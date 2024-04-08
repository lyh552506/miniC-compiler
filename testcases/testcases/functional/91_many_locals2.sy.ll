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
define i32 @main(){
.2:
  %.201 = alloca i32
  %.139 = alloca i32
  %.33 = alloca i32
  %.32 = alloca i32
  %.31 = alloca i32
  %.30 = alloca i32
  %.29 = alloca i32
  %.28 = alloca i32
  %.27 = alloca i32
  %.26 = alloca i32
  %.25 = alloca i32
  %.24 = alloca i32
  %.23 = alloca i32
  %.22 = alloca i32
  %.21 = alloca i32
  %.20 = alloca i32
  %.19 = alloca i32
  %.18 = alloca i32
  %.17 = alloca i32
  %.16 = alloca i32
  %.15 = alloca i32
  %.14 = alloca i32
  %.13 = alloca i32
  %.12 = alloca i32
  %.11 = alloca i32
  %.10 = alloca i32
  %.9 = alloca i32
  %.8 = alloca i32
  %.7 = alloca i32
  %.6 = alloca i32
  %.5 = alloca i32
  %.4 = alloca i32
  %.3 = alloca i32
  %.35at36 = call i32 @getint()
  store i32 %.35at36, i32* %.33
  br label %.37wc37 
.37wc37:
  %.41 = load i32, i32* %.33
  %.43 = icmp eq i32 %.41, 5
  br i1 %.43, label %.38wloop.37.39, label %.39wn39
.38wloop.37.39:
  %.45 = load i32, i32* %.33
  %.47 = add i32 %.45, 1
  store i32 %.47, i32* %.33
  br label %.37wc37 
.39wn39:
  store i32 0, i32* %.3
  %.52 = load i32, i32* %.3
  %.53 = add i32 %.52, 1
  store i32 %.53, i32* %.4
  %.55 = load i32, i32* %.4
  %.56 = add i32 %.55, 1
  store i32 %.56, i32* %.5
  %.58 = load i32, i32* %.5
  %.59 = add i32 %.58, 1
  store i32 %.59, i32* %.6
  %.61 = load i32, i32* %.6
  %.62 = add i32 %.61, 1
  store i32 %.62, i32* %.7
  %.64 = load i32, i32* %.7
  %.65 = add i32 %.64, 1
  store i32 %.65, i32* %.8
  %.67 = load i32, i32* %.8
  %.68 = add i32 %.67, 1
  store i32 %.68, i32* %.9
  %.70 = load i32, i32* %.9
  %.71 = add i32 %.70, 1
  store i32 %.71, i32* %.10
  %.73 = load i32, i32* %.10
  %.74 = add i32 %.73, 1
  store i32 %.74, i32* %.11
  %.76 = load i32, i32* %.11
  %.77 = add i32 %.76, 1
  store i32 %.77, i32* %.12
  %.79 = load i32, i32* %.12
  %.80 = add i32 %.79, 1
  store i32 %.80, i32* %.13
  %.82 = load i32, i32* %.13
  %.83 = add i32 %.82, 1
  store i32 %.83, i32* %.14
  %.85 = load i32, i32* %.14
  %.86 = add i32 %.85, 1
  store i32 %.86, i32* %.15
  %.88 = load i32, i32* %.15
  %.89 = add i32 %.88, 1
  store i32 %.89, i32* %.16
  %.91 = load i32, i32* %.16
  %.92 = add i32 %.91, 1
  store i32 %.92, i32* %.17
  %.94 = load i32, i32* %.17
  %.95 = add i32 %.94, 1
  store i32 %.95, i32* %.18
  %.97 = load i32, i32* %.18
  %.98 = add i32 %.97, 1
  store i32 %.98, i32* %.19
  %.100 = load i32, i32* %.19
  %.101 = add i32 %.100, 1
  store i32 %.101, i32* %.20
  %.103 = load i32, i32* %.20
  %.104 = add i32 %.103, 1
  store i32 %.104, i32* %.21
  %.106 = load i32, i32* %.21
  %.107 = add i32 %.106, 1
  store i32 %.107, i32* %.22
  %.109 = load i32, i32* %.22
  %.110 = add i32 %.109, 1
  store i32 %.110, i32* %.23
  %.112 = load i32, i32* %.23
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* %.24
  %.115 = load i32, i32* %.24
  %.116 = add i32 %.115, 1
  store i32 %.116, i32* %.25
  %.118 = load i32, i32* %.25
  %.119 = add i32 %.118, 1
  store i32 %.119, i32* %.26
  %.121 = load i32, i32* %.26
  %.122 = add i32 %.121, 1
  store i32 %.122, i32* %.27
  %.124 = load i32, i32* %.27
  %.125 = add i32 %.124, 1
  store i32 %.125, i32* %.28
  %.127 = load i32, i32* %.28
  %.128 = add i32 %.127, 1
  store i32 %.128, i32* %.29
  %.130 = load i32, i32* %.29
  %.131 = add i32 %.130, 1
  store i32 %.131, i32* %.30
  %.133 = load i32, i32* %.30
  %.134 = add i32 %.133, 1
  store i32 %.134, i32* %.31
  %.136 = load i32, i32* %.31
  %.137 = add i32 %.136, 1
  store i32 %.137, i32* %.32
  %.140 = load i32, i32* %.3
  call void @putint(i32 %.140)
  %.143 = load i32, i32* %.4
  call void @putint(i32 %.143)
  %.145 = load i32, i32* %.5
  call void @putint(i32 %.145)
  %.147 = load i32, i32* %.6
  call void @putint(i32 %.147)
  %.149 = load i32, i32* %.7
  call void @putint(i32 %.149)
  %.151 = load i32, i32* %.8
  call void @putint(i32 %.151)
  %.153 = load i32, i32* %.9
  call void @putint(i32 %.153)
  %.155 = load i32, i32* %.10
  call void @putint(i32 %.155)
  %.157 = load i32, i32* %.11
  call void @putint(i32 %.157)
  %.159 = load i32, i32* %.12
  call void @putint(i32 %.159)
  %.161 = load i32, i32* %.13
  call void @putint(i32 %.161)
  %.163 = load i32, i32* %.14
  call void @putint(i32 %.163)
  %.165 = load i32, i32* %.15
  call void @putint(i32 %.165)
  %.167 = load i32, i32* %.16
  call void @putint(i32 %.167)
  %.169 = load i32, i32* %.17
  call void @putint(i32 %.169)
  %.171 = load i32, i32* %.18
  call void @putint(i32 %.171)
  %.173 = load i32, i32* %.19
  call void @putint(i32 %.173)
  %.175 = load i32, i32* %.20
  call void @putint(i32 %.175)
  %.177 = load i32, i32* %.21
  call void @putint(i32 %.177)
  %.179 = load i32, i32* %.22
  call void @putint(i32 %.179)
  %.181 = load i32, i32* %.23
  call void @putint(i32 %.181)
  %.183 = load i32, i32* %.24
  call void @putint(i32 %.183)
  %.185 = load i32, i32* %.25
  call void @putint(i32 %.185)
  %.187 = load i32, i32* %.26
  call void @putint(i32 %.187)
  %.189 = load i32, i32* %.27
  call void @putint(i32 %.189)
  %.191 = load i32, i32* %.28
  call void @putint(i32 %.191)
  %.193 = load i32, i32* %.29
  call void @putint(i32 %.193)
  %.195 = load i32, i32* %.30
  call void @putint(i32 %.195)
  %.197 = load i32, i32* %.31
  call void @putint(i32 %.197)
  %.199 = load i32, i32* %.32
  call void @putint(i32 %.199)
  store i32 10, i32* %.201
  %.204 = load i32, i32* %.201
  call void @putch(i32 %.204)
  %.207 = load i32, i32* %.33
  call void @putint(i32 %.207)
  %.209 = load i32, i32* %.201
  call void @putch(i32 %.209)
  %.211 = load i32, i32* %.28
  ret i32 %.211 
}
@.g.n = global i32 zeroinitializer
define i32 @main(){
.2:
  %.201 = alloca i32
  %.139 = alloca i32
  %.33 = alloca i32
  %.32 = alloca i32
  %.31 = alloca i32
  %.30 = alloca i32
  %.29 = alloca i32
  %.28 = alloca i32
  %.27 = alloca i32
  %.26 = alloca i32
  %.25 = alloca i32
  %.24 = alloca i32
  %.23 = alloca i32
  %.22 = alloca i32
  %.21 = alloca i32
  %.20 = alloca i32
  %.19 = alloca i32
  %.18 = alloca i32
  %.17 = alloca i32
  %.16 = alloca i32
  %.15 = alloca i32
  %.14 = alloca i32
  %.13 = alloca i32
  %.12 = alloca i32
  %.11 = alloca i32
  %.10 = alloca i32
  %.9 = alloca i32
  %.8 = alloca i32
  %.7 = alloca i32
  %.6 = alloca i32
  %.5 = alloca i32
  %.4 = alloca i32
  %.3 = alloca i32
  %.35at36 = call i32 @getint()
  store i32 %.35at36, i32* %.33
  br label %.37wc37 
.37wc37:
  %.41 = load i32, i32* %.33
  %.43 = icmp eq i32 %.41, 5
  br i1 %.43, label %.38wloop.37.39, label %.39wn39
.38wloop.37.39:
  %.45 = load i32, i32* %.33
  %.47 = add i32 %.45, 1
  store i32 %.47, i32* %.33
  br label %.37wc37 
.39wn39:
  store i32 0, i32* %.3
  %.52 = load i32, i32* %.3
  %.53 = add i32 %.52, 1
  store i32 %.53, i32* %.4
  %.55 = load i32, i32* %.4
  %.56 = add i32 %.55, 1
  store i32 %.56, i32* %.5
  %.58 = load i32, i32* %.5
  %.59 = add i32 %.58, 1
  store i32 %.59, i32* %.6
  %.61 = load i32, i32* %.6
  %.62 = add i32 %.61, 1
  store i32 %.62, i32* %.7
  %.64 = load i32, i32* %.7
  %.65 = add i32 %.64, 1
  store i32 %.65, i32* %.8
  %.67 = load i32, i32* %.8
  %.68 = add i32 %.67, 1
  store i32 %.68, i32* %.9
  %.70 = load i32, i32* %.9
  %.71 = add i32 %.70, 1
  store i32 %.71, i32* %.10
  %.73 = load i32, i32* %.10
  %.74 = add i32 %.73, 1
  store i32 %.74, i32* %.11
  %.76 = load i32, i32* %.11
  %.77 = add i32 %.76, 1
  store i32 %.77, i32* %.12
  %.79 = load i32, i32* %.12
  %.80 = add i32 %.79, 1
  store i32 %.80, i32* %.13
  %.82 = load i32, i32* %.13
  %.83 = add i32 %.82, 1
  store i32 %.83, i32* %.14
  %.85 = load i32, i32* %.14
  %.86 = add i32 %.85, 1
  store i32 %.86, i32* %.15
  %.88 = load i32, i32* %.15
  %.89 = add i32 %.88, 1
  store i32 %.89, i32* %.16
  %.91 = load i32, i32* %.16
  %.92 = add i32 %.91, 1
  store i32 %.92, i32* %.17
  %.94 = load i32, i32* %.17
  %.95 = add i32 %.94, 1
  store i32 %.95, i32* %.18
  %.97 = load i32, i32* %.18
  %.98 = add i32 %.97, 1
  store i32 %.98, i32* %.19
  %.100 = load i32, i32* %.19
  %.101 = add i32 %.100, 1
  store i32 %.101, i32* %.20
  %.103 = load i32, i32* %.20
  %.104 = add i32 %.103, 1
  store i32 %.104, i32* %.21
  %.106 = load i32, i32* %.21
  %.107 = add i32 %.106, 1
  store i32 %.107, i32* %.22
  %.109 = load i32, i32* %.22
  %.110 = add i32 %.109, 1
  store i32 %.110, i32* %.23
  %.112 = load i32, i32* %.23
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* %.24
  %.115 = load i32, i32* %.24
  %.116 = add i32 %.115, 1
  store i32 %.116, i32* %.25
  %.118 = load i32, i32* %.25
  %.119 = add i32 %.118, 1
  store i32 %.119, i32* %.26
  %.121 = load i32, i32* %.26
  %.122 = add i32 %.121, 1
  store i32 %.122, i32* %.27
  %.124 = load i32, i32* %.27
  %.125 = add i32 %.124, 1
  store i32 %.125, i32* %.28
  %.127 = load i32, i32* %.28
  %.128 = add i32 %.127, 1
  store i32 %.128, i32* %.29
  %.130 = load i32, i32* %.29
  %.131 = add i32 %.130, 1
  store i32 %.131, i32* %.30
  %.133 = load i32, i32* %.30
  %.134 = add i32 %.133, 1
  store i32 %.134, i32* %.31
  %.136 = load i32, i32* %.31
  %.137 = add i32 %.136, 1
  store i32 %.137, i32* %.32
  %.140 = load i32, i32* %.3
  call void @putint(i32 %.140)
  %.143 = load i32, i32* %.4
  call void @putint(i32 %.143)
  %.145 = load i32, i32* %.5
  call void @putint(i32 %.145)
  %.147 = load i32, i32* %.6
  call void @putint(i32 %.147)
  %.149 = load i32, i32* %.7
  call void @putint(i32 %.149)
  %.151 = load i32, i32* %.8
  call void @putint(i32 %.151)
  %.153 = load i32, i32* %.9
  call void @putint(i32 %.153)
  %.155 = load i32, i32* %.10
  call void @putint(i32 %.155)
  %.157 = load i32, i32* %.11
  call void @putint(i32 %.157)
  %.159 = load i32, i32* %.12
  call void @putint(i32 %.159)
  %.161 = load i32, i32* %.13
  call void @putint(i32 %.161)
  %.163 = load i32, i32* %.14
  call void @putint(i32 %.163)
  %.165 = load i32, i32* %.15
  call void @putint(i32 %.165)
  %.167 = load i32, i32* %.16
  call void @putint(i32 %.167)
  %.169 = load i32, i32* %.17
  call void @putint(i32 %.169)
  %.171 = load i32, i32* %.18
  call void @putint(i32 %.171)
  %.173 = load i32, i32* %.19
  call void @putint(i32 %.173)
  %.175 = load i32, i32* %.20
  call void @putint(i32 %.175)
  %.177 = load i32, i32* %.21
  call void @putint(i32 %.177)
  %.179 = load i32, i32* %.22
  call void @putint(i32 %.179)
  %.181 = load i32, i32* %.23
  call void @putint(i32 %.181)
  %.183 = load i32, i32* %.24
  call void @putint(i32 %.183)
  %.185 = load i32, i32* %.25
  call void @putint(i32 %.185)
  %.187 = load i32, i32* %.26
  call void @putint(i32 %.187)
  %.189 = load i32, i32* %.27
  call void @putint(i32 %.189)
  %.191 = load i32, i32* %.28
  call void @putint(i32 %.191)
  %.193 = load i32, i32* %.29
  call void @putint(i32 %.193)
  %.195 = load i32, i32* %.30
  call void @putint(i32 %.