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
@.g.dp = global [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]] zeroinitializer
@.g.list = global [200 x i32] zeroinitializer
@.g.cns = global [20 x i32] zeroinitializer
define i32 @equal(i32 %.9, i32 %.12){
.7:
  %.11 = alloca i32
  %.8 = alloca i32
  store i32 %.9, i32* %.8
  store i32 %.12, i32* %.11
  %.16 = load i32, i32* %.8
  %.17 = load i32, i32* %.11
  %.18 = icmp eq i32 %.16, %.17
  br i1 %.18, label %.14, label %.15
.14:
  ret i32 1 
.15:
  ret i32 0 
}
define i32 @dfs(i32 %.27, i32 %.30, i32 %.33, i32 %.36, i32 %.39, i32 %.42){
.25:
  %.80 = alloca i32
  %.41 = alloca i32
  %.38 = alloca i32
  %.35 = alloca i32
  %.32 = alloca i32
  %.29 = alloca i32
  %.26 = alloca i32
  store i32 %.27, i32* %.26
  store i32 %.30, i32* %.29
  store i32 %.33, i32* %.32
  store i32 %.36, i32* %.35
  store i32 %.39, i32* %.38
  store i32 %.42, i32* %.41
  %.46 = load i32, i32* %.26
  %.47 = load i32, i32* %.29
  %.48 = load i32, i32* %.32
  %.49 = load i32, i32* %.35
  %.50 = load i32, i32* %.38
  %.51 = load i32, i32* %.41
  %.52 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.46, i32 %.47, i32 %.48, i32 %.49, i32 %.50, i32 %.51
  %.53 = load i32, i32* %.52
  %.55 = icmp ne i32 %.53, -1
  br i1 %.55, label %.44, label %.45
.44:
  %.57 = load i32, i32* %.26
  %.58 = load i32, i32* %.29
  %.59 = load i32, i32* %.32
  %.60 = load i32, i32* %.35
  %.61 = load i32, i32* %.38
  %.62 = load i32, i32* %.41
  %.63 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.57, i32 %.58, i32 %.59, i32 %.60, i32 %.61, i32 %.62
  %.64 = load i32, i32* %.63
  ret i32 %.64 
.45:
  %.68 = load i32, i32* %.26
  %.69 = load i32, i32* %.29
  %.70 = add i32 %.68, %.69
  %.71 = load i32, i32* %.32
  %.72 = add i32 %.70, %.71
  %.73 = load i32, i32* %.35
  %.74 = add i32 %.72, %.73
  %.75 = load i32, i32* %.38
  %.76 = add i32 %.74, %.75
  %.77 = icmp eq i32 %.76, 0
  br i1 %.77, label %.66, label %.67
.66:
  ret i32 1 
.67:
  store i32 0, i32* %.80
  %.84 = load i32, i32* %.26
  %.85 = icmp ne i32 %.84, 0
  br i1 %.85, label %.82, label %.83
.82:
  %.87 = load i32, i32* %.80
  %.88 = load i32, i32* %.26
  %.89 = load i32, i32* %.41
  %.91at18 = call i32 @equal(i32 %.89, i32 2)
  %.92 = sub i32 %.88, %.91at18
  %.93 = load i32, i32* %.26
  %.94 = sub i32 %.93, 1
  %.95 = load i32, i32* %.29
  %.96 = load i32, i32* %.32
  %.97 = load i32, i32* %.35
  %.98 = load i32, i32* %.38
  %.99at18 = call i32 @dfs(i32 %.94, i32 %.95, i32 %.96, i32 %.97, i32 %.98, i32 1)
  %.100 = mul i32 %.92, %.99at18
  %.101 = add i32 %.87, %.100
  %.102 = srem i32 %.101, 1000000007
  store i32 %.102, i32* %.80
  br label %.83 
.83:
  %.107 = load i32, i32* %.29
  %.108 = icmp ne i32 %.107, 0
  br i1 %.108, label %.105, label %.106
.105:
  %.110 = load i32, i32* %.80
  %.111 = load i32, i32* %.29
  %.112 = load i32, i32* %.41
  %.114at19 = call i32 @equal(i32 %.112, i32 3)
  %.115 = sub i32 %.111, %.114at19
  %.116 = load i32, i32* %.26
  %.117 = add i32 %.116, 1
  %.118 = load i32, i32* %.29
  %.119 = sub i32 %.118, 1
  %.120 = load i32, i32* %.32
  %.121 = load i32, i32* %.35
  %.122 = load i32, i32* %.38
  %.123at19 = call i32 @dfs(i32 %.117, i32 %.119, i32 %.120, i32 %.121, i32 %.122, i32 2)
  %.124 = mul i32 %.115, %.123at19
  %.125 = add i32 %.110, %.124
  %.126 = srem i32 %.125, 1000000007
  store i32 %.126, i32* %.80
  br label %.106 
.106:
  %.131 = load i32, i32* %.32
  %.132 = icmp ne i32 %.131, 0
  br i1 %.132, label %.129, label %.130
.129:
  %.134 = load i32, i32* %.80
  %.135 = load i32, i32* %.32
  %.136 = load i32, i32* %.41
  %.138at20 = call i32 @equal(i32 %.136, i32 4)
  %.139 = sub i32 %.135, %.138at20
  %.140 = load i32, i32* %.26
  %.141 = load i32, i32* %.29
  %.142 = add i32 %.141, 1
  %.143 = load i32, i32* %.32
  %.144 = sub i32 %.143, 1
  %.145 = load i32, i32* %.35
  %.146 = load i32, i32* %.38
  %.147at20 = call i32 @dfs(i32 %.140, i32 %.142, i32 %.144, i32 %.145, i32 %.146, i32 3)
  %.148 = mul i32 %.139, %.147at20
  %.149 = add i32 %.134, %.148
  %.150 = srem i32 %.149, 1000000007
  store i32 %.150, i32* %.80
  br label %.130 
.130:
  %.155 = load i32, i32* %.35
  %.156 = icmp ne i32 %.155, 0
  br i1 %.156, label %.153, label %.154
.153:
  %.158 = load i32, i32* %.80
  %.159 = load i32, i32* %.35
  %.160 = load i32, i32* %.41
  %.162at21 = call i32 @equal(i32 %.160, i32 5)
  %.163 = sub i32 %.159, %.162at21
  %.164 = load i32, i32* %.26
  %.165 = load i32, i32* %.29
  %.166 = load i32, i32* %.32
  %.167 = add i32 %.166, 1
  %.168 = load i32, i32* %.35
  %.169 = sub i32 %.168, 1
  %.170 = load i32, i32* %.38
  %.171at21 = call i32 @dfs(i32 %.164, i32 %.165, i32 %.167, i32 %.169, i32 %.170, i32 4)
  %.172 = mul i32 %.163, %.171at21
  %.173 = add i32 %.158, %.172
  %.174 = srem i32 %.173, 1000000007
  store i32 %.174, i32* %.80
  br label %.154 
.154:
  %.179 = load i32, i32* %.38
  %.180 = icmp ne i32 %.179, 0
  br i1 %.180, label %.177, label %.178
.177:
  %.182 = load i32, i32* %.80
  %.183 = load i32, i32* %.38
  %.184 = load i32, i32* %.26
  %.185 = load i32, i32* %.29
  %.186 = load i32, i32* %.32
  %.187 = load i32, i32* %.35
  %.188 = add i32 %.187, 1
  %.189 = load i32, i32* %.38
  %.190 = sub i32 %.189, 1
  %.191at22 = call i32 @dfs(i32 %.184, i32 %.185, i32 %.186, i32 %.188, i32 %.190, i32 5)
  %.192 = mul i32 %.183, %.191at22
  %.193 = add i32 %.182, %.192
  %.194 = srem i32 %.193, 1000000007
  store i32 %.194, i32* %.80
  br label %.178 
.178:
  %.197 = load i32, i32* %.80
  %.198 = srem i32 %.197, 1000000007
  %.199 = load i32, i32* %.26
  %.200 = load i32, i32* %.29
  %.201 = load i32, i32* %.32
  %.202 = load i32, i32* %.35
  %.203 = load i32, i32* %.38
  %.204 = load i32, i32* %.41
  %.205 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.199, i32 %.200, i32 %.201, i32 %.202, i32 %.203, i32 %.204
  store i32 %.198, i32* %.205
  %.207 = load i32, i32* %.26
  %.208 = load i32, i32* %.29
  %.209 = load i32, i32* %.32
  %.210 = load i32, i32* %.35
  %.211 = load i32, i32* %.38
  %.212 = load i32, i32* %.41
  %.213 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.207, i32 %.208, i32 %.209, i32 %.210, i32 %.211, i32 %.212
  %.214 = load i32, i32* %.213
  ret i32 %.214 
}
define i32 @main(){
.219:
  %.338 = alloca i32
  %.269 = alloca i32
  %.260 = alloca i32
  %.251 = alloca i32
  %.242 = alloca i32
  %.233 = alloca i32
  %.224 = alloca i32
  %.220 = alloca i32
  %.222at30 = call i32 @getint()
  store i32 %.222at30, i32* %.220
  store i32 0, i32* %.224
  br label %.226wc32 
.226wc32:
  %.230 = load i32, i32* %.224
  %.231 = icmp slt i32 %.230, 18
  br i1 %.231, label %.227wloop.32.55, label %.228wn55
.227wloop.32.55:
  store i32 0, i32* %.233
  br label %.235wc34 
.228wn55:
  store i32 0, i32* %.224
  br label %.311wc58 
.235wc34:
  %.239 = load i32, i32* %.233
  %.240 = icmp slt i32 %.239, 18
  br i1 %.240, label %.236wloop.34.53, label %.237wn53
.236wloop.34.53:
  store i32 0, i32* %.242
  br label %.244wc36 
.237wn53:
  %.306 = load i32, i32* %.224
  %.307 = add i32 %.306, 1
  store i32 %.307, i32* %.224
  br label %.226wc32 
.244wc36:
  %.248 = load i32, i32* %.242
  %.249 = icmp slt i32 %.248, 18
  br i1 %.249, label %.245wloop.36.51, label %.246wn51
.245wloop.36.51:
  store i32 0, i32* %.251
  br label %.253wc38 
.246wn51:
  %.302 = load i32, i32* %.233
  %.303 = add i32 %.302, 1
  store i32 %.303, i32* %.233
  br label %.235wc34 
.253wc38:
  %.257 = load i32, i32* %.251
  %.258 = icmp slt i32 %.257, 18
  br i1 %.258, label %.254wloop.38.49, label %.255wn49
.254wloop.38.49:
  store i32 0, i32* %.260
  br label %.262wc40 
.255wn49:
  %.298 = load i32, i32* %.242
  %.299 = add i32 %.298, 1
  store i32 %.299, i32* %.242
  br label %.244wc36 
.262wc40:
  %.266 = load i32, i32* %.260
  %.267 = icmp slt i32 %.266, 18
  br i1 %.267, label %.263wloop.40.47, label %.264wn47
.263wloop.40.47:
  store i32 0, i32* %.269
  br label %.271wc42 
.264wn47:
  %.294 = load i32, i32* %.251
  %.295 = add i32 %.294, 1
  store i32 %.295, i32* %.251
  br label %.253wc38 
.271wc42:
  %.275 = load i32, i32* %.269
  %.276 = icmp slt i32 %.275, 7
  br i1 %.276, label %.272wloop.42.45, label %.273wn45
.272wloop.42.45:
  %.278 = load i32, i32* %.224
  %.279 = load i32, i32* %.233
  %.280 = load i32, i32* %.242
  %.281 = load i32, i32* %.251
  %.282 = load i32, i32* %.260
  %.283 = load i32, i32* %.269
  %.284 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.278, i32 %.279, i32 %.280, i32 %.281, i32 %.282, i32 %.283
  store i32 -1, i32* %.284
  %.286 = load i32, i32* %.269
  %.287 = add i32 %.286, 1
  store i32 %.287, i32* %.269
  br label %.271wc42 
.273wn45:
  %.290 = load i32, i32* %.260
  %.291 = add i32 %.290, 1
  store i32 %.291, i32* %.260
  br label %.262wc40 
.311wc58:
  %.315 = load i32, i32* %.224
  %.316 = load i32, i32* %.220
  %.317 = icmp slt i32 %.315, %.316
  br i1 %.317, label %.312wloop.58.62, label %.313wn62
.312wloop.58.62:
  %.319at59 = call i32 @getint()
  %.320 = load i32, i32* %.224
  %.321 = getelementptr inbounds [200 x i32], [200 x i32]* @.g.list, i32 0, i32 %.320
  store i32 %.319at59, i32* %.321
  %.323 = load i32, i32* %.224
  %.324 = getelementptr inbounds [200 x i32], [200 x i32]* @.g.list, i32 0, i32 %.323
  %.325 = load i32, i32* %.324
  %.326 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 %.325
  %.327 = load i32, i32* %.326
  %.328 = add i32 %.327, 1
  %.329 = load i32, i32* %.224
  %.330 = getelementptr inbounds [200 x i32], [200 x i32]* @.g.list, i32 0, i32 %.329
  %.331 = load i32, i32* %.330
  %.332 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 %.331
  store i32 %.328, i32* %.332
  %.334 = load i32, i32* %.224
  %.335 = add i32 %.334, 1
  store i32 %.335, i32* %.224
  br label %.311wc58 
.313wn62:
  %.339 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 1
  %.340 = load i32, i32* %.339
  %.341 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 2
  %.342 = load i32, i32* %.341
  %.343 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 3
  %.344 = load i32, i32* %.343
  %.345 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 4
  %.346 = load i32, i32* %.345
  %.347 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 5
  %.348 = load i32, i32* %.347
  %.349at64 = call i32 @dfs(i32 %.340, i32 %.342, i32 %.344, i32 %.346, i32 %.348, i32 0)
  store i32 %.349at64, i32* %.338
  %.351 = load i32, i32* %.338
  call void @putint(i32 %.351)
  %.354 = load i32, i32* %.338
  ret i32 %.354 
}
@.g.dp = global [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]] zeroinitializer
@.g.list = global [200 x i32] zeroinitializer
@.g.cns = global [20 x i32] zeroinitializer
define i32 @equal(i32 %.9, i32 %.12){
.7:
  %.11 = alloca i32
  %.8 = alloca i32
  store i32 %.9, i32* %.8
  store i32 %.12, i32* %.11
  %.16 = load i32, i32* %.8
  %.17 = load i32, i32* %.11
  %.18 = icmp eq i32 %.16, %.17
  br i1 %.18, label %.14, label %.15
.14:
  ret i32 1 
.15:
  ret i32 0 
}
define i32 @dfs(i32 %.27, i32 %.30, i32 %.33, i32 %.36, i32 %.39, i32 %.42){
.25:
  %.80 = alloca i32
  %.41 = alloca i32
  %.38 = alloca i32
  %.35 = alloca i32
  %.32 = alloca i32
  %.29 = alloca i32
  %.26 = alloca i32
  store i32 %.27, i32* %.26
  store i32 %.30, i32* %.29
  store i32 %.33, i32* %.32
  store i32 %.36, i32* %.35
  store i32 %.39, i32* %.38
  store i32 %.42, i32* %.41
  %.46 = load i32, i32* %.26
  %.47 = load i32, i32* %.29
  %.48 = load i32, i32* %.32
  %.49 = load i32, i32* %.35
  %.50 = load i32, i32* %.38
  %.51 = load i32, i32* %.41
  %.52 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.46, i32 %.47, i32 %.48, i32 %.49, i32 %.50, i32 %.51
  %.53 = load i32, i32* %.52
  %.55 = icmp ne i32 %.53, -1
  br i1 %.55, label %.44, label %.45
.44:
  %.57 = load i32, i32* %.26
  %.58 = load i32, i32* %.29
  %.59 = load i32, i32* %.32
  %.60 = load i32, i32* %.35
  %.61 = load i32, i32* %.38
  %.62 = load i32, i32* %.41
  %.63 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.57, i32 %.58, i32 %.59, i32 %.60, i32 %.61, i32 %.62
  %.64 = load i32, i32* %.63
  ret i32 %.64 
.45:
  %.68 = load i32, i32* %.26
  %.69 = load i32, i32* %.29
  %.70 = add i32 %.68, %.69
  %.71 = load i32, i32* %.32
  %.72 = add i32 %.70, %.71
  %.73 = load i32, i32* %.35
  %.74 = add i32 %.72, %.73
  %.75 = load i32, i32* %.38
  %.76 = add i32 %.74, %.75
  %.77 = icmp eq i32 %.76, 0
  br i1 %.77, label %.66, label %.67
.66:
  ret i32 1 
.67:
  store i32 0, i32* %.80
  %.84 = load i32, i32* %.26
  %.85 = icmp ne i32 %.84, 0
  br i1 %.85, label %.82, label %.83
.82:
  %.87 = load i32, i32* %.80
  %.88 = load i32, i32* %.26
  %.89 = load i32, i32* %.41
  %.91at18 = call i32 @equal(i32 %.89, i32 2)
  %.92 = sub i32 %.88, %.91at18
  %.93 = load i32, i32* %.26
  %.94 = sub i32 %.93, 1
  %.95 = load i32, i32* %.29
  %.96 = load i32, i32* %.32
  %.97 = load i32, i32* %.35
  %.98 = load i32, i32* %.38
  %.99at18 = call i32 @dfs(i32 %.94, i32 %.95, i32 %.96, i32 %.97, i32 %.98, i32 1)
  %.100 = mul i32 %.92, %.99at18
  %.101 = add i32 %.87, %.100
  %.102 = srem i32 %.101, 1000000007
  store i32 %.102, i32* %.80
  br label %.83 
.83:
  %.107 = load i32, i32* %.29
  %.108 = icmp ne i32 %.107, 0
  br i1 %.108, label %.105, label %.106
.105:
  %.110 = load i32, i32* %.80
  %.111 = load i32, i32* %.29
  %.112 = load i32, i32* %.41
  %.114at19 = call i32 @equal(i32 %.112, i32 3)
  %.115 = sub i32 %.111, %.114at19
  %.116 = load i32, i32* %.26
  %.117 = add i32 %.116, 1
  %.118 = load i32, i32* %.29
  %.119 = sub i32 %.118, 1
  %.120 = load i32, i32* %.32
  %.121 = load i32, i32* %.35
  %.122 = load i32, i32* %.38
  %.123at19 = call i32 @dfs(i32 %.117, i32 %.119, i32 %.120, i32 %.121, i32 %.122, i32 2)
  %.124 = mul i32 %.115, %.123at19
  %.125 = add i32 %.110, %.124
  %.126 = srem i32 %.125, 1000000007
  store i32 %.126, i32* %.80
  br label %.106 
.106:
  %.131 = load i32, i32* %.32
  %.132 = icmp ne i32 %.131, 0
  br i1 %.132, label %.129, label %.130
.129:
  %.134 = load i32, i32* %.80
  %.135 = load i32, i32* %.32
  %.136 = load i32, i32* %.41
  %.138at20 = call i32 @equal(i32 %.136, i32 4)
  %.139 = sub i32 %.135, %.138at20
  %.140 = load i32, i32* %.26
  %.141 = load i32, i32* %.29
  %.142 = add i32 %.141, 1
  %.143 = load i32, i32* %.32
  %.144 = sub i32 %.143, 1
  %.145 = load i32, i32* %.35
  %.146 = load i32, i32* %.38
  %.147at20 = call i32 @dfs(i32 %.140, i32 %.142, i32 %.144, i32 %.145, i32 %.146, i32 3)
  %.148 = mul i32 %.139, %.147at20
  %.149 = add i32 %.134, %.148
  %.150 = srem i32 %.149, 1000000007
  store i32 %.150, i32* %.80
  br label %.130 
.130:
  %.155 = load i32, i32* %.35
  %.156 = icmp ne i32 %.155, 0
  br i1 %.156, label %.153, label %.154
.153:
  %.158 = load i32, i32* %.80
  %.159 = load i32, i32* %.35
  %.160 = load i32, i32* %.41
  %.162at21 = call i32 @equal(i32 %.160, i32 5)
  %.163 = sub i32 %.159, %.162at21
  %.164 = load i32, i32* %.26
  %.165 = load i32, i32* %.29
  %.166 = load i32, i32* %.32
  %.167 = add i32 %.166, 1
  %.168 = load i32, i32* %.35
  %.169 = sub i32 %.168, 1
  %.170 = load i32, i32* %.38
  %.171at21 = call i32 @dfs(i32 %.164, i32 %.165, i32 %.167, i32 %.169, i32 %.170, i32 4)
  %.172 = mul i32 %.163, %.171at21
  %.173 = add i32 %.158, %.172
  %.174 = srem i32 %.173, 1000000007
  store i32 %.174, i32* %.80
  br label %.154 
.154:
  %.179 = load i32, i32* %.38
  %.180 = icmp ne i32 %.179, 0
  br i1 %.180, label %.177, label %.178
.177:
  %.182 = load i32, i32* %.80
  %.183 = load i32, i32* %.38
  %.184 = load i32, i32* %.26
  %.185 = load i32, i32* %.29
  %.186 = load i32, i32* %.32
  %.187 = load i32, i32* %.35
  %.188 = add i32 %.187, 1
  %.189 = load i32, i32* %.38
  %.190 = sub i32 %.189, 1
  %.191at22 = call i32 @dfs(i32 %.184, i32 %.185, i32 %.186, i32 %.188, i32 %.190, i32 5)
  %.192 = mul i32 %.183, %.191at22
  %.193 = add i32 %.182, %.192
  %.194 = srem i32 %.193, 1000000007
  store i32 %.194, i32* %.80
  br label %.178 
.178:
  %.197 = load i32, i32* %.80
  %.198 = srem i32 %.197, 1000000007
  %.199 = load i32, i32* %.26
  %.200 = load i32, i32* %.29
  %.201 = load i32, i32* %.32
  %.202 = load i32, i32* %.35
  %.203 = load i32, i32* %.38
  %.204 = load i32, i32* %.41
  %.205 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.199, i32 %.200, i32 %.201, i32 %.202, i32 %.203, i32 %.204
  store i32 %.198, i32* %.205
  %.207 = load i32, i32* %.26
  %.208 = load i32, i32* %.29
  %.209 = load i32, i32* %.32
  %.210 = load i32, i32* %.35
  %.211 = load i32, i32* %.38
  %.212 = load i32, i32* %.41
  %.213 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.207, i32 %.208, i32 %.209, i32 %.210, i32 %.211, i32 %.212
  %.214 = load i32, i32* %.213
  ret i32 %.214 
}
define i32 @main(){
.219:
  %.338 = alloca i32
  %.269 = alloca i32
  %.260 = alloca i32
  %.251 = alloca i32
  %.242 = alloca i32
  %.233 = alloca i32
  %.224 = alloca i32
  %.220 = alloca i32
  %.222at30 = call i32 @getint()
  store i32 %.222at30, i32* %.220
  store i32 0, i32* %.224
  br label %.226wc32 
.226wc32:
  %.230 = load i32, i32* %.224
  %.231 = icmp slt i32 %.230, 18
  br i1 %.231, label %.227wloop.32.55, label %.228wn55
.227wloop.32.55:
  store i32 0, i32* %.233
  br label %.235wc34 
.228wn55:
  store i32 0, i32* %.224
  br label %.311wc58 
.235wc34:
  %.239 = load i32, i32* %.233
  %.240 = icmp slt i32 %.239, 18
  br i1 %.240, label %.236wloop.34.53, label %.237wn53
.236wloop.34.53:
  store i32 0, i32* %.242
  br label %.244wc36 
.237wn53:
  %.306 = load i32, i32* %.224
  %.307 = add i32 %.306, 1
  store i32 %.307, i32* %.224
  br label %.226wc32 
.244wc36:
  %.248 = load i32, i32* %.242
  %.249 = icmp slt i32 %.248, 18
  br i1 %.249, label %.245wloop.36.51, label %.246wn51
.245wloop.36.51:
  store i32 0, i32* %.251
  br label %.253wc38 
.246wn51:
  %.302 = load i32, i32* %.233
  %.303 = add i32 %.302, 1
  store i32 %.303, i32* %.233
  br label %.235wc34 
.253wc38:
  %.257 = load i32, i32* %.251
  %.258 = icmp slt i32 %.257, 18
  br i1 %.258, label %.254wloop.38.49, label %.255wn49
.254wloop.38.49:
  store i32 0, i32* %.260
  br label %.262wc40 
.255wn49:
  %.298 = load i32, i32* %.242
  %.299 = add i32 %.298, 1
  store i32 %.299, i32* %.242
  br label %.244wc36 
.262wc40:
  %.266 = load i32, i32* %.260
  %.267 = icmp slt i32 %.266, 18
  br i1 %.267, label %.263wloop.40.47, label %.264wn47
.263wloop.40.47:
  store i32 0, i32* %.269
  br label %.271wc42 
.264wn47:
  %.294 = load i32, i32* %.251
  %.295 = add i32 %.294, 1
  store i32 %.295, i32* %.251
  br label %.253wc38 
.271wc42:
  %.275 = load i32, i32* %.269
  %.276 = icmp slt i32 %.275, 7
  br i1 %.276, label %.272wloop.42.45, label %.273wn45
.272wloop.42.45:
  %.278 = load i32, i32* %.224
  %.279 = load i32, i32* %.233
  %.280 = load i32, i32* %.242
  %.281 = load i32, i32* %.251
  %.282 = load i32, i32* %.260
  %.283 = load i32, i32* %.269
  %.284 = getelementptr inbounds [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]], [18 x [18 x [18 x [18 x [18 x [7 x i32]]]]]]* @.g.dp, i32 0, i32 %.278, i32 %.279, i32 %.280, i32 %.281, i32 %.282, i32 %.283
  store i32 -1, i32* %.284
  %.286 = load i32, i32* %.269
  %.287 = add i32 %.286, 1
  store i32 %.287, i32* %.269
  br label %.271wc42 
