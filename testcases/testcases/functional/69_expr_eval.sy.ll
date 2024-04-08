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
@.g.last_char = global i32 32
@.g.num = global i32 zeroinitializer
@.g.other = global i32 zeroinitializer
@.g.cur_token = global i32 zeroinitializer
@__constant..277 = constant [256 x i32] zeroinitializer
@__constant..285 = constant [256 x i32] zeroinitializer
define i32 @next_char(){
.8:
  %.10at6 = call i32 @getch()
  store i32 %.10at6, i32* @.g.last_char
  %.12 = load i32, i32* @.g.last_char
  ret i32 %.12 
}
define i32 @is_space(i32 %.17){
.15:
  %.16 = alloca i32
  store i32 %.17, i32* %.16
  %.22 = load i32, i32* %.16
  %.23 = icmp eq i32 %.22, 32
  br i1 %.23, label %.19, label %.21
.19:
  ret i32 1 
.20:
  ret i32 0 
.21:
  %.25 = load i32, i32* %.16
  %.27 = icmp eq i32 %.25, 10
  br i1 %.27, label %.19, label %.20
}
define i32 @is_num(i32 %.34){
.32:
  %.33 = alloca i32
  store i32 %.34, i32* %.33
  %.38 = load i32, i32* %.33
  %.40 = icmp sge i32 %.38, 48
  br i1 %.40, label %.41, label %.37
.36:
  ret i32 1 
.37:
  ret i32 0 
.41:
  %.43 = load i32, i32* %.33
  %.45 = icmp sle i32 %.43, 57
  br i1 %.45, label %.36, label %.37
}
define i32 @next_token(){
.50:
  br label %.51wc29 
.51wc29:
  %.55 = load i32, i32* @.g.last_char
  %.56at29 = call i32 @is_space(i32 %.55)
  %.57 = icmp ne i32 %.56at29, 0
  br i1 %.57, label %.52wloop.29.29, label %.53wn29
.52wloop.29.29:
  %.59at29 = call i32 @next_char()
  br label %.51wc29 
.53wn29:
  %.63 = load i32, i32* @.g.last_char
  %.64at30 = call i32 @is_num(i32 %.63)
  %.65 = icmp ne i32 %.64at30, 0
  br i1 %.65, label %.61, label %.62
.61:
  %.67 = load i32, i32* @.g.last_char
  %.68 = sub i32 %.67, 48
  store i32 %.68, i32* @.g.num
  br label %.70wc32 
.62:
  %.88 = load i32, i32* @.g.last_char
  store i32 %.88, i32* @.g.other
  %.90at39 = call i32 @next_char()
  store i32 1, i32* @.g.cur_token
  br label %.86 
.70wc32:
  %.74at32 = call i32 @next_char()
  %.75at32 = call i32 @is_num(i32 %.74at32)
  %.76 = icmp ne i32 %.75at32, 0
  br i1 %.76, label %.71wloop.32.34, label %.72wn34
.71wloop.32.34:
  %.78 = load i32, i32* @.g.num
  %.79 = mul i32 %.78, 10
  %.80 = load i32, i32* @.g.last_char
  %.81 = add i32 %.79, %.80
  %.82 = sub i32 %.81, 48
  store i32 %.82, i32* @.g.num
  br label %.70wc32 
.72wn34:
  store i32 0, i32* @.g.cur_token
  br label %.86 
.86:
  %.93 = load i32, i32* @.g.cur_token
  ret i32 %.93 
}
define i32 @panic(){
.96:
  call void @putch(i32 112)
  call void @putch(i32 97)
  call void @putch(i32 110)
  call void @putch(i32 105)
  call void @putch(i32 99)
  call void @putch(i32 33)
  call void @putch(i32 10)
  ret i32 -1 
}
define i32 @get_op_prec(i32 %.116){
.114:
  %.115 = alloca i32
  store i32 %.116, i32* %.115
  %.121 = load i32, i32* %.115
  %.123 = icmp eq i32 %.121, 43
  br i1 %.123, label %.118, label %.120
.118:
  ret i32 10 
.119:
  %.133 = load i32, i32* %.115
  %.135 = icmp eq i32 %.133, 42
  br i1 %.135, label %.130, label %.132
.120:
  %.125 = load i32, i32* %.115
  %.127 = icmp eq i32 %.125, 45
  br i1 %.127, label %.118, label %.119
.130:
  ret i32 20 
.131:
  ret i32 0 
.132:
  %.138 = load i32, i32* %.115
  %.140 = icmp eq i32 %.138, 47
  br i1 %.140, label %.130, label %.137
.137:
  %.142 = load i32, i32* %.115
  %.144 = icmp eq i32 %.142, 37
  br i1 %.144, label %.130, label %.131
}
define void @stack_push(i32* %.152, i32 %.155){
.150:
  %.154 = alloca i32
  %.151 = alloca i32*
  store i32* %.152, i32** %.151
  store i32 %.155, i32* %.154
  %.157 = load i32*, i32** %.151
  %.158 = getelementptr inbounds i32, i32* %.157, i32 0
  %.159 = load i32, i32* %.158
  %.160 = add i32 %.159, 1
  %.161 = load i32*, i32** %.151
  %.162 = getelementptr inbounds i32, i32* %.161, i32 0
  store i32 %.160, i32* %.162
  %.164 = load i32, i32* %.154
  %.165 = load i32*, i32** %.151
  %.166 = getelementptr inbounds i32, i32* %.165, i32 0
  %.167 = load i32, i32* %.166
  %.168 = load i32*, i32** %.151
  %.169 = getelementptr inbounds i32, i32* %.168, i32 %.167
  store i32 %.164, i32* %.169
  ret void
}
define i32 @stack_pop(i32* %.175){
.173:
  %.177 = alloca i32
  %.174 = alloca i32*
  store i32* %.175, i32** %.174
  %.178 = load i32*, i32** %.174
  %.179 = getelementptr inbounds i32, i32* %.178, i32 0
  %.180 = load i32, i32* %.179
  %.181 = load i32*, i32** %.174
  %.182 = getelementptr inbounds i32, i32* %.181, i32 %.180
  %.183 = load i32, i32* %.182
  store i32 %.183, i32* %.177
  %.185 = load i32*, i32** %.174
  %.186 = getelementptr inbounds i32, i32* %.185, i32 0
  %.187 = load i32, i32* %.186
  %.188 = sub i32 %.187, 1
  %.189 = load i32*, i32** %.174
  %.190 = getelementptr inbounds i32, i32* %.189, i32 0
  store i32 %.188, i32* %.190
  %.192 = load i32, i32* %.177
  ret i32 %.192 
}
define i32 @stack_peek(i32* %.197){
.195:
  %.196 = alloca i32*
  store i32* %.197, i32** %.196
  %.199 = load i32*, i32** %.196
  %.200 = getelementptr inbounds i32, i32* %.199, i32 0
  %.201 = load i32, i32* %.200
  %.202 = load i32*, i32** %.196
  %.203 = getelementptr inbounds i32, i32* %.202, i32 %.201
  %.204 = load i32, i32* %.203
  ret i32 %.204 
}
define i32 @stack_size(i32* %.209){
.207:
  %.208 = alloca i32*
  store i32* %.209, i32** %.208
  %.211 = load i32*, i32** %.208
  %.212 = getelementptr inbounds i32, i32* %.211, i32 0
  %.213 = load i32, i32* %.212
  ret i32 %.213 
}
define i32 @eval_op(i32 %.218, i32 %.221, i32 %.224){
.216:
  %.223 = alloca i32
  %.220 = alloca i32
  %.217 = alloca i32
  store i32 %.218, i32* %.217
  store i32 %.221, i32* %.220
  store i32 %.224, i32* %.223
  %.228 = load i32, i32* %.217
  %.229 = icmp eq i32 %.228, 43
  br i1 %.229, label %.226, label %.227
.226:
  %.231 = load i32, i32* %.220
  %.232 = load i32, i32* %.223
  %.233 = add i32 %.231, %.232
  ret i32 %.233 
.227:
  %.237 = load i32, i32* %.217
  %.238 = icmp eq i32 %.237, 45
  br i1 %.238, label %.235, label %.236
.235:
  %.240 = load i32, i32* %.220
  %.241 = load i32, i32* %.223
  %.242 = sub i32 %.240, %.241
  ret i32 %.242 
.236:
  %.246 = load i32, i32* %.217
  %.247 = icmp eq i32 %.246, 42
  br i1 %.247, label %.244, label %.245
.244:
  %.249 = load i32, i32* %.220
  %.250 = load i32, i32* %.223
  %.251 = mul i32 %.249, %.250
  ret i32 %.251 
.245:
  %.255 = load i32, i32* %.217
  %.256 = icmp eq i32 %.255, 47
  br i1 %.256, label %.253, label %.254
.253:
  %.258 = load i32, i32* %.220
  %.259 = load i32, i32* %.223
  %.260 = sdiv i32 %.258, %.259
  ret i32 %.260 
.254:
  %.264 = load i32, i32* %.217
  %.265 = icmp eq i32 %.264, 37
  br i1 %.265, label %.262, label %.263
.262:
  %.267 = load i32, i32* %.220
  %.268 = load i32, i32* %.223
  %.269 = srem i32 %.267, %.268
  ret i32 %.269 
.263:
  ret i32 0 
}
define i32 @eval(){
.273:
  %.383 = alloca i32
  %.379 = alloca i32
  %.375 = alloca i32
  %.340 = alloca i32
  %.336 = alloca i32
  %.332 = alloca i32
  %.305 = alloca i32
  %.283 = alloca [256 x i32]
  %.275 = alloca [256 x i32]
  call void @llvm.memcpy.p0.p0.i32([256 x i32]* %.275, [256 x i32]* @__constant..277, i32 1024, i1 false)
  call void @llvm.memcpy.p0.p0.i32([256 x i32]* %.283, [256 x i32]* @__constant..285, i32 1024, i1 false)
  %.289 = load i32, i32* @.g.cur_token
  %.290 = icmp ne i32 %.289, 0
  br i1 %.290, label %.287, label %.288
.287:
  %.292at102 = call i32 @panic()
  ret i32 %.292at102 
.288:
  %.294 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.295 = load i32, i32* @.g.num
  call void @stack_push(i32* %.294, i32 %.295)
  %.297at104 = call i32 @next_token()
  br label %.298wc106 
.298wc106:
  %.302 = load i32, i32* @.g.cur_token
  %.303 = icmp eq i32 %.302, 1
  br i1 %.303, label %.299wloop.106.123, label %.300wn123
.299wloop.106.123:
  %.306 = load i32, i32* @.g.other
  store i32 %.306, i32* %.305
  %.310 = load i32, i32* %.305
  %.311at109 = call i32 @get_op_prec(i32 %.310)
  %.312 = icmp eq i32 %.311at109, 0
  br i1 %.312, label %.308, label %.309
.300wn123:
  %.366at125 = call i32 @next_token()
  br label %.367wc127 
.308:
  br label %.300wn123 
.309:
  %.315at110 = call i32 @next_token()
  br label %.316wc112 
.316wc112:
  %.320 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.321at112 = call i32 @stack_size(i32* %.320)
  %.322 = icmp ne i32 %.321at112, 0
  br i1 %.322, label %.323, label %.318wn117
.317wloop.112.117:
  %.333 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.334at114 = call i32 @stack_pop(i32* %.333)
  store i32 %.334at114, i32* %.332
  %.337 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.338at115 = call i32 @stack_pop(i32* %.337)
  store i32 %.338at115, i32* %.336
  %.341 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.342at115 = call i32 @stack_pop(i32* %.341)
  store i32 %.342at115, i32* %.340
  %.344 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.345 = load i32, i32* %.332
  %.346 = load i32, i32* %.340
  %.347 = load i32, i32* %.336
  %.348at116 = call i32 @eval_op(i32 %.345, i32 %.346, i32 %.347)
  call void @stack_push(i32* %.344, i32 %.348at116)
  br label %.316wc112 
.318wn117:
  %.351 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.352 = load i32, i32* %.305
  call void @stack_push(i32* %.351, i32 %.352)
  %.356 = load i32, i32* @.g.cur_token
  %.357 = icmp ne i32 %.356, 0
  br i1 %.357, label %.354, label %.355
.323:
  %.325 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.326at112 = call i32 @stack_peek(i32* %.325)
  %.327at112 = call i32 @get_op_prec(i32 %.326at112)
  %.328 = load i32, i32* %.305
  %.329at112 = call i32 @get_op_prec(i32 %.328)
  %.330 = icmp sge i32 %.327at112, %.329at112
  br i1 %.330, label %.317wloop.112.117, label %.318wn117
.354:
  %.359at120 = call i32 @panic()
  ret i32 %.359at120 
.355:
  %.361 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.362 = load i32, i32* @.g.num
  call void @stack_push(i32* %.361, i32 %.362)
  %.364at122 = call i32 @next_token()
  br label %.298wc106 
.367wc127:
  %.371 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.372at127 = call i32 @stack_size(i32* %.371)
  %.373 = icmp ne i32 %.372at127, 0
  br i1 %.373, label %.368wloop.127.131, label %.369wn131
.368wloop.127.131:
  %.376 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.377at128 = call i32 @stack_pop(i32* %.376)
  store i32 %.377at128, i32* %.375
  %.380 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.381at129 = call i32 @stack_pop(i32* %.380)
  store i32 %.381at129, i32* %.379
  %.384 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.385at129 = call i32 @stack_pop(i32* %.384)
  store i32 %.385at129, i32* %.383
  %.387 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.388 = load i32, i32* %.375
  %.389 = load i32, i32* %.383
  %.390 = load i32, i32* %.379
  %.391at130 = call i32 @eval_op(i32 %.388, i32 %.389, i32 %.390)
  call void @stack_push(i32* %.387, i32 %.391at130)
  br label %.367wc127 
.369wn131:
  %.394 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.395at132 = call i32 @stack_peek(i32* %.394)
  ret i32 %.395at132 
}
define i32 @main(){
.398:
  %.399 = alloca i32
  %.401at136 = call i32 @getint()
  store i32 %.401at136, i32* %.399
  %.403at137 = call i32 @getch()
  %.404at138 = call i32 @next_token()
  br label %.405wc139 
.405wc139:
  %.409 = load i32, i32* %.399
  %.410 = icmp ne i32 %.409, 0
  br i1 %.410, label %.406wloop.139.143, label %.407wn143
.406wloop.139.143:
  %.412at140 = call i32 @eval()
  call void @putint(i32 %.412at140)
  call void @putch(i32 10)
  %.416 = load i32, i32* %.399
  %.417 = sub i32 %.416, 1
  store i32 %.417, i32* %.399
  br label %.405wc139 
.407wn143:
  ret i32 0 
}
@.g.last_char = global i32 32
@.g.num = global i32 zeroinitializer
@.g.other = global i32 zeroinitializer
@.g.cur_token = global i32 zeroinitializer
@__constant..277 = constant [256 x i32] zeroinitializer
@__constant..285 = constant [256 x i32] zeroinitializer
define i32 @next_char(){
.8:
  %.10at6 = call i32 @getch()
  store i32 %.10at6, i32* @.g.last_char
  %.12 = load i32, i32* @.g.last_char
  ret i32 %.12 
}
define i32 @is_space(i32 %.17){
.15:
  %.16 = alloca i32
  store i32 %.17, i32* %.16
  %.22 = load i32, i32* %.16
  %.23 = icmp eq i32 %.22, 32
  br i1 %.23, label %.19, label %.21
.19:
  ret i32 1 
.20:
  ret i32 0 
.21:
  %.25 = load i32, i32* %.16
  %.27 = icmp eq i32 %.25, 10
  br i1 %.27, label %.19, label %.20
}
define i32 @is_num(i32 %.34){
.32:
  %.33 = alloca i32
  store i32 %.34, i32* %.33
  %.38 = load i32, i32* %.33
  %.40 = icmp sge i32 %.38, 48
  br i1 %.40, label %.41, label %.37
.36:
  ret i32 1 
.37:
  ret i32 0 
.41:
  %.43 = load i32, i32* %.33
  %.45 = icmp sle i32 %.43, 57
  br i1 %.45, label %.36, label %.37
}
define i32 @next_token(){
.50:
  br label %.51wc29 
.51wc29:
  %.55 = load i32, i32* @.g.last_char
  %.56at29 = call i32 @is_space(i32 %.55)
  %.57 = icmp ne i32 %.56at29, 0
  br i1 %.57, label %.52wloop.29.29, label %.53wn29
.52wloop.29.29:
  %.59at29 = call i32 @next_char()
  br label %.51wc29 
.53wn29:
  %.63 = load i32, i32* @.g.last_char
  %.64at30 = call i32 @is_num(i32 %.63)
  %.65 = icmp ne i32 %.64at30, 0
  br i1 %.65, label %.61, label %.62
.61:
  %.67 = load i32, i32* @.g.last_char
  %.68 = sub i32 %.67, 48
  store i32 %.68, i32* @.g.num
  br label %.70wc32 
.62:
  %.88 = load i32, i32* @.g.last_char
  store i32 %.88, i32* @.g.other
  %.90at39 = call i32 @next_char()
  store i32 1, i32* @.g.cur_token
  br label %.86 
.70wc32:
  %.74at32 = call i32 @next_char()
  %.75at32 = call i32 @is_num(i32 %.74at32)
  %.76 = icmp ne i32 %.75at32, 0
  br i1 %.76, label %.71wloop.32.34, label %.72wn34
.71wloop.32.34:
  %.78 = load i32, i32* @.g.num
  %.79 = mul i32 %.78, 10
  %.80 = load i32, i32* @.g.last_char
  %.81 = add i32 %.79, %.80
  %.82 = sub i32 %.81, 48
  store i32 %.82, i32* @.g.num
  br label %.70wc32 
.72wn34:
  store i32 0, i32* @.g.cur_token
  br label %.86 
.86:
  %.93 = load i32, i32* @.g.cur_token
  ret i32 %.93 
}
define i32 @panic(){
.96:
  call void @putch(i32 112)
  call void @putch(i32 97)
  call void @putch(i32 110)
  call void @putch(i32 105)
  call void @putch(i32 99)
  call void @putch(i32 33)
  call void @putch(i32 10)
  ret i32 -1 
}
define i32 @get_op_prec(i32 %.116){
.114:
  %.115 = alloca i32
  store i32 %.116, i32* %.115
  %.121 = load i32, i32* %.115
  %.123 = icmp eq i32 %.121, 43
  br i1 %.123, label %.118, label %.120
.118:
  ret i32 10 
.119:
  %.133 = load i32, i32* %.115
  %.135 = icmp eq i32 %.133, 42
  br i1 %.135, label %.130, label %.132
.120:
  %.125 = load i32, i32* %.115
  %.127 = icmp eq i32 %.125, 45
  br i1 %.127, label %.118, label %.119
.130:
  ret i32 20 
.131:
  ret i32 0 
.132:
  %.138 = load i32, i32* %.115
  %.140 = icmp eq i32 %.138, 47
  br i1 %.140, label %.130, label %.137
.137:
  %.142 = load i32, i32* %.115
  %.144 = icmp eq i32 %.142, 37
  br i1 %.144, label %.130, label %.131
}
define void @stack_push(i32* %.152, i32 %.155){
.150:
  %.154 = alloca i32
  %.151 = alloca i32*
  store i32* %.152, i32** %.151
  store i32 %.155, i32* %.154
  %.157 = load i32*, i32** %.151
  %.158 = getelementptr inbounds i32, i32* %.157, i32 0
  %.159 = load i32, i32* %.158
  %.160 = add i32 %.159, 1
  %.161 = load i32*, i32** %.151
  %.162 = getelementptr inbounds i32, i32* %.161, i32 0
  store i32 %.160, i32* %.162
  %.164 = load i32, i32* %.154
  %.165 = load i32*, i32** %.151
  %.166 = getelementptr inbounds i32, i32* %.165, i32 0
  %.167 = load i32, i32* %.166
  %.168 = load i32*, i32** %.151
  %.169 = getelementptr inbounds i32, i32* %.168, i32 %.167
  store i32 %.164, i32* %.169
  ret void
}
define i32 @stack_pop(i32* %.175){
.173:
  %.177 = alloca i32
  %.174 = alloca i32*
  store i32* %.175, i32** %.174
  %.178 = load i32*, i32** %.174
  %.179 = getelementptr inbounds i32, i32* %.178, i32 0
  %.180 = load i32, i32* %.179
  %.181 = load i32*, i32** %.174
  %.182 = getelementptr inbounds i32, i32* %.181, i32 %.180
  %.183 = load i32, i32* %.182
  store i32 %.183, i32* %.177
  %.185 = load i32*, i32** %.174
  %.186 = getelementptr inbounds i32, i32* %.185, i32 0
  %.187 = load i32, i32* %.186
  %.188 = sub i32 %.187, 1
  %.189 = load i32*, i32** %.174
  %.190 = getelementptr inbounds i32, i32* %.189, i32 0
  store i32 %.188, i32* %.190
  %.192 = load i32, i32* %.177
  ret i32 %.192 
}
define i32 @stack_peek(i32* %.197){
.195:
  %.196 = alloca i32*
  store i32* %.197, i32** %.196
  %.199 = load i32*, i32** %.196
  %.200 = getelementptr inbounds i32, i32* %.199, i32 0
  %.201 = load i32, i32* %.200
  %.202 = load i32*, i32** %.196
  %.203 = getelementptr inbounds i32, i32* %.202, i32 %.201
  %.204 = load i32, i32* %.203
  ret i32 %.204 
}
define i32 @stack_size(i32* %.209){
.207:
  %.208 = alloca i32*
  store i32* %.209, i32** %.208
  %.211 = load i32*, i32** %.208
  %.212 = getelementptr inbounds i32, i32* %.211, i32 0
  %.213 = load i32, i32* %.212
  ret i32 %.213 
}
define i32 @eval_op(i32 %.218, i32 %.221, i32 %.224){
.216:
  %.223 = alloca i32
  %.220 = alloca i32
  %.217 = alloca i32
  store i32 %.218, i32* %.217
  store i32 %.221, i32* %.220
  store i32 %.224, i32* %.223
  %.228 = load i32, i32* %.217
  %.229 = icmp eq i32 %.228, 43
  br i1 %.229, label %.226, label %.227
.226:
  %.231 = load i32, i32* %.220
  %.232 = load i32, i32* %.223
  %.233 = add i32 %.231, %.232
  ret i32 %.233 
.227:
  %.237 = load i32, i32* %.217
  %.238 = icmp eq i32 %.237, 45
  br i1 %.238, label %.235, label %.236
.235:
  %.240 = load i32, i32* %.220
  %.241 = load i32, i32* %.223
  %.242 = sub i32 %.240, %.241
  ret i32 %.242 
.236:
  %.246 = load i32, i32* %.217
  %.247 = icmp eq i32 %.246, 42
  br i1 %.247, label %.244, label %.245
.244:
  %.249 = load i32, i32* %.220
  %.250 = load i32, i32* %.223
  %.251 = mul i32 %.249, %.250
  ret i32 %.251 
.245:
  %.255 = load i32, i32* %.217
  %.256 = icmp eq i32 %.255, 47
  br i1 %.256, label %.253, label %.254
.253:
  %.258 = load i32, i32* %.220
  %.259 = load i32, i32* %.223
  %.260 = sdiv i32 %.258, %.259
  ret i32 %.260 
.254:
  %.264 = load i32, i32* %.217
  %.265 = icmp eq i32 %.264, 37
  br i1 %.265, label %.262, label %.263
.262:
  %.267 = load i32, i32* %.220
  %.268 = load i32, i32* %.223
  %.269 = srem i32 %.267, %.268
  ret i32 %.269 
.263:
  ret i32 0 
}
define i32 @eval(){
.273:
  %.383 = alloca i32
  %.379 = alloca i32
  %.375 = alloca i32
  %.340 = alloca i32
  %.336 = alloca i32
  %.332 = alloca i32
  %.305 = alloca i32
  %.283 = alloca [256 x i32]
  %.275 = alloca [256 x i32]
  call void @llvm.memcpy.p0.p0.i32([256 x i32]* %.275, [256 x i32]* @__constant..277, i32 1024, i1 false)
  call void @llvm.memcpy.p0.p0.i32([256 x i32]* %.283, [256 x i32]* @__constant..285, i32 1024, i1 false)
  %.289 = load i32, i32* @.g.cur_token
  %.290 = icmp ne i32 %.289, 0
  br i1 %.290, label %.287, label %.288
.287:
  %.292at102 = call i32 @panic()
  ret i32 %.292at102 
.288:
  %.294 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.295 = load i32, i32* @.g.num
  call void @stack_push(i32* %.294, i32 %.295)
  %.297at104 = call i32 @next_token()
  br label %.298wc106 
.298wc106:
  %.302 = load i32, i32* @.g.cur_token
  %.303 = icmp eq i32 %.302, 1
  br i1 %.303, label %.299wloop.106.123, label %.300wn123
.299wloop.106.123:
  %.306 = load i32, i32* @.g.other
  store i32 %.306, i32* %.305
  %.310 = load i32, i32* %.305
  %.311at109 = call i32 @get_op_prec(i32 %.310)
  %.312 = icmp eq i32 %.311at109, 0
  br i1 %.312, label %.308, label %.309
.300wn123:
  %.366at125 = call i32 @next_token()
  br label %.367wc127 
.308:
  br label %.300wn123 
.309:
  %.315at110 = call i32 @next_token()
  br label %.316wc112 
.316wc112:
  %.320 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.321at112 = call i32 @stack_size(i32* %.320)
  %.322 = icmp ne i32 %.321at112, 0
  br i1 %.322, label %.323, label %.318wn117
.317wloop.112.117:
  %.333 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.334at114 = call i32 @stack_pop(i32* %.333)
  store i32 %.334at114, i32* %.332
  %.337 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.338at115 = call i32 @stack_pop(i32* %.337)
  store i32 %.338at115, i32* %.336
  %.341 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.342at115 = call i32 @stack_pop(i32* %.341)
  store i32 %.342at115, i32* %.340
  %.344 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.345 = load i32, i32* %.332
  %.346 = load i32, i32* %.340
  %.347 = load i32, i32* %.336
  %.348at116 = call i32 @eval_op(i32 %.345, i32 %.346, i32 %.347)
  call void @stack_push(i32* %.344, i32 %.348at116)
  br label %.316wc112 
.318wn117:
  %.351 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.352 = load i32, i32* %.305
  call void @stack_push(i32* %.351, i32 %.352)
  %.356 = load i32, i32* @.g.cur_token
  %.357 = icmp ne i32 %.356, 0
  br i1 %.357, label %.354, label %.355
.323:
  %.325 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.326at112 = call i32 @stack_peek(i32* %.325)
  %.327at112 = call i32 @get_op_prec(i32 %.326at112)
  %.328 = load i32, i32* %.305
  %.329at112 = call i32 @get_op_prec(i32 %.328)
  %.330 = icmp sge i32 %.327at112, %.329at112
  br i1 %.330, label %.317wloop.112.117, label %.318wn117
.354:
  %.359at120 = call i32 @panic()
  ret i32 %.359at120 
.355:
  %.361 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.362 = load i32, i32* @.g.num
  call void @stack_push(i32* %.361, i32 %.362)
  %.364at122 = call i32 @next_token()
  br label %.298wc106 
.367wc127:
  %.371 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.372at127 = call i32 @stack_size(i32* %.371)
  %.373 = icmp ne i32 %.372at127, 0
  br i1 %.373, label %.368wloop.127.131, label %.369wn131
.368wloop.127.131:
  %.376 = getelementptr inbounds [256 x i32], [256 x i32]* %.283, i32 0, i32 0
  %.377at128 = call i32 @stack_pop(i32* %.376)
  store i32 %.377at128, i32* %.375
  %.380 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.381at129 = call i32 @stack_pop(i32* %.380)
  store i32 %.381at129, i32* %.379
  %.384 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.385at129 = call i32 @stack_pop(i32* %.384)
  store i32 %.385at129, i32* %.383
  %.387 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.388 = load i32, i32* %.375
  %.389 = load i32, i32* %.383
  %.390 = load i32, i32* %.379
  %.391at130 = call i32 @eval_op(i32 %.388, i32 %.389, i32 %.390)
  call void @stack_push(i32* %.387, i32 %.391at130)
  br label %.367wc127 
.369wn131:
  %.394 = getelementptr inbounds [256 x i32], [256 x i32]* %.275, i32 0, i32 0
  %.395at132 = call i32 @stack_peek(i32* %.394)
  ret i32 %.395at132 
}
define i32 @main(){
.398:
  %.399 = alloca i32
  %.401at136 = call i32 @getint()
  store i32 %.401at136, i32* %.399
  %.40