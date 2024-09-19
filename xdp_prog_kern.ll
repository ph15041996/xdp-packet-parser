; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.hdr_cursor = type { i8* }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.collect_vlans = type { [2 x i16] }
%struct.vlan_hdr = type { i16, i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, %union.anon }
%union.anon = type { %struct.anon }
%struct.anon = type { i32, i32 }
%struct.ipv6hdr = type { i8, [3 x i8], i16, i8, i8, %union.anon.1 }
%union.anon.1 = type { %struct.anon.2 }
%struct.anon.2 = type { %struct.in6_addr, %struct.in6_addr }
%struct.in6_addr = type { %union.anon.3 }
%union.anon.3 = type { [4 x i32] }
%struct.udphdr = type { i16, i16, i16, i16 }
%struct.tcphdr = type { i16, i16, i32, i32, i16, i16, i16, i16 }
%struct.icmphdr = type { i8, i8, i16, %union.anon.5 }
%union.anon.5 = type { i32 }
%struct.icmp6hdr = type { i8, i8, i16, %union.anon.8 }
%union.anon.8 = type { [1 x i32] }

@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0 }, section "maps", align 4, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !59
@llvm.compiler.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_parser_func to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_parser_func(%struct.xdp_md* nocapture noundef readonly %0) #0 section "xdp_packet_parser" !dbg !87 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !101, metadata !DIExpression()), !dbg !321
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !322
  %5 = load i32, i32* %4, align 4, !dbg !322, !tbaa !323
  %6 = zext i32 %5 to i64, !dbg !328
  %7 = inttoptr i64 %6 to i8*, !dbg !329
  call void @llvm.dbg.value(metadata i8* %7, metadata !102, metadata !DIExpression()), !dbg !321
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !330
  %9 = load i32, i32* %8, align 4, !dbg !330, !tbaa !331
  %10 = zext i32 %9 to i64, !dbg !332
  %11 = inttoptr i64 %10 to i8*, !dbg !333
  call void @llvm.dbg.value(metadata i8* %11, metadata !103, metadata !DIExpression()), !dbg !321
  %12 = bitcast i32* %3 to i8*, !dbg !334
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %12) #5, !dbg !334
  call void @llvm.dbg.value(metadata i32 0, metadata !303, metadata !DIExpression()), !dbg !321
  store i32 0, i32* %3, align 4, !dbg !335, !tbaa !336
  %13 = sub nsw i64 %6, %10, !dbg !337
  call void @llvm.dbg.value(metadata i64 %13, metadata !304, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32 2, metadata !305, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i8* %11, metadata !306, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !338, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i8* %7, metadata !346, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata %struct.ethhdr** undef, metadata !347, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata %struct.collect_vlans* undef, metadata !348, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i8* %11, metadata !349, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i32 14, metadata !350, metadata !DIExpression()) #5, !dbg !359
  %14 = getelementptr i8, i8* %11, i64 14, !dbg !361
  %15 = icmp ugt i8* %14, %7, !dbg !363
  br i1 %15, label %223, label %16, !dbg !364

16:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %11, metadata !349, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i8* %14, metadata !306, metadata !DIExpression()), !dbg !321
  %17 = inttoptr i64 %10 to %struct.ethhdr*, !dbg !365
  call void @llvm.dbg.value(metadata i8* %14, metadata !351, metadata !DIExpression()) #5, !dbg !359
  %18 = getelementptr inbounds i8, i8* %11, i64 12, !dbg !366
  %19 = bitcast i8* %18 to i16*, !dbg !366
  %20 = load i16, i16* %19, align 1, !dbg !366, !tbaa !367
  call void @llvm.dbg.value(metadata i16 %20, metadata !357, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i32 0, metadata !358, metadata !DIExpression()) #5, !dbg !359
  %21 = inttoptr i64 %6 to %struct.vlan_hdr*
  call void @llvm.dbg.value(metadata i64 0, metadata !358, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i16 %20, metadata !370, metadata !DIExpression()) #5, !dbg !375
  %22 = icmp eq i16 %20, 129, !dbg !381
  %23 = icmp eq i16 %20, -22392, !dbg !382
  %24 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %22) #5
  %25 = or i1 %23, %24, !dbg !382
  %26 = xor i1 %25, true, !dbg !383
  %27 = getelementptr i8, i8* %11, i64 18
  %28 = bitcast i8* %27 to %struct.vlan_hdr*
  %29 = icmp ugt %struct.vlan_hdr* %28, %21
  %30 = select i1 %26, i1 true, i1 %29, !dbg !384
  br i1 %30, label %48, label %31, !dbg !384

31:                                               ; preds = %16
  %32 = getelementptr i8, i8* %11, i64 16, !dbg !385
  %33 = bitcast i8* %32 to i16*, !dbg !385
  %34 = load i16, i16* %33, align 2, !dbg !385, !tbaa !386
  call void @llvm.dbg.value(metadata i16 %34, metadata !357, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i16 undef, metadata !289, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 16)), !dbg !321
  call void @llvm.dbg.value(metadata i64 1, metadata !358, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata %struct.vlan_hdr* %28, metadata !351, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i16 %34, metadata !370, metadata !DIExpression()) #5, !dbg !375
  %35 = icmp eq i16 %34, 129, !dbg !381
  %36 = icmp eq i16 %34, -22392, !dbg !382
  %37 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %35) #5
  %38 = or i1 %36, %37, !dbg !382
  %39 = xor i1 %38, true, !dbg !383
  %40 = getelementptr i8, i8* %11, i64 22
  %41 = bitcast i8* %40 to %struct.vlan_hdr*
  %42 = icmp ugt %struct.vlan_hdr* %41, %21
  %43 = select i1 %39, i1 true, i1 %42, !dbg !384
  br i1 %43, label %48, label %44, !dbg !384

44:                                               ; preds = %31
  %45 = getelementptr i8, i8* %11, i64 20, !dbg !385
  %46 = bitcast i8* %45 to i16*, !dbg !385
  %47 = load i16, i16* %46, align 2, !dbg !385, !tbaa !386
  call void @llvm.dbg.value(metadata i16 %47, metadata !357, metadata !DIExpression()) #5, !dbg !359
  call void @llvm.dbg.value(metadata i16 undef, metadata !289, metadata !DIExpression(DW_OP_LLVM_fragment, 16, 16)), !dbg !321
  br label %48, !dbg !388

48:                                               ; preds = %16, %31, %44
  %49 = phi i8* [ %14, %16 ], [ %27, %31 ], [ %40, %44 ], !dbg !359
  %50 = phi i16 [ %20, %16 ], [ %34, %31 ], [ %47, %44 ], !dbg !359
  call void @llvm.dbg.value(metadata i8* %49, metadata !306, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i16 %50, metadata !310, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !321
  call void @llvm.dbg.value(metadata %struct.ethhdr* %17, metadata !104, metadata !DIExpression()), !dbg !321
  %51 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %17, i64 0, i32 2, !dbg !390
  %52 = load i16, i16* %51, align 1, !dbg !390, !tbaa !367
  call void @llvm.dbg.value(metadata i16 %52, metadata !370, metadata !DIExpression()) #5, !dbg !392
  %53 = icmp eq i16 %52, 129, !dbg !394
  %54 = icmp eq i16 %52, -22392, !dbg !395
  %55 = tail call i1 @llvm.bpf.passthrough.i1.i1(i32 0, i1 %53) #5
  %56 = or i1 %54, %55, !dbg !395
  br i1 %56, label %57, label %68, !dbg !396

57:                                               ; preds = %48
  call void @llvm.dbg.value(metadata i32 0, metadata !303, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32* %3, metadata !303, metadata !DIExpression(DW_OP_deref)), !dbg !321
  %58 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* noundef nonnull %12) #5, !dbg !397
  call void @llvm.dbg.value(metadata i8* %58, metadata !294, metadata !DIExpression()), !dbg !321
  %59 = icmp eq i8* %58, null, !dbg !399
  br i1 %59, label %68, label %60, !dbg !401

60:                                               ; preds = %57
  call void @llvm.dbg.value(metadata i8* %58, metadata !294, metadata !DIExpression()), !dbg !321
  %61 = bitcast i8* %58 to i64*, !dbg !402
  %62 = load i64, i64* %61, align 8, !dbg !404, !tbaa !405
  %63 = add i64 %62, 1, !dbg !404
  store i64 %63, i64* %61, align 8, !dbg !404, !tbaa !405
  %64 = getelementptr inbounds i8, i8* %58, i64 8, !dbg !408
  %65 = bitcast i8* %64 to i64*, !dbg !408
  %66 = load i64, i64* %65, align 8, !dbg !409, !tbaa !410
  %67 = add i64 %66, %13, !dbg !409
  store i64 %67, i64* %65, align 8, !dbg !409, !tbaa !410
  br label %68, !dbg !411

68:                                               ; preds = %57, %60, %48
  switch i16 %50, label %223 [
    i16 8, label %69
    i16 -8826, label %90
  ], !dbg !412

69:                                               ; preds = %68
  call void @llvm.dbg.value(metadata i32 1, metadata !303, metadata !DIExpression()), !dbg !321
  store i32 1, i32* %3, align 4, !dbg !413, !tbaa !336
  call void @llvm.dbg.value(metadata %struct.iphdr** undef, metadata !118, metadata !DIExpression(DW_OP_deref)), !dbg !321
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !416, metadata !DIExpression()), !dbg !426
  call void @llvm.dbg.value(metadata i8* %7, metadata !422, metadata !DIExpression()), !dbg !426
  call void @llvm.dbg.value(metadata %struct.iphdr** undef, metadata !423, metadata !DIExpression()), !dbg !426
  call void @llvm.dbg.value(metadata i8* %49, metadata !424, metadata !DIExpression()), !dbg !426
  %70 = getelementptr inbounds i8, i8* %49, i64 20, !dbg !428
  %71 = icmp ugt i8* %70, %7, !dbg !430
  br i1 %71, label %85, label %72, !dbg !431

