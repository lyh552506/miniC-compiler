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
@.g.sheet1 = global [500 x [500 x i32]] zeroinitializer
@.g.sheet2 = global [500 x [500 x i32]] zeroinitializer
@.g.active = global i32 1
@.g.width = global i32 zeroinitializer
@.g.height = global i32 zeroinitializer
@.g.steps = global i32 zeroinitializer
define void @read_map(){
.11:
  %.42 = alloca i32
  %.23 = alloca i32
  %.21 = alloca i32
  %.13at9 = call i32 @getint()
  store i32 %.13at9, i32* @.g.width
  %.15at10 = call i32 @getint()
  store i32 %.15at10, i32* @.g.height
  %.17at12 = call i32 @getint()
  store i32 %.17at12, i32* @.g.steps
  %.20at13 = call i32 @getch()
  store i32 1, i32* %.21
  store i32 1, i32* %.23
  br label %.25wc18 
.25wc18:
  %.29 = load i32, i32* %.23
  %.30 = load i32, i32* @.g.height
  %.31 = icmp sle i32 %.29, %.30
  br i1 %.31, label %.26wloop.18.32, label %.27wn32
.26wloop.18.32:
  store i32 1, i32* %.21
  br label %.34wc20 
.27wn32:
  ret void
.34wc20:
  %.38 = load i32, i32* %.21
  %.39 = load i32, i32* @.g.width
  %.40 = icmp sle i32 %.38, %.39
  br i1 %.40, label %.35wloop.20.28, label %.36wn28
.35wloop.20.28:
  %.43at21 = call i32 @getch()
  store i32 %.43at21, i32* %.42
  %.47 = load i32, i32* %.42
  %.49 = icmp eq i32 %.47, 35
  br i1 %.49, label %.45, label %.46
.36wn28:
  %.67at30 = call i32 @getch()
  %.68 = load i32, i32* %.23
  %.69 = add i32 %.68, 1
  store i32 %.69, i32* %.23
  br label %.25wc18 
.45:
  %.51 = load i32, i32* %.23
  %.52 = load i32, i32* %.21
  %.53 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 %.51, i32 %.52
  store i32 1, i32* %.53
  br label %.56 
.46:
  %.58 = load i32, i32* %.23
  %.59 = load i32, i32* %.21
  %.60 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 %.58, i32 %.59
  store i32 0, i32* %.60
  br label %.56 
.56:
  %.63 = load i32, i32* %.21
  %.64 = add i32 %.63, 1
  store i32 %.64, i32* %.21
  br label %.34wc20 
}
define void @put_map(){
.74:
  %.77 = alloca i32
  %.75 = alloca i32
  store i32 1, i32* %.75
  store i32 1, i32* %.77
  br label %.79wc39 
.79wc39:
  %.83 = load i32, i32* %.77
  %.84 = load i32, i32* @.g.height
  %.85 = icmp sle i32 %.83, %.84
  br i1 %.85, label %.80wloop.39.52, label %.81wn52
.80wloop.39.52:
  store i32 1, i32* %.75
  br label %.88wc41 
.81wn52:
  ret void
.88wc41:
  %.92 = load i32, i32* %.75
  %.93 = load i32, i32* @.g.width
  %.94 = icmp sle i32 %.92, %.93
  br i1 %.94, label %.89wloop.41.48, label %.90wn48
.89wloop.41.48:
  %.98 = load i32, i32* %.77
  %.99 = load i32, i32* %.75
  %.100 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 %.98, i32 %.99
  %.101 = load i32, i32* %.100
  %.102 = icmp eq i32 %.101, 1
  br i1 %.102, label %.96, label %.97
.90wn48:
  call void @putch(i32 10)
  %.117 = load i32, i32* %.77
  %.118 = add i32 %.117, 1
  store i32 %.118, i32* %.77
  br label %.79wc39 
.96:
  call void @putch(i32 35)
  br label %.106 
.97:
  call void @putch(i32 46)
  br label %.106 
.106:
  %.111 = load i32, i32* %.75
  %.112 = add i32 %.111, 1
  store i32 %.112, i32* %.75
  br label %.88wc41 
}
define void @swap12(){
.123:
  %.126 = alloca i32
  %.124 = alloca i32
  store i32 1, i32* %.124
  store i32 1, i32* %.126
  br label %.128wc59 
.128wc59:
  %.132 = load i32, i32* %.126
  %.133 = load i32, i32* @.g.height
  %.134 = icmp sle i32 %.132, %.133
  br i1 %.134, label %.129wloop.59.66, label %.130wn66
.129wloop.59.66:
  store i32 1, i32* %.124
  br label %.137wc61 
.130wn66:
  ret void
.137wc61:
  %.141 = load i32, i32* %.124
  %.142 = load i32, i32* @.g.width
  %.143 = icmp sle i32 %.141, %.142
  br i1 %.143, label %.138wloop.61.64, label %.139wn64
.138wloop.61.64:
  %.145 = load i32, i32* %.126
  %.146 = load i32, i32* %.124
  %.147 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet2, i32 0, i32 %.145, i32 %.146
  %.148 = load i32, i32* %.147
  %.149 = load i32, i32* %.126
  %.150 = load i32, i32* %.124
  %.151 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 %.149, i32 %.150
  store i32 %.148, i32* %.151
  %.153 = load i32, i32* %.124
  %.154 = add i32 %.153, 1
  store i32 %.154, i32* %.124
  br label %.137wc61 
.139wn64:
  %.157 = load i32, i32* %.126
  %.158 = add i32 %.157, 1
  store i32 %.158, i32* %.126
  br label %.128wc59 
}
define void @step([500 x i32]* %.165, [500 x i32]* %.168){
.163:
  %.191 = alloca i32
  %.172 = alloca i32
  %.170 = alloca i32
  %.167 = alloca [500 x i32]*
  %.164 = alloca [500 x i32]*
  store [500 x i32]* %.165, [500 x i32]** %.164
  store [500 x i32]* %.168, [500 x i32]** %.167
  store i32 1, i32* %.170
  store i32 1, i32* %.172
  br label %.174wc73 
.174wc73:
  %.178 = load i32, i32* %.172
  %.179 = load i32, i32* @.g.height
  %.180 = icmp sle i32 %.178, %.179
  br i1 %.180, label %.175wloop.73.90, label %.176wn90
.175wloop.73.90:
  store i32 1, i32* %.170
  br label %.183wc75 
.176wn90:
  ret void
.183wc75:
  %.187 = load i32, i32* %.170
  %.188 = load i32, i32* @.g.width
  %.189 = icmp sle i32 %.187, %.188
  br i1 %.189, label %.184wloop.75.88, label %.185wn88
.184wloop.75.88:
  %.192 = load i32, i32* %.172
  %.193 = sub i32 %.192, 1
  %.194 = load i32, i32* %.170
  %.195 = sub i32 %.194, 1
  %.196 = load [500 x i32]*, [500 x i32]** %.164
  %.197 = getelementptr inbounds [500 x i32], [500 x i32]* %.196, i32 %.193, i32 %.195
  %.198 = load i32, i32* %.197
  %.199 = load i32, i32* %.172
  %.200 = sub i32 %.199, 1
  %.201 = load i32, i32* %.170
  %.202 = load [500 x i32]*, [500 x i32]** %.164
  %.203 = getelementptr inbounds [500 x i32], [500 x i32]* %.202, i32 %.200, i32 %.201
  %.204 = load i32, i32* %.203
  %.205 = add i32 %.198, %.204
  %.206 = load i32, i32* %.172
  %.207 = sub i32 %.206, 1
  %.208 = load i32, i32* %.170
  %.209 = add i32 %.208, 1
  %.210 = load [500 x i32]*, [500 x i32]** %.164
  %.211 = getelementptr inbounds [500 x i32], [500 x i32]* %.210, i32 %.207, i32 %.209
  %.212 = load i32, i32* %.211
  %.213 = add i32 %.205, %.212
  %.214 = load i32, i32* %.172
  %.215 = load i32, i32* %.170
  %.216 = sub i32 %.215, 1
  %.217 = load [500 x i32]*, [500 x i32]** %.164
  %.218 = getelementptr inbounds [500 x i32], [500 x i32]* %.217, i32 %.214, i32 %.216
  %.219 = load i32, i32* %.218
  %.220 = add i32 %.213, %.219
  %.221 = load i32, i32* %.172
  %.222 = load i32, i32* %.170
  %.223 = add i32 %.222, 1
  %.224 = load [500 x i32]*, [500 x i32]** %.164
  %.225 = getelementptr inbounds [500 x i32], [500 x i32]* %.224, i32 %.221, i32 %.223
  %.226 = load i32, i32* %.225
  %.227 = add i32 %.220, %.226
  %.228 = load i32, i32* %.172
  %.229 = add i32 %.228, 1
  %.230 = load i32, i32* %.170
  %.231 = sub i32 %.230, 1
  %.232 = load [500 x i32]*, [500 x i32]** %.164
  %.233 = getelementptr inbounds [500 x i32], [500 x i32]* %.232, i32 %.229, i32 %.231
  %.234 = load i32, i32* %.233
  %.235 = add i32 %.227, %.234
  %.236 = load i32, i32* %.172
  %.237 = add i32 %.236, 1
  %.238 = load i32, i32* %.170
  %.239 = load [500 x i32]*, [500 x i32]** %.164
  %.240 = getelementptr inbounds [500 x i32], [500 x i32]* %.239, i32 %.237, i32 %.238
  %.241 = load i32, i32* %.240
  %.242 = add i32 %.235, %.241
  %.243 = load i32, i32* %.172
  %.244 = add i32 %.243, 1
  %.245 = load i32, i32* %.170
  %.246 = add i32 %.245, 1
  %.247 = load [500 x i32]*, [500 x i32]** %.164
  %.248 = getelementptr inbounds [500 x i32], [500 x i32]* %.247, i32 %.244, i32 %.246
  %.249 = load i32, i32* %.248
  %.250 = add i32 %.242, %.249
  store i32 %.250, i32* %.191
  %.254 = load i32, i32* %.172
  %.255 = load i32, i32* %.170
  %.256 = load [500 x i32]*, [500 x i32]** %.164
  %.257 = getelementptr inbounds [500 x i32], [500 x i32]* %.256, i32 %.254, i32 %.255
  %.258 = load i32, i32* %.257
  %.259 = icmp eq i32 %.258, 1
  br i1 %.259, label %.260, label %.253
.185wn88:
  %.297 = load i32, i32* %.172
  %.298 = add i32 %.297, 1
  store i32 %.298, i32* %.172
  br label %.174wc73 
.252:
  %.266 = load i32, i32* %.172
  %.267 = load i32, i32* %.170
  %.268 = load [500 x i32]*, [500 x i32]** %.167
  %.269 = getelementptr inbounds [500 x i32], [500 x i32]* %.268, i32 %.266, i32 %.267
  store i32 1, i32* %.269
  br label %.271 
.253:
  %.275 = load i32, i32* %.191
  %.277 = icmp eq i32 %.275, 3
  br i1 %.277, label %.273, label %.274
.260:
  %.262 = load i32, i32* %.191
  %.264 = icmp eq i32 %.262, 2
  br i1 %.264, label %.252, label %.253
.271:
  %.293 = load i32, i32* %.170
  %.294 = add i32 %.293, 1
  store i32 %.294, i32* %.170
  br label %.183wc75 
.273:
  %.279 = load i32, i32* %.172
  %.280 = load i32, i32* %.170
  %.281 = load [500 x i32]*, [500 x i32]** %.167
  %.282 = getelementptr inbounds [500 x i32], [500 x i32]* %.281, i32 %.279, i32 %.280
  store i32 1, i32* %.282
  br label %.284 
.274:
  %.286 = load i32, i32* %.172
  %.287 = load i32, i32* %.170
  %.288 = load [500 x i32]*, [500 x i32]** %.167
  %.289 = getelementptr inbounds [500 x i32], [500 x i32]* %.288, i32 %.286, i32 %.287
  store i32 0, i32* %.289
  br label %.284 
.284:
  br label %.271 
}
define i32 @main(){
.303:
  call void @read_map()
  call void @_sysy_starttime(i32 95)
  br label %.308wc96 
.308wc96:
  %.312 = load i32, i32* @.g.steps
  %.313 = icmp sgt i32 %.312, 0
  br i1 %.313, label %.309wloop.96.105, label %.310wn105
.309wloop.96.105:
  %.317 = load i32, i32* @.g.active
  %.318 = icmp eq i32 %.317, 1
  br i1 %.318, label %.315, label %.316
.310wn105:
  call void @_sysy_stoptime(i32 106)
  %.340 = load i32, i32* @.g.active
  %.341 = icmp eq i32 %.340, 2
  br i1 %.341, label %.338, label %.339
.315:
  %.320 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 0
  %.321 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet2, i32 0, i32 0
  call void @step([500 x i32]* %.320, [500 x i32]* %.321)
  store i32 2, i32* @.g.active
  br label %.324 
.316:
  %.326 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet2, i32 0, i32 0
  %.327 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 0
  call void @step([500 x i32]* %.326, [500 x i32]* %.327)
  store i32 1, i32* @.g.active
  br label %.324 
.324:
  %.331 = load i32, i32* @.g.steps
  %.332 = sub i32 %.331, 1
  store i32 %.332, i32* @.g.steps
  br label %.308wc96 
.338:
  call void @swap12()
  br label %.339 
.339:
  call void @put_map()
  ret i32 0 
}
@.g.sheet1 = global [500 x [500 x i32]] zeroinitializer
@.g.sheet2 = global [500 x [500 x i32]] zeroinitializer
@.g.active = global i32 1
@.g.width = global i32 zeroinitializer
@.g.height = global i32 zeroinitializer
@.g.steps = global i32 zeroinitializer
define void @read_map(){
.11:
  %.42 = alloca i32
  %.23 = alloca i32
  %.21 = alloca i32
  %.13at9 = call i32 @getint()
  store i32 %.13at9, i32* @.g.width
  %.15at10 = call i32 @getint()
  store i32 %.15at10, i32* @.g.height
  %.17at12 = call i32 @getint()
  store i32 %.17at12, i32* @.g.steps
  %.20at13 = call i32 @getch()
  store i32 1, i32* %.21
  store i32 1, i32* %.23
  br label %.25wc18 
.25wc18:
  %.29 = load i32, i32* %.23
  %.30 = load i32, i32* @.g.height
  %.31 = icmp sle i32 %.29, %.30
  br i1 %.31, label %.26wloop.18.32, label %.27wn32
.26wloop.18.32:
  store i32 1, i32* %.21
  br label %.34wc20 
.27wn32:
  ret void
.34wc20:
  %.38 = load i32, i32* %.21
  %.39 = load i32, i32* @.g.width
  %.40 = icmp sle i32 %.38, %.39
  br i1 %.40, label %.35wloop.20.28, label %.36wn28
.35wloop.20.28:
  %.43at21 = call i32 @getch()
  store i32 %.43at21, i32* %.42
  %.47 = load i32, i32* %.42
  %.49 = icmp eq i32 %.47, 35
  br i1 %.49, label %.45, label %.46
.36wn28:
  %.67at30 = call i32 @getch()
  %.68 = load i32, i32* %.23
  %.69 = add i32 %.68, 1
  store i32 %.69, i32* %.23
  br label %.25wc18 
.45:
  %.51 = load i32, i32* %.23
  %.52 = load i32, i32* %.21
  %.53 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 %.51, i32 %.52
  store i32 1, i32* %.53
  br label %.56 
.46:
  %.58 = load i32, i32* %.23
  %.59 = load i32, i32* %.21
  %.60 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 %.58, i32 %.59
  store i32 0, i32* %.60
  br label %.56 
.56:
  %.63 = load i32, i32* %.21
  %.64 = add i32 %.63, 1
  store i32 %.64, i32* %.21
  br label %.34wc20 
}
define void @put_map(){
.74:
  %.77 = alloca i32
  %.75 = alloca i32
  store i32 1, i32* %.75
  store i32 1, i32* %.77
  br label %.79wc39 
.79wc39:
  %.83 = load i32, i32* %.77
  %.84 = load i32, i32* @.g.height
  %.85 = icmp sle i32 %.83, %.84
  br i1 %.85, label %.80wloop.39.52, label %.81wn52
.80wloop.39.52:
  store i32 1, i32* %.75
  br label %.88wc41 
.81wn52:
  ret void
.88wc41:
  %.92 = load i32, i32* %.75
  %.93 = load i32, i32* @.g.width
  %.94 = icmp sle i32 %.92, %.93
  br i1 %.94, label %.89wloop.41.48, label %.90wn48
.89wloop.41.48:
  %.98 = load i32, i32* %.77
  %.99 = load i32, i32* %.75
  %.100 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 %.98, i32 %.99
  %.101 = load i32, i32* %.100
  %.102 = icmp eq i32 %.101, 1
  br i1 %.102, label %.96, label %.97
.90wn48:
  call void @putch(i32 10)
  %.117 = load i32, i32* %.77
  %.118 = add i32 %.117, 1
  store i32 %.118, i32* %.77
  br label %.79wc39 
.96:
  call void @putch(i32 35)
  br label %.106 
.97:
  call void @putch(i32 46)
  br label %.106 
.106:
  %.111 = load i32, i32* %.75
  %.112 = add i32 %.111, 1
  store i32 %.112, i32* %.75
  br label %.88wc41 
}
define void @swap12(){
.123:
  %.126 = alloca i32
  %.124 = alloca i32
  store i32 1, i32* %.124
  store i32 1, i32* %.126
  br label %.128wc59 
.128wc59:
  %.132 = load i32, i32* %.126
  %.133 = load i32, i32* @.g.height
  %.134 = icmp sle i32 %.132, %.133
  br i1 %.134, label %.129wloop.59.66, label %.130wn66
.129wloop.59.66:
  store i32 1, i32* %.124
  br label %.137wc61 
.130wn66:
  ret void
.137wc61:
  %.141 = load i32, i32* %.124
  %.142 = load i32, i32* @.g.width
  %.143 = icmp sle i32 %.141, %.142
  br i1 %.143, label %.138wloop.61.64, label %.139wn64
.138wloop.61.64:
  %.145 = load i32, i32* %.126
  %.146 = load i32, i32* %.124
  %.147 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet2, i32 0, i32 %.145, i32 %.146
  %.148 = load i32, i32* %.147
  %.149 = load i32, i32* %.126
  %.150 = load i32, i32* %.124
  %.151 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 %.149, i32 %.150
  store i32 %.148, i32* %.151
  %.153 = load i32, i32* %.124
  %.154 = add i32 %.153, 1
  store i32 %.154, i32* %.124
  br label %.137wc61 
.139wn64:
  %.157 = load i32, i32* %.126
  %.158 = add i32 %.157, 1
  store i32 %.158, i32* %.126
  br label %.128wc59 
}
define void @step([500 x i32]* %.165, [500 x i32]* %.168){
.163:
  %.191 = alloca i32
  %.172 = alloca i32
  %.170 = alloca i32
  %.167 = alloca [500 x i32]*
  %.164 = alloca [500 x i32]*
  store [500 x i32]* %.165, [500 x i32]** %.164
  store [500 x i32]* %.168, [500 x i32]** %.167
  store i32 1, i32* %.170
  store i32 1, i32* %.172
  br label %.174wc73 
.174wc73:
  %.178 = load i32, i32* %.172
  %.179 = load i32, i32* @.g.height
  %.180 = icmp sle i32 %.178, %.179
  br i1 %.180, label %.175wloop.73.90, label %.176wn90
.175wloop.73.90:
  store i32 1, i32* %.170
  br label %.183wc75 
.176wn90:
  ret void
.183wc75:
  %.187 = load i32, i32* %.170
  %.188 = load i32, i32* @.g.width
  %.189 = icmp sle i32 %.187, %.188
  br i1 %.189, label %.184wloop.75.88, label %.185wn88
.184wloop.75.88:
  %.192 = load i32, i32* %.172
  %.193 = sub i32 %.192, 1
  %.194 = load i32, i32* %.170
  %.195 = sub i32 %.194, 1
  %.196 = load [500 x i32]*, [500 x i32]** %.164
  %.197 = getelementptr inbounds [500 x i32], [500 x i32]* %.196, i32 %.193, i32 %.195
  %.198 = load i32, i32* %.197
  %.199 = load i32, i32* %.172
  %.200 = sub i32 %.199, 1
  %.201 = load i32, i32* %.170
  %.202 = load [500 x i32]*, [500 x i32]** %.164
  %.203 = getelementptr inbounds [500 x i32], [500 x i32]* %.202, i32 %.200, i32 %.201
  %.204 = load i32, i32* %.203
  %.205 = add i32 %.198, %.204
  %.206 = load i32, i32* %.172
  %.207 = sub i32 %.206, 1
  %.208 = load i32, i32* %.170
  %.209 = add i32 %.208, 1
  %.210 = load [500 x i32]*, [500 x i32]** %.164
  %.211 = getelementptr inbounds [500 x i32], [500 x i32]* %.210, i32 %.207, i32 %.209
  %.212 = load i32, i32* %.211
  %.213 = add i32 %.205, %.212
  %.214 = load i32, i32* %.172
  %.215 = load i32, i32* %.170
  %.216 = sub i32 %.215, 1
  %.217 = load [500 x i32]*, [500 x i32]** %.164
  %.218 = getelementptr inbounds [500 x i32], [500 x i32]* %.217, i32 %.214, i32 %.216
  %.219 = load i32, i32* %.218
  %.220 = add i32 %.213, %.219
  %.221 = load i32, i32* %.172
  %.222 = load i32, i32* %.170
  %.223 = add i32 %.222, 1
  %.224 = load [500 x i32]*, [500 x i32]** %.164
  %.225 = getelementptr inbounds [500 x i32], [500 x i32]* %.224, i32 %.221, i32 %.223
  %.226 = load i32, i32* %.225
  %.227 = add i32 %.220, %.226
  %.228 = load i32, i32* %.172
  %.229 = add i32 %.228, 1
  %.230 = load i32, i32* %.170
  %.231 = sub i32 %.230, 1
  %.232 = load [500 x i32]*, [500 x i32]** %.164
  %.233 = getelementptr inbounds [500 x i32], [500 x i32]* %.232, i32 %.229, i32 %.231
  %.234 = load i32, i32* %.233
  %.235 = add i32 %.227, %.234
  %.236 = load i32, i32* %.172
  %.237 = add i32 %.236, 1
  %.238 = load i32, i32* %.170
  %.239 = load [500 x i32]*, [500 x i32]** %.164
  %.240 = getelementptr inbounds [500 x i32], [500 x i32]* %.239, i32 %.237, i32 %.238
  %.241 = load i32, i32* %.240
  %.242 = add i32 %.235, %.241
  %.243 = load i32, i32* %.172
  %.244 = add i32 %.243, 1
  %.245 = load i32, i32* %.170
  %.246 = add i32 %.245, 1
  %.247 = load [500 x i32]*, [500 x i32]** %.164
  %.248 = getelementptr inbounds [500 x i32], [500 x i32]* %.247, i32 %.244, i32 %.246
  %.249 = load i32, i32* %.248
  %.250 = add i32 %.242, %.249
  store i32 %.250, i32* %.191
  %.254 = load i32, i32* %.172
  %.255 = load i32, i32* %.170
  %.256 = load [500 x i32]*, [500 x i32]** %.164
  %.257 = getelementptr inbounds [500 x i32], [500 x i32]* %.256, i32 %.254, i32 %.255
  %.258 = load i32, i32* %.257
  %.259 = icmp eq i32 %.258, 1
  br i1 %.259, label %.260, label %.253
.185wn88:
  %.297 = load i32, i32* %.172
  %.298 = add i32 %.297, 1
  store i32 %.298, i32* %.172
  br label %.174wc73 
.252:
  %.266 = load i32, i32* %.172
  %.267 = load i32, i32* %.170
  %.268 = load [500 x i32]*, [500 x i32]** %.167
  %.269 = getelementptr inbounds [500 x i32], [500 x i32]* %.268, i32 %.266, i32 %.267
  store i32 1, i32* %.269
  br label %.271 
.253:
  %.275 = load i32, i32* %.191
  %.277 = icmp eq i32 %.275, 3
  br i1 %.277, label %.273, label %.274
.260:
  %.262 = load i32, i32* %.191
  %.264 = icmp eq i32 %.262, 2
  br i1 %.264, label %.252, label %.253
.271:
  %.293 = load i32, i32* %.170
  %.294 = add i32 %.293, 1
  store i32 %.294, i32* %.170
  br label %.183wc75 
.273:
  %.279 = load i32, i32* %.172
  %.280 = load i32, i32* %.170
  %.281 = load [500 x i32]*, [500 x i32]** %.167
  %.282 = getelementptr inbounds [500 x i32], [500 x i32]* %.281, i32 %.279, i32 %.280
  store i32 1, i32* %.282
  br label %.284 
.274:
  %.286 = load i32, i32* %.172
  %.287 = load i32, i32* %.170
  %.288 = load [500 x i32]*, [500 x i32]** %.167
  %.289 = getelementptr inbounds [500 x i32], [500 x i32]* %.288, i32 %.286, i32 %.287
  store i32 0, i32* %.289
  br label %.284 
.284:
  br label %.271 
}
define i32 @main(){
.303:
  call void @read_map()
  call void @_sysy_starttime(i32 95)
  br label %.308wc96 
.308wc96:
  %.312 = load i32, i32* @.g.steps
  %.313 = icmp sgt i32 %.312, 0
  br i1 %.313, label %.309wloop.96.105, label %.310wn105
.309wloop.96.105:
  %.317 = load i32, i32* @.g.active
  %.318 = icmp eq i32 %.317, 1
  br i1 %.318, label %.315, label %.316
.310wn105:
  call void @_sysy_stoptime(i32 106)
  %.340 = load i32, i32* @.g.active
  %.341 = icmp eq i32 %.340, 2
  br i1 %.341, label %.338, label %.339
.315:
  %.320 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet1, i32 0, i32 0
  %.321 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet2, i32 0, i32 0
  call void @step([500 x i32]* %.320, [500 x i32]* %.321)
  store i32 2, i32* @.g.active
  br label %.324 
.316:
  %.326 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.sheet2, i32 0, i32 0
  %.327 = getelementptr inbounds [500 x [500 x i32]], [500 x [500 x i32]]* @.g.shee