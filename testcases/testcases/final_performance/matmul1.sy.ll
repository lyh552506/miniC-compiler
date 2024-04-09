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
@.g.a = global [1000 x [1000 x i32]] zeroinitializer
@.g.b = global [1000 x [1000 x i32]] zeroinitializer
@.g.c = global [1000 x [1000 x i32]] zeroinitializer
define i32 @main(){
.6:
  %.231 = alloca i32
  %.196 = alloca i32
  %.138 = alloca i32
  %.91 = alloca i32
  %.11 = alloca i32
  %.10 = alloca i32
  %.9 = alloca i32
  %.8 = alloca i32
  %.7 = alloca i32
  store i32 0, i32* %.11
  store i32 0, i32* %.8
  br label %.15wc14 
.15wc14:
  %.19 = load i32, i32* %.8
  %.20 = icmp slt i32 %.19, 1000
  br i1 %.20, label %.16wloop.14.21, label %.17wn21
.16wloop.14.21:
  %.22 = load i32, i32* %.8
  %.23 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.a, i32 0, i32 %.22, i32 0
  %.25at16 = call i32 @getarray(i32* %.23)
  store i32 %.25at16, i32* %.7
  %.29 = load i32, i32* %.7
  %.30 = icmp ne i32 %.29, 1000
  br i1 %.30, label %.27, label %.28
.17wn21:
  call void @_sysy_starttime(i32 23)
  store i32 0, i32* %.8
  br label %.43wc26 
.27:
  %.32 = load i32, i32* %.7
  ret i32 %.32 
.28:
  %.34 = load i32, i32* %.8
  %.36 = add i32 %.34, 1
  store i32 %.36, i32* %.8
  br label %.15wc14 
.43wc26:
  %.47 = load i32, i32* %.8
  %.48 = icmp slt i32 %.47, 1000
  br i1 %.48, label %.44wloop.26.33, label %.45wn33
.44wloop.26.33:
  store i32 0, i32* %.9
  br label %.51wc28 
.45wn33:
  store i32 0, i32* %.8
  br label %.75wc36 
.51wc28:
  %.55 = load i32, i32* %.9
  %.56 = icmp slt i32 %.55, 1000
  br i1 %.56, label %.52wloop.28.31, label %.53wn31
.52wloop.28.31:
  %.58 = load i32, i32* %.9
  %.59 = load i32, i32* %.8
  %.60 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.a, i32 0, i32 %.58, i32 %.59
  %.61 = load i32, i32* %.60
  %.62 = load i32, i32* %.8
  %.63 = load i32, i32* %.9
  %.64 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.b, i32 0, i32 %.62, i32 %.63
  store i32 %.61, i32* %.64
  %.66 = load i32, i32* %.9
  %.67 = add i32 %.66, 1
  store i32 %.67, i32* %.9
  br label %.51wc28 
.53wn31:
  %.70 = load i32, i32* %.8
  %.71 = add i32 %.70, 1
  store i32 %.71, i32* %.8
  br label %.43wc26 
.75wc36:
  %.79 = load i32, i32* %.8
  %.80 = icmp slt i32 %.79, 1000
  br i1 %.80, label %.76wloop.36.49, label %.77wn49
.76wloop.36.49:
  store i32 0, i32* %.9
  br label %.83wc38 
.77wn49:
  store i32 0, i32* %.8
  br label %.130wc52 
.83wc38:
  %.87 = load i32, i32* %.9
  %.88 = icmp slt i32 %.87, 1000
  br i1 %.88, label %.84wloop.38.47, label %.85wn47
.84wloop.38.47:
  store i32 0, i32* %.10
  store i32 0, i32* %.91
  br label %.93wc41 
.85wn47:
  %.125 = load i32, i32* %.8
  %.126 = add i32 %.125, 1
  store i32 %.126, i32* %.8
  br label %.75wc36 
.93wc41:
  %.97 = load i32, i32* %.10
  %.98 = icmp slt i32 %.97, 1000
  br i1 %.98, label %.94wloop.41.44, label %.95wn44
.94wloop.41.44:
  %.100 = load i32, i32* %.91
  %.101 = load i32, i32* %.8
  %.102 = load i32, i32* %.10
  %.103 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.a, i32 0, i32 %.101, i32 %.102
  %.104 = load i32, i32* %.103
  %.105 = load i32, i32* %.10
  %.106 = load i32, i32* %.9
  %.107 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.b, i32 0, i32 %.105, i32 %.106
  %.108 = load i32, i32* %.107
  %.109 = mul i32 %.104, %.108
  %.110 = add i32 %.100, %.109
  store i32 %.110, i32* %.91
  %.112 = load i32, i32* %.10
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* %.10
  br label %.93wc41 
.95wn44:
  %.116 = load i32, i32* %.91
  %.117 = load i32, i32* %.8
  %.118 = load i32, i32* %.9
  %.119 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.117, i32 %.118
  store i32 %.116, i32* %.119
  %.121 = load i32, i32* %.9
  %.122 = add i32 %.121, 1
  store i32 %.122, i32* %.9
  br label %.83wc38 
.130wc52:
  %.134 = load i32, i32* %.8
  %.135 = icmp slt i32 %.134, 1000
  br i1 %.135, label %.131wloop.52.68, label %.132wn68
.131wloop.52.68:
  store i32 0, i32* %.9
  store i32 2147483647, i32* %.138
  br label %.140wc55 
.132wn68:
  store i32 0, i32* %.8
  br label %.188wc71 
.140wc55:
  %.144 = load i32, i32* %.9
  %.145 = icmp slt i32 %.144, 1000
  br i1 %.145, label %.141wloop.55.61, label %.142wn61
.141wloop.55.61:
  %.149 = load i32, i32* %.8
  %.150 = load i32, i32* %.9
  %.151 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.149, i32 %.150
  %.152 = load i32, i32* %.151
  %.153 = load i32, i32* %.138
  %.154 = icmp slt i32 %.152, %.153
  br i1 %.154, label %.147, label %.148
.142wn61:
  store i32 0, i32* %.9
  br label %.167wc63 
.147:
  %.156 = load i32, i32* %.8
  %.157 = load i32, i32* %.9
  %.158 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.156, i32 %.157
  %.159 = load i32, i32* %.158
  store i32 %.159, i32* %.138
  br label %.148 
.148:
  %.162 = load i32, i32* %.9
  %.163 = add i32 %.162, 1
  store i32 %.163, i32* %.9
  br label %.140wc55 
.167wc63:
  %.171 = load i32, i32* %.9
  %.172 = icmp slt i32 %.171, 1000
  br i1 %.172, label %.168wloop.63.66, label %.169wn66
.168wloop.63.66:
  %.174 = load i32, i32* %.138
  %.175 = load i32, i32* %.8
  %.176 = load i32, i32* %.9
  %.177 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.175, i32 %.176
  store i32 %.174, i32* %.177
  %.179 = load i32, i32* %.9
  %.180 = add i32 %.179, 1
  store i32 %.180, i32* %.9
  br label %.167wc63 
.169wn66:
  %.183 = load i32, i32* %.8
  %.184 = add i32 %.183, 1
  store i32 %.184, i32* %.8
  br label %.130wc52 
.188wc71:
  %.192 = load i32, i32* %.8
  %.193 = icmp slt i32 %.192, 1000
  br i1 %.193, label %.189wloop.71.79, label %.190wn79
.189wloop.71.79:
  store i32 0, i32* %.9
  store i32 2147483647, i32* %.196
  br label %.198wc74 
.190wn79:
  store i32 0, i32* %.8
  br label %.223wc82 
.198wc74:
  %.202 = load i32, i32* %.9
  %.203 = icmp slt i32 %.202, 1000
  br i1 %.203, label %.199wloop.74.77, label %.200wn77
.199wloop.74.77:
  %.205 = load i32, i32* %.9
  %.206 = load i32, i32* %.8
  %.207 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.205, i32 %.206
  %.208 = load i32, i32* %.207
  %.209 = sub i32 0, %.208
  %.210 = load i32, i32* %.8
  %.211 = load i32, i32* %.9
  %.212 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.210, i32 %.211
  store i32 %.209, i32* %.212
  %.214 = load i32, i32* %.9
  %.215 = add i32 %.214, 1
  store i32 %.215, i32* %.9
  br label %.198wc74 
.200wn77:
  %.218 = load i32, i32* %.8
  %.219 = add i32 %.218, 1
  store i32 %.219, i32* %.8
  br label %.188wc71 
.223wc82:
  %.227 = load i32, i32* %.8
  %.228 = icmp slt i32 %.227, 1000
  br i1 %.228, label %.224wloop.82.90, label %.225wn90
.224wloop.82.90:
  store i32 0, i32* %.9
  store i32 2147483647, i32* %.231
  br label %.233wc85 
.225wn90:
  call void @_sysy_stoptime(i32 92)
  %.258 = load i32, i32* %.11
  call void @putint(i32 %.258)
  ret i32 0 
.233wc85:
  %.237 = load i32, i32* %.9
  %.238 = icmp slt i32 %.237, 1000
  br i1 %.238, label %.234wloop.85.88, label %.235wn88
.234wloop.85.88:
  %.240 = load i32, i32* %.11
  %.241 = load i32, i32* %.8
  %.242 = load i32, i32* %.9
  %.243 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.241, i32 %.242
  %.244 = load i32, i32* %.243
  %.245 = add i32 %.240, %.244
  store i32 %.245, i32* %.11
  %.247 = load i32, i32* %.9
  %.248 = add i32 %.247, 1
  store i32 %.248, i32* %.9
  br label %.233wc85 
.235wn88:
  %.251 = load i32, i32* %.8
  %.252 = add i32 %.251, 1
  store i32 %.252, i32* %.8
  br label %.223wc82 
}
@.g.a = global [1000 x [1000 x i32]] zeroinitializer
@.g.b = global [1000 x [1000 x i32]] zeroinitializer
@.g.c = global [1000 x [1000 x i32]] zeroinitializer
define i32 @main(){
.6:
  %.231 = alloca i32
  %.196 = alloca i32
  %.138 = alloca i32
  %.91 = alloca i32
  %.11 = alloca i32
  %.10 = alloca i32
  %.9 = alloca i32
  %.8 = alloca i32
  %.7 = alloca i32
  store i32 0, i32* %.11
  store i32 0, i32* %.8
  br label %.15wc14 
.15wc14:
  %.19 = load i32, i32* %.8
  %.20 = icmp slt i32 %.19, 1000
  br i1 %.20, label %.16wloop.14.21, label %.17wn21
.16wloop.14.21:
  %.22 = load i32, i32* %.8
  %.23 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.a, i32 0, i32 %.22, i32 0
  %.25at16 = call i32 @getarray(i32* %.23)
  store i32 %.25at16, i32* %.7
  %.29 = load i32, i32* %.7
  %.30 = icmp ne i32 %.29, 1000
  br i1 %.30, label %.27, label %.28
.17wn21:
  call void @_sysy_starttime(i32 23)
  store i32 0, i32* %.8
  br label %.43wc26 
.27:
  %.32 = load i32, i32* %.7
  ret i32 %.32 
.28:
  %.34 = load i32, i32* %.8
  %.36 = add i32 %.34, 1
  store i32 %.36, i32* %.8
  br label %.15wc14 
.43wc26:
  %.47 = load i32, i32* %.8
  %.48 = icmp slt i32 %.47, 1000
  br i1 %.48, label %.44wloop.26.33, label %.45wn33
.44wloop.26.33:
  store i32 0, i32* %.9
  br label %.51wc28 
.45wn33:
  store i32 0, i32* %.8
  br label %.75wc36 
.51wc28:
  %.55 = load i32, i32* %.9
  %.56 = icmp slt i32 %.55, 1000
  br i1 %.56, label %.52wloop.28.31, label %.53wn31
.52wloop.28.31:
  %.58 = load i32, i32* %.9
  %.59 = load i32, i32* %.8
  %.60 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.a, i32 0, i32 %.58, i32 %.59
  %.61 = load i32, i32* %.60
  %.62 = load i32, i32* %.8
  %.63 = load i32, i32* %.9
  %.64 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.b, i32 0, i32 %.62, i32 %.63
  store i32 %.61, i32* %.64
  %.66 = load i32, i32* %.9
  %.67 = add i32 %.66, 1
  store i32 %.67, i32* %.9
  br label %.51wc28 
.53wn31:
  %.70 = load i32, i32* %.8
  %.71 = add i32 %.70, 1
  store i32 %.71, i32* %.8
  br label %.43wc26 
.75wc36:
  %.79 = load i32, i32* %.8
  %.80 = icmp slt i32 %.79, 1000
  br i1 %.80, label %.76wloop.36.49, label %.77wn49
.76wloop.36.49:
  store i32 0, i32* %.9
  br label %.83wc38 
.77wn49:
  store i32 0, i32* %.8
  br label %.130wc52 
.83wc38:
  %.87 = load i32, i32* %.9
  %.88 = icmp slt i32 %.87, 1000
  br i1 %.88, label %.84wloop.38.47, label %.85wn47
.84wloop.38.47:
  store i32 0, i32* %.10
  store i32 0, i32* %.91
  br label %.93wc41 
.85wn47:
  %.125 = load i32, i32* %.8
  %.126 = add i32 %.125, 1
  store i32 %.126, i32* %.8
  br label %.75wc36 
.93wc41:
  %.97 = load i32, i32* %.10
  %.98 = icmp slt i32 %.97, 1000
  br i1 %.98, label %.94wloop.41.44, label %.95wn44
.94wloop.41.44:
  %.100 = load i32, i32* %.91
  %.101 = load i32, i32* %.8
  %.102 = load i32, i32* %.10
  %.103 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.a, i32 0, i32 %.101, i32 %.102
  %.104 = load i32, i32* %.103
  %.105 = load i32, i32* %.10
  %.106 = load i32, i32* %.9
  %.107 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.b, i32 0, i32 %.105, i32 %.106
  %.108 = load i32, i32* %.107
  %.109 = mul i32 %.104, %.108
  %.110 = add i32 %.100, %.109
  store i32 %.110, i32* %.91
  %.112 = load i32, i32* %.10
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* %.10
  br label %.93wc41 
.95wn44:
  %.116 = load i32, i32* %.91
  %.117 = load i32, i32* %.8
  %.118 = load i32, i32* %.9
  %.119 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.117, i32 %.118
  store i32 %.116, i32* %.119
  %.121 = load i32, i32* %.9
  %.122 = add i32 %.121, 1
  store i32 %.122, i32* %.9
  br label %.83wc38 
.130wc52:
  %.134 = load i32, i32* %.8
  %.135 = icmp slt i32 %.134, 1000
  br i1 %.135, label %.131wloop.52.68, label %.132wn68
.131wloop.52.68:
  store i32 0, i32* %.9
  store i32 2147483647, i32* %.138
  br label %.140wc55 
.132wn68:
  store i32 0, i32* %.8
  br label %.188wc71 
.140wc55:
  %.144 = load i32, i32* %.9
  %.145 = icmp slt i32 %.144, 1000
  br i1 %.145, label %.141wloop.55.61, label %.142wn61
.141wloop.55.61:
  %.149 = load i32, i32* %.8
  %.150 = load i32, i32* %.9
  %.151 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.149, i32 %.150
  %.152 = load i32, i32* %.151
  %.153 = load i32, i32* %.138
  %.154 = icmp slt i32 %.152, %.153
  br i1 %.154, label %.147, label %.148
.142wn61:
  store i32 0, i32* %.9
  br label %.167wc63 
.147:
  %.156 = load i32, i32* %.8
  %.157 = load i32, i32* %.9
  %.158 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.156, i32 %.157
  %.159 = load i32, i32* %.158
  store i32 %.159, i32* %.138
  br label %.148 
.148:
  %.162 = load i32, i32* %.9
  %.163 = add i32 %.162, 1
  store i32 %.163, i32* %.9
  br label %.140wc55 
.167wc63:
  %.171 = load i32, i32* %.9
  %.172 = icmp slt i32 %.171, 1000
  br i1 %.172, label %.168wloop.63.66, label %.169wn66
.168wloop.63.66:
  %.174 = load i32, i32* %.138
  %.175 = load i32, i32* %.8
  %.176 = load i32, i32* %.9
  %.177 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.175, i32 %.176
  store i32 %.174, i32* %.177
  %.179 = load i32, i32* %.9
  %.180 = add i32 %.179, 1
  store i32 %.180, i32* %.9
  br label %.167wc63 
.169wn66:
  %.183 = load i32, i32* %.8
  %.184 = add i32 %.183, 1
  store i32 %.184, i32* %.8
  br label %.130wc52 
.188wc71:
  %.192 = load i32, i32* %.8
  %.193 = icmp slt i32 %.192, 1000
  br i1 %.193, label %.189wloop.71.79, label %.190wn79
.189wloop.71.79:
  store i32 0, i32* %.9
  store i32 2147483647, i32* %.196
  br label %.198wc74 
.190wn79:
  store i32 0, i32* %.8
  br label %.223wc82 
.198wc74:
  %.202 = load i32, i32* %.9
  %.203 = icmp slt i32 %.202, 1000
  br i1 %.203, label %.199wloop.74.77, label %.200wn77
.199wloop.74.77:
  %.205 = load i32, i32* %.9
  %.206 = load i32, i32* %.8
  %.207 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.205, i32 %.206
  %.208 = load i32, i32* %.207
  %.209 = sub i32 0, %.208
  %.210 = load i32, i32* %.8
  %.211 = load i32, i32* %.9
  %.212 = getelementptr inbounds [1000 x [1000 x i32]], [1000 x [1000 x i32]]* @.g.c, i32 0, i32 %.210, i32 %.211
  store i32 %.209, i32* %.212
  %.214 = load i32, i32* %.9
  %.215 = add i32 %.214, 1
  store i32 %.215, i32* %.9
  br label %.198wc74 
.200wn77:
  %.218 = load i32, i32* %.8
  %.219 = add i32 %.218, 1
  store i32 %.219, i32* %.8
  br label %.188wc71 
.223wc82:
  %.227 = load i32, i32* %.8
  %.228 = icmp slt i32 %.227, 1000
  br i1 %.228, label %.224wloop.82.90, label %.225wn90
.224wloop.82.90:
  store i32 0, i32* %.9
  store i32 2147483647, i32* %.231
  br label %.233wc85 
.225wn90:
  call void @_sysy_stoptime(i32 92)
  %.258 = load i32, i32* %.11
  call void @putint(i32 %.258)
  ret i32 0 
.233wc85:
  %.237 = load i32, i32* %.9
  %.238 = icmp slt i32 %.237, 1000
  br i1 %.238, label %.234wloop.85.88, label %.235wn88
.234wloop.85.88:
  %.240 = load i32, i32* %.11
  %.241 = load i32, i32* %.8
  %.242 = load i32, i32*