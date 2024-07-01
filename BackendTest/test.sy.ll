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
@.G.arr1 = global [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]] zeroinitializer
@.G.arr2 = global [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]] zeroinitializer
@.G.int1 = global i32 zeroinitializer
@.G.int2 = global i32 2
@.G.float1 = global float 0x3ff19999a0000000
@.G.float2 = global float zeroinitializer
define void @loop1(i32 %.17, i32 %.20){
.16:
  br label %.32wc11 
.32wc11:
  %.505 = phi i32 [0, %.16], [%.145, %.48wn36]
  %.38 = icmp slt i32 %.505, %.17
  br i1 %.38, label %.39, label %.34wn38
.34wn38:
  ret void
.39:
  %.43 = icmp slt i32 %.505, %.20
  br i1 %.43, label %.522_preheader, label %.34wn38
.46wc13:
  %.504 = phi i32 [0, %.522_preheader], [%.141, %.56wn34]
  %.51 = icmp slt i32 %.504, 2
  br i1 %.51, label %.520_preheader, label %.48wn36
.48wn36:
  %.145 = add i32 %.505, 1
  br label %.32wc11 
.54wc15:
  %.503 = phi i32 [0, %.520_preheader], [%.137, %.64wn32]
  %.59 = icmp slt i32 %.503, 3
  br i1 %.59, label %.518_preheader, label %.56wn34
.56wn34:
  %.141 = add i32 %.504, 1
  br label %.46wc13 
.62wc17:
  %.502 = phi i32 [0, %.518_preheader], [%.133, %.72wn30]
  %.67 = icmp slt i32 %.502, 4
  br i1 %.67, label %.516_preheader, label %.64wn32
.64wn32:
  %.137 = add i32 %.503, 1
  br label %.54wc15 
.70wc19:
  %.501 = phi i32 [0, %.516_preheader], [%.129, %.80wn28]
  %.75 = icmp slt i32 %.501, 5
  br i1 %.75, label %.514_preheader, label %.72wn30
.72wn30:
  %.133 = add i32 %.502, 1
  br label %.62wc17 
.78wc21:
  %.500 = phi i32 [0, %.514_preheader], [%.125, %.88wn26]
  %.83 = icmp slt i32 %.500, 6
  br i1 %.83, label %.512_preheader, label %.80wn28
.80wn28:
  %.129 = add i32 %.501, 1
  br label %.70wc19 
.86wc23:
  %.499 = phi i32 [0, %.512_preheader], [%.121, %.87wloop.23.26]
  %.91 = icmp slt i32 %.499, 2
  br i1 %.91, label %.87wloop.23.26, label %.88wn26
.87wloop.23.26:
  %.95 = add i32 %.505, %.504
  %.97 = add i32 %.503, %.95
  %.99 = add i32 %.502, %.97
  %.101 = add i32 %.501, %.99
  %.103 = add i32 %.500, %.101
  %.105 = add i32 %.499, %.103
  %.107 = add i32 %.17, %.105
  %.109 = add i32 %.20, %.107
  %.117 = getelementptr inbounds [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]], [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]]* @.G.arr1, i32 0, i32 %.505, i32 %.504, i32 %.503, i32 %.502, i32 %.501, i32 %.500, i32 %.499
  store i32 %.109, i32* %.117
  %.121 = add i32 %.499, 1
  br label %.86wc23 
.88wn26:
  %.125 = add i32 %.500, 1
  br label %.78wc21 
.512_preheader:
  br label %.86wc23 
.514_preheader:
  br label %.78wc21 
.516_preheader:
  br label %.70wc19 
.518_preheader:
  br label %.62wc17 
.520_preheader:
  br label %.54wc15 
