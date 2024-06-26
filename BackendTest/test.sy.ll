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
@.g.M = global i32 zeroinitializer
@.g.L = global i32 zeroinitializer
@.g.N = global i32 zeroinitializer
define i32 @mul(float* %.6, float* %.9, float* %.12, float* %.15, float* %.18, float* %.21, float* %.24, float* %.27, float* %.30){
.4:
  %.32 = alloca i32
  %.29 = alloca float*
  %.26 = alloca float*
  %.23 = alloca float*
  %.20 = alloca float*
  %.17 = alloca float*
  %.14 = alloca float*
  %.11 = alloca float*
  %.8 = alloca float*
  %.5 = alloca float*
  store float* %.6, float** %.5
  store float* %.9, float** %.8
  store float* %.12, float** %.11
  store float* %.15, float** %.14
  store float* %.18, float** %.17
  store float* %.21, float** %.20
  store float* %.24, float** %.23
  store float* %.27, float** %.26
  store float* %.30, float** %.29
  store i32 0, i32* %.32
  %.35 = load float*, float** %.5
  %.36 = getelementptr inbounds float, float* %.35, i32 0
  %.37 = load float, float* %.36
  %.38 = load float*, float** %.14
  %.39 = getelementptr inbounds float, float* %.38, i32 0
  %.40 = load float, float* %.39
  %.41 = fmul float %.37, %.40
  %.43 = load float*, float** %.5
  %.44 = getelementptr inbounds float, float* %.43, i32 1
  %.45 = load float, float* %.44
  %.46 = load float*, float** %.17
  %.47 = getelementptr inbounds float, float* %.46, i32 0
  %.48 = load float, float* %.47
  %.49 = fmul float %.45, %.48
  %.50 = fadd float %.41, %.49
  %.52 = load float*, float** %.5
  %.53 = getelementptr inbounds float, float* %.52, i32 2
  %.54 = load float, float* %.53
  %.55 = load float*, float** %.20
  %.56 = getelementptr inbounds float, float* %.55, i32 0
  %.57 = load float, float* %.56
  %.58 = fmul float %.54, %.57
  %.59 = fadd float %.50, %.58
  %.60 = load float*, float** %.23
  %.61 = getelementptr inbounds float, float* %.60, i32 0
  store float %.59, float* %.61
  %.63 = load float*, float** %.5
  %.64 = getelementptr inbounds float, float* %.63, i32 0
  %.65 = load float, float* %.64
  %.66 = load float*, float** %.14
  %.67 = getelementptr inbounds float, float* %.66, i32 1
  %.68 = load float, float* %.67
  %.69 = fmul float %.65, %.68
  %.70 = load float*, float** %.5
  %.71 = getelementptr inbounds float, float* %.70, i32 1
  %.72 = load float, float* %.71
  %.73 = load float*, float** %.17
  %.74 = getelementptr inbounds float, float* %.73, i32 1
  %.75 = load float, float* %.74
  %.76 = fmul float %.72, %.75
  %.77 = fadd float %.69, %.76
  %.78 = load float*, float** %.5
  %.79 = getelementptr inbounds float, float* %.78, i32 2
  %.80 = load float, float* %.79
  %.81 = load float*, float** %.20
  %.82 = getelementptr inbounds float, float* %.81, i32 1
  %.83 = load float, float* %.82
  %.84 = fmul float %.80, %.83
  %.85 = fadd float %.77, %.84
  %.86 = load float*, float** %.23
  %.87 = getelementptr inbounds float, float* %.86, i32 1
  store float %.85, float* %.87
  %.89 = load float*, float** %.5
  %.90 = getelementptr inbounds float, float* %.89, i32 0
  %.91 = load float, float* %.90
  %.92 = load float*, float** %.14
  %.93 = getelementptr inbounds float, float* %.92, i32 2
  %.94 = load float, float* %.93
  %.95 = fmul float %.91, %.94
  %.96 = load float*, float** %.5
  %.97 = getelementptr inbounds float, float* %.96, i32 1
  %.98 = load float, float* %.97
  %.99 = load float*, float** %.17
  %.100 = getelementptr inbounds float, float* %.99, i32 2
  %.101 = load float, float* %.100
  %.102 = fmul float %.98, %.101
  %.103 = fadd float %.95, %.102
  %.104 = load float*, float** %.5
  %.105 = getelementptr inbounds float, float* %.104, i32 2
  %.106 = load float, float* %.105
  %.107 = load float*, float** %.20
  %.108 = getelementptr inbounds float, float* %.107, i32 2
  %.109 = load float, float* %.108
  %.110 = fmul float %.106, %.109
  %.111 = fadd float %.103, %.110
  %.112 = load float*, float** %.23
  %.113 = getelementptr inbounds float, float* %.112, i32 2
  store float %.111, float* %.113
  %.115 = load float*, float** %.8
  %.116 = getelementptr inbounds float, float* %.115, i32 0
  %.117 = load float, float* %.116
  %.118 = load float*, float** %.14
  %.119 = getelementptr inbounds float, float* %.118, i32 0
  %.120 = load float, float* %.119
  %.121 = fmul float %.117, %.120
  %.122 = load float*, float** %.8
  %.123 = getelementptr inbounds float, float* %.122, i32 1
  %.124 = load float, float* %.123
  %.125 = load float*, float** %.17
  %.126 = getelementptr inbounds float, float* %.125, i32 0
  %.127 = load float, float* %.126
  %.128 = fmul float %.124, %.127
  %.129 = fadd float %.121, %.128
  %.130 = load float*, float** %.8
  %.131 = getelementptr inbounds float, float* %.130, i32 2
  %.132 = load float, float* %.131
  %.133 = load float*, float** %.20
  %.134 = getelementptr inbounds float, float* %.133, i32 0
  %.135 = load float, float* %.134
  %.136 = fmul float %.132, %.135
  %.137 = fadd float %.129, %.136
  %.138 = load float*, float** %.26
  %.139 = getelementptr inbounds float, float* %.138, i32 0
  store float %.137, float* %.139
  %.141 = load float*, float** %.8
  %.142 = getelementptr inbounds float, float* %.141, i32 0
  %.143 = load float, float* %.142
  %.144 = load float*, float** %.14
  %.145 = getelementptr inbounds float, float* %.144, i32 1
  %.146 = load float, float* %.145
  %.147 = fmul float %.143, %.146
  %.148 = load float*, float** %.8
  %.149 = getelementptr inbounds float, float* %.148, i32 1
  %.150 = load float, float* %.149
  %.151 = load float*, float** %.17
  %.152 = getelementptr inbounds float, float* %.151, i32 1
  %.153 = load float, float* %.152
  %.154 = fmul float %.150, %.153
  %.155 = fadd float %.147, %.154
  %.156 = load float*, float** %.8
  %.157 = getelementptr inbounds float, float* %.156, i32 2
  %.158 = load float, float* %.157
  %.159 = load float*, float** %.20
  %.160 = getelementptr inbounds float, float* %.159, i32 1
  %.161 = load float, float* %.160
  %.162 = fmul float %.158, %.161
  %.163 = fadd float %.155, %.162
  %.164 = load float*, float** %.26
  %.165 = getelementptr inbounds float, float* %.164, i32 1
  store float %.163, float* %.165
  %.167 = load float*, float** %.8
  %.168 = getelementptr inbounds float, float* %.167, i32 0
  %.169 = load float, float* %.168
  %.170 = load float*, float** %.14
  %.171 = getelementptr inbounds float, float* %.170, i32 2
  %.172 = load float, float* %.171
  %.173 = fmul float %.169, %.172
  %.174 = load float*, float** %.8
  %.175 = getelementptr inbounds float, float* %.174, i32 1
  %.176 = load float, float* %.175
  %.177 = load float*, float** %.17
  %.178 = getelementptr inbounds float, float* %.177, i32 2
  %.179 = load float, float* %.178
  %.180 = fmul float %.176, %.179
  %.181 = fadd float %.173, %.180
  %.182 = load float*, float** %.8
  %.183 = getelementptr inbounds float, float* %.182, i32 2
  %.184 = load float, float* %.183
  %.185 = load float*, float** %.20
  %.186 = getelementptr inbounds float, float* %.185, i32 2
  %.187 = load float, float* %.186
  %.188 = fmul float %.184, %.187
  %.189 = fadd float %.181, %.188
  %.190 = load float*, float** %.26
  %.191 = getelementptr inbounds float, float* %.190, i32 2
  store float %.189, float* %.191
  %.193 = load float*, float** %.11
  %.194 = getelementptr inbounds float, float* %.193, i32 0
  %.195 = load float, float* %.194
  %.196 = load float*, float** %.14
  %.197 = getelementptr inbounds float, float* %.196, i32 0
  %.198 = load float, float* %.197
  %.199 = fmul float %.195, %.198
  %.200 = load float*, float** %.11
  %.201 = getelementptr inbounds float, float* %.200, i32 1
  %.202 = load float, float* %.201
  %.203 = load float*, float** %.17
  %.204 = getelementptr inbounds float, float* %.203, i32 0
  %.205 = load float, float* %.204
  %.206 = fmul float %.202, %.205
  %.207 = fadd float %.199, %.206
  %.208 = load float*, float** %.11
  %.209 = getelementptr inbounds float, float* %.208, i32 2
  %.210 = load float, float* %.209
  %.211 = load float*, float** %.20
  %.212 = getelementptr inbounds float, float* %.211, i32 0
  %.213 = load float, float* %.212
  %.214 = fmul float %.210, %.213
  %.215 = fadd float %.207, %.214
  %.216 = load float*, float** %.29
  %.217 = getelementptr inbounds float, float* %.216, i32 0
  store float %.215, float* %.217
  %.219 = load float*, float** %.11
  %.220 = getelementptr inbounds float, float* %.219, i32 0
  %.221 = load float, float* %.220
  %.222 = load float*, float** %.14
  %.223 = getelementptr inbounds float, float* %.222, i32 1
  %.224 = load float, float* %.223
  %.225 = fmul float %.221, %.224
  %.226 = load float*, float** %.11
  %.227 = getelementptr inbounds float, float* %.226, i32 1
  %.228 = load float, float* %.227
  %.229 = load float*, float** %.17
  %.230 = getelementptr inbounds float, float* %.229, i32 1
  %.231 = load float, float* %.230
  %.232 = fmul float %.228, %.231
  %.233 = fadd float %.225, %.232
  %.234 = load float*, float** %.11
  %.235 = getelementptr inbounds float, float* %.234, i32 2
  %.236 = load float, float* %.235
  %.237 = load float*, float** %.20
  %.238 = getelementptr inbounds float, float* %.237, i32 1
  %.239 = load float, float* %.238
  %.240 = fmul float %.236, %.239
  %.241 = fadd float %.233, %.240
  %.242 = load float*, float** %.29
  %.243 = getelementptr inbounds float, float* %.242, i32 1
  store float %.241, float* %.243
  %.245 = load float*, float** %.11
  %.246 = getelementptr inbounds float, float* %.245, i32 0
  %.247 = load float, float* %.246
  %.248 = load float*, float** %.14
  %.249 = getelementptr inbounds float, float* %.248, i32 2
  %.250 = load float, float* %.249
  %.251 = fmul float %.247, %.250
  %.252 = load float*, float** %.11
  %.253 = getelementptr inbounds float, float* %.252, i32 1
  %.254 = load float, float* %.253
  %.255 = load float*, float** %.17
  %.256 = getelementptr inbounds float, float* %.255, i32 2
  %.257 = load float, float* %.256
  %.258 = fmul float %.254, %.257
  %.259 = fadd float %.251, %.258
  %.260 = load float*, float** %.11
  %.261 = getelementptr inbounds float, float* %.260, i32 2
  %.262 = load float, float* %.261
  %.263 = load float*, float** %.20
  %.264 = getelementptr inbounds float, float* %.263, i32 2
  %.265 = load float, float* %.264
  %.266 = fmul float %.262, %.265
  %.267 = fadd float %.259, %.266
  %.268 = load float*, float** %.29
  %.269 = getelementptr inbounds float, float* %.268, i32 2
  store float %.267, float* %.269
  ret i32 0 
}
define i32 @main(){
.273:
  %.343 = alloca i32
  %.288 = alloca i32
  %.287 = alloca [3 x float]
  %.286 = alloca [3 x float]
  %.285 = alloca [6 x float]
  %.283 = alloca [3 x float]
  %.282 = alloca [3 x float]
  %.281 = alloca [3 x float]
  %.280 = alloca [3 x float]
  %.279 = alloca [3 x float]
  %.278 = alloca [3 x float]
  store i32 3, i32* @.g.N
  store i32 3, i32* @.g.M
  store i32 3, i32* @.g.L
  store i32 0, i32* %.288
  br label %.290wc32 
.290wc32:
  %.294 = load i32, i32* %.288
  %.295 = load i32, i32* @.g.M
  %.296 = icmp slt i32 %.294, %.295
  br i1 %.296, label %.291wloop.32.41, label %.292wn41
.291wloop.32.41:
  %.298 = load i32, i32* %.288
  %.299 = load i32, i32* %.288
  %.300 = getelementptr inbounds [3 x float], [3 x float]* %.278, i32 0, i32 %.299
  %.301 = sitofp i32 %.298 to float
  store float %.301, float* %.300
  %.303 = load i32, i32* %.288
  %.304 = load i32, i32* %.288
  %.305 = getelementptr inbounds [3 x float], [3 x float]* %.279, i32 0, i32 %.304
  %.306 = sitofp i32 %.303 to float
  store float %.306, float* %.305
  %.308 = load i32, i32* %.288
  %.309 = load i32, i32* %.288
  %.310 = getelementptr inbounds [3 x float], [3 x float]* %.280, i32 0, i32 %.309
  %.311 = sitofp i32 %.308 to float
  store float %.311, float* %.310
  %.313 = load i32, i32* %.288
  %.314 = load i32, i32* %.288
  %.315 = getelementptr inbounds [3 x float], [3 x float]* %.281, i32 0, i32 %.314
  %.316 = sitofp i32 %.313 to float
  store float %.316, float* %.315
  %.318 = load i32, i32* %.288
  %.319 = load i32, i32* %.288
  %.320 = getelementptr inbounds [3 x float], [3 x float]* %.282, i32 0, i32 %.319
  %.321 = sitofp i32 %.318 to float
  store float %.321, float* %.320
  %.323 = load i32, i32* %.288
  %.324 = load i32, i32* %.288
  %.325 = getelementptr inbounds [3 x float], [3 x float]* %.283, i32 0, i32 %.324
  %.326 = sitofp i32 %.323 to float
  store float %.326, float* %.325
  %.328 = load i32, i32* %.288
  %.329 = add i32 %.328, 1
  store i32 %.329, i32* %.288
  br label %.290wc32 
.292wn41:
  %.332 = getelementptr inbounds [3 x float], [3 x float]* %.278, i32 0, i32 0
  %.333 = getelementptr inbounds [3 x float], [3 x float]* %.279, i32 0, i32 0
  %.334 = getelementptr inbounds [3 x float], [3 x float]* %.280, i32 0, i32 0
  %.335 = getelementptr inbounds [3 x float], [3 x float]* %.281, i32 0, i32 0
  %.336 = getelementptr inbounds [3 x float], [3 x float]* %.282, i32 0, i32 0
  %.337 = getelementptr inbounds [3 x float], [3 x float]* %.283, i32 0, i32 0
  %.338 = getelementptr inbounds [6 x float], [6 x float]* %.285, i32 0, i32 0
  %.339 = getelementptr inbounds [3 x float], [3 x float]* %.286, i32 0, i32 0
  %.340 = getelementptr inbounds [3 x float], [3 x float]* %.287, i32 0, i32 0
  %.341at42 = call i32 @mul(float* %.332, float* %.333, float* %.334, float* %.335, float* %.336, float* %.337, float* %.338, float* %.339, float* %.340)
  store i32 %.341at42, i32* %.288
  br label %.344wc44 
.344wc44:
  %.348 = load i32, i32* %.288
  %.349 = load i32, i32* @.g.N
  %.350 = icmp slt i32 %.348, %.349
  br i1 %.350, label %.345wloop.44.49, label %.346wn49
.345wloop.44.49:
  %.352 = load i32, i32* %.288
  %.353 = getelementptr inbounds [6 x float], [6 x float]* %.285, i32 0, i32 %.352
  %.354 = load float, float* %.353
  %.355 = fptosi float %.354 to i32
  store i32 %.355, i32* %.343
  %.357 = load i32, i32* %.343
  call void @putint(i32 %.357)
  %.360 = load i32, i32* %.288
  %.361 = add i32 %.360, 1
  store i32 %.361, i32* %.288
  br label %.344wc44 
.346wn49:
  store i32 10, i32* %.343
  store i32 0, i32* %.288
  %.367 = load i32, i32* %.343
  call void @putch(i32 %.367)
  br label %.370wc53 
.370wc53:
  %.374 = load i32, i32* %.288
  %.375 = load i32, i32* @.g.N
  %.376 = icmp slt i32 %.374, %.375
  br i1 %.376, label %.371wloop.53.59, label %.372wn59
.371wloop.53.59:
  %.378 = load i32, i32* %.288
  %.379 = getelementptr inbounds [3 x float], [3 x float]* %.286, i32 0, i32 %.378
  %.380 = load float, float* %.379
  %.381 = fptosi float %.380 to i32
  store i32 %.381, i32* %.343
  %.383 = load i32, i32* %.343
  call void @putint(i32 %.383)
  %.385 = load i32, i32* %.288
  %.386 = add i32 %.385, 1
  store i32 %.386, i32* %.288
  br label %.370wc53 
.372wn59:
  store i32 10, i32* %.343
  store i32 0, i32* %.288
  %.391 = load i32, i32* %.343
  call void @putch(i32 %.391)
  br label %.393wc63 
.393wc63:
  %.397 = load i32, i32* %.288
  %.398 = load i32, i32* @.g.N
  %.399 = icmp slt i32 %.397, %.398
  br i1 %.399, label %.394wloop.63.69, label %.395wn69
.394wloop.63.69:
  %.401 = load i32, i32* %.288
  %.402 = getelementptr inbounds [3 x float], [3 x float]* %.287, i32 0, i32 %.401
  %.403 = load float, float* %.402
  %.404 = fptosi float %.403 to i32
  store i32 %.404, i32* %.343
  %.406 = load i32, i32* %.343
  call void @putint(i32 %.406)
  %.408 = load i32, i32* %.288
  %.409 = add i32 %.408, 1
  store i32 %.409, i32* %.288
  br label %.393wc63 
.395wn69:
  store i32 10, i32* %.343
  %.413 = load i32, i32* %.343
  call void @putch(i32 %.413)
  ret i32 0 
}
