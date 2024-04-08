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
@__constant..37 = constant [16 x i32] zeroinitializer
@__constant..112 = constant [16 x [16 x i32]] zeroinitializer
@__constant..201 = constant [15 x i32]  [i32 8, i32 7, i32 4, i32 1, i32 2, i32 7, i32 0, i32 1, i32 9, i32 3, i32 4, i32 8, i32 3, i32 7, i32 0]
@__constant..209 = constant [13 x i32]  [i32 3, i32 9, i32 7, i32 1, i32 4, i32 2, i32 4, i32 3, i32 6, i32 8, i32 0, i32 1, i32 5]
define i32 @MAX(i32 %.3, i32 %.6){
.1:
  %.5 = alloca i32
  %.2 = alloca i32
  store i32 %.3, i32* %.2
  store i32 %.6, i32* %.5
  %.10 = load i32, i32* %.2
  %.11 = load i32, i32* %.5
  %.12 = icmp eq i32 %.10, %.11
  br i1 %.12, label %.8, label %.9
.8:
  %.14 = load i32, i32* %.2
  ret i32 %.14 
.9:
  %.18 = load i32, i32* %.2
  %.19 = load i32, i32* %.5
  %.20 = icmp sgt i32 %.18, %.19
  br i1 %.20, label %.16, label %.17
.16:
  %.22 = load i32, i32* %.2
  ret i32 %.22 
.17:
  %.24 = load i32, i32* %.5
  ret i32 %.24 
}
define i32 @max_sum_nonadjacent(i32* %.29, i32 %.32){
.27:
  %.59 = alloca i32
  %.35 = alloca [16 x i32]
  %.31 = alloca i32
  %.28 = alloca i32*
  store i32* %.29, i32** %.28
  store i32 %.32, i32* %.31
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.35, [16 x i32]* @__constant..37, i32 64, i1 false)
  %.44 = load i32*, i32** %.28
  %.45 = getelementptr inbounds i32, i32* %.44, i32 0
  %.46 = load i32, i32* %.45
  %.47 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 0
  store i32 %.46, i32* %.47
  %.49 = load i32*, i32** %.28
  %.50 = getelementptr inbounds i32, i32* %.49, i32 0
  %.51 = load i32, i32* %.50
  %.53 = load i32*, i32** %.28
  %.54 = getelementptr inbounds i32, i32* %.53, i32 1
  %.55 = load i32, i32* %.54
  %.56at16 = call i32 @MAX(i32 %.51, i32 %.55)
  %.57 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 1
  store i32 %.56at16, i32* %.57
  store i32 2, i32* %.59
  br label %.62wc18 
.62wc18:
  %.66 = load i32, i32* %.59
  %.67 = load i32, i32* %.31
  %.68 = icmp slt i32 %.66, %.67
  br i1 %.68, label %.63wloop.18.21, label %.64wn21
.63wloop.18.21:
  %.70 = load i32, i32* %.59
  %.71 = sub i32 %.70, 2
  %.72 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 %.71
  %.73 = load i32, i32* %.72
  %.74 = load i32, i32* %.59
  %.75 = load i32*, i32** %.28
  %.76 = getelementptr inbounds i32, i32* %.75, i32 %.74
  %.77 = load i32, i32* %.76
  %.78 = add i32 %.73, %.77
  %.79 = load i32, i32* %.59
  %.80 = sub i32 %.79, 1
  %.81 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 %.80
  %.82 = load i32, i32* %.81
  %.83at19 = call i32 @MAX(i32 %.78, i32 %.82)
  %.84 = load i32, i32* %.59
  %.85 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 %.84
  store i32 %.83at19, i32* %.85
  %.87 = load i32, i32* %.59
  %.88 = add i32 %.87, 1
  store i32 %.88, i32* %.59
  br label %.62wc18 