.522_preheader:
  br label %.46wc13 
}
define void @loop2(){
.150:
  br label %.159wc44 
.159wc44:
  %.530 = phi i32 [0, %.150], [%.255, %.169wn69]
  %.164 = icmp slt i32 %.530, 10
  br i1 %.164, label %.541_preheader, label %.161wn71
.161wn71:
  ret void
.167wc46:
  %.529 = phi i32 [0, %.541_preheader], [%.251, %.177wn67]
  %.172 = icmp slt i32 %.529, 2
  br i1 %.172, label %.539_preheader, label %.169wn69
.169wn69:
  %.255 = add i32 %.530, 1
  br label %.159wc44 
.175wc48:
  %.528 = phi i32 [0, %.539_preheader], [%.247, %.185wn65]
  %.180 = icmp slt i32 %.528, 3
  br i1 %.180, label %.537_preheader, label %.177wn67
.177wn67:
  %.251 = add i32 %.529, 1
  br label %.167wc46 
.183wc50:
  %.527 = phi i32 [0, %.537_preheader], [%.243, %.193wn63]
  %.188 = icmp slt i32 %.527, 2
  br i1 %.188, label %.535_preheader, label %.185wn65
.185wn65:
  %.247 = add i32 %.528, 1
  br label %.175wc48 
.191wc52:
  %.526 = phi i32 [0, %.535_preheader], [%.239, %.201wn61]
  %.196 = icmp slt i32 %.526, 4
  br i1 %.196, label %.533_preheader, label %.193wn63
.193wn63:
  %.243 = add i32 %.527, 1
  br label %.183wc50 
.199wc54:
  %.525 = phi i32 [0, %.533_preheader], [%.235, %.209wn59]
  %.204 = icmp slt i32 %.525, 8
  br i1 %.204, label %.531_preheader, label %.201wn61
.201wn61:
  %.239 = add i32 %.526, 1
  br label %.191wc52 
.207wc56:
  %.524 = phi i32 [0, %.531_preheader], [%.231, %.208wloop.56.59]
  %.212 = icmp slt i32 %.524, 7
  br i1 %.212, label %.208wloop.56.59, label %.209wn59
.208wloop.56.59:
  %.216 = add i32 %.530, %.529
  %.218 = add i32 %.527, %.216
  %.220 = add i32 %.524, %.218
  %.228 = getelementptr inbounds [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]], [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]]* @.G.arr2, i32 0, i32 %.530, i32 %.529, i32 %.528, i32 %.527, i32 %.526, i32 %.525, i32 %.524
  store i32 %.220, i32* %.228
  %.231 = add i32 %.524, 1
  br label %.207wc56 
.209wn59:
  %.235 = add i32 %.525, 1
  br label %.199wc54 
.531_preheader:
  br label %.207wc56 
.533_preheader:
  br label %.199wc54 
.535_preheader:
  br label %.191wc52 
.537_preheader:
  br label %.183wc50 
.539_preheader:
  br label %.175wc48 
