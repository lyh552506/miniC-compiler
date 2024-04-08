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
@.g.program_length = global i32 0
@.g.program = global [65536 x i32] zeroinitializer
@.g.tape = global [65536 x i32] zeroinitializer
@.g.input = global [65536 x i32] zeroinitializer
@.g.input_length = global i32 0
@.g.output = global [65536 x i32] zeroinitializer
@.g.output_length = global i32 0
@__constant..139 = constant [512 x i32] zeroinitializer
define i32 @get_bf_char(){
.14:
  %.15 = alloca i32
  %.17at16 = call i32 @getch()
  store i32 %.17at16, i32* %.15
  br label %.19wc17 
.19wc17:
  %.23 = load i32, i32* %.15
  %.25 = icmp ne i32 %.23, 62
  br i1 %.25, label %.26, label %.21wn20
.20wloop.17.20:
  %.67at19 = call i32 @getch()
  store i32 %.67at19, i32* %.15
  br label %.19wc17 
.21wn20:
  %.70 = load i32, i32* %.15
  ret i32 %.70 
.26:
  %.28 = load i32, i32* %.15
  %.30 = icmp ne i32 %.28, 60
  br i1 %.30, label %.31, label %.21wn20
.31:
  %.33 = load i32, i32* %.15
  %.35 = icmp ne i32 %.33, 43
  br i1 %.35, label %.36, label %.21wn20
.36:
  %.38 = load i32, i32* %.15
  %.40 = icmp ne i32 %.38, 45
  br i1 %.40, label %.41, label %.21wn20
.41:
  %.43 = load i32, i32* %.15
  %.45 = icmp ne i32 %.43, 91
  br i1 %.45, label %.46, label %.21wn20
.46:
  %.48 = load i32, i32* %.15
  %.50 = icmp ne i32 %.48, 93
  br i1 %.50, label %.51, label %.21wn20
.51:
  %.53 = load i32, i32* %.15
  %.55 = icmp ne i32 %.53, 46
  br i1 %.55, label %.56, label %.21wn20
.56:
  %.58 = load i32, i32* %.15
  %.60 = icmp ne i32 %.58, 44
  br i1 %.60, label %.61, label %.21wn20
.61:
  %.63 = load i32, i32* %.15
  %.65 = icmp ne i32 %.63, 35
  br i1 %.65, label %.20wloop.17.20, label %.21wn20
}
define void @read_program(){
.73:
  %.109 = alloca i32
  %.95 = alloca i32
  %.74 = alloca i32
  %.75at25 = call i32 @get_bf_char()
  store i32 %.75at25, i32* %.74
  br label %.77wc26 
.77wc26:
  %.81 = load i32, i32* %.74
  %.82 = icmp ne i32 %.81, 35
  br i1 %.82, label %.78wloop.26.30, label %.79wn30
.78wloop.26.30:
  %.84 = load i32, i32* %.74
  %.85 = load i32, i32* @.g.program_length
  %.86 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.program, i32 0, i32 %.85
  store i32 %.84, i32* %.86
  %.88at28 = call i32 @get_bf_char()
  store i32 %.88at28, i32* %.74
  %.90 = load i32, i32* @.g.program_length
  %.92 = add i32 %.90, 1
  store i32 %.92, i32* @.g.program_length
  br label %.77wc26 
.79wn30:
  %.96at34 = call i32 @getch()
  store i32 %.96at34, i32* %.95
  %.100 = load i32, i32* %.95
  %.102 = icmp ne i32 %.100, 105
  br i1 %.102, label %.98, label %.99
.98:
  ret void
.99:
  %.106at39 = call i32 @getint()
  store i32 %.106at39, i32* @.g.input_length
  %.108at41 = call i32 @getch()
  store i32 0, i32* %.109
  br label %.111wc43 
.111wc43:
  %.115 = load i32, i32* %.109
  %.116 = load i32, i32* @.g.input_length
  %.117 = icmp slt i32 %.115, %.116
  br i1 %.117, label %.112wloop.43.46, label %.113wn46
.112wloop.43.46:
  %.119at44 = call i32 @getch()
  %.120 = load i32, i32* %.109
  %.121 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.input, i32 0, i32 %.120
  store i32 %.119at44, i32* %.121
  %.123 = load i32, i32* %.109
  %.124 = add i32 %.123, 1
  store i32 %.124, i32* %.109
  br label %.111wc43 
.113wn46:
  ret void
}
define void @run_program(){
.129:
  %.276 = alloca i32
  %.233 = alloca i32
  %.214 = alloca i32
  %.156 = alloca i32
  %.145 = alloca i32
  %.137 = alloca [512 x i32]
  %.134 = alloca i32
  %.132 = alloca i32
  %.130 = alloca i32
  store i32 0, i32* %.130
  store i32 0, i32* %.132
  store i32 0, i32* %.134
  call void @llvm.memcpy.p0.p0.i32([512 x i32]* %.137, [512 x i32]* @__constant..139, i32 2048, i1 false)
  store i32 0, i32* %.145
  store i32 0, i32* @.g.output_length
  br label %.148wc56 
.148wc56:
  %.152 = load i32, i32* %.130
  %.153 = load i32, i32* @.g.program_length
  %.154 = icmp slt i32 %.152, %.153
  br i1 %.154, label %.149wloop.56.103, label %.150wn103
.149wloop.56.103:
  %.157 = load i32, i32* %.130
  %.158 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.program, i32 0, i32 %.157
  %.159 = load i32, i32* %.158
  store i32 %.159, i32* %.156
  %.163 = load i32, i32* %.156
  %.164 = icmp eq i32 %.163, 62
  br i1 %.164, label %.161, label %.162
.150wn103:
  ret void
.161:
  %.166 = load i32, i32* %.132
  %.167 = add i32 %.166, 1
  store i32 %.167, i32* %.132
  br label %.169 
.162:
  %.173 = load i32, i32* %.156
  %.174 = icmp eq i32 %.173, 60
  br i1 %.174, label %.171, label %.172
.169:
  %.349 = load i32, i32* %.130
  %.350 = add i32 %.349, 1
  store i32 %.350, i32* %.130
  br label %.148wc56 
.171:
  %.176 = load i32, i32* %.132
  %.177 = sub i32 %.176, 1
  store i32 %.177, i32* %.132
  br label %.179 
.172:
  %.183 = load i32, i32* %.156
  %.184 = icmp eq i32 %.183, 43
  br i1 %.184, label %.181, label %.182
.179:
  br label %.169 
.181:
  %.186 = load i32, i32* %.132
  %.187 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.186
  %.188 = load i32, i32* %.187
  %.189 = add i32 %.188, 1
  %.190 = load i32, i32* %.132
  %.191 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.190
  store i32 %.189, i32* %.191
  br label %.193 
.182:
  %.197 = load i32, i32* %.156
  %.198 = icmp eq i32 %.197, 45
  br i1 %.198, label %.195, label %.196
.193:
  br label %.179 
.195:
  %.200 = load i32, i32* %.132
  %.201 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.200
  %.202 = load i32, i32* %.201
  %.203 = sub i32 %.202, 1
  %.204 = load i32, i32* %.132
  %.205 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.204
  store i32 %.203, i32* %.205
  br label %.207 
.196:
  %.211 = load i32, i32* %.156
  %.212 = icmp eq i32 %.211, 91
  br i1 %.212, label %.209, label %.210
.207:
  br label %.193 
.209:
  %.215 = load i32, i32* %.132
  %.216 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.215
  %.217 = load i32, i32* %.216
  store i32 %.217, i32* %.214
  %.221 = load i32, i32* %.214
  %.222 = icmp ne i32 %.221, 0
  br i1 %.222, label %.219, label %.220
.210:
  %.273 = load i32, i32* %.156
  %.274 = icmp eq i32 %.273, 93
  br i1 %.274, label %.271, label %.272
.219:
  %.224 = load i32, i32* %.130
  %.225 = load i32, i32* %.145
  %.226 = getelementptr inbounds [512 x i32], [512 x i32]* %.137, i32 0, i32 %.225
  store i32 %.224, i32* %.226
  %.228 = load i32, i32* %.145
  %.229 = add i32 %.228, 1
  store i32 %.229, i32* %.145
  br label %.231 
.220:
  store i32 1, i32* %.233
  br label %.235wc74 
.231:
  br label %.269 
.235wc74:
  %.239 = load i32, i32* %.233
  %.240 = icmp sgt i32 %.239, 0
  br i1 %.240, label %.236wloop.74.82, label %.237wn82
.236wloop.74.82:
  %.242 = load i32, i32* %.130
  %.243 = add i32 %.242, 1
  store i32 %.243, i32* %.130
  %.247 = load i32, i32* %.130
  %.248 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.program, i32 0, i32 %.247
  %.249 = load i32, i32* %.248
  %.250 = icmp eq i32 %.249, 93
  br i1 %.250, label %.245, label %.246
.237wn82:
  br label %.231 
.245:
  %.252 = load i32, i32* %.233
  %.253 = sub i32 %.252, 1
  store i32 %.253, i32* %.233
  br label %.246 
.246:
  %.258 = load i32, i32* %.130
  %.259 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.program, i32 0, i32 %.258
  %.260 = load i32, i32* %.259
  %.261 = icmp eq i32 %.260, 91
  br i1 %.261, label %.256, label %.257
.256:
  %.263 = load i32, i32* %.233
  %.264 = add i32 %.263, 1
  store i32 %.264, i32* %.233
  br label %.257 
.257:
  br label %.235wc74 
.269:
  br label %.207 
.271:
  %.277 = load i32, i32* %.132
  %.278 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.277
  %.279 = load i32, i32* %.278
  store i32 %.279, i32* %.276
  %.283 = load i32, i32* %.276
  %.284 = icmp eq i32 %.283, 0
  br i1 %.284, label %.281, label %.282
.272:
  %.301 = load i32, i32* %.156
  %.302 = icmp eq i32 %.301, 46
  br i1 %.302, label %.299, label %.300
.281:
  %.286 = load i32, i32* %.145
  %.287 = sub i32 %.286, 1
  store i32 %.287, i32* %.145
  br label %.289 
.282:
  %.291 = load i32, i32* %.145
  %.292 = sub i32 %.291, 1
  %.293 = getelementptr inbounds [512 x i32], [512 x i32]* %.137, i32 0, i32 %.292
  %.294 = load i32, i32* %.293
  store i32 %.294, i32* %.130
  br label %.289 
.289:
  br label %.297 
.297:
  br label %.269 
.299:
  %.304 = load i32, i32* %.132
  %.305 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.304
  %.306 = load i32, i32* %.305
  %.307 = load i32, i32* @.g.output_length
  %.308 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.output, i32 0, i32 %.307
  store i32 %.306, i32* %.308
  %.310 = load i32, i32* @.g.output_length
  %.311 = add i32 %.310, 1
  store i32 %.311, i32* @.g.output_length
  br label %.313 
.300:
  %.317 = load i32, i32* %.156
  %.318 = icmp eq i32 %.317, 44
  br i1 %.318, label %.315, label %.316
.313:
  br label %.297 
.315:
  %.322 = load i32, i32* %.134
  %.323 = load i32, i32* @.g.input_length
  %.324 = icmp sge i32 %.322, %.323
  br i1 %.324, label %.320, label %.321
.316:
  br label %.313 
.320:
  %.326 = load i32, i32* %.132
  %.327 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.326
  store i32 0, i32* %.327
  br label %.329 
.321:
  %.331 = load i32, i32* %.134
  %.332 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.input, i32 0, i32 %.331
  %.333 = load i32, i32* %.332
  %.334 = load i32, i32* %.132
  %.335 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.334
  store i32 %.333, i32* %.335
  %.337 = load i32, i32* %.134
  %.338 = add i32 %.337, 1
  store i32 %.338, i32* %.134
  br label %.329 
.329:
  br label %.316 
}
define void @output_(){
.355:
  %.356 = alloca i32
  store i32 0, i32* %.356
  br label %.358wc108 
.358wc108:
  %.362 = load i32, i32* %.356
  %.363 = load i32, i32* @.g.output_length
  %.364 = icmp slt i32 %.362, %.363
  br i1 %.364, label %.359wloop.108.111, label %.360wn111
.359wloop.108.111:
  %.366 = load i32, i32* %.356
  %.367 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.output, i32 0, i32 %.366
  %.368 = load i32, i32* %.367
  call void @putch(i32 %.368)
  %.371 = load i32, i32* %.356
  %.372 = add i32 %.371, 1
  store i32 %.372, i32* %.356
  br label %.358wc108 
.360wn111:
  ret void
}
define i32 @main(){
.377:
  call void @read_program()
  call void @_sysy_starttime(i32 116)
  call void @run_program()
  call void @_sysy_stoptime(i32 118)
  call void @output_()
  ret i32 0 
}
@.g.program_length = global i32 0
@.g.program = global [65536 x i32] zeroinitializer
@.g.tape = global [65536 x i32] zeroinitializer
@.g.input = global [65536 x i32] zeroinitializer
@.g.input_length = global i32 0
@.g.output = global [65536 x i32] zeroinitializer
@.g.output_length = global i32 0
@__constant..139 = constant [512 x i32] zeroinitializer
define i32 @get_bf_char(){
.14:
  %.15 = alloca i32
  %.17at16 = call i32 @getch()
  store i32 %.17at16, i32* %.15
  br label %.19wc17 
.19wc17:
  %.23 = load i32, i32* %.15
  %.25 = icmp ne i32 %.23, 62
  br i1 %.25, label %.26, label %.21wn20
.20wloop.17.20:
  %.67at19 = call i32 @getch()
  store i32 %.67at19, i32* %.15
  br label %.19wc17 
.21wn20:
  %.70 = load i32, i32* %.15
  ret i32 %.70 
.26:
  %.28 = load i32, i32* %.15
  %.30 = icmp ne i32 %.28, 60
  br i1 %.30, label %.31, label %.21wn20
.31:
  %.33 = load i32, i32* %.15
  %.35 = icmp ne i32 %.33, 43
  br i1 %.35, label %.36, label %.21wn20
.36:
  %.38 = load i32, i32* %.15
  %.40 = icmp ne i32 %.38, 45
  br i1 %.40, label %.41, label %.21wn20
.41:
  %.43 = load i32, i32* %.15
  %.45 = icmp ne i32 %.43, 91
  br i1 %.45, label %.46, label %.21wn20
.46:
  %.48 = load i32, i32* %.15
  %.50 = icmp ne i32 %.48, 93
  br i1 %.50, label %.51, label %.21wn20
.51:
  %.53 = load i32, i32* %.15
  %.55 = icmp ne i32 %.53, 46
  br i1 %.55, label %.56, label %.21wn20
.56:
  %.58 = load i32, i32* %.15
  %.60 = icmp ne i32 %.58, 44
  br i1 %.60, label %.61, label %.21wn20
.61:
  %.63 = load i32, i32* %.15
  %.65 = icmp ne i32 %.63, 35
  br i1 %.65, label %.20wloop.17.20, label %.21wn20
}
define void @read_program(){
.73:
  %.109 = alloca i32
  %.95 = alloca i32
  %.74 = alloca i32
  %.75at25 = call i32 @get_bf_char()
  store i32 %.75at25, i32* %.74
  br label %.77wc26 
.77wc26:
  %.81 = load i32, i32* %.74
  %.82 = icmp ne i32 %.81, 35
  br i1 %.82, label %.78wloop.26.30, label %.79wn30
.78wloop.26.30:
  %.84 = load i32, i32* %.74
  %.85 = load i32, i32* @.g.program_length
  %.86 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.program, i32 0, i32 %.85
  store i32 %.84, i32* %.86
  %.88at28 = call i32 @get_bf_char()
  store i32 %.88at28, i32* %.74
  %.90 = load i32, i32* @.g.program_length
  %.92 = add i32 %.90, 1
  store i32 %.92, i32* @.g.program_length
  br label %.77wc26 
.79wn30:
  %.96at34 = call i32 @getch()
  store i32 %.96at34, i32* %.95
  %.100 = load i32, i32* %.95
  %.102 = icmp ne i32 %.100, 105
  br i1 %.102, label %.98, label %.99
.98:
  ret void
.99:
  %.106at39 = call i32 @getint()
  store i32 %.106at39, i32* @.g.input_length
  %.108at41 = call i32 @getch()
  store i32 0, i32* %.109
  br label %.111wc43 
.111wc43:
  %.115 = load i32, i32* %.109
  %.116 = load i32, i32* @.g.input_length
  %.117 = icmp slt i32 %.115, %.116
  br i1 %.117, label %.112wloop.43.46, label %.113wn46
.112wloop.43.46:
  %.119at44 = call i32 @getch()
  %.120 = load i32, i32* %.109
  %.121 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.input, i32 0, i32 %.120
  store i32 %.119at44, i32* %.121
  %.123 = load i32, i32* %.109
  %.124 = add i32 %.123, 1
  store i32 %.124, i32* %.109
  br label %.111wc43 
.113wn46:
  ret void
}
define void @run_program(){
.129:
  %.276 = alloca i32
  %.233 = alloca i32
  %.214 = alloca i32
  %.156 = alloca i32
  %.145 = alloca i32
  %.137 = alloca [512 x i32]
  %.134 = alloca i32
  %.132 = alloca i32
  %.130 = alloca i32
  store i32 0, i32* %.130
  store i32 0, i32* %.132
  store i32 0, i32* %.134
  call void @llvm.memcpy.p0.p0.i32([512 x i32]* %.137, [512 x i32]* @__constant..139, i32 2048, i1 false)
  store i32 0, i32* %.145
  store i32 0, i32* @.g.output_length
  br label %.148wc56 
.148wc56:
  %.152 = load i32, i32* %.130
  %.153 = load i32, i32* @.g.program_length
  %.154 = icmp slt i32 %.152, %.153
  br i1 %.154, label %.149wloop.56.103, label %.150wn103
.149wloop.56.103:
  %.157 = load i32, i32* %.130
  %.158 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.program, i32 0, i32 %.157
  %.159 = load i32, i32* %.158
  store i32 %.159, i32* %.156
  %.163 = load i32, i32* %.156
  %.164 = icmp eq i32 %.163, 62
  br i1 %.164, label %.161, label %.162
.150wn103:
  ret void
.161:
  %.166 = load i32, i32* %.132
  %.167 = add i32 %.166, 1
  store i32 %.167, i32* %.132
  br label %.169 
.162:
  %.173 = load i32, i32* %.156
  %.174 = icmp eq i32 %.173, 60
  br i1 %.174, label %.171, label %.172
.169:
  %.349 = load i32, i32* %.130
  %.350 = add i32 %.349, 1
  store i32 %.350, i32* %.130
  br label %.148wc56 
.171:
  %.176 = load i32, i32* %.132
  %.177 = sub i32 %.176, 1
  store i32 %.177, i32* %.132
  br label %.179 
.172:
  %.183 = load i32, i32* %.156
  %.184 = icmp eq i32 %.183, 43
  br i1 %.184, label %.181, label %.182
.179:
  br label %.169 
.181:
  %.186 = load i32, i32* %.132
  %.187 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.186
  %.188 = load i32, i32* %.187
  %.189 = add i32 %.188, 1
  %.190 = load i32, i32* %.132
  %.191 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.190
  store i32 %.189, i32* %.191
  br label %.193 
.182:
  %.197 = load i32, i32* %.156
  %.198 = icmp eq i32 %.197, 45
  br i1 %.198, label %.195, label %.196
.193:
  br label %.179 
.195:
  %.200 = load i32, i32* %.132
  %.201 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.200
  %.202 = load i32, i32* %.201
  %.203 = sub i32 %.202, 1
  %.204 = load i32, i32* %.132
  %.205 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.204
  store i32 %.203, i32* %.205
  br label %.207 
.196:
  %.211 = load i32, i32* %.156
  %.212 = icmp eq i32 %.211, 91
  br i1 %.212, label %.209, label %.210
.207:
  br label %.193 
.209:
  %.215 = load i32, i32* %.132
  %.216 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.215
  %.217 = load i32, i32* %.216
  store i32 %.217, i32* %.214
  %.221 = load i32, i32* %.214
  %.222 = icmp ne i32 %.221, 0
  br i1 %.222, label %.219, label %.220
.210:
  %.273 = load i32, i32* %.156
  %.274 = icmp eq i32 %.273, 93
  br i1 %.274, label %.271, label %.272
.219:
  %.224 = load i32, i32* %.130
  %.225 = load i32, i32* %.145
  %.226 = getelementptr inbounds [512 x i32], [512 x i32]* %.137, i32 0, i32 %.225
  store i32 %.224, i32* %.226
  %.228 = load i32, i32* %.145
  %.229 = add i32 %.228, 1
  store i32 %.229, i32* %.145
  br label %.231 
.220:
  store i32 1, i32* %.233
  br label %.235wc74 
.231:
  br label %.269 
.235wc74:
  %.239 = load i32, i32* %.233
  %.240 = icmp sgt i32 %.239, 0
  br i1 %.240, label %.236wloop.74.82, label %.237wn82
.236wloop.74.82:
  %.242 = load i32, i32* %.130
  %.243 = add i32 %.242, 1
  store i32 %.243, i32* %.130
  %.247 = load i32, i32* %.130
  %.248 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.program, i32 0, i32 %.247
  %.249 = load i32, i32* %.248
  %.250 = icmp eq i32 %.249, 93
  br i1 %.250, label %.245, label %.246
.237wn82:
  br label %.231 
.245:
  %.252 = load i32, i32* %.233
  %.253 = sub i32 %.252, 1
  store i32 %.253, i32* %.233
  br label %.246 
.246:
  %.258 = load i32, i32* %.130
  %.259 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.program, i32 0, i32 %.258
  %.260 = load i32, i32* %.259
  %.261 = icmp eq i32 %.260, 91
  br i1 %.261, label %.256, label %.257
.256:
  %.263 = load i32, i32* %.233
  %.264 = add i32 %.263, 1
  store i32 %.264, i32* %.233
  br label %.257 
.257:
  br label %.235wc74 
.269:
  br label %.207 
.271:
  %.277 = load i32, i32* %.132
  %.278 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.277
  %.279 = load i32, i32* %.278
  store i32 %.279, i32* %.276
  %.283 = load i32, i32* %.276
  %.284 = icmp eq i32 %.283, 0
  br i1 %.284, label %.281, label %.282
.272:
  %.301 = load i32, i32* %.156
  %.302 = icmp eq i32 %.301, 46
  br i1 %.302, label %.299, label %.300
.281:
  %.286 = load i32, i32* %.145
  %.287 = sub i32 %.286, 1
  store i32 %.287, i32* %.145
  br label %.289 
.282:
  %.291 = load i32, i32* %.145
  %.292 = sub i32 %.291, 1
  %.293 = getelementptr inbounds [512 x i32], [512 x i32]* %.137, i32 0, i32 %.292
  %.294 = load i32, i32* %.293
  store i32 %.294, i32* %.130
  br label %.289 
.289:
  br label %.297 
.297:
  br label %.269 
.299:
  %.304 = load i32, i32* %.132
  %.305 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.304
  %.306 = load i32, i32* %.305
  %.307 = load i32, i32* @.g.output_length
  %.308 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.output, i32 0, i32 %.307
  store i32 %.306, i32* %.308
  %.310 = load i32, i32* @.g.output_length
  %.311 = add i32 %.310, 1
  store i32 %.311, i32* @.g.output_length
  br label %.313 
.300:
  %.317 = load i32, i32* %.156
  %.318 = icmp eq i32 %.317, 44
  br i1 %.318, label %.315, label %.316
.313:
  br label %.297 
.315:
  %.322 = load i32, i32* %.134
  %.323 = load i32, i32* @.g.input_length
  %.324 = icmp sge i32 %.322, %.323
  br i1 %.324, label %.320, label %.321
.316:
  br label %.313 
.320:
  %.326 = load i32, i32* %.132
  %.327 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.326
  store i32 0, i32* %.327
  br label %.329 
.321:
  %.331 = load i32, i32* %.134
  %.332 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.input, i32 0, i32 %.331
  %.333 = load i32, i32* %.332
  %.334 = load i32, i32* %.132
  %.335 = getelementptr inbounds [65536 x i32], [65536 x i32]* @.g.tape, i32 0, i32 %.334
  store i32 %.333, i32* %.335
  %.337 = load i32, i32* %.134
  %.338 = add i32 %.337, 1
  store i32 %.338, i32* %.134
  br label %.329 
.329:
  br label %.316 
}
define void @output_(){
.355:
  %.356 = alloca i32
  store i32 0, i32* %.356
  br label %.358wc108 
.358wc108:
  %.362 = load i32, i32* %.356
  %.363 = load i32, i32* @.g.output_length
  %.364 = icmp slt i32 %.362, %.363
  br i1 %.364, label %.359wloop.108.111, label %.360wn111
.359wloop.108.111:
  %.366 = load i32, i32* %.356
  %.