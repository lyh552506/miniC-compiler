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
@.g.a0 = global i32 zeroinitializer
@.g.a1 = global i32 zeroinitializer
@.g.a2 = global i32 zeroinitializer
@.g.a3 = global i32 zeroinitializer
@.g.a4 = global i32 zeroinitializer
@.g.a5 = global i32 zeroinitializer
@.g.a6 = global i32 zeroinitializer
@.g.a7 = global i32 zeroinitializer
@.g.a8 = global i32 zeroinitializer
@.g.a9 = global i32 zeroinitializer
@.g.a10 = global i32 zeroinitializer
@.g.a11 = global i32 zeroinitializer
@.g.a12 = global i32 zeroinitializer
@.g.a13 = global i32 zeroinitializer
@.g.a14 = global i32 zeroinitializer
@.g.a15 = global i32 zeroinitializer
@.g.a16 = global i32 zeroinitializer
@.g.a17 = global i32 zeroinitializer
@.g.a18 = global i32 zeroinitializer
@.g.a19 = global i32 zeroinitializer
@.g.a20 = global i32 zeroinitializer
@.g.a21 = global i32 zeroinitializer
@.g.a22 = global i32 zeroinitializer
@.g.a23 = global i32 zeroinitializer
@.g.a24 = global i32 zeroinitializer
@.g.a25 = global i32 zeroinitializer
@.g.a26 = global i32 zeroinitializer
@.g.a27 = global i32 zeroinitializer
@.g.a28 = global i32 zeroinitializer
@.g.a29 = global i32 zeroinitializer
@.g.a30 = global i32 zeroinitializer
@.g.a31 = global i32 zeroinitializer
@.g.a32 = global i32 zeroinitializer
@.g.a33 = global i32 zeroinitializer
@.g.a34 = global i32 zeroinitializer
@.g.a35 = global i32 zeroinitializer
@.g.a36 = global i32 zeroinitializer
@.g.a37 = global i32 zeroinitializer
@.g.a38 = global i32 zeroinitializer
@.g.a39 = global i32 zeroinitializer
define i32 @testParam8(i32 %.43, i32 %.46, i32 %.49, i32 %.52, i32 %.55, i32 %.58, i32 %.61, i32 %.64){
.41:
  %.63 = alloca i32
  %.60 = alloca i32
  %.57 = alloca i32
  %.54 = alloca i32
  %.51 = alloca i32
  %.48 = alloca i32
  %.45 = alloca i32
  %.42 = alloca i32
  store i32 %.43, i32* %.42
  store i32 %.46, i32* %.45
  store i32 %.49, i32* %.48
  store i32 %.52, i32* %.51
  store i32 %.55, i32* %.54
  store i32 %.58, i32* %.57
  store i32 %.61, i32* %.60
  store i32 %.64, i32* %.63
  %.66 = load i32, i32* %.42
  %.67 = load i32, i32* %.45
  %.68 = add i32 %.66, %.67
  %.69 = load i32, i32* %.48
  %.70 = add i32 %.68, %.69
  %.71 = load i32, i32* %.51
  %.72 = add i32 %.70, %.71
  %.73 = load i32, i32* %.54
  %.74 = add i32 %.72, %.73
  %.75 = load i32, i32* %.57
  %.76 = add i32 %.74, %.75
  %.77 = load i32, i32* %.60
  %.78 = add i32 %.76, %.77
  %.79 = load i32, i32* %.63
  %.80 = add i32 %.78, %.79
  ret i32 %.80 
}
define i32 @testParam16(i32 %.85, i32 %.88, i32 %.91, i32 %.94, i32 %.97, i32 %.100, i32 %.103, i32 %.106, i32 %.109, i32 %.112, i32 %.115, i32 %.118, i32 %.121, i32 %.124, i32 %.127, i32 %.130){
.83:
  %.129 = alloca i32
  %.126 = alloca i32
  %.123 = alloca i32
  %.120 = alloca i32
  %.117 = alloca i32
  %.114 = alloca i32
  %.111 = alloca i32
  %.108 = alloca i32
  %.105 = alloca i32
  %.102 = alloca i32
  %.99 = alloca i32
  %.96 = alloca i32
  %.93 = alloca i32
  %.90 = alloca i32
  %.87 = alloca i32
  %.84 = alloca i32
  store i32 %.85, i32* %.84
  store i32 %.88, i32* %.87
  store i32 %.91, i32* %.90
  store i32 %.94, i32* %.93
  store i32 %.97, i32* %.96
  store i32 %.100, i32* %.99
  store i32 %.103, i32* %.102
  store i32 %.106, i32* %.105
  store i32 %.109, i32* %.108
  store i32 %.112, i32* %.111
  store i32 %.115, i32* %.114
  store i32 %.118, i32* %.117
  store i32 %.121, i32* %.120
  store i32 %.124, i32* %.123
  store i32 %.127, i32* %.126
  store i32 %.130, i32* %.129
  %.132 = load i32, i32* %.84
  %.133 = load i32, i32* %.87
  %.134 = add i32 %.132, %.133
  %.135 = load i32, i32* %.90
  %.136 = add i32 %.134, %.135
  %.137 = load i32, i32* %.93
  %.138 = sub i32 %.136, %.137
  %.139 = load i32, i32* %.96
  %.140 = sub i32 %.138, %.139
  %.141 = load i32, i32* %.99
  %.142 = sub i32 %.140, %.141
  %.143 = load i32, i32* %.102
  %.144 = sub i32 %.142, %.143
  %.145 = load i32, i32* %.105
  %.146 = sub i32 %.144, %.145
  %.147 = load i32, i32* %.108
  %.148 = add i32 %.146, %.147
  %.149 = load i32, i32* %.111
  %.150 = add i32 %.148, %.149
  %.151 = load i32, i32* %.114
  %.152 = add i32 %.150, %.151
  %.153 = load i32, i32* %.117
  %.154 = add i32 %.152, %.153
  %.155 = load i32, i32* %.120
  %.156 = add i32 %.154, %.155
  %.157 = load i32, i32* %.123
  %.158 = add i32 %.156, %.157
  %.159 = load i32, i32* %.126
  %.160 = add i32 %.158, %.159
  %.161 = load i32, i32* %.129
  %.162 = add i32 %.160, %.161
  ret i32 %.162 
}
define i32 @testParam32(i32 %.167, i32 %.170, i32 %.173, i32 %.176, i32 %.179, i32 %.182, i32 %.185, i32 %.188, i32 %.191, i32 %.194, i32 %.197, i32 %.200, i32 %.203, i32 %.206, i32 %.209, i32 %.212, i32 %.215, i32 %.218, i32 %.221, i32 %.224, i32 %.227, i32 %.230, i32 %.233, i32 %.236, i32 %.239, i32 %.242, i32 %.245, i32 %.248, i32 %.251, i32 %.254, i32 %.257, i32 %.260){
.165:
  %.259 = alloca i32
  %.256 = alloca i32
  %.253 = alloca i32
  %.250 = alloca i32
  %.247 = alloca i32
  %.244 = alloca i32
  %.241 = alloca i32
  %.238 = alloca i32
  %.235 = alloca i32
  %.232 = alloca i32
  %.229 = alloca i32
  %.226 = alloca i32
  %.223 = alloca i32
  %.220 = alloca i32
  %.217 = alloca i32
  %.214 = alloca i32
  %.211 = alloca i32
  %.208 = alloca i32
  %.205 = alloca i32
  %.202 = alloca i32
  %.199 = alloca i32
  %.196 = alloca i32
  %.193 = alloca i32
  %.190 = alloca i32
  %.187 = alloca i32
  %.184 = alloca i32
  %.181 = alloca i32
  %.178 = alloca i32
  %.175 = alloca i32
  %.172 = alloca i32
  %.169 = alloca i32
  %.166 = alloca i32
  store i32 %.167, i32* %.166
  store i32 %.170, i32* %.169
  store i32 %.173, i32* %.172
  store i32 %.176, i32* %.175
  store i32 %.179, i32* %.178
  store i32 %.182, i32* %.181
  store i32 %.185, i32* %.184
  store i32 %.188, i32* %.187
  store i32 %.191, i32* %.190
  store i32 %.194, i32* %.193
  store i32 %.197, i32* %.196
  store i32 %.200, i32* %.199
  store i32 %.203, i32* %.202
  store i32 %.206, i32* %.205
  store i32 %.209, i32* %.208
  store i32 %.212, i32* %.211
  store i32 %.215, i32* %.214
  store i32 %.218, i32* %.217
  store i32 %.221, i32* %.220
  store i32 %.224, i32* %.223
  store i32 %.227, i32* %.226
  store i32 %.230, i32* %.229
  store i32 %.233, i32* %.232
  store i32 %.236, i32* %.235
  store i32 %.239, i32* %.238
  store i32 %.242, i32* %.241
  store i32 %.245, i32* %.244
  store i32 %.248, i32* %.247
  store i32 %.251, i32* %.250
  store i32 %.254, i32* %.253
  store i32 %.257, i32* %.256
  store i32 %.260, i32* %.259
  %.262 = load i32, i32* %.166
  %.263 = load i32, i32* %.169
  %.264 = add i32 %.262, %.263
  %.265 = load i32, i32* %.172
  %.266 = add i32 %.264, %.265
  %.267 = load i32, i32* %.175
  %.268 = add i32 %.266, %.267
  %.269 = load i32, i32* %.178
  %.270 = add i32 %.268, %.269
  %.271 = load i32, i32* %.181
  %.272 = add i32 %.270, %.271
  %.273 = load i32, i32* %.184
  %.274 = add i32 %.272, %.273
  %.275 = load i32, i32* %.187
  %.276 = add i32 %.274, %.275
  %.277 = load i32, i32* %.190
  %.278 = add i32 %.276, %.277
  %.279 = load i32, i32* %.193
  %.280 = add i32 %.278, %.279
  %.281 = load i32, i32* %.196
  %.282 = add i32 %.280, %.281
  %.283 = load i32, i32* %.199
  %.284 = add i32 %.282, %.283
  %.285 = load i32, i32* %.202
  %.286 = add i32 %.284, %.285
  %.287 = load i32, i32* %.205
  %.288 = add i32 %.286, %.287
  %.289 = load i32, i32* %.208
  %.290 = add i32 %.288, %.289
  %.291 = load i32, i32* %.211
  %.292 = add i32 %.290, %.291
  %.293 = load i32, i32* %.214
  %.294 = add i32 %.292, %.293
  %.295 = load i32, i32* %.217
  %.296 = add i32 %.294, %.295
  %.297 = load i32, i32* %.220
  %.298 = sub i32 %.296, %.297
  %.299 = load i32, i32* %.223
  %.300 = sub i32 %.298, %.299
  %.301 = load i32, i32* %.226
  %.302 = sub i32 %.300, %.301
  %.303 = load i32, i32* %.229
  %.304 = sub i32 %.302, %.303
  %.305 = load i32, i32* %.232
  %.306 = sub i32 %.304, %.305
  %.307 = load i32, i32* %.235
  %.308 = add i32 %.306, %.307
  %.309 = load i32, i32* %.238
  %.310 = add i32 %.308, %.309
  %.311 = load i32, i32* %.241
  %.312 = add i32 %.310, %.311
  %.313 = load i32, i32* %.244
  %.314 = add i32 %.312, %.313
  %.315 = load i32, i32* %.247
  %.316 = add i32 %.314, %.315
  %.317 = load i32, i32* %.250
  %.318 = add i32 %.316, %.317
  %.319 = load i32, i32* %.253
  %.320 = add i32 %.318, %.319
  %.321 = load i32, i32* %.256
  %.322 = add i32 %.320, %.321
  %.323 = load i32, i32* %.259
  %.324 = add i32 %.322, %.323
  ret i32 %.324 
}
define i32 @main(){
.327:
  store i32 0, i32* @.g.a0
  store i32 1, i32* @.g.a1
  store i32 2, i32* @.g.a2
  store i32 3, i32* @.g.a3
  store i32 4, i32* @.g.a4
  store i32 5, i32* @.g.a5
  store i32 6, i32* @.g.a6
  store i32 7, i32* @.g.a7
  store i32 8, i32* @.g.a8
  store i32 9, i32* @.g.a9
  store i32 0, i32* @.g.a10
  store i32 1, i32* @.g.a11
  store i32 2, i32* @.g.a12
  store i32 3, i32* @.g.a13
  store i32 4, i32* @.g.a14
  store i32 5, i32* @.g.a15
  store i32 6, i32* @.g.a16
  store i32 7, i32* @.g.a17
  store i32 8, i32* @.g.a18
  store i32 9, i32* @.g.a19
  store i32 0, i32* @.g.a20
  store i32 1, i32* @.g.a21
  store i32 2, i32* @.g.a22
  store i32 3, i32* @.g.a23
  store i32 4, i32* @.g.a24
  store i32 5, i32* @.g.a25
  store i32 6, i32* @.g.a26
  store i32 7, i32* @.g.a27
  store i32 8, i32* @.g.a28
  store i32 9, i32* @.g.a29
  store i32 0, i32* @.g.a30
  store i32 1, i32* @.g.a31
  store i32 4, i32* @.g.a32
  store i32 5, i32* @.g.a33
  store i32 6, i32* @.g.a34
  store i32 7, i32* @.g.a35
  store i32 8, i32* @.g.a36
  store i32 9, i32* @.g.a37
  store i32 0, i32* @.g.a38
  store i32 1, i32* @.g.a39
  %.378 = load i32, i32* @.g.a0
  %.379 = load i32, i32* @.g.a1
  %.380 = load i32, i32* @.g.a2
  %.381 = load i32, i32* @.g.a3
  %.382 = load i32, i32* @.g.a4
  %.383 = load i32, i32* @.g.a5
  %.384 = load i32, i32* @.g.a6
  %.385 = load i32, i32* @.g.a7
  %.386at115 = call i32 @testParam8(i32 %.378, i32 %.379, i32 %.380, i32 %.381, i32 %.382, i32 %.383, i32 %.384, i32 %.385)
  store i32 %.386at115, i32* @.g.a0
  %.388 = load i32, i32* @.g.a0
  call void @putint(i32 %.388)
  %.391 = load i32, i32* @.g.a32
  %.392 = load i32, i32* @.g.a33
  %.393 = load i32, i32* @.g.a34
  %.394 = load i32, i32* @.g.a35
  %.395 = load i32, i32* @.g.a36
  %.396 = load i32, i32* @.g.a37
  %.397 = load i32, i32* @.g.a38
  %.398 = load i32, i32* @.g.a39
  %.399 = load i32, i32* @.g.a8
  %.400 = load i32, i32* @.g.a9
  %.401 = load i32, i32* @.g.a10
  %.402 = load i32, i32* @.g.a11
  %.403 = load i32, i32* @.g.a12
  %.404 = load i32, i32* @.g.a13
  %.405 = load i32, i32* @.g.a14
  %.406 = load i32, i32* @.g.a15
  %.407at117 = call i32 @testParam16(i32 %.391, i32 %.392, i32 %.393, i32 %.394, i32 %.395, i32 %.396, i32 %.397, i32 %.398, i32 %.399, i32 %.400, i32 %.401, i32 %.402, i32 %.403, i32 %.404, i32 %.405, i32 %.406)
  store i32 %.407at117, i32* @.g.a0
  %.409 = load i32, i32* @.g.a0
  call void @putint(i32 %.409)
  %.411 = load i32, i32* @.g.a0
  %.412 = load i32, i32* @.g.a1
  %.413 = load i32, i32* @.g.a2
  %.414 = load i32, i32* @.g.a3
  %.415 = load i32, i32* @.g.a4
  %.416 = load i32, i32* @.g.a5
  %.417 = load i32, i32* @.g.a6
  %.418 = load i32, i32* @.g.a7
  %.419 = load i32, i32* @.g.a8
  %.420 = load i32, i32* @.g.a9
  %.421 = load i32, i32* @.g.a10
  %.422 = load i32, i32* @.g.a11
  %.423 = load i32, i32* @.g.a12
  %.424 = load i32, i32* @.g.a13
  %.425 = load i32, i32* @.g.a14
  %.426 = load i32, i32* @.g.a15
  %.427 = load i32, i32* @.g.a16
  %.428 = load i32, i32* @.g.a17
  %.429 = load i32, i32* @.g.a18
  %.430 = load i32, i32* @.g.a19
  %.431 = load i32, i32* @.g.a20
  %.432 = load i32, i32* @.g.a21
  %.433 = load i32, i32* @.g.a22
  %.434 = load i32, i32* @.g.a23
  %.435 = load i32, i32* @.g.a24
  %.436 = load i32, i32* @.g.a25
  %.437 = load i32, i32* @.g.a26
  %.438 = load i32, i32* @.g.a27
  %.439 = load i32, i32* @.g.a28
  %.440 = load i32, i32* @.g.a29
  %.441 = load i32, i32* @.g.a30
  %.442 = load i32, i32* @.g.a31
  %.443at122 = call i32 @testParam32(i32 %.411, i32 %.412, i32 %.413, i32 %.414, i32 %.415, i32 %.416, i32 %.417, i32 %.418, i32 %.419, i32 %.420, i32 %.421, i32 %.422, i32 %.423, i32 %.424, i32 %.425, i32 %.426, i32 %.427, i32 %.428, i32 %.429, i32 %.430, i32 %.431, i32 %.432, i32 %.433, i32 %.434, i32 %.435, i32 %.436, i32 %.437, i32 %.438, i32 %.439, i32 %.440, i32 %.441, i32 %.442)
  store i32 %.443at122, i32* @.g.a0
  %.445 = load i32, i32* @.g.a0
  call void @putint(i32 %.445)
  ret i32 0 
}
@.g.a0 = global i32 zeroinitializer
@.g.a1 = global i32 zeroinitializer
@.g.a2 = global i32 zeroinitializer
@.g.a3 = global i32 zeroinitializer
@.g.a4 = global i32 zeroinitializer
@.g.a5 = global i32 zeroinitializer
@.g.a6 = global i32 zeroinitializer
@.g.a7 = global i32 zeroinitializer
@.g.a8 = global i32 zeroinitializer
@.g.a9 = global i32 zeroinitializer
@.g.a10 = global i32 zeroinitializer
@.g.a11 = global i32 zeroinitializer
@.g.a12 = global i32 zeroinitializer
@.g.a13 = global i32 zeroinitializer
@.g.a14 = global i32 zeroinitializer
@.g.a15 = global i32 zeroinitializer
@.g.a16 = global i32 zeroinitializer
@.g.a17 = global i32 zeroinitializer
@.g.a18 = global i32 zeroinitializer
@.g.a19 = global i32 zeroinitializer
@.g.a20 = global i32 zeroinitializer
@.g.a21 = global i32 zeroinitializer
@.g.a22 = global i32 zeroinitializer
@.g.a23 = global i32 zeroinitializer
@.g.a24 = global i32 zeroinitializer
@.g.a25 = global i32 zeroinitializer
@.g.a26 = global i32 zeroinitializer
@.g.a27 = global i32 zeroinitializer
@.g.a28 = global i32 zeroinitializer
@.g.a29 = global i32 zeroinitializer
@.g.a30 = global i32 zeroinitializer
@.g.a31 = global i32 zeroinitializer
@.g.a32 = global i32 zeroinitializer
@.g.a33 = global i32 zeroinitializer
@.g.a34 = global i32 zeroinitializer
@.g.a35 = global i32 zeroinitializer
@.g.a36 = global i32 zeroinitializer
@.g.a37 = global i32 zeroinitializer
@.g.a38 = global i32 zeroinitializer
@.g.a39 = global i32 zeroinitializer
define i32 @testParam8(i32 %.43, i32 %.46, i32 %.49, i32 %.52, i32 %.55, i32 %.58, i32 %.61, i32 %.64){
.41:
  %.63 = alloca i32
  %.60 = alloca i32
  %.57 = alloca i32
  %.54 = alloca i32
  %.51 = alloca i32
  %.48 = alloca i32
  %.45 = alloca i32
  %.42 = alloca i32
  store i32 %.43, i32* %.42
  store i32 %.46, i32* %.45
  store i32 %.49, i32* %.48
  store i32 %.52, i32* %.51
  store i32 %.55, i32* %.54
  store i32 %.58, i32* %.57
  store i32 %.61, i32* %.60
  store i32 %.64, i32* %.63
  %.66 = load i32, i32* %.42
  %.67 = load i32, i32* %.45
  %.68 = add i32 %.66, %.67
  %.69 = load i32, i32* %.48
  %.70 = add i32 %.68, %.69
  %.71 = load i32, i32* %.51
  %.72 = add i32 %.70, %.71
  %.73 = load i32, i32* %.54
  %.74 = add i32 %.72, %.73
  %.75 = load i32, i32* %.57
  %.76 = add i32 %.74, %.75
  %.77 = load i32, i32* %.60
  %.78 = add i32 %.76, %.77
  %.79 = load i32, i32* %.63
  %.80 = add i32 %.78, %.79
  ret i32 %.80 
}
define i32 @testParam16(i32 %.85, i32 %.88, i32 %.91, i32 %.94, i32 %.97, i32 %.100, i32 %.103, i32 %.106, i32 %.109, i32 %.112, i32 %.115, i32 %.118, i32 %.121, i32 %.124, i32 %.127, i32 %.130){
.83:
  %.129 = alloca i32
  %.126 = alloca i32
  %.123 = alloca i32
  %.120 = alloca i32
  %.117 = alloca i32
  %.114 = alloca i32
  %.111 = alloca i32
  %.108 = alloca i32
  %.105 = alloca i32
  %.102 = alloca i32
  %.99 = alloca i32
  %.96 = alloca i32
  %.93 = alloca i32
  %.90 = alloca i32
  %.87 = alloca i32
  %.84 = alloca i32
  store i32 %.85, i32* %.84
  store i32 %.88, i32* %.87
  store i32 %.91, i32* %.90
  store i32 %.94, i32* %.93
  store i32 %.97, i32* %.96
  store i32 %.100, i32* %.99
  store i32 %.103, i32* %.102
  store i32 %.106, i32* %.105
  store i32 %.109, i32* %.108
  store i32 %.112, i32* %.111
  store i32 %.115, i32* %.114
  store i32 %.118, i32* %.117
  store i32 %.121, i32* %.120
  store i32 %.124, i32* %.123
  store i32 %.127, i32* %.126
  store i32 %.130, i32* %.129
  %.132 = load i32, i32* %.84
  %.133 = load i32, i32* %.87
  %.134 = add i32 %.132, %.133
  %.135 = load i32, i32* %.90
  %.136 = add i32 %.134, %.135
  %.137 = load i32, i32* %.93
  %.138 = sub i32 %.136, %.137
  %.139 = load i32, i32* %.96
  %.140 = sub i32 %.138, %.139
  %.141 = load i32, i32* %.99
  %.142 = sub i32 %.140, %.141
  %.143 = load i32, i32* %.102
  %.144 = sub i32 %.142, %.143
  %.145 = load i32, i32* %.105
  %.146 = sub i32 %.144, %.145
  %.147 = load i32, i32* %.108
  %.148 = add i32 %.146, %.147
  %.149 = load i32, i32* %.111
  %.150 = add i32 %.148, %.149
  %.151 = load i32, i32* %.114
  %.152 = add i32 %.150, %.151
  %.153 = load i32, i32* %.117
  %.154 = add i32 %.152, %.153
  %.155 = load i32, i32* %.120
  %.156 = add i32 %.154, %.155
  %.157 = load i32, i32* %.123
  %.158 = add i32 %.156, %.157
  %.159 = load i32, i32* %.126
  %.160 = add i32 %.158, %.159
  %.161 = load i32, i32* %.129
  %.162 = add i32 %.160, %.161
  ret i32 %.162 
}
define i32 @testParam32(i32 %.167, i32 %.170, i32 %.173, i32 %.176, i32 %.179, i32 %.182, i32 %.185, i32 %.188, i32 %.191, i32 %.194, i32 %.197, i32 %.200, i32 %.203, i32 %.206, i32 %.209, i32 %.212, i32 %.215, i32 %.218, i32 %.221, i32 %.224, i32 %.227, i32 %.230, i32 %.233, i32 %.236, i32 %.239, i32 %.242, i32 %.245, i32 %.248, i32 %.251, i32 %.254, i32 %.257, i32 %.260){
.165:
  %.259 = alloca i32
  %.256 = alloca i32
  %.253 = alloca i32
  %.250 = alloca i32
  %.247 = alloca i32
  %.244 = alloca i32
  %.241 = alloca i32
  %.238 = alloca i32
  %.235 = alloca i32
  %.232 = alloca i32
  %.229 = alloca i32
  %.226 = alloca i32
  %.223 = alloca i32
  %.220 = alloca i32
  %.217 = alloca i32
  %.214 = alloca i32
  %.211 = alloca i32
  %.208 = alloca i32
  %.205 = alloca i32
  %.202 = alloca i32
  %.199 = alloca i32
  %.196 = alloca i32
  %.193 = alloca i32
  %.190 = alloca i32
  %.187 = alloca i32
  %.184 = alloca i32
  %.181 = alloca i32
  %.178 = alloca i32
  %.175 = alloca i32
  %.172 = alloca i32
  %.169 = alloca i32
  %.166 = alloca i32
  store i32 %.167, i32* %.166
  store i32 %.170, i32* %.169
  store i32 %.173, i32* %.172
  store i32 %.176, i32* %.175
  store i32 %.179, i32* %.178
  store i32 %.182, i32* %.181
  store i32 %.185, i32* %.184
  store i32 %.188, i32* %.187
  store i32 %.191, i32* %.190
  store i32 %.194, i32* %.193
  store i32 %.197, i32* %.196
  store i32 %.200, i32* %.199
  store i32 %.203, i32* %.202
  store i32 %.206, i32* %.205
  store i32 %.209, i32* %.208
  store i32 %.212, i32* %.211
  store i32 %.215, i32* %.214
  store i32 %.218, i32* %.217
  store i32 %.221, i32* %.220
  store i32 %.224, i32* %.223
  store i32 %.227, i32* %.226
  store i32 %.230, i32* %.229
  store i32 %.233, i32* %.232
  store i32 %.236, i32* %.235
  store i32 %.239, i32* %.238
  store i32 %.242, i32* %.241
  store i32 %.245, i32* %.244
  store i32 %.248, i32* %.247
  store i32 %.251, i32* %.250
  store i32 %.254, i32* %.253
  store i32 %.257, i32* %.256
  store i32 %.260, i32* %.259
  %.262 = load i32, i32* %.166
  %.263 = load i32, i32* %.169
  %.264 = add i32 %.262, %.263
  %.265 = load i32, i32* %.172
  %.266 = add i32 %.264, %.265
  %.267 = load i32, i32* %.175
  %.268 = add i32 %.266, %.267
  %.269 = load i32, i32* %.178
  %.270 = add i32 %.268, %.269
  %.271 = load i32, i32* %.181
  %.272 = add i32 %.270, %.271
  %.273 = load i32, i32* %.184
  %.274 = add i32 %.272, %.273
  %.275 = load i32, i32* %.187
  %.276 = add i32 %.274, %.275
  %.277 = load i32, i32* %.190
  %.278 = add i32 %.276, %.277
  %.279 = load i32, i32* %.193
  %.280 = add i32 %.278, %.279
  %.281 = load i32, i32* %.196
  %.282 = add i32 %.280, %.281
  %.283 = load i32, i32* %.199
  %.284 = add i32 %.282, %.283
  %.285 = load i32, i32* %.202
  %.286 = add i32 %.284, %.285
  %.287 = load i32, i32* %.205
  %.288 = add i32 %.286, %.287
  %.289 = load i32, i32* %.208
  %.290 = add i32 %.288, %.289
  %.291 = load i32, i32* %.211
  %.292 = add i32 %.290, %.291
  %.293 = load i32, i32* %.214
  %.294 = add i32 %.292, %.293
  %.295 = load i32, i32* %.217
  %.296 = add i32 %.294, %.295
  %.297 = load i32, i32* %.220
  %.298 = sub i32 %.296, %.297
  %.299 = load i32, i32* %.223
  %.300 = sub i32 %.298, %.299
  %.301 = load i32, i32* %.226
  %.302 = sub i32 %.300, %.301
  %.303 = load i32, i32* %.229
  %.304 = sub i32 %.302, %.303
  %.305 = load i32, i32* %.232
  %.306 = sub i32 %.304, %.305
  %.307 = load i32, i32* %.235
  %.308 = add i32 %.306, %.307
  %.309 = load i32, i32* %.238
  %.310 = add i32 %.308, %.309
  %.311 = load i32, i32* %.241
  %.312 = add i32 %.310, %.311
  %.313 = load i32, i32* %.244
  %.314 = add i32 %.312, %.313
  %.315 = load i32, i32* %.247
  %.316 = add i32 %.314, %.315
  %.317 = load i32, i32* %.250
  %.318 = add i32 %.316, %.317
  %.319 = load i32, i32* %.253
  %.320 = add i32 %.318, %.319
  %.321 = load i32, i32* %.256
  %.322 = add i32 %.320, %.321
  %.323 = load i32, i32* %.259
  %.324 = add i32 %.322, %.323
  ret i32 %.324 
}
define i32 @main(){
.327:
  store i32 0, i32* @.g.a0
  store i32 1, i32* @.g.a1
  store i32 2, i32* @.g.a2
  store i32 3, i32* @.g.a3
  store i32 4, i32* @.g.a4
  store i32 5, i32* @.g.a5
  store i32 6, i32* @.g.a6
  store i32 7, i32* @.g.a7
  store i32 8, i32* @.g.a8
  store i32 9, i32* @.g.a9
  store i32 0, i32* @.g.a10
  store i32 1, i32* @.g.a11
  store i32 2, i32* @.g.a12
  store i32 3, i32* @.g.a13
  store i32 4, i32* @.g.a14
  store i32 5, i32* @.g.a15
  store i32 6, i32* @.g.a16
  store i32 7, i32* @.g.a17
  store i32 8, i32* @.g.a18
  store i32 9, i32* @.g.a19
  store i32 0, i32* @.g.a20
  store i32 1, i32* @.g.a21
  store i32 2, i32* @.g.a22
  store i32 3, i32* @.g.a23
  store i32 4, i32* @.g.a24
  store i32 5, i32* @.g.a25
  store i32 6, i32* @.g.a26
  store i32 7, i32* @.g.a27
  store i32 8, i32* @.g.a28
  store i32 9, i32* @.g.a29
  store i32 0, i32* @.g.a30
  store i32 1, i32* @.g.a31
  store i32 4, i32* @.g.a32
  store i32 5, i32* @.g.a33
  store i32 6, i32* @.g.a34
  store i32 7, i32* @.g.a35
  store i32 8, i32* @.g.a36
  store i32 9, i32* @.g.a37
  store i32 0, i32* @.g.a38
  store i32 1, i32* @.g.a39
  %.378 = load i32, i32* @.g.a0
  %.379 = load i32, i32* @.g.a1
  %.380 = load i32, i32* @.g.a2
  %.381 = load i32, i32* @.g.a3
  %.382 = load i32, i32* @.g.a4
  %.383 = load i32, i32* @.g.a5
  %.384 = load i32, i32* @.g.a6
  %.385 = load i32, i32* @.g.a7
  %.386at115 = call i32 @testParam8(i32 %.378, i32 %.379, i32 %.380, i32 %.381, i32 %.382, i32 %.383, i32 %.384, i32 %.385)
  store i32 %.386at115, i32* @.g.a0
  %.388 = load i32, i32* @.g.a0
  call void @putint(i32 %.388)
  %.391 = load i32, i32* @.g.a32
  %.392 = load i32, i32* @.g.a33
  %.393 = load i32, i32* @.g.a34
  %.394 = load i32, i32* @.g.a35
  %.395 = load i32, i32* @.g.a36
  %.396 = load i32, i32* @.g.a37
  %.397 = load i32, i32* @.g.a38
  %.398 = load i32, i32* @.g.a39
  %.399 = load i32, i32* @.g.a8
  %.400 = load i32, i32* @.g.a9
  %.401 = load i32, i32* @.g.a10
  %.402 = load i32, i32* @.g.a11
  %.403 = load i32, i32* @.g.a12
  %.404 = load i32, i32* @.g.a13
  %.405 = load i32, i32* @.g.a14
  %.406 = load i32, i32* @.g.a15
  %.407at117 = call i32 @testParam16(i32 %.391, i32 %.392, i32 %.393, i32 %.394, i32 %.395, i32 %.396, i32 %.397, i32 %.398, i32 %.399, i32 %.400, i32 %.401, i32 %.402, i32 %.403, i32 %.404, i32 %.405, i32 %.406)
  store i32 %.407at117, i32* @.g.a0
  %.409 = load i32, i32* @.g.a0
  call void @putint(i32 %.409)
  %.411 = load i32, i32* @.g.a0
  %.412 = load i32, i32* @.g.a1
  %.413 = load i32, i32* @.g.a2
  %.414 = load i32, i32* @.g.a3
  %.415 = load i32, i32* @.g.a4
  %.416 = load i32, i32* @.g.a5
  %.417 = load i32, i32* @.g.a6
  %.418 = load i32, i32* @.g.a7
  %.419 = load i32, i32* @.g.a8
  %.420 = load i32, i32* @.g.a9
  %.421 = load i32, i32* @.g.a10
  %.422 = load i32, i32* @.g.a11
  %.423 = load i32, i32* @.g.a12
  %.424 = load i32, i32* @.g.a13
  %.425 = load i32, i32* @.g.a14
  %.426 = load i32, i32* @.g.a15
  %.427 = load i32, i32* @.g.a16
  %.428 = load i32, i32* @.g.a17
  %.429 = load i32, i32* @.g.a18
  %.430 = load i32, i32* @.g.a19
  %.431 = load i32, i32* @.g.a20
  %.432 = load i32, i32* @.g.a21
  %.433 = load i32, i32* @.g.a22
  %.434 = load i32, i32* @.g.a23
  %.435 = load i32, i32* @.g.a24
  %.436 = load i32, i32* @.g.a25
  %.437 = load i32, i32* @.g.a26
  %.438 = load i32, i32* @.g.a27
  %.439 = load i32, i32* @.g.a28
  %.440 = load i32, i32* @.g.a29
  %.441 = load i32, i32* @.g.a30
  %.442 = load i32, i32* @.g.a31
  %.443at122 = call i32 @testParam32(i32 %.411, i32 %.412, i32 %.413, i32 %.414, i32 %.415, i32 %.416, i32 %.417, i32 %.418, i32 %.419, i32 %.420, i32 %.421, i32 %.422, i32 %.423, i32 %.424, i32 %.425, i32 %.426, i32 %.427, i32 %.428, i32 %.429, i32 %.430, i32 %.431, i32 %.432, i32 %.433, i32 %.434, i32 %.435, i32 %.436, i32 %.437, i