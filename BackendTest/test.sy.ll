%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque
%struct.timeval = type { i64, i64 }

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%c\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%a\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"%d:\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c" %d\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c" %a\00", align 1
@_sysy_us = common dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 16
@_sysy_s = common dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 16
@_sysy_m = common dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 16
@_sysy_h = common dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 16
@_sysy_idx = common dso_local local_unnamed_addr global i32 0, align 4
@stderr = external dso_local local_unnamed_addr global %struct._IO_FILE*, align 8
@.str.7 = private unnamed_addr constant [35 x i8] c"Timer@%04d-%04d: %dH-%dM-%dS-%dus\0A\00", align 1
@_sysy_l1 = common dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 16
@_sysy_l2 = common dso_local local_unnamed_addr global [1024 x i32] zeroinitializer, align 16
@.str.8 = private unnamed_addr constant [25 x i8] c"TOTAL: %dH-%dM-%dS-%dus\0A\00", align 1
@_sysy_start = common dso_local global %struct.timeval zeroinitializer, align 8
@_sysy_end = common dso_local global %struct.timeval zeroinitializer, align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @before_main, i8* null }]
@llvm.global_dtors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @after_main, i8* null }]

define dso_local i32 @getint() local_unnamed_addr #0 {
entry:
  %t = alloca i32, align 4
  %0 = bitcast i32* %t to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0) #6
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* nonnull %t)
  %1 = load i32, i32* %t, align 4
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0) #6
  ret i32 %1
}

declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare dso_local i32 @__isoc99_scanf(i8* nocapture readonly, ...) local_unnamed_addr #2

declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

define dso_local i32 @getch() local_unnamed_addr #0 {
entry:
  %c = alloca i8, align 1
  call void @llvm.lifetime.start.p0i8(i64 1, i8* nonnull %c) #6
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), i8* nonnull %c)
  %0 = load i8, i8* %c, align 1
  %conv = sext i8 %0 to i32
  call void @llvm.lifetime.end.p0i8(i64 1, i8* nonnull %c) #6
  ret i32 %conv
}

define dso_local float @getfloat() local_unnamed_addr #0 {
entry:
  %n = alloca float, align 4
  %0 = bitcast float* %n to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0) #6
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), float* nonnull %n)
  %1 = load float, float* %n, align 4
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0) #6
  ret float %1
}

define dso_local i32 @getarray(i32* %a) local_unnamed_addr #0 {
entry:
  %n = alloca i32, align 4
  %0 = bitcast i32* %n to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0) #6
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* nonnull %n)
  %1 = load i32, i32* %n, align 4
  %cmp5 = icmp sgt i32 %1, 0
  br i1 %cmp5, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  %.lcssa = phi i32 [ %1, %entry ], [ %2, %for.body ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0) #6
  ret i32 %.lcssa

for.body:
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %indvars.iv
  %call1 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* %arrayidx)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %2 = load i32, i32* %n, align 4
  %3 = sext i32 %2 to i64
  %cmp = icmp slt i64 %indvars.iv.next, %3
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

define dso_local i32 @getfarray(float* %a) local_unnamed_addr #0 {
entry:
  %n = alloca i32, align 4
  %0 = bitcast i32* %n to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0) #6
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32* nonnull %n)
  %1 = load i32, i32* %n, align 4
  %cmp5 = icmp sgt i32 %1, 0
  br i1 %cmp5, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  %.lcssa = phi i32 [ %1, %entry ], [ %2, %for.body ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0) #6
  ret i32 %.lcssa

for.body:
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds float, float* %a, i64 %indvars.iv
  %call1 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), float* %arrayidx)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %2 = load i32, i32* %n, align 4
  %3 = sext i32 %2 to i64
  %cmp = icmp slt i64 %indvars.iv.next, %3
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

define dso_local void @putint(i32 %a) local_unnamed_addr #3 {
entry:
  %call = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0), i32 %a)
  ret void
}

declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

define dso_local void @putch(i32 %a) local_unnamed_addr #3 {
entry:
  %putchar = tail call i32 @putchar(i32 %a)
  ret void
}

define dso_local void @putarray(i32 %n, i32* nocapture readonly %a) local_unnamed_addr #3 {
entry:
  %call = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 %n)
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:
  %wide.trip.count = zext i32 %n to i64
  br label %for.body

for.cond.cleanup:
  %putchar = tail call i32 @putchar(i32 10)
  ret void

