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
define i32 @func(i32 %.3, i32 %.6, i32 %.9, i32 %.12, i32 %.15, i32 %.18, i32 %.21, i32 %.24, i32 %.27, i32 %.30, i32 %.33, i32 %.36, i32 %.39, i32 %.42, i32 %.45, i32 %.48, i32 %.51, i32 %.54, i32 %.57, i32 %.60, i32 %.63, i32 %.66, i32 %.69, i32 %.72, i32 %.75, i32 %.78, i32 %.81, i32 %.84, i32 %.87, i32 %.90, i32 %.93, i32 %.96, i32 %.99, i32 %.102, i32 %.105, i32 %.108, i32 %.111, i32 %.114, i32 %.117, i32 %.120, i32 %.123, i32 %.126, i32 %.129, i32 %.132, i32 %.135, i32 %.138, i32 %.141, i32 %.144, i32 %.147, i32 %.150, i32 %.153, i32 %.156, i32 %.159, i32 %.162, i32 %.165, i32 %.168, i32 %.171, i32 %.174, i32 %.177, i32 %.180, i32 %.183, i32 %.186, i32 %.189, i32 %.192, i32 %.195, i32 %.198, i32 %.201, i32 %.204, i32 %.207, i32 %.210, i32 %.213, i32 %.216, i32 %.219, i32 %.222, i32 %.225, i32 %.228, i32 %.231, i32 %.234, i32 %.237, i32 %.240, i32 %.243, i32 %.246, i32 %.249, i32 %.252, i32 %.255, i32 %.258, i32 %.261, i32 %.264, i32 %.267, i32 %.270, i32 %.273, i32 %.276, i32 %.279, i32 %.282, i32 %.285, i32 %.288, i32 %.291, i32 %.294, i32 %.297, i32 %.300, i32 %.303, i32 %.306, i32 %.309, i32 %.312, i32 %.315, i32 %.318, i32 %.321, i32 %.324, i32 %.327, i32 %.330, i32 %.333, i32 %.336, i32 %.339, i32 %.342, i32 %.345, i32 %.348, i32 %.351, i32 %.354, i32 %.357, i32 %.360, i32 %.363, i32 %.366, i32 %.369, i32 %.372, i32 %.375, i32 %.378, i32 %.381, i32 %.384, i32 %.387, i32 %.390, i32 %.393, i32 %.396, i32 %.399, i32 %.402, i32 %.405, i32 %.408, i32 %.411, i32 %.414, i32 %.417, i32 %.420, i32 %.423, i32 %.426, i32 %.429, i32 %.432, i32 %.435, i32 %.438, i32 %.441, i32 %.444, i32 %.447, i32 %.450, i32 %.453, i32 %.456, i32 %.459, i32 %.462, i32 %.465, i32 %.468, i32 %.471, i32 %.474, i32 %.477, i32 %.480, i32 %.483, i32 %.486, i32 %.489, i32 %.492, i32 %.495, i32 %.498, i32 %.501, i32 %.504, i32 %.507, i32 %.510, i32 %.513, i32 %.516, i32 %.519, i32 %.522, i32 %.525, i32 %.528, i32 %.531, i32 %.534, i32 %.537, i32 %.540, i32 %.543, i32 %.546, i32 %.549, i32 %.552, i32 %.555, i32 %.558, i32 %.561, i32 %.564, i32 %.567, i32 %.570, i32 %.573, i32 %.576, i32 %.579, i32 %.582, i32 %.585, i32 %.588, i32 %.591, i32 %.594, i32 %.597, i32 %.600, i32 %.603, i32 %.606, i32 %.609, i32 %.612, i32 %.615, i32 %.618, i32 %.621, i32 %.624, i32 %.627, i32 %.630, i32 %.633, i32 %.636, i32 %.639, i32 %.642, i32 %.645, i32 %.648, i32 %.651, i32 %.654, i32 %.657, i32 %.660, i32 %.663, i32 %.666, i32 %.669, i32 %.672, i32 %.675, i32 %.678, i32 %.681, i32 %.684, i32 %.687, i32 %.690, i32 %.693, i32 %.696, i32 %.699, i32 %.702, i32 %.705, i32 %.708, i32 %.711, i32 %.714, i32 %.717, i32 %.720, i32 %.723, i32 %.726, i32 %.729, i32 %.732, i32 %.735, i32 %.738, i32 %.741, i32 %.744, i32 %.747, i32 %.750, i32 %.753, i32 %.756, i32 %.759, i32 %.762, i32 %.765, i32 %.768, i32 %.771, i32 %.774, i32 %.777, i32 %.780, i32 %.783, i32 %.786, i32 %.789, i32 %.792, i32 %.795, i32 %.798, i32 %.801, i32 %.804, i32 %.807, i32 %.810, i32 %.813, i32 %.816, i32 %.819, i32 %.822, i32 %.825, i32 %.828, i32 %.831, i32 %.834, i32 %.837, i32 %.840, i32 %.843, i32 %.846, i32 %.849, i32 %.852, i32 %.855, i32 %.858, i32 %.861, i32 %.864, i32 %.867, i32 %.870, i32 %.873, i32 %.876, i32 %.879, i32 %.882, i32 %.885, i32 %.888, i32 %.891, i32 %.894, i32 %.897, i32 %.900, i32 %.903, i32 %.906, i32 %.909, i32 %.912, i32 %.915, i32 %.918, i32 %.921, i32 %.924, i32 %.927, i32 %.930, i32 %.933, i32 %.936, i32 %.939, i32 %.942, i32 %.945, i32 %.948, i32 %.951, i32 %.954, i32 %.957, i32 %.960, i32 %.963, i32 %.966, i32 %.969, i32 %.972, i32 %.975, i32 %.978, i32 %.981, i32 %.984, i32 %.987, i32 %.990, i32 %.993, i32 %.996, i32 %.999, i32 %.1002, i32 %.1005, i32 %.1008, i32 %.1011, i32 %.1014, i32 %.1017, i32 %.1020, i32 %.1023, i32 %.1026, i32 %.1029, i32 %.1032, i32 %.1035, i32 %.1038, i32 %.1041, i32 %.1044, i32 %.1047, i32 %.1050, i32 %.1053, i32 %.1056, i32 %.1059, i32 %.1062, i32 %.1065, i32 %.1068, i32 %.1071, i32 %.1074, i32 %.1077, i32 %.1080, i32 %.1083, i32 %.1086, i32 %.1089, i32 %.1092, i32 %.1095, i32 %.1098, i32 %.1101, i32 %.1104, i32 %.1107, i32 %.1110, i32 %.1113, i32 %.1116, i32 %.1119, i32 %.1122, i32 %.1125, i32 %.1128, i32 %.1131, i32 %.1134, i32 %.1137, i32 %.1140, i32 %.1143, i32 %.1146, i32 %.1149, i32 %.1152, i32 %.1155, i32 %.1158, i32 %.1161, i32 %.1164, i32 %.1167, i32 %.1170, i32 %.1173, i32 %.1176, i32 %.1179, i32 %.1182, i32 %.1185, i32 %.1188, i32 %.1191, i32 %.1194, i32 %.1197, i32 %.1200, i32 %.1203, i32 %.1206, i32 %.1209, i32 %.1212, i32 %.1215, i32 %.1218, i32 %.1221, i32 %.1224, i32 %.1227, i32 %.1230, i32 %.1233, i32 %.1236, i32 %.1239, i32 %.1242, i32 %.1245, i32 %.1248, i32 %.1251, i32 %.1254, i32 %.1257, i32 %.1260, i32 %.1263, i32 %.1266, i32 %.1269, i32 %.1272, i32 %.1275, i32 %.1278, i32 %.1281, i32 %.1284, i32 %.1287, i32 %.1290, i32 %.1293, i32 %.1296, i32 %.1299, i32 %.1302, i32 %.1305, i32 %.1308, i32 %.1311, i32 %.1314, i32 %.1317, i32 %.1320, i32 %.1323, i32 %.1326, i32 %.1329, i32 %.1332, i32 %.1335, i32 %.1338, i32 %.1341, i32 %.1344, i32 %.1347, i32 %.1350, i32 %.1353, i32 %.1356, i32 %.1359, i32 %.1362, i32 %.1365, i32 %.1368, i32 %.1371, i32 %.1374, i32 %.1377, i32 %.1380, i32 %.1383, i32 %.1386, i32 %.1389, i32 %.1392, i32 %.1395, i32 %.1398, i32 %.1401, i32 %.1404, i32 %.1407, i32 %.1410, i32 %.1413, i32 %.1416, i32 %.1419, i32 %.1422, i32 %.1425, i32 %.1428, i32 %.1431, i32 %.1434, i32 %.1437, i32 %.1440, i32 %.1443, i32 %.1446, i32 %.1449, i32 %.1452, i32 %.1455, i32 %.1458, i32 %.1461, i32 %.1464, i32 %.1467, i32 %.1470, i32 %.1473, i32 %.1476, i32 %.1479, i32 %.1482, i32 %.1485, i32 %.1488, i32 %.1491, i32 %.1494, i32 %.1497, i32 %.1500, i32 %.1503, i32 %.1506, i32 %.1509, i32 %.1512, i32 %.1515, i32 %.1518, i32 %.1521, i32 %.1524, i32 %.1527, i32 %.1530, i32 %.1533, i32 %.1536, i32 %.1539, i32 %.1542, i32 %.1545, i32 %.1548, i32 %.1551, i32 %.1554, i32 %.1557, i32 %.1560, i32 %.1563, i32 %.1566, i32 %.1569, i32 %.1572, i32 %.1575, i32 %.1578, i32 %.1581, i32 %.1584, i32 %.1587, i32 %.1590, i32 %.1593, i32 %.1596, i32 %.1599, i32 %.1602, i32 %.1605, i32 %.1608, i32 %.1611, i32 %.1614, i32 %.1617, i32 %.1620, i32 %.1623, i32 %.1626, i32 %.1629, i32 %.1632, i32 %.1635, i32 %.1638, i32 %.1641, i32 %.1644, i32 %.1647, i32 %.1650, i32 %.1653, i32 %.1656, i32 %.1659, i32 %.1662, i32 %.1665, i32 %.1668, i32 %.1671, i32 %.1674, i32 %.1677, i32 %.1680, i32 %.1683, i32 %.1686, i32 %.1689, i32 %.1692, i32 %.1695, i32 %.1698, i32 %.1701, i32 %.1704, i32 %.1707, i32 %.1710, i32 %.1713, i32 %.1716, i32 %.1719, i32 %.1722, i32 %.1725, i32 %.1728, i32 %.1731, i32 %.1734, i32 %.1737, i32 %.1740, i32 %.1743, i32 %.1746, i32 %.1749, i32 %.1752, i32 %.1755, i32 %.1758, i32 %.1761, i32 %.1764, i32 %.1767, i32 %.1770, i32 %.1773, i32 %.1776, i32 %.1779, i32 %.1782, i32 %.1785, i32 %.1788, i32 %.1791, i32 %.1794, i32 %.1797, i32 %.1800, i32 %.1803, i32 %.1806, i32 %.1809, i32 %.1812, i32 %.1815, i32 %.1818, i32 %.1821, i32 %.1824, i32 %.1827, i32 %.1830, i32 %.1833, i32 %.1836, i32 %.1839, i32 %.1842, i32 %.1845, i32 %.1848, i32 %.1851, i32 %.1854, i32 %.1857, i32 %.1860, i32 %.1863, i32 %.1866, i32 %.1869, i32 %.1872, i32 %.1875, i32 %.1878, i32 %.1881, i32 %.1884, i32 %.1887, i32 %.1890, i32 %.1893, i32 %.1896, i32 %.1899, i32 %.1902, i32 %.1905, i32 %.1908, i32 %.1911, i32 %.1914, i32 %.1917, i32 %.1920, i32 %.1923, i32 %.1926, i32 %.1929, i32 %.1932, i32 %.1935, i32 %.1938, i32 %.1941, i32 %.1944, i32 %.1947, i32 %.1950, i32 %.1953, i32 %.1956, i32 %.1959, i32 %.1962, i32 %.1965, i32 %.1968, i32 %.1971, i32 %.1974, i32 %.1977, i32 %.1980, i32 %.1983, i32 %.1986, i32 %.1989, i32 %.1992, i32 %.1995, i32 %.1998, i32 %.2001, i32 %.2004, i32 %.2007, i32 %.2010, i32 %.2013, i32 %.2016, i32 %.2019, i32 %.2022, i32 %.2025, i32 %.2028){
.1:
  %.2032 = mul i32 %.1869, %.1977
  %.2034 = mul i32 %.1653, %.2032
  %.2036 = mul i32 %.2034, %.1986
  %.2038 = mul i32 %.267, %.2036
  %.2040 = add i32 %.1587, %.2038
  %.2043 = mul i32 %.150, %.1416
  %.2045 = mul i32 %.1302, %.2043
  %.2047 = mul i32 %.813, %.2045
  %.2049 = mul i32 %.1281, %.2047
  %.2051 = mul i32 %.762, %.2049
  %.2053 = mul i32 %.2051, %.1824
  %.2054 = add i32 %.2053, %.2040
  %.2057 = mul i32 %.1737, %.1752
  %.2058 = add i32 %.2057, %.2054
  %.2060 = add i32 %.786, %.2058
  %.2063 = mul i32 %.651, %.1668
  %.2065 = mul i32 %.1095, %.2063
  %.2066 = add i32 %.2065, %.2060
  %.2069 = mul i32 %.843, %.1176
  %.2070 = add i32 %.2069, %.2066
  %.2073 = mul i32 %.327, %.456
  %.2074 = add i32 %.2073, %.2070
  %.2076 = add i32 %.549, %.2074
  %.2079 = mul i32 %.117, %.768
  %.2081 = mul i32 %.2079, %.783
  %.2083 = mul i32 %.2081, %.990
  %.2084 = add i32 %.2083, %.2076
  %.2086 = add i32 %.534, %.2084
  %.2088 = add i32 %.1272, %.2086
  %.2090 = add i32 %.183, %.2088
  %.2093 = mul i32 %.78, %.888
  %.2095 = mul i32 %.639, %.2093
  %.2096 = add i32 %.2095, %.2090
  %.2099 = mul i32 %.1248, %.1971
  %.2100 = add i32 %.2099, %.2096
  %.2103 = mul i32 %.759, %.1746
  %.2105 = mul i32 %.660, %.2103
  %.2107 = mul i32 %.462, %.2105
  %.2109 = mul i32 %.1695, %.2107
  %.2110 = add i32 %.2109, %.2100
  %.2112 = add i32 %.324, %.2110
  %.2114 = add i32 %.1497, %.2112
  %.2116 = add i32 %.795, %.2114
  %.2119 = mul i32 %.597, %.1455
  %.2121 = mul i32 %.237, %.2119
  %.2122 = add i32 %.2121, %.2116
  %.2125 = mul i32 %.516, %.1644
  %.2126 = add i32 %.2125, %.2122
  %.2129 = mul i32 %.6, %.852
  %.2131 = mul i32 %.2129, %.867
  %.2132 = add i32 %.2131, %.2126
  %.2135 = mul i32 %.15, %.1212
  %.2136 = add i32 %.2135, %.2132
  %.2139 = mul i32 %.213, %.1134
  %.2140 = add i32 %.2139, %.2136
  %.2142 = add i32 %.1809, %.2140
  %.2144 = add i32 %.1977, %.2142
  %.2146 = add i32 %.954, %.2144
  %.2149 = mul i32 %.33, %.1413
  %.2151 = mul i32 %.825, %.2149
  %.2152 = add i32 %.2151, %.2146
  %.2155 = mul i32 %.72, %.618
  %.2156 = add i32 %.2155, %.2152
  %.2159 = mul i32 %.195, %.477
  %.2160 = add i32 %.2159, %.2156
  %.2163 = mul i32 %.132, %.426
  %.2164 = add i32 %.2163, %.2160
  %.2166 = add i32 %.1596, %.2164
  %.2168 = add i32 %.348, %.2166
  %.2170 = add i32 %.1074, %.2168
  %.2173 = mul i32 %.336, %.1542
  %.2174 = add i32 %.2173, %.2170
  %.2176 = add i32 %.519, %.2174
  %.2179 = mul i32 %.1590, %.1608
  %.2181 = mul i32 %.858, %.2179
  %.2182 = add i32 %.2181, %.2176
  %.2184 = add i32 %.1902, %.2182
  %.2187 = mul i32 %.24, %.270
  %.2189 = mul i32 %.2187, %.1872
  %.2191 = mul i32 %.660, %.2189
  %.2193 = mul i32 %.819, %.2191
  %.2195 = mul i32 %.1296, %.2193
  %.2197 = mul i32 %.2195, %.1944
  %.2198 = add i32 %.2197, %.2184
  %.2200 = add i32 %.867, %.2198
  %.2203 = mul i32 %.1254, %.1341
  %.2204 = add i32 %.2203, %.2200
  %.2206 = add i32 %.1050, %.2204
  %.2208 = add i32 %.1134, %.2206
  %.2210 = add i32 %.519, %.2208
  %.2212 = add i32 %.2007, %.2210
  %.2215 = mul i32 %.159, %.882
  %.2216 = add i32 %.2215, %.2212
  %.2218 = add i32 %.1329, %.2216
  %.2221 = mul i32 %.279, %.1140
  %.2222 = add i32 %.2221, %.2218
  %.2225 = mul i32 %.192, %.372
  %.2227 = mul i32 %.12, %.2225
  %.2228 = add i32 %.2227, %.2222
  %.2230 = add i32 %.786, %.2228
  %.2232 = add i32 %.1491, %.2230
  %.2235 = mul i32 %.84, %.1137
  %.2236 = add i32 %.2235, %.2232
  %.2238 = add i32 %.957, %.2236
  %.2241 = mul i32 %.1773, %.1824
  %.2242 = add i32 %.2241, %.2238
  %.2245 = mul i32 %.1353, %.1557
  %.2247 = mul i32 %.999, %.2245
  %.2248 = add i32 %.2247, %.2242
  %.2250 = add i32 %.231, %.2248
  %.2253 = mul i32 %.282, %.1755
  %.2255 = mul i32 %.2253, %.1776
  %.2256 = add i32 %.2255, %.2250
  %.2258 = add i32 %.303, %.2256
  %.2260 = add i32 %.1236, %.2258
  %.2262 = add i32 %.684, %.2260
  %.2264 = add i32 %.699, %.2262
  %.2266 = add i32 %.684, %.2264
  %.2269 = mul i32 %.615, %.1953
  %.2270 = add i32 %.2269, %.2266
  %.2273 = mul i32 %.852, %.1179
  %.2275 = mul i32 %.2273, %.2007
  %.2277 = mul i32 %.606, %.2275
  %.2279 = mul i32 %.1470, %.2277
  %.2281 = mul i32 %.777, %.2279
  %.2282 = add i32 %.2281, %.2270
  %.2284 = add i32 %.501, %.2282
  %.2287 = mul i32 %.207, %.1911
  %.2289 = mul i32 %.1716, %.2287
  %.2291 = mul i32 %.249, %.2289
  %.2293 = mul i32 %.489, %.2291
  %.2294 = add i32 %.2293, %.2284
  %.2297 = mul i32 %.267, %.399
  %.2299 = mul i32 %.2297, %.1878
  %.2301 = mul i32 %.1755, %.2299
  %.2302 = add i32 %.2301, %.2294
  %.2304 = add i32 %.2013, %.2302
  %.2307 = mul i32 %.120, %.1506
  %.2309 = mul i32 %.699, %.2307
  %.2311 = mul i32 %.279, %.2309
  %.2312 = add i32 %.2311, %.2304
  %.2314 = add i32 %.36, %.2312
  %.2317 = mul i32 %.384, %.1668
  %.2319 = mul i32 %.261, %.2317
  %.2321 = mul i32 %.708, %.2319
  %.2323 = mul i32 %.1461, %.2321
  %.2325 = mul i32 %.90, %.2323
  %.2327 = mul i32 %.822, %.2325
  %.2328 = add i32 %.2327, %.2314
  %.2330 = add i32 %.1950, %.2328
  %.2332 = add i32 %.849, %.2330
  %.2335 = mul i32 %.1548, %.1581
  %.2336 = add i32 %.2335, %.2332
  %.2339 = mul i32 %.642, %.1788
  %.2341 = mul i32 %.432, %.2339
  %.2343 = mul i32 %.1596, %.2341
  %.2345 = mul i32 %.1542, %.2343
  %.2347 = mul i32 %.438, %.2345
  %.2349 = mul i32 %.588, %.2347
  %.2351 = mul i32 %.300, %.2349
  %.2353 = mul i32 %.2351, %.2016
  %.2355 = mul i32 %.36, %.2353
  %.2357 = mul i32 %.1770, %.2355
  %.2358 = add i32 %.2357, %.2336
  %.2361 = mul i32 %.393, %.1704
  %.2362 = add i32 %.2361, %.2358
  %.2364 = add i32 %.915, %.2362
  %.2367 = mul i32 %.627, %.672
  %.2369 = mul i32 %.2367, %.1626
  %.2370 = add i32 %.2369, %.2364
  %.2372 = add i32 %.885, %.2370
  %.2374 = add i32 %.2007, %.2372
  %.2376 = add i32 %.351, %.2374
  %.2379 = mul i32 %.1173, %.1968
  %.2380 = add i32 %.2379, %.2376
  %.2382 = add i32 %.1956, %.2380
  %.2384 = add i32 %.138, %.2382
  %.2386 = add i32 %.12, %.2384
  %.2388 = add i32 %.750, %.2386
  %.2390 = add i32 %.1620, %.2388
  %.2392 = add i32 %.1521, %.2390
  %.2394 = add i32 %.372, %.2392
  %.2396 = add i32 %.216, %.2394
  %.2398 = add i32 %.555, %.2396
  %.2401 = mul i32 %.354, %.558
  %.2403 = mul i32 %.2401, %.564
  %.2405 = mul i32 %.210, %.2403
  %.2407 = mul i32 %.2405, %.897
  %.2408 = add i32 %.2407, %.2398
  %.2411 = mul i32 %.1218, %.1746
  %.2413 = mul i32 %.1026, %.2411
  %.2415 = mul i32 %.783, %.2413
  %.2417 = mul i32 %.1485, %.2415
  %.2418 = add i32 %.2417, %.2408
  %.2421 = mul i32 %.744, %.1389
  %.2422 = add i32 %.2421, %.2418
  %.2424 = add i32 %.354, %.2422
  %.2427 = mul i32 %.477, %.708
  %.2428 = add i32 %.2427, %.2424
  %.2431 = mul i32 %.96, %.801
  %.2432 = add i32 %.2431, %.2428
  %.2434 = add i32 %.1440, %.2432
  %.2436 = add i32 %.1224, %.2434
  %.2438 = add i32 %.1569, %.2436
  %.2440 = add i32 %.1938, %.2438
  %.2443 = mul i32 %.1494, %.1650
  %.2445 = mul i32 %.2443, %.1815
  %.2446 = add i32 %.2445, %.2440
  %.2449 = mul i32 %.204, %.1356
  %.2450 = add i32 %.2449, %.2446
  %.2452 = add i32 %.1311, %.2450
  %.2455 = mul i32 %.45, %.1707
  %.2457 = mul i32 %.1170, %.2455
  %.2458 = add i32 %.2457, %.2452
  %.2460 = add i32 %.1968, %.2458
  %.2462 = add i32 %.1278, %.2460
  %.2465 = mul i32 %.816, %.1464
  %.2467 = mul i32 %.1134, %.2465
  %.2469 = mul i32 %.1299, %.2467
  %.2470 = add i32 %.2469, %.2462
  %.2473 = mul i32 %.375, %.1002
  %.2475 = mul i32 %.75, %.2473
  %.2477 = mul i32 %.648, %.2475
  %.2479 = mul i32 %.2477, %.1485
  %.2481 = mul i32 %.2479, %.1521
  %.2482 = add i32 %.2481, %.2470
  %.2484 = add i32 %.1662, %.2482
  %.2486 = add i32 %.1404, %.2484
  %.2489 = mul i32 %.126, %.1914
  %.2490 = add i32 %.2489, %.2486
  %.2492 = add i32 %.1224, %.2490
  %.2495 = mul i32 %.927, %.1854
  %.2496 = add i32 %.2495, %.2492
  %.2499 = mul i32 %.1605, %.1986
  %.2501 = mul i32 %.1392, %.2499
  %.2502 = add i32 %.2501, %.2496
  %.2505 = mul i32 %.468, %.1404
  %.2507 = mul i32 %.468, %.2505
  %.2508 = add i32 %.2507, %.2502
  %.2511 = mul i32 %.954, %.1434
  %.2512 = add i32 %.2511, %.2508
  %.2515 = mul i32 %.1872, %.1932
  %.2516 = add i32 %.2515, %.2512
  %.2518 = add i32 %.1278, %.2516
  %.2521 = mul i32 %.486, %.807
  %.2522 = add i32 %.2521, %.2518
  %.2524 = add i32 %.1029, %.2522
  %.2526 = add i32 %.480, %.2524
  %.2528 = add i32 %.1716, %.2526
  %.2530 = add i32 %.1116, %.2528
  %.2532 = add i32 %.570, %.2530
  %.2534 = add i32 %.408, %.2532
  %.2537 = mul i32 %.321, %.1827
  %.2538 = add i32 %.2537, %.2534
  %.2540 = add i32 %.552, %.2538
  %.2542 = add i32 %.1185, %.2540
  %.2545 = mul i32 %.1014, %.1944
  %.2547 = mul i32 %.69, %.2545
  %.2548 = add i32 %.2547, %.2542
  %.2550 = add i32 %.654, %.2548
  %.2552 = add i32 %.276, %.2550
  %.2555 = mul i32 %.1053, %.1980
  %.2556 = add i32 %.2555, %.2552
  %.2559 = mul i32 %.732, %.858
  %.2561 = mul i32 %.633, %.2559
  %.2563 = mul i32 %.2561, %.1425
  %.2564 = add i32 %.2563, %.2556
  %.2567 = mul i32 %.1575, %.1917
  %.2568 = add i32 %.2567, %.2564
  %.2570 = add i32 %.873, %.2568
  %.2573 = mul i32 %.411, %.840
  %.2575 = mul i32 %.132, %.2573
  %.2577 = mul i32 %.2575, %.1944
  %.2578 = add i32 %.2577, %.2570
  %.2581 = mul i32 %.1323, %.1449
  %.2582 = add i32 %.2581, %.2578
  %.2584 = add i32 %.90, %.2582
  %.2586 = add i32 %.237, %.2584
  %.2588 = add i32 %.675, %.2586
  %.2590 = add i32 %.513, %.2588
  %.2592 = add i32 %.1623, %.2590
  %.2595 = mul i32 %.732, %.873
  %.2596 = add i32 %.2595, %.2592
  %.2598 = add i32 %.1797, %.2596
  %.2601 = mul i32 %.1305, %.1695
  %.2602 = add i32 %.2601, %.2598
  %.2604 = add i32 %.987, %.2602
  %.2606 = add i32 %.1692, %.2604
  %.2608 = add i32 %.1563, %.2606
  %.2611 = mul i32 %.618, %.1170
  %.2613 = mul i32 %.2611, %.1440
  %.2615 = mul i32 %.186, %.2613
  %.2617 = mul i32 %.567, %.2615
  %.2618 = add i32 %.2617, %.2608
  %.2621 = mul i32 %.156, %.1338
  %.2622 = add i32 %.2621, %.2618
  %.2625 = mul i32 %.633, %.1671
  %.2626 = add i32 %.2625, %.2622
  %.2628 = add i32 %.630, %.2626
  %.2631 = mul i32 %.63, %.420
  %.2633 = mul i32 %.273, %.2631
  %.2634 = add i32 %.2633, %.2628
  %.2637 = mul i32 %.837, %.1653
  %.2638 = add i32 %.2637, %.2634
  %.2641 = mul i32 %.1119, %.1206
  %.2643 = mul i32 %.792, %.2641
  %.2645 = mul i32 %.687, %.2643
  %.2646 = add i32 %.2645, %.2638
  %.2649 = mul i32 %.93, %.1380
  %.2650 = add i32 %.2649, %.2646
  %.2653 = mul i32 %.555, %.1641
  %.2655 = mul i32 %.1518, %.2653
  %.2656 = add i32 %.2655, %.2650
  %.2658 = add i32 %.1755, %.2656
  %.2660 = add i32 %.1377, %.2658
  %.2662 = add i32 %.1098, %.2660
  %.2665 = mul i32 %.597, %.1191
  %.2666 = add i32 %.2665, %.2662
  %.2669 = mul i32 %.1185, %.1785
  %.2671 = mul i32 %.339, %.2669
  %.2673 = mul i32 %.1368, %.2671
  %.2674 = add i32 %.2673, %.2666
  %.2676 = add i32 %.1905, %.2674
  %.2679 = mul i32 %.1101, %.1428
  %.2681 = mul i32 %.645, %.2679
  %.2683 = mul i32 %.2681, %.1623
  %.2684 = add i32 %.2683, %.2676
  %.2687 = mul i32 %.177, %.1701
  %.2689 = mul i32 %.2687, %.1914
  %.2690 = add i32 %.2689, %.2684
  %.2693 = mul i32 %.1740, %.1824
  %.2694 = add i32 %.2693, %.2690
  %.2696 = add i32 %.1812, %.2694
  %.2698 = add i32 %.1761, %.2696
  %.2700 = add i32 %.1068, %.2698
  %.2703 = mul i32 %.1407, %.1656
  %.2705 = mul i32 %.2703, %.1893
  %.2706 = add i32 %.2705, %.2700
  %.2708 = add i32 %.1590, %.2706
  %.2710 = add i32 %.1410, %.2708
  %.2712 = add i32 %.294, %.2710
  %.2714 = add i32 %.1212, %.2712
  %.2716 = add i32 %.1587, %.2714
  %.2719 = mul i32 %.144, %.1023
  %.2720 = add i32 %.2719, %.2716
  %.2723 = mul i32 %.1251, %.1965
  %.2725 = mul i32 %.822, %.2723
  %.2726 = add i32 %.2725, %.2720
  %.2729 = mul i32 %.237, %.2010
  %.2730 = add i32 %.2729, %.2726
  %.2733 = mul i32 %.849, %.1842
  %.2734 = add i32 %.2733, %.2730
  %.2737 = mul i32 %.603, %.621
  %.2738 = add i32 %.2737, %.2734
  %.2740 = add i32 %.1176, %.2738
  %.2743 = mul i32 %.1164, %.1638
  %.2745 = mul i32 %.1185, %.2743
  %.2746 = add i32 %.2745, %.2740
  %.2749 = mul i32 %.93, %.663
  %.2750 = add i32 %.2749, %.2746
  %.2752 = add i32 %.1425, %.2750
  %.2755 = mul i32 %.663, %.1521
  %.2756 = add i32 %.2755, %.2752
  %.2759 = mul i32 %.492, %.765
  %.2761 = mul i32 %.2759, %.2022
  %.2762 = add i32 %.2761, %.2756
  %.2764 = add i32 %.399, %.2762
  %.2767 = mul i32 %.339, %.1212
  %.2769 = mul i32 %.2767, %.1731
  %.2770 = add i32 %.2769, %.2764
  %.2773 = mul i32 %.15, %.1341
  %.2774 = add i32 %.2773, %.2770
  %.2777 = mul i32 %.30, %.1764
  %.2778 = add i32 %.2777, %.2774
  %.2781 = mul i32 %.819, %.1179
  %.2783 = mul i32 %.2781, %.1209
  %.2784 = add i32 %.2783, %.2778
  %.2787 = mul i32 %.138, %.555
  %.2789 = mul i32 %.48, %.2787
  %.2791 = mul i32 %.2789, %.657
  %.2793 = mul i32 %.39, %.2791
  %.2794 = add i32 %.2793, %.2784
  %.2796 = add i32 %.1935, %.2794
  %.2798 = add i32 %.1011, %.2796
  %.2801 = mul i32 %.24, %.1740
  %.2803 = mul i32 %.1542, %.2801
  %.2805 = mul i32 %.435, %.2803
  %.2806 = add i32 %.2805, %.2798
  %.2809 = mul i32 %.1398, %.1497
  %.2811 = mul i32 %.36, %.2809
  %.2812 = add i32 %.2811, %.2806
  %.2814 = add i32 %.1533, %.2812
  %.2816 = add i32 %.420, %.2814
  %.2819 = mul i32 %.252, %.1539
  %.2820 = add i32 %.2819, %.2816
  %.2822 = add i32 %.738, %.2820
  %.2824 = add i32 %.930, %.2822
  %.2826 = add i32 %.1158, %.2824
  %.2828 = add i32 %.666, %.2826
  ret i32 %.2828 
}
define i32 @main(){
.2831:
  %.2842at51 = call i32 @func(i32 0, i32 1, i32 1, i32 8, i32 9, i32 5, i32 2, i32 0, i32 6, i32 2, i32 4, i32 7, i32 1, i32 6, i32 9, i32 3, i32 3, i32 5, i32 0, i32 8, i32 9, i32 3, i32 4, i32 5, i32 9, i32 0, i32 8, i32 9, i32 5, i32 5, i32 4, i32 1, i32 4, i32 3, i32 5, i32 9, i32 7, i32 6, i32 1, i32 7, i32 5, i32 4, i32 0, i32 7, i32 5, i32 5, i32 6, i32 4, i32 9, i32 6, i32 6, i32 6, i32 8, i32 0, i32 4, i32 2, i32 3, i32 3, i32 0, i32 5, i32 4, i32 3, i32 9, i32 5, i32 9, i32 3, i32 3, i32 6, i32 4, i32 3, i32 3, i32 0, i32 5, i32 0, i32 2, i32 5, i32 6, i32 6, i32 9, i32 4, i32 0, i32 3, i32 7, i32 2, i32 1, i32 1, i32 9, i32 8, i32 4, i32 8, i32 5, i32 2, i32 5, i32 4, i32 5, i32 0, i32 3, i32 5, i32 0, i32 7, i32 0, i32 7, i32 5, i32 6, i32 7, i32 7, i32 8, i32 2, i32 6, i32 8, i32 9, i32 4, i32 6, i32 7, i32 2, i32 9, i32 8, i32 8, i32 0, i32 0, i32 3, i32 4, i32 8, i32 9, i32 0, i32 5, i32 9, i32 8, i32 5, i32 1, i32 2, i32 7, i32 3, i32 2, i32 5, i32 4, i32 9, i32 9, i32 6, i32 9, i32 2, i32 5, i32 5, i32 7, i32 8, i32 3, i32 8, i32 9, i32 4, i32 9, i32 0, i32 5, i32 9, i32 8, i32 4, i32 2, i32 5, i32 0, i32 7, i32 8, i32 8, i32 4, i32 6, i32 7, i32 9, i32 8, i32 2, i32 4, i32 4, i32 2, i32 9, i32 9, i32 8, i32 1, i32 2, i32 3, i32 7, i32 2, i32 2, i32 1, i32 7, i32 1, i32 2, i32 4, i32 0, i32 6, i32 6, i32 0, i32 9, i32 9, i32 0, i32 7, i32 8, i32 9, i32 8, i32 5, i32 1, i32 8, i32 9, i32 2, i32 4, i32 7, i32 3, i32 4, i32 7, i32 9, i32 9, i32 4, i32 7, i32 1, i32 9, i32 0, i32 6, i32 0, i32 6, i32 9, i32 8, i32 4, i32 3, i32 6, i32 2, i32 9, i32 7, i32 5, i32 6, i32 9, i32 8, i32 6, i32 5, i32 8, i32 4, i32 0, i32 5, i32 2, i32 3, i32 2, i32 4, i32 0, i32 0, i32 9, i32 5, i32 8, i32 9, i32 2, i32 5, i32 2, i32 5, i32 0, i32 9, i32 4, i32 2, i32 0, i32 0, i32 1, i32 5, i32 0, i32 4, i32 9, i32 4, i32 9, i32 4, i32 6, i32 0, i32 0, i32 4, i32 2, i32 6, i32 9, i32 3, i32 7, i32 8, i32 5, i32 5, i32 7, i32 1, i32 0, i32 5, i32 3, i32 6, i32 0, i32 3, i32 3, i32 6, i32 2, i32 9, i32 9, i32 1, i32 9, i32 6, i32 2, i32 4, i32 1, i32 5, i32 1, i32 5, i32 0, i32 8, i32 5, i32 7, i32 9, i32 4, i32 6, i32 1, i32 3, i32 9, i32 4, i32 2, i32 3, i32 0, i32 8, i32 6, i32 0, i32 9, i32 7, i32 3, i32 1, i32 3, i32 7, i32 0, i32 9, i32 2, i32 3, i32 1, i32 2, i32 9, i32 3, i32 8, i32 5, i32 7, i32 3, i32 9, i32 6, i32 7, i32 1, i32 9, i32 6, i32 3, i32 8, i32 1, i32 8, i32 8, i32 2, i32 8, i32 7, i32 5, i32 4, i32 2, i32 0, i32 4, i32 0, i32 7, i32 7, i32 8, i32 9, i32 6, i32 6, i32 7, i32 7, i32 1, i32 6, i32 0, i32 5, i32 3, i32 4, i32 2, i32 6, i32 3, i32 6, i32 3, i32 4, i32 1, i32 3, i32 6, i32 9, i32 4, i32 3, i32 0, i32 9, i32 0, i32 2, i32 2, i32 0, i32 8, i32 8, i32 4, i32 5, i32 8, i32 2, i32 3, i32 3, i32 7, i32 2, i32 5, i32 9, i32 6, i32 7, i32 0, i32 1, i32 8, i32 5, i32 7, i32 8, i32 3, i32 0, i32 2, i32 9, i32 1, i32 5, i32 4, i32 9, i32 4, i32 5, i32 3, i32 7, i32 4, i32 0, i32 2, i32 7, i32 1, i32 3, i32 2, i32 7, i32 1, i32 7, i32 0, i32 0, i32 6, i32 7, i32 8, i32 9, i32 0, i32 2, i32 5, i32 4, i32 6, i32 2, i32 9, i32 2, i32 1, i32 0, i32 2, i32 2, i32 7, i32 3, i32 8, i32 9, i32 6, i32 3, i32 6, i32 9, i32 0, i32 8, i32 1, i32 2, i32 2, i32 9, i32 5, i32 8, i32 2, i32 5, i32 0, i32 4, i32 7, i32 0, i32 8, i32 2, i32 9, i32 6, i32 7, i32 7, i32 5, i32 2, i32 6, i32 6, i32 8, i32 8, i32 9, i32 7, i32 7, i32 4, i32 9, i32 0, i32 8, i32 7, i32 6, i32 8, i32 3, i32 1, i32 6, i32 7, i32 4, i32 6, i32 5, i32 6, i32 2, i32 8, i32 8, i32 5, i32 9, i32 0, i32 3, i32 1, i32 9, i32 1, i32 4, i32 9, i32 6, i32 4, i32 7, i32 6, i32 6, i32 8, i32 9, i32 6, i32 6, i32 1, i32 2, i32 5, i32 2, i32 0, i32 3, i32 8, i32 2, i32 9, i32 1, i32 3, i32 9, i32 6, i32 2, i32 3, i32 2, i32 9, i32 9, i32 3, i32 8, i32 8, i32 1, i32 9, i32 8, i32 5, i32 1, i32 1, i32 2, i32 7, i32 9, i32 3, i32 7, i32 4, i32 3, i32 4, i32 0, i32 7, i32 4, i32 9, i32 1, i32 4, i32 6, i32 4, i32 3, i32 8, i32 3, i32 8, i32 7, i32 6, i32 3, i32 2, i32 1, i32 8, i32 5, i32 2, i32 3, i32 1, i32 3, i32 7, i32 6, i32 2, i32 4, i32 0, i32 9, i32 9, i32 7, i32 8, i32 3, i32 7, i32 5, i32 8, i32 8, i32 5, i32 6, i32 7, i32 3, i32 2, i32 9, i32 5, i32 5, i32 1, i32 5, i32 7, i32 9, i32 7, i32 9, i32 0, i32 5, i32 4, i32 3, i32 3, i32 0, i32 0, i32 0, i32 3, i32 5, i32 1, i32 6, i32 2, i32 0, i32 4, i32 7, i32 4, i32 9, i32 7, i32 3, i32 4, i32 0, i32 6, i32 0, i32 3, i32 1, i32 3, i32 5, i32 7, i32 3, i32 8, i32 3, i32 1, i32 9, i32 6, i32 8, i32 6, i32 7, i32 7, i32 3, i32 2, i32 9, i32 8, i32 1, i32 9, i32 5, i32 8, i32 4, i32 7, i32 8, i32 9, i32 9, i32 0, i32 9, i32 2, i32 9, i32 0, i32 0, i32 7, i32 4, i32 3, i32 9, i32 2, i32 2, i32 7, i32 8, i32 7, i32 1, i32 3, i32 5, i32 8, i32 4, i32 4, i32 0, i32 9)
  ret i32 %.2842at51 
}
