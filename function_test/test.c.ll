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
define i32 @func(i32 %.3){
.1:
  %.14 = alloca [100 x i32]
  br label %.17wc8 
.17wc8:
  %.979 = phi i32 [0, %.1], [%.29, %.18wloop.8.11]
  %.22 = icmp slt i32 %.979, 100
  br i1 %.22, label %.18wloop.8.11, label %.19wn11
.18wloop.8.11:
  %.25 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 %.979
  store i32 0, i32* %.25
  %.29 = add i32 %.979, 1
  br label %.17wc8 
.19wn11:
  br label %.32wc12 
.32wc12:
  %.982 = phi i32 [0, %.19wn11], [%.954, %.937wn315]
  %.980 = phi i32 [0, %.19wn11], [%.931, %.937wn315]
  %.38 = icmp slt i32 %.980, %.3
  br i1 %.38, label %.33wloop.12.318, label %.34wn318
.33wloop.12.318:
  %.43 = icmp sgt i32 200, 1
  br i1 %.43, label %.40, label %.41
.34wn318:
  ret i32 %.982 
.40:
  %.45 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 1
  store i32 1, i32* %.45
  %.51 = icmp sgt i32 200, 2
  br i1 %.51, label %.47, label %.48
.41:
  %.931 = add i32 %.980, 1
  br label %.935wc312 
.47:
  %.53 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 2
  store i32 2, i32* %.53
  %.59 = icmp sgt i32 200, 3
  br i1 %.59, label %.55, label %.56
.48:
  br label %.41 
.55:
  %.61 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 3
  store i32 3, i32* %.61
  %.67 = icmp sgt i32 200, 4
  br i1 %.67, label %.63, label %.64
.56:
  br label %.48 
.63:
  %.69 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 4
  store i32 4, i32* %.69
  %.75 = icmp sgt i32 200, 5
  br i1 %.75, label %.71, label %.72
.64:
  br label %.56 
.71:
  %.77 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 5
  store i32 5, i32* %.77
  %.83 = icmp sgt i32 200, 6
  br i1 %.83, label %.79, label %.80
.72:
  br label %.64 
.79:
  %.85 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 6
  store i32 6, i32* %.85
  %.91 = icmp sgt i32 200, 7
  br i1 %.91, label %.87, label %.88
.80:
  br label %.72 
.87:
  %.93 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 7
  store i32 7, i32* %.93
  %.99 = icmp sgt i32 200, 8
  br i1 %.99, label %.95, label %.96
.88:
  br label %.80 
.95:
  %.101 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 8
  store i32 8, i32* %.101
  %.107 = icmp sgt i32 200, 9
  br i1 %.107, label %.103, label %.104
.96:
  br label %.88 
.103:
  %.109 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 9
  store i32 9, i32* %.109
  %.115 = icmp sgt i32 200, 10
  br i1 %.115, label %.111, label %.112
.104:
  br label %.96 
.111:
  %.117 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 10
  store i32 10, i32* %.117
  %.123 = icmp sgt i32 200, 11
  br i1 %.123, label %.119, label %.120
.112:
  br label %.104 
.119:
  %.125 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 11
  store i32 11, i32* %.125
  %.131 = icmp sgt i32 200, 12
  br i1 %.131, label %.127, label %.128
.120:
  br label %.112 
.127:
  %.133 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 12
  store i32 12, i32* %.133
  %.139 = icmp sgt i32 200, 13
  br i1 %.139, label %.135, label %.136
.128:
  br label %.120 
.135:
  %.141 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 13
  store i32 13, i32* %.141
  %.147 = icmp sgt i32 200, 14
  br i1 %.147, label %.143, label %.144
.136:
  br label %.128 
.143:
  %.149 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 14
  store i32 14, i32* %.149
  %.155 = icmp sgt i32 200, 15
  br i1 %.155, label %.151, label %.152
.144:
  br label %.136 
.151:
  %.157 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 15
  store i32 15, i32* %.157
  %.163 = icmp sgt i32 200, 16
  br i1 %.163, label %.159, label %.160
.152:
  br label %.144 
.159:
  %.165 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 16
  store i32 16, i32* %.165
  %.171 = icmp sgt i32 200, 17
  br i1 %.171, label %.167, label %.168
.160:
  br label %.152 
.167:
  %.173 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 17
  store i32 17, i32* %.173
  %.179 = icmp sgt i32 200, 18
  br i1 %.179, label %.175, label %.176
.168:
  br label %.160 
.175:
  %.181 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 18
  store i32 18, i32* %.181
  %.187 = icmp sgt i32 200, 19
  br i1 %.187, label %.183, label %.184
.176:
  br label %.168 
.183:
  %.189 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 19
  store i32 19, i32* %.189
  %.195 = icmp sgt i32 200, 20
  br i1 %.195, label %.191, label %.192
.184:
  br label %.176 
.191:
  %.197 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 20
  store i32 20, i32* %.197
  %.203 = icmp sgt i32 200, 21
  br i1 %.203, label %.199, label %.200
.192:
  br label %.184 
.199:
  %.205 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 21
  store i32 21, i32* %.205
  %.211 = icmp sgt i32 200, 22
  br i1 %.211, label %.207, label %.208
.200:
  br label %.192 
.207:
  %.213 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 22
  store i32 22, i32* %.213
  %.219 = icmp sgt i32 200, 23
  br i1 %.219, label %.215, label %.216
.208:
  br label %.200 
.215:
  %.221 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 23
  store i32 23, i32* %.221
  %.227 = icmp sgt i32 200, 24
  br i1 %.227, label %.223, label %.224
.216:
  br label %.208 
.223:
  %.229 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 24
  store i32 24, i32* %.229
  %.235 = icmp sgt i32 200, 25
  br i1 %.235, label %.231, label %.232
.224:
  br label %.216 
.231:
  %.237 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 25
  store i32 25, i32* %.237
  %.243 = icmp sgt i32 200, 26
  br i1 %.243, label %.239, label %.240
.232:
  br label %.224 
.239:
  %.245 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 26
  store i32 26, i32* %.245
  %.251 = icmp sgt i32 200, 27
  br i1 %.251, label %.247, label %.248
.240:
  br label %.232 
.247:
  %.253 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 27
  store i32 27, i32* %.253
  %.259 = icmp sgt i32 200, 28
  br i1 %.259, label %.255, label %.256
.248:
  br label %.240 
.255:
  %.261 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 28
  store i32 28, i32* %.261
  %.267 = icmp sgt i32 200, 29
  br i1 %.267, label %.263, label %.264
.256:
  br label %.248 
.263:
  %.269 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 29
  store i32 29, i32* %.269
  %.275 = icmp sgt i32 200, 30
  br i1 %.275, label %.271, label %.272
.264:
  br label %.256 
.271:
  %.277 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 30
  store i32 30, i32* %.277
  %.283 = icmp sgt i32 200, 31
  br i1 %.283, label %.279, label %.280
.272:
  br label %.264 
.279:
  %.285 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 31
  store i32 31, i32* %.285
  %.291 = icmp sgt i32 200, 32
  br i1 %.291, label %.287, label %.288
.280:
  br label %.272 
.287:
  %.293 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 32
  store i32 32, i32* %.293
  %.299 = icmp sgt i32 200, 33
  br i1 %.299, label %.295, label %.296
.288:
  br label %.280 
.295:
  %.301 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 33
  store i32 33, i32* %.301
  %.307 = icmp sgt i32 200, 34
  br i1 %.307, label %.303, label %.304
.296:
  br label %.288 
.303:
  %.309 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 34
  store i32 34, i32* %.309
  %.315 = icmp sgt i32 200, 35
  br i1 %.315, label %.311, label %.312
.304:
  br label %.296 
.311:
  %.317 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 35
  store i32 35, i32* %.317
  %.323 = icmp sgt i32 200, 36
  br i1 %.323, label %.319, label %.320
.312:
  br label %.304 
.319:
  %.325 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 36
  store i32 36, i32* %.325
  %.331 = icmp sgt i32 200, 37
  br i1 %.331, label %.327, label %.328
.320:
  br label %.312 
.327:
  %.333 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 37
  store i32 37, i32* %.333
  %.339 = icmp sgt i32 200, 38
  br i1 %.339, label %.335, label %.336
.328:
  br label %.320 
.335:
  %.341 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 38
  store i32 38, i32* %.341
  %.347 = icmp sgt i32 200, 39
  br i1 %.347, label %.343, label %.344
.336:
  br label %.328 
.343:
  %.349 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 39
  store i32 39, i32* %.349
  %.355 = icmp sgt i32 200, 40
  br i1 %.355, label %.351, label %.352
.344:
  br label %.336 
.351:
  %.357 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 40
  store i32 40, i32* %.357
  %.363 = icmp sgt i32 200, 41
  br i1 %.363, label %.359, label %.360
.352:
  br label %.344 
.359:
  %.365 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 41
  store i32 41, i32* %.365
  %.371 = icmp sgt i32 200, 42
  br i1 %.371, label %.367, label %.368
.360:
  br label %.352 
.367:
  %.373 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 42
  store i32 42, i32* %.373
  %.379 = icmp sgt i32 200, 43
  br i1 %.379, label %.375, label %.376
.368:
  br label %.360 
.375:
  %.381 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 43
  store i32 43, i32* %.381
  %.387 = icmp sgt i32 200, 44
  br i1 %.387, label %.383, label %.384
.376:
  br label %.368 
.383:
  %.389 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 44
  store i32 44, i32* %.389
  %.395 = icmp sgt i32 200, 45
  br i1 %.395, label %.391, label %.392
.384:
  br label %.376 
.391:
  %.397 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 45
  store i32 45, i32* %.397
  %.403 = icmp sgt i32 200, 46
  br i1 %.403, label %.399, label %.400
.392:
  br label %.384 
.399:
  %.405 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 46
  store i32 46, i32* %.405
  %.411 = icmp sgt i32 200, 47
  br i1 %.411, label %.407, label %.408
.400:
  br label %.392 
.407:
  %.413 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 47
  store i32 47, i32* %.413
  %.419 = icmp sgt i32 200, 48
  br i1 %.419, label %.415, label %.416
.408:
  br label %.400 
.415:
  %.421 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 48
  store i32 48, i32* %.421
  %.427 = icmp sgt i32 200, 49
  br i1 %.427, label %.423, label %.424
.416:
  br label %.408 
.423:
  %.429 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 49
  store i32 49, i32* %.429
  %.435 = icmp sgt i32 200, 50
  br i1 %.435, label %.431, label %.432
.424:
  br label %.416 
.431:
  %.437 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 50
  store i32 50, i32* %.437
  %.443 = icmp sgt i32 200, 51
  br i1 %.443, label %.439, label %.440
.432:
  br label %.424 
.439:
  %.445 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 51
  store i32 51, i32* %.445
  %.451 = icmp sgt i32 200, 52
  br i1 %.451, label %.447, label %.448
.440:
  br label %.432 
.447:
  %.453 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 52
  store i32 52, i32* %.453
  %.459 = icmp sgt i32 200, 53
  br i1 %.459, label %.455, label %.456
.448:
  br label %.440 
.455:
  %.461 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 53
  store i32 53, i32* %.461
  %.467 = icmp sgt i32 200, 54
  br i1 %.467, label %.463, label %.464
.456:
  br label %.448 
.463:
  %.469 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 54
  store i32 54, i32* %.469
  %.475 = icmp sgt i32 200, 55
  br i1 %.475, label %.471, label %.472
.464:
  br label %.456 
.471:
  %.477 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 55
  store i32 55, i32* %.477
  %.483 = icmp sgt i32 200, 56
  br i1 %.483, label %.479, label %.480
.472:
  br label %.464 
.479:
  %.485 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 56
  store i32 56, i32* %.485
  %.491 = icmp sgt i32 200, 57
  br i1 %.491, label %.487, label %.488
.480:
  br label %.472 
.487:
  %.493 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 57
  store i32 57, i32* %.493
  %.499 = icmp sgt i32 200, 58
  br i1 %.499, label %.495, label %.496
.488:
  br label %.480 
.495:
  %.501 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 58
  store i32 58, i32* %.501
  %.507 = icmp sgt i32 200, 59
  br i1 %.507, label %.503, label %.504
.496:
  br label %.488 
.503:
  %.509 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 59
  store i32 59, i32* %.509
  %.515 = icmp sgt i32 200, 60
  br i1 %.515, label %.511, label %.512
.504:
  br label %.496 
.511:
  %.517 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 60
  store i32 60, i32* %.517
  %.523 = icmp sgt i32 200, 61
  br i1 %.523, label %.519, label %.520
.512:
  br label %.504 
.519:
  %.525 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 61
  store i32 61, i32* %.525
  %.531 = icmp sgt i32 200, 62
  br i1 %.531, label %.527, label %.528
.520:
  br label %.512 
.527:
  %.533 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 62
  store i32 62, i32* %.533
  %.539 = icmp sgt i32 200, 63
  br i1 %.539, label %.535, label %.536
.528:
  br label %.520 
.535:
  %.541 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 63
  store i32 63, i32* %.541
  %.547 = icmp sgt i32 200, 64
  br i1 %.547, label %.543, label %.544
.536:
  br label %.528 
.543:
  %.549 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 64
  store i32 64, i32* %.549
  %.555 = icmp sgt i32 200, 65
  br i1 %.555, label %.551, label %.552
.544:
  br label %.536 
.551:
  %.557 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 65
  store i32 65, i32* %.557
  %.563 = icmp sgt i32 200, 66
  br i1 %.563, label %.559, label %.560
.552:
  br label %.544 
.559:
  %.565 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 66
  store i32 66, i32* %.565
  %.571 = icmp sgt i32 200, 67
  br i1 %.571, label %.567, label %.568
.560:
  br label %.552 
.567:
  %.573 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 67
  store i32 67, i32* %.573
  %.579 = icmp sgt i32 200, 68
  br i1 %.579, label %.575, label %.576
.568:
  br label %.560 
.575:
  %.581 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 68
  store i32 68, i32* %.581
  %.587 = icmp sgt i32 200, 69
  br i1 %.587, label %.583, label %.584
.576:
  br label %.568 
.583:
  %.589 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 69
  store i32 69, i32* %.589
  %.595 = icmp sgt i32 200, 70
  br i1 %.595, label %.591, label %.592
.584:
  br label %.576 
.591:
  %.597 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 70
  store i32 70, i32* %.597
  %.603 = icmp sgt i32 200, 71
  br i1 %.603, label %.599, label %.600
.592:
  br label %.584 
.599:
  %.605 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 71
  store i32 71, i32* %.605
  %.611 = icmp sgt i32 200, 72
  br i1 %.611, label %.607, label %.608
.600:
  br label %.592 
.607:
  %.613 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 72
  store i32 72, i32* %.613
  %.619 = icmp sgt i32 200, 73
  br i1 %.619, label %.615, label %.616
.608:
  br label %.600 
.615:
  %.621 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 73
  store i32 73, i32* %.621
  %.627 = icmp sgt i32 200, 74
  br i1 %.627, label %.623, label %.624
.616:
  br label %.608 
.623:
  %.629 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 74
  store i32 74, i32* %.629
  %.635 = icmp sgt i32 200, 75
  br i1 %.635, label %.631, label %.632
.624:
  br label %.616 
.631:
  %.637 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 75
  store i32 75, i32* %.637
  %.643 = icmp sgt i32 200, 76
  br i1 %.643, label %.639, label %.640
.632:
  br label %.624 
.639:
  %.645 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 76
  store i32 76, i32* %.645
  %.651 = icmp sgt i32 200, 77
  br i1 %.651, label %.647, label %.648
.640:
  br label %.632 
.647:
  %.653 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 77
  store i32 77, i32* %.653
  %.659 = icmp sgt i32 200, 78
  br i1 %.659, label %.655, label %.656
.648:
  br label %.640 
.655:
  %.661 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 78
  store i32 78, i32* %.661
  %.667 = icmp sgt i32 200, 79
  br i1 %.667, label %.663, label %.664
.656:
  br label %.648 
.663:
  %.669 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 79
  store i32 79, i32* %.669
  %.675 = icmp sgt i32 200, 80
  br i1 %.675, label %.671, label %.672
.664:
  br label %.656 
.671:
  %.677 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 80
  store i32 80, i32* %.677
  %.683 = icmp sgt i32 200, 81
  br i1 %.683, label %.679, label %.680
.672:
  br label %.664 
.679:
  %.685 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 81
  store i32 81, i32* %.685
  %.691 = icmp sgt i32 200, 82
  br i1 %.691, label %.687, label %.688
.680:
  br label %.672 
.687:
  %.693 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 82
  store i32 82, i32* %.693
  %.699 = icmp sgt i32 200, 83
  br i1 %.699, label %.695, label %.696
.688:
  br label %.680 
.695:
  %.701 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 83
  store i32 83, i32* %.701
  %.707 = icmp sgt i32 200, 84
  br i1 %.707, label %.703, label %.704
.696:
  br label %.688 
.703:
  %.709 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 84
  store i32 84, i32* %.709
  %.715 = icmp sgt i32 200, 85
  br i1 %.715, label %.711, label %.712
.704:
  br label %.696 
.711:
  %.717 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 85
  store i32 85, i32* %.717
  %.723 = icmp sgt i32 200, 86
  br i1 %.723, label %.719, label %.720
.712:
  br label %.704 
.719:
  %.725 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 86
  store i32 86, i32* %.725
  %.731 = icmp sgt i32 200, 87
  br i1 %.731, label %.727, label %.728
.720:
  br label %.712 
.727:
  %.733 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 87
  store i32 87, i32* %.733
  %.739 = icmp sgt i32 200, 88
  br i1 %.739, label %.735, label %.736
.728:
  br label %.720 
.735:
  %.741 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 88
  store i32 88, i32* %.741
  %.747 = icmp sgt i32 200, 89
  br i1 %.747, label %.743, label %.744
.736:
  br label %.728 
.743:
  %.749 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 89
  store i32 89, i32* %.749
  %.755 = icmp sgt i32 200, 90
  br i1 %.755, label %.751, label %.752
.744:
  br label %.736 
.751:
  %.757 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 90
  store i32 90, i32* %.757
  %.763 = icmp sgt i32 200, 91
  br i1 %.763, label %.759, label %.760
.752:
  br label %.744 
.759:
  %.765 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 91
  store i32 91, i32* %.765
  %.771 = icmp sgt i32 200, 92
  br i1 %.771, label %.767, label %.768
.760:
  br label %.752 
.767:
  %.773 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 92
  store i32 92, i32* %.773
  %.779 = icmp sgt i32 200, 93
  br i1 %.779, label %.775, label %.776
.768:
  br label %.760 
.775:
  %.781 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 93
  store i32 93, i32* %.781
  %.787 = icmp sgt i32 200, 94
  br i1 %.787, label %.783, label %.784
.776:
  br label %.768 
.783:
  %.789 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 94
  store i32 94, i32* %.789
  %.795 = icmp sgt i32 200, 95
  br i1 %.795, label %.791, label %.792
.784:
  br label %.776 
.791:
  %.797 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 95
  store i32 95, i32* %.797
  %.803 = icmp sgt i32 200, 96
  br i1 %.803, label %.799, label %.800
.792:
  br label %.784 
.799:
  %.805 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 96
  store i32 96, i32* %.805
  %.811 = icmp sgt i32 200, 97
  br i1 %.811, label %.807, label %.808
.800:
  br label %.792 
.807:
  %.813 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 97
  store i32 97, i32* %.813
  %.819 = icmp sgt i32 200, 98
  br i1 %.819, label %.815, label %.816
.808:
  br label %.800 
.815:
  %.821 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 98
  store i32 98, i32* %.821
  %.827 = icmp sgt i32 200, 99
  br i1 %.827, label %.823, label %.824
.816:
  br label %.808 
.823:
  %.829 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 99
  store i32 99, i32* %.829
  br label %.824 
.824:
  br label %.816 
.935wc312:
  %.981 = phi i32 [%.982, %.41], [%.946, %.936wloop.312.315]
  %.978 = phi i32 [0, %.41], [%.949, %.936wloop.312.315]
  %.940 = icmp slt i32 %.978, 100
  br i1 %.940, label %.936wloop.312.315, label %.937wn315
.936wloop.312.315:
  %.944 = getelementptr inbounds [100 x i32], [100 x i32]* %.14, i32 0, i32 %.978
  %.945 = load i32, i32* %.944
  %.946 = add i32 %.981, %.945
  %.949 = add i32 %.978, 1
  br label %.935wc312 
.937wn315:
  %.954 = srem i32 %.981, 65535
  br label %.32wc12 
}
define i32 @main(){
.960:
  call void @_sysy_starttime(i32 324)
  %.966at325 = call i32 @getint()
  %.969at326 = call i32 @func(i32 %.966at325)
  call void @putint(i32 %.969at326)
  call void @putch(i32 10)
  call void @_sysy_stoptime(i32 328)
  ret i32 0 
}
