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
@.g.e = global [16 x [16 x i32]] zeroinitializer
@.g.book = global [16 x i32] zeroinitializer
@.g.dis = global [16 x i32] zeroinitializer
@.g.n = global i32 zeroinitializer
@.g.m = global i32 zeroinitializer
@.g.v1 = global i32 zeroinitializer
@.g.v2 = global i32 zeroinitializer
@.g.w = global i32 zeroinitializer
define void @Dijkstra(){
.11:
  %.92 = alloca i32
  %.54 = alloca i32
  %.52 = alloca i32
  %.50 = alloca i32
  %.13 = alloca i32
  %.12 = alloca i32
  store i32 1, i32* %.12
  br label %.16wc13 
.16wc13:
  %.20 = load i32, i32* %.12
  %.21 = load i32, i32* @.g.n
  %.22 = icmp sle i32 %.20, %.21
  br i1 %.22, label %.17wloop.13.17, label %.18wn17
.17wloop.13.17:
  %.24 = load i32, i32* %.12
  %.25 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 1, i32 %.24
  %.27 = load i32, i32* %.25
  %.28 = load i32, i32* %.12
  %.29 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.28
  store i32 %.27, i32* %.29
  %.31 = load i32, i32* %.12
  %.32 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.book, i32 0, i32 %.31
  store i32 0, i32* %.32
  %.34 = load i32, i32* %.12
  %.35 = add i32 %.34, 1
  store i32 %.35, i32* %.12
  br label %.16wc13 
.18wn17:
  %.38 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.book, i32 0, i32 1
  store i32 1, i32* %.38
  store i32 1, i32* %.12
  br label %.41wc21 
.41wc21:
  %.45 = load i32, i32* %.12
  %.46 = load i32, i32* @.g.n
  %.47 = sub i32 %.46, 1
  %.48 = icmp sle i32 %.45, %.47
  br i1 %.48, label %.42wloop.21.43, label %.43wn43
.42wloop.21.43:
  store i32 65535, i32* %.50
  store i32 0, i32* %.52
  store i32 1, i32* %.54
  br label %.56wc25 
.43wn43:
  ret void
.56wc25:
  %.60 = load i32, i32* %.54
  %.61 = load i32, i32* @.g.n
  %.62 = icmp sle i32 %.60, %.61
  br i1 %.62, label %.57wloop.25.31, label %.58wn31
.57wloop.25.31:
  %.66 = load i32, i32* %.50
  %.67 = load i32, i32* %.54
  %.68 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.67
  %.69 = load i32, i32* %.68
  %.70 = icmp sgt i32 %.66, %.69
  br i1 %.70, label %.71, label %.65
.58wn31:
  %.89 = load i32, i32* %.52
  %.90 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.book, i32 0, i32 %.89
  store i32 1, i32* %.90
  store i32 1, i32* %.92
  br label %.94wc34 
.64:
  %.78 = load i32, i32* %.54
  %.79 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.78
  %.80 = load i32, i32* %.79
  store i32 %.80, i32* %.50
  %.82 = load i32, i32* %.54
  store i32 %.82, i32* %.52
  br label %.65 
.65:
  %.85 = load i32, i32* %.54
  %.86 = add i32 %.85, 1
  store i32 %.86, i32* %.54
  br label %.56wc25 
.71:
  %.73 = load i32, i32* %.54
  %.74 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.book, i32 0, i32 %.73
  %.75 = load i32, i32* %.74
  %.76 = icmp eq i32 %.75, 0
  br i1 %.76, label %.64, label %.65
.94wc34:
  %.98 = load i32, i32* %.92
  %.99 = load i32, i32* @.g.n
  %.100 = icmp sle i32 %.98, %.99
  br i1 %.100, label %.95wloop.34.41, label %.96wn41
.95wloop.34.41:
  %.104 = load i32, i32* %.52
  %.105 = load i32, i32* %.92
  %.106 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.104, i32 %.105
  %.107 = load i32, i32* %.106
  %.108 = icmp slt i32 %.107, 65535
  br i1 %.108, label %.102, label %.103
.96wn41:
  %.142 = load i32, i32* %.12
  %.143 = add i32 %.142, 1
  store i32 %.143, i32* %.12
  br label %.41wc21 
.102:
  %.112 = load i32, i32* %.92
  %.113 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.112
  %.114 = load i32, i32* %.113
  %.115 = load i32, i32* %.52
  %.116 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.115
  %.117 = load i32, i32* %.116
  %.118 = load i32, i32* %.52
  %.119 = load i32, i32* %.92
  %.120 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.118, i32 %.119
  %.121 = load i32, i32* %.120
  %.122 = add i32 %.117, %.121
  %.123 = icmp sgt i32 %.114, %.122
  br i1 %.123, label %.110, label %.111
.103:
  %.138 = load i32, i32* %.92
  %.139 = add i32 %.138, 1
  store i32 %.139, i32* %.92
  br label %.94wc34 
.110:
  %.125 = load i32, i32* %.52
  %.126 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.125
  %.127 = load i32, i32* %.126
  %.128 = load i32, i32* %.52
  %.129 = load i32, i32* %.92
  %.130 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.128, i32 %.129
  %.131 = load i32, i32* %.130
  %.132 = add i32 %.127, %.131
  %.133 = load i32, i32* %.92
  %.134 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.133
  store i32 %.132, i32* %.134
  br label %.111 
.111:
  br label %.103 
}
define i32 @main(){
.148:
  %.211 = alloca i32
  %.208 = alloca i32
  %.164 = alloca i32
  %.149 = alloca i32
  %.151at49 = call i32 @getint()
  store i32 %.151at49, i32* @.g.n
  %.153at50 = call i32 @getint()
  store i32 %.153at50, i32* @.g.m
  store i32 1, i32* %.149
  br label %.156wc53 
.156wc53:
  %.160 = load i32, i32* %.149
  %.161 = load i32, i32* @.g.n
  %.162 = icmp sle i32 %.160, %.161
  br i1 %.162, label %.157wloop.53.63, label %.158wn63
.157wloop.53.63:
  store i32 1, i32* %.164
  br label %.166wc55 
.158wn63:
  store i32 1, i32* %.149
  br label %.200wc66 
.166wc55:
  %.170 = load i32, i32* %.164
  %.171 = load i32, i32* @.g.n
  %.172 = icmp sle i32 %.170, %.171
  br i1 %.172, label %.167wloop.55.61, label %.168wn61
.167wloop.55.61:
  %.176 = load i32, i32* %.149
  %.177 = load i32, i32* %.164
  %.178 = icmp eq i32 %.176, %.177
  br i1 %.178, label %.174, label %.175
.168wn61:
  %.195 = load i32, i32* %.149
  %.196 = add i32 %.195, 1
  store i32 %.196, i32* %.149
  br label %.156wc53 
.174:
  %.180 = load i32, i32* %.149
  %.181 = load i32, i32* %.164
  %.182 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.180, i32 %.181
  store i32 0, i32* %.182
  br label %.184 
.175:
  %.186 = load i32, i32* %.149
  %.187 = load i32, i32* %.164
  %.188 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.186, i32 %.187
  store i32 65535, i32* %.188
  br label %.184 
.184:
  %.191 = load i32, i32* %.164
  %.192 = add i32 %.191, 1
  store i32 %.192, i32* %.164
  br label %.166wc55 
.200wc66:
  %.204 = load i32, i32* %.149
  %.205 = load i32, i32* @.g.m
  %.206 = icmp sle i32 %.204, %.205
  br i1 %.206, label %.201wloop.66.70, label %.202wn70
.201wloop.66.70:
  %.209at67 = call i32 @getint()
  store i32 %.209at67, i32* %.208
  %.212at67 = call i32 @getint()
  store i32 %.212at67, i32* %.211
  %.214at68 = call i32 @getint()
  %.215 = load i32, i32* %.208
  %.216 = load i32, i32* %.211
  %.217 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.215, i32 %.216
  store i32 %.214at68, i32* %.217
  %.219 = load i32, i32* %.149
  %.220 = add i32 %.219, 1
  store i32 %.220, i32* %.149
  br label %.200wc66 
.202wn70:
  call void @Dijkstra()
  store i32 1, i32* %.149
  br label %.225wc75 
.225wc75:
  %.229 = load i32, i32* %.149
  %.230 = load i32, i32* @.g.n
  %.231 = icmp sle i32 %.229, %.230
  br i1 %.231, label %.226wloop.75.79, label %.227wn79
.226wloop.75.79:
  %.233 = load i32, i32* %.149
  %.234 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.233
  %.235 = load i32, i32* %.234
  call void @putint(i32 %.235)
  call void @putch(i32 32)
  %.241 = load i32, i32* %.149
  %.242 = add i32 %.241, 1
  store i32 %.242, i32* %.149
  br label %.225wc75 
.227wn79:
  call void @putch(i32 10)
  ret i32 0 
}
@.g.e = global [16 x [16 x i32]] zeroinitializer
@.g.book = global [16 x i32] zeroinitializer
@.g.dis = global [16 x i32] zeroinitializer
@.g.n = global i32 zeroinitializer
@.g.m = global i32 zeroinitializer
@.g.v1 = global i32 zeroinitializer
@.g.v2 = global i32 zeroinitializer
@.g.w = global i32 zeroinitializer
define void @Dijkstra(){
.11:
  %.92 = alloca i32
  %.54 = alloca i32
  %.52 = alloca i32
  %.50 = alloca i32
  %.13 = alloca i32
  %.12 = alloca i32
  store i32 1, i32* %.12
  br label %.16wc13 
.16wc13:
  %.20 = load i32, i32* %.12
  %.21 = load i32, i32* @.g.n
  %.22 = icmp sle i32 %.20, %.21
  br i1 %.22, label %.17wloop.13.17, label %.18wn17
.17wloop.13.17:
  %.24 = load i32, i32* %.12
  %.25 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 1, i32 %.24
  %.27 = load i32, i32* %.25
  %.28 = load i32, i32* %.12
  %.29 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.28
  store i32 %.27, i32* %.29
  %.31 = load i32, i32* %.12
  %.32 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.book, i32 0, i32 %.31
  store i32 0, i32* %.32
  %.34 = load i32, i32* %.12
  %.35 = add i32 %.34, 1
  store i32 %.35, i32* %.12
  br label %.16wc13 
.18wn17:
  %.38 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.book, i32 0, i32 1
  store i32 1, i32* %.38
  store i32 1, i32* %.12
  br label %.41wc21 
.41wc21:
  %.45 = load i32, i32* %.12
  %.46 = load i32, i32* @.g.n
  %.47 = sub i32 %.46, 1
  %.48 = icmp sle i32 %.45, %.47
  br i1 %.48, label %.42wloop.21.43, label %.43wn43
.42wloop.21.43:
  store i32 65535, i32* %.50
  store i32 0, i32* %.52
  store i32 1, i32* %.54
  br label %.56wc25 
.43wn43:
  ret void
.56wc25:
  %.60 = load i32, i32* %.54
  %.61 = load i32, i32* @.g.n
  %.62 = icmp sle i32 %.60, %.61
  br i1 %.62, label %.57wloop.25.31, label %.58wn31
.57wloop.25.31:
  %.66 = load i32, i32* %.50
  %.67 = load i32, i32* %.54
  %.68 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.67
  %.69 = load i32, i32* %.68
  %.70 = icmp sgt i32 %.66, %.69
  br i1 %.70, label %.71, label %.65
.58wn31:
  %.89 = load i32, i32* %.52
  %.90 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.book, i32 0, i32 %.89
  store i32 1, i32* %.90
  store i32 1, i32* %.92
  br label %.94wc34 
.64:
  %.78 = load i32, i32* %.54
  %.79 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.78
  %.80 = load i32, i32* %.79
  store i32 %.80, i32* %.50
  %.82 = load i32, i32* %.54
  store i32 %.82, i32* %.52
  br label %.65 
.65:
  %.85 = load i32, i32* %.54
  %.86 = add i32 %.85, 1
  store i32 %.86, i32* %.54
  br label %.56wc25 
.71:
  %.73 = load i32, i32* %.54
  %.74 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.book, i32 0, i32 %.73
  %.75 = load i32, i32* %.74
  %.76 = icmp eq i32 %.75, 0
  br i1 %.76, label %.64, label %.65
.94wc34:
  %.98 = load i32, i32* %.92
  %.99 = load i32, i32* @.g.n
  %.100 = icmp sle i32 %.98, %.99
  br i1 %.100, label %.95wloop.34.41, label %.96wn41
.95wloop.34.41:
  %.104 = load i32, i32* %.52
  %.105 = load i32, i32* %.92
  %.106 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.104, i32 %.105
  %.107 = load i32, i32* %.106
  %.108 = icmp slt i32 %.107, 65535
  br i1 %.108, label %.102, label %.103
.96wn41:
  %.142 = load i32, i32* %.12
  %.143 = add i32 %.142, 1
  store i32 %.143, i32* %.12
  br label %.41wc21 
.102:
  %.112 = load i32, i32* %.92
  %.113 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.112
  %.114 = load i32, i32* %.113
  %.115 = load i32, i32* %.52
  %.116 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.115
  %.117 = load i32, i32* %.116
  %.118 = load i32, i32* %.52
  %.119 = load i32, i32* %.92
  %.120 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.118, i32 %.119
  %.121 = load i32, i32* %.120
  %.122 = add i32 %.117, %.121
  %.123 = icmp sgt i32 %.114, %.122
  br i1 %.123, label %.110, label %.111
.103:
  %.138 = load i32, i32* %.92
  %.139 = add i32 %.138, 1
  store i32 %.139, i32* %.92
  br label %.94wc34 
.110:
  %.125 = load i32, i32* %.52
  %.126 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.125
  %.127 = load i32, i32* %.126
  %.128 = load i32, i32* %.52
  %.129 = load i32, i32* %.92
  %.130 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.128, i32 %.129
  %.131 = load i32, i32* %.130
  %.132 = add i32 %.127, %.131
  %.133 = load i32, i32* %.92
  %.134 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.133
  store i32 %.132, i32* %.134
  br label %.111 
.111:
  br label %.103 
}
define i32 @main(){
.148:
  %.211 = alloca i32
  %.208 = alloca i32
  %.164 = alloca i32
  %.149 = alloca i32
  %.151at49 = call i32 @getint()
  store i32 %.151at49, i32* @.g.n
  %.153at50 = call i32 @getint()
  store i32 %.153at50, i32* @.g.m
  store i32 1, i32* %.149
  br label %.156wc53 
.156wc53:
  %.160 = load i32, i32* %.149
  %.161 = load i32, i32* @.g.n
  %.162 = icmp sle i32 %.160, %.161
  br i1 %.162, label %.157wloop.53.63, label %.158wn63
.157wloop.53.63:
  store i32 1, i32* %.164
  br label %.166wc55 
.158wn63:
  store i32 1, i32* %.149
  br label %.200wc66 
.166wc55:
  %.170 = load i32, i32* %.164
  %.171 = load i32, i32* @.g.n
  %.172 = icmp sle i32 %.170, %.171
  br i1 %.172, label %.167wloop.55.61, label %.168wn61
.167wloop.55.61:
  %.176 = load i32, i32* %.149
  %.177 = load i32, i32* %.164
  %.178 = icmp eq i32 %.176, %.177
  br i1 %.178, label %.174, label %.175
.168wn61:
  %.195 = load i32, i32* %.149
  %.196 = add i32 %.195, 1
  store i32 %.196, i32* %.149
  br label %.156wc53 
.174:
  %.180 = load i32, i32* %.149
  %.181 = load i32, i32* %.164
  %.182 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.180, i32 %.181
  store i32 0, i32* %.182
  br label %.184 
.175:
  %.186 = load i32, i32* %.149
  %.187 = load i32, i32* %.164
  %.188 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.186, i32 %.187
  store i32 65535, i32* %.188
  br label %.184 
.184:
  %.191 = load i32, i32* %.164
  %.192 = add i32 %.191, 1
  store i32 %.192, i32* %.164
  br label %.166wc55 
.200wc66:
  %.204 = load i32, i32* %.149
  %.205 = load i32, i32* @.g.m
  %.206 = icmp sle i32 %.204, %.205
  br i1 %.206, label %.201wloop.66.70, label %.202wn70
.201wloop.66.70:
  %.209at67 = call i32 @getint()
  store i32 %.209at67, i32* %.208
  %.212at67 = call i32 @getint()
  store i32 %.212at67, i32* %.211
  %.214at68 = call i32 @getint()
  %.215 = load i32, i32* %.208
  %.216 = load i32, i32* %.211
  %.217 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* @.g.e, i32 0, i32 %.215, i32 %.216
  store i32 %.214at68, i32* %.217
  %.219 = load i32, i32* %.149
  %.220 = add i32 %.219, 1
  store i32 %.220, i32* %.149
  br label %.200wc66 
.202wn70:
  call void @Dijkstra()
  store i32 1, i32* %.149
  br label %.225wc75 
.225wc75:
  %.229 = load i32, i32* %.149
  %.230 = load i32, i32* @.g.n
  %.231 = icmp sle i32 %.229, %.230
  br i1 %.231, label %.226wloop.75.79, label %.227wn79
.226wloop.75.79:
  %.233 = load i32, i32* %.149
  %.234 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.dis, i32 0, i32 %.233
  %.235 = l