for.body:
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %indvars.iv
  %0 = load i32, i32* %arrayidx, align 4
  %call1 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i64 0, i64 0), i32 %0)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

define dso_local void @putfloat(float %a) local_unnamed_addr #3 {
entry:
  %conv = fpext float %a to double
  %call = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i64 0, i64 0), double %conv)
  ret void
}

define dso_local void @putfarray(i32 %n, float* nocapture readonly %a) local_unnamed_addr #3 {
entry:
  %call = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0), i32 %n)
  %cmp7 = icmp sgt i32 %n, 0
  br i1 %cmp7, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:
  %wide.trip.count = zext i32 %n to i64
  br label %for.body

for.cond.cleanup:
  %putchar = tail call i32 @putchar(i32 10)
  ret void

for.body:
  %indvars.iv = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds float, float* %a, i64 %indvars.iv
  %0 = load float, float* %arrayidx, align 4
  %conv = fpext float %0 to double
  %call1 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @.str.6, i64 0, i64 0), double %conv)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

define dso_local void @before_main() #4 {
entry:
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(4096) bitcast ([1024 x i32]* @_sysy_us to i8*), i8 0, i64 4096, i1 false)
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(4096) bitcast ([1024 x i32]* @_sysy_s to i8*), i8 0, i64 4096, i1 false)
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(4096) bitcast ([1024 x i32]* @_sysy_m to i8*), i8 0, i64 4096, i1 false)
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(4096) bitcast ([1024 x i32]* @_sysy_h to i8*), i8 0, i64 4096, i1 false)
  store i32 1, i32* @_sysy_idx, align 4
  ret void
}

define dso_local void @after_main() #3 {
entry:
  %0 = load i32, i32* @_sysy_idx, align 4
  %cmp37 = icmp sgt i32 %0, 1
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  br i1 %cmp37, label %for.body, label %entry.for.cond.cleanup_crit_edge

entry.for.cond.cleanup_crit_edge:
  %.pre = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 0), align 16
  %.pre40 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 0), align 16
  %.pre41 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 0), align 16
  %.pre42 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 0), align 16
  br label %for.cond.cleanup

for.cond.cleanup:
  %2 = phi i32 [ %.pre42, %entry.for.cond.cleanup_crit_edge ], [ %rem, %for.body ]
  %3 = phi i32 [ %.pre41, %entry.for.cond.cleanup_crit_edge ], [ %rem19, %for.body ]
  %4 = phi i32 [ %.pre40, %entry.for.cond.cleanup_crit_edge ], [ %rem23, %for.body ]
  %5 = phi i32 [ %.pre, %entry.for.cond.cleanup_crit_edge ], [ %add22, %for.body ]
  %.lcssa = phi %struct._IO_FILE* [ %1, %entry.for.cond.cleanup_crit_edge ], [ %23, %for.body ]
  %call24 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %.lcssa, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.8, i64 0, i64 0), i32 %5, i32 %4, i32 %3, i32 %2) #7
  ret void

