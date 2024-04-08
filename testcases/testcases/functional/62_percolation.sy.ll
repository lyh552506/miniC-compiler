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
@.g.array = global [110 x i32] zeroinitializer
@.g.n = global i32 zeroinitializer
define void @init(i32 %.6){
.4:
  %.8 = alloca i32
  %.5 = alloca i32
  store i32 %.6, i32* %.5
  store i32 1, i32* %.8
  br label %.11wc5 
.11wc5:
  %.15 = load i32, i32* %.8
  %.16 = load i32, i32* %.5
  %.17 = load i32, i32* %.5
  %.18 = mul i32 %.16, %.17
  %.19 = add i32 %.18, 1
  %.20 = icmp sle i32 %.15, %.19
  br i1 %.20, label %.12wloop.5.8, label %.13wn8
.12wloop.5.8:
  %.24 = load i32, i32* %.8
  %.25 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.24
  store i32 -1, i32* %.25
  %.27 = load i32, i32* %.8
  %.28 = add i32 %.27, 1
  store i32 %.28, i32* %.8
  br label %.11wc5 
.13wn8:
  ret void
}
define i32 @findfa(i32 %.35){
.33:
  %.34 = alloca i32
  store i32 %.35, i32* %.34
  %.39 = load i32, i32* %.34
  %.40 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.39
  %.41 = load i32, i32* %.40
  %.42 = load i32, i32* %.34
  %.43 = icmp eq i32 %.41, %.42
  br i1 %.43, label %.37, label %.38
.37:
  %.45 = load i32, i32* %.34
  ret i32 %.45 
.38:
  %.47 = load i32, i32* %.34
  %.48 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.47
  %.49 = load i32, i32* %.48
  %.50at15 = call i32 @findfa(i32 %.49)
  %.51 = load i32, i32* %.34
  %.52 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.51
  store i32 %.50at15, i32* %.52
  %.54 = load i32, i32* %.34
  %.55 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.54
  %.56 = load i32, i32* %.55
  ret i32 %.56 
}
define void @mmerge(i32 %.61, i32 %.64){
.59:
  %.70 = alloca i32
  %.66 = alloca i32
  %.63 = alloca i32
  %.60 = alloca i32
  store i32 %.61, i32* %.60
  store i32 %.64, i32* %.63
  %.67 = load i32, i32* %.60
  %.68at20 = call i32 @findfa(i32 %.67)
  store i32 %.68at20, i32* %.66
  %.71 = load i32, i32* %.63
  %.72at21 = call i32 @findfa(i32 %.71)
  store i32 %.72at21, i32* %.70
  %.76 = load i32, i32* %.66
  %.77 = load i32, i32* %.70
  %.78 = icmp ne i32 %.76, %.77
  br i1 %.78, label %.74, label %.75
.74:
  %.80 = load i32, i32* %.70
  %.81 = load i32, i32* %.66
  %.82 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.81
  store i32 %.80, i32* %.82
  br label %.75 
.75:
  ret void
}
define i32 @main(){
.87:
  %.266 = alloca i32
  %.137 = alloca i32
  %.113 = alloca i32
  %.109 = alloca i32
  %.107 = alloca i32
  %.91 = alloca i32
  %.90 = alloca i32
  %.89 = alloca i32
  %.88 = alloca i32
  store i32 1, i32* %.88
  br label %.93wc28 
.93wc28:
  %.97 = load i32, i32* %.88
  %.98 = icmp ne i32 %.97, 0
  br i1 %.98, label %.94wloop.28.80, label %.95wn80
.94wloop.28.80:
  %.100 = load i32, i32* %.88
  %.101 = sub i32 %.100, 1
  store i32 %.101, i32* %.88
  store i32 4, i32* @.g.n
  store i32 10, i32* %.89
  store i32 0, i32* %.107
  store i32 0, i32* %.109
  %.111 = load i32, i32* @.g.n
  call void @init(i32 %.111)
  %.114 = load i32, i32* @.g.n
  %.115 = load i32, i32* @.g.n
  %.116 = mul i32 %.114, %.115
  %.117 = add i32 %.116, 1
  store i32 %.117, i32* %.113
  br label %.119wc37 
.95wn80:
  ret i32 0 
.119wc37:
  %.123 = load i32, i32* %.107
  %.124 = load i32, i32* %.89
  %.125 = icmp slt i32 %.123, %.124
  br i1 %.125, label %.120wloop.37.75, label %.121wn75
.120wloop.37.75:
  %.128at38 = call i32 @getint()
  store i32 %.128at38, i32* %.90
  %.130at39 = call i32 @getint()
  store i32 %.130at39, i32* %.91
  %.134 = load i32, i32* %.109
  %.135 = icmp eq i32 %.134, 0
  br i1 %.135, label %.132, label %.133
.121wn75:
  %.283 = load i32, i32* %.109
  %.284 = icmp eq i32 %.283, 0
  br i1 %.284, label %.281, label %.282
.132:
  %.138 = load i32, i32* @.g.n
  %.139 = load i32, i32* %.90
  %.140 = sub i32 %.139, 1
  %.141 = mul i32 %.138, %.140
  %.142 = load i32, i32* %.91
  %.143 = add i32 %.141, %.142
  store i32 %.143, i32* %.137
  %.145 = load i32, i32* %.137
  %.146 = load i32, i32* %.137
  %.147 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.146
  store i32 %.145, i32* %.147
  %.151 = load i32, i32* %.90
  %.152 = icmp eq i32 %.151, 1
  br i1 %.152, label %.149, label %.150
.133:
  %.277 = load i32, i32* %.107
  %.278 = add i32 %.277, 1
  store i32 %.278, i32* %.107
  br label %.119wc37 
.149:
  %.154 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 0
  store i32 0, i32* %.154
  %.156 = load i32, i32* %.137
  call void @mmerge(i32 %.156, i32 0)
  br label %.150 
.150:
  %.161 = load i32, i32* %.90
  %.162 = load i32, i32* @.g.n
  %.163 = icmp eq i32 %.161, %.162
  br i1 %.163, label %.159, label %.160
.159:
  %.165 = load i32, i32* %.113
  %.166 = load i32, i32* %.113
  %.167 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.166
  store i32 %.165, i32* %.167
  %.169 = load i32, i32* %.137
  %.170 = load i32, i32* %.113
  call void @mmerge(i32 %.169, i32 %.170)
  br label %.160 
.160:
  %.175 = load i32, i32* %.91
  %.176 = load i32, i32* @.g.n
  %.177 = icmp slt i32 %.175, %.176
  br i1 %.177, label %.178, label %.174
.173:
  %.186 = load i32, i32* %.137
  %.187 = load i32, i32* %.137
  %.188 = add i32 %.187, 1
  call void @mmerge(i32 %.186, i32 %.188)
  br label %.174 
.174:
  %.193 = load i32, i32* %.91
  %.194 = icmp sgt i32 %.193, 1
  br i1 %.194, label %.195, label %.192
.178:
  %.180 = load i32, i32* %.137
  %.181 = add i32 %.180, 1
  %.182 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.181
  %.183 = load i32, i32* %.182
  %.184 = icmp ne i32 %.183, -1
  br i1 %.184, label %.173, label %.174
.191:
  %.203 = load i32, i32* %.137
  %.204 = load i32, i32* %.137
  %.205 = sub i32 %.204, 1
  call void @mmerge(i32 %.203, i32 %.205)
  br label %.192 
.192:
  %.210 = load i32, i32* %.90
  %.211 = load i32, i32* @.g.n
  %.212 = icmp slt i32 %.210, %.211
  br i1 %.212, label %.213, label %.209
.195:
  %.197 = load i32, i32* %.137
  %.198 = sub i32 %.197, 1
  %.199 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.198
  %.200 = load i32, i32* %.199
  %.201 = icmp ne i32 %.200, -1
  br i1 %.201, label %.191, label %.192
.208:
  %.222 = load i32, i32* %.137
  %.223 = load i32, i32* %.137
  %.224 = load i32, i32* @.g.n
  %.225 = add i32 %.223, %.224
  call void @mmerge(i32 %.222, i32 %.225)
  br label %.209 
.209:
  %.230 = load i32, i32* %.90
  %.231 = icmp sgt i32 %.230, 1
  br i1 %.231, label %.232, label %.229
.213:
  %.215 = load i32, i32* %.137
  %.216 = load i32, i32* @.g.n
  %.217 = add i32 %.215, %.216
  %.218 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.217
  %.219 = load i32, i32* %.218
  %.220 = icmp ne i32 %.219, -1
  br i1 %.220, label %.208, label %.209
.228:
  %.241 = load i32, i32* %.137
  %.242 = load i32, i32* %.137
  %.243 = load i32, i32* @.g.n
  %.244 = sub i32 %.242, %.243
  call void @mmerge(i32 %.241, i32 %.244)
  br label %.229 
.229:
  %.249 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 0
  %.250 = load i32, i32* %.249
  %.251 = icmp ne i32 %.250, -1
  br i1 %.251, label %.252, label %.248
.232:
  %.234 = load i32, i32* %.137
  %.235 = load i32, i32* @.g.n
  %.236 = sub i32 %.234, %.235
  %.237 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.236
  %.238 = load i32, i32* %.237
  %.239 = icmp ne i32 %.238, -1
  br i1 %.239, label %.228, label %.229
.247:
  store i32 1, i32* %.109
  %.267 = load i32, i32* %.107
  %.268 = add i32 %.267, 1
  store i32 %.268, i32* %.266
  %.270 = load i32, i32* %.266
  call void @putint(i32 %.270)
  call void @putch(i32 10)
  br label %.248 
.248:
  br label %.133 
.252:
  %.254 = load i32, i32* %.113
  %.255 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.254
  %.256 = load i32, i32* %.255
  %.257 = icmp ne i32 %.256, -1
  br i1 %.257, label %.258, label %.248
.258:
  %.260at66 = call i32 @findfa(i32 0)
  %.261 = load i32, i32* %.113
  %.262at66 = call i32 @findfa(i32 %.261)
  %.263 = icmp eq i32 %.260at66, %.262at66
  br i1 %.263, label %.247, label %.248
.281:
  call void @putint(i32 -1)
  call void @putch(i32 10)
  br label %.282 
.282:
  br label %.93wc28 
}
@.g.array = global [110 x i32] zeroinitializer
@.g.n = global i32 zeroinitializer
define void @init(i32 %.6){
.4:
  %.8 = alloca i32
  %.5 = alloca i32
  store i32 %.6, i32* %.5
  store i32 1, i32* %.8
  br label %.11wc5 
.11wc5:
  %.15 = load i32, i32* %.8
  %.16 = load i32, i32* %.5
  %.17 = load i32, i32* %.5
  %.18 = mul i32 %.16, %.17
  %.19 = add i32 %.18, 1
  %.20 = icmp sle i32 %.15, %.19
  br i1 %.20, label %.12wloop.5.8, label %.13wn8
.12wloop.5.8:
  %.24 = load i32, i32* %.8
  %.25 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.24
  store i32 -1, i32* %.25
  %.27 = load i32, i32* %.8
  %.28 = add i32 %.27, 1
  store i32 %.28, i32* %.8
  br label %.11wc5 
.13wn8:
  ret void
}
define i32 @findfa(i32 %.35){
.33:
  %.34 = alloca i32
  store i32 %.35, i32* %.34
  %.39 = load i32, i32* %.34
  %.40 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.39
  %.41 = load i32, i32* %.40
  %.42 = load i32, i32* %.34
  %.43 = icmp eq i32 %.41, %.42
  br i1 %.43, label %.37, label %.38
.37:
  %.45 = load i32, i32* %.34
  ret i32 %.45 
.38:
  %.47 = load i32, i32* %.34
  %.48 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.47
  %.49 = load i32, i32* %.48
  %.50at15 = call i32 @findfa(i32 %.49)
  %.51 = load i32, i32* %.34
  %.52 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.51
  store i32 %.50at15, i32* %.52
  %.54 = load i32, i32* %.34
  %.55 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.54
  %.56 = load i32, i32* %.55
  ret i32 %.56 
}
define void @mmerge(i32 %.61, i32 %.64){
.59:
  %.70 = alloca i32
  %.66 = alloca i32
  %.63 = alloca i32
  %.60 = alloca i32
  store i32 %.61, i32* %.60
  store i32 %.64, i32* %.63
  %.67 = load i32, i32* %.60
  %.68at20 = call i32 @findfa(i32 %.67)
  store i32 %.68at20, i32* %.66
  %.71 = load i32, i32* %.63
  %.72at21 = call i32 @findfa(i32 %.71)
  store i32 %.72at21, i32* %.70
  %.76 = load i32, i32* %.66
  %.77 = load i32, i32* %.70
  %.78 = icmp ne i32 %.76, %.77
  br i1 %.78, label %.74, label %.75
.74:
  %.80 = load i32, i32* %.70
  %.81 = load i32, i32* %.66
  %.82 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.81
  store i32 %.80, i32* %.82
  br label %.75 
.75:
  ret void
}
define i32 @main(){
.87:
  %.266 = alloca i32
  %.137 = alloca i32
  %.113 = alloca i32
  %.109 = alloca i32
  %.107 = alloca i32
  %.91 = alloca i32
  %.90 = alloca i32
  %.89 = alloca i32
  %.88 = alloca i32
  store i32 1, i32* %.88
  br label %.93wc28 
.93wc28:
  %.97 = load i32, i32* %.88
  %.98 = icmp ne i32 %.97, 0
  br i1 %.98, label %.94wloop.28.80, label %.95wn80
.94wloop.28.80:
  %.100 = load i32, i32* %.88
  %.101 = sub i32 %.100, 1
  store i32 %.101, i32* %.88
  store i32 4, i32* @.g.n
  store i32 10, i32* %.89
  store i32 0, i32* %.107
  store i32 0, i32* %.109
  %.111 = load i32, i32* @.g.n
  call void @init(i32 %.111)
  %.114 = load i32, i32* @.g.n
  %.115 = load i32, i32* @.g.n
  %.116 = mul i32 %.114, %.115
  %.117 = add i32 %.116, 1
  store i32 %.117, i32* %.113
  br label %.119wc37 
.95wn80:
  ret i32 0 
.119wc37:
  %.123 = load i32, i32* %.107
  %.124 = load i32, i32* %.89
  %.125 = icmp slt i32 %.123, %.124
  br i1 %.125, label %.120wloop.37.75, label %.121wn75
.120wloop.37.75:
  %.128at38 = call i32 @getint()
  store i32 %.128at38, i32* %.90
  %.130at39 = call i32 @getint()
  store i32 %.130at39, i32* %.91
  %.134 = load i32, i32* %.109
  %.135 = icmp eq i32 %.134, 0
  br i1 %.135, label %.132, label %.133
.121wn75:
  %.283 = load i32, i32* %.109
  %.284 = icmp eq i32 %.283, 0
  br i1 %.284, label %.281, label %.282
.132:
  %.138 = load i32, i32* @.g.n
  %.139 = load i32, i32* %.90
  %.140 = sub i32 %.139, 1
  %.141 = mul i32 %.138, %.140
  %.142 = load i32, i32* %.91
  %.143 = add i32 %.141, %.142
  store i32 %.143, i32* %.137
  %.145 = load i32, i32* %.137
  %.146 = load i32, i32* %.137
  %.147 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.146
  store i32 %.145, i32* %.147
  %.151 = load i32, i32* %.90
  %.152 = icmp eq i32 %.151, 1
  br i1 %.152, label %.149, label %.150
.133:
  %.277 = load i32, i32* %.107
  %.278 = add i32 %.277, 1
  store i32 %.278, i32* %.107
  br label %.119wc37 
.149:
  %.154 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 0
  store i32 0, i32* %.154
  %.156 = load i32, i32* %.137
  call void @mmerge(i32 %.156, i32 0)
  br label %.150 
.150:
  %.161 = load i32, i32* %.90
  %.162 = load i32, i32* @.g.n
  %.163 = icmp eq i32 %.161, %.162
  br i1 %.163, label %.159, label %.160
.159:
  %.165 = load i32, i32* %.113
  %.166 = load i32, i32* %.113
  %.167 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.166
  store i32 %.165, i32* %.167
  %.169 = load i32, i32* %.137
  %.170 = load i32, i32* %.113
  call void @mmerge(i32 %.169, i32 %.170)
  br label %.160 
.160:
  %.175 = load i32, i32* %.91
  %.176 = load i32, i32* @.g.n
  %.177 = icmp slt i32 %.175, %.176
  br i1 %.177, label %.178, label %.174
.173:
  %.186 = load i32, i32* %.137
  %.187 = load i32, i32* %.137
  %.188 = add i32 %.187, 1
  call void @mmerge(i32 %.186, i32 %.188)
  br label %.174 
.174:
  %.193 = load i32, i32* %.91
  %.194 = icmp sgt i32 %.193, 1
  br i1 %.194, label %.195, label %.192
.178:
  %.180 = load i32, i32* %.137
  %.181 = add i32 %.180, 1
  %.182 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.181
  %.183 = load i32, i32* %.182
  %.184 = icmp ne i32 %.183, -1
  br i1 %.184, label %.173, label %.174
.191:
  %.203 = load i32, i32* %.137
  %.204 = load i32, i32* %.137
  %.205 = sub i32 %.204, 1
  call void @mmerge(i32 %.203, i32 %.205)
  br label %.192 
.192:
  %.210 = load i32, i32* %.90
  %.211 = load i32, i32* @.g.n
  %.212 = icmp slt i32 %.210, %.211
  br i1 %.212, label %.213, label %.209
.195:
  %.197 = load i32, i32* %.137
  %.198 = sub i32 %.197, 1
  %.199 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.198
  %.200 = load i32, i32* %.199
  %.201 = icmp ne i32 %.200, -1
  br i1 %.201, label %.191, label %.192
.208:
  %.222 = load i32, i32* %.137
  %.223 = load i32, i32* %.137
  %.224 = load i32, i32* @.g.n
  %.225 = add i32 %.223, %.224
  call void @mmerge(i32 %.222, i32 %.225)
  br label %.209 
.209:
  %.230 = load i32, i32* %.90
  %.231 = icmp sgt i32 %.230, 1
  br i1 %.231, label %.232, label %.229
.213:
  %.215 = load i32, i32* %.137
  %.216 = load i32, i32* @.g.n
  %.217 = add i32 %.215, %.216
  %.218 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.217
  %.219 = load i32, i32* %.218
  %.220 = icmp ne i32 %.219, -1
  br i1 %.220, label %.208, label %.209
.228:
  %.241 = load i32, i32* %.137
  %.242 = load i32, i32* %.137
  %.243 = load i32, i32* @.g.n
  %.244 = sub i32 %.242, %.243
  call void @mmerge(i32 %.241, i32 %.244)
  br label %.229 
.229:
  %.249 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 0
  %.250 = load i32, i32* %.249
  %.251 = icmp ne i32 %.250, -1
  br i1 %.251, label %.252, label %.248
.232:
  %.234 = load i32, i32* %.137
  %.235 = load i32, i32* @.g.n
  %.236 = sub i32 %.234, %.235
  %.237 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.236
  %.238 = load i32, i32* %.237
  %.239 = icmp ne i32 %.238, -1
  br i1 %.239, label %.228, label %.229
.247:
  store i32 1, i32* %.109
  %.267 = load i32, i32* %.107
  %.268 = add i32 %.267, 1
  store i32 %.268, i32* %.266
  %.270 = load i32, i32* %.266
  call void @putint(i32 %.270)
  call void @putch(i32 10)
  br label %.248 
.248:
  br label %.133 
.252:
  %.254 = load i32, i32* %.113
  %.255 = getelementptr inbounds [110 x i32], [110 x i32]* @.g.array, i32 0, i32 %.254
  %.256 = load i32, i32* %.255
  %.257 = icmp ne i32 %.256, -1
  br i1 %.257, label %.258, label %.248
.258:
  %.260at66 = call i32 @findfa(i32 0)
  %.261 = load i32, i32* %.113
  %.262at66 = call i32 @findfa(i32 %.261)
  %.263 = icmp eq i32 %.260at66, %.262at66
  br i1 %.263, label %.247, label %.248
.281:
  call void @putint(i32 -1)
  call void @putch(i32 10)
  br label %.282 
.282:
  br label %.93wc28 