.273wn45:
  %.290 = load i32, i32* %.260
  %.291 = add i32 %.290, 1
  store i32 %.291, i32* %.260
  br label %.262wc40 
.311wc58:
  %.315 = load i32, i32* %.224
  %.316 = load i32, i32* %.220
  %.317 = icmp slt i32 %.315, %.316
  br i1 %.317, label %.312wloop.58.62, label %.313wn62
.312wloop.58.62:
  %.319at59 = call i32 @getint()
  %.320 = load i32, i32* %.224
  %.321 = getelementptr inbounds [200 x i32], [200 x i32]* @.g.list, i32 0, i32 %.320
  store i32 %.319at59, i32* %.321
  %.323 = load i32, i32* %.224
  %.324 = getelementptr inbounds [200 x i32], [200 x i32]* @.g.list, i32 0, i32 %.323
  %.325 = load i32, i32* %.324
  %.326 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 %.325
  %.327 = load i32, i32* %.326
  %.328 = add i32 %.327, 1
  %.329 = load i32, i32* %.224
  %.330 = getelementptr inbounds [200 x i32], [200 x i32]* @.g.list, i32 0, i32 %.329
  %.331 = load i32, i32* %.330
  %.332 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 %.331
  store i32 %.328, i32* %.332
  %.334 = load i32, i32* %.224
  %.335 = add i32 %.334, 1
  store i32 %.335, i32* %.224
  br label %.311wc58 
.313wn62:
  %.339 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 1
  %.340 = load i32, i32* %.339
  %.341 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 2
  %.342 = load i32, i32* %.341
  %.343 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i32 0, i32 3
  %.344 = load i32, i32* %.343
  %.345 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.cns, i3