for.body:
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 1, %entry ]
  %6 = phi %struct._IO_FILE* [ %23, %for.body ], [ %1, %entry ]
  %arrayidx = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_l1, i64 0, i64 %indvars.iv
  %7 = load i32, i32* %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_l2, i64 0, i64 %indvars.iv
  %8 = load i32, i32* %arrayidx2, align 4
  %arrayidx4 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 %indvars.iv
  %9 = load i32, i32* %arrayidx4, align 4
  %arrayidx6 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 %indvars.iv
  %10 = load i32, i32* %arrayidx6, align 4
  %arrayidx8 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 %indvars.iv
  %11 = load i32, i32* %arrayidx8, align 4
  %arrayidx10 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 %indvars.iv
  %12 = load i32, i32* %arrayidx10, align 4
  %call = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %6, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.7, i64 0, i64 0), i32 %7, i32 %8, i32 %9, i32 %10, i32 %11, i32 %12) #7
  %13 = load i32, i32* %arrayidx10, align 4
  %14 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 0), align 16
  %add = add nsw i32 %14, %13
  %15 = load i32, i32* %arrayidx8, align 4
  %16 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 0), align 16
  %add15 = add nsw i32 %16, %15
  %rem = srem i32 %add, 1000000
  store i32 %rem, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 0), align 16
  %17 = load i32, i32* %arrayidx6, align 4
  %18 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 0), align 16
  %add18 = add nsw i32 %18, %17
  %rem19 = srem i32 %add15, 60
  store i32 %rem19, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 0), align 16
  %19 = load i32, i32* %arrayidx4, align 4
  %20 = load i32, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 0), align 16
  %add22 = add nsw i32 %20, %19
  store i32 %add22, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 0), align 16
  %rem23 = srem i32 %add18, 60
  store i32 %rem23, i32* getelementptr inbounds ([1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 0), align 16
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %21 = load i32, i32* @_sysy_idx, align 4
  %22 = sext i32 %21 to i64
  %cmp = icmp slt i64 %indvars.iv.next, %22
  %23 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

declare dso_local i32 @fprintf(%struct._IO_FILE* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #2

define dso_local void @_sysy_starttime(i32 %lineno) local_unnamed_addr #3 {
entry:
  %0 = load i32, i32* @_sysy_idx, align 4
  %idxprom = sext i32 %0 to i64
  %arrayidx = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_l1, i64 0, i64 %idxprom
  store i32 %lineno, i32* %arrayidx, align 4
  %call = tail call i32 @gettimeofday(%struct.timeval* nonnull @_sysy_start, i8* null) #6
  ret void
}

declare dso_local i32 @gettimeofday(%struct.timeval* nocapture, i8* nocapture) local_unnamed_addr #2

define dso_local void @_sysy_stoptime(i32 %lineno) local_unnamed_addr #3 {
entry:
  %call = tail call i32 @gettimeofday(%struct.timeval* nonnull @_sysy_end, i8* null) #6
  %0 = load i32, i32* @_sysy_idx, align 4
  %idxprom = sext i32 %0 to i64
  %arrayidx = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_l2, i64 0, i64 %idxprom
  store i32 %lineno, i32* %arrayidx, align 4
  %1 = load i64, i64* getelementptr inbounds (%struct.timeval, %struct.timeval* @_sysy_end, i64 0, i32 0), align 8
  %2 = load i64, i64* getelementptr inbounds (%struct.timeval, %struct.timeval* @_sysy_start, i64 0, i32 0), align 8
  %sub = sub nsw i64 %1, %2
  %mul = mul nsw i64 %sub, 1000000
  %3 = load i64, i64* getelementptr inbounds (%struct.timeval, %struct.timeval* @_sysy_end, i64 0, i32 1), align 8
  %add = add nsw i64 %mul, %3
  %4 = load i64, i64* getelementptr inbounds (%struct.timeval, %struct.timeval* @_sysy_start, i64 0, i32 1), align 8
  %sub1 = sub i64 %add, %4
  %arrayidx3 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_us, i64 0, i64 %idxprom
  %5 = load i32, i32* %arrayidx3, align 4
  %6 = trunc i64 %sub1 to i32
  %conv5 = add i32 %5, %6
  %div = sdiv i32 %conv5, 1000000
  %arrayidx9 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_s, i64 0, i64 %idxprom
  %7 = load i32, i32* %arrayidx9, align 4
  %add10 = add nsw i32 %div, %7
  %rem = srem i32 %conv5, 1000000
  store i32 %rem, i32* %arrayidx3, align 4
  %div15 = sdiv i32 %add10, 60
  %arrayidx17 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_m, i64 0, i64 %idxprom
  %8 = load i32, i32* %arrayidx17, align 4
  %add18 = add nsw i32 %div15, %8
  %rem21 = srem i32 %add10, 60
  store i32 %rem21, i32* %arrayidx9, align 4
  %div24 = sdiv i32 %add18, 60
  %arrayidx26 = getelementptr inbounds [1024 x i32], [1024 x i32]* @_sysy_h, i64 0, i64 %idxprom
  %9 = load i32, i32* %arrayidx26, align 4
  %add27 = add nsw i32 %9, %div24
  store i32 %add27, i32* %arrayidx26, align 4
  %rem30 = srem i32 %add18, 60
  store i32 %rem30, i32* %arrayidx17, align 4
  %inc = add nsw i32 %0, 1
  store i32 %inc, i32* @_sysy_idx, align 4
  ret void
}

declare i32 @putchar(i32) local_unnamed_addr #5

declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

