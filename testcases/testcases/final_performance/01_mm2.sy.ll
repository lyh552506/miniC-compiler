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
@.g.A = global [1024 x [1024 x i32]] zeroinitializer
@.g.B = global [1024 x [1024 x i32]] zeroinitializer
@.g.C = global [1024 x [1024 x i32]] zeroinitializer
define void @mm(i32 %.4, [1024 x i32]* %.7, [1024 x i32]* %.10, [1024 x i32]* %.13){
.2:
  %.17 = alloca i32
  %.16 = alloca i32
  %.15 = alloca i32
  %.12 = alloca [1024 x i32]*
  %.9 = alloca [1024 x i32]*
  %.6 = alloca [1024 x i32]*
  %.3 = alloca i32
  store i32 %.4, i32* %.3
  store [1024 x i32]* %.7, [1024 x i32]** %.6
  store [1024 x i32]* %.10, [1024 x i32]** %.9
  store [1024 x i32]* %.13, [1024 x i32]** %.12
  store i32 0, i32* %.15
  store i32 0, i32* %.16
  br label %.21wc7 
.21wc7:
  %.25 = load i32, i32* %.15
  %.26 = load i32, i32* %.3
  %.27 = icmp slt i32 %.25, %.26
  br i1 %.27, label %.22wloop.7.14, label %.23wn14
.22wloop.7.14:
  store i32 0, i32* %.16
  br label %.30wc9 
.23wn14:
  store i32 0, i32* %.15
  store i32 0, i32* %.16
  store i32 0, i32* %.17
  br label %.55wc18 
.30wc9:
  %.34 = load i32, i32* %.16
  %.35 = load i32, i32* %.3
  %.36 = icmp slt i32 %.34, %.35
  br i1 %.36, label %.31wloop.9.12, label %.32wn12
.31wloop.9.12:
  %.38 = load i32, i32* %.15
  %.39 = load i32, i32* %.16
  %.40 = load [1024 x i32]*, [1024 x i32]** %.12
  %.41 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.40, i32 %.38, i32 %.39
  store i32 0, i32* %.41
  %.43 = load i32, i32* %.16
  %.45 = add i32 %.43, 1
  store i32 %.45, i32* %.16
  br label %.30wc9 
.32wn12:
  %.48 = load i32, i32* %.15
  %.49 = add i32 %.48, 1
  store i32 %.49, i32* %.15
  br label %.21wc7 
.55wc18:
  %.59 = load i32, i32* %.17
  %.60 = load i32, i32* %.3
  %.61 = icmp slt i32 %.59, %.60
  br i1 %.61, label %.56wloop.18.33, label %.57wn33
.56wloop.18.33:
  store i32 0, i32* %.15
  br label %.64wc20 
.57wn33:
  ret void
.64wc20:
  %.68 = load i32, i32* %.15
  %.69 = load i32, i32* %.3
  %.70 = icmp slt i32 %.68, %.69
  br i1 %.70, label %.65wloop.20.31, label %.66wn31
.65wloop.20.31:
  %.74 = load i32, i32* %.15
  %.75 = load i32, i32* %.17
  %.76 = load [1024 x i32]*, [1024 x i32]** %.6
  %.77 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.76, i32 %.74, i32 %.75
  %.78 = load i32, i32* %.77
  %.79 = icmp eq i32 %.78, 0
  br i1 %.79, label %.72, label %.73
.66wn31:
  %.124 = load i32, i32* %.17
  %.125 = add i32 %.124, 1
  store i32 %.125, i32* %.17
  br label %.55wc18 
.72:
  %.81 = load i32, i32* %.15
  %.82 = add i32 %.81, 1
  store i32 %.82, i32* %.15
  br label %.64wc20 
.73:
  store i32 0, i32* %.16
  br label %.86wc26 
.86wc26:
  %.90 = load i32, i32* %.16
  %.91 = load i32, i32* %.3
  %.92 = icmp slt i32 %.90, %.91
  br i1 %.92, label %.87wloop.26.29, label %.88wn29
.87wloop.26.29:
  %.94 = load i32, i32* %.15
  %.95 = load i32, i32* %.16
  %.96 = load [1024 x i32]*, [1024 x i32]** %.12
  %.97 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.96, i32 %.94, i32 %.95
  %.98 = load i32, i32* %.97
  %.99 = load i32, i32* %.15
  %.100 = load i32, i32* %.17
  %.101 = load [1024 x i32]*, [1024 x i32]** %.6
  %.102 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.101, i32 %.99, i32 %.100
  %.103 = load i32, i32* %.102
  %.104 = load i32, i32* %.17
  %.105 = load i32, i32* %.16
  %.106 = load [1024 x i32]*, [1024 x i32]** %.9
  %.107 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.106, i32 %.104, i32 %.105
  %.108 = load i32, i32* %.107
  %.109 = mul i32 %.103, %.108
  %.110 = add i32 %.98, %.109
  %.111 = load i32, i32* %.15
  %.112 = load i32, i32* %.16
  %.113 = load [1024 x i32]*, [1024 x i32]** %.12
  %.114 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.113, i32 %.111, i32 %.112
  store i32 %.110, i32* %.114
  %.116 = load i32, i32* %.16
  %.117 = add i32 %.116, 1
  store i32 %.117, i32* %.16
  br label %.86wc26 
.88wn29:
  %.120 = load i32, i32* %.15
  %.121 = add i32 %.120, 1
  store i32 %.121, i32* %.15
  br label %.64wc20 
}
define i32 @main(){
.133:
  %.230 = alloca i32
  %.139 = alloca i32
  %.138 = alloca i32
  %.134 = alloca i32
  %.136at41 = call i32 @getint()
  store i32 %.136at41, i32* %.134
  store i32 0, i32* %.138
  store i32 0, i32* %.139
  br label %.142wc46 
.142wc46:
  %.146 = load i32, i32* %.138
  %.147 = load i32, i32* %.134
  %.148 = icmp slt i32 %.146, %.147
  br i1 %.148, label %.143wloop.46.53, label %.144wn53
.143wloop.46.53:
  store i32 0, i32* %.139
  br label %.151wc48 
.144wn53:
  store i32 0, i32* %.138
  store i32 0, i32* %.139
  br label %.174wc56 
.151wc48:
  %.155 = load i32, i32* %.139
  %.156 = load i32, i32* %.134
  %.157 = icmp slt i32 %.155, %.156
  br i1 %.157, label %.152wloop.48.51, label %.153wn51
.152wloop.48.51:
  %.159at49 = call i32 @getint()
  %.160 = load i32, i32* %.138
  %.161 = load i32, i32* %.139
  %.162 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.A, i32 0, i32 %.160, i32 %.161
  store i32 %.159at49, i32* %.162
  %.164 = load i32, i32* %.139
  %.165 = add i32 %.164, 1
  store i32 %.165, i32* %.139
  br label %.151wc48 
.153wn51:
  %.168 = load i32, i32* %.138
  %.169 = add i32 %.168, 1
  store i32 %.169, i32* %.138
  br label %.142wc46 
.174wc56:
  %.178 = load i32, i32* %.138
  %.179 = load i32, i32* %.134
  %.180 = icmp slt i32 %.178, %.179
  br i1 %.180, label %.175wloop.56.63, label %.176wn63
.175wloop.56.63:
  store i32 0, i32* %.139
  br label %.183wc58 
.176wn63:
  call void @_sysy_starttime(i32 65)
  store i32 0, i32* %.138
  br label %.208wc68 
.183wc58:
  %.187 = load i32, i32* %.139
  %.188 = load i32, i32* %.134
  %.189 = icmp slt i32 %.187, %.188
  br i1 %.189, label %.184wloop.58.61, label %.185wn61
.184wloop.58.61:
  %.191at59 = call i32 @getint()
  %.192 = load i32, i32* %.138
  %.193 = load i32, i32* %.139
  %.194 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.B, i32 0, i32 %.192, i32 %.193
  store i32 %.191at59, i32* %.194
  %.196 = load i32, i32* %.139
  %.197 = add i32 %.196, 1
  store i32 %.197, i32* %.139
  br label %.183wc58 
.185wn61:
  %.200 = load i32, i32* %.138
  %.201 = add i32 %.200, 1
  store i32 %.201, i32* %.138
  br label %.174wc56 
.208wc68:
  %.212 = load i32, i32* %.138
  %.214 = icmp slt i32 %.212, 5
  br i1 %.214, label %.209wloop.68.72, label %.210wn72
.209wloop.68.72:
  %.216 = load i32, i32* %.134
  %.217 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.A, i32 0, i32 0
  %.218 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.B, i32 0, i32 0
  %.219 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.C, i32 0, i32 0
  call void @mm(i32 %.216, [1024 x i32]* %.217, [1024 x i32]* %.218, [1024 x i32]* %.219)
  %.221 = load i32, i32* %.134
  %.222 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.A, i32 0, i32 0
  %.223 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.C, i32 0, i32 0
  %.224 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.B, i32 0, i32 0
  call void @mm(i32 %.221, [1024 x i32]* %.222, [1024 x i32]* %.223, [1024 x i32]* %.224)
  %.226 = load i32, i32* %.138
  %.227 = add i32 %.226, 1
  store i32 %.227, i32* %.138
  br label %.208wc68 
.210wn72:
  store i32 0, i32* %.230
  store i32 0, i32* %.138
  br label %.233wc76 
.233wc76:
  %.237 = load i32, i32* %.138
  %.238 = load i32, i32* %.134
  %.239 = icmp slt i32 %.237, %.238
  br i1 %.239, label %.234wloop.76.83, label %.235wn83
.234wloop.76.83:
  store i32 0, i32* %.139
  br label %.242wc78 
.235wn83:
  call void @_sysy_stoptime(i32 84)
  %.268 = load i32, i32* %.230
  call void @putint(i32 %.268)
  call void @putch(i32 10)
  ret i32 0 
.242wc78:
  %.246 = load i32, i32* %.139
  %.247 = load i32, i32* %.134
  %.248 = icmp slt i32 %.246, %.247
  br i1 %.248, label %.243wloop.78.81, label %.244wn81
.243wloop.78.81:
  %.250 = load i32, i32* %.230
  %.251 = load i32, i32* %.138
  %.252 = load i32, i32* %.139
  %.253 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.B, i32 0, i32 %.251, i32 %.252
  %.254 = load i32, i32* %.253
  %.255 = add i32 %.250, %.254
  store i32 %.255, i32* %.230
  %.257 = load i32, i32* %.139
  %.258 = add i32 %.257, 1
  store i32 %.258, i32* %.139
  br label %.242wc78 
.244wn81:
  %.261 = load i32, i32* %.138
  %.262 = add i32 %.261, 1
  store i32 %.262, i32* %.138
  br label %.233wc76 
}
@.g.A = global [1024 x [1024 x i32]] zeroinitializer
@.g.B = global [1024 x [1024 x i32]] zeroinitializer
@.g.C = global [1024 x [1024 x i32]] zeroinitializer
define void @mm(i32 %.4, [1024 x i32]* %.7, [1024 x i32]* %.10, [1024 x i32]* %.13){
.2:
  %.17 = alloca i32
  %.16 = alloca i32
  %.15 = alloca i32
  %.12 = alloca [1024 x i32]*
  %.9 = alloca [1024 x i32]*
  %.6 = alloca [1024 x i32]*
  %.3 = alloca i32
  store i32 %.4, i32* %.3
  store [1024 x i32]* %.7, [1024 x i32]** %.6
  store [1024 x i32]* %.10, [1024 x i32]** %.9
  store [1024 x i32]* %.13, [1024 x i32]** %.12
  store i32 0, i32* %.15
  store i32 0, i32* %.16
  br label %.21wc7 
.21wc7:
  %.25 = load i32, i32* %.15
  %.26 = load i32, i32* %.3
  %.27 = icmp slt i32 %.25, %.26
  br i1 %.27, label %.22wloop.7.14, label %.23wn14
.22wloop.7.14:
  store i32 0, i32* %.16
  br label %.30wc9 
.23wn14:
  store i32 0, i32* %.15
  store i32 0, i32* %.16
  store i32 0, i32* %.17
  br label %.55wc18 
.30wc9:
  %.34 = load i32, i32* %.16
  %.35 = load i32, i32* %.3
  %.36 = icmp slt i32 %.34, %.35
  br i1 %.36, label %.31wloop.9.12, label %.32wn12
.31wloop.9.12:
  %.38 = load i32, i32* %.15
  %.39 = load i32, i32* %.16
  %.40 = load [1024 x i32]*, [1024 x i32]** %.12
  %.41 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.40, i32 %.38, i32 %.39
  store i32 0, i32* %.41
  %.43 = load i32, i32* %.16
  %.45 = add i32 %.43, 1
  store i32 %.45, i32* %.16
  br label %.30wc9 
.32wn12:
  %.48 = load i32, i32* %.15
  %.49 = add i32 %.48, 1
  store i32 %.49, i32* %.15
  br label %.21wc7 
.55wc18:
  %.59 = load i32, i32* %.17
  %.60 = load i32, i32* %.3
  %.61 = icmp slt i32 %.59, %.60
  br i1 %.61, label %.56wloop.18.33, label %.57wn33
.56wloop.18.33:
  store i32 0, i32* %.15
  br label %.64wc20 
.57wn33:
  ret void
.64wc20:
  %.68 = load i32, i32* %.15
  %.69 = load i32, i32* %.3
  %.70 = icmp slt i32 %.68, %.69
  br i1 %.70, label %.65wloop.20.31, label %.66wn31
.65wloop.20.31:
  %.74 = load i32, i32* %.15
  %.75 = load i32, i32* %.17
  %.76 = load [1024 x i32]*, [1024 x i32]** %.6
  %.77 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.76, i32 %.74, i32 %.75
  %.78 = load i32, i32* %.77
  %.79 = icmp eq i32 %.78, 0
  br i1 %.79, label %.72, label %.73
.66wn31:
  %.124 = load i32, i32* %.17
  %.125 = add i32 %.124, 1
  store i32 %.125, i32* %.17
  br label %.55wc18 
.72:
  %.81 = load i32, i32* %.15
  %.82 = add i32 %.81, 1
  store i32 %.82, i32* %.15
  br label %.64wc20 
.73:
  store i32 0, i32* %.16
  br label %.86wc26 
.86wc26:
  %.90 = load i32, i32* %.16
  %.91 = load i32, i32* %.3
  %.92 = icmp slt i32 %.90, %.91
  br i1 %.92, label %.87wloop.26.29, label %.88wn29
.87wloop.26.29:
  %.94 = load i32, i32* %.15
  %.95 = load i32, i32* %.16
  %.96 = load [1024 x i32]*, [1024 x i32]** %.12
  %.97 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.96, i32 %.94, i32 %.95
  %.98 = load i32, i32* %.97
  %.99 = load i32, i32* %.15
  %.100 = load i32, i32* %.17
  %.101 = load [1024 x i32]*, [1024 x i32]** %.6
  %.102 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.101, i32 %.99, i32 %.100
  %.103 = load i32, i32* %.102
  %.104 = load i32, i32* %.17
  %.105 = load i32, i32* %.16
  %.106 = load [1024 x i32]*, [1024 x i32]** %.9
  %.107 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.106, i32 %.104, i32 %.105
  %.108 = load i32, i32* %.107
  %.109 = mul i32 %.103, %.108
  %.110 = add i32 %.98, %.109
  %.111 = load i32, i32* %.15
  %.112 = load i32, i32* %.16
  %.113 = load [1024 x i32]*, [1024 x i32]** %.12
  %.114 = getelementptr inbounds [1024 x i32], [1024 x i32]* %.113, i32 %.111, i32 %.112
  store i32 %.110, i32* %.114
  %.116 = load i32, i32* %.16
  %.117 = add i32 %.116, 1
  store i32 %.117, i32* %.16
  br label %.86wc26 
.88wn29:
  %.120 = load i32, i32* %.15
  %.121 = add i32 %.120, 1
  store i32 %.121, i32* %.15
  br label %.64wc20 
}
define i32 @main(){
.133:
  %.230 = alloca i32
  %.139 = alloca i32
  %.138 = alloca i32
  %.134 = alloca i32
  %.136at41 = call i32 @getint()
  store i32 %.136at41, i32* %.134
  store i32 0, i32* %.138
  store i32 0, i32* %.139
  br label %.142wc46 
.142wc46:
  %.146 = load i32, i32* %.138
  %.147 = load i32, i32* %.134
  %.148 = icmp slt i32 %.146, %.147
  br i1 %.148, label %.143wloop.46.53, label %.144wn53
.143wloop.46.53:
  store i32 0, i32* %.139
  br label %.151wc48 
.144wn53:
  store i32 0, i32* %.138
  store i32 0, i32* %.139
  br label %.174wc56 
.151wc48:
  %.155 = load i32, i32* %.139
  %.156 = load i32, i32* %.134
  %.157 = icmp slt i32 %.155, %.156
  br i1 %.157, label %.152wloop.48.51, label %.153wn51
.152wloop.48.51:
  %.159at49 = call i32 @getint()
  %.160 = load i32, i32* %.138
  %.161 = load i32, i32* %.139
  %.162 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.A, i32 0, i32 %.160, i32 %.161
  store i32 %.159at49, i32* %.162
  %.164 = load i32, i32* %.139
  %.165 = add i32 %.164, 1
  store i32 %.165, i32* %.139
  br label %.151wc48 
.153wn51:
  %.168 = load i32, i32* %.138
  %.169 = add i32 %.168, 1
  store i32 %.169, i32* %.138
  br label %.142wc46 
.174wc56:
  %.178 = load i32, i32* %.138
  %.179 = load i32, i32* %.134
  %.180 = icmp slt i32 %.178, %.179
  br i1 %.180, label %.175wloop.56.63, label %.176wn63
.175wloop.56.63:
  store i32 0, i32* %.139
  br label %.183wc58 
.176wn63:
  call void @_sysy_starttime(i32 65)
  store i32 0, i32* %.138
  br label %.208wc68 
.183wc58:
  %.187 = load i32, i32* %.139
  %.188 = load i32, i32* %.134
  %.189 = icmp slt i32 %.187, %.188
  br i1 %.189, label %.184wloop.58.61, label %.185wn61
.184wloop.58.61:
  %.191at59 = call i32 @getint()
  %.192 = load i32, i32* %.138
  %.193 = load i32, i32* %.139
  %.194 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.B, i32 0, i32 %.192, i32 %.193
  store i32 %.191at59, i32* %.194
  %.196 = load i32, i32* %.139
  %.197 = add i32 %.196, 1
  store i32 %.197, i32* %.139
  br label %.183wc58 
.185wn61:
  %.200 = load i32, i32* %.138
  %.201 = add i32 %.200, 1
  store i32 %.201, i32* %.138
  br label %.174wc56 
.208wc68:
  %.212 = load i32, i32* %.138
  %.214 = icmp slt i32 %.212, 5
  br i1 %.214, label %.209wloop.68.72, label %.210wn72
.209wloop.68.72:
  %.216 = load i32, i32* %.134
  %.217 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.A, i32 0, i32 0
  %.218 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.B, i32 0, i32 0
  %.219 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.C, i32 0, i32 0
  call void @mm(i32 %.216, [1024 x i32]* %.217, [1024 x i32]* %.218, [1024 x i32]* %.219)
  %.221 = load i32, i32* %.134
  %.222 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.A, i32 0, i32 0
  %.223 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.C, i32 0, i32 0
  %.224 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.B, i32 0, i32 0
  call void @mm(i32 %.221, [1024 x i32]* %.222, [1024 x i32]* %.223, [1024 x i32]* %.224)
  %.226 = load i32, i32* %.138
  %.227 = add i32 %.226, 1
  store i32 %.227, i32* %.138
  br label %.208wc68 
.210wn72:
  store i32 0, i32* %.230
  store i32 0, i32* %.138
  br label %.233wc76 
.233wc76:
  %.237 = load i32, i32* %.138
  %.238 = load i32, i32* %.134
  %.239 = icmp slt i32 %.237, %.238
  br i1 %.239, label %.234wloop.76.83, label %.235wn83
.234wloop.76.83:
  store i32 0, i32* %.139
  br label %.242wc78 
.235wn83:
  call void @_sysy_stoptime(i32 84)
  %.268 = load i32, i32* %.230
  call void @putint(i32 %.268)
  call void @putch(i32 10)
  ret i32 0 
.242wc78:
  %.246 = load i32, i32* %.139
  %.247 = load i32, i32* %.134
  %.248 = icmp slt i32 %.246, %.247
  br i1 %.248, label %.243wloop.78.81, label %.244wn81
.243wloop.78.81:
  %.250 = load i32, i32* %.230
  %.251 = load i32, i32* %.138
  %.252 = load i32, i32* %.139
  %.253 = getelementptr inbounds [1024 x [1024 x i32]], [1024 x [1024 x i32]]* @.g.B, i32 0, i32 %.251, i32 %.252
  %.254 = load i32, i32* %.253
  %.255 =