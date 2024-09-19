/* SPDX-License-Identifier: GPL-2.0 */
#include <stddef.h>
#include <linux/bpf.h>
#include <linux/in.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/ipv6.h>
#include <linux/icmpv6.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include <linux/ip.h>
#include <linux/icmp.h>
#include <linux/tcp.h>
#include <linux/udp.h>
/* Defines xdp_stats_map from packet04 */
#include "xdp_stats_kern_user.h"
#include "xdp_stats_kern.h"



enum count{
	V_LAN=0,
	IPV4,
	ICMP,
	TCP,
	UDP,
	
	
};


/* Header cursor to keep track of current parsing position */
struct hdr_cursor {
	void *pos;
};

struct vlan_hdr {
	__be16	h_vlan_TCI;
	__be16	h_vlan_encapsulated_proto;
};


#ifndef VLAN_MAX_DEPTH
#define VLAN_MAX_DEPTH 2
#endif

#define VLAN_VID_MASK		0x0fff /* VLAN Identifier */

/* Struct for collecting VLANs after parsing via parse_ethhdr_vlan */
struct collect_vlans {
	__u16 id[VLAN_MAX_DEPTH];
};



		/* Keeps stats per (enum) xdp_action */
// struct bpf_map_def SEC("maps") xdp_stats_map = {
// 	.type        = BPF_MAP_TYPE_ARRAY,
// 	.key_size    = sizeof(__u32),
// 	.value_size  = sizeof(struct datarec),
// 	.max_entries = XDP_ACTION_MAX,
// };

static __always_inline int proto_is_vlan(__u16 h_proto)
{
	return !!(h_proto == bpf_htons(ETH_P_8021Q) ||
		  h_proto == bpf_htons(ETH_P_8021AD));
}

/* Packet parsing helpers.
 *
 * Each helper parses a packet header, including doing bounds checking, and
 * returns the type of its contents if successful, and -1 otherwise.
 *
 * For Ethernet and IP headers, the content type is the type of the payload
 * (h_proto for Ethernet, nexthdr for IPv6), for ICMP it is the ICMP type field.
 * All return values are in host byte order.
 */
// static __always_inline int parse_ethhdr(struct hdr_cursor *nh,
// 					void *data_end,
// 					struct ethhdr **ethhdr)
// {
// 	struct ethhdr *eth = nh->pos;
// 	int hdrsize = sizeof(*eth);

// 	/* Byte-count bounds check; check if current pointer + size of header
// 	 * is after data_end.
// 	 */
// 	// if (nh->pos + 1 > data_end)
// 	// 	return -1;

// 		if (nh->pos + hdrsize > data_end)
// 		return -1;



// 	// nh->pos += hdrsize;
// 	*ethhdr = eth;

// 	return eth->h_proto; /* sudo ip link set dev lo xdpgeneric obj xdp_pass_kern.o sec xdp-byte-order */
// }

static __always_inline int parse_ethhdr_vlan(struct hdr_cursor *nh,
					void *data_end,
					struct ethhdr **ethhdr,
					struct collect_vlans *vlans)
{
	struct ethhdr *eth = nh->pos;
	int hdrsize = sizeof(*eth);
	struct vlan_hdr *vlh;
	__u16 h_proto;
	int i;

	/* Byte-count bounds check; check if current pointer + size of header
	 * is after data_end.
	 */
	// if (nh->pos + 1 > data_end)
	// 	return -1;

		if (nh->pos + hdrsize > data_end)
		return -1;



	nh->pos += hdrsize;
	*ethhdr = eth;

	vlh = nh->pos;
	h_proto = eth->h_proto;
	/* Use loop unrolling to avoid the verifier restriction on loops;
	 * support up to VLAN_MAX_DEPTH layers of VLAN encapsulation.
	 */
	#pragma unroll
	for (i = 0; i < VLAN_MAX_DEPTH; i++) {
		if (!proto_is_vlan(h_proto))
			break;

		if (vlh + 1 > data_end)
			break;

		h_proto = vlh->h_vlan_encapsulated_proto;
		if (vlans) /* collect VLAN ids */
			vlans->id[i] =
				(bpf_ntohs(vlh->h_vlan_TCI) & VLAN_VID_MASK);

		vlh++;
	}

