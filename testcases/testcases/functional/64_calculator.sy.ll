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
@.g.ints = global [10000 x i32] zeroinitializer
@.g.intt = global i32 zeroinitializer
@.g.chas = global [10000 x i32] zeroinitializer
@.g.chat = global i32 zeroinitializer
@.g.i = global i32 0
@.g.ii = global i32 1
@.g.c = global i32 zeroinitializer
@.g.get = global [10000 x i32] zeroinitializer
@.g.get2 = global [10000 x i32] zeroinitializer
define i32 @isdigit(i32 %.15){
.13:
  %.14 = alloca i32
  store i32 %.15, i32* %.14
  %.19 = load i32, i32* %.14
  %.21 = icmp sge i32 %.19, 48
  br i1 %.21, label %.22, label %.18
.17:
  ret i32 1 
.18:
  ret i32 0 
.22:
  %.24 = load i32, i32* %.14
  %.26 = icmp sle i32 %.24, 57
  br i1 %.26, label %.17, label %.18
}
define i32 @power(i32 %.33, i32 %.36){
.31:
  %.38 = alloca i32
  %.35 = alloca i32
  %.32 = alloca i32
  store i32 %.33, i32* %.32
  store i32 %.36, i32* %.35
  store i32 1, i32* %.38
  br label %.40wc18 
.40wc18:
  %.44 = load i32, i32* %.35
  %.45 = icmp ne i32 %.44, 0
  br i1 %.45, label %.41wloop.18.21, label %.42wn21
.41wloop.18.21:
  %.47 = load i32, i32* %.38
  %.48 = load i32, i32* %.32
  %.49 = mul i32 %.47, %.48
  store i32 %.49, i32* %.38
  %.51 = load i32, i32* %.35
  %.52 = sub i32 %.51, 1
  store i32 %.52, i32* %.35
  br label %.40wc18 
.42wn21:
  %.55 = load i32, i32* %.38
  ret i32 %.55 
}
define i32 @getstr(i32* %.60){
.58:
  %.66 = alloca i32
  %.62 = alloca i32
  %.59 = alloca i32*
  store i32* %.60, i32** %.59
  %.64at26 = call i32 @getch()
  store i32 %.64at26, i32* %.62
  store i32 0, i32* %.66
  br label %.68wc28 
.68wc28:
  %.72 = load i32, i32* %.62
  %.74 = icmp ne i32 %.72, 13
  br i1 %.74, label %.75, label %.70wn32
.69wloop.28.32:
  %.81 = load i32, i32* %.62
  %.82 = load i32, i32* %.66
  %.83 = load i32*, i32** %.59
  %.84 = getelementptr inbounds i32, i32* %.83, i32 %.82
  store i32 %.81, i32* %.84
  %.86 = load i32, i32* %.66
  %.87 = add i32 %.86, 1
  store i32 %.87, i32* %.66
  %.89at31 = call i32 @getch()
  store i32 %.89at31, i32* %.62
  br label %.68wc28 
.70wn32:
  %.92 = load i32, i32* %.66
  ret i32 %.92 
.75:
  %.77 = load i32, i32* %.62
  %.79 = icmp ne i32 %.77, 10
  br i1 %.79, label %.69wloop.28.32, label %.70wn32
}
define void @intpush(i32 %.97){
.95:
  %.96 = alloca i32
  store i32 %.97, i32* %.96
  %.99 = load i32, i32* @.g.intt
  %.100 = add i32 %.99, 1
  store i32 %.100, i32* @.g.intt
  %.102 = load i32, i32* %.96
  %.103 = load i32, i32* @.g.intt
  %.104 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.103
  store i32 %.102, i32* %.104
  ret void
}
define void @chapush(i32 %.110){
.108:
  %.109 = alloca i32
  store i32 %.110, i32* %.109
  %.112 = load i32, i32* @.g.chat
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* @.g.chat
  %.115 = load i32, i32* %.109
  %.116 = load i32, i32* @.g.chat
  %.117 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.116
  store i32 %.115, i32* %.117
  ret void
}
define i32 @intpop(){
.121:
  %.122 = load i32, i32* @.g.intt
  %.123 = sub i32 %.122, 1
  store i32 %.123, i32* @.g.intt
  %.125 = load i32, i32* @.g.intt
  %.126 = add i32 %.125, 1
  %.127 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.126
  %.128 = load i32, i32* %.127
  ret i32 %.128 
}
define i32 @chapop(){
.131:
  %.132 = load i32, i32* @.g.chat
  %.133 = sub i32 %.132, 1
  store i32 %.133, i32* @.g.chat
  %.135 = load i32, i32* @.g.chat
  %.136 = add i32 %.135, 1
  %.137 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.136
  %.138 = load i32, i32* %.137
  ret i32 %.138 
}
define void @intadd(i32 %.143){
.141:
  %.142 = alloca i32
  store i32 %.143, i32* %.142
  %.145 = load i32, i32* @.g.intt
  %.146 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.145
  %.147 = load i32, i32* %.146
  %.148 = mul i32 %.147, 10
  %.149 = load i32, i32* @.g.intt
  %.150 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.149
  store i32 %.148, i32* %.150
  %.152 = load i32, i32* @.g.intt
  %.153 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.152
  %.154 = load i32, i32* %.153
  %.155 = load i32, i32* %.142
  %.156 = add i32 %.154, %.155
  %.157 = load i32, i32* @.g.intt
  %.158 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.157
  store i32 %.156, i32* %.158
  ret void
}
define i32 @find(){
.162:
  %.163at64 = call i32 @chapop()
  store i32 %.163at64, i32* @.g.c
  %.166 = load i32, i32* @.g.ii
  %.167 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.166
  store i32 32, i32* %.167
  %.169 = load i32, i32* @.g.c
  %.170 = load i32, i32* @.g.ii
  %.171 = add i32 %.170, 1
  %.172 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.171
  store i32 %.169, i32* %.172
  %.174 = load i32, i32* @.g.ii
  %.176 = add i32 %.174, 2
  store i32 %.176, i32* @.g.ii
  %.180 = load i32, i32* @.g.chat
  %.181 = icmp eq i32 %.180, 0
  br i1 %.181, label %.178, label %.179
.178:
  ret i32 0 
.179:
  ret i32 1 
}
define i32 @main(){
.186:
  %.606 = alloca i32
  %.603 = alloca i32
  %.600 = alloca i32
  %.534 = alloca i32
  %.189 = alloca i32
  store i32 0, i32* @.g.intt
  store i32 0, i32* @.g.chat
  %.190 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 0
  %.191at76 = call i32 @getstr(i32* %.190)
  store i32 %.191at76, i32* %.189
  br label %.193wc77 
.193wc77:
  %.197 = load i32, i32* @.g.i
  %.198 = load i32, i32* %.189
  %.199 = icmp slt i32 %.197, %.198
  br i1 %.199, label %.194wloop.77.143, label %.195wn143
.194wloop.77.143:
  %.203 = load i32, i32* @.g.i
  %.204 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.203
  %.205 = load i32, i32* %.204
  %.206at79 = call i32 @isdigit(i32 %.205)
  %.207 = icmp eq i32 %.206at79, 1
  br i1 %.207, label %.201, label %.202
.195wn143:
  br label %.527wc144 
.201:
  %.209 = load i32, i32* @.g.i
  %.210 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.209
  %.211 = load i32, i32* %.210
  %.212 = load i32, i32* @.g.ii
  %.213 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.212
  store i32 %.211, i32* %.213
  %.215 = load i32, i32* @.g.ii
  %.216 = add i32 %.215, 1
  store i32 %.216, i32* @.g.ii
  br label %.218 
.202:
  %.222 = load i32, i32* @.g.i
  %.223 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.222
  %.224 = load i32, i32* %.223
  %.226 = icmp eq i32 %.224, 40
  br i1 %.226, label %.220, label %.221
.218:
  %.523 = load i32, i32* @.g.i
  %.524 = add i32 %.523, 1
  store i32 %.524, i32* @.g.i
  br label %.193wc77 
.220:
  call void @chapush(i32 40)
  br label %.221 
.221:
  %.232 = load i32, i32* @.g.i
  %.233 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.232
  %.234 = load i32, i32* %.233
  %.236 = icmp eq i32 %.234, 94
  br i1 %.236, label %.230, label %.231
.230:
  call void @chapush(i32 94)
  br label %.231 
.231:
  %.242 = load i32, i32* @.g.i
  %.243 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.242
  %.244 = load i32, i32* %.243
  %.246 = icmp eq i32 %.244, 41
  br i1 %.246, label %.240, label %.241
.240:
  %.248at90 = call i32 @chapop()
  store i32 %.248at90, i32* @.g.c
  br label %.250wc91 
.241:
  %.274 = load i32, i32* @.g.i
  %.275 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.274
  %.276 = load i32, i32* %.275
  %.278 = icmp eq i32 %.276, 43
  br i1 %.278, label %.272, label %.273
.250wc91:
  %.254 = load i32, i32* @.g.c
  %.255 = icmp ne i32 %.254, 40
  br i1 %.255, label %.251wloop.91.97, label %.252wn97
.251wloop.91.97:
  %.257 = load i32, i32* @.g.ii
  %.258 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.257
  store i32 32, i32* %.258
  %.260 = load i32, i32* @.g.c
  %.261 = load i32, i32* @.g.ii
  %.262 = add i32 %.261, 1
  %.263 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.262
  store i32 %.260, i32* %.263
  %.265 = load i32, i32* @.g.ii
  %.266 = add i32 %.265, 2
  store i32 %.266, i32* @.g.ii
  %.268at96 = call i32 @chapop()
  store i32 %.268at96, i32* @.g.c
  br label %.250wc91 
.252wn97:
  br label %.241 
.272:
  br label %.280wc101 
.273:
  %.334 = load i32, i32* @.g.i
  %.335 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.334
  %.336 = load i32, i32* %.335
  %.337 = icmp eq i32 %.336, 45
  br i1 %.337, label %.332, label %.333
.280wc101:
  %.285 = load i32, i32* @.g.chat
  %.286 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.285
  %.287 = load i32, i32* %.286
  %.288 = icmp eq i32 %.287, 43
  br i1 %.288, label %.281wloop.101.104, label %.284
.281wloop.101.104:
  %.325at103 = call i32 @find()
  %.326 = icmp eq i32 %.325at103, 0
  br i1 %.326, label %.323, label %.324
.282wn104:
  call void @chapush(i32 43)
  br label %.273 
.284:
  %.291 = load i32, i32* @.g.chat
  %.292 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.291
  %.293 = load i32, i32* %.292
  %.295 = icmp eq i32 %.293, 45
  br i1 %.295, label %.281wloop.101.104, label %.290
.290:
  %.298 = load i32, i32* @.g.chat
  %.299 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.298
  %.300 = load i32, i32* %.299
  %.302 = icmp eq i32 %.300, 42
  br i1 %.302, label %.281wloop.101.104, label %.297
.297:
  %.305 = load i32, i32* @.g.chat
  %.306 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.305
  %.307 = load i32, i32* %.306
  %.309 = icmp eq i32 %.307, 47
  br i1 %.309, label %.281wloop.101.104, label %.304
.304:
  %.312 = load i32, i32* @.g.chat
  %.313 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.312
  %.314 = load i32, i32* %.313
  %.316 = icmp eq i32 %.314, 37
  br i1 %.316, label %.281wloop.101.104, label %.311
.311:
  %.318 = load i32, i32* @.g.chat
  %.319 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.318
  %.320 = load i32, i32* %.319
  %.321 = icmp eq i32 %.320, 94
  br i1 %.321, label %.281wloop.101.104, label %.282wn104
.323:
  br label %.282wn104 
.324:
  br label %.280wc101 
.332:
  br label %.339wc109 
.333:
  %.389 = load i32, i32* @.g.i
  %.390 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.389
  %.391 = load i32, i32* %.390
  %.392 = icmp eq i32 %.391, 42
  br i1 %.392, label %.387, label %.388
.339wc109:
  %.344 = load i32, i32* @.g.chat
  %.345 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.344
  %.346 = load i32, i32* %.345
  %.347 = icmp eq i32 %.346, 43
  br i1 %.347, label %.340wloop.109.112, label %.343
.340wloop.109.112:
  %.380at111 = call i32 @find()
  %.381 = icmp eq i32 %.380at111, 0
  br i1 %.381, label %.378, label %.379
.341wn112:
  call void @chapush(i32 45)
  br label %.333 
.343:
  %.350 = load i32, i32* @.g.chat
  %.351 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.350
  %.352 = load i32, i32* %.351
  %.353 = icmp eq i32 %.352, 45
  br i1 %.353, label %.340wloop.109.112, label %.349
.349:
  %.356 = load i32, i32* @.g.chat
  %.357 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.356
  %.358 = load i32, i32* %.357
  %.359 = icmp eq i32 %.358, 42
  br i1 %.359, label %.340wloop.109.112, label %.355
.355:
  %.362 = load i32, i32* @.g.chat
  %.363 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.362
  %.364 = load i32, i32* %.363
  %.365 = icmp eq i32 %.364, 47
  br i1 %.365, label %.340wloop.109.112, label %.361
.361:
  %.368 = load i32, i32* @.g.chat
  %.369 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.368
  %.370 = load i32, i32* %.369
  %.371 = icmp eq i32 %.370, 37
  br i1 %.371, label %.340wloop.109.112, label %.367
.367:
  %.373 = load i32, i32* @.g.chat
  %.374 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.373
  %.375 = load i32, i32* %.374
  %.376 = icmp eq i32 %.375, 94
  br i1 %.376, label %.340wloop.109.112, label %.341wn112
.378:
  br label %.341wn112 
.379:
  br label %.339wc109 
.387:
  br label %.394wc117 
.388:
  %.432 = load i32, i32* @.g.i
  %.433 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.432
  %.434 = load i32, i32* %.433
  %.435 = icmp eq i32 %.434, 47
  br i1 %.435, label %.430, label %.431
.394wc117:
  %.399 = load i32, i32* @.g.chat
  %.400 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.399
  %.401 = load i32, i32* %.400
  %.402 = icmp eq i32 %.401, 42
  br i1 %.402, label %.395wloop.117.120, label %.398
.395wloop.117.120:
  %.423at119 = call i32 @find()
  %.424 = icmp eq i32 %.423at119, 0
  br i1 %.424, label %.421, label %.422
.396wn120:
  call void @chapush(i32 42)
  br label %.388 
.398:
  %.405 = load i32, i32* @.g.chat
  %.406 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.405
  %.407 = load i32, i32* %.406
  %.408 = icmp eq i32 %.407, 47
  br i1 %.408, label %.395wloop.117.120, label %.404
.404:
  %.411 = load i32, i32* @.g.chat
  %.412 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.411
  %.413 = load i32, i32* %.412
  %.414 = icmp eq i32 %.413, 37
  br i1 %.414, label %.395wloop.117.120, label %.410
.410:
  %.416 = load i32, i32* @.g.chat
  %.417 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.416
  %.418 = load i32, i32* %.417
  %.419 = icmp eq i32 %.418, 94
  br i1 %.419, label %.395wloop.117.120, label %.396wn120
.421:
  br label %.396wn120 
.422:
  br label %.394wc117 
.430:
  br label %.437wc125 
.431:
  %.475 = load i32, i32* @.g.i
  %.476 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.475
  %.477 = load i32, i32* %.476
  %.478 = icmp eq i32 %.477, 37
  br i1 %.478, label %.473, label %.474
.437wc125:
  %.442 = load i32, i32* @.g.chat
  %.443 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.442
  %.444 = load i32, i32* %.443
  %.445 = icmp eq i32 %.444, 42
  br i1 %.445, label %.438wloop.125.128, label %.441
.438wloop.125.128:
  %.466at127 = call i32 @find()
  %.467 = icmp eq i32 %.466at127, 0
  br i1 %.467, label %.464, label %.465
.439wn128:
  call void @chapush(i32 47)
  br label %.431 
.441:
  %.448 = load i32, i32* @.g.chat
  %.449 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.448
  %.450 = load i32, i32* %.449
  %.451 = icmp eq i32 %.450, 47
  br i1 %.451, label %.438wloop.125.128, label %.447
.447:
  %.454 = load i32, i32* @.g.chat
  %.455 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.454
  %.456 = load i32, i32* %.455
  %.457 = icmp eq i32 %.456, 37
  br i1 %.457, label %.438wloop.125.128, label %.453
.453:
  %.459 = load i32, i32* @.g.chat
  %.460 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.459
  %.461 = load i32, i32* %.460
  %.462 = icmp eq i32 %.461, 94
  br i1 %.462, label %.438wloop.125.128, label %.439wn128
.464:
  br label %.439wn128 
.465:
  br label %.437wc125 
.473:
  br label %.480wc133 
.474:
  %.516 = load i32, i32* @.g.ii
  %.517 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.516
  store i32 32, i32* %.517
  %.519 = load i32, i32* @.g.ii
  %.520 = add i32 %.519, 1
  store i32 %.520, i32* @.g.ii
  br label %.218 
.480wc133:
  %.485 = load i32, i32* @.g.chat
  %.486 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.485
  %.487 = load i32, i32* %.486
  %.488 = icmp eq i32 %.487, 42
  br i1 %.488, label %.481wloop.133.136, label %.484
.481wloop.133.136:
  %.509at135 = call i32 @find()
  %.510 = icmp eq i32 %.509at135, 0
  br i1 %.510, label %.507, label %.508
.482wn136:
  call void @chapush(i32 37)
  br label %.474 
.484:
  %.491 = load i32, i32* @.g.chat
  %.492 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.491
  %.493 = load i32, i32* %.492
  %.494 = icmp eq i32 %.493, 47
  br i1 %.494, label %.481wloop.133.136, label %.490
.490:
  %.497 = load i32, i32* @.g.chat
  %.498 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.497
  %.499 = load i32, i32* %.498
  %.500 = icmp eq i32 %.499, 37
  br i1 %.500, label %.481wloop.133.136, label %.496
.496:
  %.502 = load i32, i32* @.g.chat
  %.503 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.502
  %.504 = load i32, i32* %.503
  %.505 = icmp eq i32 %.504, 94
  br i1 %.505, label %.481wloop.133.136, label %.482wn136
.507:
  br label %.482wn136 
.508:
  br label %.480wc133 
.527wc144:
  %.531 = load i32, i32* @.g.chat
  %.532 = icmp sgt i32 %.531, 0
  br i1 %.532, label %.528wloop.144.150, label %.529wn150
.528wloop.144.150:
  %.535at146 = call i32 @chapop()
  store i32 %.535at146, i32* %.534
  %.537 = load i32, i32* @.g.ii
  %.538 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.537
  store i32 32, i32* %.538
  %.540 = load i32, i32* %.534
  %.541 = load i32, i32* @.g.ii
  %.542 = add i32 %.541, 1
  %.543 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.542
  store i32 %.540, i32* %.543
  %.545 = load i32, i32* @.g.ii
  %.546 = add i32 %.545, 2
  store i32 %.546, i32* @.g.ii
  br label %.527wc144 
.529wn150:
  %.550 = load i32, i32* @.g.ii
  %.551 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.550
  store i32 64, i32* %.551
  store i32 1, i32* @.g.i
  br label %.554wc153 
.554wc153:
  %.558 = load i32, i32* @.g.i
  %.559 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.558
  %.560 = load i32, i32* %.559
  %.561 = icmp ne i32 %.560, 64
  br i1 %.561, label %.555wloop.153.181, label %.556wn181
.555wloop.153.181:
  %.566 = load i32, i32* @.g.i
  %.567 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.566
  %.568 = load i32, i32* %.567
  %.569 = icmp eq i32 %.568, 43
  br i1 %.569, label %.563, label %.565
.556wn181:
  %.729 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 1
  %.730 = load i32, i32* %.729
  call void @putint(i32 %.730)
  ret i32 0 
.563:
  %.601at157 = call i32 @intpop()
  store i32 %.601at157, i32* %.600
  %.604at157 = call i32 @intpop()
  store i32 %.604at157, i32* %.603
  %.609 = load i32, i32* @.g.i
  %.610 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.609
  %.611 = load i32, i32* %.610
  %.612 = icmp eq i32 %.611, 43
  br i1 %.612, label %.607, label %.608
.564:
  %.685 = load i32, i32* @.g.i
  %.686 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.685
  %.687 = load i32, i32* %.686
  %.688 = icmp ne i32 %.687, 32
  br i1 %.688, label %.683, label %.684
.565:
  %.572 = load i32, i32* @.g.i
  %.573 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.572
  %.574 = load i32, i32* %.573
  %.575 = icmp eq i32 %.574, 45
  br i1 %.575, label %.563, label %.571
.571:
  %.578 = load i32, i32* @.g.i
  %.579 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.578
  %.580 = load i32, i32* %.579
  %.581 = icmp eq i32 %.580, 42
  br i1 %.581, label %.563, label %.577
.577:
  %.584 = load i32, i32* @.g.i
  %.585 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.584
  %.586 = load i32, i32* %.585
  %.587 = icmp eq i32 %.586, 47
  br i1 %.587, label %.563, label %.583
.583:
  %.590 = load i32, i32* @.g.i
  %.591 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.590
  %.592 = load i32, i32* %.591
  %.593 = icmp eq i32 %.592, 37
  br i1 %.593, label %.563, label %.589
.589:
  %.595 = load i32, i32* @.g.i
  %.596 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.595
  %.597 = load i32, i32* %.596
  %.598 = icmp eq i32 %.597, 94
  br i1 %.598, label %.563, label %.564
.607:
  %.614 = load i32, i32* %.600
  %.615 = load i32, i32* %.603
  %.616 = add i32 %.614, %.615
  store i32 %.616, i32* %.606
  br label %.608 
.608:
  %.621 = load i32, i32* @.g.i
  %.622 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.621
  %.623 = load i32, i32* %.622
  %.624 = icmp eq i32 %.623, 45
  br i1 %.624, label %.619, label %.620
.619:
  %.626 = load i32, i32* %.603
  %.627 = load i32, i32* %.600
  %.628 = sub i32 %.626, %.627
  store i32 %.628, i32* %.606
  br label %.620 
.620:
  %.633 = load i32, i32* @.g.i
  %.634 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.633
  %.635 = load i32, i32* %.634
  %.636 = icmp eq i32 %.635, 42
  br i1 %.636, label %.631, label %.632
.631:
  %.638 = load i32, i32* %.600
  %.639 = load i32, i32* %.603
  %.640 = mul i32 %.638, %.639
  store i32 %.640, i32* %.606
  br label %.632 
.632:
  %.645 = load i32, i32* @.g.i
  %.646 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.645
  %.647 = load i32, i32* %.646
  %.648 = icmp eq i32 %.647, 47
  br i1 %.648, label %.643, label %.644
.643:
  %.650 = load i32, i32* %.603
  %.651 = load i32, i32* %.600
  %.652 = sdiv i32 %.650, %.651
  store i32 %.652, i32* %.606
  br label %.644 
.644:
  %.657 = load i32, i32* @.g.i
  %.658 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.657
  %.659 = load i32, i32* %.658
  %.660 = icmp eq i32 %.659, 37
  br i1 %.660, label %.655, label %.656
.655:
  %.662 = load i32, i32* %.603
  %.663 = load i32, i32* %.600
  %.664 = srem i32 %.662, %.663
  store i32 %.664, i32* %.606
  br label %.656 
.656:
  %.669 = load i32, i32* @.g.i
  %.670 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.669
  %.671 = load i32, i32* %.670
  %.672 = icmp eq i32 %.671, 94
  br i1 %.672, label %.667, label %.668
.667:
  %.674 = load i32, i32* %.603
  %.675 = load i32, i32* %.600
  %.676at163 = call i32 @power(i32 %.674, i32 %.675)
  store i32 %.676at163, i32* %.606
  br label %.668 
.668:
  %.679 = load i32, i32* %.606
  call void @intpush(i32 %.679)
  br label %.681 
.681:
  %.725 = load i32, i32* @.g.i
  %.726 = add i32 %.725, 1
  store i32 %.726, i32* @.g.i
  br label %.554wc153 
.683:
  %.690 = load i32, i32* @.g.i
  %.691 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.690
  %.692 = load i32, i32* %.691
  %.693 = sub i32 %.692, 48
  call void @intpush(i32 %.693)
  store i32 1, i32* @.g.ii
  br label %.696wc172 
.684:
  br label %.681 
.696wc172:
  %.700 = load i32, i32* @.g.i
  %.701 = load i32, i32* @.g.ii
  %.702 = add i32 %.700, %.701
  %.703 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.702
  %.704 = load i32, i32* %.703
  %.705 = icmp ne i32 %.704, 32
  br i1 %.705, label %.697wloop.172.176, label %.698wn176
.697wloop.172.176:
  %.707 = load i32, i32* @.g.i
  %.708 = load i32, i32* @.g.ii
  %.709 = add i32 %.707, %.708
  %.710 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.709
  %.711 = load i32, i32* %.710
  %.712 = sub i32 %.711, 48
  call void @intadd(i32 %.712)
  %.714 = load i32, i32* @.g.ii
  %.715 = add i32 %.714, 1
  store i32 %.715, i32* @.g.ii
  br label %.696wc172 
.698wn176:
  %.718 = load i32, i32* @.g.i
  %.719 = load i32, i32* @.g.ii
  %.720 = add i32 %.718, %.719
  %.721 = sub i32 %.720, 1
  store i32 %.721, i32* @.g.i
  br label %.684 
}
@.g.ints = global [10000 x i32] zeroinitializer
@.g.intt = global i32 zeroinitializer
@.g.chas = global [10000 x i32] zeroinitializer
@.g.chat = global i32 zeroinitializer
@.g.i = global i32 0
@.g.ii = global i32 1
@.g.c = global i32 zeroinitializer
@.g.get = global [10000 x i32] zeroinitializer
@.g.get2 = global [10000 x i32] zeroinitializer
define i32 @isdigit(i32 %.15){
.13:
  %.14 = alloca i32
  store i32 %.15, i32* %.14
  %.19 = load i32, i32* %.14
  %.21 = icmp sge i32 %.19, 48
  br i1 %.21, label %.22, label %.18
.17:
  ret i32 1 
.18:
  ret i32 0 
.22:
  %.24 = load i32, i32* %.14
  %.26 = icmp sle i32 %.24, 57
  br i1 %.26, label %.17, label %.18
}
define i32 @power(i32 %.33, i32 %.36){
.31:
  %.38 = alloca i32
  %.35 = alloca i32
  %.32 = alloca i32
  store i32 %.33, i32* %.32
  store i32 %.36, i32* %.35
  store i32 1, i32* %.38
  br label %.40wc18 
.40wc18:
  %.44 = load i32, i32* %.35
  %.45 = icmp ne i32 %.44, 0
  br i1 %.45, label %.41wloop.18.21, label %.42wn21
.41wloop.18.21:
  %.47 = load i32, i32* %.38
  %.48 = load i32, i32* %.32
  %.49 = mul i32 %.47, %.48
  store i32 %.49, i32* %.38
  %.51 = load i32, i32* %.35
  %.52 = sub i32 %.51, 1
  store i32 %.52, i32* %.35
  br label %.40wc18 
.42wn21:
  %.55 = load i32, i32* %.38
  ret i32 %.55 
}
define i32 @getstr(i32* %.60){
.58:
  %.66 = alloca i32
  %.62 = alloca i32
  %.59 = alloca i32*
  store i32* %.60, i32** %.59
  %.64at26 = call i32 @getch()
  store i32 %.64at26, i32* %.62
  store i32 0, i32* %.66
  br label %.68wc28 
.68wc28:
  %.72 = load i32, i32* %.62
  %.74 = icmp ne i32 %.72, 13
  br i1 %.74, label %.75, label %.70wn32
.69wloop.28.32:
  %.81 = load i32, i32* %.62
  %.82 = load i32, i32* %.66
  %.83 = load i32*, i32** %.59
  %.84 = getelementptr inbounds i32, i32* %.83, i32 %.82
  store i32 %.81, i32* %.84
  %.86 = load i32, i32* %.66
  %.87 = add i32 %.86, 1
  store i32 %.87, i32* %.66
  %.89at31 = call i32 @getch()
  store i32 %.89at31, i32* %.62
  br label %.68wc28 
.70wn32:
  %.92 = load i32, i32* %.66
  ret i32 %.92 
.75:
  %.77 = load i32, i32* %.62
  %.79 = icmp ne i32 %.77, 10
  br i1 %.79, label %.69wloop.28.32, label %.70wn32
}
define void @intpush(i32 %.97){
.95:
  %.96 = alloca i32
  store i32 %.97, i32* %.96
  %.99 = load i32, i32* @.g.intt
  %.100 = add i32 %.99, 1
  store i32 %.100, i32* @.g.intt
  %.102 = load i32, i32* %.96
  %.103 = load i32, i32* @.g.intt
  %.104 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.103
  store i32 %.102, i32* %.104
  ret void
}
define void @chapush(i32 %.110){
.108:
  %.109 = alloca i32
  store i32 %.110, i32* %.109
  %.112 = load i32, i32* @.g.chat
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* @.g.chat
  %.115 = load i32, i32* %.109
  %.116 = load i32, i32* @.g.chat
  %.117 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.116
  store i32 %.115, i32* %.117
  ret void
}
define i32 @intpop(){
.121:
  %.122 = load i32, i32* @.g.intt
  %.123 = sub i32 %.122, 1
  store i32 %.123, i32* @.g.intt
  %.125 = load i32, i32* @.g.intt
  %.126 = add i32 %.125, 1
  %.127 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.126
  %.128 = load i32, i32* %.127
  ret i32 %.128 
}
define i32 @chapop(){
.131:
  %.132 = load i32, i32* @.g.chat
  %.133 = sub i32 %.132, 1
  store i32 %.133, i32* @.g.chat
  %.135 = load i32, i32* @.g.chat
  %.136 = add i32 %.135, 1
  %.137 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.136
  %.138 = load i32, i32* %.137
  ret i32 %.138 
}
define void @intadd(i32 %.143){
.141:
  %.142 = alloca i32
  store i32 %.143, i32* %.142
  %.145 = load i32, i32* @.g.intt
  %.146 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.145
  %.147 = load i32, i32* %.146
  %.148 = mul i32 %.147, 10
  %.149 = load i32, i32* @.g.intt
  %.150 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.149
  store i32 %.148, i32* %.150
  %.152 = load i32, i32* @.g.intt
  %.153 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.152
  %.154 = load i32, i32* %.153
  %.155 = load i32, i32* %.142
  %.156 = add i32 %.154, %.155
  %.157 = load i32, i32* @.g.intt
  %.158 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 %.157
  store i32 %.156, i32* %.158
  ret void
}
define i32 @find(){
.162:
  %.163at64 = call i32 @chapop()
  store i32 %.163at64, i32* @.g.c
  %.166 = load i32, i32* @.g.ii
  %.167 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.166
  store i32 32, i32* %.167
  %.169 = load i32, i32* @.g.c
  %.170 = load i32, i32* @.g.ii
  %.171 = add i32 %.170, 1
  %.172 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.171
  store i32 %.169, i32* %.172
  %.174 = load i32, i32* @.g.ii
  %.176 = add i32 %.174, 2
  store i32 %.176, i32* @.g.ii
  %.180 = load i32, i32* @.g.chat
  %.181 = icmp eq i32 %.180, 0
  br i1 %.181, label %.178, label %.179
.178:
  ret i32 0 
.179:
  ret i32 1 
}
define i32 @main(){
.186:
  %.606 = alloca i32
  %.603 = alloca i32
  %.600 = alloca i32
  %.534 = alloca i32
  %.189 = alloca i32
  store i32 0, i32* @.g.intt
  store i32 0, i32* @.g.chat
  %.190 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 0
  %.191at76 = call i32 @getstr(i32* %.190)
  store i32 %.191at76, i32* %.189
  br label %.193wc77 
.193wc77:
  %.197 = load i32, i32* @.g.i
  %.198 = load i32, i32* %.189
  %.199 = icmp slt i32 %.197, %.198
  br i1 %.199, label %.194wloop.77.143, label %.195wn143
.194wloop.77.143:
  %.203 = load i32, i32* @.g.i
  %.204 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.203
  %.205 = load i32, i32* %.204
  %.206at79 = call i32 @isdigit(i32 %.205)
  %.207 = icmp eq i32 %.206at79, 1
  br i1 %.207, label %.201, label %.202
.195wn143:
  br label %.527wc144 
.201:
  %.209 = load i32, i32* @.g.i
  %.210 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.209
  %.211 = load i32, i32* %.210
  %.212 = load i32, i32* @.g.ii
  %.213 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.212
  store i32 %.211, i32* %.213
  %.215 = load i32, i32* @.g.ii
  %.216 = add i32 %.215, 1
  store i32 %.216, i32* @.g.ii
  br label %.218 
.202:
  %.222 = load i32, i32* @.g.i
  %.223 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.222
  %.224 = load i32, i32* %.223
  %.226 = icmp eq i32 %.224, 40
  br i1 %.226, label %.220, label %.221
.218:
  %.523 = load i32, i32* @.g.i
  %.524 = add i32 %.523, 1
  store i32 %.524, i32* @.g.i
  br label %.193wc77 
.220:
  call void @chapush(i32 40)
  br label %.221 
.221:
  %.232 = load i32, i32* @.g.i
  %.233 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.232
  %.234 = load i32, i32* %.233
  %.236 = icmp eq i32 %.234, 94
  br i1 %.236, label %.230, label %.231
.230:
  call void @chapush(i32 94)
  br label %.231 
.231:
  %.242 = load i32, i32* @.g.i
  %.243 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.242
  %.244 = load i32, i32* %.243
  %.246 = icmp eq i32 %.244, 41
  br i1 %.246, label %.240, label %.241
.240:
  %.248at90 = call i32 @chapop()
  store i32 %.248at90, i32* @.g.c
  br label %.250wc91 
.241:
  %.274 = load i32, i32* @.g.i
  %.275 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.274
  %.276 = load i32, i32* %.275
  %.278 = icmp eq i32 %.276, 43
  br i1 %.278, label %.272, label %.273
.250wc91:
  %.254 = load i32, i32* @.g.c
  %.255 = icmp ne i32 %.254, 40
  br i1 %.255, label %.251wloop.91.97, label %.252wn97
.251wloop.91.97:
  %.257 = load i32, i32* @.g.ii
  %.258 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.257
  store i32 32, i32* %.258
  %.260 = load i32, i32* @.g.c
  %.261 = load i32, i32* @.g.ii
  %.262 = add i32 %.261, 1
  %.263 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.262
  store i32 %.260, i32* %.263
  %.265 = load i32, i32* @.g.ii
  %.266 = add i32 %.265, 2
  store i32 %.266, i32* @.g.ii
  %.268at96 = call i32 @chapop()
  store i32 %.268at96, i32* @.g.c
  br label %.250wc91 
.252wn97:
  br label %.241 
.272:
  br label %.280wc101 
.273:
  %.334 = load i32, i32* @.g.i
  %.335 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.334
  %.336 = load i32, i32* %.335
  %.337 = icmp eq i32 %.336, 45
  br i1 %.337, label %.332, label %.333
.280wc101:
  %.285 = load i32, i32* @.g.chat
  %.286 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.285
  %.287 = load i32, i32* %.286
  %.288 = icmp eq i32 %.287, 43
  br i1 %.288, label %.281wloop.101.104, label %.284
.281wloop.101.104:
  %.325at103 = call i32 @find()
  %.326 = icmp eq i32 %.325at103, 0
  br i1 %.326, label %.323, label %.324
.282wn104:
  call void @chapush(i32 43)
  br label %.273 
.284:
  %.291 = load i32, i32* @.g.chat
  %.292 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.291
  %.293 = load i32, i32* %.292
  %.295 = icmp eq i32 %.293, 45
  br i1 %.295, label %.281wloop.101.104, label %.290
.290:
  %.298 = load i32, i32* @.g.chat
  %.299 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.298
  %.300 = load i32, i32* %.299
  %.302 = icmp eq i32 %.300, 42
  br i1 %.302, label %.281wloop.101.104, label %.297
.297:
  %.305 = load i32, i32* @.g.chat
  %.306 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.305
  %.307 = load i32, i32* %.306
  %.309 = icmp eq i32 %.307, 47
  br i1 %.309, label %.281wloop.101.104, label %.304
.304:
  %.312 = load i32, i32* @.g.chat
  %.313 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.312
  %.314 = load i32, i32* %.313
  %.316 = icmp eq i32 %.314, 37
  br i1 %.316, label %.281wloop.101.104, label %.311
.311:
  %.318 = load i32, i32* @.g.chat
  %.319 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.318
  %.320 = load i32, i32* %.319
  %.321 = icmp eq i32 %.320, 94
  br i1 %.321, label %.281wloop.101.104, label %.282wn104
.323:
  br label %.282wn104 
.324:
  br label %.280wc101 
.332:
  br label %.339wc109 
.333:
  %.389 = load i32, i32* @.g.i
  %.390 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.389
  %.391 = load i32, i32* %.390
  %.392 = icmp eq i32 %.391, 42
  br i1 %.392, label %.387, label %.388
.339wc109:
  %.344 = load i32, i32* @.g.chat
  %.345 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.344
  %.346 = load i32, i32* %.345
  %.347 = icmp eq i32 %.346, 43
  br i1 %.347, label %.340wloop.109.112, label %.343
.340wloop.109.112:
  %.380at111 = call i32 @find()
  %.381 = icmp eq i32 %.380at111, 0
  br i1 %.381, label %.378, label %.379
.341wn112:
  call void @chapush(i32 45)
  br label %.333 
.343:
  %.350 = load i32, i32* @.g.chat
  %.351 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.350
  %.352 = load i32, i32* %.351
  %.353 = icmp eq i32 %.352, 45
  br i1 %.353, label %.340wloop.109.112, label %.349
.349:
  %.356 = load i32, i32* @.g.chat
  %.357 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.356
  %.358 = load i32, i32* %.357
  %.359 = icmp eq i32 %.358, 42
  br i1 %.359, label %.340wloop.109.112, label %.355
.355:
  %.362 = load i32, i32* @.g.chat
  %.363 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.362
  %.364 = load i32, i32* %.363
  %.365 = icmp eq i32 %.364, 47
  br i1 %.365, label %.340wloop.109.112, label %.361
.361:
  %.368 = load i32, i32* @.g.chat
  %.369 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.368
  %.370 = load i32, i32* %.369
  %.371 = icmp eq i32 %.370, 37
  br i1 %.371, label %.340wloop.109.112, label %.367
.367:
  %.373 = load i32, i32* @.g.chat
  %.374 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.373
  %.375 = load i32, i32* %.374
  %.376 = icmp eq i32 %.375, 94
  br i1 %.376, label %.340wloop.109.112, label %.341wn112
.378:
  br label %.341wn112 
.379:
  br label %.339wc109 
.387:
  br label %.394wc117 
.388:
  %.432 = load i32, i32* @.g.i
  %.433 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.432
  %.434 = load i32, i32* %.433
  %.435 = icmp eq i32 %.434, 47
  br i1 %.435, label %.430, label %.431
.394wc117:
  %.399 = load i32, i32* @.g.chat
  %.400 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.399
  %.401 = load i32, i32* %.400
  %.402 = icmp eq i32 %.401, 42
  br i1 %.402, label %.395wloop.117.120, label %.398
.395wloop.117.120:
  %.423at119 = call i32 @find()
  %.424 = icmp eq i32 %.423at119, 0
  br i1 %.424, label %.421, label %.422
.396wn120:
  call void @chapush(i32 42)
  br label %.388 
.398:
  %.405 = load i32, i32* @.g.chat
  %.406 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.405
  %.407 = load i32, i32* %.406
  %.408 = icmp eq i32 %.407, 47
  br i1 %.408, label %.395wloop.117.120, label %.404
.404:
  %.411 = load i32, i32* @.g.chat
  %.412 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.411
  %.413 = load i32, i32* %.412
  %.414 = icmp eq i32 %.413, 37
  br i1 %.414, label %.395wloop.117.120, label %.410
.410:
  %.416 = load i32, i32* @.g.chat
  %.417 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.416
  %.418 = load i32, i32* %.417
  %.419 = icmp eq i32 %.418, 94
  br i1 %.419, label %.395wloop.117.120, label %.396wn120
.421:
  br label %.396wn120 
.422:
  br label %.394wc117 
.430:
  br label %.437wc125 
.431:
  %.475 = load i32, i32* @.g.i
  %.476 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get, i32 0, i32 %.475
  %.477 = load i32, i32* %.476
  %.478 = icmp eq i32 %.477, 37
  br i1 %.478, label %.473, label %.474
.437wc125:
  %.442 = load i32, i32* @.g.chat
  %.443 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.442
  %.444 = load i32, i32* %.443
  %.445 = icmp eq i32 %.444, 42
  br i1 %.445, label %.438wloop.125.128, label %.441
.438wloop.125.128:
  %.466at127 = call i32 @find()
  %.467 = icmp eq i32 %.466at127, 0
  br i1 %.467, label %.464, label %.465
.439wn128:
  call void @chapush(i32 47)
  br label %.431 
.441:
  %.448 = load i32, i32* @.g.chat
  %.449 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.448
  %.450 = load i32, i32* %.449
  %.451 = icmp eq i32 %.450, 47
  br i1 %.451, label %.438wloop.125.128, label %.447
.447:
  %.454 = load i32, i32* @.g.chat
  %.455 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.454
  %.456 = load i32, i32* %.455
  %.457 = icmp eq i32 %.456, 37
  br i1 %.457, label %.438wloop.125.128, label %.453
.453:
  %.459 = load i32, i32* @.g.chat
  %.460 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.459
  %.461 = load i32, i32* %.460
  %.462 = icmp eq i32 %.461, 94
  br i1 %.462, label %.438wloop.125.128, label %.439wn128
.464:
  br label %.439wn128 
.465:
  br label %.437wc125 
.473:
  br label %.480wc133 
.474:
  %.516 = load i32, i32* @.g.ii
  %.517 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.516
  store i32 32, i32* %.517
  %.519 = load i32, i32* @.g.ii
  %.520 = add i32 %.519, 1
  store i32 %.520, i32* @.g.ii
  br label %.218 
.480wc133:
  %.485 = load i32, i32* @.g.chat
  %.486 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.485
  %.487 = load i32, i32* %.486
  %.488 = icmp eq i32 %.487, 42
  br i1 %.488, label %.481wloop.133.136, label %.484
.481wloop.133.136:
  %.509at135 = call i32 @find()
  %.510 = icmp eq i32 %.509at135, 0
  br i1 %.510, label %.507, label %.508
.482wn136:
  call void @chapush(i32 37)
  br label %.474 
.484:
  %.491 = load i32, i32* @.g.chat
  %.492 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.491
  %.493 = load i32, i32* %.492
  %.494 = icmp eq i32 %.493, 47
  br i1 %.494, label %.481wloop.133.136, label %.490
.490:
  %.497 = load i32, i32* @.g.chat
  %.498 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.497
  %.499 = load i32, i32* %.498
  %.500 = icmp eq i32 %.499, 37
  br i1 %.500, label %.481wloop.133.136, label %.496
.496:
  %.502 = load i32, i32* @.g.chat
  %.503 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.chas, i32 0, i32 %.502
  %.504 = load i32, i32* %.503
  %.505 = icmp eq i32 %.504, 94
  br i1 %.505, label %.481wloop.133.136, label %.482wn136
.507:
  br label %.482wn136 
.508:
  br label %.480wc133 
.527wc144:
  %.531 = load i32, i32* @.g.chat
  %.532 = icmp sgt i32 %.531, 0
  br i1 %.532, label %.528wloop.144.150, label %.529wn150
.528wloop.144.150:
  %.535at146 = call i32 @chapop()
  store i32 %.535at146, i32* %.534
  %.537 = load i32, i32* @.g.ii
  %.538 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.537
  store i32 32, i32* %.538
  %.540 = load i32, i32* %.534
  %.541 = load i32, i32* @.g.ii
  %.542 = add i32 %.541, 1
  %.543 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.542
  store i32 %.540, i32* %.543
  %.545 = load i32, i32* @.g.ii
  %.546 = add i32 %.545, 2
  store i32 %.546, i32* @.g.ii
  br label %.527wc144 
.529wn150:
  %.550 = load i32, i32* @.g.ii
  %.551 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.550
  store i32 64, i32* %.551
  store i32 1, i32* @.g.i
  br label %.554wc153 
.554wc153:
  %.558 = load i32, i32* @.g.i
  %.559 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.558
  %.560 = load i32, i32* %.559
  %.561 = icmp ne i32 %.560, 64
  br i1 %.561, label %.555wloop.153.181, label %.556wn181
.555wloop.153.181:
  %.566 = load i32, i32* @.g.i
  %.567 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.566
  %.568 = load i32, i32* %.567
  %.569 = icmp eq i32 %.568, 43
  br i1 %.569, label %.563, label %.565
.556wn181:
  %.729 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.ints, i32 0, i32 1
  %.730 = load i32, i32* %.729
  call void @putint(i32 %.730)
  ret i32 0 
.563:
  %.601at157 = call i32 @intpop()
  store i32 %.601at157, i32* %.600
  %.604at157 = call i32 @intpop()
  store i32 %.604at157, i32* %.603
  %.609 = load i32, i32* @.g.i
  %.610 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.609
  %.611 = load i32, i32* %.610
  %.612 = icmp eq i32 %.611, 43
  br i1 %.612, label %.607, label %.608
.564:
  %.685 = load i32, i32* @.g.i
  %.686 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.685
  %.687 = load i32, i32* %.686
  %.688 = icmp ne i32 %.687, 32
  br i1 %.688, label %.683, label %.684
.565:
  %.572 = load i32, i32* @.g.i
  %.573 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.572
  %.574 = load i32, i32* %.573
  %.575 = icmp eq i32 %.574, 45
  br i1 %.575, label %.563, label %.571
.571:
  %.578 = load i32, i32* @.g.i
  %.579 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.578
  %.580 = load i32, i32* %.579
  %.581 = icmp eq i32 %.580, 42
  br i1 %.581, label %.563, label %.577
.577:
  %.584 = load i32, i32* @.g.i
  %.585 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.584
  %.586 = load i32, i32* %.585
  %.587 = icmp eq i32 %.586, 47
  br i1 %.587, label %.563, label %.583
.583:
  %.590 = load i32, i32* @.g.i
  %.591 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.590
  %.592 = load i32, i32* %.591
  %.593 = icmp eq i32 %.592, 37
  br i1 %.593, label %.563, label %.589
.589:
  %.595 = load i32, i32* @.g.i
  %.596 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.595
  %.597 = load i32, i32* %.596
  %.598 = icmp eq i32 %.597, 94
  br i1 %.598, label %.563, label %.564
.607:
  %.614 = load i32, i32* %.600
  %.615 = load i32, i32* %.603
  %.616 = add i32 %.614, %.615
  store i32 %.616, i32* %.606
  br label %.608 
.608:
  %.621 = load i32, i32* @.g.i
  %.622 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.621
  %.623 = load i32, i32* %.622
  %.624 = icmp eq i32 %.623, 45
  br i1 %.624, label %.619, label %.620
.619:
  %.626 = load i32, i32* %.603
  %.627 = load i32, i32* %.600
  %.628 = sub i32 %.626, %.627
  store i32 %.628, i32* %.606
  br label %.620 
.620:
  %.633 = load i32, i32* @.g.i
  %.634 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.633
  %.635 = load i32, i32* %.634
  %.636 = icmp eq i32 %.635, 42
  br i1 %.636, label %.631, label %.632
.631:
  %.638 = load i32, i32* %.600
  %.639 = load i32, i32* %.603
  %.640 = mul i32 %.638, %.639
  store i32 %.640, i32* %.606
  br label %.632 
.632:
  %.645 = load i32, i32* @.g.i
  %.646 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.645
  %.647 = load i32, i32* %.646
  %.648 = icmp eq i32 %.647, 47
  br i1 %.648, label %.643, label %.644
.643:
  %.650 = load i32, i32* %.603
  %.651 = load i32, i32* %.600
  %.652 = sdiv i32 %.650, %.651
  store i32 %.652, i32* %.606
  br label %.644 
.644:
  %.657 = load i32, i32* @.g.i
  %.658 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.657
  %.659 = load i32, i32* %.658
  %.660 = icmp eq i32 %.659, 37
  br i1 %.660, label %.655, label %.656
.655:
  %.662 = load i32, i32* %.603
  %.663 = load i32, i32* %.600
  %.664 = srem i32 %.662, %.663
  store i32 %.664, i32* %.606
  br label %.656 
.656:
  %.669 = load i32, i32* @.g.i
  %.670 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.669
  %.671 = load i32, i32* %.670
  %.672 = icmp eq i32 %.671, 94
  br i1 %.672, label %.667, label %.668
.667:
  %.674 = load i32, i32* %.603
  %.675 = load i32, i32* %.600
  %.676at163 = call i32 @power(i32 %.674, i32 %.675)
  store i32 %.676at163, i32* %.606
  br label %.668 
.668:
  %.679 = load i32, i32* %.606
  call void @intpush(i32 %.679)
  br label %.681 
.681:
  %.725 = load i32, i32* @.g.i
  %.726 = add i32 %.725, 1
  store i32 %.726, i32* @.g.i
  br label %.554wc153 
.683:
  %.690 = load i32, i32* @.g.i
  %.691 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.690
  %.692 = load i32, i32* %.691
  %.693 = sub i32 %.692, 48
  call void @intpush(i32 %.693)
  store i32 1, i32* @.g.ii
  br label %.696wc172 
.684:
  br label %.681 
.696wc172:
  %.700 = load i32, i32* @.g.i
  %.701 = load i32, i32* @.g.ii
  %.702 = add i32 %.700, %.701
  %.703 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.get2, i32 0, i32 %.702
  %.704 = load i32, i32* %.703
  %.705 = icmp ne i32 %.704, 32
  br i1 %.705, label %.697wloop.172.176, label %.698wn176
.697wloop.172.176:
  %.707 = load i32, i32* @.g.i
  %.708 = load i32, i32* @.g.ii
  %.70