.64wn21:
  %.91 = load i32, i32* %.31
  %.92 = sub i32 %.91, 1
  %.93 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 %.92
  %.94 = load i32, i32* %.93
  ret i32 %.94 
}
define i32 @longest_common_subseq(i32* %.99, i32 %.102, i32* %.105, i32 %.108){
.97:
  %.116 = alloca i32
  %.115 = alloca i32
  %.110 = alloca [16 x [16 x i32]]
  %.107 = alloca i32
  %.104 = alloca i32*
  %.101 = alloca i32
  %.98 = alloca i32*
  store i32* %.99, i32** %.98
  store i32 %.102, i32* %.101
  store i32* %.105, i32** %.104
  store i32 %.108, i32* %.107
  call void @llvm.memcpy.p0.p0.i32([16 x [16 x i32]]* %.110, [16 x [16 x i32]]* @__constant..112, i32 1024, i1 false)
  store i32 1, i32* %.115
  br label %.118wc31 
.118wc31:
  %.122 = load i32, i32* %.115
  %.123 = load i32, i32* %.101
  %.124 = icmp sle i32 %.122, %.123
  br i1 %.124, label %.119wloop.31.42, label %.120wn42
.119wloop.31.42:
  store i32 1, i32* %.116
  br label %.127wc33 
.120wn42:
  %.186 = load i32, i32* %.101
  %.187 = load i32, i32* %.107
  %.188 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.186, i32 %.187
  %.189 = load i32, i32* %.188
  ret i32 %.189 
.127wc33:
  %.131 = load i32, i32* %.116
  %.132 = load i32, i32* %.107
  %.133 = icmp sle i32 %.131, %.132
  br i1 %.133, label %.128wloop.33.40, label %.129wn40
.128wloop.33.40:
  %.137 = load i32, i32* %.115
  %.138 = sub i32 %.137, 1
  %.139 = load i32*, i32** %.98
  %.140 = getelementptr inbounds i32, i32* %.139, i32 %.138
  %.141 = load i32, i32* %.140
  %.142 = load i32, i32* %.116
  %.143 = sub i32 %.142, 1
  %.144 = load i32*, i32** %.104
  %.145 = getelementptr inbounds i32, i32* %.144, i32 %.143
  %.146 = load i32, i32* %.145
  %.147 = icmp eq i32 %.141, %.146
  br i1 %.147, label %.135, label %.136
.129wn40:
  %.182 = load i32, i32* %.115
  %.183 = add i32 %.182, 1
  store i32 %.183, i32* %.115
  br label %.118wc31 
.135:
  %.149 = load i32, i32* %.115
  %.150 = sub i32 %.149, 1
  %.151 = load i32, i32* %.116
  %.152 = sub i32 %.151, 1
  %.153 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.150, i32 %.152
  %.154 = load i32, i32* %.153
  %.155 = add i32 %.154, 1
  %.156 = load i32, i32* %.115
  %.157 = load i32, i32* %.116
  %.158 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.156, i32 %.157
  store i32 %.155, i32* %.158
  br label %.160 
.136:
  %.162 = load i32, i32* %.115
  %.163 = sub i32 %.162, 1
  %.164 = load i32, i32* %.116
  %.165 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.163, i32 %.164
  %.166 = load i32, i32* %.165
  %.167 = load i32, i32* %.115
  %.168 = load i32, i32* %.116
  %.169 = sub i32 %.168, 1
  %.170 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.167, i32 %.169
  %.171 = load i32, i32* %.170
  %.172at37 = call i32 @MAX(i32 %.166, i32 %.171)
  %.173 = load i32, i32* %.115
  %.174 = load i32, i32* %.116
  %.175 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.173, i32 %.174
  store i32 %.172at37, i32* %.175
  br label %.160 
.160:
  %.178 = load i32, i32* %.116
  %.179 = add i32 %.178, 1
  store i32 %.179, i32* %.116
  br label %.127wc33 
}
define i32 @main(){
.192:
  %.213 = alloca i32
  %.212 = alloca i32
  %.205 = alloca [13 x i32]
  %.194 = alloca [15 x i32]
  call void @llvm.memcpy.p0.p0.i32([15 x i32]* %.194, [15 x i32]* @__constant..201, i32 60, i1 false)
  call void @llvm.memcpy.p0.p0.i32([13 x i32]* %.205, [13 x i32]* @__constant..209, i32 52, i1 false)
  %.214 = getelementptr inbounds [15 x i32], [15 x i32]* %.194, i32 0, i32 0
  %.215at52 = call i32 @max_sum_nonadjacent(i32* %.214, i32 15)
  call void @putint(i32 %.215at52)
  call void @putch(i32 10)
  %.221 = getelementptr inbounds [15 x i32], [15 x i32]* %.194, i32 0, i32 0
  %.222 = getelementptr inbounds [13 x i32], [13 x i32]* %.205, i32 0, i32 0
  %.223at55 = call i32 @longest_common_subseq(i32* %.221, i32 15, i32* %.222, i32 13)
  call void @putint(i32 %.223at55)
  call void @putch(i32 10)
  ret i32 0 
}
@__constant..37 = constant [16 x i32] zeroinitializer
@__constant..112 = constant [16 x [16 x i32]] zeroinitializer
@__constant..201 = constant [15 x i32]  [i32 8, i32 7, i32 4, i32 1, i32 2, i32 7, i32 0, i32 1, i32 9, i32 3, i32 4, i32 8, i32 3, i32 7, i32 0]
@__constant..209 = constant [13 x i32]  [i32 3, i32 9, i32 7, i32 1, i32 4, i32 2, i32 4, i32 3, i32 6, i32 8, i32 0, i32 1, i32 5]
define i32 @MAX(i32 %.3, i32 %.6){
.1:
  %.5 = alloca i32
  %.2 = alloca i32
  store i32 %.3, i32* %.2
  store i32 %.6, i32* %.5
  %.10 = load i32, i32* %.2
  %.11 = load i32, i32* %.5
  %.12 = icmp eq i32 %.10, %.11
  br i1 %.12, label %.8, label %.9
.8:
  %.14 = load i32, i32* %.2
  ret i32 %.14 
.9:
  %.18 = load i32, i32* %.2
  %.19 = load i32, i32* %.5
  %.20 = icmp sgt i32 %.18, %.19
  br i1 %.20, label %.16, label %.17
.16:
  %.22 = load i32, i32* %.2
  ret i32 %.22 
.17:
  %.24 = load i32, i32* %.5
  ret i32 %.24 
}
define i32 @max_sum_nonadjacent(i32* %.29, i32 %.32){
.27:
  %.59 = alloca i32
  %.35 = alloca [16 x i32]
  %.31 = alloca i32
  %.28 = alloca i32*
  store i32* %.29, i32** %.28
  store i32 %.32, i32* %.31
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.35, [16 x i32]* @__constant..37, i32 64, i1 false)
  %.44 = load i32*, i32** %.28
  %.45 = getelementptr inbounds i32, i32* %.44, i32 0
  %.46 = load i32, i32* %.45
  %.47 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 0
  store i32 %.46, i32* %.47
  %.49 = load i32*, i32** %.28
  %.50 = getelementptr inbounds i32, i32* %.49, i32 0
  %.51 = load i32, i32* %.50
  %.53 = load i32*, i32** %.28
  %.54 = getelementptr inbounds i32, i32* %.53, i32 1
  %.55 = load i32, i32* %.54
  %.56at16 = call i32 @MAX(i32 %.51, i32 %.55)
  %.57 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 1
  store i32 %.56at16, i32* %.57
  store i32 2, i32* %.59
  br label %.62wc18 
