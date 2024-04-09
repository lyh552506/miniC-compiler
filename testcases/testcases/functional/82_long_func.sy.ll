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
@.g.SHIFT_TABLE = global [16 x i32]  [i32 1, i32 2, i32 4, i32 8, i32 16, i32 32, i32 64, i32 128, i32 256, i32 512, i32 1024, i32 2048, i32 4096, i32 8192, i32 16384, i32 32768]
define i32 @long_func(){
.19:
  %.4172 = alloca i32
  %.4169 = alloca i32
  %.4166 = alloca i32
  %.3991 = alloca i32
  %.3988 = alloca i32
  %.3985 = alloca i32
  %.3930 = alloca i32
  %.3927 = alloca i32
  %.3924 = alloca i32
  %.3682 = alloca i32
  %.3679 = alloca i32
  %.3676 = alloca i32
  %.3501 = alloca i32
  %.3498 = alloca i32
  %.3495 = alloca i32
  %.3440 = alloca i32
  %.3437 = alloca i32
  %.3434 = alloca i32
  %.3379 = alloca i32
  %.3376 = alloca i32
  %.3374 = alloca i32
  %.3053 = alloca i32
  %.3050 = alloca i32
  %.3047 = alloca i32
  %.2872 = alloca i32
  %.2869 = alloca i32
  %.2866 = alloca i32
  %.2811 = alloca i32
  %.2808 = alloca i32
  %.2805 = alloca i32
  %.2563 = alloca i32
  %.2560 = alloca i32
  %.2557 = alloca i32
  %.2382 = alloca i32
  %.2379 = alloca i32
  %.2376 = alloca i32
  %.2321 = alloca i32
  %.2318 = alloca i32
  %.2315 = alloca i32
  %.2260 = alloca i32
  %.2257 = alloca i32
  %.2255 = alloca i32
  %.1938 = alloca i32
  %.1935 = alloca i32
  %.1932 = alloca i32
  %.1757 = alloca i32
  %.1754 = alloca i32
  %.1751 = alloca i32
  %.1696 = alloca i32
  %.1693 = alloca i32
  %.1690 = alloca i32
  %.1448 = alloca i32
  %.1445 = alloca i32
  %.1442 = alloca i32
  %.1267 = alloca i32
  %.1264 = alloca i32
  %.1261 = alloca i32
  %.1206 = alloca i32
  %.1203 = alloca i32
  %.1200 = alloca i32
  %.1145 = alloca i32
  %.1143 = alloca i32
  %.1141 = alloca i32
  %.829 = alloca i32
  %.826 = alloca i32
  %.823 = alloca i32
  %.648 = alloca i32
  %.645 = alloca i32
  %.642 = alloca i32
  %.587 = alloca i32
  %.584 = alloca i32
  %.581 = alloca i32
  %.337 = alloca i32
  %.334 = alloca i32
  %.331 = alloca i32
  %.152 = alloca i32
  %.149 = alloca i32
  %.146 = alloca i32
  %.91 = alloca i32
  %.88 = alloca i32
  %.85 = alloca i32
  %.30 = alloca i32
  %.27 = alloca i32
  %.25 = alloca i32
  %.24 = alloca i32
  %.23 = alloca i32
  %.22 = alloca i32
  %.21 = alloca i32
  %.20 = alloca i32
  store i32 2, i32* %.25
  store i32 0, i32* %.27
  store i32 1, i32* %.30
  br label %.32wc8 
.32wc8:
  %.36 = load i32, i32* %.27
  %.37 = icmp sgt i32 %.36, 0
  br i1 %.37, label %.33wloop.8.342, label %.34wn342
.33wloop.8.342:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.41 = load i32, i32* %.27
  store i32 %.41, i32* %.22
  store i32 1, i32* %.23
  br label %.44wc13 
.34wn342:
  %.1133 = load i32, i32* %.30
  store i32 %.1133, i32* %.20
  %.1135 = load i32, i32* %.20
  call void @putint(i32 %.1135)
  call void @putch(i32 10)
  store i32 2, i32* %.1141
  store i32 1, i32* %.1143
  store i32 1, i32* %.1145
  br label %.1147wc349 
.44wc13:
  %.48 = load i32, i32* %.21
  %.49 = icmp slt i32 %.48, 16
  br i1 %.49, label %.45wloop.13.20, label %.46wn20
.45wloop.13.20:
  %.53 = load i32, i32* %.22
  %.54 = srem i32 %.53, 2
  %.55 = icmp ne i32 %.54, 0
  br i1 %.55, label %.56, label %.52
.46wn20:
  %.82 = load i32, i32* %.20
  %.83 = icmp ne i32 %.82, 0
  br i1 %.83, label %.80, label %.81
.51:
  %.62 = load i32, i32* %.20
  %.63 = load i32, i32* %.21
  %.64 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.63
  %.65 = load i32, i32* %.64
  %.66 = mul i32 1, %.65
  %.67 = add i32 %.62, %.66
  store i32 %.67, i32* %.20
  br label %.52 
.52:
  %.70 = load i32, i32* %.22
  %.71 = sdiv i32 %.70, 2
  store i32 %.71, i32* %.22
  %.73 = load i32, i32* %.23
  %.74 = sdiv i32 %.73, 2
  store i32 %.74, i32* %.23
  %.76 = load i32, i32* %.21
  %.77 = add i32 %.76, 1
  store i32 %.77, i32* %.21
  br label %.44wc13 
.56:
  %.58 = load i32, i32* %.23
  %.59 = srem i32 %.58, 2
  %.60 = icmp ne i32 %.59, 0
  br i1 %.60, label %.51, label %.52
.80:
  %.86 = load i32, i32* %.30
  store i32 %.86, i32* %.85
  %.89 = load i32, i32* %.25
  store i32 %.89, i32* %.88
  store i32 0, i32* %.91
  br label %.93wc24 
.81:
  %.582 = load i32, i32* %.25
  store i32 %.582, i32* %.581
  %.585 = load i32, i32* %.25
  store i32 %.585, i32* %.584
  store i32 0, i32* %.587
  br label %.589wc175 
.93wc24:
  %.97 = load i32, i32* %.88
  %.98 = icmp ne i32 %.97, 0
  br i1 %.98, label %.94wloop.24.168, label %.95wn168
.94wloop.24.168:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.102 = load i32, i32* %.88
  store i32 %.102, i32* %.22
  store i32 1, i32* %.23
  br label %.105wc29 
.95wn168:
  %.576 = load i32, i32* %.91
  store i32 %.576, i32* %.20
  %.578 = load i32, i32* %.20
  store i32 %.578, i32* %.30
  br label %.81 
.105wc29:
  %.109 = load i32, i32* %.21
  %.110 = icmp slt i32 %.109, 16
  br i1 %.110, label %.106wloop.29.36, label %.107wn36
.106wloop.29.36:
  %.114 = load i32, i32* %.22
  %.115 = srem i32 %.114, 2
  %.116 = icmp ne i32 %.115, 0
  br i1 %.116, label %.117, label %.113
.107wn36:
  %.143 = load i32, i32* %.20
  %.144 = icmp ne i32 %.143, 0
  br i1 %.144, label %.141, label %.142
.112:
  %.123 = load i32, i32* %.20
  %.124 = load i32, i32* %.21
  %.125 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.124
  %.126 = load i32, i32* %.125
  %.127 = mul i32 1, %.126
  %.128 = add i32 %.123, %.127
  store i32 %.128, i32* %.20
  br label %.113 
.113:
  %.131 = load i32, i32* %.22
  %.132 = sdiv i32 %.131, 2
  store i32 %.132, i32* %.22
  %.134 = load i32, i32* %.23
  %.135 = sdiv i32 %.134, 2
  store i32 %.135, i32* %.23
  %.137 = load i32, i32* %.21
  %.138 = add i32 %.137, 1
  store i32 %.138, i32* %.21
  br label %.105wc29 
.117:
  %.119 = load i32, i32* %.23
  %.120 = srem i32 %.119, 2
  %.121 = icmp ne i32 %.120, 0
  br i1 %.121, label %.112, label %.113
.141:
  %.147 = load i32, i32* %.91
  store i32 %.147, i32* %.146
  %.150 = load i32, i32* %.85
  store i32 %.150, i32* %.149
  br label %.153wc40 
.142:
  %.332 = load i32, i32* %.85
  store i32 %.332, i32* %.331
  %.335 = load i32, i32* %.85
  store i32 %.335, i32* %.334
  br label %.338wc96 
.153wc40:
  %.157 = load i32, i32* %.149
  %.158 = icmp ne i32 %.157, 0
  br i1 %.158, label %.154wloop.40.89, label %.155wn89
.154wloop.40.89:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.162 = load i32, i32* %.146
  store i32 %.162, i32* %.22
  %.164 = load i32, i32* %.149
  store i32 %.164, i32* %.23
  br label %.166wc45 
.155wn89:
  %.326 = load i32, i32* %.146
  store i32 %.326, i32* %.20
  %.328 = load i32, i32* %.20
  store i32 %.328, i32* %.91
  br label %.142 
.166wc45:
  %.170 = load i32, i32* %.21
  %.171 = icmp slt i32 %.170, 16
  br i1 %.171, label %.167wloop.45.56, label %.168wn56
.167wloop.45.56:
  %.175 = load i32, i32* %.22
  %.176 = srem i32 %.175, 2
  %.177 = icmp ne i32 %.176, 0
  br i1 %.177, label %.173, label %.174
.168wn56:
  %.220 = load i32, i32* %.20
  store i32 %.220, i32* %.152
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.224 = load i32, i32* %.146
  store i32 %.224, i32* %.22
  %.226 = load i32, i32* %.149
  store i32 %.226, i32* %.23
  br label %.228wc62 
.173:
  %.181 = load i32, i32* %.23
  %.182 = srem i32 %.181, 2
  %.183 = icmp eq i32 %.182, 0
  br i1 %.183, label %.179, label %.180
.174:
  %.197 = load i32, i32* %.23
  %.198 = srem i32 %.197, 2
  %.199 = icmp ne i32 %.198, 0
  br i1 %.199, label %.195, label %.196
.179:
  %.185 = load i32, i32* %.20
  %.186 = load i32, i32* %.21
  %.187 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.186
  %.188 = load i32, i32* %.187
  %.189 = mul i32 1, %.188
  %.190 = add i32 %.185, %.189
  store i32 %.190, i32* %.20
  br label %.180 
.180:
  br label %.193 
.193:
  %.210 = load i32, i32* %.22
  %.211 = sdiv i32 %.210, 2
  store i32 %.211, i32* %.22
  %.213 = load i32, i32* %.23
  %.214 = sdiv i32 %.213, 2
  store i32 %.214, i32* %.23
  %.216 = load i32, i32* %.21
  %.217 = add i32 %.216, 1
  store i32 %.217, i32* %.21
  br label %.166wc45 
.195:
  %.201 = load i32, i32* %.20
  %.202 = load i32, i32* %.21
  %.203 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.202
  %.204 = load i32, i32* %.203
  %.205 = mul i32 1, %.204
  %.206 = add i32 %.201, %.205
  store i32 %.206, i32* %.20
  br label %.196 
.196:
  br label %.193 
.228wc62:
  %.232 = load i32, i32* %.21
  %.233 = icmp slt i32 %.232, 16
  br i1 %.233, label %.229wloop.62.69, label %.230wn69
.229wloop.62.69:
  %.237 = load i32, i32* %.22
  %.238 = srem i32 %.237, 2
  %.239 = icmp ne i32 %.238, 0
  br i1 %.239, label %.240, label %.236
.230wn69:
  %.264 = load i32, i32* %.20
  store i32 %.264, i32* %.149
  br label %.267 
.235:
  %.246 = load i32, i32* %.20
  %.247 = load i32, i32* %.21
  %.248 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.247
  %.249 = load i32, i32* %.248
  %.250 = mul i32 1, %.249
  %.251 = add i32 %.246, %.250
  store i32 %.251, i32* %.20
  br label %.236 
.236:
  %.254 = load i32, i32* %.22
  %.255 = sdiv i32 %.254, 2
  store i32 %.255, i32* %.22
  %.257 = load i32, i32* %.23
  %.258 = sdiv i32 %.257, 2
  store i32 %.258, i32* %.23
  %.260 = load i32, i32* %.21
  %.261 = add i32 %.260, 1
  store i32 %.261, i32* %.21
  br label %.228wc62 
.240:
  %.242 = load i32, i32* %.23
  %.243 = srem i32 %.242, 2
  %.244 = icmp ne i32 %.243, 0
  br i1 %.244, label %.235, label %.236
.266:
  store i32 0, i32* %.20
  br label %.273 
.267:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.277 = load i32, i32* %.149
  %.278 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.279 = load i32, i32* %.278
  %.280 = mul i32 %.277, %.279
  store i32 %.280, i32* %.22
  store i32 65535, i32* %.23
  br label %.284wc78 
.273:
  %.321 = load i32, i32* %.20
  store i32 %.321, i32* %.149
  %.323 = load i32, i32* %.152
  store i32 %.323, i32* %.146
  br label %.153wc40 
.284wc78:
  %.288 = load i32, i32* %.21
  %.289 = icmp slt i32 %.288, 16
  br i1 %.289, label %.285wloop.78.85, label %.286wn85
.285wloop.78.85:
  %.293 = load i32, i32* %.22
  %.294 = srem i32 %.293, 2
  %.295 = icmp ne i32 %.294, 0
  br i1 %.295, label %.296, label %.292
.286wn85:
  br label %.273 
.291:
  %.302 = load i32, i32* %.20
  %.303 = load i32, i32* %.21
  %.304 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.303
  %.305 = load i32, i32* %.304
  %.306 = mul i32 1, %.305
  %.307 = add i32 %.302, %.306
  store i32 %.307, i32* %.20
  br label %.292 
.292:
  %.310 = load i32, i32* %.22
  %.311 = sdiv i32 %.310, 2
  store i32 %.311, i32* %.22
  %.313 = load i32, i32* %.23
  %.314 = sdiv i32 %.313, 2
  store i32 %.314, i32* %.23
  %.316 = load i32, i32* %.21
  %.317 = add i32 %.316, 1
  store i32 %.317, i32* %.21
  br label %.284wc78 
.296:
  %.298 = load i32, i32* %.23
  %.299 = srem i32 %.298, 2
  %.300 = icmp ne i32 %.299, 0
  br i1 %.300, label %.291, label %.292
.338wc96:
  %.342 = load i32, i32* %.334
  %.343 = icmp ne i32 %.342, 0
  br i1 %.343, label %.339wloop.96.145, label %.340wn145
.339wloop.96.145:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.347 = load i32, i32* %.331
  store i32 %.347, i32* %.22
  %.349 = load i32, i32* %.334
  store i32 %.349, i32* %.23
  br label %.351wc101 
.340wn145:
  %.507 = load i32, i32* %.331
  store i32 %.507, i32* %.20
  %.509 = load i32, i32* %.20
  store i32 %.509, i32* %.85
  %.511 = load i32, i32* %.88
  store i32 %.511, i32* %.22
  store i32 1, i32* %.23
  %.516 = load i32, i32* %.23
  %.517 = icmp sge i32 %.516, 15
  br i1 %.517, label %.514, label %.515
.351wc101:
  %.355 = load i32, i32* %.21
  %.356 = icmp slt i32 %.355, 16
  br i1 %.356, label %.352wloop.101.112, label %.353wn112
.352wloop.101.112:
  %.360 = load i32, i32* %.22
  %.361 = srem i32 %.360, 2
  %.362 = icmp ne i32 %.361, 0
  br i1 %.362, label %.358, label %.359
.353wn112:
  %.405 = load i32, i32* %.20
  store i32 %.405, i32* %.337
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.409 = load i32, i32* %.331
  store i32 %.409, i32* %.22
  %.411 = load i32, i32* %.334
  store i32 %.411, i32* %.23
  br label %.413wc118 
.358:
  %.366 = load i32, i32* %.23
  %.367 = srem i32 %.366, 2
  %.368 = icmp eq i32 %.367, 0
  br i1 %.368, label %.364, label %.365
.359:
  %.382 = load i32, i32* %.23
  %.383 = srem i32 %.382, 2
  %.384 = icmp ne i32 %.383, 0
  br i1 %.384, label %.380, label %.381
.364:
  %.370 = load i32, i32* %.20
  %.371 = load i32, i32* %.21
  %.372 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.371
  %.373 = load i32, i32* %.372
  %.374 = mul i32 1, %.373
  %.375 = add i32 %.370, %.374
  store i32 %.375, i32* %.20
  br label %.365 
.365:
  br label %.378 
.378:
  %.395 = load i32, i32* %.22
  %.396 = sdiv i32 %.395, 2
  store i32 %.396, i32* %.22
  %.398 = load i32, i32* %.23
  %.399 = sdiv i32 %.398, 2
  store i32 %.399, i32* %.23
  %.401 = load i32, i32* %.21
  %.402 = add i32 %.401, 1
  store i32 %.402, i32* %.21
  br label %.351wc101 
.380:
  %.386 = load i32, i32* %.20
  %.387 = load i32, i32* %.21
  %.388 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.387
  %.389 = load i32, i32* %.388
  %.390 = mul i32 1, %.389
  %.391 = add i32 %.386, %.390
  store i32 %.391, i32* %.20
  br label %.381 
.381:
  br label %.378 
.413wc118:
  %.417 = load i32, i32* %.21
  %.418 = icmp slt i32 %.417, 16
  br i1 %.418, label %.414wloop.118.125, label %.415wn125
.414wloop.118.125:
  %.422 = load i32, i32* %.22
  %.423 = srem i32 %.422, 2
  %.424 = icmp ne i32 %.423, 0
  br i1 %.424, label %.425, label %.421
.415wn125:
  %.449 = load i32, i32* %.20
  store i32 %.449, i32* %.334
  br label %.452 
.420:
  %.431 = load i32, i32* %.20
  %.432 = load i32, i32* %.21
  %.433 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.432
  %.434 = load i32, i32* %.433
  %.435 = mul i32 1, %.434
  %.436 = add i32 %.431, %.435
  store i32 %.436, i32* %.20
  br label %.421 
.421:
  %.439 = load i32, i32* %.22
  %.440 = sdiv i32 %.439, 2
  store i32 %.440, i32* %.22
  %.442 = load i32, i32* %.23
  %.443 = sdiv i32 %.442, 2
  store i32 %.443, i32* %.23
  %.445 = load i32, i32* %.21
  %.446 = add i32 %.445, 1
  store i32 %.446, i32* %.21
  br label %.413wc118 
.425:
  %.427 = load i32, i32* %.23
  %.428 = srem i32 %.427, 2
  %.429 = icmp ne i32 %.428, 0
  br i1 %.429, label %.420, label %.421
.451:
  store i32 0, i32* %.20
  br label %.455 
.452:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.459 = load i32, i32* %.334
  %.460 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.461 = load i32, i32* %.460
  %.462 = mul i32 %.459, %.461
  store i32 %.462, i32* %.22
  store i32 65535, i32* %.23
  br label %.465wc134 
.455:
  %.502 = load i32, i32* %.20
  store i32 %.502, i32* %.334
  %.504 = load i32, i32* %.337
  store i32 %.504, i32* %.331
  br label %.338wc96 
.465wc134:
  %.469 = load i32, i32* %.21
  %.470 = icmp slt i32 %.469, 16
  br i1 %.470, label %.466wloop.134.141, label %.467wn141
.466wloop.134.141:
  %.474 = load i32, i32* %.22
  %.475 = srem i32 %.474, 2
  %.476 = icmp ne i32 %.475, 0
  br i1 %.476, label %.477, label %.473
.467wn141:
  br label %.455 
.472:
  %.483 = load i32, i32* %.20
  %.484 = load i32, i32* %.21
  %.485 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.484
  %.486 = load i32, i32* %.485
  %.487 = mul i32 1, %.486
  %.488 = add i32 %.483, %.487
  store i32 %.488, i32* %.20
  br label %.473 
.473:
  %.491 = load i32, i32* %.22
  %.492 = sdiv i32 %.491, 2
  store i32 %.492, i32* %.22
  %.494 = load i32, i32* %.23
  %.495 = sdiv i32 %.494, 2
  store i32 %.495, i32* %.23
  %.497 = load i32, i32* %.21
  %.498 = add i32 %.497, 1
  store i32 %.498, i32* %.21
  br label %.465wc134 
.477:
  %.479 = load i32, i32* %.23
  %.480 = srem i32 %.479, 2
  %.481 = icmp ne i32 %.480, 0
  br i1 %.481, label %.472, label %.473
.514:
  %.521 = load i32, i32* %.22
  %.522 = icmp slt i32 %.521, 0
  br i1 %.522, label %.519, label %.520
.515:
  %.533 = load i32, i32* %.23
  %.534 = icmp sgt i32 %.533, 0
  br i1 %.534, label %.531, label %.532
.519:
  store i32 65535, i32* %.20
  br label %.525 
.520:
  store i32 0, i32* %.20
  br label %.525 
.525:
  br label %.529 
.529:
  %.573 = load i32, i32* %.20
  store i32 %.573, i32* %.88
  br label %.93wc24 
.531:
  %.538 = load i32, i32* %.22
  %.540 = icmp sgt i32 %.538, 32767
  br i1 %.540, label %.536, label %.537
.532:
  %.569 = load i32, i32* %.22
  store i32 %.569, i32* %.20
  br label %.567 
.536:
  %.542 = load i32, i32* %.22
  %.543 = load i32, i32* %.23
  %.544 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.543
  %.545 = load i32, i32* %.544
  %.546 = sdiv i32 %.542, %.545
  store i32 %.546, i32* %.22
  %.548 = load i32, i32* %.22
  %.550 = add i32 %.548, 65536
  %.551 = load i32, i32* %.23
  %.552 = sub i32 15, %.551
  %.553 = add i32 %.552, 1
  %.554 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.553
  %.555 = load i32, i32* %.554
  %.556 = sub i32 %.550, %.555
  store i32 %.556, i32* %.20
  br label %.558 
.537:
  %.560 = load i32, i32* %.22
  %.561 = load i32, i32* %.23
  %.562 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.561
  %.563 = load i32, i32* %.562
  %.564 = sdiv i32 %.560, %.563
  store i32 %.564, i32* %.20
  br label %.558 
.558:
  br label %.567 
.567:
  br label %.529 
.589wc175:
  %.593 = load i32, i32* %.584
  %.594 = icmp ne i32 %.593, 0
  br i1 %.594, label %.590wloop.175.319, label %.591wn319
.590wloop.175.319:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.598 = load i32, i32* %.584
  store i32 %.598, i32* %.22
  store i32 1, i32* %.23
  br label %.601wc180 
.591wn319:
  %.1066 = load i32, i32* %.587
  store i32 %.1066, i32* %.20
  %.1068 = load i32, i32* %.20
  store i32 %.1068, i32* %.25
  %.1070 = load i32, i32* %.27
  store i32 %.1070, i32* %.22
  store i32 1, i32* %.23
  %.1075 = load i32, i32* %.23
  %.1076 = icmp sge i32 %.1075, 15
  br i1 %.1076, label %.1073, label %.1074
.601wc180:
  %.605 = load i32, i32* %.21
  %.606 = icmp slt i32 %.605, 16
  br i1 %.606, label %.602wloop.180.187, label %.603wn187
.602wloop.180.187:
  %.610 = load i32, i32* %.22
  %.611 = srem i32 %.610, 2
  %.612 = icmp ne i32 %.611, 0
  br i1 %.612, label %.613, label %.609
.603wn187:
  %.639 = load i32, i32* %.20
  %.640 = icmp ne i32 %.639, 0
  br i1 %.640, label %.637, label %.638
.608:
  %.619 = load i32, i32* %.20
  %.620 = load i32, i32* %.21
  %.621 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.620
  %.622 = load i32, i32* %.621
  %.623 = mul i32 1, %.622
  %.624 = add i32 %.619, %.623
  store i32 %.624, i32* %.20
  br label %.609 
.609:
  %.627 = load i32, i32* %.22
  %.628 = sdiv i32 %.627, 2
  store i32 %.628, i32* %.22
  %.630 = load i32, i32* %.23
  %.631 = sdiv i32 %.630, 2
  store i32 %.631, i32* %.23
  %.633 = load i32, i32* %.21
  %.634 = add i32 %.633, 1
  store i32 %.634, i32* %.21
  br label %.601wc180 
.613:
  %.615 = load i32, i32* %.23
  %.616 = srem i32 %.615, 2
  %.617 = icmp ne i32 %.616, 0
  br i1 %.617, label %.608, label %.609
.637:
  %.643 = load i32, i32* %.587
  store i32 %.643, i32* %.642
  %.646 = load i32, i32* %.581
  store i32 %.646, i32* %.645
  br label %.649wc191 
.638:
  %.824 = load i32, i32* %.581
  store i32 %.824, i32* %.823
  %.827 = load i32, i32* %.581
  store i32 %.827, i32* %.826
  br label %.830wc247 
.649wc191:
  %.653 = load i32, i32* %.645
  %.654 = icmp ne i32 %.653, 0
  br i1 %.654, label %.650wloop.191.240, label %.651wn240
.650wloop.191.240:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.658 = load i32, i32* %.642
  store i32 %.658, i32* %.22
  %.660 = load i32, i32* %.645
  store i32 %.660, i32* %.23
  br label %.662wc196 
.651wn240:
  %.818 = load i32, i32* %.642
  store i32 %.818, i32* %.20
  %.820 = load i32, i32* %.20
  store i32 %.820, i32* %.587
  br label %.638 
.662wc196:
  %.666 = load i32, i32* %.21
  %.667 = icmp slt i32 %.666, 16
  br i1 %.667, label %.663wloop.196.207, label %.664wn207
.663wloop.196.207:
  %.671 = load i32, i32* %.22
  %.672 = srem i32 %.671, 2
  %.673 = icmp ne i32 %.672, 0
  br i1 %.673, label %.669, label %.670
.664wn207:
  %.716 = load i32, i32* %.20
  store i32 %.716, i32* %.648
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.720 = load i32, i32* %.642
  store i32 %.720, i32* %.22
  %.722 = load i32, i32* %.645
  store i32 %.722, i32* %.23
  br label %.724wc213 
.669:
  %.677 = load i32, i32* %.23
  %.678 = srem i32 %.677, 2
  %.679 = icmp eq i32 %.678, 0
  br i1 %.679, label %.675, label %.676
.670:
  %.693 = load i32, i32* %.23
  %.694 = srem i32 %.693, 2
  %.695 = icmp ne i32 %.694, 0
  br i1 %.695, label %.691, label %.692
.675:
  %.681 = load i32, i32* %.20
  %.682 = load i32, i32* %.21
  %.683 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.682
  %.684 = load i32, i32* %.683
  %.685 = mul i32 1, %.684
  %.686 = add i32 %.681, %.685
  store i32 %.686, i32* %.20
  br label %.676 
.676:
  br label %.689 
.689:
  %.706 = load i32, i32* %.22
  %.707 = sdiv i32 %.706, 2
  store i32 %.707, i32* %.22
  %.709 = load i32, i32* %.23
  %.710 = sdiv i32 %.709, 2
  store i32 %.710, i32* %.23
  %.712 = load i32, i32* %.21
  %.713 = add i32 %.712, 1
  store i32 %.713, i32* %.21
  br label %.662wc196 
.691:
  %.697 = load i32, i32* %.20
  %.698 = load i32, i32* %.21
  %.699 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.698
  %.700 = load i32, i32* %.699
  %.701 = mul i32 1, %.700
  %.702 = add i32 %.697, %.701
  store i32 %.702, i32* %.20
  br label %.692 
.692:
  br label %.689 
.724wc213:
  %.728 = load i32, i32* %.21
  %.729 = icmp slt i32 %.728, 16
  br i1 %.729, label %.725wloop.213.220, label %.726wn220
.725wloop.213.220:
  %.733 = load i32, i32* %.22
  %.734 = srem i32 %.733, 2
  %.735 = icmp ne i32 %.734, 0
  br i1 %.735, label %.736, label %.732
.726wn220:
  %.760 = load i32, i32* %.20
  store i32 %.760, i32* %.645
  br label %.763 
.731:
  %.742 = load i32, i32* %.20
  %.743 = load i32, i32* %.21
  %.744 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.743
  %.745 = load i32, i32* %.744
  %.746 = mul i32 1, %.745
  %.747 = add i32 %.742, %.746
  store i32 %.747, i32* %.20
  br label %.732 
.732:
  %.750 = load i32, i32* %.22
  %.751 = sdiv i32 %.750, 2
  store i32 %.751, i32* %.22
  %.753 = load i32, i32* %.23
  %.754 = sdiv i32 %.753, 2
  store i32 %.754, i32* %.23
  %.756 = load i32, i32* %.21
  %.757 = add i32 %.756, 1
  store i32 %.757, i32* %.21
  br label %.724wc213 
.736:
  %.738 = load i32, i32* %.23
  %.739 = srem i32 %.738, 2
  %.740 = icmp ne i32 %.739, 0
  br i1 %.740, label %.731, label %.732
.762:
  store i32 0, i32* %.20
  br label %.766 
.763:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.770 = load i32, i32* %.645
  %.771 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.772 = load i32, i32* %.771
  %.773 = mul i32 %.770, %.772
  store i32 %.773, i32* %.22
  store i32 65535, i32* %.23
  br label %.776wc229 
.766:
  %.813 = load i32, i32* %.20
  store i32 %.813, i32* %.645
  %.815 = load i32, i32* %.648
  store i32 %.815, i32* %.642
  br label %.649wc191 
.776wc229:
  %.780 = load i32, i32* %.21
  %.781 = icmp slt i32 %.780, 16
  br i1 %.781, label %.777wloop.229.236, label %.778wn236
.777wloop.229.236:
  %.785 = load i32, i32* %.22
  %.786 = srem i32 %.785, 2
  %.787 = icmp ne i32 %.786, 0
  br i1 %.787, label %.788, label %.784
.778wn236:
  br label %.766 
.783:
  %.794 = load i32, i32* %.20
  %.795 = load i32, i32* %.21
  %.796 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.795
  %.797 = load i32, i32* %.796
  %.798 = mul i32 1, %.797
  %.799 = add i32 %.794, %.798
  store i32 %.799, i32* %.20
  br label %.784 
.784:
  %.802 = load i32, i32* %.22
  %.803 = sdiv i32 %.802, 2
  store i32 %.803, i32* %.22
  %.805 = load i32, i32* %.23
  %.806 = sdiv i32 %.805, 2
  store i32 %.806, i32* %.23
  %.808 = load i32, i32* %.21
  %.809 = add i32 %.808, 1
  store i32 %.809, i32* %.21
  br label %.776wc229 
.788:
  %.790 = load i32, i32* %.23
  %.791 = srem i32 %.790, 2
  %.792 = icmp ne i32 %.791, 0
  br i1 %.792, label %.783, label %.784
.830wc247:
  %.834 = load i32, i32* %.826
  %.835 = icmp ne i32 %.834, 0
  br i1 %.835, label %.831wloop.247.296, label %.832wn296
.831wloop.247.296:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.839 = load i32, i32* %.823
  store i32 %.839, i32* %.22
  %.841 = load i32, i32* %.826
  store i32 %.841, i32* %.23
  br label %.843wc252 
.832wn296:
  %.999 = load i32, i32* %.823
  store i32 %.999, i32* %.20
  %.1001 = load i32, i32* %.20
  store i32 %.1001, i32* %.581
  %.1003 = load i32, i32* %.584
  store i32 %.1003, i32* %.22
  store i32 1, i32* %.23
  %.1008 = load i32, i32* %.23
  %.1009 = icmp sge i32 %.1008, 15
  br i1 %.1009, label %.1006, label %.1007
.843wc252:
  %.847 = load i32, i32* %.21
  %.848 = icmp slt i32 %.847, 16
  br i1 %.848, label %.844wloop.252.263, label %.845wn263
.844wloop.252.263:
  %.852 = load i32, i32* %.22
  %.853 = srem i32 %.852, 2
  %.854 = icmp ne i32 %.853, 0
  br i1 %.854, label %.850, label %.851
.845wn263:
  %.897 = load i32, i32* %.20
  store i32 %.897, i32* %.829
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.901 = load i32, i32* %.823
  store i32 %.901, i32* %.22
  %.903 = load i32, i32* %.826
  store i32 %.903, i32* %.23
  br label %.905wc269 
.850:
  %.858 = load i32, i32* %.23
  %.859 = srem i32 %.858, 2
  %.860 = icmp eq i32 %.859, 0
  br i1 %.860, label %.856, label %.857
.851:
  %.874 = load i32, i32* %.23
  %.875 = srem i32 %.874, 2
  %.876 = icmp ne i32 %.875, 0
  br i1 %.876, label %.872, label %.873
.856:
  %.862 = load i32, i32* %.20
  %.863 = load i32, i32* %.21
  %.864 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.863
  %.865 = load i32, i32* %.864
  %.866 = mul i32 1, %.865
  %.867 = add i32 %.862, %.866
  store i32 %.867, i32* %.20
  br label %.857 
.857:
  br label %.870 
.870:
  %.887 = load i32, i32* %.22
  %.888 = sdiv i32 %.887, 2
  store i32 %.888, i32* %.22
  %.890 = load i32, i32* %.23
  %.891 = sdiv i32 %.890, 2
  store i32 %.891, i32* %.23
  %.893 = load i32, i32* %.21
  %.894 = add i32 %.893, 1
  store i32 %.894, i32* %.21
  br label %.843wc252 
.872:
  %.878 = load i32, i32* %.20
  %.879 = load i32, i32* %.21
  %.880 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.879
  %.881 = load i32, i32* %.880
  %.882 = mul i32 1, %.881
  %.883 = add i32 %.878, %.882
  store i32 %.883, i32* %.20
  br label %.873 
.873:
  br label %.870 
.905wc269:
  %.909 = load i32, i32* %.21
  %.910 = icmp slt i32 %.909, 16
  br i1 %.910, label %.906wloop.269.276, label %.907wn276
.906wloop.269.276:
  %.914 = load i32, i32* %.22
  %.915 = srem i32 %.914, 2
  %.916 = icmp ne i32 %.915, 0
  br i1 %.916, label %.917, label %.913
.907wn276:
  %.941 = load i32, i32* %.20
  store i32 %.941, i32* %.826
  br label %.944 
.912:
  %.923 = load i32, i32* %.20
  %.924 = load i32, i32* %.21
  %.925 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.924
  %.926 = load i32, i32* %.925
  %.927 = mul i32 1, %.926
  %.928 = add i32 %.923, %.927
  store i32 %.928, i32* %.20
  br label %.913 
.913:
  %.931 = load i32, i32* %.22
  %.932 = sdiv i32 %.931, 2
  store i32 %.932, i32* %.22
  %.934 = load i32, i32* %.23
  %.935 = sdiv i32 %.934, 2
  store i32 %.935, i32* %.23
  %.937 = load i32, i32* %.21
  %.938 = add i32 %.937, 1
  store i32 %.938, i32* %.21
  br label %.905wc269 
.917:
  %.919 = load i32, i32* %.23
  %.920 = srem i32 %.919, 2
  %.921 = icmp ne i32 %.920, 0
  br i1 %.921, label %.912, label %.913
.943:
  store i32 0, i32* %.20
  br label %.947 
.944:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.951 = load i32, i32* %.826
  %.952 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.953 = load i32, i32* %.952
  %.954 = mul i32 %.951, %.953
  store i32 %.954, i32* %.22
  store i32 65535, i32* %.23
  br label %.957wc285 
.947:
  %.994 = load i32, i32* %.20
  store i32 %.994, i32* %.826
  %.996 = load i32, i32* %.829
  store i32 %.996, i32* %.823
  br label %.830wc247 
.957wc285:
  %.961 = load i32, i32* %.21
  %.962 = icmp slt i32 %.961, 16
  br i1 %.962, label %.958wloop.285.292, label %.959wn292
.958wloop.285.292:
  %.966 = load i32, i32* %.22
  %.967 = srem i32 %.966, 2
  %.968 = icmp ne i32 %.967, 0
  br i1 %.968, label %.969, label %.965
.959wn292:
  br label %.947 
.964:
  %.975 = load i32, i32* %.20
  %.976 = load i32, i32* %.21
  %.977 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.976
  %.978 = load i32, i32* %.977
  %.979 = mul i32 1, %.978
  %.980 = add i32 %.975, %.979
  store i32 %.980, i32* %.20
  br label %.965 
.965:
  %.983 = load i32, i32* %.22
  %.984 = sdiv i32 %.983, 2
  store i32 %.984, i32* %.22
  %.986 = load i32, i32* %.23
  %.987 = sdiv i32 %.986, 2
  store i32 %.987, i32* %.23
  %.989 = load i32, i32* %.21
  %.990 = add i32 %.989, 1
  store i32 %.990, i32* %.21
  br label %.957wc285 
.969:
  %.971 = load i32, i32* %.23
  %.972 = srem i32 %.971, 2
  %.973 = icmp ne i32 %.972, 0
  br i1 %.973, label %.964, label %.965
.1006:
  %.1013 = load i32, i32* %.22
  %.1014 = icmp slt i32 %.1013, 0
  br i1 %.1014, label %.1011, label %.1012
.1007:
  %.1025 = load i32, i32* %.23
  %.1026 = icmp sgt i32 %.1025, 0
  br i1 %.1026, label %.1023, label %.1024
.1011:
  store i32 65535, i32* %.20
  br label %.1017 
.1012:
  store i32 0, i32* %.20
  br label %.1017 
.1017:
  br label %.1021 
.1021:
  %.1063 = load i32, i32* %.20
  store i32 %.1063, i32* %.584
  br label %.589wc175 
.1023:
  %.1030 = load i32, i32* %.22
  %.1031 = icmp sgt i32 %.1030, 32767
  br i1 %.1031, label %.1028, label %.1029
.1024:
  %.1059 = load i32, i32* %.22
  store i32 %.1059, i32* %.20
  br label %.1057 
.1028:
  %.1033 = load i32, i32* %.22
  %.1034 = load i32, i32* %.23
  %.1035 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1034
  %.1036 = load i32, i32* %.1035
  %.1037 = sdiv i32 %.1033, %.1036
  store i32 %.1037, i32* %.22
  %.1039 = load i32, i32* %.22
  %.1040 = add i32 %.1039, 65536
  %.1041 = load i32, i32* %.23
  %.1042 = sub i32 15, %.1041
  %.1043 = add i32 %.1042, 1
  %.1044 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1043
  %.1045 = load i32, i32* %.1044
  %.1046 = sub i32 %.1040, %.1045
  store i32 %.1046, i32* %.20
  br label %.1048 
.1029:
  %.1050 = load i32, i32* %.22
  %.1051 = load i32, i32* %.23
  %.1052 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1051
  %.1053 = load i32, i32* %.1052
  %.1054 = sdiv i32 %.1050, %.1053
  store i32 %.1054, i32* %.20
  br label %.1048 
.1048:
  br label %.1057 
.1057:
  br label %.1021 
.1073:
  %.1080 = load i32, i32* %.22
  %.1081 = icmp slt i32 %.1080, 0
  br i1 %.1081, label %.1078, label %.1079
.1074:
  %.1092 = load i32, i32* %.23
  %.1093 = icmp sgt i32 %.1092, 0
  br i1 %.1093, label %.1090, label %.1091
.1078:
  store i32 65535, i32* %.20
  br label %.1084 
.1079:
  store i32 0, i32* %.20
  br label %.1084 
.1084:
  br label %.1088 
.1088:
  %.1130 = load i32, i32* %.20
  store i32 %.1130, i32* %.27
  br label %.32wc8 
.1090:
  %.1097 = load i32, i32* %.22
  %.1098 = icmp sgt i32 %.1097, 32767
  br i1 %.1098, label %.1095, label %.1096
.1091:
  %.1126 = load i32, i32* %.22
  store i32 %.1126, i32* %.20
  br label %.1124 
.1095:
  %.1100 = load i32, i32* %.22
  %.1101 = load i32, i32* %.23
  %.1102 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1101
  %.1103 = load i32, i32* %.1102
  %.1104 = sdiv i32 %.1100, %.1103
  store i32 %.1104, i32* %.22
  %.1106 = load i32, i32* %.22
  %.1107 = add i32 %.1106, 65536
  %.1108 = load i32, i32* %.23
  %.1109 = sub i32 15, %.1108
  %.1110 = add i32 %.1109, 1
  %.1111 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1110
  %.1112 = load i32, i32* %.1111
  %.1113 = sub i32 %.1107, %.1112
  store i32 %.1113, i32* %.20
  br label %.1115 
.1096:
  %.1117 = load i32, i32* %.22
  %.1118 = load i32, i32* %.23
  %.1119 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1118
  %.1120 = load i32, i32* %.1119
  %.1121 = sdiv i32 %.1117, %.1120
  store i32 %.1121, i32* %.20
  br label %.1115 
.1115:
  br label %.1124 
.1124:
  br label %.1088 
.1147wc349:
  %.1151 = load i32, i32* %.1143
  %.1152 = icmp sgt i32 %.1151, 0
  br i1 %.1152, label %.1148wloop.349.683, label %.1149wn683
.1148wloop.349.683:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1156 = load i32, i32* %.1143
  store i32 %.1156, i32* %.22
  store i32 1, i32* %.23
  br label %.1159wc354 
.1149wn683:
  %.2242 = load i32, i32* %.1145
  store i32 %.2242, i32* %.20
  %.2244 = load i32, i32* %.20
  call void @putint(i32 %.2244)
  call void @putch(i32 10)
  store i32 2, i32* %.24
  br label %.2248wc689 
.1159wc354:
  %.1163 = load i32, i32* %.21
  %.1164 = icmp slt i32 %.1163, 16
  br i1 %.1164, label %.1160wloop.354.361, label %.1161wn361
.1160wloop.354.361:
  %.1168 = load i32, i32* %.22
  %.1169 = srem i32 %.1168, 2
  %.1170 = icmp ne i32 %.1169, 0
  br i1 %.1170, label %.1171, label %.1167
.1161wn361:
  %.1197 = load i32, i32* %.20
  %.1198 = icmp ne i32 %.1197, 0
  br i1 %.1198, label %.1195, label %.1196
.1166:
  %.1177 = load i32, i32* %.20
  %.1178 = load i32, i32* %.21
  %.1179 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1178
  %.1180 = load i32, i32* %.1179
  %.1181 = mul i32 1, %.1180
  %.1182 = add i32 %.1177, %.1181
  store i32 %.1182, i32* %.20
  br label %.1167 
.1167:
  %.1185 = load i32, i32* %.22
  %.1186 = sdiv i32 %.1185, 2
  store i32 %.1186, i32* %.22
  %.1188 = load i32, i32* %.23
  %.1189 = sdiv i32 %.1188, 2
  store i32 %.1189, i32* %.23
  %.1191 = load i32, i32* %.21
  %.1192 = add i32 %.1191, 1
  store i32 %.1192, i32* %.21
  br label %.1159wc354 
.1171:
  %.1173 = load i32, i32* %.23
  %.1174 = srem i32 %.1173, 2
  %.1175 = icmp ne i32 %.1174, 0
  br i1 %.1175, label %.1166, label %.1167
.1195:
  %.1201 = load i32, i32* %.1145
  store i32 %.1201, i32* %.1200
  %.1204 = load i32, i32* %.1141
  store i32 %.1204, i32* %.1203
  store i32 0, i32* %.1206
  br label %.1208wc365 
.1196:
  %.1691 = load i32, i32* %.1141
  store i32 %.1691, i32* %.1690
  %.1694 = load i32, i32* %.1141
  store i32 %.1694, i32* %.1693
  store i32 0, i32* %.1696
  br label %.1698wc516 
.1208wc365:
  %.1212 = load i32, i32* %.1203
  %.1213 = icmp ne i32 %.1212, 0
  br i1 %.1213, label %.1209wloop.365.509, label %.1210wn509
.1209wloop.365.509:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1217 = load i32, i32* %.1203
  store i32 %.1217, i32* %.22
  store i32 1, i32* %.23
  br label %.1220wc370 
.1210wn509:
  %.1685 = load i32, i32* %.1206
  store i32 %.1685, i32* %.20
  %.1687 = load i32, i32* %.20
  store i32 %.1687, i32* %.1145
  br label %.1196 
.1220wc370:
  %.1224 = load i32, i32* %.21
  %.1225 = icmp slt i32 %.1224, 16
  br i1 %.1225, label %.1221wloop.370.377, label %.1222wn377
.1221wloop.370.377:
  %.1229 = load i32, i32* %.22
  %.1230 = srem i32 %.1229, 2
  %.1231 = icmp ne i32 %.1230, 0
  br i1 %.1231, label %.1232, label %.1228
.1222wn377:
  %.1258 = load i32, i32* %.20
  %.1259 = icmp ne i32 %.1258, 0
  br i1 %.1259, label %.1256, label %.1257
.1227:
  %.1238 = load i32, i32* %.20
  %.1239 = load i32, i32* %.21
  %.1240 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1239
  %.1241 = load i32, i32* %.1240
  %.1242 = mul i32 1, %.1241
  %.1243 = add i32 %.1238, %.1242
  store i32 %.1243, i32* %.20
  br label %.1228 
.1228:
  %.1246 = load i32, i32* %.22
  %.1247 = sdiv i32 %.1246, 2
  store i32 %.1247, i32* %.22
  %.1249 = load i32, i32* %.23
  %.1250 = sdiv i32 %.1249, 2
  store i32 %.1250, i32* %.23
  %.1252 = load i32, i32* %.21
  %.1253 = add i32 %.1252, 1
  store i32 %.1253, i32* %.21
  br label %.1220wc370 
.1232:
  %.1234 = load i32, i32* %.23
  %.1235 = srem i32 %.1234, 2
  %.1236 = icmp ne i32 %.1235, 0
  br i1 %.1236, label %.1227, label %.1228
.1256:
  %.1262 = load i32, i32* %.1206
  store i32 %.1262, i32* %.1261
  %.1265 = load i32, i32* %.1200
  store i32 %.1265, i32* %.1264
  br label %.1268wc381 
.1257:
  %.1443 = load i32, i32* %.1200
  store i32 %.1443, i32* %.1442
  %.1446 = load i32, i32* %.1200
  store i32 %.1446, i32* %.1445
  br label %.1449wc437 
.1268wc381:
  %.1272 = load i32, i32* %.1264
  %.1273 = icmp ne i32 %.1272, 0
  br i1 %.1273, label %.1269wloop.381.430, label %.1270wn430
.1269wloop.381.430:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1277 = load i32, i32* %.1261
  store i32 %.1277, i32* %.22
  %.1279 = load i32, i32* %.1264
  store i32 %.1279, i32* %.23
  br label %.1281wc386 
.1270wn430:
  %.1437 = load i32, i32* %.1261
  store i32 %.1437, i32* %.20
  %.1439 = load i32, i32* %.20
  store i32 %.1439, i32* %.1206
  br label %.1257 
.1281wc386:
  %.1285 = load i32, i32* %.21
  %.1286 = icmp slt i32 %.1285, 16
  br i1 %.1286, label %.1282wloop.386.397, label %.1283wn397
.1282wloop.386.397:
  %.1290 = load i32, i32* %.22
  %.1291 = srem i32 %.1290, 2
  %.1292 = icmp ne i32 %.1291, 0
  br i1 %.1292, label %.1288, label %.1289
.1283wn397:
  %.1335 = load i32, i32* %.20
  store i32 %.1335, i32* %.1267
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1339 = load i32, i32* %.1261
  store i32 %.1339, i32* %.22
  %.1341 = load i32, i32* %.1264
  store i32 %.1341, i32* %.23
  br label %.1343wc403 
.1288:
  %.1296 = load i32, i32* %.23
  %.1297 = srem i32 %.1296, 2
  %.1298 = icmp eq i32 %.1297, 0
  br i1 %.1298, label %.1294, label %.1295
.1289:
  %.1312 = load i32, i32* %.23
  %.1313 = srem i32 %.1312, 2
  %.1314 = icmp ne i32 %.1313, 0
  br i1 %.1314, label %.1310, label %.1311
.1294:
  %.1300 = load i32, i32* %.20
  %.1301 = load i32, i32* %.21
  %.1302 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1301
  %.1303 = load i32, i32* %.1302
  %.1304 = mul i32 1, %.1303
  %.1305 = add i32 %.1300, %.1304
  store i32 %.1305, i32* %.20
  br label %.1295 
.1295:
  br label %.1308 
.1308:
  %.1325 = load i32, i32* %.22
  %.1326 = sdiv i32 %.1325, 2
  store i32 %.1326, i32* %.22
  %.1328 = load i32, i32* %.23
  %.1329 = sdiv i32 %.1328, 2
  store i32 %.1329, i32* %.23
  %.1331 = load i32, i32* %.21
  %.1332 = add i32 %.1331, 1
  store i32 %.1332, i32* %.21
  br label %.1281wc386 
.1310:
  %.1316 = load i32, i32* %.20
  %.1317 = load i32, i32* %.21
  %.1318 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1317
  %.1319 = load i32, i32* %.1318
  %.1320 = mul i32 1, %.1319
  %.1321 = add i32 %.1316, %.1320
  store i32 %.1321, i32* %.20
  br label %.1311 
.1311:
  br label %.1308 
.1343wc403:
  %.1347 = load i32, i32* %.21
  %.1348 = icmp slt i32 %.1347, 16
  br i1 %.1348, label %.1344wloop.403.410, label %.1345wn410
.1344wloop.403.410:
  %.1352 = load i32, i32* %.22
  %.1353 = srem i32 %.1352, 2
  %.1354 = icmp ne i32 %.1353, 0
  br i1 %.1354, label %.1355, label %.1351
.1345wn410:
  %.1379 = load i32, i32* %.20
  store i32 %.1379, i32* %.1264
  br label %.1382 
.1350:
  %.1361 = load i32, i32* %.20
  %.1362 = load i32, i32* %.21
  %.1363 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1362
  %.1364 = load i32, i32* %.1363
  %.1365 = mul i32 1, %.1364
  %.1366 = add i32 %.1361, %.1365
  store i32 %.1366, i32* %.20
  br label %.1351 
.1351:
  %.1369 = load i32, i32* %.22
  %.1370 = sdiv i32 %.1369, 2
  store i32 %.1370, i32* %.22
  %.1372 = load i32, i32* %.23
  %.1373 = sdiv i32 %.1372, 2
  store i32 %.1373, i32* %.23
  %.1375 = load i32, i32* %.21
  %.1376 = add i32 %.1375, 1
  store i32 %.1376, i32* %.21
  br label %.1343wc403 
.1355:
  %.1357 = load i32, i32* %.23
  %.1358 = srem i32 %.1357, 2
  %.1359 = icmp ne i32 %.1358, 0
  br i1 %.1359, label %.1350, label %.1351
.1381:
  store i32 0, i32* %.20
  br label %.1385 
.1382:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1389 = load i32, i32* %.1264
  %.1390 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.1391 = load i32, i32* %.1390
  %.1392 = mul i32 %.1389, %.1391
  store i32 %.1392, i32* %.22
  store i32 65535, i32* %.23
  br label %.1395wc419 
.1385:
  %.1432 = load i32, i32* %.20
  store i32 %.1432, i32* %.1264
  %.1434 = load i32, i32* %.1267
  store i32 %.1434, i32* %.1261
  br label %.1268wc381 
.1395wc419:
  %.1399 = load i32, i32* %.21
  %.1400 = icmp slt i32 %.1399, 16
  br i1 %.1400, label %.1396wloop.419.426, label %.1397wn426
.1396wloop.419.426:
  %.1404 = load i32, i32* %.22
  %.1405 = srem i32 %.1404, 2
  %.1406 = icmp ne i32 %.1405, 0
  br i1 %.1406, label %.1407, label %.1403
.1397wn426:
  br label %.1385 
.1402:
  %.1413 = load i32, i32* %.20
  %.1414 = load i32, i32* %.21
  %.1415 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1414
  %.1416 = load i32, i32* %.1415
  %.1417 = mul i32 1, %.1416
  %.1418 = add i32 %.1413, %.1417
  store i32 %.1418, i32* %.20
  br label %.1403 
.1403:
  %.1421 = load i32, i32* %.22
  %.1422 = sdiv i32 %.1421, 2
  store i32 %.1422, i32* %.22
  %.1424 = load i32, i32* %.23
  %.1425 = sdiv i32 %.1424, 2
  store i32 %.1425, i32* %.23
  %.1427 = load i32, i32* %.21
  %.1428 = add i32 %.1427, 1
  store i32 %.1428, i32* %.21
  br label %.1395wc419 
.1407:
  %.1409 = load i32, i32* %.23
  %.1410 = srem i32 %.1409, 2
  %.1411 = icmp ne i32 %.1410, 0
  br i1 %.1411, label %.1402, label %.1403
.1449wc437:
  %.1453 = load i32, i32* %.1445
  %.1454 = icmp ne i32 %.1453, 0
  br i1 %.1454, label %.1450wloop.437.486, label %.1451wn486
.1450wloop.437.486:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1458 = load i32, i32* %.1442
  store i32 %.1458, i32* %.22
  %.1460 = load i32, i32* %.1445
  store i32 %.1460, i32* %.23
  br label %.1462wc442 
.1451wn486:
  %.1618 = load i32, i32* %.1442
  store i32 %.1618, i32* %.20
  %.1620 = load i32, i32* %.20
  store i32 %.1620, i32* %.1200
  %.1622 = load i32, i32* %.1203
  store i32 %.1622, i32* %.22
  store i32 1, i32* %.23
  %.1627 = load i32, i32* %.23
  %.1628 = icmp sge i32 %.1627, 15
  br i1 %.1628, label %.1625, label %.1626
.1462wc442:
  %.1466 = load i32, i32* %.21
  %.1467 = icmp slt i32 %.1466, 16
  br i1 %.1467, label %.1463wloop.442.453, label %.1464wn453
.1463wloop.442.453:
  %.1471 = load i32, i32* %.22
  %.1472 = srem i32 %.1471, 2
  %.1473 = icmp ne i32 %.1472, 0
  br i1 %.1473, label %.1469, label %.1470
.1464wn453:
  %.1516 = load i32, i32* %.20
  store i32 %.1516, i32* %.1448
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1520 = load i32, i32* %.1442
  store i32 %.1520, i32* %.22
  %.1522 = load i32, i32* %.1445
  store i32 %.1522, i32* %.23
  br label %.1524wc459 
.1469:
  %.1477 = load i32, i32* %.23
  %.1478 = srem i32 %.1477, 2
  %.1479 = icmp eq i32 %.1478, 0
  br i1 %.1479, label %.1475, label %.1476
.1470:
  %.1493 = load i32, i32* %.23
  %.1494 = srem i32 %.1493, 2
  %.1495 = icmp ne i32 %.1494, 0
  br i1 %.1495, label %.1491, label %.1492
.1475:
  %.1481 = load i32, i32* %.20
  %.1482 = load i32, i32* %.21
  %.1483 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1482
  %.1484 = load i32, i32* %.1483
  %.1485 = mul i32 1, %.1484
  %.1486 = add i32 %.1481, %.1485
  store i32 %.1486, i32* %.20
  br label %.1476 
.1476:
  br label %.1489 
.1489:
  %.1506 = load i32, i32* %.22
  %.1507 = sdiv i32 %.1506, 2
  store i32 %.1507, i32* %.22
  %.1509 = load i32, i32* %.23
  %.1510 = sdiv i32 %.1509, 2
  store i32 %.1510, i32* %.23
  %.1512 = load i32, i32* %.21
  %.1513 = add i32 %.1512, 1
  store i32 %.1513, i32* %.21
  br label %.1462wc442 
.1491:
  %.1497 = load i32, i32* %.20
  %.1498 = load i32, i32* %.21
  %.1499 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1498
  %.1500 = load i32, i32* %.1499
  %.1501 = mul i32 1, %.1500
  %.1502 = add i32 %.1497, %.1501
  store i32 %.1502, i32* %.20
  br label %.1492 
.1492:
  br label %.1489 
.1524wc459:
  %.1528 = load i32, i32* %.21
  %.1529 = icmp slt i32 %.1528, 16
  br i1 %.1529, label %.1525wloop.459.466, label %.1526wn466
.1525wloop.459.466:
  %.1533 = load i32, i32* %.22
  %.1534 = srem i32 %.1533, 2
  %.1535 = icmp ne i32 %.1534, 0
  br i1 %.1535, label %.1536, label %.1532
.1526wn466:
  %.1560 = load i32, i32* %.20
  store i32 %.1560, i32* %.1445
  br label %.1563 
.1531:
  %.1542 = load i32, i32* %.20
  %.1543 = load i32, i32* %.21
  %.1544 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1543
  %.1545 = load i32, i32* %.1544
  %.1546 = mul i32 1, %.1545
  %.1547 = add i32 %.1542, %.1546
  store i32 %.1547, i32* %.20
  br label %.1532 
.1532:
  %.1550 = load i32, i32* %.22
  %.1551 = sdiv i32 %.1550, 2
  store i32 %.1551, i32* %.22
  %.1553 = load i32, i32* %.23
  %.1554 = sdiv i32 %.1553, 2
  store i32 %.1554, i32* %.23
  %.1556 = load i32, i32* %.21
  %.1557 = add i32 %.1556, 1
  store i32 %.1557, i32* %.21
  br label %.1524wc459 
.1536:
  %.1538 = load i32, i32* %.23
  %.1539 = srem i32 %.1538, 2
  %.1540 = icmp ne i32 %.1539, 0
  br i1 %.1540, label %.1531, label %.1532
.1562:
  store i32 0, i32* %.20
  br label %.1566 
.1563:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1570 = load i32, i32* %.1445
  %.1571 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.1572 = load i32, i32* %.1571
  %.1573 = mul i32 %.1570, %.1572
  store i32 %.1573, i32* %.22
  store i32 65535, i32* %.23
  br label %.1576wc475 
.1566:
  %.1613 = load i32, i32* %.20
  store i32 %.1613, i32* %.1445
  %.1615 = load i32, i32* %.1448
  store i32 %.1615, i32* %.1442
  br label %.1449wc437 
.1576wc475:
  %.1580 = load i32, i32* %.21
  %.1581 = icmp slt i32 %.1580, 16
  br i1 %.1581, label %.1577wloop.475.482, label %.1578wn482
.1577wloop.475.482:
  %.1585 = load i32, i32* %.22
  %.1586 = srem i32 %.1585, 2
  %.1587 = icmp ne i32 %.1586, 0
  br i1 %.1587, label %.1588, label %.1584
.1578wn482:
  br label %.1566 
.1583:
  %.1594 = load i32, i32* %.20
  %.1595 = load i32, i32* %.21
  %.1596 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1595
  %.1597 = load i32, i32* %.1596
  %.1598 = mul i32 1, %.1597
  %.1599 = add i32 %.1594, %.1598
  store i32 %.1599, i32* %.20
  br label %.1584 
.1584:
  %.1602 = load i32, i32* %.22
  %.1603 = sdiv i32 %.1602, 2
  store i32 %.1603, i32* %.22
  %.1605 = load i32, i32* %.23
  %.1606 = sdiv i32 %.1605, 2
  store i32 %.1606, i32* %.23
  %.1608 = load i32, i32* %.21
  %.1609 = add i32 %.1608, 1
  store i32 %.1609, i32* %.21
  br label %.1576wc475 
.1588:
  %.1590 = load i32, i32* %.23
  %.1591 = srem i32 %.1590, 2
  %.1592 = icmp ne i32 %.1591, 0
  br i1 %.1592, label %.1583, label %.1584
.1625:
  %.1632 = load i32, i32* %.22
  %.1633 = icmp slt i32 %.1632, 0
  br i1 %.1633, label %.1630, label %.1631
.1626:
  %.1644 = load i32, i32* %.23
  %.1645 = icmp sgt i32 %.1644, 0
  br i1 %.1645, label %.1642, label %.1643
.1630:
  store i32 65535, i32* %.20
  br label %.1636 
.1631:
  store i32 0, i32* %.20
  br label %.1636 
.1636:
  br label %.1640 
.1640:
  %.1682 = load i32, i32* %.20
  store i32 %.1682, i32* %.1203
  br label %.1208wc365 
.1642:
  %.1649 = load i32, i32* %.22
  %.1650 = icmp sgt i32 %.1649, 32767
  br i1 %.1650, label %.1647, label %.1648
.1643:
  %.1678 = load i32, i32* %.22
  store i32 %.1678, i32* %.20
  br label %.1676 
.1647:
  %.1652 = load i32, i32* %.22
  %.1653 = load i32, i32* %.23
  %.1654 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1653
  %.1655 = load i32, i32* %.1654
  %.1656 = sdiv i32 %.1652, %.1655
  store i32 %.1656, i32* %.22
  %.1658 = load i32, i32* %.22
  %.1659 = add i32 %.1658, 65536
  %.1660 = load i32, i32* %.23
  %.1661 = sub i32 15, %.1660
  %.1662 = add i32 %.1661, 1
  %.1663 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1662
  %.1664 = load i32, i32* %.1663
  %.1665 = sub i32 %.1659, %.1664
  store i32 %.1665, i32* %.20
  br label %.1667 
.1648:
  %.1669 = load i32, i32* %.22
  %.1670 = load i32, i32* %.23
  %.1671 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1670
  %.1672 = load i32, i32* %.1671
  %.1673 = sdiv i32 %.1669, %.1672
  store i32 %.1673, i32* %.20
  br label %.1667 
.1667:
  br label %.1676 
.1676:
  br label %.1640 
.1698wc516:
  %.1702 = load i32, i32* %.1693
  %.1703 = icmp ne i32 %.1702, 0
  br i1 %.1703, label %.1699wloop.516.660, label %.1700wn660
.1699wloop.516.660:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1707 = load i32, i32* %.1693
  store i32 %.1707, i32* %.22
  store i32 1, i32* %.23
  br label %.1710wc521 
.1700wn660:
  %.2175 = load i32, i32* %.1696
  store i32 %.2175, i32* %.20
  %.2177 = load i32, i32* %.20
  store i32 %.2177, i32* %.1141
  %.2179 = load i32, i32* %.1143
  store i32 %.2179, i32* %.22
  store i32 1, i32* %.23
  %.2184 = load i32, i32* %.23
  %.2185 = icmp sge i32 %.2184, 15
  br i1 %.2185, label %.2182, label %.2183
.1710wc521:
  %.1714 = load i32, i32* %.21
  %.1715 = icmp slt i32 %.1714, 16
  br i1 %.1715, label %.1711wloop.521.528, label %.1712wn528
.1711wloop.521.528:
  %.1719 = load i32, i32* %.22
  %.1720 = srem i32 %.1719, 2
  %.1721 = icmp ne i32 %.1720, 0
  br i1 %.1721, label %.1722, label %.1718
.1712wn528:
  %.1748 = load i32, i32* %.20
  %.1749 = icmp ne i32 %.1748, 0
  br i1 %.1749, label %.1746, label %.1747
.1717:
  %.1728 = load i32, i32* %.20
  %.1729 = load i32, i32* %.21
  %.1730 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1729
  %.1731 = load i32, i32* %.1730
  %.1732 = mul i32 1, %.1731
  %.1733 = add i32 %.1728, %.1732
  store i32 %.1733, i32* %.20
  br label %.1718 
.1718:
  %.1736 = load i32, i32* %.22
  %.1737 = sdiv i32 %.1736, 2
  store i32 %.1737, i32* %.22
  %.1739 = load i32, i32* %.23
  %.1740 = sdiv i32 %.1739, 2
  store i32 %.1740, i32* %.23
  %.1742 = load i32, i32* %.21
  %.1743 = add i32 %.1742, 1
  store i32 %.1743, i32* %.21
  br label %.1710wc521 
.1722:
  %.1724 = load i32, i32* %.23
  %.1725 = srem i32 %.1724, 2
  %.1726 = icmp ne i32 %.1725, 0
  br i1 %.1726, label %.1717, label %.1718
.1746:
  %.1752 = load i32, i32* %.1696
  store i32 %.1752, i32* %.1751
  %.1755 = load i32, i32* %.1690
  store i32 %.1755, i32* %.1754
  br label %.1758wc532 
.1747:
  %.1933 = load i32, i32* %.1690
  store i32 %.1933, i32* %.1932
  %.1936 = load i32, i32* %.1690
  store i32 %.1936, i32* %.1935
  br label %.1939wc588 
.1758wc532:
  %.1762 = load i32, i32* %.1754
  %.1763 = icmp ne i32 %.1762, 0
  br i1 %.1763, label %.1759wloop.532.581, label %.1760wn581
.1759wloop.532.581:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1767 = load i32, i32* %.1751
  store i32 %.1767, i32* %.22
  %.1769 = load i32, i32* %.1754
  store i32 %.1769, i32* %.23
  br label %.1771wc537 
.1760wn581:
  %.1927 = load i32, i32* %.1751
  store i32 %.1927, i32* %.20
  %.1929 = load i32, i32* %.20
  store i32 %.1929, i32* %.1696
  br label %.1747 
.1771wc537:
  %.1775 = load i32, i32* %.21
  %.1776 = icmp slt i32 %.1775, 16
  br i1 %.1776, label %.1772wloop.537.548, label %.1773wn548
.1772wloop.537.548:
  %.1780 = load i32, i32* %.22
  %.1781 = srem i32 %.1780, 2
  %.1782 = icmp ne i32 %.1781, 0
  br i1 %.1782, label %.1778, label %.1779
.1773wn548:
  %.1825 = load i32, i32* %.20
  store i32 %.1825, i32* %.1757
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1829 = load i32, i32* %.1751
  store i32 %.1829, i32* %.22
  %.1831 = load i32, i32* %.1754
  store i32 %.1831, i32* %.23
  br label %.1833wc554 
.1778:
  %.1786 = load i32, i32* %.23
  %.1787 = srem i32 %.1786, 2
  %.1788 = icmp eq i32 %.1787, 0
  br i1 %.1788, label %.1784, label %.1785
.1779:
  %.1802 = load i32, i32* %.23
  %.1803 = srem i32 %.1802, 2
  %.1804 = icmp ne i32 %.1803, 0
  br i1 %.1804, label %.1800, label %.1801
.1784:
  %.1790 = load i32, i32* %.20
  %.1791 = load i32, i32* %.21
  %.1792 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1791
  %.1793 = load i32, i32* %.1792
  %.1794 = mul i32 1, %.1793
  %.1795 = add i32 %.1790, %.1794
  store i32 %.1795, i32* %.20
  br label %.1785 
.1785:
  br label %.1798 
.1798:
  %.1815 = load i32, i32* %.22
  %.1816 = sdiv i32 %.1815, 2
  store i32 %.1816, i32* %.22
  %.1818 = load i32, i32* %.23
  %.1819 = sdiv i32 %.1818, 2
  store i32 %.1819, i32* %.23
  %.1821 = load i32, i32* %.21
  %.1822 = add i32 %.1821, 1
  store i32 %.1822, i32* %.21
  br label %.1771wc537 
.1800:
  %.1806 = load i32, i32* %.20
  %.1807 = load i32, i32* %.21
  %.1808 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1807
  %.1809 = load i32, i32* %.1808
  %.1810 = mul i32 1, %.1809
  %.1811 = add i32 %.1806, %.1810
  store i32 %.1811, i32* %.20
  br label %.1801 
.1801:
  br label %.1798 
.1833wc554:
  %.1837 = load i32, i32* %.21
  %.1838 = icmp slt i32 %.1837, 16
  br i1 %.1838, label %.1834wloop.554.561, label %.1835wn561
.1834wloop.554.561:
  %.1842 = load i32, i32* %.22
  %.1843 = srem i32 %.1842, 2
  %.1844 = icmp ne i32 %.1843, 0
  br i1 %.1844, label %.1845, label %.1841
.1835wn561:
  %.1869 = load i32, i32* %.20
  store i32 %.1869, i32* %.1754
  br label %.1872 
.1840:
  %.1851 = load i32, i32* %.20
  %.1852 = load i32, i32* %.21
  %.1853 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1852
  %.1854 = load i32, i32* %.1853
  %.1855 = mul i32 1, %.1854
  %.1856 = add i32 %.1851, %.1855
  store i32 %.1856, i32* %.20
  br label %.1841 
.1841:
  %.1859 = load i32, i32* %.22
  %.1860 = sdiv i32 %.1859, 2
  store i32 %.1860, i32* %.22
  %.1862 = load i32, i32* %.23
  %.1863 = sdiv i32 %.1862, 2
  store i32 %.1863, i32* %.23
  %.1865 = load i32, i32* %.21
  %.1866 = add i32 %.1865, 1
  store i32 %.1866, i32* %.21
  br label %.1833wc554 
.1845:
  %.1847 = load i32, i32* %.23
  %.1848 = srem i32 %.1847, 2
  %.1849 = icmp ne i32 %.1848, 0
  br i1 %.1849, label %.1840, label %.1841
.1871:
  store i32 0, i32* %.20
  br label %.1875 
.1872:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1879 = load i32, i32* %.1754
  %.1880 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.1881 = load i32, i32* %.1880
  %.1882 = mul i32 %.1879, %.1881
  store i32 %.1882, i32* %.22
  store i32 65535, i32* %.23
  br label %.1885wc570 
.1875:
  %.1922 = load i32, i32* %.20
  store i32 %.1922, i32* %.1754
  %.1924 = load i32, i32* %.1757
  store i32 %.1924, i32* %.1751
  br label %.1758wc532 
.1885wc570:
  %.1889 = load i32, i32* %.21
  %.1890 = icmp slt i32 %.1889, 16
  br i1 %.1890, label %.1886wloop.570.577, label %.1887wn577
.1886wloop.570.577:
  %.1894 = load i32, i32* %.22
  %.1895 = srem i32 %.1894, 2
  %.1896 = icmp ne i32 %.1895, 0
  br i1 %.1896, label %.1897, label %.1893
.1887wn577:
  br label %.1875 
.1892:
  %.1903 = load i32, i32* %.20
  %.1904 = load i32, i32* %.21
  %.1905 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1904
  %.1906 = load i32, i32* %.1905
  %.1907 = mul i32 1, %.1906
  %.1908 = add i32 %.1903, %.1907
  store i32 %.1908, i32* %.20
  br label %.1893 
.1893:
  %.1911 = load i32, i32* %.22
  %.1912 = sdiv i32 %.1911, 2
  store i32 %.1912, i32* %.22
  %.1914 = load i32, i32* %.23
  %.1915 = sdiv i32 %.1914, 2
  store i32 %.1915, i32* %.23
  %.1917 = load i32, i32* %.21
  %.1918 = add i32 %.1917, 1
  store i32 %.1918, i32* %.21
  br label %.1885wc570 
.1897:
  %.1899 = load i32, i32* %.23
  %.1900 = srem i32 %.1899, 2
  %.1901 = icmp ne i32 %.1900, 0
  br i1 %.1901, label %.1892, label %.1893
.1939wc588:
  %.1943 = load i32, i32* %.1935
  %.1944 = icmp ne i32 %.1943, 0
  br i1 %.1944, label %.1940wloop.588.637, label %.1941wn637
.1940wloop.588.637:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1948 = load i32, i32* %.1932
  store i32 %.1948, i32* %.22
  %.1950 = load i32, i32* %.1935
  store i32 %.1950, i32* %.23
  br label %.1952wc593 
.1941wn637:
  %.2108 = load i32, i32* %.1932
  store i32 %.2108, i32* %.20
  %.2110 = load i32, i32* %.20
  store i32 %.2110, i32* %.1690
  %.2112 = load i32, i32* %.1693
  store i32 %.2112, i32* %.22
  store i32 1, i32* %.23
  %.2117 = load i32, i32* %.23
  %.2118 = icmp sge i32 %.2117, 15
  br i1 %.2118, label %.2115, label %.2116
.1952wc593:
  %.1956 = load i32, i32* %.21
  %.1957 = icmp slt i32 %.1956, 16
  br i1 %.1957, label %.1953wloop.593.604, label %.1954wn604
.1953wloop.593.604:
  %.1961 = load i32, i32* %.22
  %.1962 = srem i32 %.1961, 2
  %.1963 = icmp ne i32 %.1962, 0
  br i1 %.1963, label %.1959, label %.1960
.1954wn604:
  %.2006 = load i32, i32* %.20
  store i32 %.2006, i32* %.1938
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2010 = load i32, i32* %.1932
  store i32 %.2010, i32* %.22
  %.2012 = load i32, i32* %.1935
  store i32 %.2012, i32* %.23
  br label %.2014wc610 
.1959:
  %.1967 = load i32, i32* %.23
  %.1968 = srem i32 %.1967, 2
  %.1969 = icmp eq i32 %.1968, 0
  br i1 %.1969, label %.1965, label %.1966
.1960:
  %.1983 = load i32, i32* %.23
  %.1984 = srem i32 %.1983, 2
  %.1985 = icmp ne i32 %.1984, 0
  br i1 %.1985, label %.1981, label %.1982
.1965:
  %.1971 = load i32, i32* %.20
  %.1972 = load i32, i32* %.21
  %.1973 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1972
  %.1974 = load i32, i32* %.1973
  %.1975 = mul i32 1, %.1974
  %.1976 = add i32 %.1971, %.1975
  store i32 %.1976, i32* %.20
  br label %.1966 
.1966:
  br label %.1979 
.1979:
  %.1996 = load i32, i32* %.22
  %.1997 = sdiv i32 %.1996, 2
  store i32 %.1997, i32* %.22
  %.1999 = load i32, i32* %.23
  %.2000 = sdiv i32 %.1999, 2
  store i32 %.2000, i32* %.23
  %.2002 = load i32, i32* %.21
  %.2003 = add i32 %.2002, 1
  store i32 %.2003, i32* %.21
  br label %.1952wc593 
.1981:
  %.1987 = load i32, i32* %.20
  %.1988 = load i32, i32* %.21
  %.1989 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1988
  %.1990 = load i32, i32* %.1989
  %.1991 = mul i32 1, %.1990
  %.1992 = add i32 %.1987, %.1991
  store i32 %.1992, i32* %.20
  br label %.1982 
.1982:
  br label %.1979 
.2014wc610:
  %.2018 = load i32, i32* %.21
  %.2019 = icmp slt i32 %.2018, 16
  br i1 %.2019, label %.2015wloop.610.617, label %.2016wn617
.2015wloop.610.617:
  %.2023 = load i32, i32* %.22
  %.2024 = srem i32 %.2023, 2
  %.2025 = icmp ne i32 %.2024, 0
  br i1 %.2025, label %.2026, label %.2022
.2016wn617:
  %.2050 = load i32, i32* %.20
  store i32 %.2050, i32* %.1935
  br label %.2053 
.2021:
  %.2032 = load i32, i32* %.20
  %.2033 = load i32, i32* %.21
  %.2034 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2033
  %.2035 = load i32, i32* %.2034
  %.2036 = mul i32 1, %.2035
  %.2037 = add i32 %.2032, %.2036
  store i32 %.2037, i32* %.20
  br label %.2022 
.2022:
  %.2040 = load i32, i32* %.22
  %.2041 = sdiv i32 %.2040, 2
  store i32 %.2041, i32* %.22
  %.2043 = load i32, i32* %.23
  %.2044 = sdiv i32 %.2043, 2
  store i32 %.2044, i32* %.23
  %.2046 = load i32, i32* %.21
  %.2047 = add i32 %.2046, 1
  store i32 %.2047, i32* %.21
  br label %.2014wc610 
.2026:
  %.2028 = load i32, i32* %.23
  %.2029 = srem i32 %.2028, 2
  %.2030 = icmp ne i32 %.2029, 0
  br i1 %.2030, label %.2021, label %.2022
.2052:
  store i32 0, i32* %.20
  br label %.2056 
.2053:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2060 = load i32, i32* %.1935
  %.2061 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.2062 = load i32, i32* %.2061
  %.2063 = mul i32 %.2060, %.2062
  store i32 %.2063, i32* %.22
  store i32 65535, i32* %.23
  br label %.2066wc626 
.2056:
  %.2103 = load i32, i32* %.20
  store i32 %.2103, i32* %.1935
  %.2105 = load i32, i32* %.1938
  store i32 %.2105, i32* %.1932
  br label %.1939wc588 
.2066wc626:
  %.2070 = load i32, i32* %.21
  %.2071 = icmp slt i32 %.2070, 16
  br i1 %.2071, label %.2067wloop.626.633, label %.2068wn633
.2067wloop.626.633:
  %.2075 = load i32, i32* %.22
  %.2076 = srem i32 %.2075, 2
  %.2077 = icmp ne i32 %.2076, 0
  br i1 %.2077, label %.2078, label %.2074
.2068wn633:
  br label %.2056 
.2073:
  %.2084 = load i32, i32* %.20
  %.2085 = load i32, i32* %.21
  %.2086 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2085
  %.2087 = load i32, i32* %.2086
  %.2088 = mul i32 1, %.2087
  %.2089 = add i32 %.2084, %.2088
  store i32 %.2089, i32* %.20
  br label %.2074 
.2074:
  %.2092 = load i32, i32* %.22
  %.2093 = sdiv i32 %.2092, 2
  store i32 %.2093, i32* %.22
  %.2095 = load i32, i32* %.23
  %.2096 = sdiv i32 %.2095, 2
  store i32 %.2096, i32* %.23
  %.2098 = load i32, i32* %.21
  %.2099 = add i32 %.2098, 1
  store i32 %.2099, i32* %.21
  br label %.2066wc626 
.2078:
  %.2080 = load i32, i32* %.23
  %.2081 = srem i32 %.2080, 2
  %.2082 = icmp ne i32 %.2081, 0
  br i1 %.2082, label %.2073, label %.2074
.2115:
  %.2122 = load i32, i32* %.22
  %.2123 = icmp slt i32 %.2122, 0
  br i1 %.2123, label %.2120, label %.2121
.2116:
  %.2134 = load i32, i32* %.23
  %.2135 = icmp sgt i32 %.2134, 0
  br i1 %.2135, label %.2132, label %.2133
.2120:
  store i32 65535, i32* %.20
  br label %.2126 
.2121:
  store i32 0, i32* %.20
  br label %.2126 
.2126:
  br label %.2130 
.2130:
  %.2172 = load i32, i32* %.20
  store i32 %.2172, i32* %.1693
  br label %.1698wc516 
.2132:
  %.2139 = load i32, i32* %.22
  %.2140 = icmp sgt i32 %.2139, 32767
  br i1 %.2140, label %.2137, label %.2138
.2133:
  %.2168 = load i32, i32* %.22
  store i32 %.2168, i32* %.20
  br label %.2166 
.2137:
  %.2142 = load i32, i32* %.22
  %.2143 = load i32, i32* %.23
  %.2144 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2143
  %.2145 = load i32, i32* %.2144
  %.2146 = sdiv i32 %.2142, %.2145
  store i32 %.2146, i32* %.22
  %.2148 = load i32, i32* %.22
  %.2149 = add i32 %.2148, 65536
  %.2150 = load i32, i32* %.23
  %.2151 = sub i32 15, %.2150
  %.2152 = add i32 %.2151, 1
  %.2153 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2152
  %.2154 = load i32, i32* %.2153
  %.2155 = sub i32 %.2149, %.2154
  store i32 %.2155, i32* %.20
  br label %.2157 
.2138:
  %.2159 = load i32, i32* %.22
  %.2160 = load i32, i32* %.23
  %.2161 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2160
  %.2162 = load i32, i32* %.2161
  %.2163 = sdiv i32 %.2159, %.2162
  store i32 %.2163, i32* %.20
  br label %.2157 
.2157:
  br label %.2166 
.2166:
  br label %.2130 
.2182:
  %.2189 = load i32, i32* %.22
  %.2190 = icmp slt i32 %.2189, 0
  br i1 %.2190, label %.2187, label %.2188
.2183:
  %.2201 = load i32, i32* %.23
  %.2202 = icmp sgt i32 %.2201, 0
  br i1 %.2202, label %.2199, label %.2200
.2187:
  store i32 65535, i32* %.20
  br label %.2193 
.2188:
  store i32 0, i32* %.20
  br label %.2193 
.2193:
  br label %.2197 
.2197:
  %.2239 = load i32, i32* %.20
  store i32 %.2239, i32* %.1143
  br label %.1147wc349 
.2199:
  %.2206 = load i32, i32* %.22
  %.2207 = icmp sgt i32 %.2206, 32767
  br i1 %.2207, label %.2204, label %.2205
.2200:
  %.2235 = load i32, i32* %.22
  store i32 %.2235, i32* %.20
  br label %.2233 
.2204:
  %.2209 = load i32, i32* %.22
  %.2210 = load i32, i32* %.23
  %.2211 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2210
  %.2212 = load i32, i32* %.2211
  %.2213 = sdiv i32 %.2209, %.2212
  store i32 %.2213, i32* %.22
  %.2215 = load i32, i32* %.22
  %.2216 = add i32 %.2215, 65536
  %.2217 = load i32, i32* %.23
  %.2218 = sub i32 15, %.2217
  %.2219 = add i32 %.2218, 1
  %.2220 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2219
  %.2221 = load i32, i32* %.2220
  %.2222 = sub i32 %.2216, %.2221
  store i32 %.2222, i32* %.20
  br label %.2224 
.2205:
  %.2226 = load i32, i32* %.22
  %.2227 = load i32, i32* %.23
  %.2228 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2227
  %.2229 = load i32, i32* %.2228
  %.2230 = sdiv i32 %.2226, %.2229
  store i32 %.2230, i32* %.20
  br label %.2224 
.2224:
  br label %.2233 
.2233:
  br label %.2197 
.2248wc689:
  %.2252 = load i32, i32* %.24
  %.2253 = icmp slt i32 %.2252, 16
  br i1 %.2253, label %.2249wloop.689.1032, label %.2250wn1032
.2249wloop.689.1032:
  store i32 2, i32* %.2255
  %.2258 = load i32, i32* %.24
  store i32 %.2258, i32* %.2257
  store i32 1, i32* %.2260
  br label %.2262wc692 
.2250wn1032:
  store i32 0, i32* %.24
  br label %.3367wc1034 
.2262wc692:
  %.2266 = load i32, i32* %.2257
  %.2267 = icmp sgt i32 %.2266, 0
  br i1 %.2267, label %.2263wloop.692.1026, label %.2264wn1026
.2263wloop.692.1026:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2271 = load i32, i32* %.2257
  store i32 %.2271, i32* %.22
  store i32 1, i32* %.23
  br label %.2274wc697 
.2264wn1026:
  %.3357 = load i32, i32* %.2260
  store i32 %.3357, i32* %.20
  %.3359 = load i32, i32* %.20
  call void @putint(i32 %.3359)
  call void @putch(i32 10)
  %.3362 = load i32, i32* %.24
  %.3363 = add i32 %.3362, 1
  store i32 %.3363, i32* %.24
  br label %.2248wc689 
.2274wc697:
  %.2278 = load i32, i32* %.21
  %.2279 = icmp slt i32 %.2278, 16
  br i1 %.2279, label %.2275wloop.697.704, label %.2276wn704
.2275wloop.697.704:
  %.2283 = load i32, i32* %.22
  %.2284 = srem i32 %.2283, 2
  %.2285 = icmp ne i32 %.2284, 0
  br i1 %.2285, label %.2286, label %.2282
.2276wn704:
  %.2312 = load i32, i32* %.20
  %.2313 = icmp ne i32 %.2312, 0
  br i1 %.2313, label %.2310, label %.2311
.2281:
  %.2292 = load i32, i32* %.20
  %.2293 = load i32, i32* %.21
  %.2294 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2293
  %.2295 = load i32, i32* %.2294
  %.2296 = mul i32 1, %.2295
  %.2297 = add i32 %.2292, %.2296
  store i32 %.2297, i32* %.20
  br label %.2282 
.2282:
  %.2300 = load i32, i32* %.22
  %.2301 = sdiv i32 %.2300, 2
  store i32 %.2301, i32* %.22
  %.2303 = load i32, i32* %.23
  %.2304 = sdiv i32 %.2303, 2
  store i32 %.2304, i32* %.23
  %.2306 = load i32, i32* %.21
  %.2307 = add i32 %.2306, 1
  store i32 %.2307, i32* %.21
  br label %.2274wc697 
.2286:
  %.2288 = load i32, i32* %.23
  %.2289 = srem i32 %.2288, 2
  %.2290 = icmp ne i32 %.2289, 0
  br i1 %.2290, label %.2281, label %.2282
.2310:
  %.2316 = load i32, i32* %.2260
  store i32 %.2316, i32* %.2315
  %.2319 = load i32, i32* %.2255
  store i32 %.2319, i32* %.2318
  store i32 0, i32* %.2321
  br label %.2323wc708 
.2311:
  %.2806 = load i32, i32* %.2255
  store i32 %.2806, i32* %.2805
  %.2809 = load i32, i32* %.2255
  store i32 %.2809, i32* %.2808
  store i32 0, i32* %.2811
  br label %.2813wc859 
.2323wc708:
  %.2327 = load i32, i32* %.2318
  %.2328 = icmp ne i32 %.2327, 0
  br i1 %.2328, label %.2324wloop.708.852, label %.2325wn852
.2324wloop.708.852:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2332 = load i32, i32* %.2318
  store i32 %.2332, i32* %.22
  store i32 1, i32* %.23
  br label %.2335wc713 
.2325wn852:
  %.2800 = load i32, i32* %.2321
  store i32 %.2800, i32* %.20
  %.2802 = load i32, i32* %.20
  store i32 %.2802, i32* %.2260
  br label %.2311 
.2335wc713:
  %.2339 = load i32, i32* %.21
  %.2340 = icmp slt i32 %.2339, 16
  br i1 %.2340, label %.2336wloop.713.720, label %.2337wn720
.2336wloop.713.720:
  %.2344 = load i32, i32* %.22
  %.2345 = srem i32 %.2344, 2
  %.2346 = icmp ne i32 %.2345, 0
  br i1 %.2346, label %.2347, label %.2343
.2337wn720:
  %.2373 = load i32, i32* %.20
  %.2374 = icmp ne i32 %.2373, 0
  br i1 %.2374, label %.2371, label %.2372
.2342:
  %.2353 = load i32, i32* %.20
  %.2354 = load i32, i32* %.21
  %.2355 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2354
  %.2356 = load i32, i32* %.2355
  %.2357 = mul i32 1, %.2356
  %.2358 = add i32 %.2353, %.2357
  store i32 %.2358, i32* %.20
  br label %.2343 
.2343:
  %.2361 = load i32, i32* %.22
  %.2362 = sdiv i32 %.2361, 2
  store i32 %.2362, i32* %.22
  %.2364 = load i32, i32* %.23
  %.2365 = sdiv i32 %.2364, 2
  store i32 %.2365, i32* %.23
  %.2367 = load i32, i32* %.21
  %.2368 = add i32 %.2367, 1
  store i32 %.2368, i32* %.21
  br label %.2335wc713 
.2347:
  %.2349 = load i32, i32* %.23
  %.2350 = srem i32 %.2349, 2
  %.2351 = icmp ne i32 %.2350, 0
  br i1 %.2351, label %.2342, label %.2343
.2371:
  %.2377 = load i32, i32* %.2321
  store i32 %.2377, i32* %.2376
  %.2380 = load i32, i32* %.2315
  store i32 %.2380, i32* %.2379
  br label %.2383wc724 
.2372:
  %.2558 = load i32, i32* %.2315
  store i32 %.2558, i32* %.2557
  %.2561 = load i32, i32* %.2315
  store i32 %.2561, i32* %.2560
  br label %.2564wc780 
.2383wc724:
  %.2387 = load i32, i32* %.2379
  %.2388 = icmp ne i32 %.2387, 0
  br i1 %.2388, label %.2384wloop.724.773, label %.2385wn773
.2384wloop.724.773:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2392 = load i32, i32* %.2376
  store i32 %.2392, i32* %.22
  %.2394 = load i32, i32* %.2379
  store i32 %.2394, i32* %.23
  br label %.2396wc729 
.2385wn773:
  %.2552 = load i32, i32* %.2376
  store i32 %.2552, i32* %.20
  %.2554 = load i32, i32* %.20
  store i32 %.2554, i32* %.2321
  br label %.2372 
.2396wc729:
  %.2400 = load i32, i32* %.21
  %.2401 = icmp slt i32 %.2400, 16
  br i1 %.2401, label %.2397wloop.729.740, label %.2398wn740
.2397wloop.729.740:
  %.2405 = load i32, i32* %.22
  %.2406 = srem i32 %.2405, 2
  %.2407 = icmp ne i32 %.2406, 0
  br i1 %.2407, label %.2403, label %.2404
.2398wn740:
  %.2450 = load i32, i32* %.20
  store i32 %.2450, i32* %.2382
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2454 = load i32, i32* %.2376
  store i32 %.2454, i32* %.22
  %.2456 = load i32, i32* %.2379
  store i32 %.2456, i32* %.23
  br label %.2458wc746 
.2403:
  %.2411 = load i32, i32* %.23
  %.2412 = srem i32 %.2411, 2
  %.2413 = icmp eq i32 %.2412, 0
  br i1 %.2413, label %.2409, label %.2410
.2404:
  %.2427 = load i32, i32* %.23
  %.2428 = srem i32 %.2427, 2
  %.2429 = icmp ne i32 %.2428, 0
  br i1 %.2429, label %.2425, label %.2426
.2409:
  %.2415 = load i32, i32* %.20
  %.2416 = load i32, i32* %.21
  %.2417 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2416
  %.2418 = load i32, i32* %.2417
  %.2419 = mul i32 1, %.2418
  %.2420 = add i32 %.2415, %.2419
  store i32 %.2420, i32* %.20
  br label %.2410 
.2410:
  br label %.2423 
.2423:
  %.2440 = load i32, i32* %.22
  %.2441 = sdiv i32 %.2440, 2
  store i32 %.2441, i32* %.22
  %.2443 = load i32, i32* %.23
  %.2444 = sdiv i32 %.2443, 2
  store i32 %.2444, i32* %.23
  %.2446 = load i32, i32* %.21
  %.2447 = add i32 %.2446, 1
  store i32 %.2447, i32* %.21
  br label %.2396wc729 
.2425:
  %.2431 = load i32, i32* %.20
  %.2432 = load i32, i32* %.21
  %.2433 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2432
  %.2434 = load i32, i32* %.2433
  %.2435 = mul i32 1, %.2434
  %.2436 = add i32 %.2431, %.2435
  store i32 %.2436, i32* %.20
  br label %.2426 
.2426:
  br label %.2423 
.2458wc746:
  %.2462 = load i32, i32* %.21
  %.2463 = icmp slt i32 %.2462, 16
  br i1 %.2463, label %.2459wloop.746.753, label %.2460wn753
.2459wloop.746.753:
  %.2467 = load i32, i32* %.22
  %.2468 = srem i32 %.2467, 2
  %.2469 = icmp ne i32 %.2468, 0
  br i1 %.2469, label %.2470, label %.2466
.2460wn753:
  %.2494 = load i32, i32* %.20
  store i32 %.2494, i32* %.2379
  br label %.2497 
.2465:
  %.2476 = load i32, i32* %.20
  %.2477 = load i32, i32* %.21
  %.2478 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2477
  %.2479 = load i32, i32* %.2478
  %.2480 = mul i32 1, %.2479
  %.2481 = add i32 %.2476, %.2480
  store i32 %.2481, i32* %.20
  br label %.2466 
.2466:
  %.2484 = load i32, i32* %.22
  %.2485 = sdiv i32 %.2484, 2
  store i32 %.2485, i32* %.22
  %.2487 = load i32, i32* %.23
  %.2488 = sdiv i32 %.2487, 2
  store i32 %.2488, i32* %.23
  %.2490 = load i32, i32* %.21
  %.2491 = add i32 %.2490, 1
  store i32 %.2491, i32* %.21
  br label %.2458wc746 
.2470:
  %.2472 = load i32, i32* %.23
  %.2473 = srem i32 %.2472, 2
  %.2474 = icmp ne i32 %.2473, 0
  br i1 %.2474, label %.2465, label %.2466
.2496:
  store i32 0, i32* %.20
  br label %.2500 
.2497:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2504 = load i32, i32* %.2379
  %.2505 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.2506 = load i32, i32* %.2505
  %.2507 = mul i32 %.2504, %.2506
  store i32 %.2507, i32* %.22
  store i32 65535, i32* %.23
  br label %.2510wc762 
.2500:
  %.2547 = load i32, i32* %.20
  store i32 %.2547, i32* %.2379
  %.2549 = load i32, i32* %.2382
  store i32 %.2549, i32* %.2376
  br label %.2383wc724 
.2510wc762:
  %.2514 = load i32, i32* %.21
  %.2515 = icmp slt i32 %.2514, 16
  br i1 %.2515, label %.2511wloop.762.769, label %.2512wn769
.2511wloop.762.769:
  %.2519 = load i32, i32* %.22
  %.2520 = srem i32 %.2519, 2
  %.2521 = icmp ne i32 %.2520, 0
  br i1 %.2521, label %.2522, label %.2518
.2512wn769:
  br label %.2500 
.2517:
  %.2528 = load i32, i32* %.20
  %.2529 = load i32, i32* %.21
  %.2530 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2529
  %.2531 = load i32, i32* %.2530
  %.2532 = mul i32 1, %.2531
  %.2533 = add i32 %.2528, %.2532
  store i32 %.2533, i32* %.20
  br label %.2518 
.2518:
  %.2536 = load i32, i32* %.22
  %.2537 = sdiv i32 %.2536, 2
  store i32 %.2537, i32* %.22
  %.2539 = load i32, i32* %.23
  %.2540 = sdiv i32 %.2539, 2
  store i32 %.2540, i32* %.23
  %.2542 = load i32, i32* %.21
  %.2543 = add i32 %.2542, 1
  store i32 %.2543, i32* %.21
  br label %.2510wc762 
.2522:
  %.2524 = load i32, i32* %.23
  %.2525 = srem i32 %.2524, 2
  %.2526 = icmp ne i32 %.2525, 0
  br i1 %.2526, label %.2517, label %.2518
.2564wc780:
  %.2568 = load i32, i32* %.2560
  %.2569 = icmp ne i32 %.2568, 0
  br i1 %.2569, label %.2565wloop.780.829, label %.2566wn829
.2565wloop.780.829:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2573 = load i32, i32* %.2557
  store i32 %.2573, i32* %.22
  %.2575 = load i32, i32* %.2560
  store i32 %.2575, i32* %.23
  br label %.2577wc785 
.2566wn829:
  %.2733 = load i32, i32* %.2557
  store i32 %.2733, i32* %.20
  %.2735 = load i32, i32* %.20
  store i32 %.2735, i32* %.2315
  %.2737 = load i32, i32* %.2318
  store i32 %.2737, i32* %.22
  store i32 1, i32* %.23
  %.2742 = load i32, i32* %.23
  %.2743 = icmp sge i32 %.2742, 15
  br i1 %.2743, label %.2740, label %.2741
.2577wc785:
  %.2581 = load i32, i32* %.21
  %.2582 = icmp slt i32 %.2581, 16
  br i1 %.2582, label %.2578wloop.785.796, label %.2579wn796
.2578wloop.785.796:
  %.2586 = load i32, i32* %.22
  %.2587 = srem i32 %.2586, 2
  %.2588 = icmp ne i32 %.2587, 0
  br i1 %.2588, label %.2584, label %.2585
.2579wn796:
  %.2631 = load i32, i32* %.20
  store i32 %.2631, i32* %.2563
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2635 = load i32, i32* %.2557
  store i32 %.2635, i32* %.22
  %.2637 = load i32, i32* %.2560
  store i32 %.2637, i32* %.23
  br label %.2639wc802 
.2584:
  %.2592 = load i32, i32* %.23
  %.2593 = srem i32 %.2592, 2
  %.2594 = icmp eq i32 %.2593, 0
  br i1 %.2594, label %.2590, label %.2591
.2585:
  %.2608 = load i32, i32* %.23
  %.2609 = srem i32 %.2608, 2
  %.2610 = icmp ne i32 %.2609, 0
  br i1 %.2610, label %.2606, label %.2607
.2590:
  %.2596 = load i32, i32* %.20
  %.2597 = load i32, i32* %.21
  %.2598 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2597
  %.2599 = load i32, i32* %.2598
  %.2600 = mul i32 1, %.2599
  %.2601 = add i32 %.2596, %.2600
  store i32 %.2601, i32* %.20
  br label %.2591 
.2591:
  br label %.2604 
.2604:
  %.2621 = load i32, i32* %.22
  %.2622 = sdiv i32 %.2621, 2
  store i32 %.2622, i32* %.22
  %.2624 = load i32, i32* %.23
  %.2625 = sdiv i32 %.2624, 2
  store i32 %.2625, i32* %.23
  %.2627 = load i32, i32* %.21
  %.2628 = add i32 %.2627, 1
  store i32 %.2628, i32* %.21
  br label %.2577wc785 
.2606:
  %.2612 = load i32, i32* %.20
  %.2613 = load i32, i32* %.21
  %.2614 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2613
  %.2615 = load i32, i32* %.2614
  %.2616 = mul i32 1, %.2615
  %.2617 = add i32 %.2612, %.2616
  store i32 %.2617, i32* %.20
  br label %.2607 
.2607:
  br label %.2604 
.2639wc802:
  %.2643 = load i32, i32* %.21
  %.2644 = icmp slt i32 %.2643, 16
  br i1 %.2644, label %.2640wloop.802.809, label %.2641wn809
.2640wloop.802.809:
  %.2648 = load i32, i32* %.22
  %.2649 = srem i32 %.2648, 2
  %.2650 = icmp ne i32 %.2649, 0
  br i1 %.2650, label %.2651, label %.2647
.2641wn809:
  %.2675 = load i32, i32* %.20
  store i32 %.2675, i32* %.2560
  br label %.2678 
.2646:
  %.2657 = load i32, i32* %.20
  %.2658 = load i32, i32* %.21
  %.2659 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2658
  %.2660 = load i32, i32* %.2659
  %.2661 = mul i32 1, %.2660
  %.2662 = add i32 %.2657, %.2661
  store i32 %.2662, i32* %.20
  br label %.2647 
.2647:
  %.2665 = load i32, i32* %.22
  %.2666 = sdiv i32 %.2665, 2
  store i32 %.2666, i32* %.22
  %.2668 = load i32, i32* %.23
  %.2669 = sdiv i32 %.2668, 2
  store i32 %.2669, i32* %.23
  %.2671 = load i32, i32* %.21
  %.2672 = add i32 %.2671, 1
  store i32 %.2672, i32* %.21
  br label %.2639wc802 
.2651:
  %.2653 = load i32, i32* %.23
  %.2654 = srem i32 %.2653, 2
  %.2655 = icmp ne i32 %.2654, 0
  br i1 %.2655, label %.2646, label %.2647
.2677:
  store i32 0, i32* %.20
  br label %.2681 
.2678:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2685 = load i32, i32* %.2560
  %.2686 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.2687 = load i32, i32* %.2686
  %.2688 = mul i32 %.2685, %.2687
  store i32 %.2688, i32* %.22
  store i32 65535, i32* %.23
  br label %.2691wc818 
.2681:
  %.2728 = load i32, i32* %.20
  store i32 %.2728, i32* %.2560
  %.2730 = load i32, i32* %.2563
  store i32 %.2730, i32* %.2557
  br label %.2564wc780 
.2691wc818:
  %.2695 = load i32, i32* %.21
  %.2696 = icmp slt i32 %.2695, 16
  br i1 %.2696, label %.2692wloop.818.825, label %.2693wn825
.2692wloop.818.825:
  %.2700 = load i32, i32* %.22
  %.2701 = srem i32 %.2700, 2
  %.2702 = icmp ne i32 %.2701, 0
  br i1 %.2702, label %.2703, label %.2699
.2693wn825:
  br label %.2681 
.2698:
  %.2709 = load i32, i32* %.20
  %.2710 = load i32, i32* %.21
  %.2711 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2710
  %.2712 = load i32, i32* %.2711
  %.2713 = mul i32 1, %.2712
  %.2714 = add i32 %.2709, %.2713
  store i32 %.2714, i32* %.20
  br label %.2699 
.2699:
  %.2717 = load i32, i32* %.22
  %.2718 = sdiv i32 %.2717, 2
  store i32 %.2718, i32* %.22
  %.2720 = load i32, i32* %.23
  %.2721 = sdiv i32 %.2720, 2
  store i32 %.2721, i32* %.23
  %.2723 = load i32, i32* %.21
  %.2724 = add i32 %.2723, 1
  store i32 %.2724, i32* %.21
  br label %.2691wc818 
.2703:
  %.2705 = load i32, i32* %.23
  %.2706 = srem i32 %.2705, 2
  %.2707 = icmp ne i32 %.2706, 0
  br i1 %.2707, label %.2698, label %.2699
.2740:
  %.2747 = load i32, i32* %.22
  %.2748 = icmp slt i32 %.2747, 0
  br i1 %.2748, label %.2745, label %.2746
.2741:
  %.2759 = load i32, i32* %.23
  %.2760 = icmp sgt i32 %.2759, 0
  br i1 %.2760, label %.2757, label %.2758
.2745:
  store i32 65535, i32* %.20
  br label %.2751 
.2746:
  store i32 0, i32* %.20
  br label %.2751 
.2751:
  br label %.2755 
.2755:
  %.2797 = load i32, i32* %.20
  store i32 %.2797, i32* %.2318
  br label %.2323wc708 
.2757:
  %.2764 = load i32, i32* %.22
  %.2765 = icmp sgt i32 %.2764, 32767
  br i1 %.2765, label %.2762, label %.2763
.2758:
  %.2793 = load i32, i32* %.22
  store i32 %.2793, i32* %.20
  br label %.2791 
.2762:
  %.2767 = load i32, i32* %.22
  %.2768 = load i32, i32* %.23
  %.2769 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2768
  %.2770 = load i32, i32* %.2769
  %.2771 = sdiv i32 %.2767, %.2770
  store i32 %.2771, i32* %.22
  %.2773 = load i32, i32* %.22
  %.2774 = add i32 %.2773, 65536
  %.2775 = load i32, i32* %.23
  %.2776 = sub i32 15, %.2775
  %.2777 = add i32 %.2776, 1
  %.2778 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2777
  %.2779 = load i32, i32* %.2778
  %.2780 = sub i32 %.2774, %.2779
  store i32 %.2780, i32* %.20
  br label %.2782 
.2763:
  %.2784 = load i32, i32* %.22
  %.2785 = load i32, i32* %.23
  %.2786 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2785
  %.2787 = load i32, i32* %.2786
  %.2788 = sdiv i32 %.2784, %.2787
  store i32 %.2788, i32* %.20
  br label %.2782 
.2782:
  br label %.2791 
.2791:
  br label %.2755 
.2813wc859:
  %.2817 = load i32, i32* %.2808
  %.2818 = icmp ne i32 %.2817, 0
  br i1 %.2818, label %.2814wloop.859.1003, label %.2815wn1003
.2814wloop.859.1003:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2822 = load i32, i32* %.2808
  store i32 %.2822, i32* %.22
  store i32 1, i32* %.23
  br label %.2825wc864 
.2815wn1003:
  %.3290 = load i32, i32* %.2811
  store i32 %.3290, i32* %.20
  %.3292 = load i32, i32* %.20
  store i32 %.3292, i32* %.2255
  %.3294 = load i32, i32* %.2257
  store i32 %.3294, i32* %.22
  store i32 1, i32* %.23
  %.3299 = load i32, i32* %.23
  %.3300 = icmp sge i32 %.3299, 15
  br i1 %.3300, label %.3297, label %.3298
.2825wc864:
  %.2829 = load i32, i32* %.21
  %.2830 = icmp slt i32 %.2829, 16
  br i1 %.2830, label %.2826wloop.864.871, label %.2827wn871
.2826wloop.864.871:
  %.2834 = load i32, i32* %.22
  %.2835 = srem i32 %.2834, 2
  %.2836 = icmp ne i32 %.2835, 0
  br i1 %.2836, label %.2837, label %.2833
.2827wn871:
  %.2863 = load i32, i32* %.20
  %.2864 = icmp ne i32 %.2863, 0
  br i1 %.2864, label %.2861, label %.2862
.2832:
  %.2843 = load i32, i32* %.20
  %.2844 = load i32, i32* %.21
  %.2845 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2844
  %.2846 = load i32, i32* %.2845
  %.2847 = mul i32 1, %.2846
  %.2848 = add i32 %.2843, %.2847
  store i32 %.2848, i32* %.20
  br label %.2833 
.2833:
  %.2851 = load i32, i32* %.22
  %.2852 = sdiv i32 %.2851, 2
  store i32 %.2852, i32* %.22
  %.2854 = load i32, i32* %.23
  %.2855 = sdiv i32 %.2854, 2
  store i32 %.2855, i32* %.23
  %.2857 = load i32, i32* %.21
  %.2858 = add i32 %.2857, 1
  store i32 %.2858, i32* %.21
  br label %.2825wc864 
.2837:
  %.2839 = load i32, i32* %.23
  %.2840 = srem i32 %.2839, 2
  %.2841 = icmp ne i32 %.2840, 0
  br i1 %.2841, label %.2832, label %.2833
.2861:
  %.2867 = load i32, i32* %.2811
  store i32 %.2867, i32* %.2866
  %.2870 = load i32, i32* %.2805
  store i32 %.2870, i32* %.2869
  br label %.2873wc875 
.2862:
  %.3048 = load i32, i32* %.2805
  store i32 %.3048, i32* %.3047
  %.3051 = load i32, i32* %.2805
  store i32 %.3051, i32* %.3050
  br label %.3054wc931 
.2873wc875:
  %.2877 = load i32, i32* %.2869
  %.2878 = icmp ne i32 %.2877, 0
  br i1 %.2878, label %.2874wloop.875.924, label %.2875wn924
.2874wloop.875.924:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2882 = load i32, i32* %.2866
  store i32 %.2882, i32* %.22
  %.2884 = load i32, i32* %.2869
  store i32 %.2884, i32* %.23
  br label %.2886wc880 
.2875wn924:
  %.3042 = load i32, i32* %.2866
  store i32 %.3042, i32* %.20
  %.3044 = load i32, i32* %.20
  store i32 %.3044, i32* %.2811
  br label %.2862 
.2886wc880:
  %.2890 = load i32, i32* %.21
  %.2891 = icmp slt i32 %.2890, 16
  br i1 %.2891, label %.2887wloop.880.891, label %.2888wn891
.2887wloop.880.891:
  %.2895 = load i32, i32* %.22
  %.2896 = srem i32 %.2895, 2
  %.2897 = icmp ne i32 %.2896, 0
  br i1 %.2897, label %.2893, label %.2894
.2888wn891:
  %.2940 = load i32, i32* %.20
  store i32 %.2940, i32* %.2872
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2944 = load i32, i32* %.2866
  store i32 %.2944, i32* %.22
  %.2946 = load i32, i32* %.2869
  store i32 %.2946, i32* %.23
  br label %.2948wc897 
.2893:
  %.2901 = load i32, i32* %.23
  %.2902 = srem i32 %.2901, 2
  %.2903 = icmp eq i32 %.2902, 0
  br i1 %.2903, label %.2899, label %.2900
.2894:
  %.2917 = load i32, i32* %.23
  %.2918 = srem i32 %.2917, 2
  %.2919 = icmp ne i32 %.2918, 0
  br i1 %.2919, label %.2915, label %.2916
.2899:
  %.2905 = load i32, i32* %.20
  %.2906 = load i32, i32* %.21
  %.2907 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2906
  %.2908 = load i32, i32* %.2907
  %.2909 = mul i32 1, %.2908
  %.2910 = add i32 %.2905, %.2909
  store i32 %.2910, i32* %.20
  br label %.2900 
.2900:
  br label %.2913 
.2913:
  %.2930 = load i32, i32* %.22
  %.2931 = sdiv i32 %.2930, 2
  store i32 %.2931, i32* %.22
  %.2933 = load i32, i32* %.23
  %.2934 = sdiv i32 %.2933, 2
  store i32 %.2934, i32* %.23
  %.2936 = load i32, i32* %.21
  %.2937 = add i32 %.2936, 1
  store i32 %.2937, i32* %.21
  br label %.2886wc880 
.2915:
  %.2921 = load i32, i32* %.20
  %.2922 = load i32, i32* %.21
  %.2923 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2922
  %.2924 = load i32, i32* %.2923
  %.2925 = mul i32 1, %.2924
  %.2926 = add i32 %.2921, %.2925
  store i32 %.2926, i32* %.20
  br label %.2916 
.2916:
  br label %.2913 
.2948wc897:
  %.2952 = load i32, i32* %.21
  %.2953 = icmp slt i32 %.2952, 16
  br i1 %.2953, label %.2949wloop.897.904, label %.2950wn904
.2949wloop.897.904:
  %.2957 = load i32, i32* %.22
  %.2958 = srem i32 %.2957, 2
  %.2959 = icmp ne i32 %.2958, 0
  br i1 %.2959, label %.2960, label %.2956
.2950wn904:
  %.2984 = load i32, i32* %.20
  store i32 %.2984, i32* %.2869
  br label %.2987 
.2955:
  %.2966 = load i32, i32* %.20
  %.2967 = load i32, i32* %.21
  %.2968 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2967
  %.2969 = load i32, i32* %.2968
  %.2970 = mul i32 1, %.2969
  %.2971 = add i32 %.2966, %.2970
  store i32 %.2971, i32* %.20
  br label %.2956 
.2956:
  %.2974 = load i32, i32* %.22
  %.2975 = sdiv i32 %.2974, 2
  store i32 %.2975, i32* %.22
  %.2977 = load i32, i32* %.23
  %.2978 = sdiv i32 %.2977, 2
  store i32 %.2978, i32* %.23
  %.2980 = load i32, i32* %.21
  %.2981 = add i32 %.2980, 1
  store i32 %.2981, i32* %.21
  br label %.2948wc897 
.2960:
  %.2962 = load i32, i32* %.23
  %.2963 = srem i32 %.2962, 2
  %.2964 = icmp ne i32 %.2963, 0
  br i1 %.2964, label %.2955, label %.2956
.2986:
  store i32 0, i32* %.20
  br label %.2990 
.2987:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2994 = load i32, i32* %.2869
  %.2995 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.2996 = load i32, i32* %.2995
  %.2997 = mul i32 %.2994, %.2996
  store i32 %.2997, i32* %.22
  store i32 65535, i32* %.23
  br label %.3000wc913 
.2990:
  %.3037 = load i32, i32* %.20
  store i32 %.3037, i32* %.2869
  %.3039 = load i32, i32* %.2872
  store i32 %.3039, i32* %.2866
  br label %.2873wc875 
.3000wc913:
  %.3004 = load i32, i32* %.21
  %.3005 = icmp slt i32 %.3004, 16
  br i1 %.3005, label %.3001wloop.913.920, label %.3002wn920
.3001wloop.913.920:
  %.3009 = load i32, i32* %.22
  %.3010 = srem i32 %.3009, 2
  %.3011 = icmp ne i32 %.3010, 0
  br i1 %.3011, label %.3012, label %.3008
.3002wn920:
  br label %.2990 
.3007:
  %.3018 = load i32, i32* %.20
  %.3019 = load i32, i32* %.21
  %.3020 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3019
  %.3021 = load i32, i32* %.3020
  %.3022 = mul i32 1, %.3021
  %.3023 = add i32 %.3018, %.3022
  store i32 %.3023, i32* %.20
  br label %.3008 
.3008:
  %.3026 = load i32, i32* %.22
  %.3027 = sdiv i32 %.3026, 2
  store i32 %.3027, i32* %.22
  %.3029 = load i32, i32* %.23
  %.3030 = sdiv i32 %.3029, 2
  store i32 %.3030, i32* %.23
  %.3032 = load i32, i32* %.21
  %.3033 = add i32 %.3032, 1
  store i32 %.3033, i32* %.21
  br label %.3000wc913 
.3012:
  %.3014 = load i32, i32* %.23
  %.3015 = srem i32 %.3014, 2
  %.3016 = icmp ne i32 %.3015, 0
  br i1 %.3016, label %.3007, label %.3008
.3054wc931:
  %.3058 = load i32, i32* %.3050
  %.3059 = icmp ne i32 %.3058, 0
  br i1 %.3059, label %.3055wloop.931.980, label %.3056wn980
.3055wloop.931.980:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3063 = load i32, i32* %.3047
  store i32 %.3063, i32* %.22
  %.3065 = load i32, i32* %.3050
  store i32 %.3065, i32* %.23
  br label %.3067wc936 
.3056wn980:
  %.3223 = load i32, i32* %.3047
  store i32 %.3223, i32* %.20
  %.3225 = load i32, i32* %.20
  store i32 %.3225, i32* %.2805
  %.3227 = load i32, i32* %.2808
  store i32 %.3227, i32* %.22
  store i32 1, i32* %.23
  %.3232 = load i32, i32* %.23
  %.3233 = icmp sge i32 %.3232, 15
  br i1 %.3233, label %.3230, label %.3231
.3067wc936:
  %.3071 = load i32, i32* %.21
  %.3072 = icmp slt i32 %.3071, 16
  br i1 %.3072, label %.3068wloop.936.947, label %.3069wn947
.3068wloop.936.947:
  %.3076 = load i32, i32* %.22
  %.3077 = srem i32 %.3076, 2
  %.3078 = icmp ne i32 %.3077, 0
  br i1 %.3078, label %.3074, label %.3075
.3069wn947:
  %.3121 = load i32, i32* %.20
  store i32 %.3121, i32* %.3053
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3125 = load i32, i32* %.3047
  store i32 %.3125, i32* %.22
  %.3127 = load i32, i32* %.3050
  store i32 %.3127, i32* %.23
  br label %.3129wc953 
.3074:
  %.3082 = load i32, i32* %.23
  %.3083 = srem i32 %.3082, 2
  %.3084 = icmp eq i32 %.3083, 0
  br i1 %.3084, label %.3080, label %.3081
.3075:
  %.3098 = load i32, i32* %.23
  %.3099 = srem i32 %.3098, 2
  %.3100 = icmp ne i32 %.3099, 0
  br i1 %.3100, label %.3096, label %.3097
.3080:
  %.3086 = load i32, i32* %.20
  %.3087 = load i32, i32* %.21
  %.3088 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3087
  %.3089 = load i32, i32* %.3088
  %.3090 = mul i32 1, %.3089
  %.3091 = add i32 %.3086, %.3090
  store i32 %.3091, i32* %.20
  br label %.3081 
.3081:
  br label %.3094 
.3094:
  %.3111 = load i32, i32* %.22
  %.3112 = sdiv i32 %.3111, 2
  store i32 %.3112, i32* %.22
  %.3114 = load i32, i32* %.23
  %.3115 = sdiv i32 %.3114, 2
  store i32 %.3115, i32* %.23
  %.3117 = load i32, i32* %.21
  %.3118 = add i32 %.3117, 1
  store i32 %.3118, i32* %.21
  br label %.3067wc936 
.3096:
  %.3102 = load i32, i32* %.20
  %.3103 = load i32, i32* %.21
  %.3104 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3103
  %.3105 = load i32, i32* %.3104
  %.3106 = mul i32 1, %.3105
  %.3107 = add i32 %.3102, %.3106
  store i32 %.3107, i32* %.20
  br label %.3097 
.3097:
  br label %.3094 
.3129wc953:
  %.3133 = load i32, i32* %.21
  %.3134 = icmp slt i32 %.3133, 16
  br i1 %.3134, label %.3130wloop.953.960, label %.3131wn960
.3130wloop.953.960:
  %.3138 = load i32, i32* %.22
  %.3139 = srem i32 %.3138, 2
  %.3140 = icmp ne i32 %.3139, 0
  br i1 %.3140, label %.3141, label %.3137
.3131wn960:
  %.3165 = load i32, i32* %.20
  store i32 %.3165, i32* %.3050
  br label %.3168 
.3136:
  %.3147 = load i32, i32* %.20
  %.3148 = load i32, i32* %.21
  %.3149 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3148
  %.3150 = load i32, i32* %.3149
  %.3151 = mul i32 1, %.3150
  %.3152 = add i32 %.3147, %.3151
  store i32 %.3152, i32* %.20
  br label %.3137 
.3137:
  %.3155 = load i32, i32* %.22
  %.3156 = sdiv i32 %.3155, 2
  store i32 %.3156, i32* %.22
  %.3158 = load i32, i32* %.23
  %.3159 = sdiv i32 %.3158, 2
  store i32 %.3159, i32* %.23
  %.3161 = load i32, i32* %.21
  %.3162 = add i32 %.3161, 1
  store i32 %.3162, i32* %.21
  br label %.3129wc953 
.3141:
  %.3143 = load i32, i32* %.23
  %.3144 = srem i32 %.3143, 2
  %.3145 = icmp ne i32 %.3144, 0
  br i1 %.3145, label %.3136, label %.3137
.3167:
  store i32 0, i32* %.20
  br label %.3171 
.3168:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3175 = load i32, i32* %.3050
  %.3176 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.3177 = load i32, i32* %.3176
  %.3178 = mul i32 %.3175, %.3177
  store i32 %.3178, i32* %.22
  store i32 65535, i32* %.23
  br label %.3181wc969 
.3171:
  %.3218 = load i32, i32* %.20
  store i32 %.3218, i32* %.3050
  %.3220 = load i32, i32* %.3053
  store i32 %.3220, i32* %.3047
  br label %.3054wc931 
.3181wc969:
  %.3185 = load i32, i32* %.21
  %.3186 = icmp slt i32 %.3185, 16
  br i1 %.3186, label %.3182wloop.969.976, label %.3183wn976
.3182wloop.969.976:
  %.3190 = load i32, i32* %.22
  %.3191 = srem i32 %.3190, 2
  %.3192 = icmp ne i32 %.3191, 0
  br i1 %.3192, label %.3193, label %.3189
.3183wn976:
  br label %.3171 
.3188:
  %.3199 = load i32, i32* %.20
  %.3200 = load i32, i32* %.21
  %.3201 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3200
  %.3202 = load i32, i32* %.3201
  %.3203 = mul i32 1, %.3202
  %.3204 = add i32 %.3199, %.3203
  store i32 %.3204, i32* %.20
  br label %.3189 
.3189:
  %.3207 = load i32, i32* %.22
  %.3208 = sdiv i32 %.3207, 2
  store i32 %.3208, i32* %.22
  %.3210 = load i32, i32* %.23
  %.3211 = sdiv i32 %.3210, 2
  store i32 %.3211, i32* %.23
  %.3213 = load i32, i32* %.21
  %.3214 = add i32 %.3213, 1
  store i32 %.3214, i32* %.21
  br label %.3181wc969 
.3193:
  %.3195 = load i32, i32* %.23
  %.3196 = srem i32 %.3195, 2
  %.3197 = icmp ne i32 %.3196, 0
  br i1 %.3197, label %.3188, label %.3189
.3230:
  %.3237 = load i32, i32* %.22
  %.3238 = icmp slt i32 %.3237, 0
  br i1 %.3238, label %.3235, label %.3236
.3231:
  %.3249 = load i32, i32* %.23
  %.3250 = icmp sgt i32 %.3249, 0
  br i1 %.3250, label %.3247, label %.3248
.3235:
  store i32 65535, i32* %.20
  br label %.3241 
.3236:
  store i32 0, i32* %.20
  br label %.3241 
.3241:
  br label %.3245 
.3245:
  %.3287 = load i32, i32* %.20
  store i32 %.3287, i32* %.2808
  br label %.2813wc859 
.3247:
  %.3254 = load i32, i32* %.22
  %.3255 = icmp sgt i32 %.3254, 32767
  br i1 %.3255, label %.3252, label %.3253
.3248:
  %.3283 = load i32, i32* %.22
  store i32 %.3283, i32* %.20
  br label %.3281 
.3252:
  %.3257 = load i32, i32* %.22
  %.3258 = load i32, i32* %.23
  %.3259 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3258
  %.3260 = load i32, i32* %.3259
  %.3261 = sdiv i32 %.3257, %.3260
  store i32 %.3261, i32* %.22
  %.3263 = load i32, i32* %.22
  %.3264 = add i32 %.3263, 65536
  %.3265 = load i32, i32* %.23
  %.3266 = sub i32 15, %.3265
  %.3267 = add i32 %.3266, 1
  %.3268 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3267
  %.3269 = load i32, i32* %.3268
  %.3270 = sub i32 %.3264, %.3269
  store i32 %.3270, i32* %.20
  br label %.3272 
.3253:
  %.3274 = load i32, i32* %.22
  %.3275 = load i32, i32* %.23
  %.3276 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3275
  %.3277 = load i32, i32* %.3276
  %.3278 = sdiv i32 %.3274, %.3277
  store i32 %.3278, i32* %.20
  br label %.3272 
.3272:
  br label %.3281 
.3281:
  br label %.3245 
.3297:
  %.3304 = load i32, i32* %.22
  %.3305 = icmp slt i32 %.3304, 0
  br i1 %.3305, label %.3302, label %.3303
.3298:
  %.3316 = load i32, i32* %.23
  %.3317 = icmp sgt i32 %.3316, 0
  br i1 %.3317, label %.3314, label %.3315
.3302:
  store i32 65535, i32* %.20
  br label %.3308 
.3303:
  store i32 0, i32* %.20
  br label %.3308 
.3308:
  br label %.3312 
.3312:
  %.3354 = load i32, i32* %.20
  store i32 %.3354, i32* %.2257
  br label %.2262wc692 
.3314:
  %.3321 = load i32, i32* %.22
  %.3322 = icmp sgt i32 %.3321, 32767
  br i1 %.3322, label %.3319, label %.3320
.3315:
  %.3350 = load i32, i32* %.22
  store i32 %.3350, i32* %.20
  br label %.3348 
.3319:
  %.3324 = load i32, i32* %.22
  %.3325 = load i32, i32* %.23
  %.3326 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3325
  %.3327 = load i32, i32* %.3326
  %.3328 = sdiv i32 %.3324, %.3327
  store i32 %.3328, i32* %.22
  %.3330 = load i32, i32* %.22
  %.3331 = add i32 %.3330, 65536
  %.3332 = load i32, i32* %.23
  %.3333 = sub i32 15, %.3332
  %.3334 = add i32 %.3333, 1
  %.3335 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3334
  %.3336 = load i32, i32* %.3335
  %.3337 = sub i32 %.3331, %.3336
  store i32 %.3337, i32* %.20
  br label %.3339 
.3320:
  %.3341 = load i32, i32* %.22
  %.3342 = load i32, i32* %.23
  %.3343 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3342
  %.3344 = load i32, i32* %.3343
  %.3345 = sdiv i32 %.3341, %.3344
  store i32 %.3345, i32* %.20
  br label %.3339 
.3339:
  br label %.3348 
.3348:
  br label %.3312 
.3367wc1034:
  %.3371 = load i32, i32* %.24
  %.3372 = icmp slt i32 %.3371, 16
  br i1 %.3372, label %.3368wloop.1034.1376, label %.3369wn1376
.3368wloop.1034.1376:
  store i32 2, i32* %.3374
  %.3377 = load i32, i32* %.24
  store i32 %.3377, i32* %.3376
  store i32 1, i32* %.3379
  br label %.3381wc1037 
.3369wn1376:
  ret i32 0 
.3381wc1037:
  %.3385 = load i32, i32* %.3376
  %.3386 = icmp sgt i32 %.3385, 0
  br i1 %.3386, label %.3382wloop.1037.1371, label %.3383wn1371
.3382wloop.1037.1371:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3390 = load i32, i32* %.3376
  store i32 %.3390, i32* %.22
  store i32 1, i32* %.23
  br label %.3393wc1042 
.3383wn1371:
  %.4476 = load i32, i32* %.3379
  store i32 %.4476, i32* %.20
  %.4480 = load i32, i32* %.24
  %.4481 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4480
  %.4482 = load i32, i32* %.4481
  %.4483 = load i32, i32* %.20
  %.4484 = icmp ne i32 %.4482, %.4483
  br i1 %.4484, label %.4478, label %.4479
.3393wc1042:
  %.3397 = load i32, i32* %.21
  %.3398 = icmp slt i32 %.3397, 16
  br i1 %.3398, label %.3394wloop.1042.1049, label %.3395wn1049
.3394wloop.1042.1049:
  %.3402 = load i32, i32* %.22
  %.3403 = srem i32 %.3402, 2
  %.3404 = icmp ne i32 %.3403, 0
  br i1 %.3404, label %.3405, label %.3401
.3395wn1049:
  %.3431 = load i32, i32* %.20
  %.3432 = icmp ne i32 %.3431, 0
  br i1 %.3432, label %.3429, label %.3430
.3400:
  %.3411 = load i32, i32* %.20
  %.3412 = load i32, i32* %.21
  %.3413 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3412
  %.3414 = load i32, i32* %.3413
  %.3415 = mul i32 1, %.3414
  %.3416 = add i32 %.3411, %.3415
  store i32 %.3416, i32* %.20
  br label %.3401 
.3401:
  %.3419 = load i32, i32* %.22
  %.3420 = sdiv i32 %.3419, 2
  store i32 %.3420, i32* %.22
  %.3422 = load i32, i32* %.23
  %.3423 = sdiv i32 %.3422, 2
  store i32 %.3423, i32* %.23
  %.3425 = load i32, i32* %.21
  %.3426 = add i32 %.3425, 1
  store i32 %.3426, i32* %.21
  br label %.3393wc1042 
.3405:
  %.3407 = load i32, i32* %.23
  %.3408 = srem i32 %.3407, 2
  %.3409 = icmp ne i32 %.3408, 0
  br i1 %.3409, label %.3400, label %.3401
.3429:
  %.3435 = load i32, i32* %.3379
  store i32 %.3435, i32* %.3434
  %.3438 = load i32, i32* %.3374
  store i32 %.3438, i32* %.3437
  store i32 0, i32* %.3440
  br label %.3442wc1053 
.3430:
  %.3925 = load i32, i32* %.3374
  store i32 %.3925, i32* %.3924
  %.3928 = load i32, i32* %.3374
  store i32 %.3928, i32* %.3927
  store i32 0, i32* %.3930
  br label %.3932wc1204 
.3442wc1053:
  %.3446 = load i32, i32* %.3437
  %.3447 = icmp ne i32 %.3446, 0
  br i1 %.3447, label %.3443wloop.1053.1197, label %.3444wn1197
.3443wloop.1053.1197:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3451 = load i32, i32* %.3437
  store i32 %.3451, i32* %.22
  store i32 1, i32* %.23
  br label %.3454wc1058 
.3444wn1197:
  %.3919 = load i32, i32* %.3440
  store i32 %.3919, i32* %.20
  %.3921 = load i32, i32* %.20
  store i32 %.3921, i32* %.3379
  br label %.3430 
.3454wc1058:
  %.3458 = load i32, i32* %.21
  %.3459 = icmp slt i32 %.3458, 16
  br i1 %.3459, label %.3455wloop.1058.1065, label %.3456wn1065
.3455wloop.1058.1065:
  %.3463 = load i32, i32* %.22
  %.3464 = srem i32 %.3463, 2
  %.3465 = icmp ne i32 %.3464, 0
  br i1 %.3465, label %.3466, label %.3462
.3456wn1065:
  %.3492 = load i32, i32* %.20
  %.3493 = icmp ne i32 %.3492, 0
  br i1 %.3493, label %.3490, label %.3491
.3461:
  %.3472 = load i32, i32* %.20
  %.3473 = load i32, i32* %.21
  %.3474 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3473
  %.3475 = load i32, i32* %.3474
  %.3476 = mul i32 1, %.3475
  %.3477 = add i32 %.3472, %.3476
  store i32 %.3477, i32* %.20
  br label %.3462 
.3462:
  %.3480 = load i32, i32* %.22
  %.3481 = sdiv i32 %.3480, 2
  store i32 %.3481, i32* %.22
  %.3483 = load i32, i32* %.23
  %.3484 = sdiv i32 %.3483, 2
  store i32 %.3484, i32* %.23
  %.3486 = load i32, i32* %.21
  %.3487 = add i32 %.3486, 1
  store i32 %.3487, i32* %.21
  br label %.3454wc1058 
.3466:
  %.3468 = load i32, i32* %.23
  %.3469 = srem i32 %.3468, 2
  %.3470 = icmp ne i32 %.3469, 0
  br i1 %.3470, label %.3461, label %.3462
.3490:
  %.3496 = load i32, i32* %.3440
  store i32 %.3496, i32* %.3495
  %.3499 = load i32, i32* %.3434
  store i32 %.3499, i32* %.3498
  br label %.3502wc1069 
.3491:
  %.3677 = load i32, i32* %.3434
  store i32 %.3677, i32* %.3676
  %.3680 = load i32, i32* %.3434
  store i32 %.3680, i32* %.3679
  br label %.3683wc1125 
.3502wc1069:
  %.3506 = load i32, i32* %.3498
  %.3507 = icmp ne i32 %.3506, 0
  br i1 %.3507, label %.3503wloop.1069.1118, label %.3504wn1118
.3503wloop.1069.1118:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3511 = load i32, i32* %.3495
  store i32 %.3511, i32* %.22
  %.3513 = load i32, i32* %.3498
  store i32 %.3513, i32* %.23
  br label %.3515wc1074 
.3504wn1118:
  %.3671 = load i32, i32* %.3495
  store i32 %.3671, i32* %.20
  %.3673 = load i32, i32* %.20
  store i32 %.3673, i32* %.3440
  br label %.3491 
.3515wc1074:
  %.3519 = load i32, i32* %.21
  %.3520 = icmp slt i32 %.3519, 16
  br i1 %.3520, label %.3516wloop.1074.1085, label %.3517wn1085
.3516wloop.1074.1085:
  %.3524 = load i32, i32* %.22
  %.3525 = srem i32 %.3524, 2
  %.3526 = icmp ne i32 %.3525, 0
  br i1 %.3526, label %.3522, label %.3523
.3517wn1085:
  %.3569 = load i32, i32* %.20
  store i32 %.3569, i32* %.3501
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3573 = load i32, i32* %.3495
  store i32 %.3573, i32* %.22
  %.3575 = load i32, i32* %.3498
  store i32 %.3575, i32* %.23
  br label %.3577wc1091 
.3522:
  %.3530 = load i32, i32* %.23
  %.3531 = srem i32 %.3530, 2
  %.3532 = icmp eq i32 %.3531, 0
  br i1 %.3532, label %.3528, label %.3529
.3523:
  %.3546 = load i32, i32* %.23
  %.3547 = srem i32 %.3546, 2
  %.3548 = icmp ne i32 %.3547, 0
  br i1 %.3548, label %.3544, label %.3545
.3528:
  %.3534 = load i32, i32* %.20
  %.3535 = load i32, i32* %.21
  %.3536 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3535
  %.3537 = load i32, i32* %.3536
  %.3538 = mul i32 1, %.3537
  %.3539 = add i32 %.3534, %.3538
  store i32 %.3539, i32* %.20
  br label %.3529 
.3529:
  br label %.3542 
.3542:
  %.3559 = load i32, i32* %.22
  %.3560 = sdiv i32 %.3559, 2
  store i32 %.3560, i32* %.22
  %.3562 = load i32, i32* %.23
  %.3563 = sdiv i32 %.3562, 2
  store i32 %.3563, i32* %.23
  %.3565 = load i32, i32* %.21
  %.3566 = add i32 %.3565, 1
  store i32 %.3566, i32* %.21
  br label %.3515wc1074 
.3544:
  %.3550 = load i32, i32* %.20
  %.3551 = load i32, i32* %.21
  %.3552 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3551
  %.3553 = load i32, i32* %.3552
  %.3554 = mul i32 1, %.3553
  %.3555 = add i32 %.3550, %.3554
  store i32 %.3555, i32* %.20
  br label %.3545 
.3545:
  br label %.3542 
.3577wc1091:
  %.3581 = load i32, i32* %.21
  %.3582 = icmp slt i32 %.3581, 16
  br i1 %.3582, label %.3578wloop.1091.1098, label %.3579wn1098
.3578wloop.1091.1098:
  %.3586 = load i32, i32* %.22
  %.3587 = srem i32 %.3586, 2
  %.3588 = icmp ne i32 %.3587, 0
  br i1 %.3588, label %.3589, label %.3585
.3579wn1098:
  %.3613 = load i32, i32* %.20
  store i32 %.3613, i32* %.3498
  br label %.3616 
.3584:
  %.3595 = load i32, i32* %.20
  %.3596 = load i32, i32* %.21
  %.3597 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3596
  %.3598 = load i32, i32* %.3597
  %.3599 = mul i32 1, %.3598
  %.3600 = add i32 %.3595, %.3599
  store i32 %.3600, i32* %.20
  br label %.3585 
.3585:
  %.3603 = load i32, i32* %.22
  %.3604 = sdiv i32 %.3603, 2
  store i32 %.3604, i32* %.22
  %.3606 = load i32, i32* %.23
  %.3607 = sdiv i32 %.3606, 2
  store i32 %.3607, i32* %.23
  %.3609 = load i32, i32* %.21
  %.3610 = add i32 %.3609, 1
  store i32 %.3610, i32* %.21
  br label %.3577wc1091 
.3589:
  %.3591 = load i32, i32* %.23
  %.3592 = srem i32 %.3591, 2
  %.3593 = icmp ne i32 %.3592, 0
  br i1 %.3593, label %.3584, label %.3585
.3615:
  store i32 0, i32* %.20
  br label %.3619 
.3616:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3623 = load i32, i32* %.3498
  %.3624 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.3625 = load i32, i32* %.3624
  %.3626 = mul i32 %.3623, %.3625
  store i32 %.3626, i32* %.22
  store i32 65535, i32* %.23
  br label %.3629wc1107 
.3619:
  %.3666 = load i32, i32* %.20
  store i32 %.3666, i32* %.3498
  %.3668 = load i32, i32* %.3501
  store i32 %.3668, i32* %.3495
  br label %.3502wc1069 
.3629wc1107:
  %.3633 = load i32, i32* %.21
  %.3634 = icmp slt i32 %.3633, 16
  br i1 %.3634, label %.3630wloop.1107.1114, label %.3631wn1114
.3630wloop.1107.1114:
  %.3638 = load i32, i32* %.22
  %.3639 = srem i32 %.3638, 2
  %.3640 = icmp ne i32 %.3639, 0
  br i1 %.3640, label %.3641, label %.3637
.3631wn1114:
  br label %.3619 
.3636:
  %.3647 = load i32, i32* %.20
  %.3648 = load i32, i32* %.21
  %.3649 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3648
  %.3650 = load i32, i32* %.3649
  %.3651 = mul i32 1, %.3650
  %.3652 = add i32 %.3647, %.3651
  store i32 %.3652, i32* %.20
  br label %.3637 
.3637:
  %.3655 = load i32, i32* %.22
  %.3656 = sdiv i32 %.3655, 2
  store i32 %.3656, i32* %.22
  %.3658 = load i32, i32* %.23
  %.3659 = sdiv i32 %.3658, 2
  store i32 %.3659, i32* %.23
  %.3661 = load i32, i32* %.21
  %.3662 = add i32 %.3661, 1
  store i32 %.3662, i32* %.21
  br label %.3629wc1107 
.3641:
  %.3643 = load i32, i32* %.23
  %.3644 = srem i32 %.3643, 2
  %.3645 = icmp ne i32 %.3644, 0
  br i1 %.3645, label %.3636, label %.3637
.3683wc1125:
  %.3687 = load i32, i32* %.3679
  %.3688 = icmp ne i32 %.3687, 0
  br i1 %.3688, label %.3684wloop.1125.1174, label %.3685wn1174
.3684wloop.1125.1174:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3692 = load i32, i32* %.3676
  store i32 %.3692, i32* %.22
  %.3694 = load i32, i32* %.3679
  store i32 %.3694, i32* %.23
  br label %.3696wc1130 
.3685wn1174:
  %.3852 = load i32, i32* %.3676
  store i32 %.3852, i32* %.20
  %.3854 = load i32, i32* %.20
  store i32 %.3854, i32* %.3434
  %.3856 = load i32, i32* %.3437
  store i32 %.3856, i32* %.22
  store i32 1, i32* %.23
  %.3861 = load i32, i32* %.23
  %.3862 = icmp sge i32 %.3861, 15
  br i1 %.3862, label %.3859, label %.3860
.3696wc1130:
  %.3700 = load i32, i32* %.21
  %.3701 = icmp slt i32 %.3700, 16
  br i1 %.3701, label %.3697wloop.1130.1141, label %.3698wn1141
.3697wloop.1130.1141:
  %.3705 = load i32, i32* %.22
  %.3706 = srem i32 %.3705, 2
  %.3707 = icmp ne i32 %.3706, 0
  br i1 %.3707, label %.3703, label %.3704
.3698wn1141:
  %.3750 = load i32, i32* %.20
  store i32 %.3750, i32* %.3682
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3754 = load i32, i32* %.3676
  store i32 %.3754, i32* %.22
  %.3756 = load i32, i32* %.3679
  store i32 %.3756, i32* %.23
  br label %.3758wc1147 
.3703:
  %.3711 = load i32, i32* %.23
  %.3712 = srem i32 %.3711, 2
  %.3713 = icmp eq i32 %.3712, 0
  br i1 %.3713, label %.3709, label %.3710
.3704:
  %.3727 = load i32, i32* %.23
  %.3728 = srem i32 %.3727, 2
  %.3729 = icmp ne i32 %.3728, 0
  br i1 %.3729, label %.3725, label %.3726
.3709:
  %.3715 = load i32, i32* %.20
  %.3716 = load i32, i32* %.21
  %.3717 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3716
  %.3718 = load i32, i32* %.3717
  %.3719 = mul i32 1, %.3718
  %.3720 = add i32 %.3715, %.3719
  store i32 %.3720, i32* %.20
  br label %.3710 
.3710:
  br label %.3723 
.3723:
  %.3740 = load i32, i32* %.22
  %.3741 = sdiv i32 %.3740, 2
  store i32 %.3741, i32* %.22
  %.3743 = load i32, i32* %.23
  %.3744 = sdiv i32 %.3743, 2
  store i32 %.3744, i32* %.23
  %.3746 = load i32, i32* %.21
  %.3747 = add i32 %.3746, 1
  store i32 %.3747, i32* %.21
  br label %.3696wc1130 
.3725:
  %.3731 = load i32, i32* %.20
  %.3732 = load i32, i32* %.21
  %.3733 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3732
  %.3734 = load i32, i32* %.3733
  %.3735 = mul i32 1, %.3734
  %.3736 = add i32 %.3731, %.3735
  store i32 %.3736, i32* %.20
  br label %.3726 
.3726:
  br label %.3723 
.3758wc1147:
  %.3762 = load i32, i32* %.21
  %.3763 = icmp slt i32 %.3762, 16
  br i1 %.3763, label %.3759wloop.1147.1154, label %.3760wn1154
.3759wloop.1147.1154:
  %.3767 = load i32, i32* %.22
  %.3768 = srem i32 %.3767, 2
  %.3769 = icmp ne i32 %.3768, 0
  br i1 %.3769, label %.3770, label %.3766
.3760wn1154:
  %.3794 = load i32, i32* %.20
  store i32 %.3794, i32* %.3679
  br label %.3797 
.3765:
  %.3776 = load i32, i32* %.20
  %.3777 = load i32, i32* %.21
  %.3778 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3777
  %.3779 = load i32, i32* %.3778
  %.3780 = mul i32 1, %.3779
  %.3781 = add i32 %.3776, %.3780
  store i32 %.3781, i32* %.20
  br label %.3766 
.3766:
  %.3784 = load i32, i32* %.22
  %.3785 = sdiv i32 %.3784, 2
  store i32 %.3785, i32* %.22
  %.3787 = load i32, i32* %.23
  %.3788 = sdiv i32 %.3787, 2
  store i32 %.3788, i32* %.23
  %.3790 = load i32, i32* %.21
  %.3791 = add i32 %.3790, 1
  store i32 %.3791, i32* %.21
  br label %.3758wc1147 
.3770:
  %.3772 = load i32, i32* %.23
  %.3773 = srem i32 %.3772, 2
  %.3774 = icmp ne i32 %.3773, 0
  br i1 %.3774, label %.3765, label %.3766
.3796:
  store i32 0, i32* %.20
  br label %.3800 
.3797:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3804 = load i32, i32* %.3679
  %.3805 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.3806 = load i32, i32* %.3805
  %.3807 = mul i32 %.3804, %.3806
  store i32 %.3807, i32* %.22
  store i32 65535, i32* %.23
  br label %.3810wc1163 
.3800:
  %.3847 = load i32, i32* %.20
  store i32 %.3847, i32* %.3679
  %.3849 = load i32, i32* %.3682
  store i32 %.3849, i32* %.3676
  br label %.3683wc1125 
.3810wc1163:
  %.3814 = load i32, i32* %.21
  %.3815 = icmp slt i32 %.3814, 16
  br i1 %.3815, label %.3811wloop.1163.1170, label %.3812wn1170
.3811wloop.1163.1170:
  %.3819 = load i32, i32* %.22
  %.3820 = srem i32 %.3819, 2
  %.3821 = icmp ne i32 %.3820, 0
  br i1 %.3821, label %.3822, label %.3818
.3812wn1170:
  br label %.3800 
.3817:
  %.3828 = load i32, i32* %.20
  %.3829 = load i32, i32* %.21
  %.3830 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3829
  %.3831 = load i32, i32* %.3830
  %.3832 = mul i32 1, %.3831
  %.3833 = add i32 %.3828, %.3832
  store i32 %.3833, i32* %.20
  br label %.3818 
.3818:
  %.3836 = load i32, i32* %.22
  %.3837 = sdiv i32 %.3836, 2
  store i32 %.3837, i32* %.22
  %.3839 = load i32, i32* %.23
  %.3840 = sdiv i32 %.3839, 2
  store i32 %.3840, i32* %.23
  %.3842 = load i32, i32* %.21
  %.3843 = add i32 %.3842, 1
  store i32 %.3843, i32* %.21
  br label %.3810wc1163 
.3822:
  %.3824 = load i32, i32* %.23
  %.3825 = srem i32 %.3824, 2
  %.3826 = icmp ne i32 %.3825, 0
  br i1 %.3826, label %.3817, label %.3818
.3859:
  %.3866 = load i32, i32* %.22
  %.3867 = icmp slt i32 %.3866, 0
  br i1 %.3867, label %.3864, label %.3865
.3860:
  %.3878 = load i32, i32* %.23
  %.3879 = icmp sgt i32 %.3878, 0
  br i1 %.3879, label %.3876, label %.3877
.3864:
  store i32 65535, i32* %.20
  br label %.3870 
.3865:
  store i32 0, i32* %.20
  br label %.3870 
.3870:
  br label %.3874 
.3874:
  %.3916 = load i32, i32* %.20
  store i32 %.3916, i32* %.3437
  br label %.3442wc1053 
.3876:
  %.3883 = load i32, i32* %.22
  %.3884 = icmp sgt i32 %.3883, 32767
  br i1 %.3884, label %.3881, label %.3882
.3877:
  %.3912 = load i32, i32* %.22
  store i32 %.3912, i32* %.20
  br label %.3910 
.3881:
  %.3886 = load i32, i32* %.22
  %.3887 = load i32, i32* %.23
  %.3888 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3887
  %.3889 = load i32, i32* %.3888
  %.3890 = sdiv i32 %.3886, %.3889
  store i32 %.3890, i32* %.22
  %.3892 = load i32, i32* %.22
  %.3893 = add i32 %.3892, 65536
  %.3894 = load i32, i32* %.23
  %.3895 = sub i32 15, %.3894
  %.3896 = add i32 %.3895, 1
  %.3897 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3896
  %.3898 = load i32, i32* %.3897
  %.3899 = sub i32 %.3893, %.3898
  store i32 %.3899, i32* %.20
  br label %.3901 
.3882:
  %.3903 = load i32, i32* %.22
  %.3904 = load i32, i32* %.23
  %.3905 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3904
  %.3906 = load i32, i32* %.3905
  %.3907 = sdiv i32 %.3903, %.3906
  store i32 %.3907, i32* %.20
  br label %.3901 
.3901:
  br label %.3910 
.3910:
  br label %.3874 
.3932wc1204:
  %.3936 = load i32, i32* %.3927
  %.3937 = icmp ne i32 %.3936, 0
  br i1 %.3937, label %.3933wloop.1204.1348, label %.3934wn1348
.3933wloop.1204.1348:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3941 = load i32, i32* %.3927
  store i32 %.3941, i32* %.22
  store i32 1, i32* %.23
  br label %.3944wc1209 
.3934wn1348:
  %.4409 = load i32, i32* %.3930
  store i32 %.4409, i32* %.20
  %.4411 = load i32, i32* %.20
  store i32 %.4411, i32* %.3374
  %.4413 = load i32, i32* %.3376
  store i32 %.4413, i32* %.22
  store i32 1, i32* %.23
  %.4418 = load i32, i32* %.23
  %.4419 = icmp sge i32 %.4418, 15
  br i1 %.4419, label %.4416, label %.4417
.3944wc1209:
  %.3948 = load i32, i32* %.21
  %.3949 = icmp slt i32 %.3948, 16
  br i1 %.3949, label %.3945wloop.1209.1216, label %.3946wn1216
.3945wloop.1209.1216:
  %.3953 = load i32, i32* %.22
  %.3954 = srem i32 %.3953, 2
  %.3955 = icmp ne i32 %.3954, 0
  br i1 %.3955, label %.3956, label %.3952
.3946wn1216:
  %.3982 = load i32, i32* %.20
  %.3983 = icmp ne i32 %.3982, 0
  br i1 %.3983, label %.3980, label %.3981
.3951:
  %.3962 = load i32, i32* %.20
  %.3963 = load i32, i32* %.21
  %.3964 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3963
  %.3965 = load i32, i32* %.3964
  %.3966 = mul i32 1, %.3965
  %.3967 = add i32 %.3962, %.3966
  store i32 %.3967, i32* %.20
  br label %.3952 
.3952:
  %.3970 = load i32, i32* %.22
  %.3971 = sdiv i32 %.3970, 2
  store i32 %.3971, i32* %.22
  %.3973 = load i32, i32* %.23
  %.3974 = sdiv i32 %.3973, 2
  store i32 %.3974, i32* %.23
  %.3976 = load i32, i32* %.21
  %.3977 = add i32 %.3976, 1
  store i32 %.3977, i32* %.21
  br label %.3944wc1209 
.3956:
  %.3958 = load i32, i32* %.23
  %.3959 = srem i32 %.3958, 2
  %.3960 = icmp ne i32 %.3959, 0
  br i1 %.3960, label %.3951, label %.3952
.3980:
  %.3986 = load i32, i32* %.3930
  store i32 %.3986, i32* %.3985
  %.3989 = load i32, i32* %.3924
  store i32 %.3989, i32* %.3988
  br label %.3992wc1220 
.3981:
  %.4167 = load i32, i32* %.3924
  store i32 %.4167, i32* %.4166
  %.4170 = load i32, i32* %.3924
  store i32 %.4170, i32* %.4169
  br label %.4173wc1276 
.3992wc1220:
  %.3996 = load i32, i32* %.3988
  %.3997 = icmp ne i32 %.3996, 0
  br i1 %.3997, label %.3993wloop.1220.1269, label %.3994wn1269
.3993wloop.1220.1269:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4001 = load i32, i32* %.3985
  store i32 %.4001, i32* %.22
  %.4003 = load i32, i32* %.3988
  store i32 %.4003, i32* %.23
  br label %.4005wc1225 
.3994wn1269:
  %.4161 = load i32, i32* %.3985
  store i32 %.4161, i32* %.20
  %.4163 = load i32, i32* %.20
  store i32 %.4163, i32* %.3930
  br label %.3981 
.4005wc1225:
  %.4009 = load i32, i32* %.21
  %.4010 = icmp slt i32 %.4009, 16
  br i1 %.4010, label %.4006wloop.1225.1236, label %.4007wn1236
.4006wloop.1225.1236:
  %.4014 = load i32, i32* %.22
  %.4015 = srem i32 %.4014, 2
  %.4016 = icmp ne i32 %.4015, 0
  br i1 %.4016, label %.4012, label %.4013
.4007wn1236:
  %.4059 = load i32, i32* %.20
  store i32 %.4059, i32* %.3991
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4063 = load i32, i32* %.3985
  store i32 %.4063, i32* %.22
  %.4065 = load i32, i32* %.3988
  store i32 %.4065, i32* %.23
  br label %.4067wc1242 
.4012:
  %.4020 = load i32, i32* %.23
  %.4021 = srem i32 %.4020, 2
  %.4022 = icmp eq i32 %.4021, 0
  br i1 %.4022, label %.4018, label %.4019
.4013:
  %.4036 = load i32, i32* %.23
  %.4037 = srem i32 %.4036, 2
  %.4038 = icmp ne i32 %.4037, 0
  br i1 %.4038, label %.4034, label %.4035
.4018:
  %.4024 = load i32, i32* %.20
  %.4025 = load i32, i32* %.21
  %.4026 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4025
  %.4027 = load i32, i32* %.4026
  %.4028 = mul i32 1, %.4027
  %.4029 = add i32 %.4024, %.4028
  store i32 %.4029, i32* %.20
  br label %.4019 
.4019:
  br label %.4032 
.4032:
  %.4049 = load i32, i32* %.22
  %.4050 = sdiv i32 %.4049, 2
  store i32 %.4050, i32* %.22
  %.4052 = load i32, i32* %.23
  %.4053 = sdiv i32 %.4052, 2
  store i32 %.4053, i32* %.23
  %.4055 = load i32, i32* %.21
  %.4056 = add i32 %.4055, 1
  store i32 %.4056, i32* %.21
  br label %.4005wc1225 
.4034:
  %.4040 = load i32, i32* %.20
  %.4041 = load i32, i32* %.21
  %.4042 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4041
  %.4043 = load i32, i32* %.4042
  %.4044 = mul i32 1, %.4043
  %.4045 = add i32 %.4040, %.4044
  store i32 %.4045, i32* %.20
  br label %.4035 
.4035:
  br label %.4032 
.4067wc1242:
  %.4071 = load i32, i32* %.21
  %.4072 = icmp slt i32 %.4071, 16
  br i1 %.4072, label %.4068wloop.1242.1249, label %.4069wn1249
.4068wloop.1242.1249:
  %.4076 = load i32, i32* %.22
  %.4077 = srem i32 %.4076, 2
  %.4078 = icmp ne i32 %.4077, 0
  br i1 %.4078, label %.4079, label %.4075
.4069wn1249:
  %.4103 = load i32, i32* %.20
  store i32 %.4103, i32* %.3988
  br label %.4106 
.4074:
  %.4085 = load i32, i32* %.20
  %.4086 = load i32, i32* %.21
  %.4087 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4086
  %.4088 = load i32, i32* %.4087
  %.4089 = mul i32 1, %.4088
  %.4090 = add i32 %.4085, %.4089
  store i32 %.4090, i32* %.20
  br label %.4075 
.4075:
  %.4093 = load i32, i32* %.22
  %.4094 = sdiv i32 %.4093, 2
  store i32 %.4094, i32* %.22
  %.4096 = load i32, i32* %.23
  %.4097 = sdiv i32 %.4096, 2
  store i32 %.4097, i32* %.23
  %.4099 = load i32, i32* %.21
  %.4100 = add i32 %.4099, 1
  store i32 %.4100, i32* %.21
  br label %.4067wc1242 
.4079:
  %.4081 = load i32, i32* %.23
  %.4082 = srem i32 %.4081, 2
  %.4083 = icmp ne i32 %.4082, 0
  br i1 %.4083, label %.4074, label %.4075
.4105:
  store i32 0, i32* %.20
  br label %.4109 
.4106:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4113 = load i32, i32* %.3988
  %.4114 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.4115 = load i32, i32* %.4114
  %.4116 = mul i32 %.4113, %.4115
  store i32 %.4116, i32* %.22
  store i32 65535, i32* %.23
  br label %.4119wc1258 
.4109:
  %.4156 = load i32, i32* %.20
  store i32 %.4156, i32* %.3988
  %.4158 = load i32, i32* %.3991
  store i32 %.4158, i32* %.3985
  br label %.3992wc1220 
.4119wc1258:
  %.4123 = load i32, i32* %.21
  %.4124 = icmp slt i32 %.4123, 16
  br i1 %.4124, label %.4120wloop.1258.1265, label %.4121wn1265
.4120wloop.1258.1265:
  %.4128 = load i32, i32* %.22
  %.4129 = srem i32 %.4128, 2
  %.4130 = icmp ne i32 %.4129, 0
  br i1 %.4130, label %.4131, label %.4127
.4121wn1265:
  br label %.4109 
.4126:
  %.4137 = load i32, i32* %.20
  %.4138 = load i32, i32* %.21
  %.4139 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4138
  %.4140 = load i32, i32* %.4139
  %.4141 = mul i32 1, %.4140
  %.4142 = add i32 %.4137, %.4141
  store i32 %.4142, i32* %.20
  br label %.4127 
.4127:
  %.4145 = load i32, i32* %.22
  %.4146 = sdiv i32 %.4145, 2
  store i32 %.4146, i32* %.22
  %.4148 = load i32, i32* %.23
  %.4149 = sdiv i32 %.4148, 2
  store i32 %.4149, i32* %.23
  %.4151 = load i32, i32* %.21
  %.4152 = add i32 %.4151, 1
  store i32 %.4152, i32* %.21
  br label %.4119wc1258 
.4131:
  %.4133 = load i32, i32* %.23
  %.4134 = srem i32 %.4133, 2
  %.4135 = icmp ne i32 %.4134, 0
  br i1 %.4135, label %.4126, label %.4127
.4173wc1276:
  %.4177 = load i32, i32* %.4169
  %.4178 = icmp ne i32 %.4177, 0
  br i1 %.4178, label %.4174wloop.1276.1325, label %.4175wn1325
.4174wloop.1276.1325:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4182 = load i32, i32* %.4166
  store i32 %.4182, i32* %.22
  %.4184 = load i32, i32* %.4169
  store i32 %.4184, i32* %.23
  br label %.4186wc1281 
.4175wn1325:
  %.4342 = load i32, i32* %.4166
  store i32 %.4342, i32* %.20
  %.4344 = load i32, i32* %.20
  store i32 %.4344, i32* %.3924
  %.4346 = load i32, i32* %.3927
  store i32 %.4346, i32* %.22
  store i32 1, i32* %.23
  %.4351 = load i32, i32* %.23
  %.4352 = icmp sge i32 %.4351, 15
  br i1 %.4352, label %.4349, label %.4350
.4186wc1281:
  %.4190 = load i32, i32* %.21
  %.4191 = icmp slt i32 %.4190, 16
  br i1 %.4191, label %.4187wloop.1281.1292, label %.4188wn1292
.4187wloop.1281.1292:
  %.4195 = load i32, i32* %.22
  %.4196 = srem i32 %.4195, 2
  %.4197 = icmp ne i32 %.4196, 0
  br i1 %.4197, label %.4193, label %.4194
.4188wn1292:
  %.4240 = load i32, i32* %.20
  store i32 %.4240, i32* %.4172
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4244 = load i32, i32* %.4166
  store i32 %.4244, i32* %.22
  %.4246 = load i32, i32* %.4169
  store i32 %.4246, i32* %.23
  br label %.4248wc1298 
.4193:
  %.4201 = load i32, i32* %.23
  %.4202 = srem i32 %.4201, 2
  %.4203 = icmp eq i32 %.4202, 0
  br i1 %.4203, label %.4199, label %.4200
.4194:
  %.4217 = load i32, i32* %.23
  %.4218 = srem i32 %.4217, 2
  %.4219 = icmp ne i32 %.4218, 0
  br i1 %.4219, label %.4215, label %.4216
.4199:
  %.4205 = load i32, i32* %.20
  %.4206 = load i32, i32* %.21
  %.4207 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4206
  %.4208 = load i32, i32* %.4207
  %.4209 = mul i32 1, %.4208
  %.4210 = add i32 %.4205, %.4209
  store i32 %.4210, i32* %.20
  br label %.4200 
.4200:
  br label %.4213 
.4213:
  %.4230 = load i32, i32* %.22
  %.4231 = sdiv i32 %.4230, 2
  store i32 %.4231, i32* %.22
  %.4233 = load i32, i32* %.23
  %.4234 = sdiv i32 %.4233, 2
  store i32 %.4234, i32* %.23
  %.4236 = load i32, i32* %.21
  %.4237 = add i32 %.4236, 1
  store i32 %.4237, i32* %.21
  br label %.4186wc1281 
.4215:
  %.4221 = load i32, i32* %.20
  %.4222 = load i32, i32* %.21
  %.4223 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4222
  %.4224 = load i32, i32* %.4223
  %.4225 = mul i32 1, %.4224
  %.4226 = add i32 %.4221, %.4225
  store i32 %.4226, i32* %.20
  br label %.4216 
.4216:
  br label %.4213 
.4248wc1298:
  %.4252 = load i32, i32* %.21
  %.4253 = icmp slt i32 %.4252, 16
  br i1 %.4253, label %.4249wloop.1298.1305, label %.4250wn1305
.4249wloop.1298.1305:
  %.4257 = load i32, i32* %.22
  %.4258 = srem i32 %.4257, 2
  %.4259 = icmp ne i32 %.4258, 0
  br i1 %.4259, label %.4260, label %.4256
.4250wn1305:
  %.4284 = load i32, i32* %.20
  store i32 %.4284, i32* %.4169
  br label %.4287 
.4255:
  %.4266 = load i32, i32* %.20
  %.4267 = load i32, i32* %.21
  %.4268 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4267
  %.4269 = load i32, i32* %.4268
  %.4270 = mul i32 1, %.4269
  %.4271 = add i32 %.4266, %.4270
  store i32 %.4271, i32* %.20
  br label %.4256 
.4256:
  %.4274 = load i32, i32* %.22
  %.4275 = sdiv i32 %.4274, 2
  store i32 %.4275, i32* %.22
  %.4277 = load i32, i32* %.23
  %.4278 = sdiv i32 %.4277, 2
  store i32 %.4278, i32* %.23
  %.4280 = load i32, i32* %.21
  %.4281 = add i32 %.4280, 1
  store i32 %.4281, i32* %.21
  br label %.4248wc1298 
.4260:
  %.4262 = load i32, i32* %.23
  %.4263 = srem i32 %.4262, 2
  %.4264 = icmp ne i32 %.4263, 0
  br i1 %.4264, label %.4255, label %.4256
.4286:
  store i32 0, i32* %.20
  br label %.4290 
.4287:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4294 = load i32, i32* %.4169
  %.4295 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.4296 = load i32, i32* %.4295
  %.4297 = mul i32 %.4294, %.4296
  store i32 %.4297, i32* %.22
  store i32 65535, i32* %.23
  br label %.4300wc1314 
.4290:
  %.4337 = load i32, i32* %.20
  store i32 %.4337, i32* %.4169
  %.4339 = load i32, i32* %.4172
  store i32 %.4339, i32* %.4166
  br label %.4173wc1276 
.4300wc1314:
  %.4304 = load i32, i32* %.21
  %.4305 = icmp slt i32 %.4304, 16
  br i1 %.4305, label %.4301wloop.1314.1321, label %.4302wn1321
.4301wloop.1314.1321:
  %.4309 = load i32, i32* %.22
  %.4310 = srem i32 %.4309, 2
  %.4311 = icmp ne i32 %.4310, 0
  br i1 %.4311, label %.4312, label %.4308
.4302wn1321:
  br label %.4290 
.4307:
  %.4318 = load i32, i32* %.20
  %.4319 = load i32, i32* %.21
  %.4320 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4319
  %.4321 = load i32, i32* %.4320
  %.4322 = mul i32 1, %.4321
  %.4323 = add i32 %.4318, %.4322
  store i32 %.4323, i32* %.20
  br label %.4308 
.4308:
  %.4326 = load i32, i32* %.22
  %.4327 = sdiv i32 %.4326, 2
  store i32 %.4327, i32* %.22
  %.4329 = load i32, i32* %.23
  %.4330 = sdiv i32 %.4329, 2
  store i32 %.4330, i32* %.23
  %.4332 = load i32, i32* %.21
  %.4333 = add i32 %.4332, 1
  store i32 %.4333, i32* %.21
  br label %.4300wc1314 
.4312:
  %.4314 = load i32, i32* %.23
  %.4315 = srem i32 %.4314, 2
  %.4316 = icmp ne i32 %.4315, 0
  br i1 %.4316, label %.4307, label %.4308
.4349:
  %.4356 = load i32, i32* %.22
  %.4357 = icmp slt i32 %.4356, 0
  br i1 %.4357, label %.4354, label %.4355
.4350:
  %.4368 = load i32, i32* %.23
  %.4369 = icmp sgt i32 %.4368, 0
  br i1 %.4369, label %.4366, label %.4367
.4354:
  store i32 65535, i32* %.20
  br label %.4360 
.4355:
  store i32 0, i32* %.20
  br label %.4360 
.4360:
  br label %.4364 
.4364:
  %.4406 = load i32, i32* %.20
  store i32 %.4406, i32* %.3927
  br label %.3932wc1204 
.4366:
  %.4373 = load i32, i32* %.22
  %.4374 = icmp sgt i32 %.4373, 32767
  br i1 %.4374, label %.4371, label %.4372
.4367:
  %.4402 = load i32, i32* %.22
  store i32 %.4402, i32* %.20
  br label %.4400 
.4371:
  %.4376 = load i32, i32* %.22
  %.4377 = load i32, i32* %.23
  %.4378 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4377
  %.4379 = load i32, i32* %.4378
  %.4380 = sdiv i32 %.4376, %.4379
  store i32 %.4380, i32* %.22
  %.4382 = load i32, i32* %.22
  %.4383 = add i32 %.4382, 65536
  %.4384 = load i32, i32* %.23
  %.4385 = sub i32 15, %.4384
  %.4386 = add i32 %.4385, 1
  %.4387 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4386
  %.4388 = load i32, i32* %.4387
  %.4389 = sub i32 %.4383, %.4388
  store i32 %.4389, i32* %.20
  br label %.4391 
.4372:
  %.4393 = load i32, i32* %.22
  %.4394 = load i32, i32* %.23
  %.4395 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4394
  %.4396 = load i32, i32* %.4395
  %.4397 = sdiv i32 %.4393, %.4396
  store i32 %.4397, i32* %.20
  br label %.4391 
.4391:
  br label %.4400 
.4400:
  br label %.4364 
.4416:
  %.4423 = load i32, i32* %.22
  %.4424 = icmp slt i32 %.4423, 0
  br i1 %.4424, label %.4421, label %.4422
.4417:
  %.4435 = load i32, i32* %.23
  %.4436 = icmp sgt i32 %.4435, 0
  br i1 %.4436, label %.4433, label %.4434
.4421:
  store i32 65535, i32* %.20
  br label %.4427 
.4422:
  store i32 0, i32* %.20
  br label %.4427 
.4427:
  br label %.4431 
.4431:
  %.4473 = load i32, i32* %.20
  store i32 %.4473, i32* %.3376
  br label %.3381wc1037 
.4433:
  %.4440 = load i32, i32* %.22
  %.4441 = icmp sgt i32 %.4440, 32767
  br i1 %.4441, label %.4438, label %.4439
.4434:
  %.4469 = load i32, i32* %.22
  store i32 %.4469, i32* %.20
  br label %.4467 
.4438:
  %.4443 = load i32, i32* %.22
  %.4444 = load i32, i32* %.23
  %.4445 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4444
  %.4446 = load i32, i32* %.4445
  %.4447 = sdiv i32 %.4443, %.4446
  store i32 %.4447, i32* %.22
  %.4449 = load i32, i32* %.22
  %.4450 = add i32 %.4449, 65536
  %.4451 = load i32, i32* %.23
  %.4452 = sub i32 15, %.4451
  %.4453 = add i32 %.4452, 1
  %.4454 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4453
  %.4455 = load i32, i32* %.4454
  %.4456 = sub i32 %.4450, %.4455
  store i32 %.4456, i32* %.20
  br label %.4458 
.4439:
  %.4460 = load i32, i32* %.22
  %.4461 = load i32, i32* %.23
  %.4462 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4461
  %.4463 = load i32, i32* %.4462
  %.4464 = sdiv i32 %.4460, %.4463
  store i32 %.4464, i32* %.20
  br label %.4458 
.4458:
  br label %.4467 
.4467:
  br label %.4431 
.4478:
  ret i32 1 
.4479:
  %.4487 = load i32, i32* %.24
  %.4488 = add i32 %.4487, 1
  store i32 %.4488, i32* %.24
  br label %.3367wc1034 
}
define i32 @main(){
.4493:
  %.4494at1381 = call i32 @long_func()
  ret i32 %.4494at1381 
}
@.g.SHIFT_TABLE = global [16 x i32]  [i32 1, i32 2, i32 4, i32 8, i32 16, i32 32, i32 64, i32 128, i32 256, i32 512, i32 1024, i32 2048, i32 4096, i32 8192, i32 16384, i32 32768]
define i32 @long_func(){
.19:
  %.4172 = alloca i32
  %.4169 = alloca i32
  %.4166 = alloca i32
  %.3991 = alloca i32
  %.3988 = alloca i32
  %.3985 = alloca i32
  %.3930 = alloca i32
  %.3927 = alloca i32
  %.3924 = alloca i32
  %.3682 = alloca i32
  %.3679 = alloca i32
  %.3676 = alloca i32
  %.3501 = alloca i32
  %.3498 = alloca i32
  %.3495 = alloca i32
  %.3440 = alloca i32
  %.3437 = alloca i32
  %.3434 = alloca i32
  %.3379 = alloca i32
  %.3376 = alloca i32
  %.3374 = alloca i32
  %.3053 = alloca i32
  %.3050 = alloca i32
  %.3047 = alloca i32
  %.2872 = alloca i32
  %.2869 = alloca i32
  %.2866 = alloca i32
  %.2811 = alloca i32
  %.2808 = alloca i32
  %.2805 = alloca i32
  %.2563 = alloca i32
  %.2560 = alloca i32
  %.2557 = alloca i32
  %.2382 = alloca i32
  %.2379 = alloca i32
  %.2376 = alloca i32
  %.2321 = alloca i32
  %.2318 = alloca i32
  %.2315 = alloca i32
  %.2260 = alloca i32
  %.2257 = alloca i32
  %.2255 = alloca i32
  %.1938 = alloca i32
  %.1935 = alloca i32
  %.1932 = alloca i32
  %.1757 = alloca i32
  %.1754 = alloca i32
  %.1751 = alloca i32
  %.1696 = alloca i32
  %.1693 = alloca i32
  %.1690 = alloca i32
  %.1448 = alloca i32
  %.1445 = alloca i32
  %.1442 = alloca i32
  %.1267 = alloca i32
  %.1264 = alloca i32
  %.1261 = alloca i32
  %.1206 = alloca i32
  %.1203 = alloca i32
  %.1200 = alloca i32
  %.1145 = alloca i32
  %.1143 = alloca i32
  %.1141 = alloca i32
  %.829 = alloca i32
  %.826 = alloca i32
  %.823 = alloca i32
  %.648 = alloca i32
  %.645 = alloca i32
  %.642 = alloca i32
  %.587 = alloca i32
  %.584 = alloca i32
  %.581 = alloca i32
  %.337 = alloca i32
  %.334 = alloca i32
  %.331 = alloca i32
  %.152 = alloca i32
  %.149 = alloca i32
  %.146 = alloca i32
  %.91 = alloca i32
  %.88 = alloca i32
  %.85 = alloca i32
  %.30 = alloca i32
  %.27 = alloca i32
  %.25 = alloca i32
  %.24 = alloca i32
  %.23 = alloca i32
  %.22 = alloca i32
  %.21 = alloca i32
  %.20 = alloca i32
  store i32 2, i32* %.25
  store i32 0, i32* %.27
  store i32 1, i32* %.30
  br label %.32wc8 
.32wc8:
  %.36 = load i32, i32* %.27
  %.37 = icmp sgt i32 %.36, 0
  br i1 %.37, label %.33wloop.8.342, label %.34wn342
.33wloop.8.342:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.41 = load i32, i32* %.27
  store i32 %.41, i32* %.22
  store i32 1, i32* %.23
  br label %.44wc13 
.34wn342:
  %.1133 = load i32, i32* %.30
  store i32 %.1133, i32* %.20
  %.1135 = load i32, i32* %.20
  call void @putint(i32 %.1135)
  call void @putch(i32 10)
  store i32 2, i32* %.1141
  store i32 1, i32* %.1143
  store i32 1, i32* %.1145
  br label %.1147wc349 
.44wc13:
  %.48 = load i32, i32* %.21
  %.49 = icmp slt i32 %.48, 16
  br i1 %.49, label %.45wloop.13.20, label %.46wn20
.45wloop.13.20:
  %.53 = load i32, i32* %.22
  %.54 = srem i32 %.53, 2
  %.55 = icmp ne i32 %.54, 0
  br i1 %.55, label %.56, label %.52
.46wn20:
  %.82 = load i32, i32* %.20
  %.83 = icmp ne i32 %.82, 0
  br i1 %.83, label %.80, label %.81
.51:
  %.62 = load i32, i32* %.20
  %.63 = load i32, i32* %.21
  %.64 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.63
  %.65 = load i32, i32* %.64
  %.66 = mul i32 1, %.65
  %.67 = add i32 %.62, %.66
  store i32 %.67, i32* %.20
  br label %.52 
.52:
  %.70 = load i32, i32* %.22
  %.71 = sdiv i32 %.70, 2
  store i32 %.71, i32* %.22
  %.73 = load i32, i32* %.23
  %.74 = sdiv i32 %.73, 2
  store i32 %.74, i32* %.23
  %.76 = load i32, i32* %.21
  %.77 = add i32 %.76, 1
  store i32 %.77, i32* %.21
  br label %.44wc13 
.56:
  %.58 = load i32, i32* %.23
  %.59 = srem i32 %.58, 2
  %.60 = icmp ne i32 %.59, 0
  br i1 %.60, label %.51, label %.52
.80:
  %.86 = load i32, i32* %.30
  store i32 %.86, i32* %.85
  %.89 = load i32, i32* %.25
  store i32 %.89, i32* %.88
  store i32 0, i32* %.91
  br label %.93wc24 
.81:
  %.582 = load i32, i32* %.25
  store i32 %.582, i32* %.581
  %.585 = load i32, i32* %.25
  store i32 %.585, i32* %.584
  store i32 0, i32* %.587
  br label %.589wc175 
.93wc24:
  %.97 = load i32, i32* %.88
  %.98 = icmp ne i32 %.97, 0
  br i1 %.98, label %.94wloop.24.168, label %.95wn168
.94wloop.24.168:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.102 = load i32, i32* %.88
  store i32 %.102, i32* %.22
  store i32 1, i32* %.23
  br label %.105wc29 
.95wn168:
  %.576 = load i32, i32* %.91
  store i32 %.576, i32* %.20
  %.578 = load i32, i32* %.20
  store i32 %.578, i32* %.30
  br label %.81 
.105wc29:
  %.109 = load i32, i32* %.21
  %.110 = icmp slt i32 %.109, 16
  br i1 %.110, label %.106wloop.29.36, label %.107wn36
.106wloop.29.36:
  %.114 = load i32, i32* %.22
  %.115 = srem i32 %.114, 2
  %.116 = icmp ne i32 %.115, 0
  br i1 %.116, label %.117, label %.113
.107wn36:
  %.143 = load i32, i32* %.20
  %.144 = icmp ne i32 %.143, 0
  br i1 %.144, label %.141, label %.142
.112:
  %.123 = load i32, i32* %.20
  %.124 = load i32, i32* %.21
  %.125 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.124
  %.126 = load i32, i32* %.125
  %.127 = mul i32 1, %.126
  %.128 = add i32 %.123, %.127
  store i32 %.128, i32* %.20
  br label %.113 
.113:
  %.131 = load i32, i32* %.22
  %.132 = sdiv i32 %.131, 2
  store i32 %.132, i32* %.22
  %.134 = load i32, i32* %.23
  %.135 = sdiv i32 %.134, 2
  store i32 %.135, i32* %.23
  %.137 = load i32, i32* %.21
  %.138 = add i32 %.137, 1
  store i32 %.138, i32* %.21
  br label %.105wc29 
.117:
  %.119 = load i32, i32* %.23
  %.120 = srem i32 %.119, 2
  %.121 = icmp ne i32 %.120, 0
  br i1 %.121, label %.112, label %.113
.141:
  %.147 = load i32, i32* %.91
  store i32 %.147, i32* %.146
  %.150 = load i32, i32* %.85
  store i32 %.150, i32* %.149
  br label %.153wc40 
.142:
  %.332 = load i32, i32* %.85
  store i32 %.332, i32* %.331
  %.335 = load i32, i32* %.85
  store i32 %.335, i32* %.334
  br label %.338wc96 
.153wc40:
  %.157 = load i32, i32* %.149
  %.158 = icmp ne i32 %.157, 0
  br i1 %.158, label %.154wloop.40.89, label %.155wn89
.154wloop.40.89:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.162 = load i32, i32* %.146
  store i32 %.162, i32* %.22
  %.164 = load i32, i32* %.149
  store i32 %.164, i32* %.23
  br label %.166wc45 
.155wn89:
  %.326 = load i32, i32* %.146
  store i32 %.326, i32* %.20
  %.328 = load i32, i32* %.20
  store i32 %.328, i32* %.91
  br label %.142 
.166wc45:
  %.170 = load i32, i32* %.21
  %.171 = icmp slt i32 %.170, 16
  br i1 %.171, label %.167wloop.45.56, label %.168wn56
.167wloop.45.56:
  %.175 = load i32, i32* %.22
  %.176 = srem i32 %.175, 2
  %.177 = icmp ne i32 %.176, 0
  br i1 %.177, label %.173, label %.174
.168wn56:
  %.220 = load i32, i32* %.20
  store i32 %.220, i32* %.152
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.224 = load i32, i32* %.146
  store i32 %.224, i32* %.22
  %.226 = load i32, i32* %.149
  store i32 %.226, i32* %.23
  br label %.228wc62 
.173:
  %.181 = load i32, i32* %.23
  %.182 = srem i32 %.181, 2
  %.183 = icmp eq i32 %.182, 0
  br i1 %.183, label %.179, label %.180
.174:
  %.197 = load i32, i32* %.23
  %.198 = srem i32 %.197, 2
  %.199 = icmp ne i32 %.198, 0
  br i1 %.199, label %.195, label %.196
.179:
  %.185 = load i32, i32* %.20
  %.186 = load i32, i32* %.21
  %.187 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.186
  %.188 = load i32, i32* %.187
  %.189 = mul i32 1, %.188
  %.190 = add i32 %.185, %.189
  store i32 %.190, i32* %.20
  br label %.180 
.180:
  br label %.193 
.193:
  %.210 = load i32, i32* %.22
  %.211 = sdiv i32 %.210, 2
  store i32 %.211, i32* %.22
  %.213 = load i32, i32* %.23
  %.214 = sdiv i32 %.213, 2
  store i32 %.214, i32* %.23
  %.216 = load i32, i32* %.21
  %.217 = add i32 %.216, 1
  store i32 %.217, i32* %.21
  br label %.166wc45 
.195:
  %.201 = load i32, i32* %.20
  %.202 = load i32, i32* %.21
  %.203 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.202
  %.204 = load i32, i32* %.203
  %.205 = mul i32 1, %.204
  %.206 = add i32 %.201, %.205
  store i32 %.206, i32* %.20
  br label %.196 
.196:
  br label %.193 
.228wc62:
  %.232 = load i32, i32* %.21
  %.233 = icmp slt i32 %.232, 16
  br i1 %.233, label %.229wloop.62.69, label %.230wn69
.229wloop.62.69:
  %.237 = load i32, i32* %.22
  %.238 = srem i32 %.237, 2
  %.239 = icmp ne i32 %.238, 0
  br i1 %.239, label %.240, label %.236
.230wn69:
  %.264 = load i32, i32* %.20
  store i32 %.264, i32* %.149
  br label %.267 
.235:
  %.246 = load i32, i32* %.20
  %.247 = load i32, i32* %.21
  %.248 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.247
  %.249 = load i32, i32* %.248
  %.250 = mul i32 1, %.249
  %.251 = add i32 %.246, %.250
  store i32 %.251, i32* %.20
  br label %.236 
.236:
  %.254 = load i32, i32* %.22
  %.255 = sdiv i32 %.254, 2
  store i32 %.255, i32* %.22
  %.257 = load i32, i32* %.23
  %.258 = sdiv i32 %.257, 2
  store i32 %.258, i32* %.23
  %.260 = load i32, i32* %.21
  %.261 = add i32 %.260, 1
  store i32 %.261, i32* %.21
  br label %.228wc62 
.240:
  %.242 = load i32, i32* %.23
  %.243 = srem i32 %.242, 2
  %.244 = icmp ne i32 %.243, 0
  br i1 %.244, label %.235, label %.236
.266:
  store i32 0, i32* %.20
  br label %.273 
.267:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.277 = load i32, i32* %.149
  %.278 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.279 = load i32, i32* %.278
  %.280 = mul i32 %.277, %.279
  store i32 %.280, i32* %.22
  store i32 65535, i32* %.23
  br label %.284wc78 
.273:
  %.321 = load i32, i32* %.20
  store i32 %.321, i32* %.149
  %.323 = load i32, i32* %.152
  store i32 %.323, i32* %.146
  br label %.153wc40 
.284wc78:
  %.288 = load i32, i32* %.21
  %.289 = icmp slt i32 %.288, 16
  br i1 %.289, label %.285wloop.78.85, label %.286wn85
.285wloop.78.85:
  %.293 = load i32, i32* %.22
  %.294 = srem i32 %.293, 2
  %.295 = icmp ne i32 %.294, 0
  br i1 %.295, label %.296, label %.292
.286wn85:
  br label %.273 
.291:
  %.302 = load i32, i32* %.20
  %.303 = load i32, i32* %.21
  %.304 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.303
  %.305 = load i32, i32* %.304
  %.306 = mul i32 1, %.305
  %.307 = add i32 %.302, %.306
  store i32 %.307, i32* %.20
  br label %.292 
.292:
  %.310 = load i32, i32* %.22
  %.311 = sdiv i32 %.310, 2
  store i32 %.311, i32* %.22
  %.313 = load i32, i32* %.23
  %.314 = sdiv i32 %.313, 2
  store i32 %.314, i32* %.23
  %.316 = load i32, i32* %.21
  %.317 = add i32 %.316, 1
  store i32 %.317, i32* %.21
  br label %.284wc78 
.296:
  %.298 = load i32, i32* %.23
  %.299 = srem i32 %.298, 2
  %.300 = icmp ne i32 %.299, 0
  br i1 %.300, label %.291, label %.292
.338wc96:
  %.342 = load i32, i32* %.334
  %.343 = icmp ne i32 %.342, 0
  br i1 %.343, label %.339wloop.96.145, label %.340wn145
.339wloop.96.145:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.347 = load i32, i32* %.331
  store i32 %.347, i32* %.22
  %.349 = load i32, i32* %.334
  store i32 %.349, i32* %.23
  br label %.351wc101 
.340wn145:
  %.507 = load i32, i32* %.331
  store i32 %.507, i32* %.20
  %.509 = load i32, i32* %.20
  store i32 %.509, i32* %.85
  %.511 = load i32, i32* %.88
  store i32 %.511, i32* %.22
  store i32 1, i32* %.23
  %.516 = load i32, i32* %.23
  %.517 = icmp sge i32 %.516, 15
  br i1 %.517, label %.514, label %.515
.351wc101:
  %.355 = load i32, i32* %.21
  %.356 = icmp slt i32 %.355, 16
  br i1 %.356, label %.352wloop.101.112, label %.353wn112
.352wloop.101.112:
  %.360 = load i32, i32* %.22
  %.361 = srem i32 %.360, 2
  %.362 = icmp ne i32 %.361, 0
  br i1 %.362, label %.358, label %.359
.353wn112:
  %.405 = load i32, i32* %.20
  store i32 %.405, i32* %.337
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.409 = load i32, i32* %.331
  store i32 %.409, i32* %.22
  %.411 = load i32, i32* %.334
  store i32 %.411, i32* %.23
  br label %.413wc118 
.358:
  %.366 = load i32, i32* %.23
  %.367 = srem i32 %.366, 2
  %.368 = icmp eq i32 %.367, 0
  br i1 %.368, label %.364, label %.365
.359:
  %.382 = load i32, i32* %.23
  %.383 = srem i32 %.382, 2
  %.384 = icmp ne i32 %.383, 0
  br i1 %.384, label %.380, label %.381
.364:
  %.370 = load i32, i32* %.20
  %.371 = load i32, i32* %.21
  %.372 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.371
  %.373 = load i32, i32* %.372
  %.374 = mul i32 1, %.373
  %.375 = add i32 %.370, %.374
  store i32 %.375, i32* %.20
  br label %.365 
.365:
  br label %.378 
.378:
  %.395 = load i32, i32* %.22
  %.396 = sdiv i32 %.395, 2
  store i32 %.396, i32* %.22
  %.398 = load i32, i32* %.23
  %.399 = sdiv i32 %.398, 2
  store i32 %.399, i32* %.23
  %.401 = load i32, i32* %.21
  %.402 = add i32 %.401, 1
  store i32 %.402, i32* %.21
  br label %.351wc101 
.380:
  %.386 = load i32, i32* %.20
  %.387 = load i32, i32* %.21
  %.388 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.387
  %.389 = load i32, i32* %.388
  %.390 = mul i32 1, %.389
  %.391 = add i32 %.386, %.390
  store i32 %.391, i32* %.20
  br label %.381 
.381:
  br label %.378 
.413wc118:
  %.417 = load i32, i32* %.21
  %.418 = icmp slt i32 %.417, 16
  br i1 %.418, label %.414wloop.118.125, label %.415wn125
.414wloop.118.125:
  %.422 = load i32, i32* %.22
  %.423 = srem i32 %.422, 2
  %.424 = icmp ne i32 %.423, 0
  br i1 %.424, label %.425, label %.421
.415wn125:
  %.449 = load i32, i32* %.20
  store i32 %.449, i32* %.334
  br label %.452 
.420:
  %.431 = load i32, i32* %.20
  %.432 = load i32, i32* %.21
  %.433 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.432
  %.434 = load i32, i32* %.433
  %.435 = mul i32 1, %.434
  %.436 = add i32 %.431, %.435
  store i32 %.436, i32* %.20
  br label %.421 
.421:
  %.439 = load i32, i32* %.22
  %.440 = sdiv i32 %.439, 2
  store i32 %.440, i32* %.22
  %.442 = load i32, i32* %.23
  %.443 = sdiv i32 %.442, 2
  store i32 %.443, i32* %.23
  %.445 = load i32, i32* %.21
  %.446 = add i32 %.445, 1
  store i32 %.446, i32* %.21
  br label %.413wc118 
.425:
  %.427 = load i32, i32* %.23
  %.428 = srem i32 %.427, 2
  %.429 = icmp ne i32 %.428, 0
  br i1 %.429, label %.420, label %.421
.451:
  store i32 0, i32* %.20
  br label %.455 
.452:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.459 = load i32, i32* %.334
  %.460 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.461 = load i32, i32* %.460
  %.462 = mul i32 %.459, %.461
  store i32 %.462, i32* %.22
  store i32 65535, i32* %.23
  br label %.465wc134 
.455:
  %.502 = load i32, i32* %.20
  store i32 %.502, i32* %.334
  %.504 = load i32, i32* %.337
  store i32 %.504, i32* %.331
  br label %.338wc96 
.465wc134:
  %.469 = load i32, i32* %.21
  %.470 = icmp slt i32 %.469, 16
  br i1 %.470, label %.466wloop.134.141, label %.467wn141
.466wloop.134.141:
  %.474 = load i32, i32* %.22
  %.475 = srem i32 %.474, 2
  %.476 = icmp ne i32 %.475, 0
  br i1 %.476, label %.477, label %.473
.467wn141:
  br label %.455 
.472:
  %.483 = load i32, i32* %.20
  %.484 = load i32, i32* %.21
  %.485 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.484
  %.486 = load i32, i32* %.485
  %.487 = mul i32 1, %.486
  %.488 = add i32 %.483, %.487
  store i32 %.488, i32* %.20
  br label %.473 
.473:
  %.491 = load i32, i32* %.22
  %.492 = sdiv i32 %.491, 2
  store i32 %.492, i32* %.22
  %.494 = load i32, i32* %.23
  %.495 = sdiv i32 %.494, 2
  store i32 %.495, i32* %.23
  %.497 = load i32, i32* %.21
  %.498 = add i32 %.497, 1
  store i32 %.498, i32* %.21
  br label %.465wc134 
.477:
  %.479 = load i32, i32* %.23
  %.480 = srem i32 %.479, 2
  %.481 = icmp ne i32 %.480, 0
  br i1 %.481, label %.472, label %.473
.514:
  %.521 = load i32, i32* %.22
  %.522 = icmp slt i32 %.521, 0
  br i1 %.522, label %.519, label %.520
.515:
  %.533 = load i32, i32* %.23
  %.534 = icmp sgt i32 %.533, 0
  br i1 %.534, label %.531, label %.532
.519:
  store i32 65535, i32* %.20
  br label %.525 
.520:
  store i32 0, i32* %.20
  br label %.525 
.525:
  br label %.529 
.529:
  %.573 = load i32, i32* %.20
  store i32 %.573, i32* %.88
  br label %.93wc24 
.531:
  %.538 = load i32, i32* %.22
  %.540 = icmp sgt i32 %.538, 32767
  br i1 %.540, label %.536, label %.537
.532:
  %.569 = load i32, i32* %.22
  store i32 %.569, i32* %.20
  br label %.567 
.536:
  %.542 = load i32, i32* %.22
  %.543 = load i32, i32* %.23
  %.544 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.543
  %.545 = load i32, i32* %.544
  %.546 = sdiv i32 %.542, %.545
  store i32 %.546, i32* %.22
  %.548 = load i32, i32* %.22
  %.550 = add i32 %.548, 65536
  %.551 = load i32, i32* %.23
  %.552 = sub i32 15, %.551
  %.553 = add i32 %.552, 1
  %.554 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.553
  %.555 = load i32, i32* %.554
  %.556 = sub i32 %.550, %.555
  store i32 %.556, i32* %.20
  br label %.558 
.537:
  %.560 = load i32, i32* %.22
  %.561 = load i32, i32* %.23
  %.562 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.561
  %.563 = load i32, i32* %.562
  %.564 = sdiv i32 %.560, %.563
  store i32 %.564, i32* %.20
  br label %.558 
.558:
  br label %.567 
.567:
  br label %.529 
.589wc175:
  %.593 = load i32, i32* %.584
  %.594 = icmp ne i32 %.593, 0
  br i1 %.594, label %.590wloop.175.319, label %.591wn319
.590wloop.175.319:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.598 = load i32, i32* %.584
  store i32 %.598, i32* %.22
  store i32 1, i32* %.23
  br label %.601wc180 
.591wn319:
  %.1066 = load i32, i32* %.587
  store i32 %.1066, i32* %.20
  %.1068 = load i32, i32* %.20
  store i32 %.1068, i32* %.25
  %.1070 = load i32, i32* %.27
  store i32 %.1070, i32* %.22
  store i32 1, i32* %.23
  %.1075 = load i32, i32* %.23
  %.1076 = icmp sge i32 %.1075, 15
  br i1 %.1076, label %.1073, label %.1074
.601wc180:
  %.605 = load i32, i32* %.21
  %.606 = icmp slt i32 %.605, 16
  br i1 %.606, label %.602wloop.180.187, label %.603wn187
.602wloop.180.187:
  %.610 = load i32, i32* %.22
  %.611 = srem i32 %.610, 2
  %.612 = icmp ne i32 %.611, 0
  br i1 %.612, label %.613, label %.609
.603wn187:
  %.639 = load i32, i32* %.20
  %.640 = icmp ne i32 %.639, 0
  br i1 %.640, label %.637, label %.638
.608:
  %.619 = load i32, i32* %.20
  %.620 = load i32, i32* %.21
  %.621 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.620
  %.622 = load i32, i32* %.621
  %.623 = mul i32 1, %.622
  %.624 = add i32 %.619, %.623
  store i32 %.624, i32* %.20
  br label %.609 
.609:
  %.627 = load i32, i32* %.22
  %.628 = sdiv i32 %.627, 2
  store i32 %.628, i32* %.22
  %.630 = load i32, i32* %.23
  %.631 = sdiv i32 %.630, 2
  store i32 %.631, i32* %.23
  %.633 = load i32, i32* %.21
  %.634 = add i32 %.633, 1
  store i32 %.634, i32* %.21
  br label %.601wc180 
.613:
  %.615 = load i32, i32* %.23
  %.616 = srem i32 %.615, 2
  %.617 = icmp ne i32 %.616, 0
  br i1 %.617, label %.608, label %.609
.637:
  %.643 = load i32, i32* %.587
  store i32 %.643, i32* %.642
  %.646 = load i32, i32* %.581
  store i32 %.646, i32* %.645
  br label %.649wc191 
.638:
  %.824 = load i32, i32* %.581
  store i32 %.824, i32* %.823
  %.827 = load i32, i32* %.581
  store i32 %.827, i32* %.826
  br label %.830wc247 
.649wc191:
  %.653 = load i32, i32* %.645
  %.654 = icmp ne i32 %.653, 0
  br i1 %.654, label %.650wloop.191.240, label %.651wn240
.650wloop.191.240:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.658 = load i32, i32* %.642
  store i32 %.658, i32* %.22
  %.660 = load i32, i32* %.645
  store i32 %.660, i32* %.23
  br label %.662wc196 
.651wn240:
  %.818 = load i32, i32* %.642
  store i32 %.818, i32* %.20
  %.820 = load i32, i32* %.20
  store i32 %.820, i32* %.587
  br label %.638 
.662wc196:
  %.666 = load i32, i32* %.21
  %.667 = icmp slt i32 %.666, 16
  br i1 %.667, label %.663wloop.196.207, label %.664wn207
.663wloop.196.207:
  %.671 = load i32, i32* %.22
  %.672 = srem i32 %.671, 2
  %.673 = icmp ne i32 %.672, 0
  br i1 %.673, label %.669, label %.670
.664wn207:
  %.716 = load i32, i32* %.20
  store i32 %.716, i32* %.648
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.720 = load i32, i32* %.642
  store i32 %.720, i32* %.22
  %.722 = load i32, i32* %.645
  store i32 %.722, i32* %.23
  br label %.724wc213 
.669:
  %.677 = load i32, i32* %.23
  %.678 = srem i32 %.677, 2
  %.679 = icmp eq i32 %.678, 0
  br i1 %.679, label %.675, label %.676
.670:
  %.693 = load i32, i32* %.23
  %.694 = srem i32 %.693, 2
  %.695 = icmp ne i32 %.694, 0
  br i1 %.695, label %.691, label %.692
.675:
  %.681 = load i32, i32* %.20
  %.682 = load i32, i32* %.21
  %.683 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.682
  %.684 = load i32, i32* %.683
  %.685 = mul i32 1, %.684
  %.686 = add i32 %.681, %.685
  store i32 %.686, i32* %.20
  br label %.676 
.676:
  br label %.689 
.689:
  %.706 = load i32, i32* %.22
  %.707 = sdiv i32 %.706, 2
  store i32 %.707, i32* %.22
  %.709 = load i32, i32* %.23
  %.710 = sdiv i32 %.709, 2
  store i32 %.710, i32* %.23
  %.712 = load i32, i32* %.21
  %.713 = add i32 %.712, 1
  store i32 %.713, i32* %.21
  br label %.662wc196 
.691:
  %.697 = load i32, i32* %.20
  %.698 = load i32, i32* %.21
  %.699 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.698
  %.700 = load i32, i32* %.699
  %.701 = mul i32 1, %.700
  %.702 = add i32 %.697, %.701
  store i32 %.702, i32* %.20
  br label %.692 
.692:
  br label %.689 
.724wc213:
  %.728 = load i32, i32* %.21
  %.729 = icmp slt i32 %.728, 16
  br i1 %.729, label %.725wloop.213.220, label %.726wn220
.725wloop.213.220:
  %.733 = load i32, i32* %.22
  %.734 = srem i32 %.733, 2
  %.735 = icmp ne i32 %.734, 0
  br i1 %.735, label %.736, label %.732
.726wn220:
  %.760 = load i32, i32* %.20
  store i32 %.760, i32* %.645
  br label %.763 
.731:
  %.742 = load i32, i32* %.20
  %.743 = load i32, i32* %.21
  %.744 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.743
  %.745 = load i32, i32* %.744
  %.746 = mul i32 1, %.745
  %.747 = add i32 %.742, %.746
  store i32 %.747, i32* %.20
  br label %.732 
.732:
  %.750 = load i32, i32* %.22
  %.751 = sdiv i32 %.750, 2
  store i32 %.751, i32* %.22
  %.753 = load i32, i32* %.23
  %.754 = sdiv i32 %.753, 2
  store i32 %.754, i32* %.23
  %.756 = load i32, i32* %.21
  %.757 = add i32 %.756, 1
  store i32 %.757, i32* %.21
  br label %.724wc213 
.736:
  %.738 = load i32, i32* %.23
  %.739 = srem i32 %.738, 2
  %.740 = icmp ne i32 %.739, 0
  br i1 %.740, label %.731, label %.732
.762:
  store i32 0, i32* %.20
  br label %.766 
.763:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.770 = load i32, i32* %.645
  %.771 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.772 = load i32, i32* %.771
  %.773 = mul i32 %.770, %.772
  store i32 %.773, i32* %.22
  store i32 65535, i32* %.23
  br label %.776wc229 
.766:
  %.813 = load i32, i32* %.20
  store i32 %.813, i32* %.645
  %.815 = load i32, i32* %.648
  store i32 %.815, i32* %.642
  br label %.649wc191 
.776wc229:
  %.780 = load i32, i32* %.21
  %.781 = icmp slt i32 %.780, 16
  br i1 %.781, label %.777wloop.229.236, label %.778wn236
.777wloop.229.236:
  %.785 = load i32, i32* %.22
  %.786 = srem i32 %.785, 2
  %.787 = icmp ne i32 %.786, 0
  br i1 %.787, label %.788, label %.784
.778wn236:
  br label %.766 
.783:
  %.794 = load i32, i32* %.20
  %.795 = load i32, i32* %.21
  %.796 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.795
  %.797 = load i32, i32* %.796
  %.798 = mul i32 1, %.797
  %.799 = add i32 %.794, %.798
  store i32 %.799, i32* %.20
  br label %.784 
.784:
  %.802 = load i32, i32* %.22
  %.803 = sdiv i32 %.802, 2
  store i32 %.803, i32* %.22
  %.805 = load i32, i32* %.23
  %.806 = sdiv i32 %.805, 2
  store i32 %.806, i32* %.23
  %.808 = load i32, i32* %.21
  %.809 = add i32 %.808, 1
  store i32 %.809, i32* %.21
  br label %.776wc229 
.788:
  %.790 = load i32, i32* %.23
  %.791 = srem i32 %.790, 2
  %.792 = icmp ne i32 %.791, 0
  br i1 %.792, label %.783, label %.784
.830wc247:
  %.834 = load i32, i32* %.826
  %.835 = icmp ne i32 %.834, 0
  br i1 %.835, label %.831wloop.247.296, label %.832wn296
.831wloop.247.296:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.839 = load i32, i32* %.823
  store i32 %.839, i32* %.22
  %.841 = load i32, i32* %.826
  store i32 %.841, i32* %.23
  br label %.843wc252 
.832wn296:
  %.999 = load i32, i32* %.823
  store i32 %.999, i32* %.20
  %.1001 = load i32, i32* %.20
  store i32 %.1001, i32* %.581
  %.1003 = load i32, i32* %.584
  store i32 %.1003, i32* %.22
  store i32 1, i32* %.23
  %.1008 = load i32, i32* %.23
  %.1009 = icmp sge i32 %.1008, 15
  br i1 %.1009, label %.1006, label %.1007
.843wc252:
  %.847 = load i32, i32* %.21
  %.848 = icmp slt i32 %.847, 16
  br i1 %.848, label %.844wloop.252.263, label %.845wn263
.844wloop.252.263:
  %.852 = load i32, i32* %.22
  %.853 = srem i32 %.852, 2
  %.854 = icmp ne i32 %.853, 0
  br i1 %.854, label %.850, label %.851
.845wn263:
  %.897 = load i32, i32* %.20
  store i32 %.897, i32* %.829
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.901 = load i32, i32* %.823
  store i32 %.901, i32* %.22
  %.903 = load i32, i32* %.826
  store i32 %.903, i32* %.23
  br label %.905wc269 
.850:
  %.858 = load i32, i32* %.23
  %.859 = srem i32 %.858, 2
  %.860 = icmp eq i32 %.859, 0
  br i1 %.860, label %.856, label %.857
.851:
  %.874 = load i32, i32* %.23
  %.875 = srem i32 %.874, 2
  %.876 = icmp ne i32 %.875, 0
  br i1 %.876, label %.872, label %.873
.856:
  %.862 = load i32, i32* %.20
  %.863 = load i32, i32* %.21
  %.864 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.863
  %.865 = load i32, i32* %.864
  %.866 = mul i32 1, %.865
  %.867 = add i32 %.862, %.866
  store i32 %.867, i32* %.20
  br label %.857 
.857:
  br label %.870 
.870:
  %.887 = load i32, i32* %.22
  %.888 = sdiv i32 %.887, 2
  store i32 %.888, i32* %.22
  %.890 = load i32, i32* %.23
  %.891 = sdiv i32 %.890, 2
  store i32 %.891, i32* %.23
  %.893 = load i32, i32* %.21
  %.894 = add i32 %.893, 1
  store i32 %.894, i32* %.21
  br label %.843wc252 
.872:
  %.878 = load i32, i32* %.20
  %.879 = load i32, i32* %.21
  %.880 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.879
  %.881 = load i32, i32* %.880
  %.882 = mul i32 1, %.881
  %.883 = add i32 %.878, %.882
  store i32 %.883, i32* %.20
  br label %.873 
.873:
  br label %.870 
.905wc269:
  %.909 = load i32, i32* %.21
  %.910 = icmp slt i32 %.909, 16
  br i1 %.910, label %.906wloop.269.276, label %.907wn276
.906wloop.269.276:
  %.914 = load i32, i32* %.22
  %.915 = srem i32 %.914, 2
  %.916 = icmp ne i32 %.915, 0
  br i1 %.916, label %.917, label %.913
.907wn276:
  %.941 = load i32, i32* %.20
  store i32 %.941, i32* %.826
  br label %.944 
.912:
  %.923 = load i32, i32* %.20
  %.924 = load i32, i32* %.21
  %.925 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.924
  %.926 = load i32, i32* %.925
  %.927 = mul i32 1, %.926
  %.928 = add i32 %.923, %.927
  store i32 %.928, i32* %.20
  br label %.913 
.913:
  %.931 = load i32, i32* %.22
  %.932 = sdiv i32 %.931, 2
  store i32 %.932, i32* %.22
  %.934 = load i32, i32* %.23
  %.935 = sdiv i32 %.934, 2
  store i32 %.935, i32* %.23
  %.937 = load i32, i32* %.21
  %.938 = add i32 %.937, 1
  store i32 %.938, i32* %.21
  br label %.905wc269 
.917:
  %.919 = load i32, i32* %.23
  %.920 = srem i32 %.919, 2
  %.921 = icmp ne i32 %.920, 0
  br i1 %.921, label %.912, label %.913
.943:
  store i32 0, i32* %.20
  br label %.947 
.944:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.951 = load i32, i32* %.826
  %.952 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.953 = load i32, i32* %.952
  %.954 = mul i32 %.951, %.953
  store i32 %.954, i32* %.22
  store i32 65535, i32* %.23
  br label %.957wc285 
.947:
  %.994 = load i32, i32* %.20
  store i32 %.994, i32* %.826
  %.996 = load i32, i32* %.829
  store i32 %.996, i32* %.823
  br label %.830wc247 
.957wc285:
  %.961 = load i32, i32* %.21
  %.962 = icmp slt i32 %.961, 16
  br i1 %.962, label %.958wloop.285.292, label %.959wn292
.958wloop.285.292:
  %.966 = load i32, i32* %.22
  %.967 = srem i32 %.966, 2
  %.968 = icmp ne i32 %.967, 0
  br i1 %.968, label %.969, label %.965
.959wn292:
  br label %.947 
.964:
  %.975 = load i32, i32* %.20
  %.976 = load i32, i32* %.21
  %.977 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.976
  %.978 = load i32, i32* %.977
  %.979 = mul i32 1, %.978
  %.980 = add i32 %.975, %.979
  store i32 %.980, i32* %.20
  br label %.965 
.965:
  %.983 = load i32, i32* %.22
  %.984 = sdiv i32 %.983, 2
  store i32 %.984, i32* %.22
  %.986 = load i32, i32* %.23
  %.987 = sdiv i32 %.986, 2
  store i32 %.987, i32* %.23
  %.989 = load i32, i32* %.21
  %.990 = add i32 %.989, 1
  store i32 %.990, i32* %.21
  br label %.957wc285 
.969:
  %.971 = load i32, i32* %.23
  %.972 = srem i32 %.971, 2
  %.973 = icmp ne i32 %.972, 0
  br i1 %.973, label %.964, label %.965
.1006:
  %.1013 = load i32, i32* %.22
  %.1014 = icmp slt i32 %.1013, 0
  br i1 %.1014, label %.1011, label %.1012
.1007:
  %.1025 = load i32, i32* %.23
  %.1026 = icmp sgt i32 %.1025, 0
  br i1 %.1026, label %.1023, label %.1024
.1011:
  store i32 65535, i32* %.20
  br label %.1017 
.1012:
  store i32 0, i32* %.20
  br label %.1017 
.1017:
  br label %.1021 
.1021:
  %.1063 = load i32, i32* %.20
  store i32 %.1063, i32* %.584
  br label %.589wc175 
.1023:
  %.1030 = load i32, i32* %.22
  %.1031 = icmp sgt i32 %.1030, 32767
  br i1 %.1031, label %.1028, label %.1029
.1024:
  %.1059 = load i32, i32* %.22
  store i32 %.1059, i32* %.20
  br label %.1057 
.1028:
  %.1033 = load i32, i32* %.22
  %.1034 = load i32, i32* %.23
  %.1035 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1034
  %.1036 = load i32, i32* %.1035
  %.1037 = sdiv i32 %.1033, %.1036
  store i32 %.1037, i32* %.22
  %.1039 = load i32, i32* %.22
  %.1040 = add i32 %.1039, 65536
  %.1041 = load i32, i32* %.23
  %.1042 = sub i32 15, %.1041
  %.1043 = add i32 %.1042, 1
  %.1044 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1043
  %.1045 = load i32, i32* %.1044
  %.1046 = sub i32 %.1040, %.1045
  store i32 %.1046, i32* %.20
  br label %.1048 
.1029:
  %.1050 = load i32, i32* %.22
  %.1051 = load i32, i32* %.23
  %.1052 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1051
  %.1053 = load i32, i32* %.1052
  %.1054 = sdiv i32 %.1050, %.1053
  store i32 %.1054, i32* %.20
  br label %.1048 
.1048:
  br label %.1057 
.1057:
  br label %.1021 
.1073:
  %.1080 = load i32, i32* %.22
  %.1081 = icmp slt i32 %.1080, 0
  br i1 %.1081, label %.1078, label %.1079
.1074:
  %.1092 = load i32, i32* %.23
  %.1093 = icmp sgt i32 %.1092, 0
  br i1 %.1093, label %.1090, label %.1091
.1078:
  store i32 65535, i32* %.20
  br label %.1084 
.1079:
  store i32 0, i32* %.20
  br label %.1084 
.1084:
  br label %.1088 
.1088:
  %.1130 = load i32, i32* %.20
  store i32 %.1130, i32* %.27
  br label %.32wc8 
.1090:
  %.1097 = load i32, i32* %.22
  %.1098 = icmp sgt i32 %.1097, 32767
  br i1 %.1098, label %.1095, label %.1096
.1091:
  %.1126 = load i32, i32* %.22
  store i32 %.1126, i32* %.20
  br label %.1124 
.1095:
  %.1100 = load i32, i32* %.22
  %.1101 = load i32, i32* %.23
  %.1102 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1101
  %.1103 = load i32, i32* %.1102
  %.1104 = sdiv i32 %.1100, %.1103
  store i32 %.1104, i32* %.22
  %.1106 = load i32, i32* %.22
  %.1107 = add i32 %.1106, 65536
  %.1108 = load i32, i32* %.23
  %.1109 = sub i32 15, %.1108
  %.1110 = add i32 %.1109, 1
  %.1111 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1110
  %.1112 = load i32, i32* %.1111
  %.1113 = sub i32 %.1107, %.1112
  store i32 %.1113, i32* %.20
  br label %.1115 
.1096:
  %.1117 = load i32, i32* %.22
  %.1118 = load i32, i32* %.23
  %.1119 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1118
  %.1120 = load i32, i32* %.1119
  %.1121 = sdiv i32 %.1117, %.1120
  store i32 %.1121, i32* %.20
  br label %.1115 
.1115:
  br label %.1124 
.1124:
  br label %.1088 
.1147wc349:
  %.1151 = load i32, i32* %.1143
  %.1152 = icmp sgt i32 %.1151, 0
  br i1 %.1152, label %.1148wloop.349.683, label %.1149wn683
.1148wloop.349.683:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1156 = load i32, i32* %.1143
  store i32 %.1156, i32* %.22
  store i32 1, i32* %.23
  br label %.1159wc354 
.1149wn683:
  %.2242 = load i32, i32* %.1145
  store i32 %.2242, i32* %.20
  %.2244 = load i32, i32* %.20
  call void @putint(i32 %.2244)
  call void @putch(i32 10)
  store i32 2, i32* %.24
  br label %.2248wc689 
.1159wc354:
  %.1163 = load i32, i32* %.21
  %.1164 = icmp slt i32 %.1163, 16
  br i1 %.1164, label %.1160wloop.354.361, label %.1161wn361
.1160wloop.354.361:
  %.1168 = load i32, i32* %.22
  %.1169 = srem i32 %.1168, 2
  %.1170 = icmp ne i32 %.1169, 0
  br i1 %.1170, label %.1171, label %.1167
.1161wn361:
  %.1197 = load i32, i32* %.20
  %.1198 = icmp ne i32 %.1197, 0
  br i1 %.1198, label %.1195, label %.1196
.1166:
  %.1177 = load i32, i32* %.20
  %.1178 = load i32, i32* %.21
  %.1179 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1178
  %.1180 = load i32, i32* %.1179
  %.1181 = mul i32 1, %.1180
  %.1182 = add i32 %.1177, %.1181
  store i32 %.1182, i32* %.20
  br label %.1167 
.1167:
  %.1185 = load i32, i32* %.22
  %.1186 = sdiv i32 %.1185, 2
  store i32 %.1186, i32* %.22
  %.1188 = load i32, i32* %.23
  %.1189 = sdiv i32 %.1188, 2
  store i32 %.1189, i32* %.23
  %.1191 = load i32, i32* %.21
  %.1192 = add i32 %.1191, 1
  store i32 %.1192, i32* %.21
  br label %.1159wc354 
.1171:
  %.1173 = load i32, i32* %.23
  %.1174 = srem i32 %.1173, 2
  %.1175 = icmp ne i32 %.1174, 0
  br i1 %.1175, label %.1166, label %.1167
.1195:
  %.1201 = load i32, i32* %.1145
  store i32 %.1201, i32* %.1200
  %.1204 = load i32, i32* %.1141
  store i32 %.1204, i32* %.1203
  store i32 0, i32* %.1206
  br label %.1208wc365 
.1196:
  %.1691 = load i32, i32* %.1141
  store i32 %.1691, i32* %.1690
  %.1694 = load i32, i32* %.1141
  store i32 %.1694, i32* %.1693
  store i32 0, i32* %.1696
  br label %.1698wc516 
.1208wc365:
  %.1212 = load i32, i32* %.1203
  %.1213 = icmp ne i32 %.1212, 0
  br i1 %.1213, label %.1209wloop.365.509, label %.1210wn509
.1209wloop.365.509:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1217 = load i32, i32* %.1203
  store i32 %.1217, i32* %.22
  store i32 1, i32* %.23
  br label %.1220wc370 
.1210wn509:
  %.1685 = load i32, i32* %.1206
  store i32 %.1685, i32* %.20
  %.1687 = load i32, i32* %.20
  store i32 %.1687, i32* %.1145
  br label %.1196 
.1220wc370:
  %.1224 = load i32, i32* %.21
  %.1225 = icmp slt i32 %.1224, 16
  br i1 %.1225, label %.1221wloop.370.377, label %.1222wn377
.1221wloop.370.377:
  %.1229 = load i32, i32* %.22
  %.1230 = srem i32 %.1229, 2
  %.1231 = icmp ne i32 %.1230, 0
  br i1 %.1231, label %.1232, label %.1228
.1222wn377:
  %.1258 = load i32, i32* %.20
  %.1259 = icmp ne i32 %.1258, 0
  br i1 %.1259, label %.1256, label %.1257
.1227:
  %.1238 = load i32, i32* %.20
  %.1239 = load i32, i32* %.21
  %.1240 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1239
  %.1241 = load i32, i32* %.1240
  %.1242 = mul i32 1, %.1241
  %.1243 = add i32 %.1238, %.1242
  store i32 %.1243, i32* %.20
  br label %.1228 
.1228:
  %.1246 = load i32, i32* %.22
  %.1247 = sdiv i32 %.1246, 2
  store i32 %.1247, i32* %.22
  %.1249 = load i32, i32* %.23
  %.1250 = sdiv i32 %.1249, 2
  store i32 %.1250, i32* %.23
  %.1252 = load i32, i32* %.21
  %.1253 = add i32 %.1252, 1
  store i32 %.1253, i32* %.21
  br label %.1220wc370 
.1232:
  %.1234 = load i32, i32* %.23
  %.1235 = srem i32 %.1234, 2
  %.1236 = icmp ne i32 %.1235, 0
  br i1 %.1236, label %.1227, label %.1228
.1256:
  %.1262 = load i32, i32* %.1206
  store i32 %.1262, i32* %.1261
  %.1265 = load i32, i32* %.1200
  store i32 %.1265, i32* %.1264
  br label %.1268wc381 
.1257:
  %.1443 = load i32, i32* %.1200
  store i32 %.1443, i32* %.1442
  %.1446 = load i32, i32* %.1200
  store i32 %.1446, i32* %.1445
  br label %.1449wc437 
.1268wc381:
  %.1272 = load i32, i32* %.1264
  %.1273 = icmp ne i32 %.1272, 0
  br i1 %.1273, label %.1269wloop.381.430, label %.1270wn430
.1269wloop.381.430:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1277 = load i32, i32* %.1261
  store i32 %.1277, i32* %.22
  %.1279 = load i32, i32* %.1264
  store i32 %.1279, i32* %.23
  br label %.1281wc386 
.1270wn430:
  %.1437 = load i32, i32* %.1261
  store i32 %.1437, i32* %.20
  %.1439 = load i32, i32* %.20
  store i32 %.1439, i32* %.1206
  br label %.1257 
.1281wc386:
  %.1285 = load i32, i32* %.21
  %.1286 = icmp slt i32 %.1285, 16
  br i1 %.1286, label %.1282wloop.386.397, label %.1283wn397
.1282wloop.386.397:
  %.1290 = load i32, i32* %.22
  %.1291 = srem i32 %.1290, 2
  %.1292 = icmp ne i32 %.1291, 0
  br i1 %.1292, label %.1288, label %.1289
.1283wn397:
  %.1335 = load i32, i32* %.20
  store i32 %.1335, i32* %.1267
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1339 = load i32, i32* %.1261
  store i32 %.1339, i32* %.22
  %.1341 = load i32, i32* %.1264
  store i32 %.1341, i32* %.23
  br label %.1343wc403 
.1288:
  %.1296 = load i32, i32* %.23
  %.1297 = srem i32 %.1296, 2
  %.1298 = icmp eq i32 %.1297, 0
  br i1 %.1298, label %.1294, label %.1295
.1289:
  %.1312 = load i32, i32* %.23
  %.1313 = srem i32 %.1312, 2
  %.1314 = icmp ne i32 %.1313, 0
  br i1 %.1314, label %.1310, label %.1311
.1294:
  %.1300 = load i32, i32* %.20
  %.1301 = load i32, i32* %.21
  %.1302 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1301
  %.1303 = load i32, i32* %.1302
  %.1304 = mul i32 1, %.1303
  %.1305 = add i32 %.1300, %.1304
  store i32 %.1305, i32* %.20
  br label %.1295 
.1295:
  br label %.1308 
.1308:
  %.1325 = load i32, i32* %.22
  %.1326 = sdiv i32 %.1325, 2
  store i32 %.1326, i32* %.22
  %.1328 = load i32, i32* %.23
  %.1329 = sdiv i32 %.1328, 2
  store i32 %.1329, i32* %.23
  %.1331 = load i32, i32* %.21
  %.1332 = add i32 %.1331, 1
  store i32 %.1332, i32* %.21
  br label %.1281wc386 
.1310:
  %.1316 = load i32, i32* %.20
  %.1317 = load i32, i32* %.21
  %.1318 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1317
  %.1319 = load i32, i32* %.1318
  %.1320 = mul i32 1, %.1319
  %.1321 = add i32 %.1316, %.1320
  store i32 %.1321, i32* %.20
  br label %.1311 
.1311:
  br label %.1308 
.1343wc403:
  %.1347 = load i32, i32* %.21
  %.1348 = icmp slt i32 %.1347, 16
  br i1 %.1348, label %.1344wloop.403.410, label %.1345wn410
.1344wloop.403.410:
  %.1352 = load i32, i32* %.22
  %.1353 = srem i32 %.1352, 2
  %.1354 = icmp ne i32 %.1353, 0
  br i1 %.1354, label %.1355, label %.1351
.1345wn410:
  %.1379 = load i32, i32* %.20
  store i32 %.1379, i32* %.1264
  br label %.1382 
.1350:
  %.1361 = load i32, i32* %.20
  %.1362 = load i32, i32* %.21
  %.1363 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1362
  %.1364 = load i32, i32* %.1363
  %.1365 = mul i32 1, %.1364
  %.1366 = add i32 %.1361, %.1365
  store i32 %.1366, i32* %.20
  br label %.1351 
.1351:
  %.1369 = load i32, i32* %.22
  %.1370 = sdiv i32 %.1369, 2
  store i32 %.1370, i32* %.22
  %.1372 = load i32, i32* %.23
  %.1373 = sdiv i32 %.1372, 2
  store i32 %.1373, i32* %.23
  %.1375 = load i32, i32* %.21
  %.1376 = add i32 %.1375, 1
  store i32 %.1376, i32* %.21
  br label %.1343wc403 
.1355:
  %.1357 = load i32, i32* %.23
  %.1358 = srem i32 %.1357, 2
  %.1359 = icmp ne i32 %.1358, 0
  br i1 %.1359, label %.1350, label %.1351
.1381:
  store i32 0, i32* %.20
  br label %.1385 
.1382:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1389 = load i32, i32* %.1264
  %.1390 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.1391 = load i32, i32* %.1390
  %.1392 = mul i32 %.1389, %.1391
  store i32 %.1392, i32* %.22
  store i32 65535, i32* %.23
  br label %.1395wc419 
.1385:
  %.1432 = load i32, i32* %.20
  store i32 %.1432, i32* %.1264
  %.1434 = load i32, i32* %.1267
  store i32 %.1434, i32* %.1261
  br label %.1268wc381 
.1395wc419:
  %.1399 = load i32, i32* %.21
  %.1400 = icmp slt i32 %.1399, 16
  br i1 %.1400, label %.1396wloop.419.426, label %.1397wn426
.1396wloop.419.426:
  %.1404 = load i32, i32* %.22
  %.1405 = srem i32 %.1404, 2
  %.1406 = icmp ne i32 %.1405, 0
  br i1 %.1406, label %.1407, label %.1403
.1397wn426:
  br label %.1385 
.1402:
  %.1413 = load i32, i32* %.20
  %.1414 = load i32, i32* %.21
  %.1415 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1414
  %.1416 = load i32, i32* %.1415
  %.1417 = mul i32 1, %.1416
  %.1418 = add i32 %.1413, %.1417
  store i32 %.1418, i32* %.20
  br label %.1403 
.1403:
  %.1421 = load i32, i32* %.22
  %.1422 = sdiv i32 %.1421, 2
  store i32 %.1422, i32* %.22
  %.1424 = load i32, i32* %.23
  %.1425 = sdiv i32 %.1424, 2
  store i32 %.1425, i32* %.23
  %.1427 = load i32, i32* %.21
  %.1428 = add i32 %.1427, 1
  store i32 %.1428, i32* %.21
  br label %.1395wc419 
.1407:
  %.1409 = load i32, i32* %.23
  %.1410 = srem i32 %.1409, 2
  %.1411 = icmp ne i32 %.1410, 0
  br i1 %.1411, label %.1402, label %.1403
.1449wc437:
  %.1453 = load i32, i32* %.1445
  %.1454 = icmp ne i32 %.1453, 0
  br i1 %.1454, label %.1450wloop.437.486, label %.1451wn486
.1450wloop.437.486:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1458 = load i32, i32* %.1442
  store i32 %.1458, i32* %.22
  %.1460 = load i32, i32* %.1445
  store i32 %.1460, i32* %.23
  br label %.1462wc442 
.1451wn486:
  %.1618 = load i32, i32* %.1442
  store i32 %.1618, i32* %.20
  %.1620 = load i32, i32* %.20
  store i32 %.1620, i32* %.1200
  %.1622 = load i32, i32* %.1203
  store i32 %.1622, i32* %.22
  store i32 1, i32* %.23
  %.1627 = load i32, i32* %.23
  %.1628 = icmp sge i32 %.1627, 15
  br i1 %.1628, label %.1625, label %.1626
.1462wc442:
  %.1466 = load i32, i32* %.21
  %.1467 = icmp slt i32 %.1466, 16
  br i1 %.1467, label %.1463wloop.442.453, label %.1464wn453
.1463wloop.442.453:
  %.1471 = load i32, i32* %.22
  %.1472 = srem i32 %.1471, 2
  %.1473 = icmp ne i32 %.1472, 0
  br i1 %.1473, label %.1469, label %.1470
.1464wn453:
  %.1516 = load i32, i32* %.20
  store i32 %.1516, i32* %.1448
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1520 = load i32, i32* %.1442
  store i32 %.1520, i32* %.22
  %.1522 = load i32, i32* %.1445
  store i32 %.1522, i32* %.23
  br label %.1524wc459 
.1469:
  %.1477 = load i32, i32* %.23
  %.1478 = srem i32 %.1477, 2
  %.1479 = icmp eq i32 %.1478, 0
  br i1 %.1479, label %.1475, label %.1476
.1470:
  %.1493 = load i32, i32* %.23
  %.1494 = srem i32 %.1493, 2
  %.1495 = icmp ne i32 %.1494, 0
  br i1 %.1495, label %.1491, label %.1492
.1475:
  %.1481 = load i32, i32* %.20
  %.1482 = load i32, i32* %.21
  %.1483 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1482
  %.1484 = load i32, i32* %.1483
  %.1485 = mul i32 1, %.1484
  %.1486 = add i32 %.1481, %.1485
  store i32 %.1486, i32* %.20
  br label %.1476 
.1476:
  br label %.1489 
.1489:
  %.1506 = load i32, i32* %.22
  %.1507 = sdiv i32 %.1506, 2
  store i32 %.1507, i32* %.22
  %.1509 = load i32, i32* %.23
  %.1510 = sdiv i32 %.1509, 2
  store i32 %.1510, i32* %.23
  %.1512 = load i32, i32* %.21
  %.1513 = add i32 %.1512, 1
  store i32 %.1513, i32* %.21
  br label %.1462wc442 
.1491:
  %.1497 = load i32, i32* %.20
  %.1498 = load i32, i32* %.21
  %.1499 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1498
  %.1500 = load i32, i32* %.1499
  %.1501 = mul i32 1, %.1500
  %.1502 = add i32 %.1497, %.1501
  store i32 %.1502, i32* %.20
  br label %.1492 
.1492:
  br label %.1489 
.1524wc459:
  %.1528 = load i32, i32* %.21
  %.1529 = icmp slt i32 %.1528, 16
  br i1 %.1529, label %.1525wloop.459.466, label %.1526wn466
.1525wloop.459.466:
  %.1533 = load i32, i32* %.22
  %.1534 = srem i32 %.1533, 2
  %.1535 = icmp ne i32 %.1534, 0
  br i1 %.1535, label %.1536, label %.1532
.1526wn466:
  %.1560 = load i32, i32* %.20
  store i32 %.1560, i32* %.1445
  br label %.1563 
.1531:
  %.1542 = load i32, i32* %.20
  %.1543 = load i32, i32* %.21
  %.1544 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1543
  %.1545 = load i32, i32* %.1544
  %.1546 = mul i32 1, %.1545
  %.1547 = add i32 %.1542, %.1546
  store i32 %.1547, i32* %.20
  br label %.1532 
.1532:
  %.1550 = load i32, i32* %.22
  %.1551 = sdiv i32 %.1550, 2
  store i32 %.1551, i32* %.22
  %.1553 = load i32, i32* %.23
  %.1554 = sdiv i32 %.1553, 2
  store i32 %.1554, i32* %.23
  %.1556 = load i32, i32* %.21
  %.1557 = add i32 %.1556, 1
  store i32 %.1557, i32* %.21
  br label %.1524wc459 
.1536:
  %.1538 = load i32, i32* %.23
  %.1539 = srem i32 %.1538, 2
  %.1540 = icmp ne i32 %.1539, 0
  br i1 %.1540, label %.1531, label %.1532
.1562:
  store i32 0, i32* %.20
  br label %.1566 
.1563:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1570 = load i32, i32* %.1445
  %.1571 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.1572 = load i32, i32* %.1571
  %.1573 = mul i32 %.1570, %.1572
  store i32 %.1573, i32* %.22
  store i32 65535, i32* %.23
  br label %.1576wc475 
.1566:
  %.1613 = load i32, i32* %.20
  store i32 %.1613, i32* %.1445
  %.1615 = load i32, i32* %.1448
  store i32 %.1615, i32* %.1442
  br label %.1449wc437 
.1576wc475:
  %.1580 = load i32, i32* %.21
  %.1581 = icmp slt i32 %.1580, 16
  br i1 %.1581, label %.1577wloop.475.482, label %.1578wn482
.1577wloop.475.482:
  %.1585 = load i32, i32* %.22
  %.1586 = srem i32 %.1585, 2
  %.1587 = icmp ne i32 %.1586, 0
  br i1 %.1587, label %.1588, label %.1584
.1578wn482:
  br label %.1566 
.1583:
  %.1594 = load i32, i32* %.20
  %.1595 = load i32, i32* %.21
  %.1596 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1595
  %.1597 = load i32, i32* %.1596
  %.1598 = mul i32 1, %.1597
  %.1599 = add i32 %.1594, %.1598
  store i32 %.1599, i32* %.20
  br label %.1584 
.1584:
  %.1602 = load i32, i32* %.22
  %.1603 = sdiv i32 %.1602, 2
  store i32 %.1603, i32* %.22
  %.1605 = load i32, i32* %.23
  %.1606 = sdiv i32 %.1605, 2
  store i32 %.1606, i32* %.23
  %.1608 = load i32, i32* %.21
  %.1609 = add i32 %.1608, 1
  store i32 %.1609, i32* %.21
  br label %.1576wc475 
.1588:
  %.1590 = load i32, i32* %.23
  %.1591 = srem i32 %.1590, 2
  %.1592 = icmp ne i32 %.1591, 0
  br i1 %.1592, label %.1583, label %.1584
.1625:
  %.1632 = load i32, i32* %.22
  %.1633 = icmp slt i32 %.1632, 0
  br i1 %.1633, label %.1630, label %.1631
.1626:
  %.1644 = load i32, i32* %.23
  %.1645 = icmp sgt i32 %.1644, 0
  br i1 %.1645, label %.1642, label %.1643
.1630:
  store i32 65535, i32* %.20
  br label %.1636 
.1631:
  store i32 0, i32* %.20
  br label %.1636 
.1636:
  br label %.1640 
.1640:
  %.1682 = load i32, i32* %.20
  store i32 %.1682, i32* %.1203
  br label %.1208wc365 
.1642:
  %.1649 = load i32, i32* %.22
  %.1650 = icmp sgt i32 %.1649, 32767
  br i1 %.1650, label %.1647, label %.1648
.1643:
  %.1678 = load i32, i32* %.22
  store i32 %.1678, i32* %.20
  br label %.1676 
.1647:
  %.1652 = load i32, i32* %.22
  %.1653 = load i32, i32* %.23
  %.1654 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1653
  %.1655 = load i32, i32* %.1654
  %.1656 = sdiv i32 %.1652, %.1655
  store i32 %.1656, i32* %.22
  %.1658 = load i32, i32* %.22
  %.1659 = add i32 %.1658, 65536
  %.1660 = load i32, i32* %.23
  %.1661 = sub i32 15, %.1660
  %.1662 = add i32 %.1661, 1
  %.1663 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1662
  %.1664 = load i32, i32* %.1663
  %.1665 = sub i32 %.1659, %.1664
  store i32 %.1665, i32* %.20
  br label %.1667 
.1648:
  %.1669 = load i32, i32* %.22
  %.1670 = load i32, i32* %.23
  %.1671 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1670
  %.1672 = load i32, i32* %.1671
  %.1673 = sdiv i32 %.1669, %.1672
  store i32 %.1673, i32* %.20
  br label %.1667 
.1667:
  br label %.1676 
.1676:
  br label %.1640 
.1698wc516:
  %.1702 = load i32, i32* %.1693
  %.1703 = icmp ne i32 %.1702, 0
  br i1 %.1703, label %.1699wloop.516.660, label %.1700wn660
.1699wloop.516.660:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1707 = load i32, i32* %.1693
  store i32 %.1707, i32* %.22
  store i32 1, i32* %.23
  br label %.1710wc521 
.1700wn660:
  %.2175 = load i32, i32* %.1696
  store i32 %.2175, i32* %.20
  %.2177 = load i32, i32* %.20
  store i32 %.2177, i32* %.1141
  %.2179 = load i32, i32* %.1143
  store i32 %.2179, i32* %.22
  store i32 1, i32* %.23
  %.2184 = load i32, i32* %.23
  %.2185 = icmp sge i32 %.2184, 15
  br i1 %.2185, label %.2182, label %.2183
.1710wc521:
  %.1714 = load i32, i32* %.21
  %.1715 = icmp slt i32 %.1714, 16
  br i1 %.1715, label %.1711wloop.521.528, label %.1712wn528
.1711wloop.521.528:
  %.1719 = load i32, i32* %.22
  %.1720 = srem i32 %.1719, 2
  %.1721 = icmp ne i32 %.1720, 0
  br i1 %.1721, label %.1722, label %.1718
.1712wn528:
  %.1748 = load i32, i32* %.20
  %.1749 = icmp ne i32 %.1748, 0
  br i1 %.1749, label %.1746, label %.1747
.1717:
  %.1728 = load i32, i32* %.20
  %.1729 = load i32, i32* %.21
  %.1730 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1729
  %.1731 = load i32, i32* %.1730
  %.1732 = mul i32 1, %.1731
  %.1733 = add i32 %.1728, %.1732
  store i32 %.1733, i32* %.20
  br label %.1718 
.1718:
  %.1736 = load i32, i32* %.22
  %.1737 = sdiv i32 %.1736, 2
  store i32 %.1737, i32* %.22
  %.1739 = load i32, i32* %.23
  %.1740 = sdiv i32 %.1739, 2
  store i32 %.1740, i32* %.23
  %.1742 = load i32, i32* %.21
  %.1743 = add i32 %.1742, 1
  store i32 %.1743, i32* %.21
  br label %.1710wc521 
.1722:
  %.1724 = load i32, i32* %.23
  %.1725 = srem i32 %.1724, 2
  %.1726 = icmp ne i32 %.1725, 0
  br i1 %.1726, label %.1717, label %.1718
.1746:
  %.1752 = load i32, i32* %.1696
  store i32 %.1752, i32* %.1751
  %.1755 = load i32, i32* %.1690
  store i32 %.1755, i32* %.1754
  br label %.1758wc532 
.1747:
  %.1933 = load i32, i32* %.1690
  store i32 %.1933, i32* %.1932
  %.1936 = load i32, i32* %.1690
  store i32 %.1936, i32* %.1935
  br label %.1939wc588 
.1758wc532:
  %.1762 = load i32, i32* %.1754
  %.1763 = icmp ne i32 %.1762, 0
  br i1 %.1763, label %.1759wloop.532.581, label %.1760wn581
.1759wloop.532.581:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1767 = load i32, i32* %.1751
  store i32 %.1767, i32* %.22
  %.1769 = load i32, i32* %.1754
  store i32 %.1769, i32* %.23
  br label %.1771wc537 
.1760wn581:
  %.1927 = load i32, i32* %.1751
  store i32 %.1927, i32* %.20
  %.1929 = load i32, i32* %.20
  store i32 %.1929, i32* %.1696
  br label %.1747 
.1771wc537:
  %.1775 = load i32, i32* %.21
  %.1776 = icmp slt i32 %.1775, 16
  br i1 %.1776, label %.1772wloop.537.548, label %.1773wn548
.1772wloop.537.548:
  %.1780 = load i32, i32* %.22
  %.1781 = srem i32 %.1780, 2
  %.1782 = icmp ne i32 %.1781, 0
  br i1 %.1782, label %.1778, label %.1779
.1773wn548:
  %.1825 = load i32, i32* %.20
  store i32 %.1825, i32* %.1757
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1829 = load i32, i32* %.1751
  store i32 %.1829, i32* %.22
  %.1831 = load i32, i32* %.1754
  store i32 %.1831, i32* %.23
  br label %.1833wc554 
.1778:
  %.1786 = load i32, i32* %.23
  %.1787 = srem i32 %.1786, 2
  %.1788 = icmp eq i32 %.1787, 0
  br i1 %.1788, label %.1784, label %.1785
.1779:
  %.1802 = load i32, i32* %.23
  %.1803 = srem i32 %.1802, 2
  %.1804 = icmp ne i32 %.1803, 0
  br i1 %.1804, label %.1800, label %.1801
.1784:
  %.1790 = load i32, i32* %.20
  %.1791 = load i32, i32* %.21
  %.1792 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1791
  %.1793 = load i32, i32* %.1792
  %.1794 = mul i32 1, %.1793
  %.1795 = add i32 %.1790, %.1794
  store i32 %.1795, i32* %.20
  br label %.1785 
.1785:
  br label %.1798 
.1798:
  %.1815 = load i32, i32* %.22
  %.1816 = sdiv i32 %.1815, 2
  store i32 %.1816, i32* %.22
  %.1818 = load i32, i32* %.23
  %.1819 = sdiv i32 %.1818, 2
  store i32 %.1819, i32* %.23
  %.1821 = load i32, i32* %.21
  %.1822 = add i32 %.1821, 1
  store i32 %.1822, i32* %.21
  br label %.1771wc537 
.1800:
  %.1806 = load i32, i32* %.20
  %.1807 = load i32, i32* %.21
  %.1808 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1807
  %.1809 = load i32, i32* %.1808
  %.1810 = mul i32 1, %.1809
  %.1811 = add i32 %.1806, %.1810
  store i32 %.1811, i32* %.20
  br label %.1801 
.1801:
  br label %.1798 
.1833wc554:
  %.1837 = load i32, i32* %.21
  %.1838 = icmp slt i32 %.1837, 16
  br i1 %.1838, label %.1834wloop.554.561, label %.1835wn561
.1834wloop.554.561:
  %.1842 = load i32, i32* %.22
  %.1843 = srem i32 %.1842, 2
  %.1844 = icmp ne i32 %.1843, 0
  br i1 %.1844, label %.1845, label %.1841
.1835wn561:
  %.1869 = load i32, i32* %.20
  store i32 %.1869, i32* %.1754
  br label %.1872 
.1840:
  %.1851 = load i32, i32* %.20
  %.1852 = load i32, i32* %.21
  %.1853 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1852
  %.1854 = load i32, i32* %.1853
  %.1855 = mul i32 1, %.1854
  %.1856 = add i32 %.1851, %.1855
  store i32 %.1856, i32* %.20
  br label %.1841 
.1841:
  %.1859 = load i32, i32* %.22
  %.1860 = sdiv i32 %.1859, 2
  store i32 %.1860, i32* %.22
  %.1862 = load i32, i32* %.23
  %.1863 = sdiv i32 %.1862, 2
  store i32 %.1863, i32* %.23
  %.1865 = load i32, i32* %.21
  %.1866 = add i32 %.1865, 1
  store i32 %.1866, i32* %.21
  br label %.1833wc554 
.1845:
  %.1847 = load i32, i32* %.23
  %.1848 = srem i32 %.1847, 2
  %.1849 = icmp ne i32 %.1848, 0
  br i1 %.1849, label %.1840, label %.1841
.1871:
  store i32 0, i32* %.20
  br label %.1875 
.1872:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1879 = load i32, i32* %.1754
  %.1880 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.1881 = load i32, i32* %.1880
  %.1882 = mul i32 %.1879, %.1881
  store i32 %.1882, i32* %.22
  store i32 65535, i32* %.23
  br label %.1885wc570 
.1875:
  %.1922 = load i32, i32* %.20
  store i32 %.1922, i32* %.1754
  %.1924 = load i32, i32* %.1757
  store i32 %.1924, i32* %.1751
  br label %.1758wc532 
.1885wc570:
  %.1889 = load i32, i32* %.21
  %.1890 = icmp slt i32 %.1889, 16
  br i1 %.1890, label %.1886wloop.570.577, label %.1887wn577
.1886wloop.570.577:
  %.1894 = load i32, i32* %.22
  %.1895 = srem i32 %.1894, 2
  %.1896 = icmp ne i32 %.1895, 0
  br i1 %.1896, label %.1897, label %.1893
.1887wn577:
  br label %.1875 
.1892:
  %.1903 = load i32, i32* %.20
  %.1904 = load i32, i32* %.21
  %.1905 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1904
  %.1906 = load i32, i32* %.1905
  %.1907 = mul i32 1, %.1906
  %.1908 = add i32 %.1903, %.1907
  store i32 %.1908, i32* %.20
  br label %.1893 
.1893:
  %.1911 = load i32, i32* %.22
  %.1912 = sdiv i32 %.1911, 2
  store i32 %.1912, i32* %.22
  %.1914 = load i32, i32* %.23
  %.1915 = sdiv i32 %.1914, 2
  store i32 %.1915, i32* %.23
  %.1917 = load i32, i32* %.21
  %.1918 = add i32 %.1917, 1
  store i32 %.1918, i32* %.21
  br label %.1885wc570 
.1897:
  %.1899 = load i32, i32* %.23
  %.1900 = srem i32 %.1899, 2
  %.1901 = icmp ne i32 %.1900, 0
  br i1 %.1901, label %.1892, label %.1893
.1939wc588:
  %.1943 = load i32, i32* %.1935
  %.1944 = icmp ne i32 %.1943, 0
  br i1 %.1944, label %.1940wloop.588.637, label %.1941wn637
.1940wloop.588.637:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.1948 = load i32, i32* %.1932
  store i32 %.1948, i32* %.22
  %.1950 = load i32, i32* %.1935
  store i32 %.1950, i32* %.23
  br label %.1952wc593 
.1941wn637:
  %.2108 = load i32, i32* %.1932
  store i32 %.2108, i32* %.20
  %.2110 = load i32, i32* %.20
  store i32 %.2110, i32* %.1690
  %.2112 = load i32, i32* %.1693
  store i32 %.2112, i32* %.22
  store i32 1, i32* %.23
  %.2117 = load i32, i32* %.23
  %.2118 = icmp sge i32 %.2117, 15
  br i1 %.2118, label %.2115, label %.2116
.1952wc593:
  %.1956 = load i32, i32* %.21
  %.1957 = icmp slt i32 %.1956, 16
  br i1 %.1957, label %.1953wloop.593.604, label %.1954wn604
.1953wloop.593.604:
  %.1961 = load i32, i32* %.22
  %.1962 = srem i32 %.1961, 2
  %.1963 = icmp ne i32 %.1962, 0
  br i1 %.1963, label %.1959, label %.1960
.1954wn604:
  %.2006 = load i32, i32* %.20
  store i32 %.2006, i32* %.1938
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2010 = load i32, i32* %.1932
  store i32 %.2010, i32* %.22
  %.2012 = load i32, i32* %.1935
  store i32 %.2012, i32* %.23
  br label %.2014wc610 
.1959:
  %.1967 = load i32, i32* %.23
  %.1968 = srem i32 %.1967, 2
  %.1969 = icmp eq i32 %.1968, 0
  br i1 %.1969, label %.1965, label %.1966
.1960:
  %.1983 = load i32, i32* %.23
  %.1984 = srem i32 %.1983, 2
  %.1985 = icmp ne i32 %.1984, 0
  br i1 %.1985, label %.1981, label %.1982
.1965:
  %.1971 = load i32, i32* %.20
  %.1972 = load i32, i32* %.21
  %.1973 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1972
  %.1974 = load i32, i32* %.1973
  %.1975 = mul i32 1, %.1974
  %.1976 = add i32 %.1971, %.1975
  store i32 %.1976, i32* %.20
  br label %.1966 
.1966:
  br label %.1979 
.1979:
  %.1996 = load i32, i32* %.22
  %.1997 = sdiv i32 %.1996, 2
  store i32 %.1997, i32* %.22
  %.1999 = load i32, i32* %.23
  %.2000 = sdiv i32 %.1999, 2
  store i32 %.2000, i32* %.23
  %.2002 = load i32, i32* %.21
  %.2003 = add i32 %.2002, 1
  store i32 %.2003, i32* %.21
  br label %.1952wc593 
.1981:
  %.1987 = load i32, i32* %.20
  %.1988 = load i32, i32* %.21
  %.1989 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.1988
  %.1990 = load i32, i32* %.1989
  %.1991 = mul i32 1, %.1990
  %.1992 = add i32 %.1987, %.1991
  store i32 %.1992, i32* %.20
  br label %.1982 
.1982:
  br label %.1979 
.2014wc610:
  %.2018 = load i32, i32* %.21
  %.2019 = icmp slt i32 %.2018, 16
  br i1 %.2019, label %.2015wloop.610.617, label %.2016wn617
.2015wloop.610.617:
  %.2023 = load i32, i32* %.22
  %.2024 = srem i32 %.2023, 2
  %.2025 = icmp ne i32 %.2024, 0
  br i1 %.2025, label %.2026, label %.2022
.2016wn617:
  %.2050 = load i32, i32* %.20
  store i32 %.2050, i32* %.1935
  br label %.2053 
.2021:
  %.2032 = load i32, i32* %.20
  %.2033 = load i32, i32* %.21
  %.2034 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2033
  %.2035 = load i32, i32* %.2034
  %.2036 = mul i32 1, %.2035
  %.2037 = add i32 %.2032, %.2036
  store i32 %.2037, i32* %.20
  br label %.2022 
.2022:
  %.2040 = load i32, i32* %.22
  %.2041 = sdiv i32 %.2040, 2
  store i32 %.2041, i32* %.22
  %.2043 = load i32, i32* %.23
  %.2044 = sdiv i32 %.2043, 2
  store i32 %.2044, i32* %.23
  %.2046 = load i32, i32* %.21
  %.2047 = add i32 %.2046, 1
  store i32 %.2047, i32* %.21
  br label %.2014wc610 
.2026:
  %.2028 = load i32, i32* %.23
  %.2029 = srem i32 %.2028, 2
  %.2030 = icmp ne i32 %.2029, 0
  br i1 %.2030, label %.2021, label %.2022
.2052:
  store i32 0, i32* %.20
  br label %.2056 
.2053:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2060 = load i32, i32* %.1935
  %.2061 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.2062 = load i32, i32* %.2061
  %.2063 = mul i32 %.2060, %.2062
  store i32 %.2063, i32* %.22
  store i32 65535, i32* %.23
  br label %.2066wc626 
.2056:
  %.2103 = load i32, i32* %.20
  store i32 %.2103, i32* %.1935
  %.2105 = load i32, i32* %.1938
  store i32 %.2105, i32* %.1932
  br label %.1939wc588 
.2066wc626:
  %.2070 = load i32, i32* %.21
  %.2071 = icmp slt i32 %.2070, 16
  br i1 %.2071, label %.2067wloop.626.633, label %.2068wn633
.2067wloop.626.633:
  %.2075 = load i32, i32* %.22
  %.2076 = srem i32 %.2075, 2
  %.2077 = icmp ne i32 %.2076, 0
  br i1 %.2077, label %.2078, label %.2074
.2068wn633:
  br label %.2056 
.2073:
  %.2084 = load i32, i32* %.20
  %.2085 = load i32, i32* %.21
  %.2086 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2085
  %.2087 = load i32, i32* %.2086
  %.2088 = mul i32 1, %.2087
  %.2089 = add i32 %.2084, %.2088
  store i32 %.2089, i32* %.20
  br label %.2074 
.2074:
  %.2092 = load i32, i32* %.22
  %.2093 = sdiv i32 %.2092, 2
  store i32 %.2093, i32* %.22
  %.2095 = load i32, i32* %.23
  %.2096 = sdiv i32 %.2095, 2
  store i32 %.2096, i32* %.23
  %.2098 = load i32, i32* %.21
  %.2099 = add i32 %.2098, 1
  store i32 %.2099, i32* %.21
  br label %.2066wc626 
.2078:
  %.2080 = load i32, i32* %.23
  %.2081 = srem i32 %.2080, 2
  %.2082 = icmp ne i32 %.2081, 0
  br i1 %.2082, label %.2073, label %.2074
.2115:
  %.2122 = load i32, i32* %.22
  %.2123 = icmp slt i32 %.2122, 0
  br i1 %.2123, label %.2120, label %.2121
.2116:
  %.2134 = load i32, i32* %.23
  %.2135 = icmp sgt i32 %.2134, 0
  br i1 %.2135, label %.2132, label %.2133
.2120:
  store i32 65535, i32* %.20
  br label %.2126 
.2121:
  store i32 0, i32* %.20
  br label %.2126 
.2126:
  br label %.2130 
.2130:
  %.2172 = load i32, i32* %.20
  store i32 %.2172, i32* %.1693
  br label %.1698wc516 
.2132:
  %.2139 = load i32, i32* %.22
  %.2140 = icmp sgt i32 %.2139, 32767
  br i1 %.2140, label %.2137, label %.2138
.2133:
  %.2168 = load i32, i32* %.22
  store i32 %.2168, i32* %.20
  br label %.2166 
.2137:
  %.2142 = load i32, i32* %.22
  %.2143 = load i32, i32* %.23
  %.2144 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2143
  %.2145 = load i32, i32* %.2144
  %.2146 = sdiv i32 %.2142, %.2145
  store i32 %.2146, i32* %.22
  %.2148 = load i32, i32* %.22
  %.2149 = add i32 %.2148, 65536
  %.2150 = load i32, i32* %.23
  %.2151 = sub i32 15, %.2150
  %.2152 = add i32 %.2151, 1
  %.2153 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2152
  %.2154 = load i32, i32* %.2153
  %.2155 = sub i32 %.2149, %.2154
  store i32 %.2155, i32* %.20
  br label %.2157 
.2138:
  %.2159 = load i32, i32* %.22
  %.2160 = load i32, i32* %.23
  %.2161 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2160
  %.2162 = load i32, i32* %.2161
  %.2163 = sdiv i32 %.2159, %.2162
  store i32 %.2163, i32* %.20
  br label %.2157 
.2157:
  br label %.2166 
.2166:
  br label %.2130 
.2182:
  %.2189 = load i32, i32* %.22
  %.2190 = icmp slt i32 %.2189, 0
  br i1 %.2190, label %.2187, label %.2188
.2183:
  %.2201 = load i32, i32* %.23
  %.2202 = icmp sgt i32 %.2201, 0
  br i1 %.2202, label %.2199, label %.2200
.2187:
  store i32 65535, i32* %.20
  br label %.2193 
.2188:
  store i32 0, i32* %.20
  br label %.2193 
.2193:
  br label %.2197 
.2197:
  %.2239 = load i32, i32* %.20
  store i32 %.2239, i32* %.1143
  br label %.1147wc349 
.2199:
  %.2206 = load i32, i32* %.22
  %.2207 = icmp sgt i32 %.2206, 32767
  br i1 %.2207, label %.2204, label %.2205
.2200:
  %.2235 = load i32, i32* %.22
  store i32 %.2235, i32* %.20
  br label %.2233 
.2204:
  %.2209 = load i32, i32* %.22
  %.2210 = load i32, i32* %.23
  %.2211 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2210
  %.2212 = load i32, i32* %.2211
  %.2213 = sdiv i32 %.2209, %.2212
  store i32 %.2213, i32* %.22
  %.2215 = load i32, i32* %.22
  %.2216 = add i32 %.2215, 65536
  %.2217 = load i32, i32* %.23
  %.2218 = sub i32 15, %.2217
  %.2219 = add i32 %.2218, 1
  %.2220 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2219
  %.2221 = load i32, i32* %.2220
  %.2222 = sub i32 %.2216, %.2221
  store i32 %.2222, i32* %.20
  br label %.2224 
.2205:
  %.2226 = load i32, i32* %.22
  %.2227 = load i32, i32* %.23
  %.2228 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2227
  %.2229 = load i32, i32* %.2228
  %.2230 = sdiv i32 %.2226, %.2229
  store i32 %.2230, i32* %.20
  br label %.2224 
.2224:
  br label %.2233 
.2233:
  br label %.2197 
.2248wc689:
  %.2252 = load i32, i32* %.24
  %.2253 = icmp slt i32 %.2252, 16
  br i1 %.2253, label %.2249wloop.689.1032, label %.2250wn1032
.2249wloop.689.1032:
  store i32 2, i32* %.2255
  %.2258 = load i32, i32* %.24
  store i32 %.2258, i32* %.2257
  store i32 1, i32* %.2260
  br label %.2262wc692 
.2250wn1032:
  store i32 0, i32* %.24
  br label %.3367wc1034 
.2262wc692:
  %.2266 = load i32, i32* %.2257
  %.2267 = icmp sgt i32 %.2266, 0
  br i1 %.2267, label %.2263wloop.692.1026, label %.2264wn1026
.2263wloop.692.1026:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2271 = load i32, i32* %.2257
  store i32 %.2271, i32* %.22
  store i32 1, i32* %.23
  br label %.2274wc697 
.2264wn1026:
  %.3357 = load i32, i32* %.2260
  store i32 %.3357, i32* %.20
  %.3359 = load i32, i32* %.20
  call void @putint(i32 %.3359)
  call void @putch(i32 10)
  %.3362 = load i32, i32* %.24
  %.3363 = add i32 %.3362, 1
  store i32 %.3363, i32* %.24
  br label %.2248wc689 
.2274wc697:
  %.2278 = load i32, i32* %.21
  %.2279 = icmp slt i32 %.2278, 16
  br i1 %.2279, label %.2275wloop.697.704, label %.2276wn704
.2275wloop.697.704:
  %.2283 = load i32, i32* %.22
  %.2284 = srem i32 %.2283, 2
  %.2285 = icmp ne i32 %.2284, 0
  br i1 %.2285, label %.2286, label %.2282
.2276wn704:
  %.2312 = load i32, i32* %.20
  %.2313 = icmp ne i32 %.2312, 0
  br i1 %.2313, label %.2310, label %.2311
.2281:
  %.2292 = load i32, i32* %.20
  %.2293 = load i32, i32* %.21
  %.2294 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2293
  %.2295 = load i32, i32* %.2294
  %.2296 = mul i32 1, %.2295
  %.2297 = add i32 %.2292, %.2296
  store i32 %.2297, i32* %.20
  br label %.2282 
.2282:
  %.2300 = load i32, i32* %.22
  %.2301 = sdiv i32 %.2300, 2
  store i32 %.2301, i32* %.22
  %.2303 = load i32, i32* %.23
  %.2304 = sdiv i32 %.2303, 2
  store i32 %.2304, i32* %.23
  %.2306 = load i32, i32* %.21
  %.2307 = add i32 %.2306, 1
  store i32 %.2307, i32* %.21
  br label %.2274wc697 
.2286:
  %.2288 = load i32, i32* %.23
  %.2289 = srem i32 %.2288, 2
  %.2290 = icmp ne i32 %.2289, 0
  br i1 %.2290, label %.2281, label %.2282
.2310:
  %.2316 = load i32, i32* %.2260
  store i32 %.2316, i32* %.2315
  %.2319 = load i32, i32* %.2255
  store i32 %.2319, i32* %.2318
  store i32 0, i32* %.2321
  br label %.2323wc708 
.2311:
  %.2806 = load i32, i32* %.2255
  store i32 %.2806, i32* %.2805
  %.2809 = load i32, i32* %.2255
  store i32 %.2809, i32* %.2808
  store i32 0, i32* %.2811
  br label %.2813wc859 
.2323wc708:
  %.2327 = load i32, i32* %.2318
  %.2328 = icmp ne i32 %.2327, 0
  br i1 %.2328, label %.2324wloop.708.852, label %.2325wn852
.2324wloop.708.852:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2332 = load i32, i32* %.2318
  store i32 %.2332, i32* %.22
  store i32 1, i32* %.23
  br label %.2335wc713 
.2325wn852:
  %.2800 = load i32, i32* %.2321
  store i32 %.2800, i32* %.20
  %.2802 = load i32, i32* %.20
  store i32 %.2802, i32* %.2260
  br label %.2311 
.2335wc713:
  %.2339 = load i32, i32* %.21
  %.2340 = icmp slt i32 %.2339, 16
  br i1 %.2340, label %.2336wloop.713.720, label %.2337wn720
.2336wloop.713.720:
  %.2344 = load i32, i32* %.22
  %.2345 = srem i32 %.2344, 2
  %.2346 = icmp ne i32 %.2345, 0
  br i1 %.2346, label %.2347, label %.2343
.2337wn720:
  %.2373 = load i32, i32* %.20
  %.2374 = icmp ne i32 %.2373, 0
  br i1 %.2374, label %.2371, label %.2372
.2342:
  %.2353 = load i32, i32* %.20
  %.2354 = load i32, i32* %.21
  %.2355 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2354
  %.2356 = load i32, i32* %.2355
  %.2357 = mul i32 1, %.2356
  %.2358 = add i32 %.2353, %.2357
  store i32 %.2358, i32* %.20
  br label %.2343 
.2343:
  %.2361 = load i32, i32* %.22
  %.2362 = sdiv i32 %.2361, 2
  store i32 %.2362, i32* %.22
  %.2364 = load i32, i32* %.23
  %.2365 = sdiv i32 %.2364, 2
  store i32 %.2365, i32* %.23
  %.2367 = load i32, i32* %.21
  %.2368 = add i32 %.2367, 1
  store i32 %.2368, i32* %.21
  br label %.2335wc713 
.2347:
  %.2349 = load i32, i32* %.23
  %.2350 = srem i32 %.2349, 2
  %.2351 = icmp ne i32 %.2350, 0
  br i1 %.2351, label %.2342, label %.2343
.2371:
  %.2377 = load i32, i32* %.2321
  store i32 %.2377, i32* %.2376
  %.2380 = load i32, i32* %.2315
  store i32 %.2380, i32* %.2379
  br label %.2383wc724 
.2372:
  %.2558 = load i32, i32* %.2315
  store i32 %.2558, i32* %.2557
  %.2561 = load i32, i32* %.2315
  store i32 %.2561, i32* %.2560
  br label %.2564wc780 
.2383wc724:
  %.2387 = load i32, i32* %.2379
  %.2388 = icmp ne i32 %.2387, 0
  br i1 %.2388, label %.2384wloop.724.773, label %.2385wn773
.2384wloop.724.773:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2392 = load i32, i32* %.2376
  store i32 %.2392, i32* %.22
  %.2394 = load i32, i32* %.2379
  store i32 %.2394, i32* %.23
  br label %.2396wc729 
.2385wn773:
  %.2552 = load i32, i32* %.2376
  store i32 %.2552, i32* %.20
  %.2554 = load i32, i32* %.20
  store i32 %.2554, i32* %.2321
  br label %.2372 
.2396wc729:
  %.2400 = load i32, i32* %.21
  %.2401 = icmp slt i32 %.2400, 16
  br i1 %.2401, label %.2397wloop.729.740, label %.2398wn740
.2397wloop.729.740:
  %.2405 = load i32, i32* %.22
  %.2406 = srem i32 %.2405, 2
  %.2407 = icmp ne i32 %.2406, 0
  br i1 %.2407, label %.2403, label %.2404
.2398wn740:
  %.2450 = load i32, i32* %.20
  store i32 %.2450, i32* %.2382
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2454 = load i32, i32* %.2376
  store i32 %.2454, i32* %.22
  %.2456 = load i32, i32* %.2379
  store i32 %.2456, i32* %.23
  br label %.2458wc746 
.2403:
  %.2411 = load i32, i32* %.23
  %.2412 = srem i32 %.2411, 2
  %.2413 = icmp eq i32 %.2412, 0
  br i1 %.2413, label %.2409, label %.2410
.2404:
  %.2427 = load i32, i32* %.23
  %.2428 = srem i32 %.2427, 2
  %.2429 = icmp ne i32 %.2428, 0
  br i1 %.2429, label %.2425, label %.2426
.2409:
  %.2415 = load i32, i32* %.20
  %.2416 = load i32, i32* %.21
  %.2417 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2416
  %.2418 = load i32, i32* %.2417
  %.2419 = mul i32 1, %.2418
  %.2420 = add i32 %.2415, %.2419
  store i32 %.2420, i32* %.20
  br label %.2410 
.2410:
  br label %.2423 
.2423:
  %.2440 = load i32, i32* %.22
  %.2441 = sdiv i32 %.2440, 2
  store i32 %.2441, i32* %.22
  %.2443 = load i32, i32* %.23
  %.2444 = sdiv i32 %.2443, 2
  store i32 %.2444, i32* %.23
  %.2446 = load i32, i32* %.21
  %.2447 = add i32 %.2446, 1
  store i32 %.2447, i32* %.21
  br label %.2396wc729 
.2425:
  %.2431 = load i32, i32* %.20
  %.2432 = load i32, i32* %.21
  %.2433 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2432
  %.2434 = load i32, i32* %.2433
  %.2435 = mul i32 1, %.2434
  %.2436 = add i32 %.2431, %.2435
  store i32 %.2436, i32* %.20
  br label %.2426 
.2426:
  br label %.2423 
.2458wc746:
  %.2462 = load i32, i32* %.21
  %.2463 = icmp slt i32 %.2462, 16
  br i1 %.2463, label %.2459wloop.746.753, label %.2460wn753
.2459wloop.746.753:
  %.2467 = load i32, i32* %.22
  %.2468 = srem i32 %.2467, 2
  %.2469 = icmp ne i32 %.2468, 0
  br i1 %.2469, label %.2470, label %.2466
.2460wn753:
  %.2494 = load i32, i32* %.20
  store i32 %.2494, i32* %.2379
  br label %.2497 
.2465:
  %.2476 = load i32, i32* %.20
  %.2477 = load i32, i32* %.21
  %.2478 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2477
  %.2479 = load i32, i32* %.2478
  %.2480 = mul i32 1, %.2479
  %.2481 = add i32 %.2476, %.2480
  store i32 %.2481, i32* %.20
  br label %.2466 
.2466:
  %.2484 = load i32, i32* %.22
  %.2485 = sdiv i32 %.2484, 2
  store i32 %.2485, i32* %.22
  %.2487 = load i32, i32* %.23
  %.2488 = sdiv i32 %.2487, 2
  store i32 %.2488, i32* %.23
  %.2490 = load i32, i32* %.21
  %.2491 = add i32 %.2490, 1
  store i32 %.2491, i32* %.21
  br label %.2458wc746 
.2470:
  %.2472 = load i32, i32* %.23
  %.2473 = srem i32 %.2472, 2
  %.2474 = icmp ne i32 %.2473, 0
  br i1 %.2474, label %.2465, label %.2466
.2496:
  store i32 0, i32* %.20
  br label %.2500 
.2497:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2504 = load i32, i32* %.2379
  %.2505 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.2506 = load i32, i32* %.2505
  %.2507 = mul i32 %.2504, %.2506
  store i32 %.2507, i32* %.22
  store i32 65535, i32* %.23
  br label %.2510wc762 
.2500:
  %.2547 = load i32, i32* %.20
  store i32 %.2547, i32* %.2379
  %.2549 = load i32, i32* %.2382
  store i32 %.2549, i32* %.2376
  br label %.2383wc724 
.2510wc762:
  %.2514 = load i32, i32* %.21
  %.2515 = icmp slt i32 %.2514, 16
  br i1 %.2515, label %.2511wloop.762.769, label %.2512wn769
.2511wloop.762.769:
  %.2519 = load i32, i32* %.22
  %.2520 = srem i32 %.2519, 2
  %.2521 = icmp ne i32 %.2520, 0
  br i1 %.2521, label %.2522, label %.2518
.2512wn769:
  br label %.2500 
.2517:
  %.2528 = load i32, i32* %.20
  %.2529 = load i32, i32* %.21
  %.2530 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2529
  %.2531 = load i32, i32* %.2530
  %.2532 = mul i32 1, %.2531
  %.2533 = add i32 %.2528, %.2532
  store i32 %.2533, i32* %.20
  br label %.2518 
.2518:
  %.2536 = load i32, i32* %.22
  %.2537 = sdiv i32 %.2536, 2
  store i32 %.2537, i32* %.22
  %.2539 = load i32, i32* %.23
  %.2540 = sdiv i32 %.2539, 2
  store i32 %.2540, i32* %.23
  %.2542 = load i32, i32* %.21
  %.2543 = add i32 %.2542, 1
  store i32 %.2543, i32* %.21
  br label %.2510wc762 
.2522:
  %.2524 = load i32, i32* %.23
  %.2525 = srem i32 %.2524, 2
  %.2526 = icmp ne i32 %.2525, 0
  br i1 %.2526, label %.2517, label %.2518
.2564wc780:
  %.2568 = load i32, i32* %.2560
  %.2569 = icmp ne i32 %.2568, 0
  br i1 %.2569, label %.2565wloop.780.829, label %.2566wn829
.2565wloop.780.829:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2573 = load i32, i32* %.2557
  store i32 %.2573, i32* %.22
  %.2575 = load i32, i32* %.2560
  store i32 %.2575, i32* %.23
  br label %.2577wc785 
.2566wn829:
  %.2733 = load i32, i32* %.2557
  store i32 %.2733, i32* %.20
  %.2735 = load i32, i32* %.20
  store i32 %.2735, i32* %.2315
  %.2737 = load i32, i32* %.2318
  store i32 %.2737, i32* %.22
  store i32 1, i32* %.23
  %.2742 = load i32, i32* %.23
  %.2743 = icmp sge i32 %.2742, 15
  br i1 %.2743, label %.2740, label %.2741
.2577wc785:
  %.2581 = load i32, i32* %.21
  %.2582 = icmp slt i32 %.2581, 16
  br i1 %.2582, label %.2578wloop.785.796, label %.2579wn796
.2578wloop.785.796:
  %.2586 = load i32, i32* %.22
  %.2587 = srem i32 %.2586, 2
  %.2588 = icmp ne i32 %.2587, 0
  br i1 %.2588, label %.2584, label %.2585
.2579wn796:
  %.2631 = load i32, i32* %.20
  store i32 %.2631, i32* %.2563
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2635 = load i32, i32* %.2557
  store i32 %.2635, i32* %.22
  %.2637 = load i32, i32* %.2560
  store i32 %.2637, i32* %.23
  br label %.2639wc802 
.2584:
  %.2592 = load i32, i32* %.23
  %.2593 = srem i32 %.2592, 2
  %.2594 = icmp eq i32 %.2593, 0
  br i1 %.2594, label %.2590, label %.2591
.2585:
  %.2608 = load i32, i32* %.23
  %.2609 = srem i32 %.2608, 2
  %.2610 = icmp ne i32 %.2609, 0
  br i1 %.2610, label %.2606, label %.2607
.2590:
  %.2596 = load i32, i32* %.20
  %.2597 = load i32, i32* %.21
  %.2598 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2597
  %.2599 = load i32, i32* %.2598
  %.2600 = mul i32 1, %.2599
  %.2601 = add i32 %.2596, %.2600
  store i32 %.2601, i32* %.20
  br label %.2591 
.2591:
  br label %.2604 
.2604:
  %.2621 = load i32, i32* %.22
  %.2622 = sdiv i32 %.2621, 2
  store i32 %.2622, i32* %.22
  %.2624 = load i32, i32* %.23
  %.2625 = sdiv i32 %.2624, 2
  store i32 %.2625, i32* %.23
  %.2627 = load i32, i32* %.21
  %.2628 = add i32 %.2627, 1
  store i32 %.2628, i32* %.21
  br label %.2577wc785 
.2606:
  %.2612 = load i32, i32* %.20
  %.2613 = load i32, i32* %.21
  %.2614 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2613
  %.2615 = load i32, i32* %.2614
  %.2616 = mul i32 1, %.2615
  %.2617 = add i32 %.2612, %.2616
  store i32 %.2617, i32* %.20
  br label %.2607 
.2607:
  br label %.2604 
.2639wc802:
  %.2643 = load i32, i32* %.21
  %.2644 = icmp slt i32 %.2643, 16
  br i1 %.2644, label %.2640wloop.802.809, label %.2641wn809
.2640wloop.802.809:
  %.2648 = load i32, i32* %.22
  %.2649 = srem i32 %.2648, 2
  %.2650 = icmp ne i32 %.2649, 0
  br i1 %.2650, label %.2651, label %.2647
.2641wn809:
  %.2675 = load i32, i32* %.20
  store i32 %.2675, i32* %.2560
  br label %.2678 
.2646:
  %.2657 = load i32, i32* %.20
  %.2658 = load i32, i32* %.21
  %.2659 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2658
  %.2660 = load i32, i32* %.2659
  %.2661 = mul i32 1, %.2660
  %.2662 = add i32 %.2657, %.2661
  store i32 %.2662, i32* %.20
  br label %.2647 
.2647:
  %.2665 = load i32, i32* %.22
  %.2666 = sdiv i32 %.2665, 2
  store i32 %.2666, i32* %.22
  %.2668 = load i32, i32* %.23
  %.2669 = sdiv i32 %.2668, 2
  store i32 %.2669, i32* %.23
  %.2671 = load i32, i32* %.21
  %.2672 = add i32 %.2671, 1
  store i32 %.2672, i32* %.21
  br label %.2639wc802 
.2651:
  %.2653 = load i32, i32* %.23
  %.2654 = srem i32 %.2653, 2
  %.2655 = icmp ne i32 %.2654, 0
  br i1 %.2655, label %.2646, label %.2647
.2677:
  store i32 0, i32* %.20
  br label %.2681 
.2678:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2685 = load i32, i32* %.2560
  %.2686 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.2687 = load i32, i32* %.2686
  %.2688 = mul i32 %.2685, %.2687
  store i32 %.2688, i32* %.22
  store i32 65535, i32* %.23
  br label %.2691wc818 
.2681:
  %.2728 = load i32, i32* %.20
  store i32 %.2728, i32* %.2560
  %.2730 = load i32, i32* %.2563
  store i32 %.2730, i32* %.2557
  br label %.2564wc780 
.2691wc818:
  %.2695 = load i32, i32* %.21
  %.2696 = icmp slt i32 %.2695, 16
  br i1 %.2696, label %.2692wloop.818.825, label %.2693wn825
.2692wloop.818.825:
  %.2700 = load i32, i32* %.22
  %.2701 = srem i32 %.2700, 2
  %.2702 = icmp ne i32 %.2701, 0
  br i1 %.2702, label %.2703, label %.2699
.2693wn825:
  br label %.2681 
.2698:
  %.2709 = load i32, i32* %.20
  %.2710 = load i32, i32* %.21
  %.2711 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2710
  %.2712 = load i32, i32* %.2711
  %.2713 = mul i32 1, %.2712
  %.2714 = add i32 %.2709, %.2713
  store i32 %.2714, i32* %.20
  br label %.2699 
.2699:
  %.2717 = load i32, i32* %.22
  %.2718 = sdiv i32 %.2717, 2
  store i32 %.2718, i32* %.22
  %.2720 = load i32, i32* %.23
  %.2721 = sdiv i32 %.2720, 2
  store i32 %.2721, i32* %.23
  %.2723 = load i32, i32* %.21
  %.2724 = add i32 %.2723, 1
  store i32 %.2724, i32* %.21
  br label %.2691wc818 
.2703:
  %.2705 = load i32, i32* %.23
  %.2706 = srem i32 %.2705, 2
  %.2707 = icmp ne i32 %.2706, 0
  br i1 %.2707, label %.2698, label %.2699
.2740:
  %.2747 = load i32, i32* %.22
  %.2748 = icmp slt i32 %.2747, 0
  br i1 %.2748, label %.2745, label %.2746
.2741:
  %.2759 = load i32, i32* %.23
  %.2760 = icmp sgt i32 %.2759, 0
  br i1 %.2760, label %.2757, label %.2758
.2745:
  store i32 65535, i32* %.20
  br label %.2751 
.2746:
  store i32 0, i32* %.20
  br label %.2751 
.2751:
  br label %.2755 
.2755:
  %.2797 = load i32, i32* %.20
  store i32 %.2797, i32* %.2318
  br label %.2323wc708 
.2757:
  %.2764 = load i32, i32* %.22
  %.2765 = icmp sgt i32 %.2764, 32767
  br i1 %.2765, label %.2762, label %.2763
.2758:
  %.2793 = load i32, i32* %.22
  store i32 %.2793, i32* %.20
  br label %.2791 
.2762:
  %.2767 = load i32, i32* %.22
  %.2768 = load i32, i32* %.23
  %.2769 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2768
  %.2770 = load i32, i32* %.2769
  %.2771 = sdiv i32 %.2767, %.2770
  store i32 %.2771, i32* %.22
  %.2773 = load i32, i32* %.22
  %.2774 = add i32 %.2773, 65536
  %.2775 = load i32, i32* %.23
  %.2776 = sub i32 15, %.2775
  %.2777 = add i32 %.2776, 1
  %.2778 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2777
  %.2779 = load i32, i32* %.2778
  %.2780 = sub i32 %.2774, %.2779
  store i32 %.2780, i32* %.20
  br label %.2782 
.2763:
  %.2784 = load i32, i32* %.22
  %.2785 = load i32, i32* %.23
  %.2786 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2785
  %.2787 = load i32, i32* %.2786
  %.2788 = sdiv i32 %.2784, %.2787
  store i32 %.2788, i32* %.20
  br label %.2782 
.2782:
  br label %.2791 
.2791:
  br label %.2755 
.2813wc859:
  %.2817 = load i32, i32* %.2808
  %.2818 = icmp ne i32 %.2817, 0
  br i1 %.2818, label %.2814wloop.859.1003, label %.2815wn1003
.2814wloop.859.1003:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2822 = load i32, i32* %.2808
  store i32 %.2822, i32* %.22
  store i32 1, i32* %.23
  br label %.2825wc864 
.2815wn1003:
  %.3290 = load i32, i32* %.2811
  store i32 %.3290, i32* %.20
  %.3292 = load i32, i32* %.20
  store i32 %.3292, i32* %.2255
  %.3294 = load i32, i32* %.2257
  store i32 %.3294, i32* %.22
  store i32 1, i32* %.23
  %.3299 = load i32, i32* %.23
  %.3300 = icmp sge i32 %.3299, 15
  br i1 %.3300, label %.3297, label %.3298
.2825wc864:
  %.2829 = load i32, i32* %.21
  %.2830 = icmp slt i32 %.2829, 16
  br i1 %.2830, label %.2826wloop.864.871, label %.2827wn871
.2826wloop.864.871:
  %.2834 = load i32, i32* %.22
  %.2835 = srem i32 %.2834, 2
  %.2836 = icmp ne i32 %.2835, 0
  br i1 %.2836, label %.2837, label %.2833
.2827wn871:
  %.2863 = load i32, i32* %.20
  %.2864 = icmp ne i32 %.2863, 0
  br i1 %.2864, label %.2861, label %.2862
.2832:
  %.2843 = load i32, i32* %.20
  %.2844 = load i32, i32* %.21
  %.2845 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2844
  %.2846 = load i32, i32* %.2845
  %.2847 = mul i32 1, %.2846
  %.2848 = add i32 %.2843, %.2847
  store i32 %.2848, i32* %.20
  br label %.2833 
.2833:
  %.2851 = load i32, i32* %.22
  %.2852 = sdiv i32 %.2851, 2
  store i32 %.2852, i32* %.22
  %.2854 = load i32, i32* %.23
  %.2855 = sdiv i32 %.2854, 2
  store i32 %.2855, i32* %.23
  %.2857 = load i32, i32* %.21
  %.2858 = add i32 %.2857, 1
  store i32 %.2858, i32* %.21
  br label %.2825wc864 
.2837:
  %.2839 = load i32, i32* %.23
  %.2840 = srem i32 %.2839, 2
  %.2841 = icmp ne i32 %.2840, 0
  br i1 %.2841, label %.2832, label %.2833
.2861:
  %.2867 = load i32, i32* %.2811
  store i32 %.2867, i32* %.2866
  %.2870 = load i32, i32* %.2805
  store i32 %.2870, i32* %.2869
  br label %.2873wc875 
.2862:
  %.3048 = load i32, i32* %.2805
  store i32 %.3048, i32* %.3047
  %.3051 = load i32, i32* %.2805
  store i32 %.3051, i32* %.3050
  br label %.3054wc931 
.2873wc875:
  %.2877 = load i32, i32* %.2869
  %.2878 = icmp ne i32 %.2877, 0
  br i1 %.2878, label %.2874wloop.875.924, label %.2875wn924
.2874wloop.875.924:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2882 = load i32, i32* %.2866
  store i32 %.2882, i32* %.22
  %.2884 = load i32, i32* %.2869
  store i32 %.2884, i32* %.23
  br label %.2886wc880 
.2875wn924:
  %.3042 = load i32, i32* %.2866
  store i32 %.3042, i32* %.20
  %.3044 = load i32, i32* %.20
  store i32 %.3044, i32* %.2811
  br label %.2862 
.2886wc880:
  %.2890 = load i32, i32* %.21
  %.2891 = icmp slt i32 %.2890, 16
  br i1 %.2891, label %.2887wloop.880.891, label %.2888wn891
.2887wloop.880.891:
  %.2895 = load i32, i32* %.22
  %.2896 = srem i32 %.2895, 2
  %.2897 = icmp ne i32 %.2896, 0
  br i1 %.2897, label %.2893, label %.2894
.2888wn891:
  %.2940 = load i32, i32* %.20
  store i32 %.2940, i32* %.2872
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2944 = load i32, i32* %.2866
  store i32 %.2944, i32* %.22
  %.2946 = load i32, i32* %.2869
  store i32 %.2946, i32* %.23
  br label %.2948wc897 
.2893:
  %.2901 = load i32, i32* %.23
  %.2902 = srem i32 %.2901, 2
  %.2903 = icmp eq i32 %.2902, 0
  br i1 %.2903, label %.2899, label %.2900
.2894:
  %.2917 = load i32, i32* %.23
  %.2918 = srem i32 %.2917, 2
  %.2919 = icmp ne i32 %.2918, 0
  br i1 %.2919, label %.2915, label %.2916
.2899:
  %.2905 = load i32, i32* %.20
  %.2906 = load i32, i32* %.21
  %.2907 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2906
  %.2908 = load i32, i32* %.2907
  %.2909 = mul i32 1, %.2908
  %.2910 = add i32 %.2905, %.2909
  store i32 %.2910, i32* %.20
  br label %.2900 
.2900:
  br label %.2913 
.2913:
  %.2930 = load i32, i32* %.22
  %.2931 = sdiv i32 %.2930, 2
  store i32 %.2931, i32* %.22
  %.2933 = load i32, i32* %.23
  %.2934 = sdiv i32 %.2933, 2
  store i32 %.2934, i32* %.23
  %.2936 = load i32, i32* %.21
  %.2937 = add i32 %.2936, 1
  store i32 %.2937, i32* %.21
  br label %.2886wc880 
.2915:
  %.2921 = load i32, i32* %.20
  %.2922 = load i32, i32* %.21
  %.2923 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2922
  %.2924 = load i32, i32* %.2923
  %.2925 = mul i32 1, %.2924
  %.2926 = add i32 %.2921, %.2925
  store i32 %.2926, i32* %.20
  br label %.2916 
.2916:
  br label %.2913 
.2948wc897:
  %.2952 = load i32, i32* %.21
  %.2953 = icmp slt i32 %.2952, 16
  br i1 %.2953, label %.2949wloop.897.904, label %.2950wn904
.2949wloop.897.904:
  %.2957 = load i32, i32* %.22
  %.2958 = srem i32 %.2957, 2
  %.2959 = icmp ne i32 %.2958, 0
  br i1 %.2959, label %.2960, label %.2956
.2950wn904:
  %.2984 = load i32, i32* %.20
  store i32 %.2984, i32* %.2869
  br label %.2987 
.2955:
  %.2966 = load i32, i32* %.20
  %.2967 = load i32, i32* %.21
  %.2968 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.2967
  %.2969 = load i32, i32* %.2968
  %.2970 = mul i32 1, %.2969
  %.2971 = add i32 %.2966, %.2970
  store i32 %.2971, i32* %.20
  br label %.2956 
.2956:
  %.2974 = load i32, i32* %.22
  %.2975 = sdiv i32 %.2974, 2
  store i32 %.2975, i32* %.22
  %.2977 = load i32, i32* %.23
  %.2978 = sdiv i32 %.2977, 2
  store i32 %.2978, i32* %.23
  %.2980 = load i32, i32* %.21
  %.2981 = add i32 %.2980, 1
  store i32 %.2981, i32* %.21
  br label %.2948wc897 
.2960:
  %.2962 = load i32, i32* %.23
  %.2963 = srem i32 %.2962, 2
  %.2964 = icmp ne i32 %.2963, 0
  br i1 %.2964, label %.2955, label %.2956
.2986:
  store i32 0, i32* %.20
  br label %.2990 
.2987:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.2994 = load i32, i32* %.2869
  %.2995 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.2996 = load i32, i32* %.2995
  %.2997 = mul i32 %.2994, %.2996
  store i32 %.2997, i32* %.22
  store i32 65535, i32* %.23
  br label %.3000wc913 
.2990:
  %.3037 = load i32, i32* %.20
  store i32 %.3037, i32* %.2869
  %.3039 = load i32, i32* %.2872
  store i32 %.3039, i32* %.2866
  br label %.2873wc875 
.3000wc913:
  %.3004 = load i32, i32* %.21
  %.3005 = icmp slt i32 %.3004, 16
  br i1 %.3005, label %.3001wloop.913.920, label %.3002wn920
.3001wloop.913.920:
  %.3009 = load i32, i32* %.22
  %.3010 = srem i32 %.3009, 2
  %.3011 = icmp ne i32 %.3010, 0
  br i1 %.3011, label %.3012, label %.3008
.3002wn920:
  br label %.2990 
.3007:
  %.3018 = load i32, i32* %.20
  %.3019 = load i32, i32* %.21
  %.3020 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3019
  %.3021 = load i32, i32* %.3020
  %.3022 = mul i32 1, %.3021
  %.3023 = add i32 %.3018, %.3022
  store i32 %.3023, i32* %.20
  br label %.3008 
.3008:
  %.3026 = load i32, i32* %.22
  %.3027 = sdiv i32 %.3026, 2
  store i32 %.3027, i32* %.22
  %.3029 = load i32, i32* %.23
  %.3030 = sdiv i32 %.3029, 2
  store i32 %.3030, i32* %.23
  %.3032 = load i32, i32* %.21
  %.3033 = add i32 %.3032, 1
  store i32 %.3033, i32* %.21
  br label %.3000wc913 
.3012:
  %.3014 = load i32, i32* %.23
  %.3015 = srem i32 %.3014, 2
  %.3016 = icmp ne i32 %.3015, 0
  br i1 %.3016, label %.3007, label %.3008
.3054wc931:
  %.3058 = load i32, i32* %.3050
  %.3059 = icmp ne i32 %.3058, 0
  br i1 %.3059, label %.3055wloop.931.980, label %.3056wn980
.3055wloop.931.980:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3063 = load i32, i32* %.3047
  store i32 %.3063, i32* %.22
  %.3065 = load i32, i32* %.3050
  store i32 %.3065, i32* %.23
  br label %.3067wc936 
.3056wn980:
  %.3223 = load i32, i32* %.3047
  store i32 %.3223, i32* %.20
  %.3225 = load i32, i32* %.20
  store i32 %.3225, i32* %.2805
  %.3227 = load i32, i32* %.2808
  store i32 %.3227, i32* %.22
  store i32 1, i32* %.23
  %.3232 = load i32, i32* %.23
  %.3233 = icmp sge i32 %.3232, 15
  br i1 %.3233, label %.3230, label %.3231
.3067wc936:
  %.3071 = load i32, i32* %.21
  %.3072 = icmp slt i32 %.3071, 16
  br i1 %.3072, label %.3068wloop.936.947, label %.3069wn947
.3068wloop.936.947:
  %.3076 = load i32, i32* %.22
  %.3077 = srem i32 %.3076, 2
  %.3078 = icmp ne i32 %.3077, 0
  br i1 %.3078, label %.3074, label %.3075
.3069wn947:
  %.3121 = load i32, i32* %.20
  store i32 %.3121, i32* %.3053
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3125 = load i32, i32* %.3047
  store i32 %.3125, i32* %.22
  %.3127 = load i32, i32* %.3050
  store i32 %.3127, i32* %.23
  br label %.3129wc953 
.3074:
  %.3082 = load i32, i32* %.23
  %.3083 = srem i32 %.3082, 2
  %.3084 = icmp eq i32 %.3083, 0
  br i1 %.3084, label %.3080, label %.3081
.3075:
  %.3098 = load i32, i32* %.23
  %.3099 = srem i32 %.3098, 2
  %.3100 = icmp ne i32 %.3099, 0
  br i1 %.3100, label %.3096, label %.3097
.3080:
  %.3086 = load i32, i32* %.20
  %.3087 = load i32, i32* %.21
  %.3088 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3087
  %.3089 = load i32, i32* %.3088
  %.3090 = mul i32 1, %.3089
  %.3091 = add i32 %.3086, %.3090
  store i32 %.3091, i32* %.20
  br label %.3081 
.3081:
  br label %.3094 
.3094:
  %.3111 = load i32, i32* %.22
  %.3112 = sdiv i32 %.3111, 2
  store i32 %.3112, i32* %.22
  %.3114 = load i32, i32* %.23
  %.3115 = sdiv i32 %.3114, 2
  store i32 %.3115, i32* %.23
  %.3117 = load i32, i32* %.21
  %.3118 = add i32 %.3117, 1
  store i32 %.3118, i32* %.21
  br label %.3067wc936 
.3096:
  %.3102 = load i32, i32* %.20
  %.3103 = load i32, i32* %.21
  %.3104 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3103
  %.3105 = load i32, i32* %.3104
  %.3106 = mul i32 1, %.3105
  %.3107 = add i32 %.3102, %.3106
  store i32 %.3107, i32* %.20
  br label %.3097 
.3097:
  br label %.3094 
.3129wc953:
  %.3133 = load i32, i32* %.21
  %.3134 = icmp slt i32 %.3133, 16
  br i1 %.3134, label %.3130wloop.953.960, label %.3131wn960
.3130wloop.953.960:
  %.3138 = load i32, i32* %.22
  %.3139 = srem i32 %.3138, 2
  %.3140 = icmp ne i32 %.3139, 0
  br i1 %.3140, label %.3141, label %.3137
.3131wn960:
  %.3165 = load i32, i32* %.20
  store i32 %.3165, i32* %.3050
  br label %.3168 
.3136:
  %.3147 = load i32, i32* %.20
  %.3148 = load i32, i32* %.21
  %.3149 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3148
  %.3150 = load i32, i32* %.3149
  %.3151 = mul i32 1, %.3150
  %.3152 = add i32 %.3147, %.3151
  store i32 %.3152, i32* %.20
  br label %.3137 
.3137:
  %.3155 = load i32, i32* %.22
  %.3156 = sdiv i32 %.3155, 2
  store i32 %.3156, i32* %.22
  %.3158 = load i32, i32* %.23
  %.3159 = sdiv i32 %.3158, 2
  store i32 %.3159, i32* %.23
  %.3161 = load i32, i32* %.21
  %.3162 = add i32 %.3161, 1
  store i32 %.3162, i32* %.21
  br label %.3129wc953 
.3141:
  %.3143 = load i32, i32* %.23
  %.3144 = srem i32 %.3143, 2
  %.3145 = icmp ne i32 %.3144, 0
  br i1 %.3145, label %.3136, label %.3137
.3167:
  store i32 0, i32* %.20
  br label %.3171 
.3168:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3175 = load i32, i32* %.3050
  %.3176 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.3177 = load i32, i32* %.3176
  %.3178 = mul i32 %.3175, %.3177
  store i32 %.3178, i32* %.22
  store i32 65535, i32* %.23
  br label %.3181wc969 
.3171:
  %.3218 = load i32, i32* %.20
  store i32 %.3218, i32* %.3050
  %.3220 = load i32, i32* %.3053
  store i32 %.3220, i32* %.3047
  br label %.3054wc931 
.3181wc969:
  %.3185 = load i32, i32* %.21
  %.3186 = icmp slt i32 %.3185, 16
  br i1 %.3186, label %.3182wloop.969.976, label %.3183wn976
.3182wloop.969.976:
  %.3190 = load i32, i32* %.22
  %.3191 = srem i32 %.3190, 2
  %.3192 = icmp ne i32 %.3191, 0
  br i1 %.3192, label %.3193, label %.3189
.3183wn976:
  br label %.3171 
.3188:
  %.3199 = load i32, i32* %.20
  %.3200 = load i32, i32* %.21
  %.3201 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3200
  %.3202 = load i32, i32* %.3201
  %.3203 = mul i32 1, %.3202
  %.3204 = add i32 %.3199, %.3203
  store i32 %.3204, i32* %.20
  br label %.3189 
.3189:
  %.3207 = load i32, i32* %.22
  %.3208 = sdiv i32 %.3207, 2
  store i32 %.3208, i32* %.22
  %.3210 = load i32, i32* %.23
  %.3211 = sdiv i32 %.3210, 2
  store i32 %.3211, i32* %.23
  %.3213 = load i32, i32* %.21
  %.3214 = add i32 %.3213, 1
  store i32 %.3214, i32* %.21
  br label %.3181wc969 
.3193:
  %.3195 = load i32, i32* %.23
  %.3196 = srem i32 %.3195, 2
  %.3197 = icmp ne i32 %.3196, 0
  br i1 %.3197, label %.3188, label %.3189
.3230:
  %.3237 = load i32, i32* %.22
  %.3238 = icmp slt i32 %.3237, 0
  br i1 %.3238, label %.3235, label %.3236
.3231:
  %.3249 = load i32, i32* %.23
  %.3250 = icmp sgt i32 %.3249, 0
  br i1 %.3250, label %.3247, label %.3248
.3235:
  store i32 65535, i32* %.20
  br label %.3241 
.3236:
  store i32 0, i32* %.20
  br label %.3241 
.3241:
  br label %.3245 
.3245:
  %.3287 = load i32, i32* %.20
  store i32 %.3287, i32* %.2808
  br label %.2813wc859 
.3247:
  %.3254 = load i32, i32* %.22
  %.3255 = icmp sgt i32 %.3254, 32767
  br i1 %.3255, label %.3252, label %.3253
.3248:
  %.3283 = load i32, i32* %.22
  store i32 %.3283, i32* %.20
  br label %.3281 
.3252:
  %.3257 = load i32, i32* %.22
  %.3258 = load i32, i32* %.23
  %.3259 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3258
  %.3260 = load i32, i32* %.3259
  %.3261 = sdiv i32 %.3257, %.3260
  store i32 %.3261, i32* %.22
  %.3263 = load i32, i32* %.22
  %.3264 = add i32 %.3263, 65536
  %.3265 = load i32, i32* %.23
  %.3266 = sub i32 15, %.3265
  %.3267 = add i32 %.3266, 1
  %.3268 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3267
  %.3269 = load i32, i32* %.3268
  %.3270 = sub i32 %.3264, %.3269
  store i32 %.3270, i32* %.20
  br label %.3272 
.3253:
  %.3274 = load i32, i32* %.22
  %.3275 = load i32, i32* %.23
  %.3276 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3275
  %.3277 = load i32, i32* %.3276
  %.3278 = sdiv i32 %.3274, %.3277
  store i32 %.3278, i32* %.20
  br label %.3272 
.3272:
  br label %.3281 
.3281:
  br label %.3245 
.3297:
  %.3304 = load i32, i32* %.22
  %.3305 = icmp slt i32 %.3304, 0
  br i1 %.3305, label %.3302, label %.3303
.3298:
  %.3316 = load i32, i32* %.23
  %.3317 = icmp sgt i32 %.3316, 0
  br i1 %.3317, label %.3314, label %.3315
.3302:
  store i32 65535, i32* %.20
  br label %.3308 
.3303:
  store i32 0, i32* %.20
  br label %.3308 
.3308:
  br label %.3312 
.3312:
  %.3354 = load i32, i32* %.20
  store i32 %.3354, i32* %.2257
  br label %.2262wc692 
.3314:
  %.3321 = load i32, i32* %.22
  %.3322 = icmp sgt i32 %.3321, 32767
  br i1 %.3322, label %.3319, label %.3320
.3315:
  %.3350 = load i32, i32* %.22
  store i32 %.3350, i32* %.20
  br label %.3348 
.3319:
  %.3324 = load i32, i32* %.22
  %.3325 = load i32, i32* %.23
  %.3326 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3325
  %.3327 = load i32, i32* %.3326
  %.3328 = sdiv i32 %.3324, %.3327
  store i32 %.3328, i32* %.22
  %.3330 = load i32, i32* %.22
  %.3331 = add i32 %.3330, 65536
  %.3332 = load i32, i32* %.23
  %.3333 = sub i32 15, %.3332
  %.3334 = add i32 %.3333, 1
  %.3335 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3334
  %.3336 = load i32, i32* %.3335
  %.3337 = sub i32 %.3331, %.3336
  store i32 %.3337, i32* %.20
  br label %.3339 
.3320:
  %.3341 = load i32, i32* %.22
  %.3342 = load i32, i32* %.23
  %.3343 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3342
  %.3344 = load i32, i32* %.3343
  %.3345 = sdiv i32 %.3341, %.3344
  store i32 %.3345, i32* %.20
  br label %.3339 
.3339:
  br label %.3348 
.3348:
  br label %.3312 
.3367wc1034:
  %.3371 = load i32, i32* %.24
  %.3372 = icmp slt i32 %.3371, 16
  br i1 %.3372, label %.3368wloop.1034.1376, label %.3369wn1376
.3368wloop.1034.1376:
  store i32 2, i32* %.3374
  %.3377 = load i32, i32* %.24
  store i32 %.3377, i32* %.3376
  store i32 1, i32* %.3379
  br label %.3381wc1037 
.3369wn1376:
  ret i32 0 
.3381wc1037:
  %.3385 = load i32, i32* %.3376
  %.3386 = icmp sgt i32 %.3385, 0
  br i1 %.3386, label %.3382wloop.1037.1371, label %.3383wn1371
.3382wloop.1037.1371:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3390 = load i32, i32* %.3376
  store i32 %.3390, i32* %.22
  store i32 1, i32* %.23
  br label %.3393wc1042 
.3383wn1371:
  %.4476 = load i32, i32* %.3379
  store i32 %.4476, i32* %.20
  %.4480 = load i32, i32* %.24
  %.4481 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4480
  %.4482 = load i32, i32* %.4481
  %.4483 = load i32, i32* %.20
  %.4484 = icmp ne i32 %.4482, %.4483
  br i1 %.4484, label %.4478, label %.4479
.3393wc1042:
  %.3397 = load i32, i32* %.21
  %.3398 = icmp slt i32 %.3397, 16
  br i1 %.3398, label %.3394wloop.1042.1049, label %.3395wn1049
.3394wloop.1042.1049:
  %.3402 = load i32, i32* %.22
  %.3403 = srem i32 %.3402, 2
  %.3404 = icmp ne i32 %.3403, 0
  br i1 %.3404, label %.3405, label %.3401
.3395wn1049:
  %.3431 = load i32, i32* %.20
  %.3432 = icmp ne i32 %.3431, 0
  br i1 %.3432, label %.3429, label %.3430
.3400:
  %.3411 = load i32, i32* %.20
  %.3412 = load i32, i32* %.21
  %.3413 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3412
  %.3414 = load i32, i32* %.3413
  %.3415 = mul i32 1, %.3414
  %.3416 = add i32 %.3411, %.3415
  store i32 %.3416, i32* %.20
  br label %.3401 
.3401:
  %.3419 = load i32, i32* %.22
  %.3420 = sdiv i32 %.3419, 2
  store i32 %.3420, i32* %.22
  %.3422 = load i32, i32* %.23
  %.3423 = sdiv i32 %.3422, 2
  store i32 %.3423, i32* %.23
  %.3425 = load i32, i32* %.21
  %.3426 = add i32 %.3425, 1
  store i32 %.3426, i32* %.21
  br label %.3393wc1042 
.3405:
  %.3407 = load i32, i32* %.23
  %.3408 = srem i32 %.3407, 2
  %.3409 = icmp ne i32 %.3408, 0
  br i1 %.3409, label %.3400, label %.3401
.3429:
  %.3435 = load i32, i32* %.3379
  store i32 %.3435, i32* %.3434
  %.3438 = load i32, i32* %.3374
  store i32 %.3438, i32* %.3437
  store i32 0, i32* %.3440
  br label %.3442wc1053 
.3430:
  %.3925 = load i32, i32* %.3374
  store i32 %.3925, i32* %.3924
  %.3928 = load i32, i32* %.3374
  store i32 %.3928, i32* %.3927
  store i32 0, i32* %.3930
  br label %.3932wc1204 
.3442wc1053:
  %.3446 = load i32, i32* %.3437
  %.3447 = icmp ne i32 %.3446, 0
  br i1 %.3447, label %.3443wloop.1053.1197, label %.3444wn1197
.3443wloop.1053.1197:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3451 = load i32, i32* %.3437
  store i32 %.3451, i32* %.22
  store i32 1, i32* %.23
  br label %.3454wc1058 
.3444wn1197:
  %.3919 = load i32, i32* %.3440
  store i32 %.3919, i32* %.20
  %.3921 = load i32, i32* %.20
  store i32 %.3921, i32* %.3379
  br label %.3430 
.3454wc1058:
  %.3458 = load i32, i32* %.21
  %.3459 = icmp slt i32 %.3458, 16
  br i1 %.3459, label %.3455wloop.1058.1065, label %.3456wn1065
.3455wloop.1058.1065:
  %.3463 = load i32, i32* %.22
  %.3464 = srem i32 %.3463, 2
  %.3465 = icmp ne i32 %.3464, 0
  br i1 %.3465, label %.3466, label %.3462
.3456wn1065:
  %.3492 = load i32, i32* %.20
  %.3493 = icmp ne i32 %.3492, 0
  br i1 %.3493, label %.3490, label %.3491
.3461:
  %.3472 = load i32, i32* %.20
  %.3473 = load i32, i32* %.21
  %.3474 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3473
  %.3475 = load i32, i32* %.3474
  %.3476 = mul i32 1, %.3475
  %.3477 = add i32 %.3472, %.3476
  store i32 %.3477, i32* %.20
  br label %.3462 
.3462:
  %.3480 = load i32, i32* %.22
  %.3481 = sdiv i32 %.3480, 2
  store i32 %.3481, i32* %.22
  %.3483 = load i32, i32* %.23
  %.3484 = sdiv i32 %.3483, 2
  store i32 %.3484, i32* %.23
  %.3486 = load i32, i32* %.21
  %.3487 = add i32 %.3486, 1
  store i32 %.3487, i32* %.21
  br label %.3454wc1058 
.3466:
  %.3468 = load i32, i32* %.23
  %.3469 = srem i32 %.3468, 2
  %.3470 = icmp ne i32 %.3469, 0
  br i1 %.3470, label %.3461, label %.3462
.3490:
  %.3496 = load i32, i32* %.3440
  store i32 %.3496, i32* %.3495
  %.3499 = load i32, i32* %.3434
  store i32 %.3499, i32* %.3498
  br label %.3502wc1069 
.3491:
  %.3677 = load i32, i32* %.3434
  store i32 %.3677, i32* %.3676
  %.3680 = load i32, i32* %.3434
  store i32 %.3680, i32* %.3679
  br label %.3683wc1125 
.3502wc1069:
  %.3506 = load i32, i32* %.3498
  %.3507 = icmp ne i32 %.3506, 0
  br i1 %.3507, label %.3503wloop.1069.1118, label %.3504wn1118
.3503wloop.1069.1118:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3511 = load i32, i32* %.3495
  store i32 %.3511, i32* %.22
  %.3513 = load i32, i32* %.3498
  store i32 %.3513, i32* %.23
  br label %.3515wc1074 
.3504wn1118:
  %.3671 = load i32, i32* %.3495
  store i32 %.3671, i32* %.20
  %.3673 = load i32, i32* %.20
  store i32 %.3673, i32* %.3440
  br label %.3491 
.3515wc1074:
  %.3519 = load i32, i32* %.21
  %.3520 = icmp slt i32 %.3519, 16
  br i1 %.3520, label %.3516wloop.1074.1085, label %.3517wn1085
.3516wloop.1074.1085:
  %.3524 = load i32, i32* %.22
  %.3525 = srem i32 %.3524, 2
  %.3526 = icmp ne i32 %.3525, 0
  br i1 %.3526, label %.3522, label %.3523
.3517wn1085:
  %.3569 = load i32, i32* %.20
  store i32 %.3569, i32* %.3501
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3573 = load i32, i32* %.3495
  store i32 %.3573, i32* %.22
  %.3575 = load i32, i32* %.3498
  store i32 %.3575, i32* %.23
  br label %.3577wc1091 
.3522:
  %.3530 = load i32, i32* %.23
  %.3531 = srem i32 %.3530, 2
  %.3532 = icmp eq i32 %.3531, 0
  br i1 %.3532, label %.3528, label %.3529
.3523:
  %.3546 = load i32, i32* %.23
  %.3547 = srem i32 %.3546, 2
  %.3548 = icmp ne i32 %.3547, 0
  br i1 %.3548, label %.3544, label %.3545
.3528:
  %.3534 = load i32, i32* %.20
  %.3535 = load i32, i32* %.21
  %.3536 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3535
  %.3537 = load i32, i32* %.3536
  %.3538 = mul i32 1, %.3537
  %.3539 = add i32 %.3534, %.3538
  store i32 %.3539, i32* %.20
  br label %.3529 
.3529:
  br label %.3542 
.3542:
  %.3559 = load i32, i32* %.22
  %.3560 = sdiv i32 %.3559, 2
  store i32 %.3560, i32* %.22
  %.3562 = load i32, i32* %.23
  %.3563 = sdiv i32 %.3562, 2
  store i32 %.3563, i32* %.23
  %.3565 = load i32, i32* %.21
  %.3566 = add i32 %.3565, 1
  store i32 %.3566, i32* %.21
  br label %.3515wc1074 
.3544:
  %.3550 = load i32, i32* %.20
  %.3551 = load i32, i32* %.21
  %.3552 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3551
  %.3553 = load i32, i32* %.3552
  %.3554 = mul i32 1, %.3553
  %.3555 = add i32 %.3550, %.3554
  store i32 %.3555, i32* %.20
  br label %.3545 
.3545:
  br label %.3542 
.3577wc1091:
  %.3581 = load i32, i32* %.21
  %.3582 = icmp slt i32 %.3581, 16
  br i1 %.3582, label %.3578wloop.1091.1098, label %.3579wn1098
.3578wloop.1091.1098:
  %.3586 = load i32, i32* %.22
  %.3587 = srem i32 %.3586, 2
  %.3588 = icmp ne i32 %.3587, 0
  br i1 %.3588, label %.3589, label %.3585
.3579wn1098:
  %.3613 = load i32, i32* %.20
  store i32 %.3613, i32* %.3498
  br label %.3616 
.3584:
  %.3595 = load i32, i32* %.20
  %.3596 = load i32, i32* %.21
  %.3597 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3596
  %.3598 = load i32, i32* %.3597
  %.3599 = mul i32 1, %.3598
  %.3600 = add i32 %.3595, %.3599
  store i32 %.3600, i32* %.20
  br label %.3585 
.3585:
  %.3603 = load i32, i32* %.22
  %.3604 = sdiv i32 %.3603, 2
  store i32 %.3604, i32* %.22
  %.3606 = load i32, i32* %.23
  %.3607 = sdiv i32 %.3606, 2
  store i32 %.3607, i32* %.23
  %.3609 = load i32, i32* %.21
  %.3610 = add i32 %.3609, 1
  store i32 %.3610, i32* %.21
  br label %.3577wc1091 
.3589:
  %.3591 = load i32, i32* %.23
  %.3592 = srem i32 %.3591, 2
  %.3593 = icmp ne i32 %.3592, 0
  br i1 %.3593, label %.3584, label %.3585
.3615:
  store i32 0, i32* %.20
  br label %.3619 
.3616:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3623 = load i32, i32* %.3498
  %.3624 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.3625 = load i32, i32* %.3624
  %.3626 = mul i32 %.3623, %.3625
  store i32 %.3626, i32* %.22
  store i32 65535, i32* %.23
  br label %.3629wc1107 
.3619:
  %.3666 = load i32, i32* %.20
  store i32 %.3666, i32* %.3498
  %.3668 = load i32, i32* %.3501
  store i32 %.3668, i32* %.3495
  br label %.3502wc1069 
.3629wc1107:
  %.3633 = load i32, i32* %.21
  %.3634 = icmp slt i32 %.3633, 16
  br i1 %.3634, label %.3630wloop.1107.1114, label %.3631wn1114
.3630wloop.1107.1114:
  %.3638 = load i32, i32* %.22
  %.3639 = srem i32 %.3638, 2
  %.3640 = icmp ne i32 %.3639, 0
  br i1 %.3640, label %.3641, label %.3637
.3631wn1114:
  br label %.3619 
.3636:
  %.3647 = load i32, i32* %.20
  %.3648 = load i32, i32* %.21
  %.3649 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3648
  %.3650 = load i32, i32* %.3649
  %.3651 = mul i32 1, %.3650
  %.3652 = add i32 %.3647, %.3651
  store i32 %.3652, i32* %.20
  br label %.3637 
.3637:
  %.3655 = load i32, i32* %.22
  %.3656 = sdiv i32 %.3655, 2
  store i32 %.3656, i32* %.22
  %.3658 = load i32, i32* %.23
  %.3659 = sdiv i32 %.3658, 2
  store i32 %.3659, i32* %.23
  %.3661 = load i32, i32* %.21
  %.3662 = add i32 %.3661, 1
  store i32 %.3662, i32* %.21
  br label %.3629wc1107 
.3641:
  %.3643 = load i32, i32* %.23
  %.3644 = srem i32 %.3643, 2
  %.3645 = icmp ne i32 %.3644, 0
  br i1 %.3645, label %.3636, label %.3637
.3683wc1125:
  %.3687 = load i32, i32* %.3679
  %.3688 = icmp ne i32 %.3687, 0
  br i1 %.3688, label %.3684wloop.1125.1174, label %.3685wn1174
.3684wloop.1125.1174:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3692 = load i32, i32* %.3676
  store i32 %.3692, i32* %.22
  %.3694 = load i32, i32* %.3679
  store i32 %.3694, i32* %.23
  br label %.3696wc1130 
.3685wn1174:
  %.3852 = load i32, i32* %.3676
  store i32 %.3852, i32* %.20
  %.3854 = load i32, i32* %.20
  store i32 %.3854, i32* %.3434
  %.3856 = load i32, i32* %.3437
  store i32 %.3856, i32* %.22
  store i32 1, i32* %.23
  %.3861 = load i32, i32* %.23
  %.3862 = icmp sge i32 %.3861, 15
  br i1 %.3862, label %.3859, label %.3860
.3696wc1130:
  %.3700 = load i32, i32* %.21
  %.3701 = icmp slt i32 %.3700, 16
  br i1 %.3701, label %.3697wloop.1130.1141, label %.3698wn1141
.3697wloop.1130.1141:
  %.3705 = load i32, i32* %.22
  %.3706 = srem i32 %.3705, 2
  %.3707 = icmp ne i32 %.3706, 0
  br i1 %.3707, label %.3703, label %.3704
.3698wn1141:
  %.3750 = load i32, i32* %.20
  store i32 %.3750, i32* %.3682
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3754 = load i32, i32* %.3676
  store i32 %.3754, i32* %.22
  %.3756 = load i32, i32* %.3679
  store i32 %.3756, i32* %.23
  br label %.3758wc1147 
.3703:
  %.3711 = load i32, i32* %.23
  %.3712 = srem i32 %.3711, 2
  %.3713 = icmp eq i32 %.3712, 0
  br i1 %.3713, label %.3709, label %.3710
.3704:
  %.3727 = load i32, i32* %.23
  %.3728 = srem i32 %.3727, 2
  %.3729 = icmp ne i32 %.3728, 0
  br i1 %.3729, label %.3725, label %.3726
.3709:
  %.3715 = load i32, i32* %.20
  %.3716 = load i32, i32* %.21
  %.3717 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3716
  %.3718 = load i32, i32* %.3717
  %.3719 = mul i32 1, %.3718
  %.3720 = add i32 %.3715, %.3719
  store i32 %.3720, i32* %.20
  br label %.3710 
.3710:
  br label %.3723 
.3723:
  %.3740 = load i32, i32* %.22
  %.3741 = sdiv i32 %.3740, 2
  store i32 %.3741, i32* %.22
  %.3743 = load i32, i32* %.23
  %.3744 = sdiv i32 %.3743, 2
  store i32 %.3744, i32* %.23
  %.3746 = load i32, i32* %.21
  %.3747 = add i32 %.3746, 1
  store i32 %.3747, i32* %.21
  br label %.3696wc1130 
.3725:
  %.3731 = load i32, i32* %.20
  %.3732 = load i32, i32* %.21
  %.3733 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3732
  %.3734 = load i32, i32* %.3733
  %.3735 = mul i32 1, %.3734
  %.3736 = add i32 %.3731, %.3735
  store i32 %.3736, i32* %.20
  br label %.3726 
.3726:
  br label %.3723 
.3758wc1147:
  %.3762 = load i32, i32* %.21
  %.3763 = icmp slt i32 %.3762, 16
  br i1 %.3763, label %.3759wloop.1147.1154, label %.3760wn1154
.3759wloop.1147.1154:
  %.3767 = load i32, i32* %.22
  %.3768 = srem i32 %.3767, 2
  %.3769 = icmp ne i32 %.3768, 0
  br i1 %.3769, label %.3770, label %.3766
.3760wn1154:
  %.3794 = load i32, i32* %.20
  store i32 %.3794, i32* %.3679
  br label %.3797 
.3765:
  %.3776 = load i32, i32* %.20
  %.3777 = load i32, i32* %.21
  %.3778 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3777
  %.3779 = load i32, i32* %.3778
  %.3780 = mul i32 1, %.3779
  %.3781 = add i32 %.3776, %.3780
  store i32 %.3781, i32* %.20
  br label %.3766 
.3766:
  %.3784 = load i32, i32* %.22
  %.3785 = sdiv i32 %.3784, 2
  store i32 %.3785, i32* %.22
  %.3787 = load i32, i32* %.23
  %.3788 = sdiv i32 %.3787, 2
  store i32 %.3788, i32* %.23
  %.3790 = load i32, i32* %.21
  %.3791 = add i32 %.3790, 1
  store i32 %.3791, i32* %.21
  br label %.3758wc1147 
.3770:
  %.3772 = load i32, i32* %.23
  %.3773 = srem i32 %.3772, 2
  %.3774 = icmp ne i32 %.3773, 0
  br i1 %.3774, label %.3765, label %.3766
.3796:
  store i32 0, i32* %.20
  br label %.3800 
.3797:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3804 = load i32, i32* %.3679
  %.3805 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.3806 = load i32, i32* %.3805
  %.3807 = mul i32 %.3804, %.3806
  store i32 %.3807, i32* %.22
  store i32 65535, i32* %.23
  br label %.3810wc1163 
.3800:
  %.3847 = load i32, i32* %.20
  store i32 %.3847, i32* %.3679
  %.3849 = load i32, i32* %.3682
  store i32 %.3849, i32* %.3676
  br label %.3683wc1125 
.3810wc1163:
  %.3814 = load i32, i32* %.21
  %.3815 = icmp slt i32 %.3814, 16
  br i1 %.3815, label %.3811wloop.1163.1170, label %.3812wn1170
.3811wloop.1163.1170:
  %.3819 = load i32, i32* %.22
  %.3820 = srem i32 %.3819, 2
  %.3821 = icmp ne i32 %.3820, 0
  br i1 %.3821, label %.3822, label %.3818
.3812wn1170:
  br label %.3800 
.3817:
  %.3828 = load i32, i32* %.20
  %.3829 = load i32, i32* %.21
  %.3830 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3829
  %.3831 = load i32, i32* %.3830
  %.3832 = mul i32 1, %.3831
  %.3833 = add i32 %.3828, %.3832
  store i32 %.3833, i32* %.20
  br label %.3818 
.3818:
  %.3836 = load i32, i32* %.22
  %.3837 = sdiv i32 %.3836, 2
  store i32 %.3837, i32* %.22
  %.3839 = load i32, i32* %.23
  %.3840 = sdiv i32 %.3839, 2
  store i32 %.3840, i32* %.23
  %.3842 = load i32, i32* %.21
  %.3843 = add i32 %.3842, 1
  store i32 %.3843, i32* %.21
  br label %.3810wc1163 
.3822:
  %.3824 = load i32, i32* %.23
  %.3825 = srem i32 %.3824, 2
  %.3826 = icmp ne i32 %.3825, 0
  br i1 %.3826, label %.3817, label %.3818
.3859:
  %.3866 = load i32, i32* %.22
  %.3867 = icmp slt i32 %.3866, 0
  br i1 %.3867, label %.3864, label %.3865
.3860:
  %.3878 = load i32, i32* %.23
  %.3879 = icmp sgt i32 %.3878, 0
  br i1 %.3879, label %.3876, label %.3877
.3864:
  store i32 65535, i32* %.20
  br label %.3870 
.3865:
  store i32 0, i32* %.20
  br label %.3870 
.3870:
  br label %.3874 
.3874:
  %.3916 = load i32, i32* %.20
  store i32 %.3916, i32* %.3437
  br label %.3442wc1053 
.3876:
  %.3883 = load i32, i32* %.22
  %.3884 = icmp sgt i32 %.3883, 32767
  br i1 %.3884, label %.3881, label %.3882
.3877:
  %.3912 = load i32, i32* %.22
  store i32 %.3912, i32* %.20
  br label %.3910 
.3881:
  %.3886 = load i32, i32* %.22
  %.3887 = load i32, i32* %.23
  %.3888 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3887
  %.3889 = load i32, i32* %.3888
  %.3890 = sdiv i32 %.3886, %.3889
  store i32 %.3890, i32* %.22
  %.3892 = load i32, i32* %.22
  %.3893 = add i32 %.3892, 65536
  %.3894 = load i32, i32* %.23
  %.3895 = sub i32 15, %.3894
  %.3896 = add i32 %.3895, 1
  %.3897 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3896
  %.3898 = load i32, i32* %.3897
  %.3899 = sub i32 %.3893, %.3898
  store i32 %.3899, i32* %.20
  br label %.3901 
.3882:
  %.3903 = load i32, i32* %.22
  %.3904 = load i32, i32* %.23
  %.3905 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3904
  %.3906 = load i32, i32* %.3905
  %.3907 = sdiv i32 %.3903, %.3906
  store i32 %.3907, i32* %.20
  br label %.3901 
.3901:
  br label %.3910 
.3910:
  br label %.3874 
.3932wc1204:
  %.3936 = load i32, i32* %.3927
  %.3937 = icmp ne i32 %.3936, 0
  br i1 %.3937, label %.3933wloop.1204.1348, label %.3934wn1348
.3933wloop.1204.1348:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.3941 = load i32, i32* %.3927
  store i32 %.3941, i32* %.22
  store i32 1, i32* %.23
  br label %.3944wc1209 
.3934wn1348:
  %.4409 = load i32, i32* %.3930
  store i32 %.4409, i32* %.20
  %.4411 = load i32, i32* %.20
  store i32 %.4411, i32* %.3374
  %.4413 = load i32, i32* %.3376
  store i32 %.4413, i32* %.22
  store i32 1, i32* %.23
  %.4418 = load i32, i32* %.23
  %.4419 = icmp sge i32 %.4418, 15
  br i1 %.4419, label %.4416, label %.4417
.3944wc1209:
  %.3948 = load i32, i32* %.21
  %.3949 = icmp slt i32 %.3948, 16
  br i1 %.3949, label %.3945wloop.1209.1216, label %.3946wn1216
.3945wloop.1209.1216:
  %.3953 = load i32, i32* %.22
  %.3954 = srem i32 %.3953, 2
  %.3955 = icmp ne i32 %.3954, 0
  br i1 %.3955, label %.3956, label %.3952
.3946wn1216:
  %.3982 = load i32, i32* %.20
  %.3983 = icmp ne i32 %.3982, 0
  br i1 %.3983, label %.3980, label %.3981
.3951:
  %.3962 = load i32, i32* %.20
  %.3963 = load i32, i32* %.21
  %.3964 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.3963
  %.3965 = load i32, i32* %.3964
  %.3966 = mul i32 1, %.3965
  %.3967 = add i32 %.3962, %.3966
  store i32 %.3967, i32* %.20
  br label %.3952 
.3952:
  %.3970 = load i32, i32* %.22
  %.3971 = sdiv i32 %.3970, 2
  store i32 %.3971, i32* %.22
  %.3973 = load i32, i32* %.23
  %.3974 = sdiv i32 %.3973, 2
  store i32 %.3974, i32* %.23
  %.3976 = load i32, i32* %.21
  %.3977 = add i32 %.3976, 1
  store i32 %.3977, i32* %.21
  br label %.3944wc1209 
.3956:
  %.3958 = load i32, i32* %.23
  %.3959 = srem i32 %.3958, 2
  %.3960 = icmp ne i32 %.3959, 0
  br i1 %.3960, label %.3951, label %.3952
.3980:
  %.3986 = load i32, i32* %.3930
  store i32 %.3986, i32* %.3985
  %.3989 = load i32, i32* %.3924
  store i32 %.3989, i32* %.3988
  br label %.3992wc1220 
.3981:
  %.4167 = load i32, i32* %.3924
  store i32 %.4167, i32* %.4166
  %.4170 = load i32, i32* %.3924
  store i32 %.4170, i32* %.4169
  br label %.4173wc1276 
.3992wc1220:
  %.3996 = load i32, i32* %.3988
  %.3997 = icmp ne i32 %.3996, 0
  br i1 %.3997, label %.3993wloop.1220.1269, label %.3994wn1269
.3993wloop.1220.1269:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4001 = load i32, i32* %.3985
  store i32 %.4001, i32* %.22
  %.4003 = load i32, i32* %.3988
  store i32 %.4003, i32* %.23
  br label %.4005wc1225 
.3994wn1269:
  %.4161 = load i32, i32* %.3985
  store i32 %.4161, i32* %.20
  %.4163 = load i32, i32* %.20
  store i32 %.4163, i32* %.3930
  br label %.3981 
.4005wc1225:
  %.4009 = load i32, i32* %.21
  %.4010 = icmp slt i32 %.4009, 16
  br i1 %.4010, label %.4006wloop.1225.1236, label %.4007wn1236
.4006wloop.1225.1236:
  %.4014 = load i32, i32* %.22
  %.4015 = srem i32 %.4014, 2
  %.4016 = icmp ne i32 %.4015, 0
  br i1 %.4016, label %.4012, label %.4013
.4007wn1236:
  %.4059 = load i32, i32* %.20
  store i32 %.4059, i32* %.3991
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4063 = load i32, i32* %.3985
  store i32 %.4063, i32* %.22
  %.4065 = load i32, i32* %.3988
  store i32 %.4065, i32* %.23
  br label %.4067wc1242 
.4012:
  %.4020 = load i32, i32* %.23
  %.4021 = srem i32 %.4020, 2
  %.4022 = icmp eq i32 %.4021, 0
  br i1 %.4022, label %.4018, label %.4019
.4013:
  %.4036 = load i32, i32* %.23
  %.4037 = srem i32 %.4036, 2
  %.4038 = icmp ne i32 %.4037, 0
  br i1 %.4038, label %.4034, label %.4035
.4018:
  %.4024 = load i32, i32* %.20
  %.4025 = load i32, i32* %.21
  %.4026 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4025
  %.4027 = load i32, i32* %.4026
  %.4028 = mul i32 1, %.4027
  %.4029 = add i32 %.4024, %.4028
  store i32 %.4029, i32* %.20
  br label %.4019 
.4019:
  br label %.4032 
.4032:
  %.4049 = load i32, i32* %.22
  %.4050 = sdiv i32 %.4049, 2
  store i32 %.4050, i32* %.22
  %.4052 = load i32, i32* %.23
  %.4053 = sdiv i32 %.4052, 2
  store i32 %.4053, i32* %.23
  %.4055 = load i32, i32* %.21
  %.4056 = add i32 %.4055, 1
  store i32 %.4056, i32* %.21
  br label %.4005wc1225 
.4034:
  %.4040 = load i32, i32* %.20
  %.4041 = load i32, i32* %.21
  %.4042 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4041
  %.4043 = load i32, i32* %.4042
  %.4044 = mul i32 1, %.4043
  %.4045 = add i32 %.4040, %.4044
  store i32 %.4045, i32* %.20
  br label %.4035 
.4035:
  br label %.4032 
.4067wc1242:
  %.4071 = load i32, i32* %.21
  %.4072 = icmp slt i32 %.4071, 16
  br i1 %.4072, label %.4068wloop.1242.1249, label %.4069wn1249
.4068wloop.1242.1249:
  %.4076 = load i32, i32* %.22
  %.4077 = srem i32 %.4076, 2
  %.4078 = icmp ne i32 %.4077, 0
  br i1 %.4078, label %.4079, label %.4075
.4069wn1249:
  %.4103 = load i32, i32* %.20
  store i32 %.4103, i32* %.3988
  br label %.4106 
.4074:
  %.4085 = load i32, i32* %.20
  %.4086 = load i32, i32* %.21
  %.4087 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4086
  %.4088 = load i32, i32* %.4087
  %.4089 = mul i32 1, %.4088
  %.4090 = add i32 %.4085, %.4089
  store i32 %.4090, i32* %.20
  br label %.4075 
.4075:
  %.4093 = load i32, i32* %.22
  %.4094 = sdiv i32 %.4093, 2
  store i32 %.4094, i32* %.22
  %.4096 = load i32, i32* %.23
  %.4097 = sdiv i32 %.4096, 2
  store i32 %.4097, i32* %.23
  %.4099 = load i32, i32* %.21
  %.4100 = add i32 %.4099, 1
  store i32 %.4100, i32* %.21
  br label %.4067wc1242 
.4079:
  %.4081 = load i32, i32* %.23
  %.4082 = srem i32 %.4081, 2
  %.4083 = icmp ne i32 %.4082, 0
  br i1 %.4083, label %.4074, label %.4075
.4105:
  store i32 0, i32* %.20
  br label %.4109 
.4106:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4113 = load i32, i32* %.3988
  %.4114 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.4115 = load i32, i32* %.4114
  %.4116 = mul i32 %.4113, %.4115
  store i32 %.4116, i32* %.22
  store i32 65535, i32* %.23
  br label %.4119wc1258 
.4109:
  %.4156 = load i32, i32* %.20
  store i32 %.4156, i32* %.3988
  %.4158 = load i32, i32* %.3991
  store i32 %.4158, i32* %.3985
  br label %.3992wc1220 
.4119wc1258:
  %.4123 = load i32, i32* %.21
  %.4124 = icmp slt i32 %.4123, 16
  br i1 %.4124, label %.4120wloop.1258.1265, label %.4121wn1265
.4120wloop.1258.1265:
  %.4128 = load i32, i32* %.22
  %.4129 = srem i32 %.4128, 2
  %.4130 = icmp ne i32 %.4129, 0
  br i1 %.4130, label %.4131, label %.4127
.4121wn1265:
  br label %.4109 
.4126:
  %.4137 = load i32, i32* %.20
  %.4138 = load i32, i32* %.21
  %.4139 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4138
  %.4140 = load i32, i32* %.4139
  %.4141 = mul i32 1, %.4140
  %.4142 = add i32 %.4137, %.4141
  store i32 %.4142, i32* %.20
  br label %.4127 
.4127:
  %.4145 = load i32, i32* %.22
  %.4146 = sdiv i32 %.4145, 2
  store i32 %.4146, i32* %.22
  %.4148 = load i32, i32* %.23
  %.4149 = sdiv i32 %.4148, 2
  store i32 %.4149, i32* %.23
  %.4151 = load i32, i32* %.21
  %.4152 = add i32 %.4151, 1
  store i32 %.4152, i32* %.21
  br label %.4119wc1258 
.4131:
  %.4133 = load i32, i32* %.23
  %.4134 = srem i32 %.4133, 2
  %.4135 = icmp ne i32 %.4134, 0
  br i1 %.4135, label %.4126, label %.4127
.4173wc1276:
  %.4177 = load i32, i32* %.4169
  %.4178 = icmp ne i32 %.4177, 0
  br i1 %.4178, label %.4174wloop.1276.1325, label %.4175wn1325
.4174wloop.1276.1325:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4182 = load i32, i32* %.4166
  store i32 %.4182, i32* %.22
  %.4184 = load i32, i32* %.4169
  store i32 %.4184, i32* %.23
  br label %.4186wc1281 
.4175wn1325:
  %.4342 = load i32, i32* %.4166
  store i32 %.4342, i32* %.20
  %.4344 = load i32, i32* %.20
  store i32 %.4344, i32* %.3924
  %.4346 = load i32, i32* %.3927
  store i32 %.4346, i32* %.22
  store i32 1, i32* %.23
  %.4351 = load i32, i32* %.23
  %.4352 = icmp sge i32 %.4351, 15
  br i1 %.4352, label %.4349, label %.4350
.4186wc1281:
  %.4190 = load i32, i32* %.21
  %.4191 = icmp slt i32 %.4190, 16
  br i1 %.4191, label %.4187wloop.1281.1292, label %.4188wn1292
.4187wloop.1281.1292:
  %.4195 = load i32, i32* %.22
  %.4196 = srem i32 %.4195, 2
  %.4197 = icmp ne i32 %.4196, 0
  br i1 %.4197, label %.4193, label %.4194
.4188wn1292:
  %.4240 = load i32, i32* %.20
  store i32 %.4240, i32* %.4172
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4244 = load i32, i32* %.4166
  store i32 %.4244, i32* %.22
  %.4246 = load i32, i32* %.4169
  store i32 %.4246, i32* %.23
  br label %.4248wc1298 
.4193:
  %.4201 = load i32, i32* %.23
  %.4202 = srem i32 %.4201, 2
  %.4203 = icmp eq i32 %.4202, 0
  br i1 %.4203, label %.4199, label %.4200
.4194:
  %.4217 = load i32, i32* %.23
  %.4218 = srem i32 %.4217, 2
  %.4219 = icmp ne i32 %.4218, 0
  br i1 %.4219, label %.4215, label %.4216
.4199:
  %.4205 = load i32, i32* %.20
  %.4206 = load i32, i32* %.21
  %.4207 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4206
  %.4208 = load i32, i32* %.4207
  %.4209 = mul i32 1, %.4208
  %.4210 = add i32 %.4205, %.4209
  store i32 %.4210, i32* %.20
  br label %.4200 
.4200:
  br label %.4213 
.4213:
  %.4230 = load i32, i32* %.22
  %.4231 = sdiv i32 %.4230, 2
  store i32 %.4231, i32* %.22
  %.4233 = load i32, i32* %.23
  %.4234 = sdiv i32 %.4233, 2
  store i32 %.4234, i32* %.23
  %.4236 = load i32, i32* %.21
  %.4237 = add i32 %.4236, 1
  store i32 %.4237, i32* %.21
  br label %.4186wc1281 
.4215:
  %.4221 = load i32, i32* %.20
  %.4222 = load i32, i32* %.21
  %.4223 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4222
  %.4224 = load i32, i32* %.4223
  %.4225 = mul i32 1, %.4224
  %.4226 = add i32 %.4221, %.4225
  store i32 %.4226, i32* %.20
  br label %.4216 
.4216:
  br label %.4213 
.4248wc1298:
  %.4252 = load i32, i32* %.21
  %.4253 = icmp slt i32 %.4252, 16
  br i1 %.4253, label %.4249wloop.1298.1305, label %.4250wn1305
.4249wloop.1298.1305:
  %.4257 = load i32, i32* %.22
  %.4258 = srem i32 %.4257, 2
  %.4259 = icmp ne i32 %.4258, 0
  br i1 %.4259, label %.4260, label %.4256
.4250wn1305:
  %.4284 = load i32, i32* %.20
  store i32 %.4284, i32* %.4169
  br label %.4287 
.4255:
  %.4266 = load i32, i32* %.20
  %.4267 = load i32, i32* %.21
  %.4268 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4267
  %.4269 = load i32, i32* %.4268
  %.4270 = mul i32 1, %.4269
  %.4271 = add i32 %.4266, %.4270
  store i32 %.4271, i32* %.20
  br label %.4256 
.4256:
  %.4274 = load i32, i32* %.22
  %.4275 = sdiv i32 %.4274, 2
  store i32 %.4275, i32* %.22
  %.4277 = load i32, i32* %.23
  %.4278 = sdiv i32 %.4277, 2
  store i32 %.4278, i32* %.23
  %.4280 = load i32, i32* %.21
  %.4281 = add i32 %.4280, 1
  store i32 %.4281, i32* %.21
  br label %.4248wc1298 
.4260:
  %.4262 = load i32, i32* %.23
  %.4263 = srem i32 %.4262, 2
  %.4264 = icmp ne i32 %.4263, 0
  br i1 %.4264, label %.4255, label %.4256
.4286:
  store i32 0, i32* %.20
  br label %.4290 
.4287:
  store i32 0, i32* %.20
  store i32 0, i32* %.21
  %.4294 = load i32, i32* %.4169
  %.4295 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 1
  %.4296 = load i32, i32* %.4295
  %.4297 = mul i32 %.4294, %.4296
  store i32 %.4297, i32* %.22
  store i32 65535, i32* %.23
  br label %.4300wc1314 
.4290:
  %.4337 = load i32, i32* %.20
  store i32 %.4337, i32* %.4169
  %.4339 = load i32, i32* %.4172
  store i32 %.4339, i32* %.4166
  br label %.4173wc1276 
.4300wc1314:
  %.4304 = load i32, i32* %.21
  %.4305 = icmp slt i32 %.4304, 16
  br i1 %.4305, label %.4301wloop.1314.1321, label %.4302wn1321
.4301wloop.1314.1321:
  %.4309 = load i32, i32* %.22
  %.4310 = srem i32 %.4309, 2
  %.4311 = icmp ne i32 %.4310, 0
  br i1 %.4311, label %.4312, label %.4308
.4302wn1321:
  br label %.4290 
.4307:
  %.4318 = load i32, i32* %.20
  %.4319 = load i32, i32* %.21
  %.4320 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4319
  %.4321 = load i32, i32* %.4320
  %.4322 = mul i32 1, %.4321
  %.4323 = add i32 %.4318, %.4322
  store i32 %.4323, i32* %.20
  br label %.4308 
.4308:
  %.4326 = load i32, i32* %.22
  %.4327 = sdiv i32 %.4326, 2
  store i32 %.4327, i32* %.22
  %.4329 = load i32, i32* %.23
  %.4330 = sdiv i32 %.4329, 2
  store i32 %.4330, i32* %.23
  %.4332 = load i32, i32* %.21
  %.4333 = add i32 %.4332, 1
  store i32 %.4333, i32* %.21
  br label %.4300wc1314 
.4312:
  %.4314 = load i32, i32* %.23
  %.4315 = srem i32 %.4314, 2
  %.4316 = icmp ne i32 %.4315, 0
  br i1 %.4316, label %.4307, label %.4308
.4349:
  %.4356 = load i32, i32* %.22
  %.4357 = icmp slt i32 %.4356, 0
  br i1 %.4357, label %.4354, label %.4355
.4350:
  %.4368 = load i32, i32* %.23
  %.4369 = icmp sgt i32 %.4368, 0
  br i1 %.4369, label %.4366, label %.4367
.4354:
  store i32 65535, i32* %.20
  br label %.4360 
.4355:
  store i32 0, i32* %.20
  br label %.4360 
.4360:
  br label %.4364 
.4364:
  %.4406 = load i32, i32* %.20
  store i32 %.4406, i32* %.3927
  br label %.3932wc1204 
.4366:
  %.4373 = load i32, i32* %.22
  %.4374 = icmp sgt i32 %.4373, 32767
  br i1 %.4374, label %.4371, label %.4372
.4367:
  %.4402 = load i32, i32* %.22
  store i32 %.4402, i32* %.20
  br label %.4400 
.4371:
  %.4376 = load i32, i32* %.22
  %.4377 = load i32, i32* %.23
  %.4378 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4377
  %.4379 = load i32, i32* %.4378
  %.4380 = sdiv i32 %.4376, %.4379
  store i32 %.4380, i32* %.22
  %.4382 = load i32, i32* %.22
  %.4383 = add i32 %.4382, 65536
  %.4384 = load i32, i32* %.23
  %.4385 = sub i32 15, %.4384
  %.4386 = add i32 %.4385, 1
  %.4387 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4386
  %.4388 = load i32, i32* %.4387
  %.4389 = sub i32 %.4383, %.4388
  store i32 %.4389, i32* %.20
  br label %.4391 
.4372:
  %.4393 = load i32, i32* %.22
  %.4394 = load i32, i32* %.23
  %.4395 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4394
  %.4396 = load i32, i32* %.4395
  %.4397 = sdiv i32 %.4393, %.4396
  store i32 %.4397, i32* %.20
  br label %.4391 
.4391:
  br label %.4400 
.4400:
  br label %.4364 
.4416:
  %.4423 = load i32, i32* %.22
  %.4424 = icmp slt i32 %.4423, 0
  br i1 %.4424, label %.4421, label %.4422
.4417:
  %.4435 = load i32, i32* %.23
  %.4436 = icmp sgt i32 %.4435, 0
  br i1 %.4436, label %.4433, label %.4434
.4421:
  store i32 65535, i32* %.20
  br label %.4427 
.4422:
  store i32 0, i32* %.20
  br label %.4427 
.4427:
  br label %.4431 
.4431:
  %.4473 = load i32, i32* %.20
  store i32 %.4473, i32* %.3376
  br label %.3381wc1037 
.4433:
  %.4440 = load i32, i32* %.22
  %.4441 = icmp sgt i32 %.4440, 32767
  br i1 %.4441, label %.4438, label %.4439
.4434:
  %.4469 = load i32, i32* %.22
  store i32 %.4469, i32* %.20
  br label %.4467 
.4438:
  %.4443 = load i32, i32* %.22
  %.4444 = load i32, i32* %.23
  %.4445 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4444
  %.4446 = load i32, i32* %.4445
  %.4447 = sdiv i32 %.4443, %.4446
  store i32 %.4447, i32* %.22
  %.4449 = load i32, i32* %.22
  %.4450 = add i32 %.4449, 65536
  %.4451 = load i32, i32* %.23
  %.4452 = sub i32 15, %.4451
  %.4453 = add i32 %.4452, 1
  %.4454 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4453
  %.4455 = load i32, i32* %.4454
  %.4456 = sub i32 %.4450, %.4455
  store i32 %.4456, i32* %.20
  br label %.4458 
.4439:
  %.4460 = load i32, i32* %.22
  %.4461 = load i32, i32* %.23
  %.4462 = getelementptr inbounds [16 x i32], [16 x i32]* @.g.SHIFT_TABLE, i32 0, i32 %.4461
  %.4463 = load i32, i32* %.4462
  %.4464 = sdiv i32 %.4460, %.4463
  store i32 %.4464, i32* %.20
  br label %.4458 
.4458:
  br label %.4467 
.4467:
  br label %.4431 
.4478:
  ret i32 1 
.4479:
  %.4487 = load i32, i32* %.24
  %.4488 = add i32 %