	nh->pos = vlh;
	return h_proto; /* network-byte-order */


	// return eth->h_proto; /* sudo ip link set dev lo xdpgeneric obj xdp_pass_kern.o sec xdp-byte-order */
}


static __always_inline int parse_iphdr(struct hdr_cursor *nh,
				       void *data_end,
				       struct iphdr **iphdr)
{
	struct iphdr *iph = nh->pos;
	int hdrsize;

	if (iph + 1 > data_end)
		return -1;

	hdrsize = iph->ihl * 4;
	/* Sanity check packet field is valid */
	if(hdrsize < sizeof(*iph))
		return -1;

	/* Variable-length IPv4 header, need to use byte-based arithmetic */
	if (nh->pos + hdrsize > data_end)
		return -1;

	nh->pos += hdrsize;
	*iphdr = iph;

	return iph->protocol;
}


static __always_inline int parse_ip6hdr(struct hdr_cursor *nh, void *data_end,
					struct ipv6hdr **ip6hdr)
{
	struct ipv6hdr *ip6h = nh->pos;

	if (ip6h + 1 > data_end)
		return -1;

	nh->pos = ip6h + 1;
	*ip6hdr = ip6h;

	return ip6h->nexthdr;
}

static __always_inline int parse_icmphdr(struct hdr_cursor *nh,
					 void *data_end,
					 struct icmphdr **icmphdr)
{
	struct icmphdr *icmph = nh->pos;

	if (icmph + 1 > data_end)
		return -1;

	nh->pos  = icmph + 1;
	*icmphdr = icmph;

	return icmph->type;
}

static __always_inline int parse_icmp6hdr(struct hdr_cursor *nh,
					  void *data_end,
					  struct icmp6hdr **icmp6hdr)
{
	struct icmp6hdr *icmp6h = nh->pos;

	if (icmp6h + 1 > data_end)
		return -1;

	nh->pos   = icmp6h + 1;
	*icmp6hdr = icmp6h;

	return icmp6h->icmp6_type;
}


static __always_inline int parse_udphdr(struct hdr_cursor *nh,
					void *data_end,
					struct udphdr **udphdr)
{
	int len;
	struct udphdr *h = nh->pos;

	if (h + 1 > data_end)
		return -1;

	nh->pos  = h + 1;
	*udphdr = h;

	len = bpf_ntohs(h->len) - sizeof(struct udphdr);
	if (len < 0)
		return -1;

	return len;
}

/*
 * parse_tcphdr: parse and return the length of the tcp header
 */
static __always_inline int parse_tcphdr(struct hdr_cursor *nh,
					void *data_end,
					struct tcphdr **tcphdr)
{
	int len;
	struct tcphdr *h = nh->pos;

	if (h + 1 > data_end)
		return -1;

	len = h->doff * 4;
	/* Sanity check packet field is valid */
	if(len < sizeof(*h))
		return -1;

	/* Variable-length TCP header, need to use byte-based arithmetic */
	if (nh->pos + len > data_end)
		return -1;

	nh->pos += len;
	*tcphdr = h;

	return len;
}