.62wc18:
  %.66 = load i32, i32* %.59
  %.67 = load i32, i32* %.31
  %.68 = icmp slt i32 %.66, %.67
  br i1 %.68, label %.63wloop.18.21, label %.64wn21
.63wloop.18.21:
  %.70 = load i32, i32* %.59
  %.71 = sub i32 %.70, 2
  %.72 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 %.71
  %.73 = load i32, i32* %.72
  %.74 = load i32, i32* %.59
  %.75 = load i32*, i32** %.28
  %.76 = getelementptr inbounds i32, i32* %.75, i32 %.74
  %.77 = load i32, i32* %.76
  %.78 = add i32 %.73, %.77
  %.79 = load i32, i32* %.59
  %.80 = sub i32 %.79, 1
  %.81 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 %.80
  %.82 = load i32, i32* %.81
  %.83at19 = call i32 @MAX(i32 %.78, i32 %.82)
  %.84 = load i32, i32* %.59
  %.85 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 %.84
  store i32 %.83at19, i32* %.85
  %.87 = load i32, i32* %.59
  %.88 = add i32 %.87, 1
  store i32 %.88, i32* %.59
  br label %.62wc18 
.64wn21:
  %.91 = load i32, i32* %.31
  %.92 = sub i32 %.91, 1
  %.93 = getelementptr inbounds [16 x i32], [16 x i32]* %.35, i32 0, i32 %.92
  %.94 = load i32, i32* %.93
  ret i32 %.94 
}
define i32 @longest_common_subseq(i32* %.99, i32 %.102, i32* %.105, i32 %.108){
.97:
  %.116 = alloca i32
  %.115 = alloca i32
  %.110 = alloca [16 x [16 x i32]]
  %.107 = alloca i32
  %.104 = alloca i32*
  %.101 = alloca i32
  %.98 = alloca i32*
  store i32* %.99, i32** %.98
  store i32 %.102, i32* %.101
  store i32* %.105, i32** %.104
  store i32 %.108, i32* %.107
  call void @llvm.memcpy.p0.p0.i32([16 x [16 x i32]]* %.110, [16 x [16 x i32]]* @__constant..112, i32 1024, i1 false)
  store i32 1, i32* %.115
  br label %.118wc31 
.118wc31:
  %.122 = load i32, i32* %.115
  %.123 = load i32, i32* %.101
  %.124 = icmp sle i32 %.122, %.123
  br i1 %.124, label %.119wloop.31.42, label %.120wn42
.119wloop.31.42:
  store i32 1, i32* %.116
  br label %.127wc33 
.120wn42:
  %.186 = load i32, i32* %.101
  %.187 = load i32, i32* %.107
  %.188 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.186, i32 %.187
  %.189 = load i32, i32* %.188
  ret i32 %.189 
.127wc33:
  %.131 = load i32, i32* %.116
  %.132 = load i32, i32* %.107
  %.133 = icmp sle i32 %.131, %.132
  br i1 %.133, label %.128wloop.33.40, label %.129wn40
.128wloop.33.40:
  %.137 = load i32, i32* %.115
  %.138 = sub i32 %.137, 1
  %.139 = load i32*, i32** %.98
  %.140 = getelementptr inbounds i32, i32* %.139, i32 %.138
  %.141 = load i32, i32* %.140
  %.142 = load i32, i32* %.116
  %.143 = sub i32 %.142, 1
  %.144 = load i32*, i32** %.104
  %.145 = getelementptr inbounds i32, i32* %.144, i32 %.143
  %.146 = load i32, i32* %.145
  %.147 = icmp eq i32 %.141, %.146
  br i1 %.147, label %.135, label %.136
.129wn40:
  %.182 = load i32, i32* %.115
  %.183 = add i32 %.182, 1
  store i32 %.183, i32* %.115
  br label %.118wc31 
.135:
  %.149 = load i32, i32* %.115
  %.150 = sub i32 %.149, 1
  %.151 = load i32, i32* %.116
  %.152 = sub i32 %.151, 1
  %.153 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.150, i32 %.152
  %.154 = load i32, i32* %.153
  %.155 = add i32 %.154, 1
  %.156 = load i32, i32* %.115
  %.157 = load i32, i32* %.116
  %.158 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.156, i32 %.157
  store i32 %.155, i32* %.158
  br label %.160 
.136:
  %.162 = load i32, i32* %.115
  %.163 = sub i32 %.162, 1
  %.164 = load i32, i32* %.116
  %.165 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.163, i32 %.164
  %.166 = load i32, i32* %.165
  %.167 = load i32, i32* %.115
  %.168 = load i32, i32* %.116
  %.169 = sub i32 %.168, 1
  %.170 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.167, i32 %.169
  %.171 = load i32, i32* %.170
  %.172at37 = call i32 @MAX(i32 %.166, i32 %.171)
  %.173 = load i32, i32* %.115
  %.174 = load i32, i32* %.116
  %.175 = getelementptr inbounds [16 x [16 x i32]], [16 x [16 x i32]]* %.110, i32 0, i32 %.173, i32 %.174
  store i32 %.172at37, i32* %.175
  br label %.160 
.160:
  %.178 = load i32, i32* %.116
  %.179 = add i32 %.178, 1
  store i32 %.179, i32* %.116
  br label %.127wc33 
}
define i32 @main(){
.192:
  %.213 = alloca i32
  %.212 = alloca i32
  %.205 = alloca [13 x i32]
  %.194 = alloca [15 x i32]
  call void @llvm.memcpy.p0.p0.i32([15 x i32]* %.194, [15 x i32]* @__constant..201, i32 60, i1 false)
  call void @llvm.memcpy.p0.p0.i32([13 x i32]* %.205, [13 x i32]* @__constant..209, i32 52, i1 false)
  %.214 = getelementptr inbounds [15 x i32], [15 x i32]* %.194, i32 0, i32 0
  %.215at52 = call i32 @max_sum_nonadjacent(i32* %.214, i32 15)
  call void @putint(i32 %.215at52)
  call void @putch(i32 10)
  %.221 = getelementptr inbounds [15 x i32], [15 x i32]* %.194, i32 0, i32 0
  %.222 = getelementptr inbounds [13 x i32], [13 x i32]* %.205, i32 0, i32 0
  %.223at55 = call i32 @longest_common_subseq(i32* %.221, i32 15, i32* %.222, i32 13)
  call void @putint(i32 %