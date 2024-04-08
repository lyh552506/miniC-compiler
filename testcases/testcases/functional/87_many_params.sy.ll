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
@__constant..705 = constant [16 x i32]  [i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]
@__constant..834 = constant [32 x [2 x i32]]  [[2 x i32]  [i32 0, i32 8848], [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer]
define void @sort(i32* %.3, i32 %.6){
.1:
  %.45 = alloca i32
  %.21 = alloca i32
  %.8 = alloca i32
  %.5 = alloca i32
  %.2 = alloca i32*
  store i32* %.3, i32** %.2
  store i32 %.6, i32* %.5
  store i32 0, i32* %.8
  br label %.11wc3 
.11wc3:
  %.15 = load i32, i32* %.8
  %.16 = load i32, i32* %.5
  %.18 = sub i32 %.16, 1
  %.19 = icmp slt i32 %.15, %.18
  br i1 %.19, label %.12wloop.3.14, label %.13wn14
.12wloop.3.14:
  %.22 = load i32, i32* %.8
  %.23 = add i32 %.22, 1
  store i32 %.23, i32* %.21
  br label %.25wc5 
.13wn14:
  ret void
.25wc5:
  %.29 = load i32, i32* %.21
  %.30 = load i32, i32* %.5
  %.31 = icmp slt i32 %.29, %.30
  br i1 %.31, label %.26wloop.5.12, label %.27wn12
.26wloop.5.12:
  %.35 = load i32, i32* %.8
  %.36 = load i32*, i32** %.2
  %.37 = getelementptr inbounds i32, i32* %.36, i32 %.35
  %.38 = load i32, i32* %.37
  %.39 = load i32, i32* %.21
  %.40 = load i32*, i32** %.2
  %.41 = getelementptr inbounds i32, i32* %.40, i32 %.39
  %.42 = load i32, i32* %.41
  %.43 = icmp slt i32 %.38, %.42
  br i1 %.43, label %.33, label %.34
.27wn12:
  %.69 = load i32, i32* %.8
  %.70 = add i32 %.69, 1
  store i32 %.70, i32* %.8
  br label %.11wc3 
.33:
  %.46 = load i32, i32* %.8
  %.47 = load i32*, i32** %.2
  %.48 = getelementptr inbounds i32, i32* %.47, i32 %.46
  %.49 = load i32, i32* %.48
  store i32 %.49, i32* %.45
  %.51 = load i32, i32* %.21
  %.52 = load i32*, i32** %.2
  %.53 = getelementptr inbounds i32, i32* %.52, i32 %.51
  %.54 = load i32, i32* %.53
  %.55 = load i32, i32* %.8
  %.56 = load i32*, i32** %.2
  %.57 = getelementptr inbounds i32, i32* %.56, i32 %.55
  store i32 %.54, i32* %.57
  %.59 = load i32, i32* %.45
  %.60 = load i32, i32* %.21
  %.61 = load i32*, i32** %.2
  %.62 = getelementptr inbounds i32, i32* %.61, i32 %.60
  store i32 %.59, i32* %.62
  br label %.34 
.34:
  %.65 = load i32, i32* %.21
  %.66 = add i32 %.65, 1
  store i32 %.66, i32* %.21
  br label %.25wc5 
}
define i32 @param32_rec(i32 %.77, i32 %.80, i32 %.83, i32 %.86, i32 %.89, i32 %.92, i32 %.95, i32 %.98, i32 %.101, i32 %.104, i32 %.107, i32 %.110, i32 %.113, i32 %.116, i32 %.119, i32 %.122, i32 %.125, i32 %.128, i32 %.131, i32 %.134, i32 %.137, i32 %.140, i32 %.143, i32 %.146, i32 %.149, i32 %.152, i32 %.155, i32 %.158, i32 %.161, i32 %.164, i32 %.167, i32 %.170){
.75:
  %.169 = alloca i32
  %.166 = alloca i32
  %.163 = alloca i32
  %.160 = alloca i32
  %.157 = alloca i32
  %.154 = alloca i32
  %.151 = alloca i32
  %.148 = alloca i32
  %.145 = alloca i32
  %.142 = alloca i32
  %.139 = alloca i32
  %.136 = alloca i32
  %.133 = alloca i32
  %.130 = alloca i32
  %.127 = alloca i32
  %.124 = alloca i32
  %.121 = alloca i32
  %.118 = alloca i32
  %.115 = alloca i32
  %.112 = alloca i32
  %.109 = alloca i32
  %.106 = alloca i32
  %.103 = alloca i32
  %.100 = alloca i32
  %.97 = alloca i32
  %.94 = alloca i32
  %.91 = alloca i32
  %.88 = alloca i32
  %.85 = alloca i32
  %.82 = alloca i32
  %.79 = alloca i32
  %.76 = alloca i32
  store i32 %.77, i32* %.76
  store i32 %.80, i32* %.79
  store i32 %.83, i32* %.82
  store i32 %.86, i32* %.85
  store i32 %.89, i32* %.88
  store i32 %.92, i32* %.91
  store i32 %.95, i32* %.94
  store i32 %.98, i32* %.97
  store i32 %.101, i32* %.100
  store i32 %.104, i32* %.103
  store i32 %.107, i32* %.106
  store i32 %.110, i32* %.109
  store i32 %.113, i32* %.112
  store i32 %.116, i32* %.115
  store i32 %.119, i32* %.118
  store i32 %.122, i32* %.121
  store i32 %.125, i32* %.124
  store i32 %.128, i32* %.127
  store i32 %.131, i32* %.130
  store i32 %.134, i32* %.133
  store i32 %.137, i32* %.136
  store i32 %.140, i32* %.139
  store i32 %.143, i32* %.142
  store i32 %.146, i32* %.145
  store i32 %.149, i32* %.148
  store i32 %.152, i32* %.151
  store i32 %.155, i32* %.154
  store i32 %.158, i32* %.157
  store i32 %.161, i32* %.160
  store i32 %.164, i32* %.163
  store i32 %.167, i32* %.166
  store i32 %.170, i32* %.169
  %.174 = load i32, i32* %.76
  %.175 = icmp eq i32 %.174, 0
  br i1 %.175, label %.172, label %.173
.172:
  %.177 = load i32, i32* %.79
  ret i32 %.177 
.173:
  %.179 = load i32, i32* %.76
  %.180 = sub i32 %.179, 1
  %.181 = load i32, i32* %.79
  %.182 = load i32, i32* %.82
  %.183 = add i32 %.181, %.182
  %.185 = srem i32 %.183, 998244353
  %.186 = load i32, i32* %.85
  %.187 = load i32, i32* %.88
  %.188 = load i32, i32* %.91
  %.189 = load i32, i32* %.94
  %.190 = load i32, i32* %.97
  %.191 = load i32, i32* %.100
  %.192 = load i32, i32* %.103
  %.193 = load i32, i32* %.106
  %.194 = load i32, i32* %.109
  %.195 = load i32, i32* %.112
  %.196 = load i32, i32* %.115
  %.197 = load i32, i32* %.118
  %.198 = load i32, i32* %.121
  %.199 = load i32, i32* %.124
  %.200 = load i32, i32* %.127
  %.201 = load i32, i32* %.130
  %.202 = load i32, i32* %.133
  %.203 = load i32, i32* %.136
  %.204 = load i32, i32* %.139
  %.205 = load i32, i32* %.142
  %.206 = load i32, i32* %.145
  %.207 = load i32, i32* %.148
  %.208 = load i32, i32* %.151
  %.209 = load i32, i32* %.154
  %.210 = load i32, i32* %.157
  %.211 = load i32, i32* %.160
  %.212 = load i32, i32* %.163
  %.213 = load i32, i32* %.166
  %.214 = load i32, i32* %.169
  %.215at27 = call i32 @param32_rec(i32 %.180, i32 %.185, i32 %.186, i32 %.187, i32 %.188, i32 %.189, i32 %.190, i32 %.191, i32 %.192, i32 %.193, i32 %.194, i32 %.195, i32 %.196, i32 %.197, i32 %.198, i32 %.199, i32 %.200, i32 %.201, i32 %.202, i32 %.203, i32 %.204, i32 %.205, i32 %.206, i32 %.207, i32 %.208, i32 %.209, i32 %.210, i32 %.211, i32 %.212, i32 %.213, i32 %.214, i32 0)
  ret i32 %.215at27 
}
define i32 @param32_arr(i32* %.220, i32* %.223, i32* %.226, i32* %.229, i32* %.232, i32* %.235, i32* %.238, i32* %.241, i32* %.244, i32* %.247, i32* %.250, i32* %.253, i32* %.256, i32* %.259, i32* %.262, i32* %.265, i32* %.268, i32* %.271, i32* %.274, i32* %.277, i32* %.280, i32* %.283, i32* %.286, i32* %.289, i32* %.292, i32* %.295, i32* %.298, i32* %.301, i32* %.304, i32* %.307, i32* %.310, i32* %.313){
.218:
  %.315 = alloca i32
  %.312 = alloca i32*
  %.309 = alloca i32*
  %.306 = alloca i32*
  %.303 = alloca i32*
  %.300 = alloca i32*
  %.297 = alloca i32*
  %.294 = alloca i32*
  %.291 = alloca i32*
  %.288 = alloca i32*
  %.285 = alloca i32*
  %.282 = alloca i32*
  %.279 = alloca i32*
  %.276 = alloca i32*
  %.273 = alloca i32*
  %.270 = alloca i32*
  %.267 = alloca i32*
  %.264 = alloca i32*
  %.261 = alloca i32*
  %.258 = alloca i32*
  %.255 = alloca i32*
  %.252 = alloca i32*
  %.249 = alloca i32*
  %.246 = alloca i32*
  %.243 = alloca i32*
  %.240 = alloca i32*
  %.237 = alloca i32*
  %.234 = alloca i32*
  %.231 = alloca i32*
  %.228 = alloca i32*
  %.225 = alloca i32*
  %.222 = alloca i32*
  %.219 = alloca i32*
  store i32* %.220, i32** %.219
  store i32* %.223, i32** %.222
  store i32* %.226, i32** %.225
  store i32* %.229, i32** %.228
  store i32* %.232, i32** %.231
  store i32* %.235, i32** %.234
  store i32* %.238, i32** %.237
  store i32* %.241, i32** %.240
  store i32* %.244, i32** %.243
  store i32* %.247, i32** %.246
  store i32* %.250, i32** %.249
  store i32* %.253, i32** %.252
  store i32* %.256, i32** %.255
  store i32* %.259, i32** %.258
  store i32* %.262, i32** %.261
  store i32* %.265, i32** %.264
  store i32* %.268, i32** %.267
  store i32* %.271, i32** %.270
  store i32* %.274, i32** %.273
  store i32* %.277, i32** %.276
  store i32* %.280, i32** %.279
  store i32* %.283, i32** %.282
  store i32* %.286, i32** %.285
  store i32* %.289, i32** %.288
  store i32* %.292, i32** %.291
  store i32* %.295, i32** %.294
  store i32* %.298, i32** %.297
  store i32* %.301, i32** %.300
  store i32* %.304, i32** %.303
  store i32* %.307, i32** %.306
  store i32* %.310, i32** %.309
  store i32* %.313, i32** %.312
  %.316 = load i32*, i32** %.219
  %.317 = getelementptr inbounds i32, i32* %.316, i32 0
  %.318 = load i32, i32* %.317
  %.319 = load i32*, i32** %.219
  %.320 = getelementptr inbounds i32, i32* %.319, i32 1
  %.321 = load i32, i32* %.320
  %.322 = add i32 %.318, %.321
  store i32 %.322, i32* %.315
  %.324 = load i32, i32* %.315
  %.325 = load i32*, i32** %.222
  %.326 = getelementptr inbounds i32, i32* %.325, i32 0
  %.327 = load i32, i32* %.326
  %.328 = add i32 %.324, %.327
  %.329 = load i32*, i32** %.222
  %.330 = getelementptr inbounds i32, i32* %.329, i32 1
  %.331 = load i32, i32* %.330
  %.332 = add i32 %.328, %.331
  store i32 %.332, i32* %.315
  %.334 = load i32, i32* %.315
  %.335 = load i32*, i32** %.225
  %.336 = getelementptr inbounds i32, i32* %.335, i32 0
  %.337 = load i32, i32* %.336
  %.338 = add i32 %.334, %.337
  %.339 = load i32*, i32** %.225
  %.340 = getelementptr inbounds i32, i32* %.339, i32 1
  %.341 = load i32, i32* %.340
  %.342 = add i32 %.338, %.341
  store i32 %.342, i32* %.315
  %.344 = load i32, i32* %.315
  %.345 = load i32*, i32** %.228
  %.346 = getelementptr inbounds i32, i32* %.345, i32 0
  %.347 = load i32, i32* %.346
  %.348 = add i32 %.344, %.347
  %.349 = load i32*, i32** %.228
  %.350 = getelementptr inbounds i32, i32* %.349, i32 1
  %.351 = load i32, i32* %.350
  %.352 = add i32 %.348, %.351
  store i32 %.352, i32* %.315
  %.354 = load i32, i32* %.315
  %.355 = load i32*, i32** %.231
  %.356 = getelementptr inbounds i32, i32* %.355, i32 0
  %.357 = load i32, i32* %.356
  %.358 = add i32 %.354, %.357
  %.359 = load i32*, i32** %.231
  %.360 = getelementptr inbounds i32, i32* %.359, i32 1
  %.361 = load i32, i32* %.360
  %.362 = add i32 %.358, %.361
  store i32 %.362, i32* %.315
  %.364 = load i32, i32* %.315
  %.365 = load i32*, i32** %.234
  %.366 = getelementptr inbounds i32, i32* %.365, i32 0
  %.367 = load i32, i32* %.366
  %.368 = add i32 %.364, %.367
  %.369 = load i32*, i32** %.234
  %.370 = getelementptr inbounds i32, i32* %.369, i32 1
  %.371 = load i32, i32* %.370
  %.372 = add i32 %.368, %.371
  store i32 %.372, i32* %.315
  %.374 = load i32, i32* %.315
  %.375 = load i32*, i32** %.237
  %.376 = getelementptr inbounds i32, i32* %.375, i32 0
  %.377 = load i32, i32* %.376
  %.378 = add i32 %.374, %.377
  %.379 = load i32*, i32** %.237
  %.380 = getelementptr inbounds i32, i32* %.379, i32 1
  %.381 = load i32, i32* %.380
  %.382 = add i32 %.378, %.381
  store i32 %.382, i32* %.315
  %.384 = load i32, i32* %.315
  %.385 = load i32*, i32** %.240
  %.386 = getelementptr inbounds i32, i32* %.385, i32 0
  %.387 = load i32, i32* %.386
  %.388 = add i32 %.384, %.387
  %.389 = load i32*, i32** %.240
  %.390 = getelementptr inbounds i32, i32* %.389, i32 1
  %.391 = load i32, i32* %.390
  %.392 = add i32 %.388, %.391
  store i32 %.392, i32* %.315
  %.394 = load i32, i32* %.315
  %.395 = load i32*, i32** %.243
  %.396 = getelementptr inbounds i32, i32* %.395, i32 0
  %.397 = load i32, i32* %.396
  %.398 = add i32 %.394, %.397
  %.399 = load i32*, i32** %.243
  %.400 = getelementptr inbounds i32, i32* %.399, i32 1
  %.401 = load i32, i32* %.400
  %.402 = add i32 %.398, %.401
  store i32 %.402, i32* %.315
  %.404 = load i32, i32* %.315
  %.405 = load i32*, i32** %.246
  %.406 = getelementptr inbounds i32, i32* %.405, i32 0
  %.407 = load i32, i32* %.406
  %.408 = add i32 %.404, %.407
  %.409 = load i32*, i32** %.246
  %.410 = getelementptr inbounds i32, i32* %.409, i32 1
  %.411 = load i32, i32* %.410
  %.412 = add i32 %.408, %.411
  store i32 %.412, i32* %.315
  %.414 = load i32, i32* %.315
  %.415 = load i32*, i32** %.249
  %.416 = getelementptr inbounds i32, i32* %.415, i32 0
  %.417 = load i32, i32* %.416
  %.418 = add i32 %.414, %.417
  %.419 = load i32*, i32** %.249
  %.420 = getelementptr inbounds i32, i32* %.419, i32 1
  %.421 = load i32, i32* %.420
  %.422 = add i32 %.418, %.421
  store i32 %.422, i32* %.315
  %.424 = load i32, i32* %.315
  %.425 = load i32*, i32** %.252
  %.426 = getelementptr inbounds i32, i32* %.425, i32 0
  %.427 = load i32, i32* %.426
  %.428 = add i32 %.424, %.427
  %.429 = load i32*, i32** %.252
  %.430 = getelementptr inbounds i32, i32* %.429, i32 1
  %.431 = load i32, i32* %.430
  %.432 = add i32 %.428, %.431
  store i32 %.432, i32* %.315
  %.434 = load i32, i32* %.315
  %.435 = load i32*, i32** %.255
  %.436 = getelementptr inbounds i32, i32* %.435, i32 0
  %.437 = load i32, i32* %.436
  %.438 = add i32 %.434, %.437
  %.439 = load i32*, i32** %.255
  %.440 = getelementptr inbounds i32, i32* %.439, i32 1
  %.441 = load i32, i32* %.440
  %.442 = add i32 %.438, %.441
  store i32 %.442, i32* %.315
  %.444 = load i32, i32* %.315
  %.445 = load i32*, i32** %.258
  %.446 = getelementptr inbounds i32, i32* %.445, i32 0
  %.447 = load i32, i32* %.446
  %.448 = add i32 %.444, %.447
  %.449 = load i32*, i32** %.258
  %.450 = getelementptr inbounds i32, i32* %.449, i32 1
  %.451 = load i32, i32* %.450
  %.452 = add i32 %.448, %.451
  store i32 %.452, i32* %.315
  %.454 = load i32, i32* %.315
  %.455 = load i32*, i32** %.261
  %.456 = getelementptr inbounds i32, i32* %.455, i32 0
  %.457 = load i32, i32* %.456
  %.458 = add i32 %.454, %.457
  %.459 = load i32*, i32** %.261
  %.460 = getelementptr inbounds i32, i32* %.459, i32 1
  %.461 = load i32, i32* %.460
  %.462 = add i32 %.458, %.461
  store i32 %.462, i32* %.315
  %.464 = load i32, i32* %.315
  %.465 = load i32*, i32** %.264
  %.466 = getelementptr inbounds i32, i32* %.465, i32 0
  %.467 = load i32, i32* %.466
  %.468 = add i32 %.464, %.467
  %.469 = load i32*, i32** %.264
  %.470 = getelementptr inbounds i32, i32* %.469, i32 1
  %.471 = load i32, i32* %.470
  %.472 = add i32 %.468, %.471
  store i32 %.472, i32* %.315
  %.474 = load i32, i32* %.315
  %.475 = load i32*, i32** %.267
  %.476 = getelementptr inbounds i32, i32* %.475, i32 0
  %.477 = load i32, i32* %.476
  %.478 = add i32 %.474, %.477
  %.479 = load i32*, i32** %.267
  %.480 = getelementptr inbounds i32, i32* %.479, i32 1
  %.481 = load i32, i32* %.480
  %.482 = add i32 %.478, %.481
  store i32 %.482, i32* %.315
  %.484 = load i32, i32* %.315
  %.485 = load i32*, i32** %.270
  %.486 = getelementptr inbounds i32, i32* %.485, i32 0
  %.487 = load i32, i32* %.486
  %.488 = add i32 %.484, %.487
  %.489 = load i32*, i32** %.270
  %.490 = getelementptr inbounds i32, i32* %.489, i32 1
  %.491 = load i32, i32* %.490
  %.492 = add i32 %.488, %.491
  store i32 %.492, i32* %.315
  %.494 = load i32, i32* %.315
  %.495 = load i32*, i32** %.273
  %.496 = getelementptr inbounds i32, i32* %.495, i32 0
  %.497 = load i32, i32* %.496
  %.498 = add i32 %.494, %.497
  %.499 = load i32*, i32** %.273
  %.500 = getelementptr inbounds i32, i32* %.499, i32 1
  %.501 = load i32, i32* %.500
  %.502 = add i32 %.498, %.501
  store i32 %.502, i32* %.315
  %.504 = load i32, i32* %.315
  %.505 = load i32*, i32** %.276
  %.506 = getelementptr inbounds i32, i32* %.505, i32 0
  %.507 = load i32, i32* %.506
  %.508 = add i32 %.504, %.507
  %.509 = load i32*, i32** %.276
  %.510 = getelementptr inbounds i32, i32* %.509, i32 1
  %.511 = load i32, i32* %.510
  %.512 = add i32 %.508, %.511
  store i32 %.512, i32* %.315
  %.514 = load i32, i32* %.315
  %.515 = load i32*, i32** %.279
  %.516 = getelementptr inbounds i32, i32* %.515, i32 0
  %.517 = load i32, i32* %.516
  %.518 = add i32 %.514, %.517
  %.519 = load i32*, i32** %.279
  %.520 = getelementptr inbounds i32, i32* %.519, i32 1
  %.521 = load i32, i32* %.520
  %.522 = add i32 %.518, %.521
  store i32 %.522, i32* %.315
  %.524 = load i32, i32* %.315
  %.525 = load i32*, i32** %.282
  %.526 = getelementptr inbounds i32, i32* %.525, i32 0
  %.527 = load i32, i32* %.526
  %.528 = add i32 %.524, %.527
  %.529 = load i32*, i32** %.282
  %.530 = getelementptr inbounds i32, i32* %.529, i32 1
  %.531 = load i32, i32* %.530
  %.532 = add i32 %.528, %.531
  store i32 %.532, i32* %.315
  %.534 = load i32, i32* %.315
  %.535 = load i32*, i32** %.285
  %.536 = getelementptr inbounds i32, i32* %.535, i32 0
  %.537 = load i32, i32* %.536
  %.538 = add i32 %.534, %.537
  %.539 = load i32*, i32** %.285
  %.540 = getelementptr inbounds i32, i32* %.539, i32 1
  %.541 = load i32, i32* %.540
  %.542 = add i32 %.538, %.541
  store i32 %.542, i32* %.315
  %.544 = load i32, i32* %.315
  %.545 = load i32*, i32** %.288
  %.546 = getelementptr inbounds i32, i32* %.545, i32 0
  %.547 = load i32, i32* %.546
  %.548 = add i32 %.544, %.547
  %.549 = load i32*, i32** %.288
  %.550 = getelementptr inbounds i32, i32* %.549, i32 1
  %.551 = load i32, i32* %.550
  %.552 = add i32 %.548, %.551
  store i32 %.552, i32* %.315
  %.554 = load i32, i32* %.315
  %.555 = load i32*, i32** %.291
  %.556 = getelementptr inbounds i32, i32* %.555, i32 0
  %.557 = load i32, i32* %.556
  %.558 = add i32 %.554, %.557
  %.559 = load i32*, i32** %.291
  %.560 = getelementptr inbounds i32, i32* %.559, i32 1
  %.561 = load i32, i32* %.560
  %.562 = add i32 %.558, %.561
  store i32 %.562, i32* %.315
  %.564 = load i32, i32* %.315
  %.565 = load i32*, i32** %.294
  %.566 = getelementptr inbounds i32, i32* %.565, i32 0
  %.567 = load i32, i32* %.566
  %.568 = add i32 %.564, %.567
  %.569 = load i32*, i32** %.294
  %.570 = getelementptr inbounds i32, i32* %.569, i32 1
  %.571 = load i32, i32* %.570
  %.572 = add i32 %.568, %.571
  store i32 %.572, i32* %.315
  %.574 = load i32, i32* %.315
  %.575 = load i32*, i32** %.297
  %.576 = getelementptr inbounds i32, i32* %.575, i32 0
  %.577 = load i32, i32* %.576
  %.578 = add i32 %.574, %.577
  %.579 = load i32*, i32** %.297
  %.580 = getelementptr inbounds i32, i32* %.579, i32 1
  %.581 = load i32, i32* %.580
  %.582 = add i32 %.578, %.581
  store i32 %.582, i32* %.315
  %.584 = load i32, i32* %.315
  %.585 = load i32*, i32** %.300
  %.586 = getelementptr inbounds i32, i32* %.585, i32 0
  %.587 = load i32, i32* %.586
  %.588 = add i32 %.584, %.587
  %.589 = load i32*, i32** %.300
  %.590 = getelementptr inbounds i32, i32* %.589, i32 1
  %.591 = load i32, i32* %.590
  %.592 = add i32 %.588, %.591
  store i32 %.592, i32* %.315
  %.594 = load i32, i32* %.315
  %.595 = load i32*, i32** %.303
  %.596 = getelementptr inbounds i32, i32* %.595, i32 0
  %.597 = load i32, i32* %.596
  %.598 = add i32 %.594, %.597
  %.599 = load i32*, i32** %.303
  %.600 = getelementptr inbounds i32, i32* %.599, i32 1
  %.601 = load i32, i32* %.600
  %.602 = add i32 %.598, %.601
  store i32 %.602, i32* %.315
  %.604 = load i32, i32* %.315
  %.605 = load i32*, i32** %.306
  %.606 = getelementptr inbounds i32, i32* %.605, i32 0
  %.607 = load i32, i32* %.606
  %.608 = add i32 %.604, %.607
  %.609 = load i32*, i32** %.306
  %.610 = getelementptr inbounds i32, i32* %.609, i32 1
  %.611 = load i32, i32* %.610
  %.612 = add i32 %.608, %.611
  store i32 %.612, i32* %.315
  %.614 = load i32, i32* %.315
  %.615 = load i32*, i32** %.309
  %.616 = getelementptr inbounds i32, i32* %.615, i32 0
  %.617 = load i32, i32* %.616
  %.618 = add i32 %.614, %.617
  %.619 = load i32*, i32** %.309
  %.620 = getelementptr inbounds i32, i32* %.619, i32 1
  %.621 = load i32, i32* %.620
  %.622 = add i32 %.618, %.621
  store i32 %.622, i32* %.315
  %.624 = load i32, i32* %.315
  %.625 = load i32*, i32** %.312
  %.626 = getelementptr inbounds i32, i32* %.625, i32 0
  %.627 = load i32, i32* %.626
  %.628 = add i32 %.624, %.627
  %.629 = load i32*, i32** %.312
  %.630 = getelementptr inbounds i32, i32* %.629, i32 1
  %.631 = load i32, i32* %.630
  %.632 = add i32 %.628, %.631
  store i32 %.632, i32* %.315
  %.634 = load i32, i32* %.315
  ret i32 %.634 
}
define i32 @param16(i32 %.639, i32 %.642, i32 %.645, i32 %.648, i32 %.651, i32 %.654, i32 %.657, i32 %.660, i32 %.663, i32 %.666, i32 %.669, i32 %.672, i32 %.675, i32 %.678, i32 %.681, i32 %.684){
.637:
  %.687 = alloca [16 x i32]
  %.683 = alloca i32
  %.680 = alloca i32
  %.677 = alloca i32
  %.674 = alloca i32
  %.671 = alloca i32
  %.668 = alloca i32
  %.665 = alloca i32
  %.662 = alloca i32
  %.659 = alloca i32
  %.656 = alloca i32
  %.653 = alloca i32
  %.650 = alloca i32
  %.647 = alloca i32
  %.644 = alloca i32
  %.641 = alloca i32
  %.638 = alloca i32
  store i32 %.639, i32* %.638
  store i32 %.642, i32* %.641
  store i32 %.645, i32* %.644
  store i32 %.648, i32* %.647
  store i32 %.651, i32* %.650
  store i32 %.654, i32* %.653
  store i32 %.657, i32* %.656
  store i32 %.660, i32* %.659
  store i32 %.663, i32* %.662
  store i32 %.666, i32* %.665
  store i32 %.669, i32* %.668
  store i32 %.672, i32* %.671
  store i32 %.675, i32* %.674
  store i32 %.678, i32* %.677
  store i32 %.681, i32* %.680
  store i32 %.684, i32* %.683
  %.689 = load i32, i32* %.638
  %.690 = load i32, i32* %.641
  %.691 = load i32, i32* %.644
  %.692 = load i32, i32* %.647
  %.693 = load i32, i32* %.650
  %.694 = load i32, i32* %.653
  %.695 = load i32, i32* %.656
  %.696 = load i32, i32* %.659
  %.697 = load i32, i32* %.662
  %.698 = load i32, i32* %.665
  %.699 = load i32, i32* %.668
  %.700 = load i32, i32* %.671
  %.701 = load i32, i32* %.674
  %.702 = load i32, i32* %.677
  %.703 = load i32, i32* %.680
  %.704 = load i32, i32* %.683
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.687, [16 x i32]* @__constant..705, i32 64, i1 false)
  %.711 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 0
  store i32 %.689, i32* %.711
  %.713 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 1
  store i32 %.690, i32* %.713
  %.715 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 2
  store i32 %.691, i32* %.715
  %.718 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 3
  store i32 %.692, i32* %.718
  %.721 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 4
  store i32 %.693, i32* %.721
  %.724 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 5
  store i32 %.694, i32* %.724
  %.727 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 6
  store i32 %.695, i32* %.727
  %.730 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 7
  store i32 %.696, i32* %.730
  %.733 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 8
  store i32 %.697, i32* %.733
  %.736 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 9
  store i32 %.698, i32* %.736
  %.739 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 10
  store i32 %.699, i32* %.739
  %.742 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 11
  store i32 %.700, i32* %.742
  %.745 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 12
  store i32 %.701, i32* %.745
  %.748 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 13
  store i32 %.702, i32* %.748
  %.751 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 14
  store i32 %.703, i32* %.751
  %.754 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 15
  store i32 %.704, i32* %.754
  %.757 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 0
  call void @sort(i32* %.757, i32 16)
  %.759 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 0
  %.760 = load i32, i32* %.759
  %.761 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 1
  %.762 = load i32, i32* %.761
  %.763 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 2
  %.764 = load i32, i32* %.763
  %.765 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 3
  %.766 = load i32, i32* %.765
  %.767 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 4
  %.768 = load i32, i32* %.767
  %.769 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 5
  %.770 = load i32, i32* %.769
  %.771 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 6
  %.772 = load i32, i32* %.771
  %.773 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 7
  %.774 = load i32, i32* %.773
  %.775 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 8
  %.776 = load i32, i32* %.775
  %.777 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 9
  %.778 = load i32, i32* %.777
  %.779 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 10
  %.780 = load i32, i32* %.779
  %.781 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 11
  %.782 = load i32, i32* %.781
  %.783 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 12
  %.784 = load i32, i32* %.783
  %.785 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 13
  %.786 = load i32, i32* %.785
  %.787 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 14
  %.788 = load i32, i32* %.787
  %.789 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 15
  %.790 = load i32, i32* %.789
  %.791 = load i32, i32* %.638
  %.792 = load i32, i32* %.641
  %.793 = load i32, i32* %.644
  %.794 = load i32, i32* %.647
  %.795 = load i32, i32* %.650
  %.796 = load i32, i32* %.653
  %.797 = load i32, i32* %.656
  %.798 = load i32, i32* %.659
  %.799 = load i32, i32* %.662
  %.800 = load i32, i32* %.665
  %.801 = load i32, i32* %.668
  %.802 = load i32, i32* %.671
  %.803 = load i32, i32* %.674
  %.804 = load i32, i32* %.677
  %.805 = load i32, i32* %.680
  %.806 = load i32, i32* %.683
  %.807at81 = call i32 @param32_rec(i32 %.760, i32 %.762, i32 %.764, i32 %.766, i32 %.768, i32 %.770, i32 %.772, i32 %.774, i32 %.776, i32 %.778, i32 %.780, i32 %.782, i32 %.784, i32 %.786, i32 %.788, i32 %.790, i32 %.791, i32 %.792, i32 %.793, i32 %.794, i32 %.795, i32 %.796, i32 %.797, i32 %.798, i32 %.799, i32 %.800, i32 %.801, i32 %.802, i32 %.803, i32 %.804, i32 %.805, i32 %.806)
  ret i32 %.807at81 
}
define i32 @main(){
.810:
  %.839 = alloca i32
  %.812 = alloca [32 x [2 x i32]]
  %.816at88 = call i32 @getint()
  %.817at88 = call i32 @getint()
  %.818at88 = call i32 @getint()
  %.819at88 = call i32 @getint()
  %.820at88 = call i32 @getint()
  %.821at89 = call i32 @getint()
  %.822at89 = call i32 @getint()
  %.823at89 = call i32 @getint()
  %.824at89 = call i32 @getint()
  %.825at89 = call i32 @getint()
  %.826at90 = call i32 @getint()
  %.827at90 = call i32 @getint()
  %.828at90 = call i32 @getint()
  %.829at90 = call i32 @getint()
  %.830at90 = call i32 @getint()
  %.831at91 = call i32 @getint()
  %.832at88 = call i32 @param16(i32 %.816at88, i32 %.817at88, i32 %.818at88, i32 %.819at88, i32 %.820at88, i32 %.821at89, i32 %.822at89, i32 %.823at89, i32 %.824at89, i32 %.825at89, i32 %.826at90, i32 %.827at90, i32 %.828at90, i32 %.829at90, i32 %.830at90, i32 %.831at91)
  call void @llvm.memcpy.p0.p0.i32([32 x [2 x i32]]* %.812, [32 x [2 x i32]]* @__constant..834, i32 256, i1 false)
  %.837 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 0, i32 0
  store i32 %.832at88, i32* %.837
  store i32 1, i32* %.839
  br label %.841wc94 
.841wc94:
  %.845 = load i32, i32* %.839
  %.846 = icmp slt i32 %.845, 32
  br i1 %.846, label %.842wloop.94.98, label %.843wn98
.842wloop.94.98:
  %.848 = load i32, i32* %.839
  %.849 = sub i32 %.848, 1
  %.850 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 %.849, i32 1
  %.851 = load i32, i32* %.850
  %.852 = sub i32 %.851, 1
  %.853 = load i32, i32* %.839
  %.854 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 %.853, i32 0
  store i32 %.852, i32* %.854
  %.856 = load i32, i32* %.839
  %.857 = sub i32 %.856, 1
  %.858 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 %.857, i32 0
  %.859 = load i32, i32* %.858
  %.860 = sub i32 %.859, 2
  %.861 = load i32, i32* %.839
  %.862 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 %.861, i32 1
  store i32 %.860, i32* %.862
  %.864 = load i32, i32* %.839
  %.865 = add i32 %.864, 1
  store i32 %.865, i32* %.839
  br label %.841wc94 
.843wn98:
  %.868 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 0, i32 0
  %.869 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 1, i32 0
  %.870 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 2, i32 0
  %.871 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 3, i32 0
  %.872 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 4, i32 0
  %.873 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 5, i32 0
  %.874 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 6, i32 0
  %.875 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 7, i32 0
  %.876 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 8, i32 0
  %.877 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 9, i32 0
  %.878 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 10, i32 0
  %.879 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 11, i32 0
  %.880 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 12, i32 0
  %.881 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 13, i32 0
  %.882 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 14, i32 0
  %.883 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 15, i32 0
  %.884 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 16, i32 0
  %.886 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 17, i32 0
  %.888 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 18, i32 0
  %.890 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 19, i32 0
  %.892 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 20, i32 0
  %.894 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 21, i32 0
  %.896 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 22, i32 0
  %.898 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 23, i32 0
  %.900 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 24, i32 0
  %.902 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 25, i32 0
  %.904 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 26, i32 0
  %.906 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 27, i32 0
  %.908 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 28, i32 0
  %.910 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 29, i32 0
  %.912 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 30, i32 0
  %.914 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 31, i32 0
  %.915at99 = call i32 @param32_arr(i32* %.868, i32* %.869, i32* %.870, i32* %.871, i32* %.872, i32* %.873, i32* %.874, i32* %.875, i32* %.876, i32* %.877, i32* %.878, i32* %.879, i32* %.880, i32* %.881, i32* %.882, i32* %.883, i32* %.884, i32* %.886, i32* %.888, i32* %.890, i32* %.892, i32* %.894, i32* %.896, i32* %.898, i32* %.900, i32* %.902, i32* %.904, i32* %.906, i32* %.908, i32* %.910, i32* %.912, i32* %.914)
  call void @putint(i32 %.915at99)
  call void @putch(i32 10)
  ret i32 0 
}
@__constant..705 = constant [16 x i32]  [i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]
@__constant..834 = constant [32 x [2 x i32]]  [[2 x i32]  [i32 0, i32 8848], [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer, [2 x i32] zeroinitializer]
define void @sort(i32* %.3, i32 %.6){
.1:
  %.45 = alloca i32
  %.21 = alloca i32
  %.8 = alloca i32
  %.5 = alloca i32
  %.2 = alloca i32*
  store i32* %.3, i32** %.2
  store i32 %.6, i32* %.5
  store i32 0, i32* %.8
  br label %.11wc3 
.11wc3:
  %.15 = load i32, i32* %.8
  %.16 = load i32, i32* %.5
  %.18 = sub i32 %.16, 1
  %.19 = icmp slt i32 %.15, %.18
  br i1 %.19, label %.12wloop.3.14, label %.13wn14
.12wloop.3.14:
  %.22 = load i32, i32* %.8
  %.23 = add i32 %.22, 1
  store i32 %.23, i32* %.21
  br label %.25wc5 
.13wn14:
  ret void
.25wc5:
  %.29 = load i32, i32* %.21
  %.30 = load i32, i32* %.5
  %.31 = icmp slt i32 %.29, %.30
  br i1 %.31, label %.26wloop.5.12, label %.27wn12
.26wloop.5.12:
  %.35 = load i32, i32* %.8
  %.36 = load i32*, i32** %.2
  %.37 = getelementptr inbounds i32, i32* %.36, i32 %.35
  %.38 = load i32, i32* %.37
  %.39 = load i32, i32* %.21
  %.40 = load i32*, i32** %.2
  %.41 = getelementptr inbounds i32, i32* %.40, i32 %.39
  %.42 = load i32, i32* %.41
  %.43 = icmp slt i32 %.38, %.42
  br i1 %.43, label %.33, label %.34
.27wn12:
  %.69 = load i32, i32* %.8
  %.70 = add i32 %.69, 1
  store i32 %.70, i32* %.8
  br label %.11wc3 
.33:
  %.46 = load i32, i32* %.8
  %.47 = load i32*, i32** %.2
  %.48 = getelementptr inbounds i32, i32* %.47, i32 %.46
  %.49 = load i32, i32* %.48
  store i32 %.49, i32* %.45
  %.51 = load i32, i32* %.21
  %.52 = load i32*, i32** %.2
  %.53 = getelementptr inbounds i32, i32* %.52, i32 %.51
  %.54 = load i32, i32* %.53
  %.55 = load i32, i32* %.8
  %.56 = load i32*, i32** %.2
  %.57 = getelementptr inbounds i32, i32* %.56, i32 %.55
  store i32 %.54, i32* %.57
  %.59 = load i32, i32* %.45
  %.60 = load i32, i32* %.21
  %.61 = load i32*, i32** %.2
  %.62 = getelementptr inbounds i32, i32* %.61, i32 %.60
  store i32 %.59, i32* %.62
  br label %.34 
.34:
  %.65 = load i32, i32* %.21
  %.66 = add i32 %.65, 1
  store i32 %.66, i32* %.21
  br label %.25wc5 
}
define i32 @param32_rec(i32 %.77, i32 %.80, i32 %.83, i32 %.86, i32 %.89, i32 %.92, i32 %.95, i32 %.98, i32 %.101, i32 %.104, i32 %.107, i32 %.110, i32 %.113, i32 %.116, i32 %.119, i32 %.122, i32 %.125, i32 %.128, i32 %.131, i32 %.134, i32 %.137, i32 %.140, i32 %.143, i32 %.146, i32 %.149, i32 %.152, i32 %.155, i32 %.158, i32 %.161, i32 %.164, i32 %.167, i32 %.170){
.75:
  %.169 = alloca i32
  %.166 = alloca i32
  %.163 = alloca i32
  %.160 = alloca i32
  %.157 = alloca i32
  %.154 = alloca i32
  %.151 = alloca i32
  %.148 = alloca i32
  %.145 = alloca i32
  %.142 = alloca i32
  %.139 = alloca i32
  %.136 = alloca i32
  %.133 = alloca i32
  %.130 = alloca i32
  %.127 = alloca i32
  %.124 = alloca i32
  %.121 = alloca i32
  %.118 = alloca i32
  %.115 = alloca i32
  %.112 = alloca i32
  %.109 = alloca i32
  %.106 = alloca i32
  %.103 = alloca i32
  %.100 = alloca i32
  %.97 = alloca i32
  %.94 = alloca i32
  %.91 = alloca i32
  %.88 = alloca i32
  %.85 = alloca i32
  %.82 = alloca i32
  %.79 = alloca i32
  %.76 = alloca i32
  store i32 %.77, i32* %.76
  store i32 %.80, i32* %.79
  store i32 %.83, i32* %.82
  store i32 %.86, i32* %.85
  store i32 %.89, i32* %.88
  store i32 %.92, i32* %.91
  store i32 %.95, i32* %.94
  store i32 %.98, i32* %.97
  store i32 %.101, i32* %.100
  store i32 %.104, i32* %.103
  store i32 %.107, i32* %.106
  store i32 %.110, i32* %.109
  store i32 %.113, i32* %.112
  store i32 %.116, i32* %.115
  store i32 %.119, i32* %.118
  store i32 %.122, i32* %.121
  store i32 %.125, i32* %.124
  store i32 %.128, i32* %.127
  store i32 %.131, i32* %.130
  store i32 %.134, i32* %.133
  store i32 %.137, i32* %.136
  store i32 %.140, i32* %.139
  store i32 %.143, i32* %.142
  store i32 %.146, i32* %.145
  store i32 %.149, i32* %.148
  store i32 %.152, i32* %.151
  store i32 %.155, i32* %.154
  store i32 %.158, i32* %.157
  store i32 %.161, i32* %.160
  store i32 %.164, i32* %.163
  store i32 %.167, i32* %.166
  store i32 %.170, i32* %.169
  %.174 = load i32, i32* %.76
  %.175 = icmp eq i32 %.174, 0
  br i1 %.175, label %.172, label %.173
.172:
  %.177 = load i32, i32* %.79
  ret i32 %.177 
.173:
  %.179 = load i32, i32* %.76
  %.180 = sub i32 %.179, 1
  %.181 = load i32, i32* %.79
  %.182 = load i32, i32* %.82
  %.183 = add i32 %.181, %.182
  %.185 = srem i32 %.183, 998244353
  %.186 = load i32, i32* %.85
  %.187 = load i32, i32* %.88
  %.188 = load i32, i32* %.91
  %.189 = load i32, i32* %.94
  %.190 = load i32, i32* %.97
  %.191 = load i32, i32* %.100
  %.192 = load i32, i32* %.103
  %.193 = load i32, i32* %.106
  %.194 = load i32, i32* %.109
  %.195 = load i32, i32* %.112
  %.196 = load i32, i32* %.115
  %.197 = load i32, i32* %.118
  %.198 = load i32, i32* %.121
  %.199 = load i32, i32* %.124
  %.200 = load i32, i32* %.127
  %.201 = load i32, i32* %.130
  %.202 = load i32, i32* %.133
  %.203 = load i32, i32* %.136
  %.204 = load i32, i32* %.139
  %.205 = load i32, i32* %.142
  %.206 = load i32, i32* %.145
  %.207 = load i32, i32* %.148
  %.208 = load i32, i32* %.151
  %.209 = load i32, i32* %.154
  %.210 = load i32, i32* %.157
  %.211 = load i32, i32* %.160
  %.212 = load i32, i32* %.163
  %.213 = load i32, i32* %.166
  %.214 = load i32, i32* %.169
  %.215at27 = call i32 @param32_rec(i32 %.180, i32 %.185, i32 %.186, i32 %.187, i32 %.188, i32 %.189, i32 %.190, i32 %.191, i32 %.192, i32 %.193, i32 %.194, i32 %.195, i32 %.196, i32 %.197, i32 %.198, i32 %.199, i32 %.200, i32 %.201, i32 %.202, i32 %.203, i32 %.204, i32 %.205, i32 %.206, i32 %.207, i32 %.208, i32 %.209, i32 %.210, i32 %.211, i32 %.212, i32 %.213, i32 %.214, i32 0)
  ret i32 %.215at27 
}
define i32 @param32_arr(i32* %.220, i32* %.223, i32* %.226, i32* %.229, i32* %.232, i32* %.235, i32* %.238, i32* %.241, i32* %.244, i32* %.247, i32* %.250, i32* %.253, i32* %.256, i32* %.259, i32* %.262, i32* %.265, i32* %.268, i32* %.271, i32* %.274, i32* %.277, i32* %.280, i32* %.283, i32* %.286, i32* %.289, i32* %.292, i32* %.295, i32* %.298, i32* %.301, i32* %.304, i32* %.307, i32* %.310, i32* %.313){
.218:
  %.315 = alloca i32
  %.312 = alloca i32*
  %.309 = alloca i32*
  %.306 = alloca i32*
  %.303 = alloca i32*
  %.300 = alloca i32*
  %.297 = alloca i32*
  %.294 = alloca i32*
  %.291 = alloca i32*
  %.288 = alloca i32*
  %.285 = alloca i32*
  %.282 = alloca i32*
  %.279 = alloca i32*
  %.276 = alloca i32*
  %.273 = alloca i32*
  %.270 = alloca i32*
  %.267 = alloca i32*
  %.264 = alloca i32*
  %.261 = alloca i32*
  %.258 = alloca i32*
  %.255 = alloca i32*
  %.252 = alloca i32*
  %.249 = alloca i32*
  %.246 = alloca i32*
  %.243 = alloca i32*
  %.240 = alloca i32*
  %.237 = alloca i32*
  %.234 = alloca i32*
  %.231 = alloca i32*
  %.228 = alloca i32*
  %.225 = alloca i32*
  %.222 = alloca i32*
  %.219 = alloca i32*
  store i32* %.220, i32** %.219
  store i32* %.223, i32** %.222
  store i32* %.226, i32** %.225
  store i32* %.229, i32** %.228
  store i32* %.232, i32** %.231
  store i32* %.235, i32** %.234
  store i32* %.238, i32** %.237
  store i32* %.241, i32** %.240
  store i32* %.244, i32** %.243
  store i32* %.247, i32** %.246
  store i32* %.250, i32** %.249
  store i32* %.253, i32** %.252
  store i32* %.256, i32** %.255
  store i32* %.259, i32** %.258
  store i32* %.262, i32** %.261
  store i32* %.265, i32** %.264
  store i32* %.268, i32** %.267
  store i32* %.271, i32** %.270
  store i32* %.274, i32** %.273
  store i32* %.277, i32** %.276
  store i32* %.280, i32** %.279
  store i32* %.283, i32** %.282
  store i32* %.286, i32** %.285
  store i32* %.289, i32** %.288
  store i32* %.292, i32** %.291
  store i32* %.295, i32** %.294
  store i32* %.298, i32** %.297
  store i32* %.301, i32** %.300
  store i32* %.304, i32** %.303
  store i32* %.307, i32** %.306
  store i32* %.310, i32** %.309
  store i32* %.313, i32** %.312
  %.316 = load i32*, i32** %.219
  %.317 = getelementptr inbounds i32, i32* %.316, i32 0
  %.318 = load i32, i32* %.317
  %.319 = load i32*, i32** %.219
  %.320 = getelementptr inbounds i32, i32* %.319, i32 1
  %.321 = load i32, i32* %.320
  %.322 = add i32 %.318, %.321
  store i32 %.322, i32* %.315
  %.324 = load i32, i32* %.315
  %.325 = load i32*, i32** %.222
  %.326 = getelementptr inbounds i32, i32* %.325, i32 0
  %.327 = load i32, i32* %.326
  %.328 = add i32 %.324, %.327
  %.329 = load i32*, i32** %.222
  %.330 = getelementptr inbounds i32, i32* %.329, i32 1
  %.331 = load i32, i32* %.330
  %.332 = add i32 %.328, %.331
  store i32 %.332, i32* %.315
  %.334 = load i32, i32* %.315
  %.335 = load i32*, i32** %.225
  %.336 = getelementptr inbounds i32, i32* %.335, i32 0
  %.337 = load i32, i32* %.336
  %.338 = add i32 %.334, %.337
  %.339 = load i32*, i32** %.225
  %.340 = getelementptr inbounds i32, i32* %.339, i32 1
  %.341 = load i32, i32* %.340
  %.342 = add i32 %.338, %.341
  store i32 %.342, i32* %.315
  %.344 = load i32, i32* %.315
  %.345 = load i32*, i32** %.228
  %.346 = getelementptr inbounds i32, i32* %.345, i32 0
  %.347 = load i32, i32* %.346
  %.348 = add i32 %.344, %.347
  %.349 = load i32*, i32** %.228
  %.350 = getelementptr inbounds i32, i32* %.349, i32 1
  %.351 = load i32, i32* %.350
  %.352 = add i32 %.348, %.351
  store i32 %.352, i32* %.315
  %.354 = load i32, i32* %.315
  %.355 = load i32*, i32** %.231
  %.356 = getelementptr inbounds i32, i32* %.355, i32 0
  %.357 = load i32, i32* %.356
  %.358 = add i32 %.354, %.357
  %.359 = load i32*, i32** %.231
  %.360 = getelementptr inbounds i32, i32* %.359, i32 1
  %.361 = load i32, i32* %.360
  %.362 = add i32 %.358, %.361
  store i32 %.362, i32* %.315
  %.364 = load i32, i32* %.315
  %.365 = load i32*, i32** %.234
  %.366 = getelementptr inbounds i32, i32* %.365, i32 0
  %.367 = load i32, i32* %.366
  %.368 = add i32 %.364, %.367
  %.369 = load i32*, i32** %.234
  %.370 = getelementptr inbounds i32, i32* %.369, i32 1
  %.371 = load i32, i32* %.370
  %.372 = add i32 %.368, %.371
  store i32 %.372, i32* %.315
  %.374 = load i32, i32* %.315
  %.375 = load i32*, i32** %.237
  %.376 = getelementptr inbounds i32, i32* %.375, i32 0
  %.377 = load i32, i32* %.376
  %.378 = add i32 %.374, %.377
  %.379 = load i32*, i32** %.237
  %.380 = getelementptr inbounds i32, i32* %.379, i32 1
  %.381 = load i32, i32* %.380
  %.382 = add i32 %.378, %.381
  store i32 %.382, i32* %.315
  %.384 = load i32, i32* %.315
  %.385 = load i32*, i32** %.240
  %.386 = getelementptr inbounds i32, i32* %.385, i32 0
  %.387 = load i32, i32* %.386
  %.388 = add i32 %.384, %.387
  %.389 = load i32*, i32** %.240
  %.390 = getelementptr inbounds i32, i32* %.389, i32 1
  %.391 = load i32, i32* %.390
  %.392 = add i32 %.388, %.391
  store i32 %.392, i32* %.315
  %.394 = load i32, i32* %.315
  %.395 = load i32*, i32** %.243
  %.396 = getelementptr inbounds i32, i32* %.395, i32 0
  %.397 = load i32, i32* %.396
  %.398 = add i32 %.394, %.397
  %.399 = load i32*, i32** %.243
  %.400 = getelementptr inbounds i32, i32* %.399, i32 1
  %.401 = load i32, i32* %.400
  %.402 = add i32 %.398, %.401
  store i32 %.402, i32* %.315
  %.404 = load i32, i32* %.315
  %.405 = load i32*, i32** %.246
  %.406 = getelementptr inbounds i32, i32* %.405, i32 0
  %.407 = load i32, i32* %.406
  %.408 = add i32 %.404, %.407
  %.409 = load i32*, i32** %.246
  %.410 = getelementptr inbounds i32, i32* %.409, i32 1
  %.411 = load i32, i32* %.410
  %.412 = add i32 %.408, %.411
  store i32 %.412, i32* %.315
  %.414 = load i32, i32* %.315
  %.415 = load i32*, i32** %.249
  %.416 = getelementptr inbounds i32, i32* %.415, i32 0
  %.417 = load i32, i32* %.416
  %.418 = add i32 %.414, %.417
  %.419 = load i32*, i32** %.249
  %.420 = getelementptr inbounds i32, i32* %.419, i32 1
  %.421 = load i32, i32* %.420
  %.422 = add i32 %.418, %.421
  store i32 %.422, i32* %.315
  %.424 = load i32, i32* %.315
  %.425 = load i32*, i32** %.252
  %.426 = getelementptr inbounds i32, i32* %.425, i32 0
  %.427 = load i32, i32* %.426
  %.428 = add i32 %.424, %.427
  %.429 = load i32*, i32** %.252
  %.430 = getelementptr inbounds i32, i32* %.429, i32 1
  %.431 = load i32, i32* %.430
  %.432 = add i32 %.428, %.431
  store i32 %.432, i32* %.315
  %.434 = load i32, i32* %.315
  %.435 = load i32*, i32** %.255
  %.436 = getelementptr inbounds i32, i32* %.435, i32 0
  %.437 = load i32, i32* %.436
  %.438 = add i32 %.434, %.437
  %.439 = load i32*, i32** %.255
  %.440 = getelementptr inbounds i32, i32* %.439, i32 1
  %.441 = load i32, i32* %.440
  %.442 = add i32 %.438, %.441
  store i32 %.442, i32* %.315
  %.444 = load i32, i32* %.315
  %.445 = load i32*, i32** %.258
  %.446 = getelementptr inbounds i32, i32* %.445, i32 0
  %.447 = load i32, i32* %.446
  %.448 = add i32 %.444, %.447
  %.449 = load i32*, i32** %.258
  %.450 = getelementptr inbounds i32, i32* %.449, i32 1
  %.451 = load i32, i32* %.450
  %.452 = add i32 %.448, %.451
  store i32 %.452, i32* %.315
  %.454 = load i32, i32* %.315
  %.455 = load i32*, i32** %.261
  %.456 = getelementptr inbounds i32, i32* %.455, i32 0
  %.457 = load i32, i32* %.456
  %.458 = add i32 %.454, %.457
  %.459 = load i32*, i32** %.261
  %.460 = getelementptr inbounds i32, i32* %.459, i32 1
  %.461 = load i32, i32* %.460
  %.462 = add i32 %.458, %.461
  store i32 %.462, i32* %.315
  %.464 = load i32, i32* %.315
  %.465 = load i32*, i32** %.264
  %.466 = getelementptr inbounds i32, i32* %.465, i32 0
  %.467 = load i32, i32* %.466
  %.468 = add i32 %.464, %.467
  %.469 = load i32*, i32** %.264
  %.470 = getelementptr inbounds i32, i32* %.469, i32 1
  %.471 = load i32, i32* %.470
  %.472 = add i32 %.468, %.471
  store i32 %.472, i32* %.315
  %.474 = load i32, i32* %.315
  %.475 = load i32*, i32** %.267
  %.476 = getelementptr inbounds i32, i32* %.475, i32 0
  %.477 = load i32, i32* %.476
  %.478 = add i32 %.474, %.477
  %.479 = load i32*, i32** %.267
  %.480 = getelementptr inbounds i32, i32* %.479, i32 1
  %.481 = load i32, i32* %.480
  %.482 = add i32 %.478, %.481
  store i32 %.482, i32* %.315
  %.484 = load i32, i32* %.315
  %.485 = load i32*, i32** %.270
  %.486 = getelementptr inbounds i32, i32* %.485, i32 0
  %.487 = load i32, i32* %.486
  %.488 = add i32 %.484, %.487
  %.489 = load i32*, i32** %.270
  %.490 = getelementptr inbounds i32, i32* %.489, i32 1
  %.491 = load i32, i32* %.490
  %.492 = add i32 %.488, %.491
  store i32 %.492, i32* %.315
  %.494 = load i32, i32* %.315
  %.495 = load i32*, i32** %.273
  %.496 = getelementptr inbounds i32, i32* %.495, i32 0
  %.497 = load i32, i32* %.496
  %.498 = add i32 %.494, %.497
  %.499 = load i32*, i32** %.273
  %.500 = getelementptr inbounds i32, i32* %.499, i32 1
  %.501 = load i32, i32* %.500
  %.502 = add i32 %.498, %.501
  store i32 %.502, i32* %.315
  %.504 = load i32, i32* %.315
  %.505 = load i32*, i32** %.276
  %.506 = getelementptr inbounds i32, i32* %.505, i32 0
  %.507 = load i32, i32* %.506
  %.508 = add i32 %.504, %.507
  %.509 = load i32*, i32** %.276
  %.510 = getelementptr inbounds i32, i32* %.509, i32 1
  %.511 = load i32, i32* %.510
  %.512 = add i32 %.508, %.511
  store i32 %.512, i32* %.315
  %.514 = load i32, i32* %.315
  %.515 = load i32*, i32** %.279
  %.516 = getelementptr inbounds i32, i32* %.515, i32 0
  %.517 = load i32, i32* %.516
  %.518 = add i32 %.514, %.517
  %.519 = load i32*, i32** %.279
  %.520 = getelementptr inbounds i32, i32* %.519, i32 1
  %.521 = load i32, i32* %.520
  %.522 = add i32 %.518, %.521
  store i32 %.522, i32* %.315
  %.524 = load i32, i32* %.315
  %.525 = load i32*, i32** %.282
  %.526 = getelementptr inbounds i32, i32* %.525, i32 0
  %.527 = load i32, i32* %.526
  %.528 = add i32 %.524, %.527
  %.529 = load i32*, i32** %.282
  %.530 = getelementptr inbounds i32, i32* %.529, i32 1
  %.531 = load i32, i32* %.530
  %.532 = add i32 %.528, %.531
  store i32 %.532, i32* %.315
  %.534 = load i32, i32* %.315
  %.535 = load i32*, i32** %.285
  %.536 = getelementptr inbounds i32, i32* %.535, i32 0
  %.537 = load i32, i32* %.536
  %.538 = add i32 %.534, %.537
  %.539 = load i32*, i32** %.285
  %.540 = getelementptr inbounds i32, i32* %.539, i32 1
  %.541 = load i32, i32* %.540
  %.542 = add i32 %.538, %.541
  store i32 %.542, i32* %.315
  %.544 = load i32, i32* %.315
  %.545 = load i32*, i32** %.288
  %.546 = getelementptr inbounds i32, i32* %.545, i32 0
  %.547 = load i32, i32* %.546
  %.548 = add i32 %.544, %.547
  %.549 = load i32*, i32** %.288
  %.550 = getelementptr inbounds i32, i32* %.549, i32 1
  %.551 = load i32, i32* %.550
  %.552 = add i32 %.548, %.551
  store i32 %.552, i32* %.315
  %.554 = load i32, i32* %.315
  %.555 = load i32*, i32** %.291
  %.556 = getelementptr inbounds i32, i32* %.555, i32 0
  %.557 = load i32, i32* %.556
  %.558 = add i32 %.554, %.557
  %.559 = load i32*, i32** %.291
  %.560 = getelementptr inbounds i32, i32* %.559, i32 1
  %.561 = load i32, i32* %.560
  %.562 = add i32 %.558, %.561
  store i32 %.562, i32* %.315
  %.564 = load i32, i32* %.315
  %.565 = load i32*, i32** %.294
  %.566 = getelementptr inbounds i32, i32* %.565, i32 0
  %.567 = load i32, i32* %.566
  %.568 = add i32 %.564, %.567
  %.569 = load i32*, i32** %.294
  %.570 = getelementptr inbounds i32, i32* %.569, i32 1
  %.571 = load i32, i32* %.570
  %.572 = add i32 %.568, %.571
  store i32 %.572, i32* %.315
  %.574 = load i32, i32* %.315
  %.575 = load i32*, i32** %.297
  %.576 = getelementptr inbounds i32, i32* %.575, i32 0
  %.577 = load i32, i32* %.576
  %.578 = add i32 %.574, %.577
  %.579 = load i32*, i32** %.297
  %.580 = getelementptr inbounds i32, i32* %.579, i32 1
  %.581 = load i32, i32* %.580
  %.582 = add i32 %.578, %.581
  store i32 %.582, i32* %.315
  %.584 = load i32, i32* %.315
  %.585 = load i32*, i32** %.300
  %.586 = getelementptr inbounds i32, i32* %.585, i32 0
  %.587 = load i32, i32* %.586
  %.588 = add i32 %.584, %.587
  %.589 = load i32*, i32** %.300
  %.590 = getelementptr inbounds i32, i32* %.589, i32 1
  %.591 = load i32, i32* %.590
  %.592 = add i32 %.588, %.591
  store i32 %.592, i32* %.315
  %.594 = load i32, i32* %.315
  %.595 = load i32*, i32** %.303
  %.596 = getelementptr inbounds i32, i32* %.595, i32 0
  %.597 = load i32, i32* %.596
  %.598 = add i32 %.594, %.597
  %.599 = load i32*, i32** %.303
  %.600 = getelementptr inbounds i32, i32* %.599, i32 1
  %.601 = load i32, i32* %.600
  %.602 = add i32 %.598, %.601
  store i32 %.602, i32* %.315
  %.604 = load i32, i32* %.315
  %.605 = load i32*, i32** %.306
  %.606 = getelementptr inbounds i32, i32* %.605, i32 0
  %.607 = load i32, i32* %.606
  %.608 = add i32 %.604, %.607
  %.609 = load i32*, i32** %.306
  %.610 = getelementptr inbounds i32, i32* %.609, i32 1
  %.611 = load i32, i32* %.610
  %.612 = add i32 %.608, %.611
  store i32 %.612, i32* %.315
  %.614 = load i32, i32* %.315
  %.615 = load i32*, i32** %.309
  %.616 = getelementptr inbounds i32, i32* %.615, i32 0
  %.617 = load i32, i32* %.616
  %.618 = add i32 %.614, %.617
  %.619 = load i32*, i32** %.309
  %.620 = getelementptr inbounds i32, i32* %.619, i32 1
  %.621 = load i32, i32* %.620
  %.622 = add i32 %.618, %.621
  store i32 %.622, i32* %.315
  %.624 = load i32, i32* %.315
  %.625 = load i32*, i32** %.312
  %.626 = getelementptr inbounds i32, i32* %.625, i32 0
  %.627 = load i32, i32* %.626
  %.628 = add i32 %.624, %.627
  %.629 = load i32*, i32** %.312
  %.630 = getelementptr inbounds i32, i32* %.629, i32 1
  %.631 = load i32, i32* %.630
  %.632 = add i32 %.628, %.631
  store i32 %.632, i32* %.315
  %.634 = load i32, i32* %.315
  ret i32 %.634 
}
define i32 @param16(i32 %.639, i32 %.642, i32 %.645, i32 %.648, i32 %.651, i32 %.654, i32 %.657, i32 %.660, i32 %.663, i32 %.666, i32 %.669, i32 %.672, i32 %.675, i32 %.678, i32 %.681, i32 %.684){
.637:
  %.687 = alloca [16 x i32]
  %.683 = alloca i32
  %.680 = alloca i32
  %.677 = alloca i32
  %.674 = alloca i32
  %.671 = alloca i32
  %.668 = alloca i32
  %.665 = alloca i32
  %.662 = alloca i32
  %.659 = alloca i32
  %.656 = alloca i32
  %.653 = alloca i32
  %.650 = alloca i32
  %.647 = alloca i32
  %.644 = alloca i32
  %.641 = alloca i32
  %.638 = alloca i32
  store i32 %.639, i32* %.638
  store i32 %.642, i32* %.641
  store i32 %.645, i32* %.644
  store i32 %.648, i32* %.647
  store i32 %.651, i32* %.650
  store i32 %.654, i32* %.653
  store i32 %.657, i32* %.656
  store i32 %.660, i32* %.659
  store i32 %.663, i32* %.662
  store i32 %.666, i32* %.665
  store i32 %.669, i32* %.668
  store i32 %.672, i32* %.671
  store i32 %.675, i32* %.674
  store i32 %.678, i32* %.677
  store i32 %.681, i32* %.680
  store i32 %.684, i32* %.683
  %.689 = load i32, i32* %.638
  %.690 = load i32, i32* %.641
  %.691 = load i32, i32* %.644
  %.692 = load i32, i32* %.647
  %.693 = load i32, i32* %.650
  %.694 = load i32, i32* %.653
  %.695 = load i32, i32* %.656
  %.696 = load i32, i32* %.659
  %.697 = load i32, i32* %.662
  %.698 = load i32, i32* %.665
  %.699 = load i32, i32* %.668
  %.700 = load i32, i32* %.671
  %.701 = load i32, i32* %.674
  %.702 = load i32, i32* %.677
  %.703 = load i32, i32* %.680
  %.704 = load i32, i32* %.683
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.687, [16 x i32]* @__constant..705, i32 64, i1 false)
  %.711 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 0
  store i32 %.689, i32* %.711
  %.713 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 1
  store i32 %.690, i32* %.713
  %.715 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 2
  store i32 %.691, i32* %.715
  %.718 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 3
  store i32 %.692, i32* %.718
  %.721 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 4
  store i32 %.693, i32* %.721
  %.724 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 5
  store i32 %.694, i32* %.724
  %.727 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 6
  store i32 %.695, i32* %.727
  %.730 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 7
  store i32 %.696, i32* %.730
  %.733 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 8
  store i32 %.697, i32* %.733
  %.736 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 9
  store i32 %.698, i32* %.736
  %.739 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 10
  store i32 %.699, i32* %.739
  %.742 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 11
  store i32 %.700, i32* %.742
  %.745 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 12
  store i32 %.701, i32* %.745
  %.748 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 13
  store i32 %.702, i32* %.748
  %.751 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 14
  store i32 %.703, i32* %.751
  %.754 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 15
  store i32 %.704, i32* %.754
  %.757 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 0
  call void @sort(i32* %.757, i32 16)
  %.759 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 0
  %.760 = load i32, i32* %.759
  %.761 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 1
  %.762 = load i32, i32* %.761
  %.763 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 2
  %.764 = load i32, i32* %.763
  %.765 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 3
  %.766 = load i32, i32* %.765
  %.767 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 4
  %.768 = load i32, i32* %.767
  %.769 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 5
  %.770 = load i32, i32* %.769
  %.771 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 6
  %.772 = load i32, i32* %.771
  %.773 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 7
  %.774 = load i32, i32* %.773
  %.775 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 8
  %.776 = load i32, i32* %.775
  %.777 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 9
  %.778 = load i32, i32* %.777
  %.779 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 10
  %.780 = load i32, i32* %.779
  %.781 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 11
  %.782 = load i32, i32* %.781
  %.783 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 12
  %.784 = load i32, i32* %.783
  %.785 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 13
  %.786 = load i32, i32* %.785
  %.787 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 14
  %.788 = load i32, i32* %.787
  %.789 = getelementptr inbounds [16 x i32], [16 x i32]* %.687, i32 0, i32 15
  %.790 = load i32, i32* %.789
  %.791 = load i32, i32* %.638
  %.792 = load i32, i32* %.641
  %.793 = load i32, i32* %.644
  %.794 = load i32, i32* %.647
  %.795 = load i32, i32* %.650
  %.796 = load i32, i32* %.653
  %.797 = load i32, i32* %.656
  %.798 = load i32, i32* %.659
  %.799 = load i32, i32* %.662
  %.800 = load i32, i32* %.665
  %.801 = load i32, i32* %.668
  %.802 = load i32, i32* %.671
  %.803 = load i32, i32* %.674
  %.804 = load i32, i32* %.677
  %.805 = load i32, i32* %.680
  %.806 = load i32, i32* %.683
  %.807at81 = call i32 @param32_rec(i32 %.760, i32 %.762, i32 %.764, i32 %.766, i32 %.768, i32 %.770, i32 %.772, i32 %.774, i32 %.776, i32 %.778, i32 %.780, i32 %.782, i32 %.784, i32 %.786, i32 %.788, i32 %.790, i32 %.791, i32 %.792, i32 %.793, i32 %.794, i32 %.795, i32 %.796, i32 %.797, i32 %.798, i32 %.799, i32 %.800, i32 %.801, i32 %.802, i32 %.803, i32 %.804, i32 %.805, i32 %.806)
  ret i32 %.807at81 
}
define i32 @main(){
.810:
  %.839 = alloca i32
  %.812 = alloca [32 x [2 x i32]]
  %.816at88 = call i32 @getint()
  %.817at88 = call i32 @getint()
  %.818at88 = call i32 @getint()
  %.819at88 = call i32 @getint()
  %.820at88 = call i32 @getint()
  %.821at89 = call i32 @getint()
  %.822at89 = call i32 @getint()
  %.823at89 = call i32 @getint()
  %.824at89 = call i32 @getint()
  %.825at89 = call i32 @getint()
  %.826at90 = call i32 @getint()
  %.827at90 = call i32 @getint()
  %.828at90 = call i32 @getint()
  %.829at90 = call i32 @getint()
  %.830at90 = call i32 @getint()
  %.831at91 = call i32 @getint()
  %.832at88 = call i32 @param16(i32 %.816at88, i32 %.817at88, i32 %.818at88, i32 %.819at88, i32 %.820at88, i32 %.821at89, i32 %.822at89, i32 %.823at89, i32 %.824at89, i32 %.825at89, i32 %.826at90, i32 %.827at90, i32 %.828at90, i32 %.829at90, i32 %.830at90, i32 %.831at91)
  call void @llvm.memcpy.p0.p0.i32([32 x [2 x i32]]* %.812, [32 x [2 x i32]]* @__constant..834, i32 256, i1 false)
  %.837 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 0, i32 0
  store i32 %.832at88, i32* %.837
  store i32 1, i32* %.839
  br label %.841wc94 
.841wc94:
  %.845 = load i32, i32* %.839
  %.846 = icmp slt i32 %.845, 32
  br i1 %.846, label %.842wloop.94.98, label %.843wn98
.842wloop.94.98:
  %.848 = load i32, i32* %.839
  %.849 = sub i32 %.848, 1
  %.850 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 %.849, i32 1
  %.851 = load i32, i32* %.850
  %.852 = sub i32 %.851, 1
  %.853 = load i32, i32* %.839
  %.854 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 %.853, i32 0
  store i32 %.852, i32* %.854
  %.856 = load i32, i32* %.839
  %.857 = sub i32 %.856, 1
  %.858 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 %.857, i32 0
  %.859 = load i32, i32* %.858
  %.860 = sub i32 %.859, 2
  %.861 = load i32, i32* %.839
  %.862 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 %.861, i32 1
  store i32 %.860, i32* %.862
  %.864 = load i32, i32* %.839
  %.865 = add i32 %.864, 1
  store i32 %.865, i32* %.839
  br label %.841wc94 
.843wn98:
  %.868 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 0, i32 0
  %.869 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 1, i32 0
  %.870 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 2, i32 0
  %.871 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 3, i32 0
  %.872 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 4, i32 0
  %.873 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 5, i32 0
  %.874 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 6, i32 0
  %.875 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 7, i32 0
  %.876 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 8, i32 0
  %.877 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 9, i32 0
  %.878 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 10, i32 0
  %.879 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 11, i32 0
  %.880 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 12, i32 0
  %.881 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 13, i32 0
  %.882 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 14, i32 0
  %.883 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 15, i32 0
  %.884 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 16, i32 0
  %.886 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 17, i32 0
  %.888 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 18, i32 0
  %.890 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 19, i32 0
  %.892 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 20, i32 0
  %.894 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 21, i32 0
  %.896 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 22, i32 0
  %.898 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 23, i32 0
  %.900 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 24, i32 0
  %.902 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 25, i32 0
  %.904 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 26, i32 0
  %.906 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 27, i32 0
  %.908 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 28, i32 0
  %.910 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 29, i32 0
  %.912 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 30, i32 0
  %.914 = getelementptr inbounds [32 x [2 x i32]], [32 x [2 x i32]]* %.812, i32 0, i32 31, i32 0
  %.915at99 = call i32 @param32_arr(i32* %.868, i32* %.869, i32* %.870, i32* %.871, i32* %.872, i32* %.873, i32* %.874, i32* %.875, i32* %.876, i32* %.877, i32* %.878, i32* %.879, i32* %.880, i32* %.881, i32* %.882, i32* %.883, i32* %.884, i32* %.886, i32* %.888, i32* %.890, i32* %.892, i32* %.894, i32* %.896, i32* %.898, i32* %.900, i32* %.902, i32* %.904, i32* %.906, i32* %.908, i32* %.