72:                                               ; preds = %69
  %73 = load i8, i8* %49, align 4, !dbg !432
  %74 = shl i8 %73, 2, !dbg !433
  %75 = and i8 %74, 60, !dbg !433
  call void @llvm.dbg.value(metadata i8 %75, metadata !425, metadata !DIExpression(DW_OP_LLVM_convert, 8, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !426
  %76 = icmp ult i8 %75, 20, !dbg !434
  br i1 %76, label %85, label %77, !dbg !436

77:                                               ; preds = %72
  %78 = zext i8 %75 to i64
  call void @llvm.dbg.value(metadata i64 %78, metadata !425, metadata !DIExpression()), !dbg !426
  %79 = getelementptr i8, i8* %49, i64 %78, !dbg !437
  %80 = icmp ugt i8* %79, %7, !dbg !439
  br i1 %80, label %85, label %81, !dbg !440

81:                                               ; preds = %77
  call void @llvm.dbg.value(metadata i8* %79, metadata !306, metadata !DIExpression()), !dbg !321
  %82 = getelementptr inbounds i8, i8* %49, i64 9, !dbg !441
  %83 = load i8, i8* %82, align 1, !dbg !441, !tbaa !442
  %84 = zext i8 %83 to i32, !dbg !444
  br label %85, !dbg !445

85:                                               ; preds = %69, %72, %77, %81
  %86 = phi i8* [ %49, %69 ], [ %49, %72 ], [ %49, %77 ], [ %79, %81 ], !dbg !321
  %87 = phi i32 [ -1, %69 ], [ -1, %72 ], [ -1, %77 ], [ %84, %81 ], !dbg !426
  call void @llvm.dbg.value(metadata i8* %86, metadata !306, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32 %87, metadata !311, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32* %3, metadata !303, metadata !DIExpression(DW_OP_deref)), !dbg !321
  %88 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* noundef nonnull %12) #5, !dbg !446
  call void @llvm.dbg.value(metadata i8* %88, metadata !294, metadata !DIExpression()), !dbg !321
  %89 = icmp eq i8* %88, null, !dbg !447
  br i1 %89, label %115, label %104, !dbg !449

90:                                               ; preds = %68
  call void @llvm.dbg.value(metadata i32 1, metadata !303, metadata !DIExpression()), !dbg !321
  store i32 1, i32* %3, align 4, !dbg !450, !tbaa !336
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !453, metadata !DIExpression()), !dbg !462
  call void @llvm.dbg.value(metadata i8* %7, metadata !459, metadata !DIExpression()), !dbg !462
  call void @llvm.dbg.value(metadata %struct.ipv6hdr** undef, metadata !460, metadata !DIExpression()), !dbg !462
  call void @llvm.dbg.value(metadata i8* %49, metadata !461, metadata !DIExpression()), !dbg !462
  %91 = getelementptr inbounds i8, i8* %49, i64 40, !dbg !464
  %92 = bitcast i8* %91 to %struct.ipv6hdr*, !dbg !464
  %93 = inttoptr i64 %6 to %struct.ipv6hdr*, !dbg !466
  %94 = icmp ugt %struct.ipv6hdr* %92, %93, !dbg !467
  br i1 %94, label %99, label %95, !dbg !468

95:                                               ; preds = %90
  call void @llvm.dbg.value(metadata i8* %49, metadata !461, metadata !DIExpression()), !dbg !462
  call void @llvm.dbg.value(metadata i8* %91, metadata !306, metadata !DIExpression()), !dbg !321
  %96 = getelementptr inbounds i8, i8* %49, i64 6, !dbg !469
  %97 = load i8, i8* %96, align 2, !dbg !469, !tbaa !470
  %98 = zext i8 %97 to i32, !dbg !472
  br label %99, !dbg !473

99:                                               ; preds = %90, %95
  %100 = phi i8* [ %49, %90 ], [ %91, %95 ], !dbg !321
  %101 = phi i32 [ -1, %90 ], [ %98, %95 ], !dbg !462
  call void @llvm.dbg.value(metadata i8* %100, metadata !306, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32 %101, metadata !311, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32* %3, metadata !303, metadata !DIExpression(DW_OP_deref)), !dbg !321
  %102 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* noundef nonnull %12) #5, !dbg !474
  call void @llvm.dbg.value(metadata i8* %102, metadata !294, metadata !DIExpression()), !dbg !321
  %103 = icmp eq i8* %102, null, !dbg !475
  br i1 %103, label %115, label %104, !dbg !477

104:                                              ; preds = %99, %85
  %105 = phi i8* [ %88, %85 ], [ %102, %99 ]
  %106 = phi i8* [ %86, %85 ], [ %100, %99 ]
  %107 = phi i32 [ %87, %85 ], [ %101, %99 ]
  %108 = getelementptr inbounds i8, i8* %105, i64 8, !dbg !478
  %109 = bitcast i8* %108 to i64*, !dbg !478
  %110 = load i64, i64* %109, align 8, !dbg !478, !tbaa !410
  %111 = add i64 %110, %13, !dbg !478
  store i64 %111, i64* %109, align 8, !dbg !478, !tbaa !410
  %112 = bitcast i8* %105 to i64*, !dbg !478
  %113 = load i64, i64* %112, align 8, !dbg !478, !tbaa !405
  %114 = add i64 %113, 1, !dbg !478
  store i64 %114, i64* %112, align 8, !dbg !478, !tbaa !405
  br label %115, !dbg !479

115:                                              ; preds = %104, %99, %85
  %116 = phi i8* [ %100, %99 ], [ %86, %85 ], [ %106, %104 ], !dbg !480
  %117 = phi i32 [ %101, %99 ], [ %87, %85 ], [ %107, %104 ], !dbg !478
  call void @llvm.dbg.value(metadata i8* %116, metadata !306, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32 %117, metadata !311, metadata !DIExpression()), !dbg !321
  switch i32 %117, label %223 [
    i32 17, label %118
    i32 6, label %147
    i32 1, label %179
    i32 58, label %201
  ], !dbg !479

118:                                              ; preds = %115
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !481, metadata !DIExpression()) #5, !dbg !491
  call void @llvm.dbg.value(metadata i8* %7, metadata !487, metadata !DIExpression()) #5, !dbg !491
  call void @llvm.dbg.value(metadata %struct.udphdr** undef, metadata !488, metadata !DIExpression()) #5, !dbg !491
  call void @llvm.dbg.value(metadata i8* %116, metadata !490, metadata !DIExpression()) #5, !dbg !491
  %119 = getelementptr inbounds i8, i8* %116, i64 8, !dbg !495
  %120 = bitcast i8* %119 to %struct.udphdr*, !dbg !495
  %121 = inttoptr i64 %6 to %struct.udphdr*, !dbg !497
  %122 = icmp ugt %struct.udphdr* %120, %121, !dbg !498
  br i1 %122, label %223, label %123, !dbg !499

123:                                              ; preds = %118
  call void @llvm.dbg.value(metadata %struct.udphdr* %120, metadata !306, metadata !DIExpression()), !dbg !321
  %124 = getelementptr inbounds i8, i8* %116, i64 4, !dbg !500
  %125 = bitcast i8* %124 to i16*, !dbg !500
  %126 = load i16, i16* %125, align 2, !dbg !500, !tbaa !501
  %127 = call i16 @llvm.bswap.i16(i16 %126) #5
  call void @llvm.dbg.value(metadata i16 %127, metadata !489, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_constu, 8, DW_OP_minus, DW_OP_stack_value)) #5, !dbg !491
  %128 = icmp ult i16 %127, 8, !dbg !503
  br i1 %128, label %223, label %129, !dbg !505

129:                                              ; preds = %123
  call void @llvm.dbg.value(metadata i16 %127, metadata !489, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_constu, 8, DW_OP_minus, DW_OP_stack_value)) #5, !dbg !491
  call void @llvm.dbg.value(metadata i16 %127, metadata !489, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_constu, 8, DW_OP_minus, DW_OP_stack_value)) #5, !dbg !491
  call void @llvm.dbg.value(metadata i32 4, metadata !303, metadata !DIExpression()), !dbg !321
  store i32 4, i32* %3, align 4, !dbg !506, !tbaa !336
  call void @llvm.dbg.value(metadata i32* %3, metadata !303, metadata !DIExpression(DW_OP_deref)), !dbg !321
  %130 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* noundef nonnull %12) #5, !dbg !507
  call void @llvm.dbg.value(metadata i8* %130, metadata !294, metadata !DIExpression()), !dbg !321
  %131 = icmp eq i8* %130, null, !dbg !508
  br i1 %131, label %140, label %132, !dbg !510

132:                                              ; preds = %129
  call void @llvm.dbg.value(metadata i8* %130, metadata !294, metadata !DIExpression()), !dbg !321
  %133 = getelementptr inbounds i8, i8* %130, i64 8, !dbg !511
  %134 = bitcast i8* %133 to i64*, !dbg !511
  %135 = load i64, i64* %134, align 8, !dbg !513, !tbaa !410
  %136 = add i64 %135, %13, !dbg !513
  store i64 %136, i64* %134, align 8, !dbg !513, !tbaa !410
  %137 = bitcast i8* %130 to i64*, !dbg !514
  %138 = load i64, i64* %137, align 8, !dbg !515, !tbaa !405
  %139 = add i64 %138, 1, !dbg !515
  store i64 %139, i64* %137, align 8, !dbg !515, !tbaa !405
  br label %140, !dbg !516

140:                                              ; preds = %132, %129
  call void @llvm.dbg.value(metadata i8* %116, metadata !191, metadata !DIExpression()), !dbg !321
  %141 = getelementptr inbounds i8, i8* %116, i64 2, !dbg !517
  %142 = bitcast i8* %141 to i16*, !dbg !517
  %143 = load i16, i16* %142, align 2, !dbg !517, !tbaa !518
  %144 = call i16 @llvm.bswap.i16(i16 %143)
  %145 = add i16 %144, -1, !dbg !517
  %146 = call i16 @llvm.bswap.i16(i16 %145), !dbg !517
  call void @llvm.dbg.value(metadata i8* %116, metadata !191, metadata !DIExpression()), !dbg !321
  store i16 %146, i16* %142, align 2, !dbg !519, !tbaa !518
  br label %223, !dbg !520

147:                                              ; preds = %115
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !521, metadata !DIExpression()), !dbg !531
  call void @llvm.dbg.value(metadata i8* %7, metadata !527, metadata !DIExpression()), !dbg !531
  call void @llvm.dbg.value(metadata %struct.tcphdr** undef, metadata !528, metadata !DIExpression()), !dbg !531
  call void @llvm.dbg.value(metadata i8* %116, metadata !530, metadata !DIExpression()), !dbg !531
  %148 = getelementptr inbounds i8, i8* %116, i64 20, !dbg !535
  %149 = icmp ugt i8* %148, %7, !dbg !537
  br i1 %149, label %223, label %150, !dbg !538