.541_preheader:
  br label %.167wc46 
}
define i32 @loop3(i32 %.261, i32 %.264, i32 %.267, i32 %.270, i32 %.273, i32 %.276, i32 %.279){
.260:
  br label %.292wc78 
.292wc78:
  %.563 = phi i32 [0, %.260], [%.444, %.302wn109]
  %.556 = phi i32 [0, %.260], [%.553, %.302wn109]
  %.297 = icmp slt i32 %.563, 10
  br i1 %.297, label %.588_preheader, label %.294wn112
.294wn112:
  %.555 = phi i32 [%.556, %.292wc78], [%.553, %.302wn109]
  ret i32 %.555 
.300wc80:
  %.562 = phi i32 [0, %.588_preheader], [%.433, %.311wn106]
  %.554 = phi i32 [%.556, %.588_preheader], [%.551, %.311wn106]
  %.306 = icmp slt i32 %.562, 100
  br i1 %.306, label %.586_preheader, label %.302wn109
.302wn109:
  %.553 = phi i32 [%.554, %.300wc80], [%.551, %.311wn106]
  %.444 = add i32 %.563, 1
  %.450 = icmp sge i32 %.444, %.261
  br i1 %.450, label %.294wn112, label %.292wc78
.309wc82:
  %.561 = phi i32 [0, %.586_preheader], [%.422, %.320wn103]
  %.552 = phi i32 [%.554, %.586_preheader], [%.549, %.320wn103]
  %.315 = icmp slt i32 %.561, 1000
  br i1 %.315, label %.584_preheader, label %.311wn106
.311wn106:
  %.551 = phi i32 [%.552, %.309wc82], [%.549, %.320wn103]
  %.433 = add i32 %.562, 1
  %.439 = icmp sge i32 %.433, %.264
  br i1 %.439, label %.302wn109, label %.300wc80
.318wc84:
  %.560 = phi i32 [0, %.584_preheader], [%.411, %.329wn100]
  %.550 = phi i32 [%.552, %.584_preheader], [%.547, %.329wn100]
  %.324 = icmp slt i32 %.560, 10000
  br i1 %.324, label %.582_preheader, label %.320wn103
.320wn103:
  %.549 = phi i32 [%.550, %.318wc84], [%.547, %.329wn100]
  %.422 = add i32 %.561, 1
  %.428 = icmp sge i32 %.422, %.267
  br i1 %.428, label %.311wn106, label %.309wc82
.327wc86:
  %.559 = phi i32 [0, %.582_preheader], [%.400, %.338wn97]
  %.548 = phi i32 [%.550, %.582_preheader], [%.545, %.338wn97]
  %.333 = icmp slt i32 %.559, 100000
  br i1 %.333, label %.580_preheader, label %.329wn100
.329wn100:
  %.547 = phi i32 [%.548, %.327wc86], [%.545, %.338wn97]
  %.411 = add i32 %.560, 1
  %.417 = icmp sge i32 %.411, %.270
  br i1 %.417, label %.320wn103, label %.318wc84
.336wc88:
  %.558 = phi i32 [0, %.580_preheader], [%.389, %.347wn94]
  %.546 = phi i32 [%.548, %.580_preheader], [%.543, %.347wn94]
  %.342 = icmp slt i32 %.558, 1000000
  br i1 %.342, label %.578_preheader, label %.338wn97
.338wn97:
  %.545 = phi i32 [%.546, %.336wc88], [%.543, %.347wn94]
  %.400 = add i32 %.559, 1
  %.406 = icmp sge i32 %.400, %.273
  br i1 %.406, label %.329wn100, label %.327wc86
.345wc90:
  %.557 = phi i32 [0, %.578_preheader], [%.378, %.346wloop.90.94]
  %.544 = phi i32 [%.546, %.578_preheader], [%.375, %.346wloop.90.94]
  %.351 = icmp slt i32 %.557, 10000000
  br i1 %.351, label %.346wloop.90.94, label %.347wn94
.346wloop.90.94:
  %.355 = srem i32 %.544, 817
  %.363 = getelementptr inbounds [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]], [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]]* @.G.arr1, i32 0, i32 %.563, i32 %.562, i32 %.561, i32 %.560, i32 %.559, i32 %.558, i32 %.557
  %.364 = load i32, i32* %.363
  %.365 = add i32 %.364, %.355
  %.373 = getelementptr inbounds [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]], [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]]* @.G.arr2, i32 0, i32 %.563, i32 %.562, i32 %.561, i32 %.560, i32 %.559, i32 %.558, i32 %.557
  %.374 = load i32, i32* %.373
  %.375 = add i32 %.374, %.365
  %.378 = add i32 %.557, 1
  %.384 = icmp sge i32 %.378, %.279
  br i1 %.384, label %.347wn94, label %.345wc90
.347wn94:
  %.543 = phi i32 [%.544, %.345wc90], [%.375, %.346wloop.90.94]
  %.389 = add i32 %.558, 1
  %.395 = icmp sge i32 %.389, %.276
  br i1 %.395, label %.338wn97, label %.336wc88
.578_preheader:
  br label %.345wc90 
.580_preheader:
  br label %.336wc88 
.582_preheader:
  br label %.327wc86 
.584_preheader:
  br label %.318wc84 
.586_preheader:
  br label %.309wc82 
.588_preheader:
  br label %.300wc80 
}
define i32 @main(){
.457:
  %.460at117 = call i32 @getint()
  %.463at118 = call i32 @getint()
  %.466at119 = call i32 @getint()
  %.469at120 = call i32 @getint()
  %.472at120 = call i32 @getint()
  %.475at121 = call i32 @getint()
  %.478at122 = call i32 @getint()
  %.481at123 = call i32 @getint()
  %.484at124 = call i32 @getint()
  call void @loop1(i32 %.460at117, i32 %.463at118)
  call void @loop2()
  %.497at127 = call i32 @loop3(i32 %.466at119, i32 %.469at120, i32 %.472at120, i32 %.475at121, i32 %.478at122, i32 %.481at123, i32 %.484at124)
  ret i32 %.497at127 
}
