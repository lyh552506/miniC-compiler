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

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nofree nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nofree norecurse nounwind uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree nounwind }
attributes #6 = { nounwind }
attributes #7 = { cold }
@.g.w = global i32 512
@.g.h = global i32 270
@.g.imgIn = global [512 x [270 x float]] zeroinitializer
@.g.imgOut = global [512 x [270 x float]] zeroinitializer
@.g.my_y1 = global [512 x [270 x float]] zeroinitializer
@.g.my_y2 = global [512 x [270 x float]] zeroinitializer
@.g.alpha = global float 0x3fd0000000000000
define float @newExp(float %.13){
.11:
  %x_0 = alloca float
  store float %.13, float* %x_0
  %.16 = load float, float* %x_0
  %.18 = sitofp i32 256 to float
  %.19 = fdiv float %.16, %.18
  %.20 = fadd float 0x3ff0000000000000, %.19
  store float %.20, float* %x_0
  %.22 = load float, float* %x_0
  %.23 = load float, float* %x_0
  %.24 = fmul float %.22, %.23
  store float %.24, float* %x_0
  %.26 = load float, float* %x_0
  %.27 = load float, float* %x_0
  %.28 = fmul float %.26, %.27
  store float %.28, float* %x_0
  %.30 = load float, float* %x_0
  %.31 = load float, float* %x_0
  %.32 = fmul float %.30, %.31
  store float %.32, float* %x_0
  %.34 = load float, float* %x_0
  %.35 = load float, float* %x_0
  %.36 = fmul float %.34, %.35
  store float %.36, float* %x_0
  %.38 = load float, float* %x_0
  %.39 = load float, float* %x_0
  %.40 = fmul float %.38, %.39
  store float %.40, float* %x_0
  %.42 = load float, float* %x_0
  %.43 = load float, float* %x_0
  %.44 = fmul float %.42, %.43
  store float %.44, float* %x_0
  %.46 = load float, float* %x_0
  %.47 = load float, float* %x_0
  %.48 = fmul float %.46, %.47
  store float %.48, float* %x_0
  %.50 = load float, float* %x_0
  %.51 = load float, float* %x_0
  %.52 = fmul float %.50, %.51
  store float %.52, float* %x_0
  %.54 = load float, float* %x_0
  ret float %.54 
}
define float @newPow(float %.59, i32 %.62){
.57:
  %n_0 = alloca i32
  %num_0 = alloca float
  store float %.59, float* %num_0
  store i32 %.62, i32* %n_0
  %.66 = load i32, i32* %n_0
  %.68 = icmp slt i32 %.66, 0
  br i1 %.68, label %.64, label %.65
.64:
  %.70 = load float, float* %num_0
  %.71 = load i32, i32* %n_0
  %.72 = sub i32 0, %.71
  %.73at26 = call float @newPow(float %.70, i32 %.72)
  %.74 = fdiv float 0x3ff0000000000000, %.73at26
  ret float %.74 
.65:
  %.78 = load i32, i32* %n_0
  %.79 = icmp eq i32 %.78, 0
  br i1 %.79, label %.76, label %.77
.76:
  ret float 0x3ff0000000000000 
.77:
  %.84 = load i32, i32* %n_0
  %.85 = icmp sgt i32 %.84, 0
  br i1 %.85, label %.82, label %.83
.82:
  %.87 = load float, float* %num_0
  %.88 = load float, float* %num_0
  %.89 = load i32, i32* %n_0
  %.91 = sub i32 %.89, 1
  %.92at30 = call float @newPow(float %.88, i32 %.91)
  %.93 = fmul float %.87, %.92at30
  ret float %.93 
.83:
  br label %.95 
.95:
  br label %.97 
.97:
  ret float undef 
}
define void @kernel_deriche(i32 %.104, i32 %.107, float %.110, [270 x float]* %.113, [270 x float]* %.116, [270 x float]* %.119, [270 x float]* %.122){
.102:
  %c2_0 = alloca float
  %c1_0 = alloca float
  %b2_0 = alloca float
  %b1_0 = alloca float
  %a8_0 = alloca float
  %a7_0 = alloca float
  %a6_0 = alloca float
  %a5_0 = alloca float
  %a4_0 = alloca float
  %a3_0 = alloca float
  %a2_0 = alloca float
  %a1_0 = alloca float
  %k_0 = alloca float
  %yp2_0 = alloca float
  %yp1_0 = alloca float
  %tp2_0 = alloca float
  %tp1_0 = alloca float
  %xp2_0 = alloca float
  %xp1_0 = alloca float
  %ym2_0 = alloca float
  %ym1_0 = alloca float
  %tm1_0 = alloca float
  %xm1_0 = alloca float
  %j_0 = alloca i32
  %i_0 = alloca i32
  %y2_0 = alloca [270 x float]*
  %y1_0 = alloca [270 x float]*
  %imgOut_0 = alloca [270 x float]*
  %imgIn_0 = alloca [270 x float]*
  %alpha_0 = alloca float
  %h_0 = alloca i32
  %w_0 = alloca i32
  store i32 %.104, i32* %w_0
  store i32 %.107, i32* %h_0
  store float %.110, float* %alpha_0
  store [270 x float]* %.113, [270 x float]** %imgIn_0
  store [270 x float]* %.116, [270 x float]** %imgOut_0
  store [270 x float]* %.119, [270 x float]** %y1_0
  store [270 x float]* %.122, [270 x float]** %y2_0
  %.149 = load float, float* %alpha_0
  %.151 = fsub float 0x0, %.149
  %.152at46 = call float @newExp(float %.151)
  %.153 = fsub float 0x3ff0000000000000, %.152at46
  %.154 = load float, float* %alpha_0
  %.155 = fsub float 0x0, %.154
  %.156at46 = call float @newExp(float %.155)
  %.157 = fsub float 0x3ff0000000000000, %.156at46
  %.158 = fmul float %.153, %.157
  %.160 = load float, float* %alpha_0
  %.161 = fmul float 0x4000000000000000, %.160
  %.162 = load float, float* %alpha_0
  %.163 = fsub float 0x0, %.162
  %.164at47 = call float @newExp(float %.163)
  %.165 = fmul float %.161, %.164at47
  %.166 = fadd float 0x3ff0000000000000, %.165
  %.167 = load float, float* %alpha_0
  %.168 = fmul float 0x4000000000000000, %.167
  %.169at47 = call float @newExp(float %.168)
  %.170 = fsub float %.166, %.169at47
  %.171 = fdiv float %.158, %.170
  store float %.171, float* %k_0
  %.173 = load float, float* %k_0
  store float %.173, float* %a1_0
  %.175 = load float, float* %k_0
  store float %.175, float* %a5_0
  %.177 = load float, float* %k_0
  %.178 = load float, float* %alpha_0
  %.179 = fsub float 0x0, %.178
  %.180at50 = call float @newExp(float %.179)
  %.181 = fmul float %.177, %.180at50
  %.182 = load float, float* %alpha_0
  %.183 = fsub float %.182, 0x3ff0000000000000
  %.184 = fmul float %.181, %.183
  store float %.184, float* %a6_0
  %.186 = load float, float* %a6_0
  store float %.186, float* %a2_0
  %.188 = load float, float* %k_0
  %.189 = load float, float* %alpha_0
  %.190 = fsub float 0x0, %.189
  %.191at52 = call float @newExp(float %.190)
  %.192 = fmul float %.188, %.191at52
  %.193 = load float, float* %alpha_0
  %.194 = fadd float %.193, 0x3ff0000000000000
  %.195 = fmul float %.192, %.194
  store float %.195, float* %a7_0
  %.197 = load float, float* %a7_0
  store float %.197, float* %a3_0
  %.199 = load float, float* %k_0
  %.200 = fsub float 0x0, %.199
  %.202 = load float, float* %alpha_0
  %.203 = fmul float 0xc000000000000000, %.202
  %.204at54 = call float @newExp(float %.203)
  %.205 = fmul float %.200, %.204at54
  store float %.205, float* %a8_0
  %.207 = load float, float* %a8_0
  store float %.207, float* %a4_0
  %.209 = load float, float* %alpha_0
  %.210 = fsub float 0x0, %.209
  %.211 = fptosi float %.210 to i32
  %.212at56 = call float @newPow(float 0x4000000000000000, i32 %.211)
  store float %.212at56, float* %b1_0
  %.214 = load float, float* %alpha_0
  %.215 = fmul float 0xc000000000000000, %.214
  %.216at57 = call float @newExp(float %.215)
  %.217 = fsub float 0x0, %.216at57
  store float %.217, float* %b2_0
  %.219 = sitofp i32 1 to float
  store float %.219, float* %c1_0
  %.221 = sitofp i32 1 to float
  store float %.221, float* %c2_0
  store i32 0, i32* %i_0
  br label %.224wc61 
.224wc61:
  %.228 = load i32, i32* %i_0
  %.229 = load i32, i32* %w_0
  %.230 = icmp slt i32 %.228, %.229
  br i1 %.230, label %.225wloop.61.76, label %.226wn76
.225wloop.61.76:
  store float 0x0, float* %ym1_0
  store float 0x0, float* %ym2_0
  store float 0x0, float* %xm1_0
  store i32 0, i32* %j_0
  br label %.236wc67 
.226wn76:
  store i32 0, i32* %i_0
  br label %.291wc78 
.236wc67:
  %.240 = load i32, i32* %j_0
  %.241 = load i32, i32* %h_0
  %.242 = icmp slt i32 %.240, %.241
  br i1 %.242, label %.237wloop.67.74, label %.238wn74
.237wloop.67.74:
  %.244 = load float, float* %a1_0
  %.245 = load i32, i32* %i_0
  %.246 = load i32, i32* %j_0
  %.247 = load [270 x float]*, [270 x float]** %imgIn_0
  %.248 = getelementptr inbounds [270 x float], [270 x float]* %.247, i32 %.245, i32 %.246
  %.249 = load float, float* %.248
  %.250 = fmul float %.244, %.249
  %.251 = load float, float* %a2_0
  %.252 = load float, float* %xm1_0
  %.253 = fmul float %.251, %.252
  %.254 = fadd float %.250, %.253
  %.255 = load float, float* %b1_0
  %.256 = load float, float* %ym1_0
  %.257 = fmul float %.255, %.256
  %.258 = fadd float %.254, %.257
  %.259 = load float, float* %b2_0
  %.260 = load float, float* %ym2_0
  %.261 = fmul float %.259, %.260
  %.262 = fadd float %.258, %.261
  %.263 = load i32, i32* %i_0
  %.264 = load i32, i32* %j_0
  %.265 = load [270 x float]*, [270 x float]** %y1_0
  %.266 = getelementptr inbounds [270 x float], [270 x float]* %.265, i32 %.263, i32 %.264
  store float %.262, float* %.266
  %.268 = load i32, i32* %i_0
  %.269 = load i32, i32* %j_0
  %.270 = load [270 x float]*, [270 x float]** %imgIn_0
  %.271 = getelementptr inbounds [270 x float], [270 x float]* %.270, i32 %.268, i32 %.269
  %.272 = load float, float* %.271
  store float %.272, float* %xm1_0
  %.274 = load float, float* %ym1_0
  store float %.274, float* %ym2_0
  %.276 = load i32, i32* %i_0
  %.277 = load i32, i32* %j_0
  %.278 = load [270 x float]*, [270 x float]** %y1_0
  %.279 = getelementptr inbounds [270 x float], [270 x float]* %.278, i32 %.276, i32 %.277
  %.280 = load float, float* %.279
  store float %.280, float* %ym1_0
  %.282 = load i32, i32* %j_0
  %.283 = add i32 %.282, 1
  store i32 %.283, i32* %j_0
  br label %.236wc67 
.238wn74:
  %.286 = load i32, i32* %i_0
  %.287 = add i32 %.286, 1
  store i32 %.287, i32* %i_0
  br label %.224wc61 
.291wc78:
  %.295 = load i32, i32* %i_0
  %.296 = load i32, i32* %w_0
  %.297 = icmp slt i32 %.295, %.296
  br i1 %.297, label %.292wloop.78.95, label %.293wn95
.292wloop.78.95:
  store float 0x0, float* %yp1_0
  store float 0x0, float* %yp2_0
  store float 0x0, float* %xp1_0
  store float 0x0, float* %xp2_0
  %.303 = load i32, i32* %h_0
  %.304 = sub i32 %.303, 1
  store i32 %.304, i32* %j_0
  br label %.306wc85 
.293wn95:
  store i32 0, i32* %i_0
  br label %.358wc97 
.306wc85:
  %.310 = load i32, i32* %j_0
  %.311 = icmp sge i32 %.310, 0
  br i1 %.311, label %.307wloop.85.93, label %.308wn93
.307wloop.85.93:
  %.313 = load float, float* %a3_0
  %.314 = load float, float* %xp1_0
  %.315 = fmul float %.313, %.314
  %.316 = load float, float* %a4_0
  %.317 = load float, float* %xp2_0
  %.318 = fmul float %.316, %.317
  %.319 = fadd float %.315, %.318
  %.320 = load float, float* %b1_0
  %.321 = load float, float* %yp1_0
  %.322 = fmul float %.320, %.321
  %.323 = fadd float %.319, %.322
  %.324 = load float, float* %b2_0
  %.325 = load float, float* %yp2_0
  %.326 = fmul float %.324, %.325
  %.327 = fadd float %.323, %.326
  %.328 = load i32, i32* %i_0
  %.329 = load i32, i32* %j_0
  %.330 = load [270 x float]*, [270 x float]** %y2_0
  %.331 = getelementptr inbounds [270 x float], [270 x float]* %.330, i32 %.328, i32 %.329
  store float %.327, float* %.331
  %.333 = load float, float* %xp1_0
  store float %.333, float* %xp2_0
  %.335 = load i32, i32* %i_0
  %.336 = load i32, i32* %j_0
  %.337 = load [270 x float]*, [270 x float]** %imgIn_0
  %.338 = getelementptr inbounds [270 x float], [270 x float]* %.337, i32 %.335, i32 %.336
  %.339 = load float, float* %.338
  store float %.339, float* %xp1_0
  %.341 = load float, float* %yp1_0
  store float %.341, float* %yp2_0
  %.343 = load i32, i32* %i_0
  %.344 = load i32, i32* %j_0
  %.345 = load [270 x float]*, [270 x float]** %y2_0
  %.346 = getelementptr inbounds [270 x float], [270 x float]* %.345, i32 %.343, i32 %.344
  %.347 = load float, float* %.346
  store float %.347, float* %yp1_0
  %.349 = load i32, i32* %j_0
  %.350 = sub i32 %.349, 1
  store i32 %.350, i32* %j_0
  br label %.306wc85 
.308wn93:
  %.353 = load i32, i32* %i_0
  %.354 = add i32 %.353, 1
  store i32 %.354, i32* %i_0
  br label %.291wc78 
.358wc97:
  %.362 = load i32, i32* %i_0
  %.363 = load i32, i32* %w_0
  %.364 = icmp slt i32 %.362, %.363
  br i1 %.364, label %.359wloop.97.105, label %.360wn105
.359wloop.97.105:
  store i32 0, i32* %j_0
  br label %.367wc99 
.360wn105:
  store i32 0, i32* %j_0
  br label %.402wc107 
.367wc99:
  %.371 = load i32, i32* %j_0
  %.372 = load i32, i32* %h_0
  %.373 = icmp slt i32 %.371, %.372
  br i1 %.373, label %.368wloop.99.103, label %.369wn103
.368wloop.99.103:
  %.375 = load float, float* %c1_0
  %.376 = load i32, i32* %i_0
  %.377 = load i32, i32* %j_0
  %.378 = load [270 x float]*, [270 x float]** %y1_0
  %.379 = getelementptr inbounds [270 x float], [270 x float]* %.378, i32 %.376, i32 %.377
  %.380 = load float, float* %.379
  %.381 = load i32, i32* %i_0
  %.382 = load i32, i32* %j_0
  %.383 = load [270 x float]*, [270 x float]** %y2_0
  %.384 = getelementptr inbounds [270 x float], [270 x float]* %.383, i32 %.381, i32 %.382
  %.385 = load float, float* %.384
  %.386 = fadd float %.380, %.385
  %.387 = fmul float %.375, %.386
  %.388 = load i32, i32* %i_0
  %.389 = load i32, i32* %j_0
  %.390 = load [270 x float]*, [270 x float]** %imgOut_0
  %.391 = getelementptr inbounds [270 x float], [270 x float]* %.390, i32 %.388, i32 %.389
  store float %.387, float* %.391
  %.393 = load i32, i32* %j_0
  %.394 = add i32 %.393, 1
  store i32 %.394, i32* %j_0
  br label %.367wc99 
.369wn103:
  %.397 = load i32, i32* %i_0
  %.398 = add i32 %.397, 1
  store i32 %.398, i32* %i_0
  br label %.358wc97 
.402wc107:
  %.406 = load i32, i32* %j_0
  %.407 = load i32, i32* %h_0
  %.408 = icmp slt i32 %.406, %.407
  br i1 %.408, label %.403wloop.107.122, label %.404wn122
.403wloop.107.122:
  store float 0x0, float* %tm1_0
  store float 0x0, float* %ym1_0
  store float 0x0, float* %ym2_0
  store i32 0, i32* %i_0
  br label %.414wc113 
.404wn122:
  store i32 0, i32* %j_0
  br label %.469wc124 
.414wc113:
  %.418 = load i32, i32* %i_0
  %.419 = load i32, i32* %w_0
  %.420 = icmp slt i32 %.418, %.419
  br i1 %.420, label %.415wloop.113.120, label %.416wn120
.415wloop.113.120:
  %.422 = load float, float* %a5_0
  %.423 = load i32, i32* %i_0
  %.424 = load i32, i32* %j_0
  %.425 = load [270 x float]*, [270 x float]** %imgOut_0
  %.426 = getelementptr inbounds [270 x float], [270 x float]* %.425, i32 %.423, i32 %.424
  %.427 = load float, float* %.426
  %.428 = fmul float %.422, %.427
  %.429 = load float, float* %a6_0
  %.430 = load float, float* %tm1_0
  %.431 = fmul float %.429, %.430
  %.432 = fadd float %.428, %.431
  %.433 = load float, float* %b1_0
  %.434 = load float, float* %ym1_0
  %.435 = fmul float %.433, %.434
  %.436 = fadd float %.432, %.435
  %.437 = load float, float* %b2_0
  %.438 = load float, float* %ym2_0
  %.439 = fmul float %.437, %.438
  %.440 = fadd float %.436, %.439
  %.441 = load i32, i32* %i_0
  %.442 = load i32, i32* %j_0
  %.443 = load [270 x float]*, [270 x float]** %y1_0
  %.444 = getelementptr inbounds [270 x float], [270 x float]* %.443, i32 %.441, i32 %.442
  store float %.440, float* %.444
  %.446 = load i32, i32* %i_0
  %.447 = load i32, i32* %j_0
  %.448 = load [270 x float]*, [270 x float]** %imgOut_0
  %.449 = getelementptr inbounds [270 x float], [270 x float]* %.448, i32 %.446, i32 %.447
  %.450 = load float, float* %.449
  store float %.450, float* %tm1_0
  %.452 = load float, float* %ym1_0
  store float %.452, float* %ym2_0
  %.454 = load i32, i32* %i_0
  %.455 = load i32, i32* %j_0
  %.456 = load [270 x float]*, [270 x float]** %y1_0
  %.457 = getelementptr inbounds [270 x float], [270 x float]* %.456, i32 %.454, i32 %.455
  %.458 = load float, float* %.457
  store float %.458, float* %ym1_0
  %.460 = load i32, i32* %i_0
  %.461 = add i32 %.460, 1
  store i32 %.461, i32* %i_0
  br label %.414wc113 
.416wn120:
  %.464 = load i32, i32* %j_0
  %.465 = add i32 %.464, 1
  store i32 %.465, i32* %j_0
  br label %.402wc107 
.469wc124:
  %.473 = load i32, i32* %j_0
  %.474 = load i32, i32* %h_0
  %.475 = icmp slt i32 %.473, %.474
  br i1 %.475, label %.470wloop.124.141, label %.471wn141
.470wloop.124.141:
  store float 0x0, float* %tp1_0
  store float 0x0, float* %tp2_0
  store float 0x0, float* %yp1_0
  store float 0x0, float* %yp2_0
  %.481 = load i32, i32* %w_0
  %.482 = sub i32 %.481, 1
  store i32 %.482, i32* %i_0
  br label %.484wc131 
.471wn141:
  store i32 0, i32* %i_0
  br label %.536wc143 
.484wc131:
  %.488 = load i32, i32* %i_0
  %.489 = icmp sge i32 %.488, 0
  br i1 %.489, label %.485wloop.131.139, label %.486wn139
.485wloop.131.139:
  %.491 = load float, float* %a7_0
  %.492 = load float, float* %tp1_0
  %.493 = fmul float %.491, %.492
  %.494 = load float, float* %a8_0
  %.495 = load float, float* %tp2_0
  %.496 = fmul float %.494, %.495
  %.497 = fadd float %.493, %.496
  %.498 = load float, float* %b1_0
  %.499 = load float, float* %yp1_0
  %.500 = fmul float %.498, %.499
  %.501 = fadd float %.497, %.500
  %.502 = load float, float* %b2_0
  %.503 = load float, float* %yp2_0
  %.504 = fmul float %.502, %.503
  %.505 = fadd float %.501, %.504
  %.506 = load i32, i32* %i_0
  %.507 = load i32, i32* %j_0
  %.508 = load [270 x float]*, [270 x float]** %y2_0
  %.509 = getelementptr inbounds [270 x float], [270 x float]* %.508, i32 %.506, i32 %.507
  store float %.505, float* %.509
  %.511 = load float, float* %tp1_0
  store float %.511, float* %tp2_0
  %.513 = load i32, i32* %i_0
  %.514 = load i32, i32* %j_0
  %.515 = load [270 x float]*, [270 x float]** %imgOut_0
  %.516 = getelementptr inbounds [270 x float], [270 x float]* %.515, i32 %.513, i32 %.514
  %.517 = load float, float* %.516
  store float %.517, float* %tp1_0
  %.519 = load float, float* %yp1_0
  store float %.519, float* %yp2_0
  %.521 = load i32, i32* %i_0
  %.522 = load i32, i32* %j_0
  %.523 = load [270 x float]*, [270 x float]** %y2_0
  %.524 = getelementptr inbounds [270 x float], [270 x float]* %.523, i32 %.521, i32 %.522
  %.525 = load float, float* %.524
  store float %.525, float* %yp1_0
  %.527 = load i32, i32* %i_0
  %.528 = sub i32 %.527, 1
  store i32 %.528, i32* %i_0
  br label %.484wc131 
.486wn139:
  %.531 = load i32, i32* %j_0
  %.532 = add i32 %.531, 1
  store i32 %.532, i32* %j_0
  br label %.469wc124 
.536wc143:
  %.540 = load i32, i32* %i_0
  %.541 = load i32, i32* %w_0
  %.542 = icmp slt i32 %.540, %.541
  br i1 %.542, label %.537wloop.143.150, label %.538wn150
.537wloop.143.150:
  store i32 0, i32* %j_0
  br label %.545wc145 
.538wn150:
  ret void
.545wc145:
  %.549 = load i32, i32* %j_0
  %.550 = load i32, i32* %h_0
  %.551 = icmp slt i32 %.549, %.550
  br i1 %.551, label %.546wloop.145.148, label %.547wn148
.546wloop.145.148:
  %.553 = load float, float* %c2_0
  %.554 = load i32, i32* %i_0
  %.555 = load i32, i32* %j_0
  %.556 = load [270 x float]*, [270 x float]** %y1_0
  %.557 = getelementptr inbounds [270 x float], [270 x float]* %.556, i32 %.554, i32 %.555
  %.558 = load float, float* %.557
  %.559 = load i32, i32* %i_0
  %.560 = load i32, i32* %j_0
  %.561 = load [270 x float]*, [270 x float]** %y2_0
  %.562 = getelementptr inbounds [270 x float], [270 x float]* %.561, i32 %.559, i32 %.560
  %.563 = load float, float* %.562
  %.564 = fadd float %.558, %.563
  %.565 = fmul float %.553, %.564
  %.566 = load i32, i32* %i_0
  %.567 = load i32, i32* %j_0
  %.568 = load [270 x float]*, [270 x float]** %imgOut_0
  %.569 = getelementptr inbounds [270 x float], [270 x float]* %.568, i32 %.566, i32 %.567
  store float %.565, float* %.569
  %.571 = load i32, i32* %j_0
  %.572 = add i32 %.571, 1
  store i32 %.572, i32* %j_0
  br label %.545wc145 
.547wn148:
  %.575 = load i32, i32* %i_0
  %.576 = add i32 %.575, 1
  store i32 %.576, i32* %i_0
  br label %.536wc143 
}
define i32 @main(){
.581:
  %.582 = getelementptr inbounds [512 x [270 x float]], [512 x [270 x float]]* @.g.imgIn, i32 0, i32 0
  %.584at155 = call i32 @getfarray([270 x float]* %.582)
  call void @_sysy_starttime(i32 156)
  %.588 = load i32, i32* @.g.w
  %.589 = load i32, i32* @.g.h
  %.590 = load float, float* @.g.alpha
  %.591 = getelementptr inbounds [512 x [270 x float]], [512 x [270 x float]]* @.g.imgIn, i32 0, i32 0
  %.592 = getelementptr inbounds [512 x [270 x float]], [512 x [270 x float]]* @.g.imgOut, i32 0, i32 0
  %.593 = getelementptr inbounds [512 x [270 x float]], [512 x [270 x float]]* @.g.my_y1, i32 0, i32 0
  %.594 = getelementptr inbounds [512 x [270 x float]], [512 x [270 x float]]* @.g.my_y2, i32 0, i32 0
  call void @kernel_deriche(i32 %.588, i32 %.589, float %.590, [270 x float]* %.591, [270 x float]* %.592, [270 x float]* %.593, [270 x float]* %.594)
  call void @_sysy_stoptime(i32 158)
  %.599 = load i32, i32* @.g.w
  %.600 = load i32, i32* @.g.h
  %.601 = mul i32 %.599, %.600
  %.602 = getelementptr inbounds [512 x [270 x float]], [512 x [270 x float]]* @.g.imgOut, i32 0, i32 0
  call void @putfarray(i32 %.601, [270 x float]* %.602)
  ret i32 0 
}
