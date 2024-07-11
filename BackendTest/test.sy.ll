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
@.G.maxlen = global i32 zeroinitializer
@.G.temp = global [2097152 x i32] zeroinitializer
@.G.w = global [2097152 x i32] zeroinitializer
@.G.dst = global [2097152 x i32] zeroinitializer
@.G.c = global [2097152 x i32] zeroinitializer
define i32 @getvalue(i32* %.8, i32 %.11, i32 %.14, i32 %.17){
.7:
  %.18 = alloca i32
  %.15 = alloca i32
  %.12 = alloca i32
  %.9 = alloca i32*
  store i32* %.8, i32** %.9
  store i32 %.11, i32* %.12
  store i32 %.14, i32* %.15
  store i32 %.17, i32* %.18
  %.23 = load i32, i32* %.15
  %.25 = icmp slt i32 %.23, 0
  br i1 %.25, label %.20, label %.22
.20:
  ret i32 -1 
.21:
  %.43 = load i32, i32* %.15
  %.44 = load i32, i32* %.12
  %.45 = mul i32 %.43, %.44
  %.46 = load i32, i32* %.18
  %.47 = add i32 %.45, %.46
  %.48 = load i32*, i32** %.9
  %.49 = getelementptr inbounds i32, i32* %.48, i32 %.47
  %.50 = load i32, i32* %.49
  ret i32 %.50 
.22:
  %.28 = load i32, i32* %.15
  %.29 = load i32, i32* %.12
  %.30 = icmp sge i32 %.28, %.29
  br i1 %.30, label %.20, label %.27
.27:
  %.33 = load i32, i32* %.18
  %.34 = icmp slt i32 %.33, 0
  br i1 %.34, label %.20, label %.32
.32:
  %.36 = load i32, i32* %.18
  %.37 = load i32, i32* %.12
  %.38 = icmp sge i32 %.36, %.37
  br i1 %.38, label %.20, label %.21
}
define void @mem_move(i32* %.54, i32* %.57, i32 %.60){
.53:
  %.63 = alloca i32
  %.61 = alloca i32
  %.58 = alloca i32*
  %.55 = alloca i32*
  store i32* %.54, i32** %.55
  store i32* %.57, i32** %.58
  store i32 %.60, i32* %.61
  store i32 0, i32* %.63
  br label %.65wc17 
.65wc17:
  %.69 = load i32, i32* %.63
  %.70 = load i32, i32* %.61
  %.71 = icmp slt i32 %.69, %.70
  br i1 %.71, label %.66wloop.17.20, label %.67wn20
.66wloop.17.20:
  %.73 = load i32, i32* %.63
  %.74 = load i32*, i32** %.55
  %.75 = getelementptr inbounds i32, i32* %.74, i32 %.73
  %.76 = load i32, i32* %.75
  %.77 = load i32, i32* %.63
  %.78 = load i32*, i32** %.58
  %.79 = getelementptr inbounds i32, i32* %.78, i32 %.77
  store i32 %.76, i32* %.79
  %.81 = load i32, i32* %.63
  %.82 = add i32 %.81, 1
  store i32 %.82, i32* %.63
  br label %.65wc17 
.67wn20:
  ret void
}
define void @floyd(i32* %.88, i32* %.91, i32 %.94){
.87:
  %.162 = alloca i32
  %.152 = alloca i32
  %.107 = alloca i32
  %.97 = alloca i32
  %.95 = alloca i32
  %.92 = alloca i32*
  %.89 = alloca i32*
  store i32* %.88, i32** %.89
  store i32* %.91, i32** %.92
  store i32 %.94, i32* %.95
  store i32 0, i32* %.97
  br label %.99wc26 
.99wc26:
  %.103 = load i32, i32* %.97
  %.104 = load i32, i32* %.95
  %.105 = icmp slt i32 %.103, %.104
  br i1 %.105, label %.100wloop.26.33, label %.101wn33
.100wloop.26.33:
  store i32 0, i32* %.107
  br label %.109wc28 
.101wn33:
  store i32 0, i32* %.97
  %.138 = load i32, i32* %.95
  %.139 = load i32, i32* %.95
  %.140 = mul i32 %.138, %.139
  %.141 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  call void @putarray(i32 %.140, i32* %.141)
  br label %.144wc37 
.109wc28:
  %.113 = load i32, i32* %.107
  %.114 = load i32, i32* %.95
  %.115 = icmp slt i32 %.113, %.114
  br i1 %.115, label %.110wloop.28.31, label %.111wn31
.110wloop.28.31:
  %.117 = load i32*, i32** %.89
  %.118 = load i32, i32* %.95
  %.119 = load i32, i32* %.107
  %.120 = load i32, i32* %.97
  %.121at29 = call i32 @getvalue(i32* %.117, i32 %.118, i32 %.119, i32 %.120)
  %.122 = load i32, i32* %.107
  %.123 = load i32, i32* %.95
  %.124 = mul i32 %.122, %.123
  %.125 = load i32, i32* %.97
  %.126 = add i32 %.124, %.125
  %.127 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 %.126
  store i32 %.121at29, i32* %.127
  %.129 = load i32, i32* %.107
  %.130 = add i32 %.129, 1
  store i32 %.130, i32* %.107
  br label %.109wc28 
.111wn31:
  %.133 = load i32, i32* %.97
  %.134 = add i32 %.133, 1
  store i32 %.134, i32* %.97
  br label %.99wc26 
.144wc37:
  %.148 = load i32, i32* %.97
  %.149 = load i32, i32* %.95
  %.150 = icmp slt i32 %.148, %.149
  br i1 %.150, label %.145wloop.37.62, label %.146wn62
.145wloop.37.62:
  store i32 0, i32* %.152
  br label %.154wc39 
.146wn62:
  %.303 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.304 = load i32*, i32** %.92
  %.305 = load i32, i32* %.95
  %.306 = load i32, i32* %.95
  %.307 = mul i32 %.305, %.306
  call void @mem_move(i32* %.303, i32* %.304, i32 %.307)
  ret void
.154wc39:
  %.158 = load i32, i32* %.152
  %.159 = load i32, i32* %.95
  %.160 = icmp slt i32 %.158, %.159
  br i1 %.160, label %.155wloop.39.60, label %.156wn60
.155wloop.39.60:
  store i32 0, i32* %.162
  br label %.164wc41 
.156wn60:
  %.299 = load i32, i32* %.97
  %.300 = add i32 %.299, 1
  store i32 %.300, i32* %.97
  br label %.144wc37 
.164wc41:
  %.168 = load i32, i32* %.162
  %.169 = load i32, i32* %.95
  %.170 = icmp slt i32 %.168, %.169
  br i1 %.170, label %.165wloop.41.58, label %.166wn58
.165wloop.41.58:
  %.172 = load i32, i32* %.95
  call void @putint(i32 %.172)
  call void @putch(i32 10)
  %.178 = load i32, i32* %.152
  call void @putint(i32 %.178)
  call void @putch(i32 10)
  %.181 = load i32, i32* %.162
  call void @putint(i32 %.181)
  call void @putch(i32 10)
  %.186 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.187 = load i32, i32* %.95
  %.188 = load i32, i32* %.152
  %.189 = load i32, i32* %.97
  %.190at45 = call i32 @getvalue(i32* %.186, i32 %.187, i32 %.188, i32 %.189)
  %.191 = icmp sge i32 %.190at45, 0
  br i1 %.191, label %.192, label %.185
.166wn58:
  %.295 = load i32, i32* %.152
  %.296 = add i32 %.295, 1
  store i32 %.296, i32* %.152
  br label %.154wc39 
.184:
  %.203 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.204 = load i32, i32* %.95
  %.205 = load i32, i32* %.152
  %.206 = load i32, i32* %.162
  %.207at46 = call i32 @getvalue(i32* %.203, i32 %.204, i32 %.205, i32 %.206)
  %.208 = icmp slt i32 %.207at46, 0
  br i1 %.208, label %.201, label %.202
.185:
  %.291 = load i32, i32* %.162
  %.292 = add i32 %.291, 1
  store i32 %.292, i32* %.162
  br label %.164wc41 
.192:
  %.194 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.195 = load i32, i32* %.95
  %.196 = load i32, i32* %.97
  %.197 = load i32, i32* %.162
  %.198at45 = call i32 @getvalue(i32* %.194, i32 %.195, i32 %.196, i32 %.197)
  %.199 = icmp sge i32 %.198at45, 0
  br i1 %.199, label %.184, label %.185
.201:
  %.210 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.211 = load i32, i32* %.95
  %.212 = load i32, i32* %.152
  %.213 = load i32, i32* %.97
  %.214at47 = call i32 @getvalue(i32* %.210, i32 %.211, i32 %.212, i32 %.213)
  %.215 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.216 = load i32, i32* %.95
  %.217 = load i32, i32* %.97
  %.218 = load i32, i32* %.162
  %.219at47 = call i32 @getvalue(i32* %.215, i32 %.216, i32 %.217, i32 %.218)
  %.220 = add i32 %.214at47, %.219at47
  %.221 = load i32, i32* %.152
  %.222 = load i32, i32* %.95
  %.223 = mul i32 %.221, %.222
  %.224 = load i32, i32* %.162
  %.225 = add i32 %.223, %.224
  %.226 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 %.225
  store i32 %.220, i32* %.226
  %.228 = load i32, i32* %.152
  %.229 = load i32, i32* %.95
  %.230 = mul i32 %.228, %.229
  %.231 = load i32, i32* %.162
  %.232 = add i32 %.230, %.231
  %.233 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 %.232
  %.234 = load i32, i32* %.233
  call void @putint(i32 %.234)
  call void @putch(i32 10)
  br label %.237 
.202:
  %.241 = load i32, i32* %.152
  %.242 = load i32, i32* %.95
  %.243 = mul i32 %.241, %.242
  %.244 = load i32, i32* %.162
  %.245 = add i32 %.243, %.244
  %.246 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 %.245
  %.247 = load i32, i32* %.246
  %.248 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.249 = load i32, i32* %.95
  %.250 = load i32, i32* %.152
  %.251 = load i32, i32* %.97
  %.252at51 = call i32 @getvalue(i32* %.248, i32 %.249, i32 %.250, i32 %.251)
  %.253 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.254 = load i32, i32* %.95
  %.255 = load i32, i32* %.97
  %.256 = load i32, i32* %.162
  %.257at51 = call i32 @getvalue(i32* %.253, i32 %.254, i32 %.255, i32 %.256)
  %.258 = add i32 %.252at51, %.257at51
  %.259 = icmp sgt i32 %.247, %.258
  br i1 %.259, label %.239, label %.240
.237:
  br label %.185 
.239:
  %.261 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.262 = load i32, i32* %.95
  %.263 = load i32, i32* %.152
  %.264 = load i32, i32* %.97
  %.265at52 = call i32 @getvalue(i32* %.261, i32 %.262, i32 %.263, i32 %.264)
  %.266 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 0
  %.267 = load i32, i32* %.95
  %.268 = load i32, i32* %.97
  %.269 = load i32, i32* %.162
  %.270at52 = call i32 @getvalue(i32* %.266, i32 %.267, i32 %.268, i32 %.269)
  %.271 = add i32 %.265at52, %.270at52
  %.272 = load i32, i32* %.152
  %.273 = load i32, i32* %.95
  %.274 = mul i32 %.272, %.273
  %.275 = load i32, i32* %.162
  %.276 = add i32 %.274, %.275
  %.277 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 %.276
  store i32 %.271, i32* %.277
  %.279 = load i32, i32* %.152
  %.280 = load i32, i32* %.95
  %.281 = mul i32 %.279, %.280
  %.282 = load i32, i32* %.162
  %.283 = add i32 %.281, %.282
  %.284 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.temp, i32 0, i32 %.283
  %.285 = load i32, i32* %.284
  call void @putint(i32 %.285)
  call void @putch(i32 10)
  br label %.240 
.240:
  br label %.237 
}
define i32 @main(){
.311:
  %.312 = alloca i32
  %.314at68 = call i32 @getint()
  store i32 %.314at68, i32* %.312
  %.316 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.w, i32 0, i32 0
  %.318at69 = call i32 @getarray(i32* %.316)
  %.319 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.w, i32 0, i32 0
  %.320 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.G.dst, i32 0, i32 0
  %.321 = load i32, i32* %.312
  call void @floyd(i32* %.319, i32* %.320, i32 %.321)
  ret i32 0 
}
