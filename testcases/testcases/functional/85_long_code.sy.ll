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
@.g.n = global i32 zeroinitializer
define i32 @bubblesort(i32* %.4){
.2:
  %.45 = alloca i32
  %.7 = alloca i32
  %.6 = alloca i32
  %.3 = alloca i32*
  store i32* %.4, i32** %.3
  store i32 0, i32* %.6
  br label %.10wc8 
.10wc8:
  %.14 = load i32, i32* %.6
  %.15 = load i32, i32* @.g.n
  %.17 = sub i32 %.15, 1
  %.18 = icmp slt i32 %.14, %.17
  br i1 %.18, label %.11wloop.8.22, label %.12wn22
.11wloop.8.22:
  store i32 0, i32* %.7
  br label %.21wc11 
.12wn22:
  ret i32 0 
.21wc11:
  %.25 = load i32, i32* %.7
  %.26 = load i32, i32* @.g.n
  %.27 = load i32, i32* %.6
  %.28 = sub i32 %.26, %.27
  %.29 = sub i32 %.28, 1
  %.30 = icmp slt i32 %.25, %.29
  br i1 %.30, label %.22wloop.11.20, label %.23wn20
.22wloop.11.20:
  %.34 = load i32, i32* %.7
  %.35 = load i32*, i32** %.3
  %.36 = getelementptr inbounds i32, i32* %.35, i32 %.34
  %.37 = load i32, i32* %.36
  %.38 = load i32, i32* %.7
  %.39 = add i32 %.38, 1
  %.40 = load i32*, i32** %.3
  %.41 = getelementptr inbounds i32, i32* %.40, i32 %.39
  %.42 = load i32, i32* %.41
  %.43 = icmp sgt i32 %.37, %.42
  br i1 %.43, label %.32, label %.33
.23wn20:
  %.71 = load i32, i32* %.6
  %.72 = add i32 %.71, 1
  store i32 %.72, i32* %.6
  br label %.10wc8 
.32:
  %.46 = load i32, i32* %.7
  %.47 = add i32 %.46, 1
  %.48 = load i32*, i32** %.3
  %.49 = getelementptr inbounds i32, i32* %.48, i32 %.47
  %.50 = load i32, i32* %.49
  store i32 %.50, i32* %.45
  %.52 = load i32, i32* %.7
  %.53 = load i32*, i32** %.3
  %.54 = getelementptr inbounds i32, i32* %.53, i32 %.52
  %.55 = load i32, i32* %.54
  %.56 = load i32, i32* %.7
  %.57 = add i32 %.56, 1
  %.58 = load i32*, i32** %.3
  %.59 = getelementptr inbounds i32, i32* %.58, i32 %.57
  store i32 %.55, i32* %.59
  %.61 = load i32, i32* %.45
  %.62 = load i32, i32* %.7
  %.63 = load i32*, i32** %.3
  %.64 = getelementptr inbounds i32, i32* %.63, i32 %.62
  store i32 %.61, i32* %.64
  br label %.33 
.33:
  %.67 = load i32, i32* %.7
  %.68 = add i32 %.67, 1
  store i32 %.68, i32* %.7
  br label %.21wc11 
}
define i32 @insertsort(i32* %.79){
.77:
  %.97 = alloca i32
  %.91 = alloca i32
  %.81 = alloca i32
  %.78 = alloca i32*
  store i32* %.79, i32** %.78
  store i32 1, i32* %.81
  br label %.83wc29 
.83wc29:
  %.87 = load i32, i32* %.81
  %.88 = load i32, i32* @.g.n
  %.89 = icmp slt i32 %.87, %.88
  br i1 %.89, label %.84wloop.29.42, label %.85wn42
.84wloop.29.42:
  %.92 = load i32, i32* %.81
  %.93 = load i32*, i32** %.78
  %.94 = getelementptr inbounds i32, i32* %.93, i32 %.92
  %.95 = load i32, i32* %.94
  store i32 %.95, i32* %.91
  %.98 = load i32, i32* %.81
  %.99 = sub i32 %.98, 1
  store i32 %.99, i32* %.97
  br label %.101wc35 
.85wn42:
  ret i32 0 
.101wc35:
  %.105 = load i32, i32* %.97
  %.107 = icmp sgt i32 %.105, -1
  br i1 %.107, label %.108, label %.103wn39
.102wloop.35.39:
  %.117 = load i32, i32* %.97
  %.118 = load i32*, i32** %.78
  %.119 = getelementptr inbounds i32, i32* %.118, i32 %.117
  %.120 = load i32, i32* %.119
  %.121 = load i32, i32* %.97
  %.122 = add i32 %.121, 1
  %.123 = load i32*, i32** %.78
  %.124 = getelementptr inbounds i32, i32* %.123, i32 %.122
  store i32 %.120, i32* %.124
  %.126 = load i32, i32* %.97
  %.127 = sub i32 %.126, 1
  store i32 %.127, i32* %.97
  br label %.101wc35 
.103wn39:
  %.130 = load i32, i32* %.91
  %.131 = load i32, i32* %.97
  %.132 = add i32 %.131, 1
  %.133 = load i32*, i32** %.78
  %.134 = getelementptr inbounds i32, i32* %.133, i32 %.132
  store i32 %.130, i32* %.134
  %.136 = load i32, i32* %.81
  %.137 = add i32 %.136, 1
  store i32 %.137, i32* %.81
  br label %.83wc29 
.108:
  %.110 = load i32, i32* %.91
  %.111 = load i32, i32* %.97
  %.112 = load i32*, i32** %.78
  %.113 = getelementptr inbounds i32, i32* %.112, i32 %.111
  %.114 = load i32, i32* %.113
  %.115 = icmp slt i32 %.110, %.114
  br i1 %.115, label %.102wloop.35.39, label %.103wn39
}
define i32 @QuickSort(i32* %.144, i32 %.147, i32 %.150){
.142:
  %.261 = alloca i32
  %.164 = alloca i32
  %.161 = alloca i32
  %.158 = alloca i32
  %.149 = alloca i32
  %.146 = alloca i32
  %.143 = alloca i32*
  store i32* %.144, i32** %.143
  store i32 %.147, i32* %.146
  store i32 %.150, i32* %.149
  %.154 = load i32, i32* %.146
  %.155 = load i32, i32* %.149
  %.156 = icmp slt i32 %.154, %.155
  br i1 %.156, label %.152, label %.153
.152:
  %.159 = load i32, i32* %.146
  store i32 %.159, i32* %.158
  %.162 = load i32, i32* %.149
  store i32 %.162, i32* %.161
  %.165 = load i32, i32* %.146
  %.166 = load i32*, i32** %.143
  %.167 = getelementptr inbounds i32, i32* %.166, i32 %.165
  %.168 = load i32, i32* %.167
  store i32 %.168, i32* %.164
  br label %.170wc56 
.153:
  ret i32 0 
.170wc56:
  %.174 = load i32, i32* %.158
  %.175 = load i32, i32* %.161
  %.176 = icmp slt i32 %.174, %.175
  br i1 %.176, label %.171wloop.56.79, label %.172wn79
.171wloop.56.79:
  br label %.178wc58 
.172wn79:
  %.256 = load i32, i32* %.164
  %.257 = load i32, i32* %.158
  %.258 = load i32*, i32** %.143
  %.259 = getelementptr inbounds i32, i32* %.258, i32 %.257
  store i32 %.256, i32* %.259
  %.262 = load i32, i32* %.158
  %.263 = sub i32 %.262, 1
  store i32 %.263, i32* %.261
  %.265 = load i32*, i32** %.143
  %.266 = load i32, i32* %.146
  %.267 = load i32, i32* %.261
  %.268at84 = call i32 @QuickSort(i32* %.265, i32 %.266, i32 %.267)
  store i32 %.268at84, i32* %.261
  %.270 = load i32, i32* %.158
  %.271 = add i32 %.270, 1
  store i32 %.271, i32* %.261
  %.273 = load i32*, i32** %.143
  %.274 = load i32, i32* %.261
  %.275 = load i32, i32* %.149
  %.276at86 = call i32 @QuickSort(i32* %.273, i32 %.274, i32 %.275)
  store i32 %.276at86, i32* %.261
  br label %.153 
.178wc58:
  %.182 = load i32, i32* %.158
  %.183 = load i32, i32* %.161
  %.184 = icmp slt i32 %.182, %.183
  br i1 %.184, label %.185, label %.180wn61
.179wloop.58.61:
  %.195 = load i32, i32* %.161
  %.196 = sub i32 %.195, 1
  store i32 %.196, i32* %.161
  br label %.178wc58 
.180wn61:
  %.201 = load i32, i32* %.158
  %.202 = load i32, i32* %.161
  %.203 = icmp slt i32 %.201, %.202
  br i1 %.203, label %.199, label %.200
.185:
  %.187 = load i32, i32* %.161
  %.188 = load i32*, i32** %.143
  %.189 = getelementptr inbounds i32, i32* %.188, i32 %.187
  %.190 = load i32, i32* %.189
  %.191 = load i32, i32* %.164
  %.192 = sub i32 %.191, 1
  %.193 = icmp sgt i32 %.190, %.192
  br i1 %.193, label %.179wloop.58.61, label %.180wn61
.199:
  %.205 = load i32, i32* %.161
  %.206 = load i32*, i32** %.143
  %.207 = getelementptr inbounds i32, i32* %.206, i32 %.205
  %.208 = load i32, i32* %.207
  %.209 = load i32, i32* %.158
  %.210 = load i32*, i32** %.143
  %.211 = getelementptr inbounds i32, i32* %.210, i32 %.209
  store i32 %.208, i32* %.211
  %.213 = load i32, i32* %.158
  %.214 = add i32 %.213, 1
  store i32 %.214, i32* %.158
  br label %.200 
.200:
  br label %.217wc69 
.217wc69:
  %.221 = load i32, i32* %.158
  %.222 = load i32, i32* %.161
  %.223 = icmp slt i32 %.221, %.222
  br i1 %.223, label %.224, label %.219wn72
.218wloop.69.72:
  %.233 = load i32, i32* %.158
  %.234 = add i32 %.233, 1
  store i32 %.234, i32* %.158
  br label %.217wc69 
.219wn72:
  %.239 = load i32, i32* %.158
  %.240 = load i32, i32* %.161
  %.241 = icmp slt i32 %.239, %.240
  br i1 %.241, label %.237, label %.238
.224:
  %.226 = load i32, i32* %.158
  %.227 = load i32*, i32** %.143
  %.228 = getelementptr inbounds i32, i32* %.227, i32 %.226
  %.229 = load i32, i32* %.228
  %.230 = load i32, i32* %.164
  %.231 = icmp slt i32 %.229, %.230
  br i1 %.231, label %.218wloop.69.72, label %.219wn72
.237:
  %.243 = load i32, i32* %.158
  %.244 = load i32*, i32** %.143
  %.245 = getelementptr inbounds i32, i32* %.244, i32 %.243
  %.246 = load i32, i32* %.245
  %.247 = load i32, i32* %.161
  %.248 = load i32*, i32** %.143
  %.249 = getelementptr inbounds i32, i32* %.248, i32 %.247
  store i32 %.246, i32* %.249
  %.251 = load i32, i32* %.161
  %.252 = sub i32 %.251, 1
  store i32 %.252, i32* %.161
  br label %.238 
.238:
  br label %.170wc56 
}
define i32 @getMid(i32* %.283){
.281:
  %.285 = alloca i32
  %.282 = alloca i32*
  store i32* %.283, i32** %.282
  %.288 = load i32, i32* @.g.n
  %.290 = srem i32 %.288, 2
  %.291 = icmp eq i32 %.290, 0
  br i1 %.291, label %.286, label %.287
.286:
  %.293 = load i32, i32* @.g.n
  %.294 = sdiv i32 %.293, 2
  store i32 %.294, i32* %.285
  %.296 = load i32, i32* %.285
  %.297 = load i32*, i32** %.282
  %.298 = getelementptr inbounds i32, i32* %.297, i32 %.296
  %.299 = load i32, i32* %.298
  %.300 = load i32, i32* %.285
  %.301 = sub i32 %.300, 1
  %.302 = load i32*, i32** %.282
  %.303 = getelementptr inbounds i32, i32* %.302, i32 %.301
  %.304 = load i32, i32* %.303
  %.305 = add i32 %.299, %.304
  %.306 = sdiv i32 %.305, 2
  ret i32 %.306 
.287:
  %.308 = load i32, i32* @.g.n
  %.309 = sdiv i32 %.308, 2
  store i32 %.309, i32* %.285
  %.311 = load i32, i32* %.285
  %.312 = load i32*, i32** %.282
  %.313 = getelementptr inbounds i32, i32* %.312, i32 %.311
  %.314 = load i32, i32* %.313
  ret i32 %.314 
}
define i32 @getMost(i32* %.319){
.317:
  %.351 = alloca i32
  %.341 = alloca i32
  %.340 = alloca i32
  %.323 = alloca i32
  %.322 = alloca [1000 x i32]
  %.318 = alloca i32*
  store i32* %.319, i32** %.318
  store i32 0, i32* %.323
  br label %.325wc107 
.325wc107:
  %.329 = load i32, i32* %.323
  %.330 = icmp slt i32 %.329, 1000
  br i1 %.330, label %.326wloop.107.110, label %.327wn110
.326wloop.107.110:
  %.332 = load i32, i32* %.323
  %.333 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.332
  store i32 0, i32* %.333
  %.335 = load i32, i32* %.323
  %.336 = add i32 %.335, 1
  store i32 %.336, i32* %.323
  br label %.325wc107 
.327wn110:
  store i32 0, i32* %.323
  store i32 0, i32* %.340
  br label %.343wc115 
.343wc115:
  %.347 = load i32, i32* %.323
  %.348 = load i32, i32* @.g.n
  %.349 = icmp slt i32 %.347, %.348
  br i1 %.349, label %.344wloop.115.124, label %.345wn124
.344wloop.115.124:
  %.352 = load i32, i32* %.323
  %.353 = load i32*, i32** %.318
  %.354 = getelementptr inbounds i32, i32* %.353, i32 %.352
  %.355 = load i32, i32* %.354
  store i32 %.355, i32* %.351
  %.357 = load i32, i32* %.351
  %.358 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.357
  %.359 = load i32, i32* %.358
  %.360 = add i32 %.359, 1
  %.361 = load i32, i32* %.351
  %.362 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.361
  store i32 %.360, i32* %.362
  %.366 = load i32, i32* %.351
  %.367 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.366
  %.368 = load i32, i32* %.367
  %.369 = load i32, i32* %.340
  %.370 = icmp sgt i32 %.368, %.369
  br i1 %.370, label %.364, label %.365
.345wn124:
  %.383 = load i32, i32* %.341
  ret i32 %.383 
.364:
  %.372 = load i32, i32* %.351
  %.373 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.372
  %.374 = load i32, i32* %.373
  store i32 %.374, i32* %.340
  %.376 = load i32, i32* %.351
  store i32 %.376, i32* %.341
  br label %.365 
.365:
  %.379 = load i32, i32* %.323
  %.380 = add i32 %.379, 1
  store i32 %.380, i32* %.323
  br label %.343wc115 
}
define i32 @revert(i32* %.388){
.386:
  %.392 = alloca i32
  %.391 = alloca i32
  %.390 = alloca i32
  %.387 = alloca i32*
  store i32* %.388, i32** %.387
  store i32 0, i32* %.391
  store i32 0, i32* %.392
  br label %.395wc134 
.395wc134:
  %.399 = load i32, i32* %.391
  %.400 = load i32, i32* %.392
  %.401 = icmp slt i32 %.399, %.400
  br i1 %.401, label %.396wloop.134.140, label %.397wn140
.396wloop.134.140:
  %.403 = load i32, i32* %.391
  %.404 = load i32*, i32** %.387
  %.405 = getelementptr inbounds i32, i32* %.404, i32 %.403
  %.406 = load i32, i32* %.405
  store i32 %.406, i32* %.390
  %.408 = load i32, i32* %.392
  %.409 = load i32*, i32** %.387
  %.410 = getelementptr inbounds i32, i32* %.409, i32 %.408
  %.411 = load i32, i32* %.410
  %.412 = load i32, i32* %.391
  %.413 = load i32*, i32** %.387
  %.414 = getelementptr inbounds i32, i32* %.413, i32 %.412
  store i32 %.411, i32* %.414
  %.416 = load i32, i32* %.390
  %.417 = load i32, i32* %.392
  %.418 = load i32*, i32** %.387
  %.419 = getelementptr inbounds i32, i32* %.418, i32 %.417
  store i32 %.416, i32* %.419
  %.421 = load i32, i32* %.391
  %.422 = add i32 %.421, 1
  store i32 %.422, i32* %.391
  %.424 = load i32, i32* %.392
  %.425 = sub i32 %.424, 1
  store i32 %.425, i32* %.392
  br label %.395wc134 
.397wn140:
  ret i32 0 
}
define i32 @arrCopy(i32* %.432, i32* %.435){
.430:
  %.437 = alloca i32
  %.434 = alloca i32*
  %.431 = alloca i32*
  store i32* %.432, i32** %.431
  store i32* %.435, i32** %.434
  store i32 0, i32* %.437
  br label %.439wc147 
.439wc147:
  %.443 = load i32, i32* %.437
  %.444 = load i32, i32* @.g.n
  %.445 = icmp slt i32 %.443, %.444
  br i1 %.445, label %.440wloop.147.150, label %.441wn150
.440wloop.147.150:
  %.447 = load i32, i32* %.437
  %.448 = load i32*, i32** %.431
  %.449 = getelementptr inbounds i32, i32* %.448, i32 %.447
  %.450 = load i32, i32* %.449
  %.451 = load i32, i32* %.437
  %.452 = load i32*, i32** %.434
  %.453 = getelementptr inbounds i32, i32* %.452, i32 %.451
  store i32 %.450, i32* %.453
  %.455 = load i32, i32* %.437
  %.456 = add i32 %.455, 1
  store i32 %.456, i32* %.437
  br label %.439wc147 
.441wn150:
  ret i32 0 
}
define i32 @calSum(i32* %.463, i32 %.466){
.461:
  %.470 = alloca i32
  %.468 = alloca i32
  %.465 = alloca i32
  %.462 = alloca i32*
  store i32* %.463, i32** %.462
  store i32 %.466, i32* %.465
  store i32 0, i32* %.468
  store i32 0, i32* %.470
  br label %.472wc159 
.472wc159:
  %.476 = load i32, i32* %.470
  %.477 = load i32, i32* @.g.n
  %.478 = icmp slt i32 %.476, %.477
  br i1 %.478, label %.473wloop.159.168, label %.474wn168
.473wloop.159.168:
  %.480 = load i32, i32* %.468
  %.481 = load i32, i32* %.470
  %.482 = load i32*, i32** %.462
  %.483 = getelementptr inbounds i32, i32* %.482, i32 %.481
  %.484 = load i32, i32* %.483
  %.485 = add i32 %.480, %.484
  store i32 %.485, i32* %.468
  %.489 = load i32, i32* %.470
  %.490 = load i32, i32* %.465
  %.491 = srem i32 %.489, %.490
  %.492 = load i32, i32* %.465
  %.493 = sub i32 %.492, 1
  %.494 = icmp ne i32 %.491, %.493
  br i1 %.494, label %.487, label %.488
.474wn168:
  ret i32 0 
.487:
  %.496 = load i32, i32* %.470
  %.497 = load i32*, i32** %.462
  %.498 = getelementptr inbounds i32, i32* %.497, i32 %.496
  store i32 0, i32* %.498
  br label %.500 
.488:
  %.502 = load i32, i32* %.468
  %.503 = load i32, i32* %.470
  %.504 = load i32*, i32** %.462
  %.505 = getelementptr inbounds i32, i32* %.504, i32 %.503
  store i32 %.502, i32* %.505
  store i32 0, i32* %.468
  br label %.500 
.500:
  %.509 = load i32, i32* %.470
  %.510 = add i32 %.509, 1
  store i32 %.510, i32* %.470
  br label %.472wc159 
}
define i32 @avgPooling(i32* %.517, i32 %.520){
.515:
  %.526 = alloca i32
  %.523 = alloca i32
  %.522 = alloca i32
  %.519 = alloca i32
  %.516 = alloca i32*
  store i32* %.517, i32** %.516
  store i32 %.520, i32* %.519
  store i32 0, i32* %.523
  store i32 0, i32* %.522
  br label %.527wc178 
.527wc178:
  %.531 = load i32, i32* %.523
  %.532 = load i32, i32* @.g.n
  %.533 = icmp slt i32 %.531, %.532
  br i1 %.533, label %.528wloop.178.190, label %.529wn190
.528wloop.178.190:
  %.537 = load i32, i32* %.523
  %.538 = load i32, i32* %.519
  %.539 = sub i32 %.538, 1
  %.540 = icmp slt i32 %.537, %.539
  br i1 %.540, label %.535, label %.536
.529wn190:
  %.603 = load i32, i32* @.g.n
  %.604 = load i32, i32* %.519
  %.605 = sub i32 %.603, %.604
  %.606 = add i32 %.605, 1
  store i32 %.606, i32* %.523
  br label %.608wc192 
.535:
  %.542 = load i32, i32* %.522
  %.543 = load i32, i32* %.523
  %.544 = load i32*, i32** %.516
  %.545 = getelementptr inbounds i32, i32* %.544, i32 %.543
  %.546 = load i32, i32* %.545
  %.547 = add i32 %.542, %.546
  store i32 %.547, i32* %.522
  br label %.549 
.536:
  %.553 = load i32, i32* %.523
  %.554 = load i32, i32* %.519
  %.555 = sub i32 %.554, 1
  %.556 = icmp eq i32 %.553, %.555
  br i1 %.556, label %.551, label %.552
.549:
  %.599 = load i32, i32* %.523
  %.600 = add i32 %.599, 1
  store i32 %.600, i32* %.523
  br label %.527wc178 
.551:
  %.558 = load i32*, i32** %.516
  %.559 = getelementptr inbounds i32, i32* %.558, i32 0
  %.560 = load i32, i32* %.559
  store i32 %.560, i32* %.526
  %.562 = load i32, i32* %.522
  %.563 = load i32, i32* %.519
  %.564 = sdiv i32 %.562, %.563
  %.565 = load i32*, i32** %.516
  %.566 = getelementptr inbounds i32, i32* %.565, i32 0
  store i32 %.564, i32* %.566
  br label %.568 
.552:
  %.570 = load i32, i32* %.522
  %.571 = load i32, i32* %.523
  %.572 = load i32*, i32** %.516
  %.573 = getelementptr inbounds i32, i32* %.572, i32 %.571
  %.574 = load i32, i32* %.573
  %.575 = add i32 %.570, %.574
  %.576 = load i32, i32* %.526
  %.577 = sub i32 %.575, %.576
  store i32 %.577, i32* %.522
  %.579 = load i32, i32* %.523
  %.580 = load i32, i32* %.519
  %.581 = sub i32 %.579, %.580
  %.582 = add i32 %.581, 1
  %.583 = load i32*, i32** %.516
  %.584 = getelementptr inbounds i32, i32* %.583, i32 %.582
  %.585 = load i32, i32* %.584
  store i32 %.585, i32* %.526
  %.587 = load i32, i32* %.522
  %.588 = load i32, i32* %.519
  %.589 = sdiv i32 %.587, %.588
  %.590 = load i32, i32* %.523
  %.591 = load i32, i32* %.519
  %.592 = sub i32 %.590, %.591
  %.593 = add i32 %.592, 1
  %.594 = load i32*, i32** %.516
  %.595 = getelementptr inbounds i32, i32* %.594, i32 %.593
  store i32 %.589, i32* %.595
  br label %.568 
.568:
  br label %.549 
.608wc192:
  %.612 = load i32, i32* %.523
  %.613 = load i32, i32* @.g.n
  %.614 = icmp slt i32 %.612, %.613
  br i1 %.614, label %.609wloop.192.195, label %.610wn195
.609wloop.192.195:
  %.616 = load i32, i32* %.523
  %.617 = load i32*, i32** %.516
  %.618 = getelementptr inbounds i32, i32* %.617, i32 %.616
  store i32 0, i32* %.618
  %.620 = load i32, i32* %.523
  %.621 = add i32 %.620, 1
  store i32 %.621, i32* %.523
  br label %.608wc192 
.610wn195:
  ret i32 0 
}
define i32 @main(){
.626:
  %.756 = alloca i32
  %.748 = alloca i32
  %.630 = alloca [32 x i32]
  %.629 = alloca [32 x i32]
  store i32 32, i32* @.g.n
  %.632 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  store i32 7, i32* %.632
  %.635 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 1
  store i32 23, i32* %.635
  %.638 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 2
  store i32 89, i32* %.638
  %.642 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 3
  store i32 26, i32* %.642
  %.646 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 4
  store i32 282, i32* %.646
  %.650 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 5
  store i32 254, i32* %.650
  %.654 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 6
  store i32 27, i32* %.654
  %.656 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 7
  store i32 5, i32* %.656
  %.660 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 8
  store i32 83, i32* %.660
  %.664 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 9
  store i32 273, i32* %.664
  %.668 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 10
  store i32 574, i32* %.668
  %.672 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 11
  store i32 905, i32* %.672
  %.676 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 12
  store i32 354, i32* %.676
  %.680 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 13
  store i32 657, i32* %.680
  %.684 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 14
  store i32 935, i32* %.684
  %.688 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 15
  store i32 264, i32* %.688
  %.692 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 16
  store i32 639, i32* %.692
  %.696 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 17
  store i32 459, i32* %.696
  %.700 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 18
  store i32 29, i32* %.700
  %.704 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 19
  store i32 68, i32* %.704
  %.708 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 20
  store i32 929, i32* %.708
  %.712 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 21
  store i32 756, i32* %.712
  %.716 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 22
  store i32 452, i32* %.716
  %.719 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 23
  store i32 279, i32* %.719
  %.723 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 24
  store i32 58, i32* %.723
  %.727 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 25
  store i32 87, i32* %.727
  %.730 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 26
  store i32 96, i32* %.730
  %.733 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 27
  store i32 36, i32* %.733
  %.737 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 28
  store i32 39, i32* %.737
  %.739 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 29
  store i32 28, i32* %.739
  %.742 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 30
  store i32 1, i32* %.742
  %.746 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 31
  store i32 290, i32* %.746
  %.749 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.750 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.751at236 = call i32 @arrCopy(i32* %.749, i32* %.750)
  store i32 %.751at236, i32* %.748
  %.753 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.754at237 = call i32 @revert(i32* %.753)
  store i32 %.754at237, i32* %.748
  store i32 0, i32* %.756
  br label %.758wc240 
.758wc240:
  %.762 = load i32, i32* %.756
  %.763 = icmp slt i32 %.762, 32
  br i1 %.763, label %.759wloop.240.244, label %.760wn244
.759wloop.240.244:
  %.765 = load i32, i32* %.756
  %.766 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.765
  %.767 = load i32, i32* %.766
  store i32 %.767, i32* %.748
  %.769 = load i32, i32* %.748
  call void @putint(i32 %.769)
  %.772 = load i32, i32* %.756
  %.773 = add i32 %.772, 1
  store i32 %.773, i32* %.756
  br label %.758wc240 
.760wn244:
  %.776 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.777at245 = call i32 @bubblesort(i32* %.776)
  store i32 %.777at245, i32* %.748
  store i32 0, i32* %.756
  br label %.780wc247 
.780wc247:
  %.784 = load i32, i32* %.756
  %.785 = icmp slt i32 %.784, 32
  br i1 %.785, label %.781wloop.247.251, label %.782wn251
.781wloop.247.251:
  %.787 = load i32, i32* %.756
  %.788 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.787
  %.789 = load i32, i32* %.788
  store i32 %.789, i32* %.748
  %.791 = load i32, i32* %.748
  call void @putint(i32 %.791)
  %.793 = load i32, i32* %.756
  %.794 = add i32 %.793, 1
  store i32 %.794, i32* %.756
  br label %.780wc247 
.782wn251:
  %.797 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.798at252 = call i32 @getMid(i32* %.797)
  store i32 %.798at252, i32* %.748
  %.800 = load i32, i32* %.748
  call void @putint(i32 %.800)
  %.802 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.803at254 = call i32 @getMost(i32* %.802)
  store i32 %.803at254, i32* %.748
  %.805 = load i32, i32* %.748
  call void @putint(i32 %.805)
  %.807 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.808 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.809at257 = call i32 @arrCopy(i32* %.807, i32* %.808)
  store i32 %.809at257, i32* %.748
  %.811 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.812at258 = call i32 @bubblesort(i32* %.811)
  store i32 %.812at258, i32* %.748
  store i32 0, i32* %.756
  br label %.815wc260 
.815wc260:
  %.819 = load i32, i32* %.756
  %.820 = icmp slt i32 %.819, 32
  br i1 %.820, label %.816wloop.260.264, label %.817wn264
.816wloop.260.264:
  %.822 = load i32, i32* %.756
  %.823 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.822
  %.824 = load i32, i32* %.823
  store i32 %.824, i32* %.748
  %.826 = load i32, i32* %.748
  call void @putint(i32 %.826)
  %.828 = load i32, i32* %.756
  %.829 = add i32 %.828, 1
  store i32 %.829, i32* %.756
  br label %.815wc260 
.817wn264:
  %.832 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.833 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.834at266 = call i32 @arrCopy(i32* %.832, i32* %.833)
  store i32 %.834at266, i32* %.748
  %.836 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.837at267 = call i32 @insertsort(i32* %.836)
  store i32 %.837at267, i32* %.748
  store i32 0, i32* %.756
  br label %.840wc269 
.840wc269:
  %.844 = load i32, i32* %.756
  %.845 = icmp slt i32 %.844, 32
  br i1 %.845, label %.841wloop.269.273, label %.842wn273
.841wloop.269.273:
  %.847 = load i32, i32* %.756
  %.848 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.847
  %.849 = load i32, i32* %.848
  store i32 %.849, i32* %.748
  %.851 = load i32, i32* %.748
  call void @putint(i32 %.851)
  %.853 = load i32, i32* %.756
  %.854 = add i32 %.853, 1
  store i32 %.854, i32* %.756
  br label %.840wc269 
.842wn273:
  %.857 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.858 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.859at275 = call i32 @arrCopy(i32* %.857, i32* %.858)
  store i32 %.859at275, i32* %.748
  store i32 0, i32* %.756
  store i32 31, i32* %.748
  %.863 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.864 = load i32, i32* %.756
  %.865 = load i32, i32* %.748
  %.866at278 = call i32 @QuickSort(i32* %.863, i32 %.864, i32 %.865)
  store i32 %.866at278, i32* %.748
  br label %.868wc279 
.868wc279:
  %.872 = load i32, i32* %.756
  %.873 = icmp slt i32 %.872, 32
  br i1 %.873, label %.869wloop.279.283, label %.870wn283
.869wloop.279.283:
  %.875 = load i32, i32* %.756
  %.876 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.875
  %.877 = load i32, i32* %.876
  store i32 %.877, i32* %.748
  %.879 = load i32, i32* %.748
  call void @putint(i32 %.879)
  %.881 = load i32, i32* %.756
  %.882 = add i32 %.881, 1
  store i32 %.882, i32* %.756
  br label %.868wc279 
.870wn283:
  %.885 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.886 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.887at285 = call i32 @arrCopy(i32* %.885, i32* %.886)
  store i32 %.887at285, i32* %.748
  %.889 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.890at286 = call i32 @calSum(i32* %.889, i32 4)
  store i32 %.890at286, i32* %.748
  store i32 0, i32* %.756
  br label %.893wc288 
.893wc288:
  %.897 = load i32, i32* %.756
  %.898 = icmp slt i32 %.897, 32
  br i1 %.898, label %.894wloop.288.292, label %.895wn292
.894wloop.288.292:
  %.900 = load i32, i32* %.756
  %.901 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.900
  %.902 = load i32, i32* %.901
  store i32 %.902, i32* %.748
  %.904 = load i32, i32* %.748
  call void @putint(i32 %.904)
  %.906 = load i32, i32* %.756
  %.907 = add i32 %.906, 1
  store i32 %.907, i32* %.756
  br label %.893wc288 
.895wn292:
  %.910 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.911 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.912at294 = call i32 @arrCopy(i32* %.910, i32* %.911)
  store i32 %.912at294, i32* %.748
  %.914 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.915at295 = call i32 @avgPooling(i32* %.914, i32 3)
  store i32 %.915at295, i32* %.748
  store i32 0, i32* %.756
  br label %.918wc297 
.918wc297:
  %.922 = load i32, i32* %.756
  %.923 = icmp slt i32 %.922, 32
  br i1 %.923, label %.919wloop.297.301, label %.920wn301
.919wloop.297.301:
  %.925 = load i32, i32* %.756
  %.926 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.925
  %.927 = load i32, i32* %.926
  store i32 %.927, i32* %.748
  %.929 = load i32, i32* %.748
  call void @putint(i32 %.929)
  %.931 = load i32, i32* %.756
  %.932 = add i32 %.931, 1
  store i32 %.932, i32* %.756
  br label %.918wc297 
.920wn301:
  ret i32 0 
}
@.g.n = global i32 zeroinitializer
define i32 @bubblesort(i32* %.4){
.2:
  %.45 = alloca i32
  %.7 = alloca i32
  %.6 = alloca i32
  %.3 = alloca i32*
  store i32* %.4, i32** %.3
  store i32 0, i32* %.6
  br label %.10wc8 
.10wc8:
  %.14 = load i32, i32* %.6
  %.15 = load i32, i32* @.g.n
  %.17 = sub i32 %.15, 1
  %.18 = icmp slt i32 %.14, %.17
  br i1 %.18, label %.11wloop.8.22, label %.12wn22
.11wloop.8.22:
  store i32 0, i32* %.7
  br label %.21wc11 
.12wn22:
  ret i32 0 
.21wc11:
  %.25 = load i32, i32* %.7
  %.26 = load i32, i32* @.g.n
  %.27 = load i32, i32* %.6
  %.28 = sub i32 %.26, %.27
  %.29 = sub i32 %.28, 1
  %.30 = icmp slt i32 %.25, %.29
  br i1 %.30, label %.22wloop.11.20, label %.23wn20
.22wloop.11.20:
  %.34 = load i32, i32* %.7
  %.35 = load i32*, i32** %.3
  %.36 = getelementptr inbounds i32, i32* %.35, i32 %.34
  %.37 = load i32, i32* %.36
  %.38 = load i32, i32* %.7
  %.39 = add i32 %.38, 1
  %.40 = load i32*, i32** %.3
  %.41 = getelementptr inbounds i32, i32* %.40, i32 %.39
  %.42 = load i32, i32* %.41
  %.43 = icmp sgt i32 %.37, %.42
  br i1 %.43, label %.32, label %.33
.23wn20:
  %.71 = load i32, i32* %.6
  %.72 = add i32 %.71, 1
  store i32 %.72, i32* %.6
  br label %.10wc8 
.32:
  %.46 = load i32, i32* %.7
  %.47 = add i32 %.46, 1
  %.48 = load i32*, i32** %.3
  %.49 = getelementptr inbounds i32, i32* %.48, i32 %.47
  %.50 = load i32, i32* %.49
  store i32 %.50, i32* %.45
  %.52 = load i32, i32* %.7
  %.53 = load i32*, i32** %.3
  %.54 = getelementptr inbounds i32, i32* %.53, i32 %.52
  %.55 = load i32, i32* %.54
  %.56 = load i32, i32* %.7
  %.57 = add i32 %.56, 1
  %.58 = load i32*, i32** %.3
  %.59 = getelementptr inbounds i32, i32* %.58, i32 %.57
  store i32 %.55, i32* %.59
  %.61 = load i32, i32* %.45
  %.62 = load i32, i32* %.7
  %.63 = load i32*, i32** %.3
  %.64 = getelementptr inbounds i32, i32* %.63, i32 %.62
  store i32 %.61, i32* %.64
  br label %.33 
.33:
  %.67 = load i32, i32* %.7
  %.68 = add i32 %.67, 1
  store i32 %.68, i32* %.7
  br label %.21wc11 
}
define i32 @insertsort(i32* %.79){
.77:
  %.97 = alloca i32
  %.91 = alloca i32
  %.81 = alloca i32
  %.78 = alloca i32*
  store i32* %.79, i32** %.78
  store i32 1, i32* %.81
  br label %.83wc29 
.83wc29:
  %.87 = load i32, i32* %.81
  %.88 = load i32, i32* @.g.n
  %.89 = icmp slt i32 %.87, %.88
  br i1 %.89, label %.84wloop.29.42, label %.85wn42
.84wloop.29.42:
  %.92 = load i32, i32* %.81
  %.93 = load i32*, i32** %.78
  %.94 = getelementptr inbounds i32, i32* %.93, i32 %.92
  %.95 = load i32, i32* %.94
  store i32 %.95, i32* %.91
  %.98 = load i32, i32* %.81
  %.99 = sub i32 %.98, 1
  store i32 %.99, i32* %.97
  br label %.101wc35 
.85wn42:
  ret i32 0 
.101wc35:
  %.105 = load i32, i32* %.97
  %.107 = icmp sgt i32 %.105, -1
  br i1 %.107, label %.108, label %.103wn39
.102wloop.35.39:
  %.117 = load i32, i32* %.97
  %.118 = load i32*, i32** %.78
  %.119 = getelementptr inbounds i32, i32* %.118, i32 %.117
  %.120 = load i32, i32* %.119
  %.121 = load i32, i32* %.97
  %.122 = add i32 %.121, 1
  %.123 = load i32*, i32** %.78
  %.124 = getelementptr inbounds i32, i32* %.123, i32 %.122
  store i32 %.120, i32* %.124
  %.126 = load i32, i32* %.97
  %.127 = sub i32 %.126, 1
  store i32 %.127, i32* %.97
  br label %.101wc35 
.103wn39:
  %.130 = load i32, i32* %.91
  %.131 = load i32, i32* %.97
  %.132 = add i32 %.131, 1
  %.133 = load i32*, i32** %.78
  %.134 = getelementptr inbounds i32, i32* %.133, i32 %.132
  store i32 %.130, i32* %.134
  %.136 = load i32, i32* %.81
  %.137 = add i32 %.136, 1
  store i32 %.137, i32* %.81
  br label %.83wc29 
.108:
  %.110 = load i32, i32* %.91
  %.111 = load i32, i32* %.97
  %.112 = load i32*, i32** %.78
  %.113 = getelementptr inbounds i32, i32* %.112, i32 %.111
  %.114 = load i32, i32* %.113
  %.115 = icmp slt i32 %.110, %.114
  br i1 %.115, label %.102wloop.35.39, label %.103wn39
}
define i32 @QuickSort(i32* %.144, i32 %.147, i32 %.150){
.142:
  %.261 = alloca i32
  %.164 = alloca i32
  %.161 = alloca i32
  %.158 = alloca i32
  %.149 = alloca i32
  %.146 = alloca i32
  %.143 = alloca i32*
  store i32* %.144, i32** %.143
  store i32 %.147, i32* %.146
  store i32 %.150, i32* %.149
  %.154 = load i32, i32* %.146
  %.155 = load i32, i32* %.149
  %.156 = icmp slt i32 %.154, %.155
  br i1 %.156, label %.152, label %.153
.152:
  %.159 = load i32, i32* %.146
  store i32 %.159, i32* %.158
  %.162 = load i32, i32* %.149
  store i32 %.162, i32* %.161
  %.165 = load i32, i32* %.146
  %.166 = load i32*, i32** %.143
  %.167 = getelementptr inbounds i32, i32* %.166, i32 %.165
  %.168 = load i32, i32* %.167
  store i32 %.168, i32* %.164
  br label %.170wc56 
.153:
  ret i32 0 
.170wc56:
  %.174 = load i32, i32* %.158
  %.175 = load i32, i32* %.161
  %.176 = icmp slt i32 %.174, %.175
  br i1 %.176, label %.171wloop.56.79, label %.172wn79
.171wloop.56.79:
  br label %.178wc58 
.172wn79:
  %.256 = load i32, i32* %.164
  %.257 = load i32, i32* %.158
  %.258 = load i32*, i32** %.143
  %.259 = getelementptr inbounds i32, i32* %.258, i32 %.257
  store i32 %.256, i32* %.259
  %.262 = load i32, i32* %.158
  %.263 = sub i32 %.262, 1
  store i32 %.263, i32* %.261
  %.265 = load i32*, i32** %.143
  %.266 = load i32, i32* %.146
  %.267 = load i32, i32* %.261
  %.268at84 = call i32 @QuickSort(i32* %.265, i32 %.266, i32 %.267)
  store i32 %.268at84, i32* %.261
  %.270 = load i32, i32* %.158
  %.271 = add i32 %.270, 1
  store i32 %.271, i32* %.261
  %.273 = load i32*, i32** %.143
  %.274 = load i32, i32* %.261
  %.275 = load i32, i32* %.149
  %.276at86 = call i32 @QuickSort(i32* %.273, i32 %.274, i32 %.275)
  store i32 %.276at86, i32* %.261
  br label %.153 
.178wc58:
  %.182 = load i32, i32* %.158
  %.183 = load i32, i32* %.161
  %.184 = icmp slt i32 %.182, %.183
  br i1 %.184, label %.185, label %.180wn61
.179wloop.58.61:
  %.195 = load i32, i32* %.161
  %.196 = sub i32 %.195, 1
  store i32 %.196, i32* %.161
  br label %.178wc58 
.180wn61:
  %.201 = load i32, i32* %.158
  %.202 = load i32, i32* %.161
  %.203 = icmp slt i32 %.201, %.202
  br i1 %.203, label %.199, label %.200
.185:
  %.187 = load i32, i32* %.161
  %.188 = load i32*, i32** %.143
  %.189 = getelementptr inbounds i32, i32* %.188, i32 %.187
  %.190 = load i32, i32* %.189
  %.191 = load i32, i32* %.164
  %.192 = sub i32 %.191, 1
  %.193 = icmp sgt i32 %.190, %.192
  br i1 %.193, label %.179wloop.58.61, label %.180wn61
.199:
  %.205 = load i32, i32* %.161
  %.206 = load i32*, i32** %.143
  %.207 = getelementptr inbounds i32, i32* %.206, i32 %.205
  %.208 = load i32, i32* %.207
  %.209 = load i32, i32* %.158
  %.210 = load i32*, i32** %.143
  %.211 = getelementptr inbounds i32, i32* %.210, i32 %.209
  store i32 %.208, i32* %.211
  %.213 = load i32, i32* %.158
  %.214 = add i32 %.213, 1
  store i32 %.214, i32* %.158
  br label %.200 
.200:
  br label %.217wc69 
.217wc69:
  %.221 = load i32, i32* %.158
  %.222 = load i32, i32* %.161
  %.223 = icmp slt i32 %.221, %.222
  br i1 %.223, label %.224, label %.219wn72
.218wloop.69.72:
  %.233 = load i32, i32* %.158
  %.234 = add i32 %.233, 1
  store i32 %.234, i32* %.158
  br label %.217wc69 
.219wn72:
  %.239 = load i32, i32* %.158
  %.240 = load i32, i32* %.161
  %.241 = icmp slt i32 %.239, %.240
  br i1 %.241, label %.237, label %.238
.224:
  %.226 = load i32, i32* %.158
  %.227 = load i32*, i32** %.143
  %.228 = getelementptr inbounds i32, i32* %.227, i32 %.226
  %.229 = load i32, i32* %.228
  %.230 = load i32, i32* %.164
  %.231 = icmp slt i32 %.229, %.230
  br i1 %.231, label %.218wloop.69.72, label %.219wn72
.237:
  %.243 = load i32, i32* %.158
  %.244 = load i32*, i32** %.143
  %.245 = getelementptr inbounds i32, i32* %.244, i32 %.243
  %.246 = load i32, i32* %.245
  %.247 = load i32, i32* %.161
  %.248 = load i32*, i32** %.143
  %.249 = getelementptr inbounds i32, i32* %.248, i32 %.247
  store i32 %.246, i32* %.249
  %.251 = load i32, i32* %.161
  %.252 = sub i32 %.251, 1
  store i32 %.252, i32* %.161
  br label %.238 
.238:
  br label %.170wc56 
}
define i32 @getMid(i32* %.283){
.281:
  %.285 = alloca i32
  %.282 = alloca i32*
  store i32* %.283, i32** %.282
  %.288 = load i32, i32* @.g.n
  %.290 = srem i32 %.288, 2
  %.291 = icmp eq i32 %.290, 0
  br i1 %.291, label %.286, label %.287
.286:
  %.293 = load i32, i32* @.g.n
  %.294 = sdiv i32 %.293, 2
  store i32 %.294, i32* %.285
  %.296 = load i32, i32* %.285
  %.297 = load i32*, i32** %.282
  %.298 = getelementptr inbounds i32, i32* %.297, i32 %.296
  %.299 = load i32, i32* %.298
  %.300 = load i32, i32* %.285
  %.301 = sub i32 %.300, 1
  %.302 = load i32*, i32** %.282
  %.303 = getelementptr inbounds i32, i32* %.302, i32 %.301
  %.304 = load i32, i32* %.303
  %.305 = add i32 %.299, %.304
  %.306 = sdiv i32 %.305, 2
  ret i32 %.306 
.287:
  %.308 = load i32, i32* @.g.n
  %.309 = sdiv i32 %.308, 2
  store i32 %.309, i32* %.285
  %.311 = load i32, i32* %.285
  %.312 = load i32*, i32** %.282
  %.313 = getelementptr inbounds i32, i32* %.312, i32 %.311
  %.314 = load i32, i32* %.313
  ret i32 %.314 
}
define i32 @getMost(i32* %.319){
.317:
  %.351 = alloca i32
  %.341 = alloca i32
  %.340 = alloca i32
  %.323 = alloca i32
  %.322 = alloca [1000 x i32]
  %.318 = alloca i32*
  store i32* %.319, i32** %.318
  store i32 0, i32* %.323
  br label %.325wc107 
.325wc107:
  %.329 = load i32, i32* %.323
  %.330 = icmp slt i32 %.329, 1000
  br i1 %.330, label %.326wloop.107.110, label %.327wn110
.326wloop.107.110:
  %.332 = load i32, i32* %.323
  %.333 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.332
  store i32 0, i32* %.333
  %.335 = load i32, i32* %.323
  %.336 = add i32 %.335, 1
  store i32 %.336, i32* %.323
  br label %.325wc107 
.327wn110:
  store i32 0, i32* %.323
  store i32 0, i32* %.340
  br label %.343wc115 
.343wc115:
  %.347 = load i32, i32* %.323
  %.348 = load i32, i32* @.g.n
  %.349 = icmp slt i32 %.347, %.348
  br i1 %.349, label %.344wloop.115.124, label %.345wn124
.344wloop.115.124:
  %.352 = load i32, i32* %.323
  %.353 = load i32*, i32** %.318
  %.354 = getelementptr inbounds i32, i32* %.353, i32 %.352
  %.355 = load i32, i32* %.354
  store i32 %.355, i32* %.351
  %.357 = load i32, i32* %.351
  %.358 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.357
  %.359 = load i32, i32* %.358
  %.360 = add i32 %.359, 1
  %.361 = load i32, i32* %.351
  %.362 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.361
  store i32 %.360, i32* %.362
  %.366 = load i32, i32* %.351
  %.367 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.366
  %.368 = load i32, i32* %.367
  %.369 = load i32, i32* %.340
  %.370 = icmp sgt i32 %.368, %.369
  br i1 %.370, label %.364, label %.365
.345wn124:
  %.383 = load i32, i32* %.341
  ret i32 %.383 
.364:
  %.372 = load i32, i32* %.351
  %.373 = getelementptr inbounds [1000 x i32], [1000 x i32]* %.322, i32 0, i32 %.372
  %.374 = load i32, i32* %.373
  store i32 %.374, i32* %.340
  %.376 = load i32, i32* %.351
  store i32 %.376, i32* %.341
  br label %.365 
.365:
  %.379 = load i32, i32* %.323
  %.380 = add i32 %.379, 1
  store i32 %.380, i32* %.323
  br label %.343wc115 
}
define i32 @revert(i32* %.388){
.386:
  %.392 = alloca i32
  %.391 = alloca i32
  %.390 = alloca i32
  %.387 = alloca i32*
  store i32* %.388, i32** %.387
  store i32 0, i32* %.391
  store i32 0, i32* %.392
  br label %.395wc134 
.395wc134:
  %.399 = load i32, i32* %.391
  %.400 = load i32, i32* %.392
  %.401 = icmp slt i32 %.399, %.400
  br i1 %.401, label %.396wloop.134.140, label %.397wn140
.396wloop.134.140:
  %.403 = load i32, i32* %.391
  %.404 = load i32*, i32** %.387
  %.405 = getelementptr inbounds i32, i32* %.404, i32 %.403
  %.406 = load i32, i32* %.405
  store i32 %.406, i32* %.390
  %.408 = load i32, i32* %.392
  %.409 = load i32*, i32** %.387
  %.410 = getelementptr inbounds i32, i32* %.409, i32 %.408
  %.411 = load i32, i32* %.410
  %.412 = load i32, i32* %.391
  %.413 = load i32*, i32** %.387
  %.414 = getelementptr inbounds i32, i32* %.413, i32 %.412
  store i32 %.411, i32* %.414
  %.416 = load i32, i32* %.390
  %.417 = load i32, i32* %.392
  %.418 = load i32*, i32** %.387
  %.419 = getelementptr inbounds i32, i32* %.418, i32 %.417
  store i32 %.416, i32* %.419
  %.421 = load i32, i32* %.391
  %.422 = add i32 %.421, 1
  store i32 %.422, i32* %.391
  %.424 = load i32, i32* %.392
  %.425 = sub i32 %.424, 1
  store i32 %.425, i32* %.392
  br label %.395wc134 
.397wn140:
  ret i32 0 
}
define i32 @arrCopy(i32* %.432, i32* %.435){
.430:
  %.437 = alloca i32
  %.434 = alloca i32*
  %.431 = alloca i32*
  store i32* %.432, i32** %.431
  store i32* %.435, i32** %.434
  store i32 0, i32* %.437
  br label %.439wc147 
.439wc147:
  %.443 = load i32, i32* %.437
  %.444 = load i32, i32* @.g.n
  %.445 = icmp slt i32 %.443, %.444
  br i1 %.445, label %.440wloop.147.150, label %.441wn150
.440wloop.147.150:
  %.447 = load i32, i32* %.437
  %.448 = load i32*, i32** %.431
  %.449 = getelementptr inbounds i32, i32* %.448, i32 %.447
  %.450 = load i32, i32* %.449
  %.451 = load i32, i32* %.437
  %.452 = load i32*, i32** %.434
  %.453 = getelementptr inbounds i32, i32* %.452, i32 %.451
  store i32 %.450, i32* %.453
  %.455 = load i32, i32* %.437
  %.456 = add i32 %.455, 1
  store i32 %.456, i32* %.437
  br label %.439wc147 
.441wn150:
  ret i32 0 
}
define i32 @calSum(i32* %.463, i32 %.466){
.461:
  %.470 = alloca i32
  %.468 = alloca i32
  %.465 = alloca i32
  %.462 = alloca i32*
  store i32* %.463, i32** %.462
  store i32 %.466, i32* %.465
  store i32 0, i32* %.468
  store i32 0, i32* %.470
  br label %.472wc159 
.472wc159:
  %.476 = load i32, i32* %.470
  %.477 = load i32, i32* @.g.n
  %.478 = icmp slt i32 %.476, %.477
  br i1 %.478, label %.473wloop.159.168, label %.474wn168
.473wloop.159.168:
  %.480 = load i32, i32* %.468
  %.481 = load i32, i32* %.470
  %.482 = load i32*, i32** %.462
  %.483 = getelementptr inbounds i32, i32* %.482, i32 %.481
  %.484 = load i32, i32* %.483
  %.485 = add i32 %.480, %.484
  store i32 %.485, i32* %.468
  %.489 = load i32, i32* %.470
  %.490 = load i32, i32* %.465
  %.491 = srem i32 %.489, %.490
  %.492 = load i32, i32* %.465
  %.493 = sub i32 %.492, 1
  %.494 = icmp ne i32 %.491, %.493
  br i1 %.494, label %.487, label %.488
.474wn168:
  ret i32 0 
.487:
  %.496 = load i32, i32* %.470
  %.497 = load i32*, i32** %.462
  %.498 = getelementptr inbounds i32, i32* %.497, i32 %.496
  store i32 0, i32* %.498
  br label %.500 
.488:
  %.502 = load i32, i32* %.468
  %.503 = load i32, i32* %.470
  %.504 = load i32*, i32** %.462
  %.505 = getelementptr inbounds i32, i32* %.504, i32 %.503
  store i32 %.502, i32* %.505
  store i32 0, i32* %.468
  br label %.500 
.500:
  %.509 = load i32, i32* %.470
  %.510 = add i32 %.509, 1
  store i32 %.510, i32* %.470
  br label %.472wc159 
}
define i32 @avgPooling(i32* %.517, i32 %.520){
.515:
  %.526 = alloca i32
  %.523 = alloca i32
  %.522 = alloca i32
  %.519 = alloca i32
  %.516 = alloca i32*
  store i32* %.517, i32** %.516
  store i32 %.520, i32* %.519
  store i32 0, i32* %.523
  store i32 0, i32* %.522
  br label %.527wc178 
.527wc178:
  %.531 = load i32, i32* %.523
  %.532 = load i32, i32* @.g.n
  %.533 = icmp slt i32 %.531, %.532
  br i1 %.533, label %.528wloop.178.190, label %.529wn190
.528wloop.178.190:
  %.537 = load i32, i32* %.523
  %.538 = load i32, i32* %.519
  %.539 = sub i32 %.538, 1
  %.540 = icmp slt i32 %.537, %.539
  br i1 %.540, label %.535, label %.536
.529wn190:
  %.603 = load i32, i32* @.g.n
  %.604 = load i32, i32* %.519
  %.605 = sub i32 %.603, %.604
  %.606 = add i32 %.605, 1
  store i32 %.606, i32* %.523
  br label %.608wc192 
.535:
  %.542 = load i32, i32* %.522
  %.543 = load i32, i32* %.523
  %.544 = load i32*, i32** %.516
  %.545 = getelementptr inbounds i32, i32* %.544, i32 %.543
  %.546 = load i32, i32* %.545
  %.547 = add i32 %.542, %.546
  store i32 %.547, i32* %.522
  br label %.549 
.536:
  %.553 = load i32, i32* %.523
  %.554 = load i32, i32* %.519
  %.555 = sub i32 %.554, 1
  %.556 = icmp eq i32 %.553, %.555
  br i1 %.556, label %.551, label %.552
.549:
  %.599 = load i32, i32* %.523
  %.600 = add i32 %.599, 1
  store i32 %.600, i32* %.523
  br label %.527wc178 
.551:
  %.558 = load i32*, i32** %.516
  %.559 = getelementptr inbounds i32, i32* %.558, i32 0
  %.560 = load i32, i32* %.559
  store i32 %.560, i32* %.526
  %.562 = load i32, i32* %.522
  %.563 = load i32, i32* %.519
  %.564 = sdiv i32 %.562, %.563
  %.565 = load i32*, i32** %.516
  %.566 = getelementptr inbounds i32, i32* %.565, i32 0
  store i32 %.564, i32* %.566
  br label %.568 
.552:
  %.570 = load i32, i32* %.522
  %.571 = load i32, i32* %.523
  %.572 = load i32*, i32** %.516
  %.573 = getelementptr inbounds i32, i32* %.572, i32 %.571
  %.574 = load i32, i32* %.573
  %.575 = add i32 %.570, %.574
  %.576 = load i32, i32* %.526
  %.577 = sub i32 %.575, %.576
  store i32 %.577, i32* %.522
  %.579 = load i32, i32* %.523
  %.580 = load i32, i32* %.519
  %.581 = sub i32 %.579, %.580
  %.582 = add i32 %.581, 1
  %.583 = load i32*, i32** %.516
  %.584 = getelementptr inbounds i32, i32* %.583, i32 %.582
  %.585 = load i32, i32* %.584
  store i32 %.585, i32* %.526
  %.587 = load i32, i32* %.522
  %.588 = load i32, i32* %.519
  %.589 = sdiv i32 %.587, %.588
  %.590 = load i32, i32* %.523
  %.591 = load i32, i32* %.519
  %.592 = sub i32 %.590, %.591
  %.593 = add i32 %.592, 1
  %.594 = load i32*, i32** %.516
  %.595 = getelementptr inbounds i32, i32* %.594, i32 %.593
  store i32 %.589, i32* %.595
  br label %.568 
.568:
  br label %.549 
.608wc192:
  %.612 = load i32, i32* %.523
  %.613 = load i32, i32* @.g.n
  %.614 = icmp slt i32 %.612, %.613
  br i1 %.614, label %.609wloop.192.195, label %.610wn195
.609wloop.192.195:
  %.616 = load i32, i32* %.523
  %.617 = load i32*, i32** %.516
  %.618 = getelementptr inbounds i32, i32* %.617, i32 %.616
  store i32 0, i32* %.618
  %.620 = load i32, i32* %.523
  %.621 = add i32 %.620, 1
  store i32 %.621, i32* %.523
  br label %.608wc192 
.610wn195:
  ret i32 0 
}
define i32 @main(){
.626:
  %.756 = alloca i32
  %.748 = alloca i32
  %.630 = alloca [32 x i32]
  %.629 = alloca [32 x i32]
  store i32 32, i32* @.g.n
  %.632 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  store i32 7, i32* %.632
  %.635 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 1
  store i32 23, i32* %.635
  %.638 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 2
  store i32 89, i32* %.638
  %.642 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 3
  store i32 26, i32* %.642
  %.646 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 4
  store i32 282, i32* %.646
  %.650 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 5
  store i32 254, i32* %.650
  %.654 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 6
  store i32 27, i32* %.654
  %.656 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 7
  store i32 5, i32* %.656
  %.660 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 8
  store i32 83, i32* %.660
  %.664 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 9
  store i32 273, i32* %.664
  %.668 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 10
  store i32 574, i32* %.668
  %.672 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 11
  store i32 905, i32* %.672
  %.676 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 12
  store i32 354, i32* %.676
  %.680 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 13
  store i32 657, i32* %.680
  %.684 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 14
  store i32 935, i32* %.684
  %.688 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 15
  store i32 264, i32* %.688
  %.692 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 16
  store i32 639, i32* %.692
  %.696 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 17
  store i32 459, i32* %.696
  %.700 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 18
  store i32 29, i32* %.700
  %.704 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 19
  store i32 68, i32* %.704
  %.708 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 20
  store i32 929, i32* %.708
  %.712 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 21
  store i32 756, i32* %.712
  %.716 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 22
  store i32 452, i32* %.716
  %.719 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 23
  store i32 279, i32* %.719
  %.723 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 24
  store i32 58, i32* %.723
  %.727 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 25
  store i32 87, i32* %.727
  %.730 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 26
  store i32 96, i32* %.730
  %.733 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 27
  store i32 36, i32* %.733
  %.737 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 28
  store i32 39, i32* %.737
  %.739 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 29
  store i32 28, i32* %.739
  %.742 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 30
  store i32 1, i32* %.742
  %.746 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 31
  store i32 290, i32* %.746
  %.749 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.750 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.751at236 = call i32 @arrCopy(i32* %.749, i32* %.750)
  store i32 %.751at236, i32* %.748
  %.753 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.754at237 = call i32 @revert(i32* %.753)
  store i32 %.754at237, i32* %.748
  store i32 0, i32* %.756
  br label %.758wc240 
.758wc240:
  %.762 = load i32, i32* %.756
  %.763 = icmp slt i32 %.762, 32
  br i1 %.763, label %.759wloop.240.244, label %.760wn244
.759wloop.240.244:
  %.765 = load i32, i32* %.756
  %.766 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.765
  %.767 = load i32, i32* %.766
  store i32 %.767, i32* %.748
  %.769 = load i32, i32* %.748
  call void @putint(i32 %.769)
  %.772 = load i32, i32* %.756
  %.773 = add i32 %.772, 1
  store i32 %.773, i32* %.756
  br label %.758wc240 
.760wn244:
  %.776 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.777at245 = call i32 @bubblesort(i32* %.776)
  store i32 %.777at245, i32* %.748
  store i32 0, i32* %.756
  br label %.780wc247 
.780wc247:
  %.784 = load i32, i32* %.756
  %.785 = icmp slt i32 %.784, 32
  br i1 %.785, label %.781wloop.247.251, label %.782wn251
.781wloop.247.251:
  %.787 = load i32, i32* %.756
  %.788 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.787
  %.789 = load i32, i32* %.788
  store i32 %.789, i32* %.748
  %.791 = load i32, i32* %.748
  call void @putint(i32 %.791)
  %.793 = load i32, i32* %.756
  %.794 = add i32 %.793, 1
  store i32 %.794, i32* %.756
  br label %.780wc247 
.782wn251:
  %.797 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.798at252 = call i32 @getMid(i32* %.797)
  store i32 %.798at252, i32* %.748
  %.800 = load i32, i32* %.748
  call void @putint(i32 %.800)
  %.802 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.803at254 = call i32 @getMost(i32* %.802)
  store i32 %.803at254, i32* %.748
  %.805 = load i32, i32* %.748
  call void @putint(i32 %.805)
  %.807 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.808 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.809at257 = call i32 @arrCopy(i32* %.807, i32* %.808)
  store i32 %.809at257, i32* %.748
  %.811 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.812at258 = call i32 @bubblesort(i32* %.811)
  store i32 %.812at258, i32* %.748
  store i32 0, i32* %.756
  br label %.815wc260 
.815wc260:
  %.819 = load i32, i32* %.756
  %.820 = icmp slt i32 %.819, 32
  br i1 %.820, label %.816wloop.260.264, label %.817wn264
.816wloop.260.264:
  %.822 = load i32, i32* %.756
  %.823 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.822
  %.824 = load i32, i32* %.823
  store i32 %.824, i32* %.748
  %.826 = load i32, i32* %.748
  call void @putint(i32 %.826)
  %.828 = load i32, i32* %.756
  %.829 = add i32 %.828, 1
  store i32 %.829, i32* %.756
  br label %.815wc260 
.817wn264:
  %.832 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.833 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.834at266 = call i32 @arrCopy(i32* %.832, i32* %.833)
  store i32 %.834at266, i32* %.748
  %.836 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.837at267 = call i32 @insertsort(i32* %.836)
  store i32 %.837at267, i32* %.748
  store i32 0, i32* %.756
  br label %.840wc269 
.840wc269:
  %.844 = load i32, i32* %.756
  %.845 = icmp slt i32 %.844, 32
  br i1 %.845, label %.841wloop.269.273, label %.842wn273
.841wloop.269.273:
  %.847 = load i32, i32* %.756
  %.848 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.847
  %.849 = load i32, i32* %.848
  store i32 %.849, i32* %.748
  %.851 = load i32, i32* %.748
  call void @putint(i32 %.851)
  %.853 = load i32, i32* %.756
  %.854 = add i32 %.853, 1
  store i32 %.854, i32* %.756
  br label %.840wc269 
.842wn273:
  %.857 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.858 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.859at275 = call i32 @arrCopy(i32* %.857, i32* %.858)
  store i32 %.859at275, i32* %.748
  store i32 0, i32* %.756
  store i32 31, i32* %.748
  %.863 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.864 = load i32, i32* %.756
  %.865 = load i32, i32* %.748
  %.866at278 = call i32 @QuickSort(i32* %.863, i32 %.864, i32 %.865)
  store i32 %.866at278, i32* %.748
  br label %.868wc279 
.868wc279:
  %.872 = load i32, i32* %.756
  %.873 = icmp slt i32 %.872, 32
  br i1 %.873, label %.869wloop.279.283, label %.870wn283
.869wloop.279.283:
  %.875 = load i32, i32* %.756
  %.876 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.875
  %.877 = load i32, i32* %.876
  store i32 %.877, i32* %.748
  %.879 = load i32, i32* %.748
  call void @putint(i32 %.879)
  %.881 = load i32, i32* %.756
  %.882 = add i32 %.881, 1
  store i32 %.882, i32* %.756
  br label %.868wc279 
.870wn283:
  %.885 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.886 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.887at285 = call i32 @arrCopy(i32* %.885, i32* %.886)
  store i32 %.887at285, i32* %.748
  %.889 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.890at286 = call i32 @calSum(i32* %.889, i32 4)
  store i32 %.890at286, i32* %.748
  store i32 0, i32* %.756
  br label %.893wc288 
.893wc288:
  %.897 = load i32, i32* %.756
  %.898 = icmp slt i32 %.897, 32
  br i1 %.898, label %.894wloop.288.292, label %.895wn292
.894wloop.288.292:
  %.900 = load i32, i32* %.756
  %.901 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 %.900
  %.902 = load i32, i32* %.901
  store i32 %.902, i32* %.748
  %.904 = load i32, i32* %.748
  call void @putint(i32 %.904)
  %.906 = load i32, i32* %.756
  %.907 = add i32 %.906, 1
  store i32 %.907, i32* %.756
  br label %.893wc288 
.895wn292:
  %.910 = getelementptr inbounds [32 x i32], [32 x i32]* %.629, i32 0, i32 0
  %.911 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.912at294 = call i32 @arrCopy(i32* %.910, i32* %.911)
  store i32 %.912at294, i32* %.748
  %.914 = getelementptr inbounds [32 x i32], [32 x i32]* %.630, i32 0, i32 0
  %.915at295 = call i32 @avgPooling(i32* %.914, i32 3)
  store i32 %.915at295, i32* %.748
  store i32 0, i32* %.756
  br label %.918wc297 
.918wc297:
  %.922 = load i32, i32* %.756
  %.923 = icmp slt i32 %.922, 32
  br i1 %.923, label %.919wlo