150:                                              ; preds = %147
  %151 = getelementptr inbounds i8, i8* %116, i64 12, !dbg !539
  %152 = bitcast i8* %151 to i16*, !dbg !539
  %153 = load i16, i16* %152, align 4, !dbg !539
  %154 = lshr i16 %153, 2, !dbg !540
  %155 = and i16 %154, 60, !dbg !540
  call void @llvm.dbg.value(metadata i16 %155, metadata !529, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !531
  %156 = icmp ult i16 %155, 20, !dbg !541
  br i1 %156, label %223, label %157, !dbg !543

157:                                              ; preds = %150
  %158 = zext i16 %155 to i64
  %159 = getelementptr i8, i8* %116, i64 %158, !dbg !544
  %160 = icmp ugt i8* %159, %7, !dbg !546
  br i1 %160, label %223, label %161, !dbg !547

161:                                              ; preds = %157
  call void @llvm.dbg.value(metadata i8* %159, metadata !306, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32 3, metadata !303, metadata !DIExpression()), !dbg !321
  store i32 3, i32* %3, align 4, !dbg !548, !tbaa !336
  call void @llvm.dbg.value(metadata i32* %3, metadata !303, metadata !DIExpression(DW_OP_deref)), !dbg !321
  %162 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* noundef nonnull %12) #5, !dbg !549
  call void @llvm.dbg.value(metadata i8* %162, metadata !294, metadata !DIExpression()), !dbg !321
  %163 = icmp eq i8* %162, null, !dbg !550
  br i1 %163, label %172, label %164, !dbg !552

164:                                              ; preds = %161
  call void @llvm.dbg.value(metadata i8* %162, metadata !294, metadata !DIExpression()), !dbg !321
  %165 = getelementptr inbounds i8, i8* %162, i64 8, !dbg !553
  %166 = bitcast i8* %165 to i64*, !dbg !553
  %167 = load i64, i64* %166, align 8, !dbg !555, !tbaa !410
  %168 = add i64 %167, %13, !dbg !555
  store i64 %168, i64* %166, align 8, !dbg !555, !tbaa !410
  %169 = bitcast i8* %162 to i64*, !dbg !556
  %170 = load i64, i64* %169, align 8, !dbg !557, !tbaa !405
  %171 = add i64 %170, 1, !dbg !557
  store i64 %171, i64* %169, align 8, !dbg !557, !tbaa !405
  br label %172, !dbg !558

172:                                              ; preds = %164, %161
  call void @llvm.dbg.value(metadata i8* %116, metadata !200, metadata !DIExpression()), !dbg !321
  %173 = getelementptr inbounds i8, i8* %116, i64 2, !dbg !559
  %174 = bitcast i8* %173 to i16*, !dbg !559
  %175 = load i16, i16* %174, align 2, !dbg !559, !tbaa !560
  %176 = call i16 @llvm.bswap.i16(i16 %175)
  %177 = add i16 %176, -1, !dbg !559
  %178 = call i16 @llvm.bswap.i16(i16 %177), !dbg !559
  call void @llvm.dbg.value(metadata i8* %116, metadata !200, metadata !DIExpression()), !dbg !321
  store i16 %178, i16* %174, align 2, !dbg !562, !tbaa !560
  br label %223, !dbg !563

179:                                              ; preds = %115
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !564, metadata !DIExpression()), !dbg !573
  call void @llvm.dbg.value(metadata i8* %7, metadata !570, metadata !DIExpression()), !dbg !573
  call void @llvm.dbg.value(metadata %struct.icmphdr** undef, metadata !571, metadata !DIExpression()), !dbg !573
  call void @llvm.dbg.value(metadata i8* %116, metadata !572, metadata !DIExpression()), !dbg !573
  %180 = getelementptr inbounds i8, i8* %116, i64 8, !dbg !576
  %181 = bitcast i8* %180 to %struct.icmphdr*, !dbg !576
  %182 = inttoptr i64 %6 to %struct.icmphdr*, !dbg !578
  %183 = icmp ugt %struct.icmphdr* %181, %182, !dbg !579
  br i1 %183, label %223, label %184, !dbg !580

184:                                              ; preds = %179
  call void @llvm.dbg.value(metadata i8* %116, metadata !572, metadata !DIExpression()), !dbg !573
  call void @llvm.dbg.value(metadata %struct.icmphdr* %181, metadata !306, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i8* %116, metadata !222, metadata !DIExpression()), !dbg !321
  %185 = getelementptr inbounds i8, i8* %116, i64 6, !dbg !581
  %186 = bitcast i8* %185 to i16*, !dbg !581
  %187 = load i16, i16* %186, align 2, !dbg !581, !tbaa !582
  call void @llvm.dbg.value(metadata i16 undef, metadata !312, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !583
  %188 = and i16 %187, 256, !dbg !584
  %189 = icmp eq i16 %188, 0, !dbg !584
  br i1 %189, label %190, label %223, !dbg !586

190:                                              ; preds = %184
  call void @llvm.dbg.value(metadata i32 2, metadata !305, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32 2, metadata !303, metadata !DIExpression()), !dbg !321
  store i32 2, i32* %3, align 4, !dbg !587, !tbaa !336
  call void @llvm.dbg.value(metadata i32* %3, metadata !303, metadata !DIExpression(DW_OP_deref)), !dbg !321
  %191 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* noundef nonnull %12) #5, !dbg !589
  call void @llvm.dbg.value(metadata i8* %191, metadata !294, metadata !DIExpression()), !dbg !321
  %192 = icmp eq i8* %191, null, !dbg !590
  br i1 %192, label %223, label %193, !dbg !592

193:                                              ; preds = %190
  call void @llvm.dbg.value(metadata i8* %191, metadata !294, metadata !DIExpression()), !dbg !321
  %194 = getelementptr inbounds i8, i8* %191, i64 8, !dbg !593
  %195 = bitcast i8* %194 to i64*, !dbg !593
  %196 = load i64, i64* %195, align 8, !dbg !595, !tbaa !410
  %197 = add i64 %196, %13, !dbg !595
  store i64 %197, i64* %195, align 8, !dbg !595, !tbaa !410
  %198 = bitcast i8* %191 to i64*, !dbg !596
  %199 = load i64, i64* %198, align 8, !dbg !597, !tbaa !405
  %200 = add i64 %199, 1, !dbg !597
  store i64 %200, i64* %198, align 8, !dbg !597, !tbaa !405
  br label %223, !dbg !598

201:                                              ; preds = %115
  call void @llvm.dbg.value(metadata %struct.hdr_cursor* undef, metadata !599, metadata !DIExpression()), !dbg !608
  call void @llvm.dbg.value(metadata i8* %7, metadata !605, metadata !DIExpression()), !dbg !608
  call void @llvm.dbg.value(metadata %struct.icmp6hdr** undef, metadata !606, metadata !DIExpression()), !dbg !608
  call void @llvm.dbg.value(metadata i8* %116, metadata !607, metadata !DIExpression()), !dbg !608
  %202 = getelementptr inbounds i8, i8* %116, i64 8, !dbg !611
  %203 = bitcast i8* %202 to %struct.icmp6hdr*, !dbg !611
  %204 = inttoptr i64 %6 to %struct.icmp6hdr*, !dbg !613
  %205 = icmp ugt %struct.icmp6hdr* %203, %204, !dbg !614
  br i1 %205, label %223, label %206, !dbg !615

206:                                              ; preds = %201
  call void @llvm.dbg.value(metadata i8* %116, metadata !607, metadata !DIExpression()), !dbg !608
  call void @llvm.dbg.value(metadata %struct.icmp6hdr* %203, metadata !306, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i8* %116, metadata !246, metadata !DIExpression()), !dbg !321
  %207 = getelementptr inbounds i8, i8* %116, i64 6, !dbg !616
  %208 = bitcast i8* %207 to i16*, !dbg !616
  %209 = load i16, i16* %208, align 2, !dbg !616, !tbaa !582
  call void @llvm.dbg.value(metadata i16 undef, metadata !317, metadata !DIExpression(DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !617
  %210 = and i16 %209, 256, !dbg !618
  %211 = icmp eq i16 %210, 0, !dbg !618
  br i1 %211, label %223, label %212, !dbg !620

212:                                              ; preds = %206
  call void @llvm.dbg.value(metadata i32 2, metadata !305, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.value(metadata i32 2, metadata !303, metadata !DIExpression()), !dbg !321
  store i32 2, i32* %3, align 4, !dbg !621, !tbaa !336
  call void @llvm.dbg.value(metadata i32* %3, metadata !303, metadata !DIExpression(DW_OP_deref)), !dbg !321
  %213 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* noundef nonnull %12) #5, !dbg !623
  call void @llvm.dbg.value(metadata i8* %213, metadata !294, metadata !DIExpression()), !dbg !321
  %214 = icmp eq i8* %213, null, !dbg !624
  br i1 %214, label %223, label %215, !dbg !626

215:                                              ; preds = %212
  call void @llvm.dbg.value(metadata i8* %213, metadata !294, metadata !DIExpression()), !dbg !321
  %216 = getelementptr inbounds i8, i8* %213, i64 8, !dbg !627
  %217 = bitcast i8* %216 to i64*, !dbg !627
  %218 = load i64, i64* %217, align 8, !dbg !629, !tbaa !410
  %219 = add i64 %218, %13, !dbg !629
  store i64 %219, i64* %217, align 8, !dbg !629, !tbaa !410
  %220 = bitcast i8* %213 to i64*, !dbg !630
  %221 = load i64, i64* %220, align 8, !dbg !631, !tbaa !405
  %222 = add i64 %221, 1, !dbg !631
  store i64 %222, i64* %220, align 8, !dbg !631, !tbaa !405
  br label %223, !dbg !632

223:                                              ; preds = %201, %179, %157, %150, %147, %123, %118, %1, %215, %212, %206, %115, %193, %190, %184, %68, %140, %172
  %224 = phi i32 [ 2, %140 ], [ 2, %172 ], [ 2, %68 ], [ 2, %193 ], [ 2, %190 ], [ 1, %184 ], [ 2, %115 ], [ 2, %215 ], [ 2, %212 ], [ 1, %206 ], [ 0, %1 ], [ 0, %118 ], [ 0, %123 ], [ 0, %147 ], [ 0, %150 ], [ 0, %157 ], [ 0, %179 ], [ 0, %201 ], !dbg !321
  call void @llvm.dbg.value(metadata i32 %224, metadata !305, metadata !DIExpression()), !dbg !321
  call void @llvm.dbg.label(metadata !320), !dbg !633
  %225 = bitcast i32* %2 to i8*, !dbg !634
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %225), !dbg !634
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !639, metadata !DIExpression()) #5, !dbg !634
  call void @llvm.dbg.value(metadata i32 %224, metadata !640, metadata !DIExpression()) #5, !dbg !634
  store i32 %224, i32* %2, align 4, !tbaa !336
  call void @llvm.dbg.value(metadata i32* %2, metadata !640, metadata !DIExpression(DW_OP_deref)) #5, !dbg !634
  %226 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* noundef nonnull %225) #5, !dbg !643
  call void @llvm.dbg.value(metadata i8* %226, metadata !641, metadata !DIExpression()) #5, !dbg !634
  %227 = icmp eq i8* %226, null, !dbg !644
  br i1 %227, label %241, label %228, !dbg !646

