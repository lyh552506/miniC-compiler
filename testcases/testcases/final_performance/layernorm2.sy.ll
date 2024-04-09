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
@.g.a = global [1000 x [1000 x float]] zeroinitializer
define float @myAbs(float %.3){
.1:
  %.2 = alloca float
  store float %.3, float* %.2
  %.7 = load float, float* %.2
  %.9 = sitofp i32 0 to float
  %.10 = fcmp ult float %.7, %.9
  br i1 %.10, label %.5, label %.6
.5:
  %.12 = load float, float* %.2
  %.14 = fsub float 0x0, %.12
  store float %.14, float* %.2
  br label %.6 
.6:
  %.17 = load float, float* %.2
  ret float %.17 
}
define float @sqrt(float %.22){
.20:
  %.30 = alloca float
  %.27 = alloca float
  %.24 = alloca float
  %.21 = alloca float
  store float %.22, float* %.21
  %.25 = sitofp i32 0 to float
  store float %.25, float* %.24
  %.28 = load float, float* %.21
  store float %.28, float* %.27
  %.31 = load float, float* %.24
  %.32 = load float, float* %.27
  %.33 = fadd float %.31, %.32
  %.35 = sitofp i32 2 to float
  %.36 = fdiv float %.33, %.35
  store float %.36, float* %.30
  br label %.38wc12 
.38wc12:
  %.42 = load float, float* %.30
  %.43 = load float, float* %.30
  %.44 = fmul float %.42, %.43
  %.45 = load float, float* %.21
  %.46 = fsub float %.44, %.45
  %.47at12 = call float @myAbs(float %.46)
  %.49 = fcmp ugt float %.47at12, 0x3f50624de0000000
  br i1 %.49, label %.39wloop.12.21, label %.40wn21
.39wloop.12.21:
  %.53 = load float, float* %.30
  %.54 = load float, float* %.30
  %.55 = fmul float %.53, %.54
  %.56 = load float, float* %.21
  %.57 = fcmp ugt float %.55, %.56
  br i1 %.57, label %.51, label %.52
.40wn21:
  %.79 = load float, float* %.30
  ret float %.79 
.51:
  %.59 = load float, float* %.30
  store float %.59, float* %.27
  %.61 = load float, float* %.30
  %.62 = load float, float* %.24
  %.63 = fadd float %.61, %.62
  %.64 = sitofp i32 2 to float
  %.65 = fdiv float %.63, %.64
  store float %.65, float* %.30
  br label %.67 
.52:
  %.69 = load float, float* %.30
  store float %.69, float* %.24
  %.71 = load float, float* %.30
  %.72 = load float, float* %.27
  %.73 = fadd float %.71, %.72
  %.74 = sitofp i32 2 to float
  %.75 = fdiv float %.73, %.74
  store float %.75, float* %.30
  br label %.67 
.67:
  br label %.38wc12 
}
define i32 @main(){
.84:
  %.177 = alloca [1000 x float]
  %.129 = alloca [1000 x float]
  %.89 = alloca float
  %.88 = alloca i32
  %.87 = alloca i32
  %.86 = alloca i32
  %.85 = alloca i32
  %.90 = sitofp i32 0 to float
  store float %.90, float* %.89
  store i32 0, i32* %.86
  br label %.93wc33 
.93wc33:
  %.97 = load i32, i32* %.86
  %.98 = icmp slt i32 %.97, 1000
  br i1 %.98, label %.94wloop.33.40, label %.95wn40
.94wloop.33.40:
  %.100 = load i32, i32* %.86
  %.101 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.100, i32 0
  %.103at35 = call i32 @getfarray(float* %.101)
  store i32 %.103at35, i32* %.85
  %.107 = load i32, i32* %.85
  %.108 = icmp ne i32 %.107, 1000
  br i1 %.108, label %.105, label %.106
.95wn40:
  call void @_sysy_starttime(i32 42)
  store i32 0, i32* %.88
  br label %.121wc45 
.105:
  %.110 = load i32, i32* %.85
  ret i32 %.110 
.106:
  %.112 = load i32, i32* %.86
  %.114 = add i32 %.112, 1
  store i32 %.114, i32* %.86
  br label %.93wc33 
.121wc45:
  %.125 = load i32, i32* %.88
  %.127 = icmp slt i32 %.125, 100
  br i1 %.127, label %.122wloop.45.83, label %.123wn83
.122wloop.45.83:
  store i32 0, i32* %.86
  br label %.131wc49 
.123wn83:
  store i32 0, i32* %.86
  br label %.299wc86 
.131wc49:
  %.135 = load i32, i32* %.86
  %.136 = icmp slt i32 %.135, 1000
  br i1 %.136, label %.132wloop.49.58, label %.133wn58
.132wloop.49.58:
  store i32 0, i32* %.87
  %.139 = load i32, i32* %.86
  %.140 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.139
  %.141 = sitofp i32 0 to float
  store float %.141, float* %.140
  br label %.143wc52 
.133wn58:
  store i32 0, i32* %.86
  br label %.179wc61 
.143wc52:
  %.147 = load i32, i32* %.87
  %.148 = icmp slt i32 %.147, 1000
  br i1 %.148, label %.144wloop.52.55, label %.145wn55
.144wloop.52.55:
  %.150 = load i32, i32* %.86
  %.151 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.150
  %.152 = load float, float* %.151
  %.153 = load i32, i32* %.86
  %.154 = load i32, i32* %.87
  %.155 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.153, i32 %.154
  %.156 = load float, float* %.155
  %.157 = fadd float %.152, %.156
  %.158 = load i32, i32* %.86
  %.159 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.158
  store float %.157, float* %.159
  %.161 = load i32, i32* %.87
  %.162 = add i32 %.161, 1
  store i32 %.162, i32* %.87
  br label %.143wc52 
.145wn55:
  %.165 = load i32, i32* %.86
  %.166 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.165
  %.167 = load float, float* %.166
  %.168 = sitofp i32 1000 to float
  %.169 = fdiv float %.167, %.168
  %.170 = load i32, i32* %.86
  %.171 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.170
  store float %.169, float* %.171
  %.173 = load i32, i32* %.86
  %.174 = add i32 %.173, 1
  store i32 %.174, i32* %.86
  br label %.131wc49 
.179wc61:
  %.183 = load i32, i32* %.86
  %.184 = icmp slt i32 %.183, 1000
  br i1 %.184, label %.180wloop.61.71, label %.181wn71
.180wloop.61.71:
  store i32 0, i32* %.87
  %.187 = load i32, i32* %.86
  %.188 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.187
  %.189 = sitofp i32 0 to float
  store float %.189, float* %.188
  br label %.191wc64 
.181wn71:
  store i32 0, i32* %.86
  br label %.248wc73 
.191wc64:
  %.195 = load i32, i32* %.87
  %.196 = icmp slt i32 %.195, 1000
  br i1 %.196, label %.192wloop.64.67, label %.193wn67
.192wloop.64.67:
  %.198 = load i32, i32* %.86
  %.199 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.198
  %.200 = load float, float* %.199
  %.201 = load i32, i32* %.86
  %.202 = load i32, i32* %.87
  %.203 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.201, i32 %.202
  %.204 = load float, float* %.203
  %.205 = load i32, i32* %.86
  %.206 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.205
  %.207 = load float, float* %.206
  %.208 = fsub float %.204, %.207
  %.209 = load i32, i32* %.86
  %.210 = load i32, i32* %.87
  %.211 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.209, i32 %.210
  %.212 = load float, float* %.211
  %.213 = load i32, i32* %.86
  %.214 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.213
  %.215 = load float, float* %.214
  %.216 = fsub float %.212, %.215
  %.217 = fmul float %.208, %.216
  %.218 = fadd float %.200, %.217
  %.219 = load i32, i32* %.86
  %.220 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.219
  store float %.218, float* %.220
  %.222 = load i32, i32* %.87
  %.223 = add i32 %.222, 1
  store i32 %.223, i32* %.87
  br label %.191wc64 
.193wn67:
  %.226 = load i32, i32* %.86
  %.227 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.226
  %.228 = load float, float* %.227
  %.229 = sitofp i32 1000 to float
  %.230 = fdiv float %.228, %.229
  %.231 = load i32, i32* %.86
  %.232 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.231
  store float %.230, float* %.232
  %.234 = load i32, i32* %.86
  %.235 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.234
  %.236 = load float, float* %.235
  %.238 = fadd float %.236, 0x3f847ae140000000
  %.239at69 = call float @sqrt(float %.238)
  %.240 = load i32, i32* %.86
  %.241 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.240
  store float %.239at69, float* %.241
  %.243 = load i32, i32* %.86
  %.244 = add i32 %.243, 1
  store i32 %.244, i32* %.86
  br label %.179wc61 
.248wc73:
  %.252 = load i32, i32* %.86
  %.253 = icmp slt i32 %.252, 1000
  br i1 %.253, label %.249wloop.73.81, label %.250wn81
.249wloop.73.81:
  store i32 0, i32* %.87
  br label %.256wc75 
.250wn81:
  %.294 = load i32, i32* %.88
  %.295 = add i32 %.294, 1
  store i32 %.295, i32* %.88
  br label %.121wc45 
.256wc75:
  %.260 = load i32, i32* %.87
  %.261 = icmp slt i32 %.260, 1000
  br i1 %.261, label %.257wloop.75.79, label %.258wn79
.257wloop.75.79:
  %.263 = load i32, i32* %.86
  %.264 = load i32, i32* %.87
  %.265 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.263, i32 %.264
  %.266 = load float, float* %.265
  %.267 = load i32, i32* %.86
  %.268 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.267
  %.269 = load float, float* %.268
  %.270 = fsub float %.266, %.269
  %.271 = load i32, i32* %.86
  %.272 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.271
  %.273 = load float, float* %.272
  %.274 = fdiv float %.270, %.273
  %.275 = load i32, i32* %.86
  %.276 = load i32, i32* %.87
  %.277 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.275, i32 %.276
  store float %.274, float* %.277
  %.279 = load float, float* %.89
  %.280 = load i32, i32* %.86
  %.281 = load i32, i32* %.87
  %.282 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.280, i32 %.281
  %.283 = load float, float* %.282
  %.284 = fadd float %.279, %.283
  store float %.284, float* %.89
  %.286 = load i32, i32* %.87
  %.287 = add i32 %.286, 1
  store i32 %.287, i32* %.87
  br label %.256wc75 
.258wn79:
  %.290 = load i32, i32* %.86
  %.291 = add i32 %.290, 1
  store i32 %.291, i32* %.86
  br label %.248wc73 
.299wc86:
  %.303 = load i32, i32* %.86
  %.304 = icmp slt i32 %.303, 1000
  br i1 %.304, label %.300wloop.86.93, label %.301wn93
.300wloop.86.93:
  store i32 0, i32* %.87
  br label %.307wc88 
.301wn93:
  call void @_sysy_stoptime(i32 95)
  %.332 = load float, float* %.89
  call void @putfloat(float %.332)
  ret i32 0 
.307wc88:
  %.311 = load i32, i32* %.87
  %.312 = icmp slt i32 %.311, 1000
  br i1 %.312, label %.308wloop.88.91, label %.309wn91
.308wloop.88.91:
  %.314 = load float, float* %.89
  %.315 = load i32, i32* %.86
  %.316 = load i32, i32* %.87
  %.317 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.315, i32 %.316
  %.318 = load float, float* %.317
  %.319 = fadd float %.314, %.318
  store float %.319, float* %.89
  %.321 = load i32, i32* %.87
  %.322 = add i32 %.321, 1
  store i32 %.322, i32* %.87
  br label %.307wc88 
.309wn91:
  %.325 = load i32, i32* %.86
  %.326 = add i32 %.325, 1
  store i32 %.326, i32* %.86
  br label %.299wc86 
}
@.g.a = global [1000 x [1000 x float]] zeroinitializer
define float @myAbs(float %.3){
.1:
  %.2 = alloca float
  store float %.3, float* %.2
  %.7 = load float, float* %.2
  %.9 = sitofp i32 0 to float
  %.10 = fcmp ult float %.7, %.9
  br i1 %.10, label %.5, label %.6
.5:
  %.12 = load float, float* %.2
  %.14 = fsub float 0x0, %.12
  store float %.14, float* %.2
  br label %.6 
.6:
  %.17 = load float, float* %.2
  ret float %.17 
}
define float @sqrt(float %.22){
.20:
  %.30 = alloca float
  %.27 = alloca float
  %.24 = alloca float
  %.21 = alloca float
  store float %.22, float* %.21
  %.25 = sitofp i32 0 to float
  store float %.25, float* %.24
  %.28 = load float, float* %.21
  store float %.28, float* %.27
  %.31 = load float, float* %.24
  %.32 = load float, float* %.27
  %.33 = fadd float %.31, %.32
  %.35 = sitofp i32 2 to float
  %.36 = fdiv float %.33, %.35
  store float %.36, float* %.30
  br label %.38wc12 
.38wc12:
  %.42 = load float, float* %.30
  %.43 = load float, float* %.30
  %.44 = fmul float %.42, %.43
  %.45 = load float, float* %.21
  %.46 = fsub float %.44, %.45
  %.47at12 = call float @myAbs(float %.46)
  %.49 = fcmp ugt float %.47at12, 0x3f50624de0000000
  br i1 %.49, label %.39wloop.12.21, label %.40wn21
.39wloop.12.21:
  %.53 = load float, float* %.30
  %.54 = load float, float* %.30
  %.55 = fmul float %.53, %.54
  %.56 = load float, float* %.21
  %.57 = fcmp ugt float %.55, %.56
  br i1 %.57, label %.51, label %.52
.40wn21:
  %.79 = load float, float* %.30
  ret float %.79 
.51:
  %.59 = load float, float* %.30
  store float %.59, float* %.27
  %.61 = load float, float* %.30
  %.62 = load float, float* %.24
  %.63 = fadd float %.61, %.62
  %.64 = sitofp i32 2 to float
  %.65 = fdiv float %.63, %.64
  store float %.65, float* %.30
  br label %.67 
.52:
  %.69 = load float, float* %.30
  store float %.69, float* %.24
  %.71 = load float, float* %.30
  %.72 = load float, float* %.27
  %.73 = fadd float %.71, %.72
  %.74 = sitofp i32 2 to float
  %.75 = fdiv float %.73, %.74
  store float %.75, float* %.30
  br label %.67 
.67:
  br label %.38wc12 
}
define i32 @main(){
.84:
  %.177 = alloca [1000 x float]
  %.129 = alloca [1000 x float]
  %.89 = alloca float
  %.88 = alloca i32
  %.87 = alloca i32
  %.86 = alloca i32
  %.85 = alloca i32
  %.90 = sitofp i32 0 to float
  store float %.90, float* %.89
  store i32 0, i32* %.86
  br label %.93wc33 
.93wc33:
  %.97 = load i32, i32* %.86
  %.98 = icmp slt i32 %.97, 1000
  br i1 %.98, label %.94wloop.33.40, label %.95wn40
.94wloop.33.40:
  %.100 = load i32, i32* %.86
  %.101 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.100, i32 0
  %.103at35 = call i32 @getfarray(float* %.101)
  store i32 %.103at35, i32* %.85
  %.107 = load i32, i32* %.85
  %.108 = icmp ne i32 %.107, 1000
  br i1 %.108, label %.105, label %.106
.95wn40:
  call void @_sysy_starttime(i32 42)
  store i32 0, i32* %.88
  br label %.121wc45 
.105:
  %.110 = load i32, i32* %.85
  ret i32 %.110 
.106:
  %.112 = load i32, i32* %.86
  %.114 = add i32 %.112, 1
  store i32 %.114, i32* %.86
  br label %.93wc33 
.121wc45:
  %.125 = load i32, i32* %.88
  %.127 = icmp slt i32 %.125, 100
  br i1 %.127, label %.122wloop.45.83, label %.123wn83
.122wloop.45.83:
  store i32 0, i32* %.86
  br label %.131wc49 
.123wn83:
  store i32 0, i32* %.86
  br label %.299wc86 
.131wc49:
  %.135 = load i32, i32* %.86
  %.136 = icmp slt i32 %.135, 1000
  br i1 %.136, label %.132wloop.49.58, label %.133wn58
.132wloop.49.58:
  store i32 0, i32* %.87
  %.139 = load i32, i32* %.86
  %.140 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.139
  %.141 = sitofp i32 0 to float
  store float %.141, float* %.140
  br label %.143wc52 
.133wn58:
  store i32 0, i32* %.86
  br label %.179wc61 
.143wc52:
  %.147 = load i32, i32* %.87
  %.148 = icmp slt i32 %.147, 1000
  br i1 %.148, label %.144wloop.52.55, label %.145wn55
.144wloop.52.55:
  %.150 = load i32, i32* %.86
  %.151 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.150
  %.152 = load float, float* %.151
  %.153 = load i32, i32* %.86
  %.154 = load i32, i32* %.87
  %.155 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.153, i32 %.154
  %.156 = load float, float* %.155
  %.157 = fadd float %.152, %.156
  %.158 = load i32, i32* %.86
  %.159 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.158
  store float %.157, float* %.159
  %.161 = load i32, i32* %.87
  %.162 = add i32 %.161, 1
  store i32 %.162, i32* %.87
  br label %.143wc52 
.145wn55:
  %.165 = load i32, i32* %.86
  %.166 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.165
  %.167 = load float, float* %.166
  %.168 = sitofp i32 1000 to float
  %.169 = fdiv float %.167, %.168
  %.170 = load i32, i32* %.86
  %.171 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.170
  store float %.169, float* %.171
  %.173 = load i32, i32* %.86
  %.174 = add i32 %.173, 1
  store i32 %.174, i32* %.86
  br label %.131wc49 
.179wc61:
  %.183 = load i32, i32* %.86
  %.184 = icmp slt i32 %.183, 1000
  br i1 %.184, label %.180wloop.61.71, label %.181wn71
.180wloop.61.71:
  store i32 0, i32* %.87
  %.187 = load i32, i32* %.86
  %.188 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.187
  %.189 = sitofp i32 0 to float
  store float %.189, float* %.188
  br label %.191wc64 
.181wn71:
  store i32 0, i32* %.86
  br label %.248wc73 
.191wc64:
  %.195 = load i32, i32* %.87
  %.196 = icmp slt i32 %.195, 1000
  br i1 %.196, label %.192wloop.64.67, label %.193wn67
.192wloop.64.67:
  %.198 = load i32, i32* %.86
  %.199 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.198
  %.200 = load float, float* %.199
  %.201 = load i32, i32* %.86
  %.202 = load i32, i32* %.87
  %.203 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.201, i32 %.202
  %.204 = load float, float* %.203
  %.205 = load i32, i32* %.86
  %.206 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.205
  %.207 = load float, float* %.206
  %.208 = fsub float %.204, %.207
  %.209 = load i32, i32* %.86
  %.210 = load i32, i32* %.87
  %.211 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.209, i32 %.210
  %.212 = load float, float* %.211
  %.213 = load i32, i32* %.86
  %.214 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.213
  %.215 = load float, float* %.214
  %.216 = fsub float %.212, %.215
  %.217 = fmul float %.208, %.216
  %.218 = fadd float %.200, %.217
  %.219 = load i32, i32* %.86
  %.220 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.219
  store float %.218, float* %.220
  %.222 = load i32, i32* %.87
  %.223 = add i32 %.222, 1
  store i32 %.223, i32* %.87
  br label %.191wc64 
.193wn67:
  %.226 = load i32, i32* %.86
  %.227 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.226
  %.228 = load float, float* %.227
  %.229 = sitofp i32 1000 to float
  %.230 = fdiv float %.228, %.229
  %.231 = load i32, i32* %.86
  %.232 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.231
  store float %.230, float* %.232
  %.234 = load i32, i32* %.86
  %.235 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.234
  %.236 = load float, float* %.235
  %.238 = fadd float %.236, 0x3f847ae140000000
  %.239at69 = call float @sqrt(float %.238)
  %.240 = load i32, i32* %.86
  %.241 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.240
  store float %.239at69, float* %.241
  %.243 = load i32, i32* %.86
  %.244 = add i32 %.243, 1
  store i32 %.244, i32* %.86
  br label %.179wc61 
.248wc73:
  %.252 = load i32, i32* %.86
  %.253 = icmp slt i32 %.252, 1000
  br i1 %.253, label %.249wloop.73.81, label %.250wn81
.249wloop.73.81:
  store i32 0, i32* %.87
  br label %.256wc75 
.250wn81:
  %.294 = load i32, i32* %.88
  %.295 = add i32 %.294, 1
  store i32 %.295, i32* %.88
  br label %.121wc45 
.256wc75:
  %.260 = load i32, i32* %.87
  %.261 = icmp slt i32 %.260, 1000
  br i1 %.261, label %.257wloop.75.79, label %.258wn79
.257wloop.75.79:
  %.263 = load i32, i32* %.86
  %.264 = load i32, i32* %.87
  %.265 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.263, i32 %.264
  %.266 = load float, float* %.265
  %.267 = load i32, i32* %.86
  %.268 = getelementptr inbounds [1000 x float], [1000 x float]* %.129, i32 0, i32 %.267
  %.269 = load float, float* %.268
  %.270 = fsub float %.266, %.269
  %.271 = load i32, i32* %.86
  %.272 = getelementptr inbounds [1000 x float], [1000 x float]* %.177, i32 0, i32 %.271
  %.273 = load float, float* %.272
  %.274 = fdiv float %.270, %.273
  %.275 = load i32, i32* %.86
  %.276 = load i32, i32* %.87
  %.277 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.275, i32 %.276
  store float %.274, float* %.277
  %.279 = load float, float* %.89
  %.280 = load i32, i32* %.86
  %.281 = load i32, i32* %.87
  %.282 = getelementptr inbounds [1000 x [1000 x float]], [1000 x [1000 x float]]* @.g.a, i32 0, i32 %.280, i32 %.281
  %.283 = load float, float* %.282
  %.284 = fadd float %.279, %.283
  store float %.284, float* %.89
  %.286 = load i32, i32* %.87
  %.287 = add i32 %.286, 1
  store i32 %.287, i32* %.87
  br label %.256wc75 
.258wn79:
  %.290 = load i32, i32* %.86
  %.291 = add i32 %.290, 1
  store i32 %.291, i32* %.86
  br label %.248wc73 
.299wc86:
  %.303 = load i32, i32* %.86
  %.304 = icmp slt i32 %.303, 1000
  br i1 %.304, label %.300wloop.86.93, label %.301wn93
.300wloop.86.93:
  store i32 0, i32* %.87
  br label %.307wc88 
.301wn93:
  call void @_sysy_stoptime(i32 95)
  %.332 = load float, float* %.89
  call void @putfloat(float %.332)
  ret i32 0 
.307wc88:
  %.311 = load i32, i32* %.87
  %.312 = icmp slt i32 %.311, 1000
  br i1 %.312, label %.308wloop.88.91, label %.309wn91
.308wloop.88.91:
  %.314 = load float, float* %.89
  %.315 = load i32, i32* %.86
  %.316 = load i32, i32* %.87
  %.317 = getelementptr 