SEC("xdp_packet_parser")
int  xdp_parser_func(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct ethhdr *eth;
	struct iphdr *iph;
	struct ipv6hdr *ipv6hdr;
	struct udphdr *udphdr;
	struct tcphdr *tcphdr;
	struct icmphdr *icmphdr;
	struct icmp6hdr *icmp6hdr;
	struct collect_vlans vlans;
	struct datarec *rec;

	__u32 counts=0;
	__u64 bytes = data_end - data;
	/* Default action XDP_PASS, imply everything we couldn't parse, or that
	 * we don't want to deal with, we just pass up the stack and let the
	 * kernel deal with it.
	 */
	__u32 action = XDP_PASS; /* Default action */

        /* These keep track of the next header type and iterator pointer */
	struct hdr_cursor nh;
	int eth_type,ip_type;

	/* Start next header cursor position at data start */
	nh.pos = data;

	/* Packet parsing in steps: Get each header one at a time, aborting if
	 * parsing fails. Each helper function does sanity checking (is the
	 * header type in the packet correct?), and bounds checking.
	 */
	// eth_type = parse_ethhdr(&nh, data_end, &eth);
	// if (eth_type != bpf_htons(ETH_P_IPV6))
	// 	goto out;



	eth_type = parse_ethhdr_vlan(&nh, data_end, &eth,&vlans);
	if(eth_type<0){
		action = XDP_ABORTED;
		goto out;
	}

	if(proto_is_vlan(eth->h_proto)){
		counts = V_LAN;
		rec = bpf_map_lookup_elem(&xdp_stats_map, &counts);
        if (rec)
        {
            rec->rx_packets += 1;
            rec->rx_bytes += bytes;
        }
	}

	if (eth_type == bpf_htons(ETH_P_IP)){

		counts=IPV4;
		ip_type = parse_iphdr(&nh,data_end,&iph);
		rec=bpf_map_lookup_elem(&xdp_stats_map, &counts);
		if(rec){
			rec->rx_bytes+=bytes;
			rec->rx_packets+=1;
		}
	}
	else if (eth_type == bpf_htons(ETH_P_IPV6))
	{
		counts=IPV4;
		ip_type =parse_ip6hdr(&nh,data_end,&ipv6hdr);
		rec=bpf_map_lookup_elem(&xdp_stats_map, &counts);
		if(rec){
			rec->rx_bytes+=bytes;
			rec->rx_packets+=1;
		}
	}
	
	else{
		goto out;
	}

	if(ip_type == IPPROTO_UDP){
		if(parse_udphdr(&nh,data_end,&udphdr)<0){
			action = XDP_ABORTED;
			goto out;
		}

		counts=UDP;
		rec=bpf_map_lookup_elem(&xdp_stats_map, &counts);
		if(rec){
			rec->rx_bytes+=bytes;
			rec->rx_packets+=1;
		}
		udphdr->dest = bpf_htons(bpf_ntohs(udphdr->dest)-1);
	
	} else if(ip_type == IPPROTO_TCP){
		if(parse_tcphdr(&nh,data_end,&tcphdr)<0){
			action = XDP_ABORTED;
			goto out;
		}
		counts=TCP;
		rec=bpf_map_lookup_elem(&xdp_stats_map, &counts);
		if(rec){
			rec->rx_bytes+=bytes;
			rec->rx_packets+=1;
		}
		tcphdr->dest = bpf_htons(bpf_ntohs(tcphdr->dest) - 1);
	}

	else if(ip_type == IPPROTO_ICMP){
		if (parse_icmphdr(&nh, data_end, &icmphdr) < 0){
			action = XDP_ABORTED;
			goto out;
		}
		int seq;
		seq=bpf_ntohs(icmphdr->un.echo.sequence);
		if(seq%2==0){
			action=XDP_PASS;
			counts=ICMP;
			rec=bpf_map_lookup_elem(&xdp_stats_map, &counts);
			if(rec){
				rec->rx_bytes+=bytes;
				rec->rx_packets+=1;
			}
		}
		else{
				action = XDP_DROP;
			}
	}
	else if (ip_type == IPPROTO_ICMPV6)
	{
	if (parse_icmp6hdr(&nh, data_end, &icmp6hdr) < 0){
				action = XDP_ABORTED;
				goto out;
			}
			int seq;
			seq=bpf_ntohs(icmp6hdr->icmp6_sequence);
			if(seq%2==1){
				action=XDP_PASS;
				counts=ICMP;
				rec=bpf_map_lookup_elem(&xdp_stats_map, &counts);
				if(rec){
					rec->rx_bytes+=bytes;
					rec->rx_packets+=1;
				}
			}else{
				action = XDP_DROP;
			}

	}

	// eth_type = parse_ip6hdr(&nh, data_end, &ip6h);
	// if (eth_type != bpf_htons(ETH_P_IPV6))
	// 	goto out;



	/* Assignment additions go below here */

	// action = XDP_DROP;
out:
	return xdp_stats_record_action(ctx, action); /* read via xdp_stats */
}

char _license[] SEC("license") = "GPL";