228:                                              ; preds = %223
  call void @llvm.dbg.value(metadata i8* %226, metadata !641, metadata !DIExpression()) #5, !dbg !634
  %229 = bitcast i8* %226 to i64*, !dbg !647
  %230 = load i64, i64* %229, align 8, !dbg !648, !tbaa !405
  %231 = add i64 %230, 1, !dbg !648
  store i64 %231, i64* %229, align 8, !dbg !648, !tbaa !405
  %232 = load i32, i32* %4, align 4, !dbg !649, !tbaa !323
  %233 = load i32, i32* %8, align 4, !dbg !650, !tbaa !331
  %234 = sub i32 %232, %233, !dbg !651
  %235 = zext i32 %234 to i64, !dbg !652
  %236 = getelementptr inbounds i8, i8* %226, i64 8, !dbg !653
  %237 = bitcast i8* %236 to i64*, !dbg !653
  %238 = load i64, i64* %237, align 8, !dbg !654, !tbaa !410
  %239 = add i64 %238, %235, !dbg !654
  store i64 %239, i64* %237, align 8, !dbg !654, !tbaa !410
  %240 = load i32, i32* %2, align 4, !dbg !655, !tbaa !336
  call void @llvm.dbg.value(metadata i32 %240, metadata !640, metadata !DIExpression()) #5, !dbg !634
  br label %241, !dbg !656

241:                                              ; preds = %223, %228
  %242 = phi i32 [ %240, %228 ], [ 0, %223 ], !dbg !634
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %225), !dbg !657
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %12) #5, !dbg !658
  ret i32 %242, !dbg !659
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #2

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