declare void @llvm.memcpy.p0.p0.i32(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i32, i1 immarg)
attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nofree nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nofree norecurse nounwind uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree nounwind }
attributes #6 = { nounwind }
attributes #7 = { cold }
define i32 @QuickSort(i32* %.143, i32 %.146, i32 %.149){
.142:
  %.156 = icmp slt i32 %.146, %.149
  br i1 %.156, label %.152, label %.153
.152:
  %.167 = getelementptr inbounds i32, i32* %.143, i32 %.146
  %.168 = load i32, i32* %.167
  br label %.170wc56 
.153:
  ret i32 0 
.170wc56:
  %.945 = phi i32 [%.149, %.152], [%.944, %.238]
  %.942 = phi i32 [%.146, %.152], [%.941, %.238]
  %.176 = icmp slt i32 %.942, %.945
  br i1 %.176, label %.178wc58, label %.172wn79
.172wn79:
  %.259 = getelementptr inbounds i32, i32* %.143, i32 %.942
  store i32 %.168, i32* %.259
  %.263 = sub i32 %.942, 1
  %.268at84 = call i32 @QuickSort(i32* %.143, i32 %.146, i32 %.263)
  %.271 = add i32 %.942, 1
  %.276at86 = call i32 @QuickSort(i32* %.143, i32 %.271, i32 %.149)
  br label %.153 
.178wc58:
  %.946 = phi i32 [%.945, %.170wc56], [%.196, %.179wloop.58.61]
  %.184 = icmp slt i32 %.942, %.946
  br i1 %.184, label %.185, label %.180wn61
.179wloop.58.61:
  %.196 = sub i32 %.946, 1
  br label %.178wc58 
.180wn61:
  br i1 %.184, label %.199, label %.200
.185:
  %.189 = getelementptr inbounds i32, i32* %.143, i32 %.946
  %.190 = load i32, i32* %.189
  %.192 = sub i32 %.168, 1
  %.193 = icmp sgt i32 %.190, %.192
  br i1 %.193, label %.179wloop.58.61, label %.180wn61
.199:
  %.207 = getelementptr inbounds i32, i32* %.143, i32 %.946
  %.208 = load i32, i32* %.207
  %.211 = getelementptr inbounds i32, i32* %.143, i32 %.942
  store i32 %.208, i32* %.211
  %.214 = add i32 %.942, 1
  br label %.200 
.200:
  %.943 = phi i32 [%.942, %.180wn61], [%.214, %.199]
  br label %.217wc69 
.217wc69:
  %.941 = phi i32 [%.943, %.200], [%.234, %.218wloop.69.72]
  %.223 = icmp slt i32 %.941, %.946
  br i1 %.223, label %.224, label %.219wn72
.218wloop.69.72:
  %.234 = add i32 %.941, 1
  br label %.217wc69 
.219wn72:
  br i1 %.223, label %.237, label %.238
.224:
  %.228 = getelementptr inbounds i32, i32* %.143, i32 %.941
  %.229 = load i32, i32* %.228
  %.231 = icmp slt i32 %.229, %.168
  br i1 %.231, label %.218wloop.69.72, label %.219wn72
.237:
  %.245 = getelementptr inbounds i32, i32* %.143, i32 %.941
  %.246 = load i32, i32* %.245
  %.249 = getelementptr inbounds i32, i32* %.143, i32 %.946
  store i32 %.246, i32* %.249
  %.252 = sub i32 %.946, 1
  br label %.238 
.238:
  %.944 = phi i32 [%.946, %.219wn72], [%.252, %.237]
  br label %.170wc56 
}
define i32 @main(){
.626:
  %.1114 = alloca [1000 x i32]
  %.630 = alloca [32 x i32]
  %.629 = alloca [32 x i32]
  %.632 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  store i32 7, i32* %.632
  %.635 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 1
  store i32 23, i32* %.635
  %.638 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 2
  store i32 89, i32* %.638
  %.642 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 3
  store i32 26, i32* %.642
  %.646 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 4
  store i32 282, i32* %.646
  %.650 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 5
  store i32 254, i32* %.650
  %.654 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 6
  store i32 27, i32* %.654
  %.656 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 7
  store i32 5, i32* %.656
  %.660 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 8
  store i32 83, i32* %.660
  %.664 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 9
  store i32 273, i32* %.664
  %.668 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 10
  store i32 574, i32* %.668
  %.672 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 11
  store i32 905, i32* %.672
  %.676 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 12
  store i32 354, i32* %.676
  %.680 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 13
  store i32 657, i32* %.680
  %.684 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 14
  store i32 935, i32* %.684
  %.688 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 15
  store i32 264, i32* %.688
  %.692 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 16
  store i32 639, i32* %.692
  %.696 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 17
  store i32 459, i32* %.696
  %.700 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 18
  store i32 29, i32* %.700
  %.704 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 19
  store i32 68, i32* %.704
  %.708 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 20
  store i32 929, i32* %.708
  %.712 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 21
  store i32 756, i32* %.712
  %.716 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 22
  store i32 452, i32* %.716
  %.719 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 23
  store i32 279, i32* %.719
  %.723 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 24
  store i32 58, i32* %.723
  %.727 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 25
  store i32 87, i32* %.727
  %.730 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 26
  store i32 96, i32* %.730
  %.733 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 27
  store i32 36, i32* %.733
  %.737 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 28
  store i32 39, i32* %.737
  %.739 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 29
  store i32 28, i32* %.739
  %.742 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 30
  store i32 1, i32* %.742
  %.746 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 31
  store i32 290, i32* %.746
  %.750 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  br label %.1280 
.1280:
  %.1281 = phi i32 [0, %.626], [%.1287, %.1282]
  %.1290 = icmp slt i32 %.1281, 32
  br i1 %.1290, label %.1282, label %.1157
.1282:
  %.1283 = getelementptr inbounds i32, i32* %.632, i32 %.1281
  %.1284 = load i32, i32* %.1283
  %.1285 = getelementptr inbounds i32, i32* %.750, i32 %.1281
  store i32 %.1284, i32* %.1285
  %.1287 = add i32 %.1281, 1
  br label %.1280 
.1157:
  %.1158 = phi i32 [0, %.1280], [%.1168, %.1159]
  %.1163 = phi i32 [0, %.1280], [%.1164, %.1159]
  %.1170 = icmp slt i32 %.1158, %.1163
  br i1 %.1170, label %.1159, label %.758wc240
.1159:
  %.1160 = getelementptr inbounds i32, i32* %.750, i32 %.1158
  %.1161 = load i32, i32* %.1160
  %.1162 = getelementptr inbounds i32, i32* %.750, i32 %.1163
  %.1165 = load i32, i32* %.1162
  store i32 %.1165, i32* %.1160
  store i32 %.1161, i32* %.1162
  %.1168 = add i32 %.1158, 1
  %.1164 = sub i32 %.1163, 1
  br label %.1157 
.758wc240:
  %.973 = phi i32 [0, %.1157], [%.773, %.759wloop.240.244]
  %.763 = icmp slt i32 %.973, 32
  br i1 %.763, label %.759wloop.240.244, label %.1016
.759wloop.240.244:
  %.766 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.973
  %.767 = load i32, i32* %.766
  call void @putint(i32 %.767)
  %.773 = add i32 %.973, 1
  br label %.758wc240 
.1016:
  %.1017 = phi i32 [0, %.758wc240], [%.1019, %.1018]
  %.1023 = icmp slt i32 %.1017, 31
  br i1 %.1023, label %.1025, label %.780wc247
.1025:
  %.1026 = phi i32 [0, %.1016], [%.1035, %.1027], [%.1035, %.1036]
  %.1040 = sub i32 32, %.1017
  %.1041 = sub i32 %.1040, 1
  %.1042 = icmp slt i32 %.1026, %.1041
  br i1 %.1042, label %.1036, label %.1018
.1036:
  %.1030 = getelementptr inbounds i32, i32* %.750, i32 %.1026
  %.1029 = load i32, i32* %.1030
  %.1035 = add i32 %.1026, 1
  %.1031 = getelementptr inbounds i32, i32* %.1030, i32 1
  %.1033 = load i32, i32* %.1031
  %.1037 = icmp sgt i32 %.1029, %.1033
  br i1 %.1037, label %.1027, label %.1025
.1018:
  %.1019 = add i32 %.1017, 1
  br label %.1016 
.1027:
  store i32 %.1029, i32* %.1031
  store i32 %.1033, i32* %.1030
  br label %.1025 
.780wc247:
  %.972 = phi i32 [0, %.1016], [%.794, %.781wloop.247.251]
  %.785 = icmp slt i32 %.972, 32
  br i1 %.785, label %.781wloop.247.251, label %.782wn251
.781wloop.247.251:
  %.788 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.972
  %.789 = load i32, i32* %.788
  call void @putint(i32 %.789)
  %.794 = add i32 %.972, 1
  br label %.780wc247 
.782wn251:
  %.1095 = getelementptr inbounds i32, i32* %.750, i32 16
  %.1096 = load i32, i32* %.1095
  %.1098 = getelementptr inbounds i32, i32* %.750, i32 15
  %.1099 = load i32, i32* %.1098
  %.1100 = add i32 %.1096, %.1099
  %.1101 = sdiv i32 %.1100, 2
  br label %.1087 
.1087:
  call void @putint(i32 %.1101)
  br label %.1116 
.1116:
  %.1117 = phi i32 [0, %.1087], [%.1121, %.1118]
  %.1123 = icmp slt i32 %.1117, 1000
  br i1 %.1123, label %.1118, label %.1125
.1118:
  %.1119 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.1114, i32 0, i32 %.1117
  store i32 0, i32* %.1119
  %.1121 = add i32 %.1117, 1
  br label %.1116 
.1125:
  %.1126 = phi i32 [0, %.1116], [%.1128, %.1127]
  %.1144 = phi i32 [undef, %.1116], [%.1143, %.1127]
  %.1131 = phi i32 [0, %.1116], [%.1132, %.1127]
  %.1147 = icmp slt i32 %.1131, 32
  br i1 %.1147, label %.1129, label %.1149
.1129:
  %.1130 = getelementptr inbounds i32, i32* %.750, i32 %.1131
  %.1133 = load i32, i32* %.1130
  %.1134 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.1114, i32 0, i32 %.1133
  %.1135 = load i32, i32* %.1134
  %.1136 = add i32 %.1135, 1
  store i32 %.1136, i32* %.1134
  %.1138 = icmp sgt i32 %.1136, %.1126
  br i1 %.1138, label %.1140, label %.1127
.1149:
  call void @putint(i32 %.1144)
  br label %.1260 
.1140:
  %.1141 = load i32, i32* %.1134
  br label %.1127 
.1127:
  %.1128 = phi i32 [%.1126, %.1129], [%.1141, %.1140]
  %.1143 = phi i32 [%.1144, %.1129], [%.1133, %.1140]
  %.1132 = add i32 %.1131, 1
  br label %.1125 
.1260:
  %.1261 = phi i32 [0, %.1149], [%.1267, %.1262]
  %.1270 = icmp slt i32 %.1261, 32
  br i1 %.1270, label %.1262, label %.980
.1262:
  %.1263 = getelementptr inbounds i32, i32* %.632, i32 %.1261
  %.1264 = load i32, i32* %.1263
  %.1265 = getelementptr inbounds i32, i32* %.750, i32 %.1261
  store i32 %.1264, i32* %.1265
  %.1267 = add i32 %.1261, 1
  br label %.1260 
.980:
  %.981 = phi i32 [0, %.1260], [%.983, %.982]
  %.987 = icmp slt i32 %.981, 31
  br i1 %.987, label %.989, label %.815wc260
.989:
  %.990 = phi i32 [0, %.980], [%.999, %.991], [%.999, %.1000]
  %.1004 = sub i32 32, %.981
  %.1005 = sub i32 %.1004, 1
  %.1006 = icmp slt i32 %.990, %.1005
  br i1 %.1006, label %.1000, label %.982
.1000:
  %.994 = getelementptr inbounds i32, i32* %.750, i32 %.990
  %.993 = load i32, i32* %.994
  %.999 = add i32 %.990, 1
  %.995 = getelementptr inbounds i32, i32* %.994, i32 1
  %.997 = load i32, i32* %.995
  %.1001 = icmp sgt i32 %.993, %.997
  br i1 %.1001, label %.991, label %.989
.982:
  %.983 = add i32 %.981, 1
  br label %.980 
.991:
  store i32 %.993, i32* %.995
  store i32 %.997, i32* %.994
  br label %.989 
.815wc260:
  %.971 = phi i32 [0, %.980], [%.829, %.816wloop.260.264]
  %.820 = icmp slt i32 %.971, 32
  br i1 %.820, label %.816wloop.260.264, label %.1240
.816wloop.260.264:
  %.823 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.971
  %.824 = load i32, i32* %.823
  call void @putint(i32 %.824)
  %.829 = add i32 %.971, 1
  br label %.815wc260 
.1240:
  %.1241 = phi i32 [0, %.815wc260], [%.1247, %.1242]
  %.1250 = icmp slt i32 %.1241, 32
  br i1 %.1250, label %.1242, label %.1052
.1242:
  %.1243 = getelementptr inbounds i32, i32* %.632, i32 %.1241
  %.1244 = load i32, i32* %.1243
  %.1245 = getelementptr inbounds i32, i32* %.750, i32 %.1241
  store i32 %.1244, i32* %.1245
  %.1247 = add i32 %.1241, 1
  br label %.1240 
.1052:
  %.1053 = phi i32 [1, %.1240], [%.1077, %.1054]
  %.1080 = icmp slt i32 %.1053, 32
  br i1 %.1080, label %.1057, label %.840wc269
.1057:
  %.1058 = getelementptr inbounds i32, i32* %.750, i32 %.1053
  %.1059 = load i32, i32* %.1058
  %.1060 = sub i32 %.1053, 1
  br label %.1062 
.1062:
  %.1056 = phi i32 [%.1060, %.1057], [%.1073, %.1070]
  %.1063 = icmp sgt i32 %.1056, -1
  br i1 %.1063, label %.1065, label %.1054
.1070:
  %.1071 = getelementptr inbounds i32, i32* %.1066, i32 1
  store i32 %.1067, i32* %.1071
  %.1073 = sub i32 %.1056, 1
  br label %.1062 
.1054:
  %.1055 = add i32 %.1056, 1
  %.1075 = getelementptr inbounds i32, i32* %.750, i32 %.1055
  store i32 %.1059, i32* %.1075
  %.1077 = add i32 %.1053, 1
  br label %.1052 
.1065:
  %.1066 = getelementptr inbounds i32, i32* %.750, i32 %.1056
  %.1067 = load i32, i32* %.1066
  %.1068 = icmp slt i32 %.1059, %.1067
  br i1 %.1068, label %.1070, label %.1054
.840wc269:
  %.970 = phi i32 [0, %.1052], [%.854, %.841wloop.269.273]
  %.845 = icmp slt i32 %.970, 32
  br i1 %.845, label %.841wloop.269.273, label %.1220
.841wloop.269.273:
  %.848 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.970
  %.849 = load i32, i32* %.848
  call void @putint(i32 %.849)
  %.854 = add i32 %.970, 1
  br label %.840wc269 
.1220:
  %.1221 = phi i32 [0, %.840wc269], [%.1227, %.1222]
  %.1230 = icmp slt i32 %.1221, 32
  br i1 %.1230, label %.1222, label %.1217
.1222:
  %.1223 = getelementptr inbounds i32, i32* %.632, i32 %.1221
  %.1224 = load i32, i32* %.1223
  %.1225 = getelementptr inbounds i32, i32* %.750, i32 %.1221
  store i32 %.1224, i32* %.1225
  %.1227 = add i32 %.1221, 1
  br label %.1220 
.1217:
  %.866at278 = call i32 @QuickSort(i32* %.750, i32 0, i32 31)
  br label %.868wc279 
.868wc279:
  %.969 = phi i32 [0, %.1217], [%.882, %.869wloop.279.283]
  %.873 = icmp slt i32 %.969, 32
  br i1 %.873, label %.869wloop.279.283, label %.1200
.869wloop.279.283:
  %.876 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.969
  %.877 = load i32, i32* %.876
  call void @putint(i32 %.877)
  %.882 = add i32 %.969, 1
  br label %.868wc279 
.1200:
  %.1201 = phi i32 [0, %.868wc279], [%.1207, %.1202]
  %.1210 = icmp slt i32 %.1201, 32
  br i1 %.1210, label %.1202, label %.1300
.1202:
  %.1203 = getelementptr inbounds i32, i32* %.632, i32 %.1201
  %.1204 = load i32, i32* %.1203
  %.1205 = getelementptr inbounds i32, i32* %.750, i32 %.1201
  store i32 %.1204, i32* %.1205
  %.1207 = add i32 %.1201, 1
  br label %.1200 
.1300:
  %.1301 = phi i32 [0, %.1200], [%.1303, %.1302]
  %.1309 = phi i32 [0, %.1200], [%.1310, %.1302]
  %.1317 = icmp slt i32 %.1309, 32
  br i1 %.1317, label %.1319, label %.893wc288
.1319:
  %.1308 = getelementptr inbounds i32, i32* %.750, i32 %.1309
  %.1307 = load i32, i32* %.1308
  %.1306 = add i32 %.1301, %.1307
  %.1320 = srem i32 %.1309, 4
  %.1322 = icmp ne i32 %.1320, 3
  br i1 %.1322, label %.1312, label %.1304
.1312:
  store i32 0, i32* %.1308
  br label %.1302 
.1304:
  store i32 %.1306, i32* %.1308
  br label %.1302 
.1302:
  %.1303 = phi i32 [0, %.1304], [%.1306, %.1312]
  %.1310 = add i32 %.1309, 1
  br label %.1300 
.893wc288:
  %.968 = phi i32 [0, %.1300], [%.907, %.894wloop.288.292]
  %.898 = icmp slt i32 %.968, 32
  br i1 %.898, label %.894wloop.288.292, label %.1180
.894wloop.288.292:
  %.901 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.968
  %.902 = load i32, i32* %.901
  call void @putint(i32 %.902)
  %.907 = add i32 %.968, 1
  br label %.893wc288 
.1180:
  %.1181 = phi i32 [0, %.893wc288], [%.1187, %.1182]
  %.1190 = icmp slt i32 %.1181, 32
  br i1 %.1190, label %.1182, label %.1332
.1182:
  %.1183 = getelementptr inbounds i32, i32* %.632, i32 %.1181
  %.1184 = load i32, i32* %.1183
  %.1185 = getelementptr inbounds i32, i32* %.750, i32 %.1181
  store i32 %.1184, i32* %.1185
  %.1187 = add i32 %.1181, 1
  br label %.1180 
.1332:
  %.1333 = phi i32 [0, %.1180], [%.1335, %.1334]
  %.1340 = phi i32 [0, %.1180], [%.1341, %.1334]
  %.1345 = phi i32 [undef, %.1180], [%.1346, %.1334]
  %.1368 = icmp slt i32 %.1340, 32
  br i1 %.1368, label %.1370, label %.1381
.1370:
  %.1372 = icmp slt i32 %.1340, 2
  br i1 %.1372, label %.1357, label %.1374
.1357:
  %.1358 = getelementptr inbounds i32, i32* %.750, i32 %.1340
  %.1359 = load i32, i32* %.1358
  %.1360 = add i32 %.1333, %.1359
  br label %.1334 
.1374:
  %.1375 = icmp eq i32 %.1340, 2
  br i1 %.1375, label %.1352, label %.1338
.1334:
  %.1335 = phi i32 [%.1337, %.1336], [%.1360, %.1357]
  %.1346 = phi i32 [%.1347, %.1336], [%.1345, %.1357]
  %.1341 = add i32 %.1340, 1
  br label %.1332 
.1352:
  %.1353 = load i32, i32* %.750
  %.1354 = sdiv i32 %.1333, 3
  store i32 %.1354, i32* %.750
  br label %.1336 
.1338:
  %.1339 = getelementptr inbounds i32, i32* %.750, i32 %.1340
  %.1342 = load i32, i32* %.1339
  %.1343 = add i32 %.1333, %.1342
  %.1344 = sub i32 %.1343, %.1345
  %.1351 = sub i32 %.1340, 3
  %.1350 = add i32 %.1351, 1
  %.1349 = getelementptr inbounds i32, i32* %.750, i32 %.1350
  %.1348 = load i32, i32* %.1349
  %.1362 = sdiv i32 %.1344, 3
  store i32 %.1362, i32* %.1349
  br label %.1336 
.1336:
  %.1337 = phi i32 [%.1344, %.1338], [%.1333, %.1352]
  %.1347 = phi i32 [%.1348, %.1338], [%.1353, %.1352]
  br label %.1334 
.1381:
  %.1382 = phi i32 [30, %.1332], [%.1386, %.1383]
  %.1389 = icmp slt i32 %.1382, 32
  br i1 %.1389, label %.1383, label %.918wc297
.1383:
  %.1384 = getelementptr inbounds i32, i32* %.750, i32 %.1382
  store i32 0, i32* %.1384
  %.1386 = add i32 %.1382, 1
  br label %.1381 
.918wc297:
  %.967 = phi i32 [0, %.1381], [%.932, %.919wloop.297.301]
  %.923 = icmp slt i32 %.967, 32
  br i1 %.923, label %.919wloop.297.301, label %.920wn301
.919wloop.297.301:
  %.926 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.967
  %.927 = load i32, i32* %.926
  call void @putint(i32 %.927)
  %.932 = add i32 %.967, 1
  br label %.918wc297 
.920wn301:
  ret i32 0 
}
