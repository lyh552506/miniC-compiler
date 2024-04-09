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
@.g.temp = global float 1
define i32 @func(i32 %.3, i32 %.6){
.1:
  %.5 = alloca i32
  %.2 = alloca i32
  store i32 %.3, i32* %.2
  store i32 %.6, i32* %.5
  %.8 = load i32, i32* %.2
  %.9 = load i32, i32* %.5
  %.10 = add i32 %.8, %.9
  %.11 = load i32, i32* %.2
  %.12 = load i32, i32* %.5
  %.13 = add i32 %.11, %.12
  %.15 = add i32 %.13, 1
  %.16 = mul i32 %.10, %.15
  %.18 = sdiv i32 %.16, 2
  %.19 = load i32, i32* %.2
  %.20 = add i32 %.18, %.19
  %.21 = add i32 %.20, 1
  ret i32 %.21 
}
define float @Vectordot(float* %.26, float* %.29, i32 %.32){
.24:
  %.37 = alloca float
  %.34 = alloca i32
  %.31 = alloca i32
  %.28 = alloca float*
  %.25 = alloca float*
  store float* %.26, float** %.25
  store float* %.29, float** %.28
  store i32 %.32, i32* %.31
  store i32 0, i32* %.34
  %.38 = sitofp i32 0 to float
  store float %.38, float* %.37
  br label %.40wc8 
.40wc8:
  %.44 = load i32, i32* %.34
  %.45 = load i32, i32* %.31
  %.46 = icmp slt i32 %.44, %.45
  br i1 %.46, label %.41wloop.8.11, label %.42wn11
.41wloop.8.11:
  %.48 = load float, float* %.37
  %.49 = load i32, i32* %.34
  %.50 = load float*, float** %.25
  %.51 = getelementptr inbounds float, float* %.50, i32 %.49
  %.52 = load float, float* %.51
  %.53 = load i32, i32* %.34
  %.54 = load float*, float** %.28
  %.55 = getelementptr inbounds float, float* %.54, i32 %.53
  %.56 = load float, float* %.55
  %.57 = fmul float %.52, %.56
  %.58 = fadd float %.48, %.57
  store float %.58, float* %.37
  %.60 = load i32, i32* %.34
  %.61 = add i32 %.60, 1
  store i32 %.61, i32* %.34
  br label %.40wc8 
.42wn11:
  %.64 = load float, float* %.37
  ret float %.64 
}
define void @mult1(float* %.69, float* %.72, i32 %.75){
.67:
  %.81 = alloca float
  %.79 = alloca i32
  %.77 = alloca i32
  %.74 = alloca i32
  %.71 = alloca float*
  %.68 = alloca float*
  store float* %.69, float** %.68
  store float* %.72, float** %.71
  store i32 %.75, i32* %.74
  store i32 0, i32* %.77
  store i32 0, i32* %.79
  %.82 = sitofp i32 0 to float
  store float %.82, float* %.81
  br label %.84wc19 
.84wc19:
  %.88 = load i32, i32* %.77
  %.89 = load i32, i32* %.74
  %.90 = icmp slt i32 %.88, %.89
  br i1 %.90, label %.85wloop.19.26, label %.86wn26
.85wloop.19.26:
  br label %.92wc20 
.86wn26:
  ret void
.92wc20:
  %.96 = load i32, i32* %.79
  %.97 = load i32, i32* %.74
  %.98 = icmp slt i32 %.96, %.97
  br i1 %.98, label %.93wloop.20.23, label %.94wn23
.93wloop.20.23:
  %.100 = load float, float* %.81
  %.101 = load i32, i32* %.79
  %.102 = load float*, float** %.68
  %.103 = getelementptr inbounds float, float* %.102, i32 %.101
  %.104 = load float, float* %.103
  %.105 = load i32, i32* %.77
  %.106 = load i32, i32* %.79
  %.107at21 = call i32 @func(i32 %.105, i32 %.106)
  %.108 = sitofp i32 %.107at21 to float
  %.109 = fdiv float %.104, %.108
  %.110 = fadd float %.100, %.109
  store float %.110, float* %.81
  %.112 = load i32, i32* %.79
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* %.79
  br label %.92wc20 
.94wn23:
  %.116 = load float, float* %.81
  %.117 = load i32, i32* %.77
  %.118 = load float*, float** %.71
  %.119 = getelementptr inbounds float, float* %.118, i32 %.117
  store float %.116, float* %.119
  %.121 = load i32, i32* %.77
  %.122 = add i32 %.121, 1
  store i32 %.122, i32* %.77
  br label %.84wc19 
}
define void @mult2(float* %.129, float* %.132, i32 %.135){
.127:
  %.141 = alloca float
  %.139 = alloca i32
  %.137 = alloca i32
  %.134 = alloca i32
  %.131 = alloca float*
  %.128 = alloca float*
  store float* %.129, float** %.128
  store float* %.132, float** %.131
  store i32 %.135, i32* %.134
  store i32 0, i32* %.137
  store i32 0, i32* %.139
  %.142 = sitofp i32 0 to float
  store float %.142, float* %.141
  br label %.144wc33 
.144wc33:
  %.148 = load i32, i32* %.137
  %.149 = load i32, i32* %.134
  %.150 = icmp slt i32 %.148, %.149
  br i1 %.150, label %.145wloop.33.40, label %.146wn40
.145wloop.33.40:
  br label %.152wc34 
.146wn40:
  ret void
.152wc34:
  %.156 = load i32, i32* %.139
  %.157 = load i32, i32* %.134
  %.158 = icmp slt i32 %.156, %.157
  br i1 %.158, label %.153wloop.34.37, label %.154wn37
.153wloop.34.37:
  %.160 = load float, float* %.141
  %.161 = load i32, i32* %.139
  %.162 = load float*, float** %.128
  %.163 = getelementptr inbounds float, float* %.162, i32 %.161
  %.164 = load float, float* %.163
  %.165 = load i32, i32* %.139
  %.166 = load i32, i32* %.137
  %.167at35 = call i32 @func(i32 %.165, i32 %.166)
  %.168 = sitofp i32 %.167at35 to float
  %.169 = fdiv float %.164, %.168
  %.170 = fadd float %.160, %.169
  store float %.170, float* %.141
  %.172 = load i32, i32* %.139
  %.173 = add i32 %.172, 1
  store i32 %.173, i32* %.139
  br label %.152wc34 
.154wn37:
  %.176 = load float, float* %.141
  %.177 = load i32, i32* %.137
  %.178 = load float*, float** %.131
  %.179 = getelementptr inbounds float, float* %.178, i32 %.177
  store float %.176, float* %.179
  %.181 = load i32, i32* %.137
  %.182 = add i32 %.181, 1
  store i32 %.182, i32* %.137
  br label %.144wc33 
}
define void @mult_combin(float* %.189, float* %.192, i32 %.195, float* %.198){
.187:
  %.197 = alloca float*
  %.194 = alloca i32
  %.191 = alloca float*
  %.188 = alloca float*
  store float* %.189, float** %.188
  store float* %.192, float** %.191
  store i32 %.195, i32* %.194
  store float* %.198, float** %.197
  %.200 = load float*, float** %.188
  %.201 = load float*, float** %.197
  %.202 = load i32, i32* %.194
  call void @mult1(float* %.200, float* %.201, i32 %.202)
  %.204 = load float*, float** %.197
  %.205 = load float*, float** %.191
  %.206 = load i32, i32* %.194
  call void @mult2(float* %.204, float* %.205, i32 %.206)
  ret void
}
define float @my_sqrt(float %.213){
.211:
  %.212 = alloca float
  store float %.213, float* %.212
  br label %.215wc51 
.215wc51:
  %.220 = load float, float* @.g.temp
  %.221 = load float, float* %.212
  %.222 = load float, float* @.g.temp
  %.223 = fdiv float %.221, %.222
  %.224 = fsub float %.220, %.223
  %.226 = fcmp ugt float %.224, 0x3eb0c6f7a0000000
  br i1 %.226, label %.216wloop.51.53, label %.219
.216wloop.51.53:
  %.237 = load float, float* @.g.temp
  %.238 = load float, float* %.212
  %.239 = load float, float* @.g.temp
  %.240 = fdiv float %.238, %.239
  %.241 = fadd float %.237, %.240
  %.242 = sitofp i32 2 to float
  %.243 = fdiv float %.241, %.242
  store float %.243, float* @.g.temp
  br label %.215wc51 
.217wn53:
  %.246 = load float, float* @.g.temp
  ret float %.246 
.219:
  %.228 = load float, float* @.g.temp
  %.229 = load float, float* %.212
  %.230 = load float, float* @.g.temp
  %.231 = fdiv float %.229, %.230
  %.232 = fsub float %.228, %.231
  %.235 = fcmp ult float %.232, 0xbeb0c6f7a0000000
  br i1 %.235, label %.216wloop.51.53, label %.217wn53
}
define i32 @main(){
.249:
  %.310 = alloca float
  %.267 = alloca i32
  %.266 = alloca [100000 x float]
  %.265 = alloca [100000 x float]
  %.264 = alloca [100000 x float]
  %.250 = alloca i32
  store i32 100000, i32* %.250
  %.255 = load i32, i32* %.250
  %.256 = icmp sle i32 %.255, 0
  br i1 %.256, label %.253, label %.254
.253:
  store i32 2000, i32* %.250
  br label %.254 
.254:
  call void @_sysy_starttime(i32 62)
  br label %.268wc66 
.268wc66:
  %.272 = load i32, i32* %.267
  %.273 = load i32, i32* %.250
  %.274 = icmp slt i32 %.272, %.273
  br i1 %.274, label %.269wloop.66.69, label %.270wn69
.269wloop.66.69:
  %.276 = load i32, i32* %.267
  %.277 = getelementptr inbounds [100000 x float], [100000 x float]* %.264, i32 0, i32 %.276
  %.278 = sitofp i32 1 to float
  store float %.278, float* %.277
  %.280 = load i32, i32* %.267
  %.281 = add i32 %.280, 1
  store i32 %.281, i32* %.267
  br label %.268wc66 
.270wn69:
  store i32 0, i32* %.267
  br label %.285wc71 
.285wc71:
  %.289 = load i32, i32* %.267
  %.291 = icmp slt i32 %.289, 1000
  br i1 %.291, label %.286wloop.71.75, label %.287wn75
.286wloop.71.75:
  %.293 = getelementptr inbounds [100000 x float], [100000 x float]* %.264, i32 0, i32 0
  %.294 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.295 = load i32, i32* %.250
  %.296 = getelementptr inbounds [100000 x float], [100000 x float]* %.266, i32 0, i32 0
  call void @mult_combin(float* %.293, float* %.294, i32 %.295, float* %.296)
  %.298 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.299 = getelementptr inbounds [100000 x float], [100000 x float]* %.264, i32 0, i32 0
  %.300 = load i32, i32* %.250
  %.301 = getelementptr inbounds [100000 x float], [100000 x float]* %.266, i32 0, i32 0
  call void @mult_combin(float* %.298, float* %.299, i32 %.300, float* %.301)
  %.303 = load i32, i32* %.267
  %.304 = add i32 %.303, 1
  store i32 %.304, i32* %.267
  br label %.285wc71 
.287wn75:
  call void @_sysy_stoptime(i32 76)
  %.311 = getelementptr inbounds [100000 x float], [100000 x float]* %.264, i32 0, i32 0
  %.312 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.313 = load i32, i32* %.250
  %.314at77 = call float @Vectordot(float* %.311, float* %.312, i32 %.313)
  %.315 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.316 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.317 = load i32, i32* %.250
  %.318at77 = call float @Vectordot(float* %.315, float* %.316, i32 %.317)
  %.319 = fdiv float %.314at77, %.318at77
  %.320at77 = call float @my_sqrt(float %.319)
  store float %.320at77, float* %.310
  %.324 = load float, float* %.310
  %.326 = fsub float %.324, 0x3ff0000000000000
  %.327 = fcmp ule float %.326, 0x3eb0c6f7a0000000
  br i1 %.327, label %.328, label %.323
.322:
  call void @putint(i32 1)
  br label %.336 
.323:
  call void @putint(i32 0)
  br label %.336 
.328:
  %.330 = load float, float* %.310
  %.331 = fsub float %.330, 0x3ff0000000000000
  %.332 = fcmp uge float %.331, 0xbeb0c6f7a0000000
  br i1 %.332, label %.322, label %.323
.336:
  call void @putch(i32 10)
  ret i32 0 
}
@.g.temp = global float 1
define i32 @func(i32 %.3, i32 %.6){
.1:
  %.5 = alloca i32
  %.2 = alloca i32
  store i32 %.3, i32* %.2
  store i32 %.6, i32* %.5
  %.8 = load i32, i32* %.2
  %.9 = load i32, i32* %.5
  %.10 = add i32 %.8, %.9
  %.11 = load i32, i32* %.2
  %.12 = load i32, i32* %.5
  %.13 = add i32 %.11, %.12
  %.15 = add i32 %.13, 1
  %.16 = mul i32 %.10, %.15
  %.18 = sdiv i32 %.16, 2
  %.19 = load i32, i32* %.2
  %.20 = add i32 %.18, %.19
  %.21 = add i32 %.20, 1
  ret i32 %.21 
}
define float @Vectordot(float* %.26, float* %.29, i32 %.32){
.24:
  %.37 = alloca float
  %.34 = alloca i32
  %.31 = alloca i32
  %.28 = alloca float*
  %.25 = alloca float*
  store float* %.26, float** %.25
  store float* %.29, float** %.28
  store i32 %.32, i32* %.31
  store i32 0, i32* %.34
  %.38 = sitofp i32 0 to float
  store float %.38, float* %.37
  br label %.40wc8 
.40wc8:
  %.44 = load i32, i32* %.34
  %.45 = load i32, i32* %.31
  %.46 = icmp slt i32 %.44, %.45
  br i1 %.46, label %.41wloop.8.11, label %.42wn11
.41wloop.8.11:
  %.48 = load float, float* %.37
  %.49 = load i32, i32* %.34
  %.50 = load float*, float** %.25
  %.51 = getelementptr inbounds float, float* %.50, i32 %.49
  %.52 = load float, float* %.51
  %.53 = load i32, i32* %.34
  %.54 = load float*, float** %.28
  %.55 = getelementptr inbounds float, float* %.54, i32 %.53
  %.56 = load float, float* %.55
  %.57 = fmul float %.52, %.56
  %.58 = fadd float %.48, %.57
  store float %.58, float* %.37
  %.60 = load i32, i32* %.34
  %.61 = add i32 %.60, 1
  store i32 %.61, i32* %.34
  br label %.40wc8 
.42wn11:
  %.64 = load float, float* %.37
  ret float %.64 
}
define void @mult1(float* %.69, float* %.72, i32 %.75){
.67:
  %.81 = alloca float
  %.79 = alloca i32
  %.77 = alloca i32
  %.74 = alloca i32
  %.71 = alloca float*
  %.68 = alloca float*
  store float* %.69, float** %.68
  store float* %.72, float** %.71
  store i32 %.75, i32* %.74
  store i32 0, i32* %.77
  store i32 0, i32* %.79
  %.82 = sitofp i32 0 to float
  store float %.82, float* %.81
  br label %.84wc19 
.84wc19:
  %.88 = load i32, i32* %.77
  %.89 = load i32, i32* %.74
  %.90 = icmp slt i32 %.88, %.89
  br i1 %.90, label %.85wloop.19.26, label %.86wn26
.85wloop.19.26:
  br label %.92wc20 
.86wn26:
  ret void
.92wc20:
  %.96 = load i32, i32* %.79
  %.97 = load i32, i32* %.74
  %.98 = icmp slt i32 %.96, %.97
  br i1 %.98, label %.93wloop.20.23, label %.94wn23
.93wloop.20.23:
  %.100 = load float, float* %.81
  %.101 = load i32, i32* %.79
  %.102 = load float*, float** %.68
  %.103 = getelementptr inbounds float, float* %.102, i32 %.101
  %.104 = load float, float* %.103
  %.105 = load i32, i32* %.77
  %.106 = load i32, i32* %.79
  %.107at21 = call i32 @func(i32 %.105, i32 %.106)
  %.108 = sitofp i32 %.107at21 to float
  %.109 = fdiv float %.104, %.108
  %.110 = fadd float %.100, %.109
  store float %.110, float* %.81
  %.112 = load i32, i32* %.79
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* %.79
  br label %.92wc20 
.94wn23:
  %.116 = load float, float* %.81
  %.117 = load i32, i32* %.77
  %.118 = load float*, float** %.71
  %.119 = getelementptr inbounds float, float* %.118, i32 %.117
  store float %.116, float* %.119
  %.121 = load i32, i32* %.77
  %.122 = add i32 %.121, 1
  store i32 %.122, i32* %.77
  br label %.84wc19 
}
define void @mult2(float* %.129, float* %.132, i32 %.135){
.127:
  %.141 = alloca float
  %.139 = alloca i32
  %.137 = alloca i32
  %.134 = alloca i32
  %.131 = alloca float*
  %.128 = alloca float*
  store float* %.129, float** %.128
  store float* %.132, float** %.131
  store i32 %.135, i32* %.134
  store i32 0, i32* %.137
  store i32 0, i32* %.139
  %.142 = sitofp i32 0 to float
  store float %.142, float* %.141
  br label %.144wc33 
.144wc33:
  %.148 = load i32, i32* %.137
  %.149 = load i32, i32* %.134
  %.150 = icmp slt i32 %.148, %.149
  br i1 %.150, label %.145wloop.33.40, label %.146wn40
.145wloop.33.40:
  br label %.152wc34 
.146wn40:
  ret void
.152wc34:
  %.156 = load i32, i32* %.139
  %.157 = load i32, i32* %.134
  %.158 = icmp slt i32 %.156, %.157
  br i1 %.158, label %.153wloop.34.37, label %.154wn37
.153wloop.34.37:
  %.160 = load float, float* %.141
  %.161 = load i32, i32* %.139
  %.162 = load float*, float** %.128
  %.163 = getelementptr inbounds float, float* %.162, i32 %.161
  %.164 = load float, float* %.163
  %.165 = load i32, i32* %.139
  %.166 = load i32, i32* %.137
  %.167at35 = call i32 @func(i32 %.165, i32 %.166)
  %.168 = sitofp i32 %.167at35 to float
  %.169 = fdiv float %.164, %.168
  %.170 = fadd float %.160, %.169
  store float %.170, float* %.141
  %.172 = load i32, i32* %.139
  %.173 = add i32 %.172, 1
  store i32 %.173, i32* %.139
  br label %.152wc34 
.154wn37:
  %.176 = load float, float* %.141
  %.177 = load i32, i32* %.137
  %.178 = load float*, float** %.131
  %.179 = getelementptr inbounds float, float* %.178, i32 %.177
  store float %.176, float* %.179
  %.181 = load i32, i32* %.137
  %.182 = add i32 %.181, 1
  store i32 %.182, i32* %.137
  br label %.144wc33 
}
define void @mult_combin(float* %.189, float* %.192, i32 %.195, float* %.198){
.187:
  %.197 = alloca float*
  %.194 = alloca i32
  %.191 = alloca float*
  %.188 = alloca float*
  store float* %.189, float** %.188
  store float* %.192, float** %.191
  store i32 %.195, i32* %.194
  store float* %.198, float** %.197
  %.200 = load float*, float** %.188
  %.201 = load float*, float** %.197
  %.202 = load i32, i32* %.194
  call void @mult1(float* %.200, float* %.201, i32 %.202)
  %.204 = load float*, float** %.197
  %.205 = load float*, float** %.191
  %.206 = load i32, i32* %.194
  call void @mult2(float* %.204, float* %.205, i32 %.206)
  ret void
}
define float @my_sqrt(float %.213){
.211:
  %.212 = alloca float
  store float %.213, float* %.212
  br label %.215wc51 
.215wc51:
  %.220 = load float, float* @.g.temp
  %.221 = load float, float* %.212
  %.222 = load float, float* @.g.temp
  %.223 = fdiv float %.221, %.222
  %.224 = fsub float %.220, %.223
  %.226 = fcmp ugt float %.224, 0x3eb0c6f7a0000000
  br i1 %.226, label %.216wloop.51.53, label %.219
.216wloop.51.53:
  %.237 = load float, float* @.g.temp
  %.238 = load float, float* %.212
  %.239 = load float, float* @.g.temp
  %.240 = fdiv float %.238, %.239
  %.241 = fadd float %.237, %.240
  %.242 = sitofp i32 2 to float
  %.243 = fdiv float %.241, %.242
  store float %.243, float* @.g.temp
  br label %.215wc51 
.217wn53:
  %.246 = load float, float* @.g.temp
  ret float %.246 
.219:
  %.228 = load float, float* @.g.temp
  %.229 = load float, float* %.212
  %.230 = load float, float* @.g.temp
  %.231 = fdiv float %.229, %.230
  %.232 = fsub float %.228, %.231
  %.235 = fcmp ult float %.232, 0xbeb0c6f7a0000000
  br i1 %.235, label %.216wloop.51.53, label %.217wn53
}
define i32 @main(){
.249:
  %.310 = alloca float
  %.267 = alloca i32
  %.266 = alloca [100000 x float]
  %.265 = alloca [100000 x float]
  %.264 = alloca [100000 x float]
  %.250 = alloca i32
  store i32 100000, i32* %.250
  %.255 = load i32, i32* %.250
  %.256 = icmp sle i32 %.255, 0
  br i1 %.256, label %.253, label %.254
.253:
  store i32 2000, i32* %.250
  br label %.254 
.254:
  call void @_sysy_starttime(i32 62)
  br label %.268wc66 
.268wc66:
  %.272 = load i32, i32* %.267
  %.273 = load i32, i32* %.250
  %.274 = icmp slt i32 %.272, %.273
  br i1 %.274, label %.269wloop.66.69, label %.270wn69
.269wloop.66.69:
  %.276 = load i32, i32* %.267
  %.277 = getelementptr inbounds [100000 x float], [100000 x float]* %.264, i32 0, i32 %.276
  %.278 = sitofp i32 1 to float
  store float %.278, float* %.277
  %.280 = load i32, i32* %.267
  %.281 = add i32 %.280, 1
  store i32 %.281, i32* %.267
  br label %.268wc66 
.270wn69:
  store i32 0, i32* %.267
  br label %.285wc71 
.285wc71:
  %.289 = load i32, i32* %.267
  %.291 = icmp slt i32 %.289, 1000
  br i1 %.291, label %.286wloop.71.75, label %.287wn75
.286wloop.71.75:
  %.293 = getelementptr inbounds [100000 x float], [100000 x float]* %.264, i32 0, i32 0
  %.294 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.295 = load i32, i32* %.250
  %.296 = getelementptr inbounds [100000 x float], [100000 x float]* %.266, i32 0, i32 0
  call void @mult_combin(float* %.293, float* %.294, i32 %.295, float* %.296)
  %.298 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.299 = getelementptr inbounds [100000 x float], [100000 x float]* %.264, i32 0, i32 0
  %.300 = load i32, i32* %.250
  %.301 = getelementptr inbounds [100000 x float], [100000 x float]* %.266, i32 0, i32 0
  call void @mult_combin(float* %.298, float* %.299, i32 %.300, float* %.301)
  %.303 = load i32, i32* %.267
  %.304 = add i32 %.303, 1
  store i32 %.304, i32* %.267
  br label %.285wc71 
.287wn75:
  call void @_sysy_stoptime(i32 76)
  %.311 = getelementptr inbounds [100000 x float], [100000 x float]* %.264, i32 0, i32 0
  %.312 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.313 = load i32, i32* %.250
  %.314at77 = call float @Vectordot(float* %.311, float* %.312, i32 %.313)
  %.315 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.316 = getelementptr inbounds [100000 x float], [100000 x float]* %.265, i32 0, i32 0
  %.317 = load i32, i32* %.250
  %.318at77 = call float @Vectordot(float* %.315, float* %.316, i32 %.317)
  %.319 = fdiv float %.314at77, %.318at77
  %.320at77 = call float @my_sqrt(float %.319)
  store float %.320at77, float* %.310
  %.324 = load float, float* %.310
  %.326 = fsub float %.324, 0x3ff0000000000000
  %.327 = fcmp ule float %.326, 0x3eb0c6f7a0000000
  br i1 %.327, label %.328, label %.323
.322:
  call void @putint(i32 1)
  br label %.336 
.323:
  call void @putint(i32 0)
  br label %.336 
.328:
  %.330 = load float, float* %.310
  %.331 = fsub float %.330, 0x3ff0000000000000
  %.332 = fcmp uge float %.331, 0xb