; Function Attrs: nounwind readnone
declare i1 @llvm.bpf.passthrough.i1.i1(i32, i1) #4

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #2 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { nounwind readnone }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!82, !83, !84, !85}
!llvm.ident = !{!86}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !73, line: 16, type: !74, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1.1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !52, globals: !58, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/ubuntu/xdp-tutorial/packet01-parsing", checksumkind: CSK_MD5, checksum: "da860faf0d5013ecd297624339b141a7")
!4 = !{!5, !14, !21}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/ubuntu/xdp-tutorial/packet01-parsing", checksumkind: CSK_MD5, checksum: "db1ce4e5e29770657167bc8f57af9388")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "count", file: !3, line: 21, baseType: !7, size: 32, elements: !15)
!15 = !{!16, !17, !18, !19, !20}
!16 = !DIEnumerator(name: "V_LAN", value: 0)
!17 = !DIEnumerator(name: "IPV4", value: 1)
!18 = !DIEnumerator(name: "ICMP", value: 2)
!19 = !DIEnumerator(name: "TCP", value: 3)
!20 = !DIEnumerator(name: "UDP", value: 4)
!21 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !22, line: 28, baseType: !7, size: 32, elements: !23)
!22 = !DIFile(filename: "/usr/include/linux/in.h", directory: "", checksumkind: CSK_MD5, checksum: "078a32220dc819f6a7e2ea3cecc4e133")
!23 = !{!24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !50, !51}
!24 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!25 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!26 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!27 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!28 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!29 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!30 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!31 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!32 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!33 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!34 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!35 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!36 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!37 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!38 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!39 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!40 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!41 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!42 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!43 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!44 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!45 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!46 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!47 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!48 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143)
!49 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!50 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262)
!51 = !DIEnumerator(name: "IPPROTO_MAX", value: 263)
!52 = !{!53, !54, !55}
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!54 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!55 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !56, line: 24, baseType: !57)
!56 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!57 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!58 = !{!0, !59, !65}
!59 = !DIGlobalVariableExpression(var: !60, expr: !DIExpression())
!60 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 441, type: !61, isLocal: false, isDefinition: true)
!61 = !DICompositeType(tag: DW_TAG_array_type, baseType: !62, size: 32, elements: !63)
!62 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!63 = !{!64}
!64 = !DISubrange(count: 4)
!65 = !DIGlobalVariableExpression(var: !66, expr: !DIExpression())
!66 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !67, line: 33, type: !68, isLocal: true, isDefinition: true)
!67 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/ubuntu/xdp-tutorial/packet01-parsing", checksumkind: CSK_MD5, checksum: "2601bcf9d7985cb46bfbd904b60f5aaf")
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DISubroutineType(types: !70)
!70 = !{!53, !53, !71}
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!73 = !DIFile(filename: "./xdp_stats_kern.h", directory: "/home/ubuntu/xdp-tutorial/packet01-parsing", checksumkind: CSK_MD5, checksum: "0f65d57b07088eec24d5031993b90668")
!74 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !75, line: 33, size: 160, elements: !76)
!75 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/home/ubuntu/xdp-tutorial/packet01-parsing", checksumkind: CSK_MD5, checksum: "9e37b5f46a8fb7f5ed35ab69309bf15d")
!76 = !{!77, !78, !79, !80, !81}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !74, file: !75, line: 34, baseType: !7, size: 32)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !74, file: !75, line: 35, baseType: !7, size: 32, offset: 32)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !74, file: !75, line: 36, baseType: !7, size: 32, offset: 64)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !74, file: !75, line: 37, baseType: !7, size: 32, offset: 96)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !74, file: !75, line: 38, baseType: !7, size: 32, offset: 128)
!82 = !{i32 7, !"Dwarf Version", i32 5}
!83 = !{i32 2, !"Debug Info Version", i32 3}
!84 = !{i32 1, !"wchar_size", i32 4}
!85 = !{i32 7, !"frame-pointer", i32 2}
!86 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!87 = distinct !DISubprogram(name: "xdp_parser_func", scope: !3, file: !3, line: 278, type: !88, scopeLine: 279, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !100)
!88 = !DISubroutineType(types: !89)
!89 = !{!90, !91}
!90 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !93)
!93 = !{!94, !96, !97, !98, !99}
!94 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !92, file: !6, line: 2857, baseType: !95, size: 32)
!95 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !56, line: 27, baseType: !7)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !92, file: !6, line: 2858, baseType: !95, size: 32, offset: 32)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !92, file: !6, line: 2859, baseType: !95, size: 32, offset: 64)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !92, file: !6, line: 2861, baseType: !95, size: 32, offset: 96)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !92, file: !6, line: 2862, baseType: !95, size: 32, offset: 128)
!100 = !{!101, !102, !103, !104, !118, !148, !191, !200, !222, !246, !289, !294, !303, !304, !305, !306, !310, !311, !312, !317, !320}
!101 = !DILocalVariable(name: "ctx", arg: 1, scope: !87, file: !3, line: 278, type: !91)
!102 = !DILocalVariable(name: "data_end", scope: !87, file: !3, line: 280, type: !53)
!103 = !DILocalVariable(name: "data", scope: !87, file: !3, line: 281, type: !53)
!104 = !DILocalVariable(name: "eth", scope: !87, file: !3, line: 282, type: !105)
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!106 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !107, line: 168, size: 112, elements: !108)
!107 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!108 = !{!109, !114, !115}
!109 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !106, file: !107, line: 169, baseType: !110, size: 48)
!110 = !DICompositeType(tag: DW_TAG_array_type, baseType: !111, size: 48, elements: !112)
!111 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!112 = !{!113}
!113 = !DISubrange(count: 6)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !106, file: !107, line: 170, baseType: !110, size: 48, offset: 48)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !106, file: !107, line: 171, baseType: !116, size: 16, offset: 96)
!116 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !117, line: 25, baseType: !55)
!117 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!118 = !DILocalVariable(name: "iph", scope: !87, file: !3, line: 283, type: !119)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !121, line: 87, size: 160, elements: !122)
!121 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "042b09a58768855e3578a0a8eba49be7")
!122 = !{!123, !125, !126, !127, !128, !129, !130, !131, !132, !134}
!123 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !120, file: !121, line: 89, baseType: !124, size: 4, flags: DIFlagBitField, extraData: i64 0)
!124 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !56, line: 21, baseType: !111)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !120, file: !121, line: 90, baseType: !124, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!126 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !120, file: !121, line: 97, baseType: !124, size: 8, offset: 8)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !120, file: !121, line: 98, baseType: !116, size: 16, offset: 16)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !120, file: !121, line: 99, baseType: !116, size: 16, offset: 32)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !120, file: !121, line: 100, baseType: !116, size: 16, offset: 48)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !120, file: !121, line: 101, baseType: !124, size: 8, offset: 64)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !120, file: !121, line: 102, baseType: !124, size: 8, offset: 72)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !120, file: !121, line: 103, baseType: !133, size: 16, offset: 80)
!133 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !117, line: 31, baseType: !55)
!134 = !DIDerivedType(tag: DW_TAG_member, scope: !120, file: !121, line: 104, baseType: !135, size: 64, offset: 96)
!135 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !120, file: !121, line: 104, size: 64, elements: !136)
!136 = !{!137, !143}
!137 = !DIDerivedType(tag: DW_TAG_member, scope: !135, file: !121, line: 104, baseType: !138, size: 64)
!138 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !135, file: !121, line: 104, size: 64, elements: !139)
!139 = !{!140, !142}
!140 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !138, file: !121, line: 104, baseType: !141, size: 32)
!141 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !117, line: 27, baseType: !95)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !138, file: !121, line: 104, baseType: !141, size: 32, offset: 32)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !135, file: !121, line: 104, baseType: !144, size: 64)
!144 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !135, file: !121, line: 104, size: 64, elements: !145)
!145 = !{!146, !147}
!146 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !144, file: !121, line: 104, baseType: !141, size: 32)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !144, file: !121, line: 104, baseType: !141, size: 32, offset: 32)
!148 = !DILocalVariable(name: "ipv6hdr", scope: !87, file: !3, line: 284, type: !149)
!149 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !150, size: 64)
!150 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ipv6hdr", file: !151, line: 118, size: 320, elements: !152)
!151 = !DIFile(filename: "/usr/include/linux/ipv6.h", directory: "", checksumkind: CSK_MD5, checksum: "9926d49458ea1e0cc4651362e733e03e")
!152 = !{!153, !154, !155, !159, !160, !161, !162}
!153 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !150, file: !151, line: 120, baseType: !124, size: 4, flags: DIFlagBitField, extraData: i64 0)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !150, file: !151, line: 121, baseType: !124, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "flow_lbl", scope: !150, file: !151, line: 128, baseType: !156, size: 24, offset: 8)
!156 = !DICompositeType(tag: DW_TAG_array_type, baseType: !124, size: 24, elements: !157)
!157 = !{!158}
!158 = !DISubrange(count: 3)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "payload_len", scope: !150, file: !151, line: 130, baseType: !116, size: 16, offset: 32)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "nexthdr", scope: !150, file: !151, line: 131, baseType: !124, size: 8, offset: 48)
!161 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !150, file: !151, line: 132, baseType: !124, size: 8, offset: 56)
!162 = !DIDerivedType(tag: DW_TAG_member, scope: !150, file: !151, line: 134, baseType: !163, size: 256, offset: 64)
!163 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !150, file: !151, line: 134, size: 256, elements: !164)
!164 = !{!165, !186}
!165 = !DIDerivedType(tag: DW_TAG_member, scope: !163, file: !151, line: 134, baseType: !166, size: 256)
!166 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !163, file: !151, line: 134, size: 256, elements: !167)
!167 = !{!168, !185}
!168 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !166, file: !151, line: 134, baseType: !169, size: 128)
!169 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in6_addr", file: !170, line: 33, size: 128, elements: !171)
!170 = !DIFile(filename: "/usr/include/linux/in6.h", directory: "", checksumkind: CSK_MD5, checksum: "8bebb780b45d3fe932cc1d934fa5f5fe")
!171 = !{!172}
!172 = !DIDerivedType(tag: DW_TAG_member, name: "in6_u", scope: !169, file: !170, line: 40, baseType: !173, size: 128)
!173 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !169, file: !170, line: 34, size: 128, elements: !174)
!174 = !{!175, !179, !183}
!175 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr8", scope: !173, file: !170, line: 35, baseType: !176, size: 128)
!176 = !DICompositeType(tag: DW_TAG_array_type, baseType: !124, size: 128, elements: !177)
!177 = !{!178}
!178 = !DISubrange(count: 16)
!179 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr16", scope: !173, file: !170, line: 37, baseType: !180, size: 128)
!180 = !DICompositeType(tag: DW_TAG_array_type, baseType: !116, size: 128, elements: !181)
!181 = !{!182}
!182 = !DISubrange(count: 8)
!183 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr32", scope: !173, file: !170, line: 38, baseType: !184, size: 128)
!184 = !DICompositeType(tag: DW_TAG_array_type, baseType: !141, size: 128, elements: !63)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !166, file: !151, line: 134, baseType: !169, size: 128, offset: 128)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !163, file: !151, line: 134, baseType: !187, size: 256)
!187 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !163, file: !151, line: 134, size: 256, elements: !188)
!188 = !{!189, !190}
!189 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !187, file: !151, line: 134, baseType: !169, size: 128)
!190 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !187, file: !151, line: 134, baseType: !169, size: 128, offset: 128)
!191 = !DILocalVariable(name: "udphdr", scope: !87, file: !3, line: 285, type: !192)
!192 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !193, size: 64)
!193 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !194, line: 23, size: 64, elements: !195)
!194 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "", checksumkind: CSK_MD5, checksum: "53c0d42e1bf6d93b39151764be2d20fb")
!195 = !{!196, !197, !198, !199}
!196 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !193, file: !194, line: 24, baseType: !116, size: 16)
!197 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !193, file: !194, line: 25, baseType: !116, size: 16, offset: 16)
!198 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !193, file: !194, line: 26, baseType: !116, size: 16, offset: 32)
!199 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !193, file: !194, line: 27, baseType: !133, size: 16, offset: 48)
!200 = !DILocalVariable(name: "tcphdr", scope: !87, file: !3, line: 286, type: !201)
!201 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !202, size: 64)
!202 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !203, line: 25, size: 160, elements: !204)
!203 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "", checksumkind: CSK_MD5, checksum: "8d74bf2133e7b3dab885994b9916aa13")
!204 = !{!205, !206, !207, !208, !209, !210, !211, !212, !213, !214, !215, !216, !217, !218, !219, !220, !221}
!205 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !202, file: !203, line: 26, baseType: !116, size: 16)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !202, file: !203, line: 27, baseType: !116, size: 16, offset: 16)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !202, file: !203, line: 28, baseType: !141, size: 32, offset: 32)
!208 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !202, file: !203, line: 29, baseType: !141, size: 32, offset: 64)
!209 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !202, file: !203, line: 31, baseType: !55, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!210 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !202, file: !203, line: 32, baseType: !55, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !202, file: !203, line: 33, baseType: !55, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !202, file: !203, line: 34, baseType: !55, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!213 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !202, file: !203, line: 35, baseType: !55, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !202, file: !203, line: 36, baseType: !55, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!215 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !202, file: !203, line: 37, baseType: !55, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!216 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !202, file: !203, line: 38, baseType: !55, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!217 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !202, file: !203, line: 39, baseType: !55, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!218 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !202, file: !203, line: 40, baseType: !55, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!219 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !202, file: !203, line: 55, baseType: !116, size: 16, offset: 112)
!220 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !202, file: !203, line: 56, baseType: !133, size: 16, offset: 128)
!221 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !202, file: !203, line: 57, baseType: !116, size: 16, offset: 144)
!222 = !DILocalVariable(name: "icmphdr", scope: !87, file: !3, line: 287, type: !223)
!223 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !224, size: 64)
!224 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmphdr", file: !225, line: 89, size: 64, elements: !226)
!225 = !DIFile(filename: "/usr/include/linux/icmp.h", directory: "", checksumkind: CSK_MD5, checksum: "a505632898dce546638b3344627d334b")
!226 = !{!227, !228, !229, !230}
!227 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !224, file: !225, line: 90, baseType: !124, size: 8)
!228 = !DIDerivedType(tag: DW_TAG_member, name: "code", scope: !224, file: !225, line: 91, baseType: !124, size: 8, offset: 8)
!229 = !DIDerivedType(tag: DW_TAG_member, name: "checksum", scope: !224, file: !225, line: 92, baseType: !133, size: 16, offset: 16)
!230 = !DIDerivedType(tag: DW_TAG_member, name: "un", scope: !224, file: !225, line: 104, baseType: !231, size: 32, offset: 32)
!231 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !224, file: !225, line: 93, size: 32, elements: !232)
!232 = !{!233, !238, !239, !244}
!233 = !DIDerivedType(tag: DW_TAG_member, name: "echo", scope: !231, file: !225, line: 97, baseType: !234, size: 32)
!234 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !231, file: !225, line: 94, size: 32, elements: !235)
!235 = !{!236, !237}
!236 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !234, file: !225, line: 95, baseType: !116, size: 16)
!237 = !DIDerivedType(tag: DW_TAG_member, name: "sequence", scope: !234, file: !225, line: 96, baseType: !116, size: 16, offset: 16)
!238 = !DIDerivedType(tag: DW_TAG_member, name: "gateway", scope: !231, file: !225, line: 98, baseType: !141, size: 32)
!239 = !DIDerivedType(tag: DW_TAG_member, name: "frag", scope: !231, file: !225, line: 102, baseType: !240, size: 32)
!240 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !231, file: !225, line: 99, size: 32, elements: !241)
!241 = !{!242, !243}
!242 = !DIDerivedType(tag: DW_TAG_member, name: "__unused", scope: !240, file: !225, line: 100, baseType: !116, size: 16)
!243 = !DIDerivedType(tag: DW_TAG_member, name: "mtu", scope: !240, file: !225, line: 101, baseType: !116, size: 16, offset: 16)
!244 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", scope: !231, file: !225, line: 103, baseType: !245, size: 32)
!245 = !DICompositeType(tag: DW_TAG_array_type, baseType: !124, size: 32, elements: !63)
!246 = !DILocalVariable(name: "icmp6hdr", scope: !87, file: !3, line: 288, type: !247)
!247 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !248, size: 64)
!248 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmp6hdr", file: !249, line: 8, size: 64, elements: !250)
!249 = !DIFile(filename: "/usr/include/linux/icmpv6.h", directory: "", checksumkind: CSK_MD5, checksum: "0310ca5584e6f44f6eea6cf040ee84b9")
!250 = !{!251, !252, !253, !254}
!251 = !DIDerivedType(tag: DW_TAG_member, name: "icmp6_type", scope: !248, file: !249, line: 10, baseType: !124, size: 8)
!252 = !DIDerivedType(tag: DW_TAG_member, name: "icmp6_code", scope: !248, file: !249, line: 11, baseType: !124, size: 8, offset: 8)
!253 = !DIDerivedType(tag: DW_TAG_member, name: "icmp6_cksum", scope: !248, file: !249, line: 12, baseType: !133, size: 16, offset: 16)
!254 = !DIDerivedType(tag: DW_TAG_member, name: "icmp6_dataun", scope: !248, file: !249, line: 63, baseType: !255, size: 32, offset: 32)
!255 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !248, file: !249, line: 15, size: 32, elements: !256)
!256 = !{!257, !261, !265, !266, !271, !279}
!257 = !DIDerivedType(tag: DW_TAG_member, name: "un_data32", scope: !255, file: !249, line: 16, baseType: !258, size: 32)
!258 = !DICompositeType(tag: DW_TAG_array_type, baseType: !141, size: 32, elements: !259)
!259 = !{!260}
!260 = !DISubrange(count: 1)
!261 = !DIDerivedType(tag: DW_TAG_member, name: "un_data16", scope: !255, file: !249, line: 17, baseType: !262, size: 32)
!262 = !DICompositeType(tag: DW_TAG_array_type, baseType: !116, size: 32, elements: !263)
!263 = !{!264}
!264 = !DISubrange(count: 2)
!265 = !DIDerivedType(tag: DW_TAG_member, name: "un_data8", scope: !255, file: !249, line: 18, baseType: !245, size: 32)
!266 = !DIDerivedType(tag: DW_TAG_member, name: "u_echo", scope: !255, file: !249, line: 23, baseType: !267, size: 32)
!267 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmpv6_echo", file: !249, line: 20, size: 32, elements: !268)
!268 = !{!269, !270}
!269 = !DIDerivedType(tag: DW_TAG_member, name: "identifier", scope: !267, file: !249, line: 21, baseType: !116, size: 16)
!270 = !DIDerivedType(tag: DW_TAG_member, name: "sequence", scope: !267, file: !249, line: 22, baseType: !116, size: 16, offset: 16)
!271 = !DIDerivedType(tag: DW_TAG_member, name: "u_nd_advt", scope: !255, file: !249, line: 40, baseType: !272, size: 32)
!272 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmpv6_nd_advt", file: !249, line: 25, size: 32, elements: !273)
!273 = !{!274, !275, !276, !277, !278}
!274 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", scope: !272, file: !249, line: 27, baseType: !95, size: 5, flags: DIFlagBitField, extraData: i64 0)
!275 = !DIDerivedType(tag: DW_TAG_member, name: "override", scope: !272, file: !249, line: 28, baseType: !95, size: 1, offset: 5, flags: DIFlagBitField, extraData: i64 0)
!276 = !DIDerivedType(tag: DW_TAG_member, name: "solicited", scope: !272, file: !249, line: 29, baseType: !95, size: 1, offset: 6, flags: DIFlagBitField, extraData: i64 0)
!277 = !DIDerivedType(tag: DW_TAG_member, name: "router", scope: !272, file: !249, line: 30, baseType: !95, size: 1, offset: 7, flags: DIFlagBitField, extraData: i64 0)
!278 = !DIDerivedType(tag: DW_TAG_member, name: "reserved2", scope: !272, file: !249, line: 31, baseType: !95, size: 24, offset: 8, flags: DIFlagBitField, extraData: i64 0)
!279 = !DIDerivedType(tag: DW_TAG_member, name: "u_nd_ra", scope: !255, file: !249, line: 61, baseType: !280, size: 32)
!280 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "icmpv6_nd_ra", file: !249, line: 42, size: 32, elements: !281)
!281 = !{!282, !283, !284, !285, !286, !287, !288}
!282 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !280, file: !249, line: 43, baseType: !124, size: 8)
!283 = !DIDerivedType(tag: DW_TAG_member, name: "reserved", scope: !280, file: !249, line: 45, baseType: !124, size: 3, offset: 8, flags: DIFlagBitField, extraData: i64 8)
!284 = !DIDerivedType(tag: DW_TAG_member, name: "router_pref", scope: !280, file: !249, line: 46, baseType: !124, size: 2, offset: 11, flags: DIFlagBitField, extraData: i64 8)
!285 = !DIDerivedType(tag: DW_TAG_member, name: "home_agent", scope: !280, file: !249, line: 47, baseType: !124, size: 1, offset: 13, flags: DIFlagBitField, extraData: i64 8)
!286 = !DIDerivedType(tag: DW_TAG_member, name: "other", scope: !280, file: !249, line: 48, baseType: !124, size: 1, offset: 14, flags: DIFlagBitField, extraData: i64 8)
!287 = !DIDerivedType(tag: DW_TAG_member, name: "managed", scope: !280, file: !249, line: 49, baseType: !124, size: 1, offset: 15, flags: DIFlagBitField, extraData: i64 8)
!288 = !DIDerivedType(tag: DW_TAG_member, name: "rt_lifetime", scope: !280, file: !249, line: 60, baseType: !116, size: 16, offset: 16)
!289 = !DILocalVariable(name: "vlans", scope: !87, file: !3, line: 289, type: !290)
!290 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "collect_vlans", file: !3, line: 50, size: 32, elements: !291)
!291 = !{!292}
!292 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !290, file: !3, line: 51, baseType: !293, size: 32)
!293 = !DICompositeType(tag: DW_TAG_array_type, baseType: !55, size: 32, elements: !263)
!294 = !DILocalVariable(name: "rec", scope: !87, file: !3, line: 290, type: !295)
!295 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !296, size: 64)
!296 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !297, line: 10, size: 128, elements: !298)
!297 = !DIFile(filename: "./xdp_stats_kern_user.h", directory: "/home/ubuntu/xdp-tutorial/packet01-parsing", checksumkind: CSK_MD5, checksum: "96c2435685fa7da2d24f219444d8659d")
!298 = !{!299, !302}
!299 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !296, file: !297, line: 11, baseType: !300, size: 64)
!300 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !56, line: 31, baseType: !301)
!301 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!302 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !296, file: !297, line: 12, baseType: !300, size: 64, offset: 64)
!303 = !DILocalVariable(name: "counts", scope: !87, file: !3, line: 292, type: !95)
!304 = !DILocalVariable(name: "bytes", scope: !87, file: !3, line: 293, type: !300)
!305 = !DILocalVariable(name: "action", scope: !87, file: !3, line: 298, type: !95)
!306 = !DILocalVariable(name: "nh", scope: !87, file: !3, line: 301, type: !307)
!307 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "hdr_cursor", file: !3, line: 33, size: 64, elements: !308)
!308 = !{!309}
!309 = !DIDerivedType(tag: DW_TAG_member, name: "pos", scope: !307, file: !3, line: 34, baseType: !53, size: 64)
!310 = !DILocalVariable(name: "eth_type", scope: !87, file: !3, line: 302, type: !90)
!311 = !DILocalVariable(name: "ip_type", scope: !87, file: !3, line: 302, type: !90)
!312 = !DILocalVariable(name: "seq", scope: !313, file: !3, line: 391, type: !90)
!313 = distinct !DILexicalBlock(scope: !314, file: !3, line: 386, column: 34)
!314 = distinct !DILexicalBlock(scope: !315, file: !3, line: 386, column: 10)
!315 = distinct !DILexicalBlock(scope: !316, file: !3, line: 372, column: 12)
!316 = distinct !DILexicalBlock(scope: !87, file: !3, line: 358, column: 5)
!317 = !DILocalVariable(name: "seq", scope: !318, file: !3, line: 412, type: !90)
!318 = distinct !DILexicalBlock(scope: !319, file: !3, line: 407, column: 2)
!319 = distinct !DILexicalBlock(scope: !314, file: !3, line: 406, column: 11)
!320 = !DILabel(scope: !87, name: "out", file: !3, line: 437)
!321 = !DILocation(line: 0, scope: !87)
!322 = !DILocation(line: 280, column: 38, scope: !87)
!323 = !{!324, !325, i64 4}
!324 = !{!"xdp_md", !325, i64 0, !325, i64 4, !325, i64 8, !325, i64 12, !325, i64 16}
!325 = !{!"int", !326, i64 0}
!326 = !{!"omnipotent char", !327, i64 0}
!327 = !{!"Simple C/C++ TBAA"}
!328 = !DILocation(line: 280, column: 27, scope: !87)
!329 = !DILocation(line: 280, column: 19, scope: !87)
!330 = !DILocation(line: 281, column: 34, scope: !87)
!331 = !{!324, !325, i64 0}
!332 = !DILocation(line: 281, column: 23, scope: !87)
!333 = !DILocation(line: 281, column: 15, scope: !87)
!334 = !DILocation(line: 292, column: 2, scope: !87)
!335 = !DILocation(line: 292, column: 8, scope: !87)
!336 = !{!325, !325, i64 0}
!337 = !DILocation(line: 293, column: 25, scope: !87)
!338 = !DILocalVariable(name: "nh", arg: 1, scope: !339, file: !3, line: 103, type: !342)
!339 = distinct !DISubprogram(name: "parse_ethhdr_vlan", scope: !3, file: !3, line: 103, type: !340, scopeLine: 107, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !345)
!340 = !DISubroutineType(types: !341)
!341 = !{!90, !342, !53, !343, !344}
!342 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !307, size: 64)
!343 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!344 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !290, size: 64)
!345 = !{!338, !346, !347, !348, !349, !350, !351, !357, !358}
!346 = !DILocalVariable(name: "data_end", arg: 2, scope: !339, file: !3, line: 104, type: !53)
!347 = !DILocalVariable(name: "ethhdr", arg: 3, scope: !339, file: !3, line: 105, type: !343)
!348 = !DILocalVariable(name: "vlans", arg: 4, scope: !339, file: !3, line: 106, type: !344)
!349 = !DILocalVariable(name: "eth", scope: !339, file: !3, line: 108, type: !105)
!350 = !DILocalVariable(name: "hdrsize", scope: !339, file: !3, line: 109, type: !90)
!351 = !DILocalVariable(name: "vlh", scope: !339, file: !3, line: 110, type: !352)
!352 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !353, size: 64)
!353 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !3, line: 37, size: 32, elements: !354)
!354 = !{!355, !356}
!355 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !353, file: !3, line: 38, baseType: !116, size: 16)
!356 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !353, file: !3, line: 39, baseType: !116, size: 16, offset: 16)
!357 = !DILocalVariable(name: "h_proto", scope: !339, file: !3, line: 111, type: !55)
!358 = !DILocalVariable(name: "i", scope: !339, file: !3, line: 112, type: !90)
!359 = !DILocation(line: 0, scope: !339, inlinedAt: !360)
!360 = distinct !DILocation(line: 317, column: 13, scope: !87)
!361 = !DILocation(line: 120, column: 15, scope: !362, inlinedAt: !360)
!362 = distinct !DILexicalBlock(scope: !339, file: !3, line: 120, column: 7)
!363 = !DILocation(line: 120, column: 25, scope: !362, inlinedAt: !360)
!364 = !DILocation(line: 120, column: 7, scope: !339, inlinedAt: !360)
!365 = !DILocation(line: 126, column: 10, scope: !339, inlinedAt: !360)
!366 = !DILocation(line: 129, column: 17, scope: !339, inlinedAt: !360)
!367 = !{!368, !369, i64 12}
!368 = !{!"ethhdr", !326, i64 0, !326, i64 6, !369, i64 12}
!369 = !{!"short", !326, i64 0}
!370 = !DILocalVariable(name: "h_proto", arg: 1, scope: !371, file: !3, line: 64, type: !55)
!371 = distinct !DISubprogram(name: "proto_is_vlan", scope: !3, file: !3, line: 64, type: !372, scopeLine: 65, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !374)
!372 = !DISubroutineType(types: !373)
!373 = !{!90, !55}
!374 = !{!370}
!375 = !DILocation(line: 0, scope: !371, inlinedAt: !376)
!376 = distinct !DILocation(line: 135, column: 8, scope: !377, inlinedAt: !360)
!377 = distinct !DILexicalBlock(scope: !378, file: !3, line: 135, column: 7)
!378 = distinct !DILexicalBlock(scope: !379, file: !3, line: 134, column: 39)
!379 = distinct !DILexicalBlock(scope: !380, file: !3, line: 134, column: 2)
!380 = distinct !DILexicalBlock(scope: !339, file: !3, line: 134, column: 2)
!381 = !DILocation(line: 66, column: 20, scope: !371, inlinedAt: !376)
!382 = !DILocation(line: 66, column: 46, scope: !371, inlinedAt: !376)
!383 = !DILocation(line: 135, column: 8, scope: !377, inlinedAt: !360)
!384 = !DILocation(line: 135, column: 7, scope: !378, inlinedAt: !360)
!385 = !DILocation(line: 141, column: 18, scope: !378, inlinedAt: !360)
!386 = !{!387, !369, i64 2}
!387 = !{!"vlan_hdr", !369, i64 0, !369, i64 2}
!388 = !DILocation(line: 143, column: 4, scope: !389, inlinedAt: !360)
!389 = distinct !DILexicalBlock(scope: !378, file: !3, line: 142, column: 7)
!390 = !DILocation(line: 323, column: 24, scope: !391)
!391 = distinct !DILexicalBlock(scope: !87, file: !3, line: 323, column: 5)
!392 = !DILocation(line: 0, scope: !371, inlinedAt: !393)
!393 = distinct !DILocation(line: 323, column: 5, scope: !391)
!394 = !DILocation(line: 66, column: 20, scope: !371, inlinedAt: !393)
!395 = !DILocation(line: 66, column: 46, scope: !371, inlinedAt: !393)
!396 = !DILocation(line: 323, column: 5, scope: !87)
!397 = !DILocation(line: 325, column: 9, scope: !398)
!398 = distinct !DILexicalBlock(scope: !391, file: !3, line: 323, column: 33)
!399 = !DILocation(line: 326, column: 13, scope: !400)
!400 = distinct !DILexicalBlock(scope: !398, file: !3, line: 326, column: 13)
!401 = !DILocation(line: 326, column: 13, scope: !398)
!402 = !DILocation(line: 328, column: 18, scope: !403)
!403 = distinct !DILexicalBlock(scope: !400, file: !3, line: 327, column: 9)
!404 = !DILocation(line: 328, column: 29, scope: !403)
!405 = !{!406, !407, i64 0}
!406 = !{!"datarec", !407, i64 0, !407, i64 8}
!407 = !{!"long long", !326, i64 0}
!408 = !DILocation(line: 329, column: 18, scope: !403)
!409 = !DILocation(line: 329, column: 27, scope: !403)
!410 = !{!406, !407, i64 8}
!411 = !DILocation(line: 330, column: 9, scope: !403)
!412 = !DILocation(line: 333, column: 6, scope: !87)
!413 = !DILocation(line: 335, column: 9, scope: !414)
!414 = distinct !DILexicalBlock(scope: !415, file: !3, line: 333, column: 38)
!415 = distinct !DILexicalBlock(scope: !87, file: !3, line: 333, column: 6)
!416 = !DILocalVariable(name: "nh", arg: 1, scope: !417, file: !3, line: 157, type: !342)
!417 = distinct !DISubprogram(name: "parse_iphdr", scope: !3, file: !3, line: 157, type: !418, scopeLine: 160, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !421)
!418 = !DISubroutineType(types: !419)
!419 = !{!90, !342, !53, !420}
!420 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!421 = !{!416, !422, !423, !424, !425}
!422 = !DILocalVariable(name: "data_end", arg: 2, scope: !417, file: !3, line: 158, type: !53)
!423 = !DILocalVariable(name: "iphdr", arg: 3, scope: !417, file: !3, line: 159, type: !420)
!424 = !DILocalVariable(name: "iph", scope: !417, file: !3, line: 161, type: !119)
!425 = !DILocalVariable(name: "hdrsize", scope: !417, file: !3, line: 162, type: !90)
!426 = !DILocation(line: 0, scope: !417, inlinedAt: !427)
!427 = distinct !DILocation(line: 336, column: 13, scope: !414)
!428 = !DILocation(line: 164, column: 10, scope: !429, inlinedAt: !427)
!429 = distinct !DILexicalBlock(scope: !417, file: !3, line: 164, column: 6)
!430 = !DILocation(line: 164, column: 14, scope: !429, inlinedAt: !427)
!431 = !DILocation(line: 164, column: 6, scope: !417, inlinedAt: !427)
!432 = !DILocation(line: 167, column: 17, scope: !417, inlinedAt: !427)
!433 = !DILocation(line: 167, column: 21, scope: !417, inlinedAt: !427)
!434 = !DILocation(line: 169, column: 13, scope: !435, inlinedAt: !427)
!435 = distinct !DILexicalBlock(scope: !417, file: !3, line: 169, column: 5)
!436 = !DILocation(line: 169, column: 5, scope: !417, inlinedAt: !427)
!437 = !DILocation(line: 173, column: 14, scope: !438, inlinedAt: !427)
!438 = distinct !DILexicalBlock(scope: !417, file: !3, line: 173, column: 6)
!439 = !DILocation(line: 173, column: 24, scope: !438, inlinedAt: !427)
!440 = !DILocation(line: 173, column: 6, scope: !417, inlinedAt: !427)
!441 = !DILocation(line: 179, column: 14, scope: !417, inlinedAt: !427)
!442 = !{!443, !326, i64 9}
!443 = !{!"iphdr", !326, i64 0, !326, i64 0, !326, i64 1, !369, i64 2, !369, i64 4, !369, i64 6, !326, i64 8, !326, i64 9, !369, i64 10, !326, i64 12}
!444 = !DILocation(line: 179, column: 9, scope: !417, inlinedAt: !427)
!445 = !DILocation(line: 179, column: 2, scope: !417, inlinedAt: !427)
!446 = !DILocation(line: 337, column: 7, scope: !414)
!447 = !DILocation(line: 338, column: 6, scope: !448)
!448 = distinct !DILexicalBlock(scope: !414, file: !3, line: 338, column: 6)
!449 = !DILocation(line: 338, column: 6, scope: !414)
!450 = !DILocation(line: 345, column: 9, scope: !451)
!451 = distinct !DILexicalBlock(scope: !452, file: !3, line: 344, column: 2)
!452 = distinct !DILexicalBlock(scope: !415, file: !3, line: 343, column: 11)
!453 = !DILocalVariable(name: "nh", arg: 1, scope: !454, file: !3, line: 183, type: !342)
!454 = distinct !DISubprogram(name: "parse_ip6hdr", scope: !3, file: !3, line: 183, type: !455, scopeLine: 185, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !458)
!455 = !DISubroutineType(types: !456)
!456 = !{!90, !342, !53, !457}
!457 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !149, size: 64)
!458 = !{!453, !459, !460, !461}
!459 = !DILocalVariable(name: "data_end", arg: 2, scope: !454, file: !3, line: 183, type: !53)
!460 = !DILocalVariable(name: "ip6hdr", arg: 3, scope: !454, file: !3, line: 184, type: !457)
!461 = !DILocalVariable(name: "ip6h", scope: !454, file: !3, line: 186, type: !149)
!462 = !DILocation(line: 0, scope: !454, inlinedAt: !463)
!463 = distinct !DILocation(line: 346, column: 12, scope: !451)
!464 = !DILocation(line: 188, column: 11, scope: !465, inlinedAt: !463)
!465 = distinct !DILexicalBlock(scope: !454, file: !3, line: 188, column: 6)
!466 = !DILocation(line: 188, column: 17, scope: !465, inlinedAt: !463)
!467 = !DILocation(line: 188, column: 15, scope: !465, inlinedAt: !463)
!468 = !DILocation(line: 188, column: 6, scope: !454, inlinedAt: !463)
!469 = !DILocation(line: 194, column: 15, scope: !454, inlinedAt: !463)
!470 = !{!471, !326, i64 6}
!471 = !{!"ipv6hdr", !326, i64 0, !326, i64 0, !326, i64 1, !369, i64 4, !326, i64 6, !326, i64 7, !326, i64 8}
!472 = !DILocation(line: 194, column: 9, scope: !454, inlinedAt: !463)
!473 = !DILocation(line: 194, column: 2, scope: !454, inlinedAt: !463)
!474 = !DILocation(line: 347, column: 7, scope: !451)
!475 = !DILocation(line: 348, column: 6, scope: !476)
!476 = distinct !DILexicalBlock(scope: !451, file: !3, line: 348, column: 6)
!477 = !DILocation(line: 348, column: 6, scope: !451)
!478 = !DILocation(line: 0, scope: !415)
!479 = !DILocation(line: 358, column: 5, scope: !87)
!480 = !DILocation(line: 305, column: 9, scope: !87)
!481 = !DILocalVariable(name: "nh", arg: 1, scope: !482, file: !3, line: 228, type: !342)
!482 = distinct !DISubprogram(name: "parse_udphdr", scope: !3, file: !3, line: 228, type: !483, scopeLine: 231, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !486)
!483 = !DISubroutineType(types: !484)
!484 = !{!90, !342, !53, !485}
!485 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!486 = !{!481, !487, !488, !489, !490}
!487 = !DILocalVariable(name: "data_end", arg: 2, scope: !482, file: !3, line: 229, type: !53)
!488 = !DILocalVariable(name: "udphdr", arg: 3, scope: !482, file: !3, line: 230, type: !485)
!489 = !DILocalVariable(name: "len", scope: !482, file: !3, line: 232, type: !90)
!490 = !DILocalVariable(name: "h", scope: !482, file: !3, line: 233, type: !192)
!491 = !DILocation(line: 0, scope: !482, inlinedAt: !492)
!492 = distinct !DILocation(line: 359, column: 6, scope: !493)
!493 = distinct !DILexicalBlock(scope: !494, file: !3, line: 359, column: 6)
!494 = distinct !DILexicalBlock(scope: !316, file: !3, line: 358, column: 28)
!495 = !DILocation(line: 235, column: 8, scope: !496, inlinedAt: !492)
!496 = distinct !DILexicalBlock(scope: !482, file: !3, line: 235, column: 6)
!497 = !DILocation(line: 235, column: 14, scope: !496, inlinedAt: !492)
!498 = !DILocation(line: 235, column: 12, scope: !496, inlinedAt: !492)
!499 = !DILocation(line: 235, column: 6, scope: !482, inlinedAt: !492)
!500 = !DILocation(line: 241, column: 8, scope: !482, inlinedAt: !492)
!501 = !{!502, !369, i64 4}
!502 = !{!"udphdr", !369, i64 0, !369, i64 2, !369, i64 4, !369, i64 6}
!503 = !DILocation(line: 242, column: 10, scope: !504, inlinedAt: !492)
!504 = distinct !DILexicalBlock(scope: !482, file: !3, line: 242, column: 6)
!505 = !DILocation(line: 242, column: 6, scope: !482, inlinedAt: !492)
!506 = !DILocation(line: 364, column: 9, scope: !494)
!507 = !DILocation(line: 365, column: 7, scope: !494)
!508 = !DILocation(line: 366, column: 6, scope: !509)
!509 = distinct !DILexicalBlock(scope: !494, file: !3, line: 366, column: 6)
!510 = !DILocation(line: 366, column: 6, scope: !494)
!511 = !DILocation(line: 367, column: 9, scope: !512)
!512 = distinct !DILexicalBlock(scope: !509, file: !3, line: 366, column: 10)
!513 = !DILocation(line: 367, column: 17, scope: !512)
!514 = !DILocation(line: 368, column: 9, scope: !512)
!515 = !DILocation(line: 368, column: 19, scope: !512)
!516 = !DILocation(line: 369, column: 3, scope: !512)
!517 = !DILocation(line: 370, column: 18, scope: !494)
!518 = !{!502, !369, i64 2}
!519 = !DILocation(line: 370, column: 16, scope: !494)
!520 = !DILocation(line: 372, column: 2, scope: !494)
!521 = !DILocalVariable(name: "nh", arg: 1, scope: !522, file: !3, line: 251, type: !342)
!522 = distinct !DISubprogram(name: "parse_tcphdr", scope: !3, file: !3, line: 251, type: !523, scopeLine: 254, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !526)
!523 = !DISubroutineType(types: !524)
!524 = !{!90, !342, !53, !525}
!525 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !201, size: 64)
!526 = !{!521, !527, !528, !529, !530}
!527 = !DILocalVariable(name: "data_end", arg: 2, scope: !522, file: !3, line: 252, type: !53)
!528 = !DILocalVariable(name: "tcphdr", arg: 3, scope: !522, file: !3, line: 253, type: !525)
!529 = !DILocalVariable(name: "len", scope: !522, file: !3, line: 255, type: !90)
!530 = !DILocalVariable(name: "h", scope: !522, file: !3, line: 256, type: !201)
!531 = !DILocation(line: 0, scope: !522, inlinedAt: !532)
!532 = distinct !DILocation(line: 373, column: 6, scope: !533)
!533 = distinct !DILexicalBlock(scope: !534, file: !3, line: 373, column: 6)
!534 = distinct !DILexicalBlock(scope: !315, file: !3, line: 372, column: 35)
!535 = !DILocation(line: 258, column: 8, scope: !536, inlinedAt: !532)
!536 = distinct !DILexicalBlock(scope: !522, file: !3, line: 258, column: 6)
!537 = !DILocation(line: 258, column: 12, scope: !536, inlinedAt: !532)
!538 = !DILocation(line: 258, column: 6, scope: !522, inlinedAt: !532)
!539 = !DILocation(line: 261, column: 11, scope: !522, inlinedAt: !532)
!540 = !DILocation(line: 261, column: 16, scope: !522, inlinedAt: !532)
!541 = !DILocation(line: 263, column: 9, scope: !542, inlinedAt: !532)
!542 = distinct !DILexicalBlock(scope: !522, file: !3, line: 263, column: 5)
!543 = !DILocation(line: 263, column: 5, scope: !522, inlinedAt: !532)
!544 = !DILocation(line: 267, column: 14, scope: !545, inlinedAt: !532)
!545 = distinct !DILexicalBlock(scope: !522, file: !3, line: 267, column: 6)
!546 = !DILocation(line: 267, column: 20, scope: !545, inlinedAt: !532)
!547 = !DILocation(line: 267, column: 6, scope: !522, inlinedAt: !532)
!548 = !DILocation(line: 377, column: 9, scope: !534)
!549 = !DILocation(line: 378, column: 7, scope: !534)
!550 = !DILocation(line: 379, column: 6, scope: !551)
!551 = distinct !DILexicalBlock(scope: !534, file: !3, line: 379, column: 6)
!552 = !DILocation(line: 379, column: 6, scope: !534)
!553 = !DILocation(line: 380, column: 9, scope: !554)
!554 = distinct !DILexicalBlock(scope: !551, file: !3, line: 379, column: 10)
!555 = !DILocation(line: 380, column: 17, scope: !554)
!556 = !DILocation(line: 381, column: 9, scope: !554)
!557 = !DILocation(line: 381, column: 19, scope: !554)
!558 = !DILocation(line: 382, column: 3, scope: !554)
!559 = !DILocation(line: 383, column: 18, scope: !534)
!560 = !{!561, !369, i64 2}
!561 = !{!"tcphdr", !369, i64 0, !369, i64 2, !325, i64 4, !325, i64 8, !369, i64 12, !369, i64 12, !369, i64 13, !369, i64 13, !369, i64 13, !369, i64 13, !369, i64 13, !369, i64 13, !369, i64 13, !369, i64 13, !369, i64 14, !369, i64 16, !369, i64 18}
!562 = !DILocation(line: 383, column: 16, scope: !534)
!563 = !DILocation(line: 384, column: 2, scope: !534)
!564 = !DILocalVariable(name: "nh", arg: 1, scope: !565, file: !3, line: 197, type: !342)
!565 = distinct !DISubprogram(name: "parse_icmphdr", scope: !3, file: !3, line: 197, type: !566, scopeLine: 200, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !569)
!566 = !DISubroutineType(types: !567)
!567 = !{!90, !342, !53, !568}
!568 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !223, size: 64)
!569 = !{!564, !570, !571, !572}
!570 = !DILocalVariable(name: "data_end", arg: 2, scope: !565, file: !3, line: 198, type: !53)
!571 = !DILocalVariable(name: "icmphdr", arg: 3, scope: !565, file: !3, line: 199, type: !568)
!572 = !DILocalVariable(name: "icmph", scope: !565, file: !3, line: 201, type: !223)
!573 = !DILocation(line: 0, scope: !565, inlinedAt: !574)
!574 = distinct !DILocation(line: 387, column: 7, scope: !575)
!575 = distinct !DILexicalBlock(scope: !313, file: !3, line: 387, column: 7)
!576 = !DILocation(line: 203, column: 12, scope: !577, inlinedAt: !574)
!577 = distinct !DILexicalBlock(scope: !565, file: !3, line: 203, column: 6)
!578 = !DILocation(line: 203, column: 18, scope: !577, inlinedAt: !574)
!579 = !DILocation(line: 203, column: 16, scope: !577, inlinedAt: !574)
!580 = !DILocation(line: 203, column: 6, scope: !565, inlinedAt: !574)
!581 = !DILocation(line: 392, column: 7, scope: !313)
!582 = !{!326, !326, i64 0}
!583 = !DILocation(line: 0, scope: !313)
!584 = !DILocation(line: 393, column: 11, scope: !585)
!585 = distinct !DILexicalBlock(scope: !313, file: !3, line: 393, column: 6)
!586 = !DILocation(line: 393, column: 6, scope: !313)
!587 = !DILocation(line: 395, column: 10, scope: !588)
!588 = distinct !DILexicalBlock(scope: !585, file: !3, line: 393, column: 15)
!589 = !DILocation(line: 396, column: 8, scope: !588)
!590 = !DILocation(line: 397, column: 7, scope: !591)
!591 = distinct !DILexicalBlock(scope: !588, file: !3, line: 397, column: 7)
!592 = !DILocation(line: 397, column: 7, scope: !588)
!593 = !DILocation(line: 398, column: 10, scope: !594)
!594 = distinct !DILexicalBlock(scope: !591, file: !3, line: 397, column: 11)
!595 = !DILocation(line: 398, column: 18, scope: !594)
!596 = !DILocation(line: 399, column: 10, scope: !594)
!597 = !DILocation(line: 399, column: 20, scope: !594)
!598 = !DILocation(line: 400, column: 4, scope: !594)
!599 = !DILocalVariable(name: "nh", arg: 1, scope: !600, file: !3, line: 212, type: !342)
!600 = distinct !DISubprogram(name: "parse_icmp6hdr", scope: !3, file: !3, line: 212, type: !601, scopeLine: 215, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !604)
!601 = !DISubroutineType(types: !602)
!602 = !{!90, !342, !53, !603}
!603 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !247, size: 64)
!604 = !{!599, !605, !606, !607}
!605 = !DILocalVariable(name: "data_end", arg: 2, scope: !600, file: !3, line: 213, type: !53)
!606 = !DILocalVariable(name: "icmp6hdr", arg: 3, scope: !600, file: !3, line: 214, type: !603)
!607 = !DILocalVariable(name: "icmp6h", scope: !600, file: !3, line: 216, type: !247)
!608 = !DILocation(line: 0, scope: !600, inlinedAt: !609)
!609 = distinct !DILocation(line: 408, column: 6, scope: !610)
!610 = distinct !DILexicalBlock(scope: !318, file: !3, line: 408, column: 6)
!611 = !DILocation(line: 218, column: 13, scope: !612, inlinedAt: !609)
!612 = distinct !DILexicalBlock(scope: !600, file: !3, line: 218, column: 6)
!613 = !DILocation(line: 218, column: 19, scope: !612, inlinedAt: !609)
!614 = !DILocation(line: 218, column: 17, scope: !612, inlinedAt: !609)
!615 = !DILocation(line: 218, column: 6, scope: !600, inlinedAt: !609)
!616 = !DILocation(line: 413, column: 8, scope: !318)
!617 = !DILocation(line: 0, scope: !318)
!618 = !DILocation(line: 414, column: 12, scope: !619)
!619 = distinct !DILexicalBlock(scope: !318, file: !3, line: 414, column: 7)
!620 = !DILocation(line: 414, column: 7, scope: !318)
!621 = !DILocation(line: 416, column: 11, scope: !622)
!622 = distinct !DILexicalBlock(scope: !619, file: !3, line: 414, column: 16)
!623 = !DILocation(line: 417, column: 9, scope: !622)
!624 = !DILocation(line: 418, column: 8, scope: !625)
!625 = distinct !DILexicalBlock(scope: !622, file: !3, line: 418, column: 8)
!626 = !DILocation(line: 418, column: 8, scope: !622)
!627 = !DILocation(line: 419, column: 11, scope: !628)
!628 = distinct !DILexicalBlock(scope: !625, file: !3, line: 418, column: 12)
!629 = !DILocation(line: 419, column: 19, scope: !628)
!630 = !DILocation(line: 420, column: 11, scope: !628)
!631 = !DILocation(line: 420, column: 21, scope: !628)
!632 = !DILocation(line: 421, column: 5, scope: !628)
!633 = !DILocation(line: 437, column: 1, scope: !87)
!634 = !DILocation(line: 0, scope: !635, inlinedAt: !642)
!635 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !73, file: !73, line: 24, type: !636, scopeLine: 25, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !638)
!636 = !DISubroutineType(types: !637)
!637 = !{!95, !91, !95}
!638 = !{!639, !640, !641}
!639 = !DILocalVariable(name: "ctx", arg: 1, scope: !635, file: !73, line: 24, type: !91)
!640 = !DILocalVariable(name: "action", arg: 2, scope: !635, file: !73, line: 24, type: !95)
!641 = !DILocalVariable(name: "rec", scope: !635, file: !73, line: 30, type: !295)
!642 = distinct !DILocation(line: 438, column: 9, scope: !87)
!643 = !DILocation(line: 30, column: 24, scope: !635, inlinedAt: !642)
!644 = !DILocation(line: 31, column: 7, scope: !645, inlinedAt: !642)
!645 = distinct !DILexicalBlock(scope: !635, file: !73, line: 31, column: 6)
!646 = !DILocation(line: 31, column: 6, scope: !635, inlinedAt: !642)
!647 = !DILocation(line: 38, column: 7, scope: !635, inlinedAt: !642)
!648 = !DILocation(line: 38, column: 17, scope: !635, inlinedAt: !642)
!649 = !DILocation(line: 39, column: 25, scope: !635, inlinedAt: !642)
!650 = !DILocation(line: 39, column: 41, scope: !635, inlinedAt: !642)
!651 = !DILocation(line: 39, column: 34, scope: !635, inlinedAt: !642)
!652 = !DILocation(line: 39, column: 19, scope: !635, inlinedAt: !642)
!653 = !DILocation(line: 39, column: 7, scope: !635, inlinedAt: !642)
!654 = !DILocation(line: 39, column: 16, scope: !635, inlinedAt: !642)
!655 = !DILocation(line: 41, column: 9, scope: !635, inlinedAt: !642)
!656 = !DILocation(line: 41, column: 2, scope: !635, inlinedAt: !642)
!657 = !DILocation(line: 42, column: 1, scope: !635, inlinedAt: !642)
!658 = !DILocation(line: 439, column: 1, scope: !87)
!659 = !DILocation(line: 438, column: 2, scope: !87)
