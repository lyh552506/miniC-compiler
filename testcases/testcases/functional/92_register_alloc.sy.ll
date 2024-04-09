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
@.g.a1 = global i32 1
@.g.a2 = global i32 2
@.g.a3 = global i32 3
@.g.a4 = global i32 4
@.g.a5 = global i32 5
@.g.a6 = global i32 6
@.g.a7 = global i32 7
@.g.a8 = global i32 8
@.g.a9 = global i32 9
@.g.a10 = global i32 10
@.g.a11 = global i32 11
@.g.a12 = global i32 12
@.g.a13 = global i32 13
@.g.a14 = global i32 14
@.g.a15 = global i32 15
@.g.a16 = global i32 16
@.g.a17 = global i32 1
@.g.a18 = global i32 2
@.g.a19 = global i32 3
@.g.a20 = global i32 4
@.g.a21 = global i32 5
@.g.a22 = global i32 6
@.g.a23 = global i32 7
@.g.a24 = global i32 8
@.g.a25 = global i32 9
@.g.a26 = global i32 10
@.g.a27 = global i32 11
@.g.a28 = global i32 12
@.g.a29 = global i32 13
@.g.a30 = global i32 14
@.g.a31 = global i32 15
@.g.a32 = global i32 16
define i32 @func(i32 %.51, i32 %.54){
.49:
  %.96 = alloca i32
  %.95 = alloca i32
  %.94 = alloca i32
  %.93 = alloca i32
  %.92 = alloca i32
  %.91 = alloca i32
  %.90 = alloca i32
  %.89 = alloca i32
  %.88 = alloca i32
  %.87 = alloca i32
  %.86 = alloca i32
  %.85 = alloca i32
  %.84 = alloca i32
  %.83 = alloca i32
  %.82 = alloca i32
  %.81 = alloca i32
  %.80 = alloca i32
  %.79 = alloca i32
  %.78 = alloca i32
  %.77 = alloca i32
  %.76 = alloca i32
  %.75 = alloca i32
  %.74 = alloca i32
  %.73 = alloca i32
  %.72 = alloca i32
  %.71 = alloca i32
  %.70 = alloca i32
  %.69 = alloca i32
  %.68 = alloca i32
  %.67 = alloca i32
  %.66 = alloca i32
  %.65 = alloca i32
  %.64 = alloca i32
  %.63 = alloca i32
  %.62 = alloca i32
  %.61 = alloca i32
  %.56 = alloca i32
  %.53 = alloca i32
  %.50 = alloca i32
  store i32 %.51, i32* %.50
  store i32 %.54, i32* %.53
  %.57 = load i32, i32* %.50
  %.58 = load i32, i32* %.53
  %.59 = add i32 %.57, %.58
  store i32 %.59, i32* %.56
  %.98at47 = call i32 @getint()
  store i32 %.98at47, i32* %.61
  %.100at47 = call i32 @getint()
  store i32 %.100at47, i32* %.62
  %.102at47 = call i32 @getint()
  store i32 %.102at47, i32* %.63
  %.104at47 = call i32 @getint()
  store i32 %.104at47, i32* %.64
  %.106 = load i32, i32* %.61
  %.107 = add i32 1, %.106
  %.108 = load i32, i32* @.g.a1
  %.109 = add i32 %.107, %.108
  store i32 %.109, i32* %.65
  %.111 = load i32, i32* %.62
  %.112 = add i32 2, %.111
  %.113 = load i32, i32* @.g.a2
  %.114 = add i32 %.112, %.113
  store i32 %.114, i32* %.66
  %.116 = load i32, i32* %.63
  %.117 = add i32 3, %.116
  %.118 = load i32, i32* @.g.a3
  %.119 = add i32 %.117, %.118
  store i32 %.119, i32* %.67
  %.121 = load i32, i32* %.64
  %.122 = add i32 4, %.121
  %.123 = load i32, i32* @.g.a4
  %.124 = add i32 %.122, %.123
  store i32 %.124, i32* %.68
  %.126 = load i32, i32* %.65
  %.127 = add i32 1, %.126
  %.128 = load i32, i32* @.g.a5
  %.129 = add i32 %.127, %.128
  store i32 %.129, i32* %.69
  %.131 = load i32, i32* %.66
  %.132 = add i32 2, %.131
  %.133 = load i32, i32* @.g.a6
  %.134 = add i32 %.132, %.133
  store i32 %.134, i32* %.70
  %.136 = load i32, i32* %.67
  %.137 = add i32 3, %.136
  %.138 = load i32, i32* @.g.a7
  %.139 = add i32 %.137, %.138
  store i32 %.139, i32* %.71
  %.141 = load i32, i32* %.68
  %.142 = add i32 4, %.141
  %.143 = load i32, i32* @.g.a8
  %.144 = add i32 %.142, %.143
  store i32 %.144, i32* %.72
  %.146 = load i32, i32* %.69
  %.147 = add i32 1, %.146
  %.148 = load i32, i32* @.g.a9
  %.149 = add i32 %.147, %.148
  store i32 %.149, i32* %.73
  %.151 = load i32, i32* %.70
  %.152 = add i32 2, %.151
  %.153 = load i32, i32* @.g.a10
  %.154 = add i32 %.152, %.153
  store i32 %.154, i32* %.74
  %.156 = load i32, i32* %.71
  %.157 = add i32 3, %.156
  %.158 = load i32, i32* @.g.a11
  %.159 = add i32 %.157, %.158
  store i32 %.159, i32* %.75
  %.161 = load i32, i32* %.72
  %.162 = add i32 4, %.161
  %.163 = load i32, i32* @.g.a12
  %.164 = add i32 %.162, %.163
  store i32 %.164, i32* %.76
  %.166 = load i32, i32* %.73
  %.167 = add i32 1, %.166
  %.168 = load i32, i32* @.g.a13
  %.169 = add i32 %.167, %.168
  store i32 %.169, i32* %.77
  %.171 = load i32, i32* %.74
  %.172 = add i32 2, %.171
  %.173 = load i32, i32* @.g.a14
  %.174 = add i32 %.172, %.173
  store i32 %.174, i32* %.78
  %.176 = load i32, i32* %.75
  %.177 = add i32 3, %.176
  %.178 = load i32, i32* @.g.a15
  %.179 = add i32 %.177, %.178
  store i32 %.179, i32* %.79
  %.181 = load i32, i32* %.76
  %.182 = add i32 4, %.181
  %.183 = load i32, i32* @.g.a16
  %.184 = add i32 %.182, %.183
  store i32 %.184, i32* %.80
  %.186 = load i32, i32* %.77
  %.187 = add i32 1, %.186
  %.188 = load i32, i32* @.g.a17
  %.189 = add i32 %.187, %.188
  store i32 %.189, i32* %.81
  %.191 = load i32, i32* %.78
  %.192 = add i32 2, %.191
  %.193 = load i32, i32* @.g.a18
  %.194 = add i32 %.192, %.193
  store i32 %.194, i32* %.82
  %.196 = load i32, i32* %.79
  %.197 = add i32 3, %.196
  %.198 = load i32, i32* @.g.a19
  %.199 = add i32 %.197, %.198
  store i32 %.199, i32* %.83
  %.201 = load i32, i32* %.80
  %.202 = add i32 4, %.201
  %.203 = load i32, i32* @.g.a20
  %.204 = add i32 %.202, %.203
  store i32 %.204, i32* %.84
  %.206 = load i32, i32* %.81
  %.207 = add i32 1, %.206
  %.208 = load i32, i32* @.g.a21
  %.209 = add i32 %.207, %.208
  store i32 %.209, i32* %.85
  %.211 = load i32, i32* %.82
  %.212 = add i32 2, %.211
  %.213 = load i32, i32* @.g.a22
  %.214 = add i32 %.212, %.213
  store i32 %.214, i32* %.86
  %.216 = load i32, i32* %.83
  %.217 = add i32 3, %.216
  %.218 = load i32, i32* @.g.a23
  %.219 = add i32 %.217, %.218
  store i32 %.219, i32* %.87
  %.221 = load i32, i32* %.84
  %.222 = add i32 4, %.221
  %.223 = load i32, i32* @.g.a24
  %.224 = add i32 %.222, %.223
  store i32 %.224, i32* %.88
  %.226 = load i32, i32* %.85
  %.227 = add i32 1, %.226
  %.228 = load i32, i32* @.g.a25
  %.229 = add i32 %.227, %.228
  store i32 %.229, i32* %.89
  %.231 = load i32, i32* %.86
  %.232 = add i32 2, %.231
  %.233 = load i32, i32* @.g.a26
  %.234 = add i32 %.232, %.233
  store i32 %.234, i32* %.90
  %.236 = load i32, i32* %.87
  %.237 = add i32 3, %.236
  %.238 = load i32, i32* @.g.a27
  %.239 = add i32 %.237, %.238
  store i32 %.239, i32* %.91
  %.241 = load i32, i32* %.88
  %.242 = add i32 4, %.241
  %.243 = load i32, i32* @.g.a28
  %.244 = add i32 %.242, %.243
  store i32 %.244, i32* %.92
  %.246 = load i32, i32* %.89
  %.247 = add i32 1, %.246
  %.248 = load i32, i32* @.g.a29
  %.249 = add i32 %.247, %.248
  store i32 %.249, i32* %.93
  %.251 = load i32, i32* %.90
  %.252 = add i32 2, %.251
  %.253 = load i32, i32* @.g.a30
  %.254 = add i32 %.252, %.253
  store i32 %.254, i32* %.94
  %.256 = load i32, i32* %.91
  %.257 = add i32 3, %.256
  %.258 = load i32, i32* @.g.a31
  %.259 = add i32 %.257, %.258
  store i32 %.259, i32* %.95
  %.261 = load i32, i32* %.92
  %.262 = add i32 4, %.261
  %.263 = load i32, i32* @.g.a32
  %.264 = add i32 %.262, %.263
  store i32 %.264, i32* %.96
  %.266 = load i32, i32* %.50
  %.267 = load i32, i32* %.53
  %.268 = sub i32 %.266, %.267
  %.269 = add i32 %.268, 10
  store i32 %.269, i32* %.56
  %.271 = load i32, i32* %.89
  %.272 = add i32 1, %.271
  %.273 = load i32, i32* @.g.a29
  %.274 = add i32 %.272, %.273
  store i32 %.274, i32* %.93
  %.276 = load i32, i32* %.90
  %.277 = add i32 2, %.276
  %.278 = load i32, i32* @.g.a30
  %.279 = add i32 %.277, %.278
  store i32 %.279, i32* %.94
  %.281 = load i32, i32* %.91
  %.282 = add i32 3, %.281
  %.283 = load i32, i32* @.g.a31
  %.284 = add i32 %.282, %.283
  store i32 %.284, i32* %.95
  %.286 = load i32, i32* %.92
  %.287 = add i32 4, %.286
  %.288 = load i32, i32* @.g.a32
  %.289 = add i32 %.287, %.288
  store i32 %.289, i32* %.96
  %.291 = load i32, i32* %.85
  %.292 = add i32 1, %.291
  %.293 = load i32, i32* @.g.a25
  %.294 = add i32 %.292, %.293
  store i32 %.294, i32* %.89
  %.296 = load i32, i32* %.86
  %.297 = add i32 2, %.296
  %.298 = load i32, i32* @.g.a26
  %.299 = add i32 %.297, %.298
  store i32 %.299, i32* %.90
  %.301 = load i32, i32* %.87
  %.302 = add i32 3, %.301
  %.303 = load i32, i32* @.g.a27
  %.304 = add i32 %.302, %.303
  store i32 %.304, i32* %.91
  %.306 = load i32, i32* %.88
  %.307 = add i32 4, %.306
  %.308 = load i32, i32* @.g.a28
  %.309 = add i32 %.307, %.308
  store i32 %.309, i32* %.92
  %.311 = load i32, i32* %.81
  %.312 = add i32 1, %.311
  %.313 = load i32, i32* @.g.a21
  %.314 = add i32 %.312, %.313
  store i32 %.314, i32* %.85
  %.316 = load i32, i32* %.82
  %.317 = add i32 2, %.316
  %.318 = load i32, i32* @.g.a22
  %.319 = add i32 %.317, %.318
  store i32 %.319, i32* %.86
  %.321 = load i32, i32* %.83
  %.322 = add i32 3, %.321
  %.323 = load i32, i32* @.g.a23
  %.324 = add i32 %.322, %.323
  store i32 %.324, i32* %.87
  %.326 = load i32, i32* %.84
  %.327 = add i32 4, %.326
  %.328 = load i32, i32* @.g.a24
  %.329 = add i32 %.327, %.328
  store i32 %.329, i32* %.88
  %.331 = load i32, i32* %.77
  %.332 = add i32 1, %.331
  %.333 = load i32, i32* @.g.a17
  %.334 = add i32 %.332, %.333
  store i32 %.334, i32* %.81
  %.336 = load i32, i32* %.78
  %.337 = add i32 2, %.336
  %.338 = load i32, i32* @.g.a18
  %.339 = add i32 %.337, %.338
  store i32 %.339, i32* %.82
  %.341 = load i32, i32* %.79
  %.342 = add i32 3, %.341
  %.343 = load i32, i32* @.g.a19
  %.344 = add i32 %.342, %.343
  store i32 %.344, i32* %.83
  %.346 = load i32, i32* %.80
  %.347 = add i32 4, %.346
  %.348 = load i32, i32* @.g.a20
  %.349 = add i32 %.347, %.348
  store i32 %.349, i32* %.84
  %.351 = load i32, i32* %.73
  %.352 = add i32 1, %.351
  %.353 = load i32, i32* @.g.a13
  %.354 = add i32 %.352, %.353
  store i32 %.354, i32* %.77
  %.356 = load i32, i32* %.74
  %.357 = add i32 2, %.356
  %.358 = load i32, i32* @.g.a14
  %.359 = add i32 %.357, %.358
  store i32 %.359, i32* %.78
  %.361 = load i32, i32* %.75
  %.362 = add i32 3, %.361
  %.363 = load i32, i32* @.g.a15
  %.364 = add i32 %.362, %.363
  store i32 %.364, i32* %.79
  %.366 = load i32, i32* %.76
  %.367 = add i32 4, %.366
  %.368 = load i32, i32* @.g.a16
  %.369 = add i32 %.367, %.368
  store i32 %.369, i32* %.80
  %.371 = load i32, i32* %.69
  %.372 = add i32 1, %.371
  %.373 = load i32, i32* @.g.a9
  %.374 = add i32 %.372, %.373
  store i32 %.374, i32* %.73
  %.376 = load i32, i32* %.70
  %.377 = add i32 2, %.376
  %.378 = load i32, i32* @.g.a10
  %.379 = add i32 %.377, %.378
  store i32 %.379, i32* %.74
  %.381 = load i32, i32* %.71
  %.382 = add i32 3, %.381
  %.383 = load i32, i32* @.g.a11
  %.384 = add i32 %.382, %.383
  store i32 %.384, i32* %.75
  %.386 = load i32, i32* %.72
  %.387 = add i32 4, %.386
  %.388 = load i32, i32* @.g.a12
  %.389 = add i32 %.387, %.388
  store i32 %.389, i32* %.76
  %.391 = load i32, i32* %.65
  %.392 = add i32 1, %.391
  %.393 = load i32, i32* @.g.a5
  %.394 = add i32 %.392, %.393
  store i32 %.394, i32* %.69
  %.396 = load i32, i32* %.66
  %.397 = add i32 2, %.396
  %.398 = load i32, i32* @.g.a6
  %.399 = add i32 %.397, %.398
  store i32 %.399, i32* %.70
  %.401 = load i32, i32* %.67
  %.402 = add i32 3, %.401
  %.403 = load i32, i32* @.g.a7
  %.404 = add i32 %.402, %.403
  store i32 %.404, i32* %.71
  %.406 = load i32, i32* %.68
  %.407 = add i32 4, %.406
  %.408 = load i32, i32* @.g.a8
  %.409 = add i32 %.407, %.408
  store i32 %.409, i32* %.72
  %.411 = load i32, i32* %.61
  %.412 = add i32 1, %.411
  %.413 = load i32, i32* @.g.a1
  %.414 = add i32 %.412, %.413
  store i32 %.414, i32* %.65
  %.416 = load i32, i32* %.62
  %.417 = add i32 2, %.416
  %.418 = load i32, i32* @.g.a2
  %.419 = add i32 %.417, %.418
  store i32 %.419, i32* %.66
  %.421 = load i32, i32* %.63
  %.422 = add i32 3, %.421
  %.423 = load i32, i32* @.g.a3
  %.424 = add i32 %.422, %.423
  store i32 %.424, i32* %.67
  %.426 = load i32, i32* %.64
  %.427 = add i32 4, %.426
  %.428 = load i32, i32* @.g.a4
  %.429 = add i32 %.427, %.428
  store i32 %.429, i32* %.68
  %.431 = load i32, i32* %.61
  %.432 = add i32 1, %.431
  %.433 = load i32, i32* @.g.a1
  %.434 = add i32 %.432, %.433
  store i32 %.434, i32* %.65
  %.436 = load i32, i32* %.62
  %.437 = add i32 2, %.436
  %.438 = load i32, i32* @.g.a2
  %.439 = add i32 %.437, %.438
  store i32 %.439, i32* %.66
  %.441 = load i32, i32* %.63
  %.442 = add i32 3, %.441
  %.443 = load i32, i32* @.g.a3
  %.444 = add i32 %.442, %.443
  store i32 %.444, i32* %.67
  %.446 = load i32, i32* %.64
  %.447 = add i32 4, %.446
  %.448 = load i32, i32* @.g.a4
  %.449 = add i32 %.447, %.448
  store i32 %.449, i32* %.68
  %.451 = load i32, i32* %.56
  %.452 = load i32, i32* %.61
  %.453 = add i32 %.451, %.452
  %.454 = load i32, i32* %.62
  %.455 = add i32 %.453, %.454
  %.456 = load i32, i32* %.63
  %.457 = add i32 %.455, %.456
  %.458 = load i32, i32* %.64
  %.459 = add i32 %.457, %.458
  %.460 = load i32, i32* %.65
  %.461 = sub i32 %.459, %.460
  %.462 = load i32, i32* %.66
  %.463 = sub i32 %.461, %.462
  %.464 = load i32, i32* %.67
  %.465 = sub i32 %.463, %.464
  %.466 = load i32, i32* %.68
  %.467 = sub i32 %.465, %.466
  %.468 = load i32, i32* %.69
  %.469 = add i32 %.467, %.468
  %.470 = load i32, i32* %.70
  %.471 = add i32 %.469, %.470
  %.472 = load i32, i32* %.71
  %.473 = add i32 %.471, %.472
  %.474 = load i32, i32* %.72
  %.475 = add i32 %.473, %.474
  %.476 = load i32, i32* %.73
  %.477 = sub i32 %.475, %.476
  %.478 = load i32, i32* %.74
  %.479 = sub i32 %.477, %.478
  %.480 = load i32, i32* %.75
  %.481 = sub i32 %.479, %.480
  %.482 = load i32, i32* %.76
  %.483 = sub i32 %.481, %.482
  %.484 = load i32, i32* %.77
  %.485 = add i32 %.483, %.484
  %.486 = load i32, i32* %.78
  %.487 = add i32 %.485, %.486
  %.488 = load i32, i32* %.79
  %.489 = add i32 %.487, %.488
  %.490 = load i32, i32* %.80
  %.491 = add i32 %.489, %.490
  %.492 = load i32, i32* %.81
  %.493 = sub i32 %.491, %.492
  %.494 = load i32, i32* %.82
  %.495 = sub i32 %.493, %.494
  %.496 = load i32, i32* %.83
  %.497 = sub i32 %.495, %.496
  %.498 = load i32, i32* %.84
  %.499 = sub i32 %.497, %.498
  %.500 = load i32, i32* %.85
  %.501 = add i32 %.499, %.500
  %.502 = load i32, i32* %.86
  %.503 = add i32 %.501, %.502
  %.504 = load i32, i32* %.87
  %.505 = add i32 %.503, %.504
  %.506 = load i32, i32* %.88
  %.507 = add i32 %.505, %.506
  %.508 = load i32, i32* %.89
  %.509 = sub i32 %.507, %.508
  %.510 = load i32, i32* %.90
  %.511 = sub i32 %.509, %.510
  %.512 = load i32, i32* %.91
  %.513 = sub i32 %.511, %.512
  %.514 = load i32, i32* %.92
  %.515 = sub i32 %.513, %.514
  %.516 = load i32, i32* %.93
  %.517 = add i32 %.515, %.516
  %.518 = load i32, i32* %.94
  %.519 = add i32 %.517, %.518
  %.520 = load i32, i32* %.95
  %.521 = add i32 %.519, %.520
  %.522 = load i32, i32* %.96
  %.523 = add i32 %.521, %.522
  %.524 = load i32, i32* @.g.a1
  %.525 = add i32 %.523, %.524
  %.526 = load i32, i32* @.g.a2
  %.527 = sub i32 %.525, %.526
  %.528 = load i32, i32* @.g.a3
  %.529 = add i32 %.527, %.528
  %.530 = load i32, i32* @.g.a4
  %.531 = sub i32 %.529, %.530
  %.532 = load i32, i32* @.g.a5
  %.533 = add i32 %.531, %.532
  %.534 = load i32, i32* @.g.a6
  %.535 = sub i32 %.533, %.534
  %.536 = load i32, i32* @.g.a7
  %.537 = add i32 %.535, %.536
  %.538 = load i32, i32* @.g.a8
  %.539 = sub i32 %.537, %.538
  %.540 = load i32, i32* @.g.a9
  %.541 = add i32 %.539, %.540
  %.542 = load i32, i32* @.g.a10
  %.543 = sub i32 %.541, %.542
  %.544 = load i32, i32* @.g.a11
  %.545 = add i32 %.543, %.544
  %.546 = load i32, i32* @.g.a12
  %.547 = sub i32 %.545, %.546
  %.548 = load i32, i32* @.g.a13
  %.549 = add i32 %.547, %.548
  %.550 = load i32, i32* @.g.a14
  %.551 = sub i32 %.549, %.550
  %.552 = load i32, i32* @.g.a15
  %.553 = add i32 %.551, %.552
  %.554 = load i32, i32* @.g.a16
  %.555 = sub i32 %.553, %.554
  %.556 = load i32, i32* @.g.a17
  %.557 = add i32 %.555, %.556
  %.558 = load i32, i32* @.g.a18
  %.559 = sub i32 %.557, %.558
  %.560 = load i32, i32* @.g.a19
  %.561 = add i32 %.559, %.560
  %.562 = load i32, i32* @.g.a20
  %.563 = sub i32 %.561, %.562
  %.564 = load i32, i32* @.g.a21
  %.565 = add i32 %.563, %.564
  %.566 = load i32, i32* @.g.a22
  %.567 = sub i32 %.565, %.566
  %.568 = load i32, i32* @.g.a23
  %.569 = add i32 %.567, %.568
  %.570 = load i32, i32* @.g.a24
  %.571 = sub i32 %.569, %.570
  %.572 = load i32, i32* @.g.a25
  %.573 = add i32 %.571, %.572
  %.574 = load i32, i32* @.g.a26
  %.575 = sub i32 %.573, %.574
  %.576 = load i32, i32* @.g.a27
  %.577 = add i32 %.575, %.576
  %.578 = load i32, i32* @.g.a28
  %.579 = sub i32 %.577, %.578
  %.580 = load i32, i32* @.g.a29
  %.581 = add i32 %.579, %.580
  %.582 = load i32, i32* @.g.a30
  %.583 = sub i32 %.581, %.582
  %.584 = load i32, i32* @.g.a31
  %.585 = add i32 %.583, %.584
  %.586 = load i32, i32* @.g.a32
  %.587 = sub i32 %.585, %.586
  ret i32 %.587 
}
define i32 @main(){
.590:
  %.592 = alloca i32
  %.591 = alloca i32
  %.593at89 = call i32 @getint()
  store i32 %.593at89, i32* %.591
  %.595 = load i32, i32* %.591
  %.597 = add i32 %.595, 18
  store i32 %.597, i32* %.592
  %.599 = load i32, i32* %.591
  %.600 = load i32, i32* %.592
  %.601at91 = call i32 @func(i32 %.599, i32 %.600)
  store i32 %.601at91, i32* %.591
  %.603 = load i32, i32* %.591
  call void @putint(i32 %.603)
  %.606 = load i32, i32* %.591
  ret i32 %.606 
}
@.g.a1 = global i32 1
@.g.a2 = global i32 2
@.g.a3 = global i32 3
@.g.a4 = global i32 4
@.g.a5 = global i32 5
@.g.a6 = global i32 6
@.g.a7 = global i32 7
@.g.a8 = global i32 8
@.g.a9 = global i32 9
@.g.a10 = global i32 10
@.g.a11 = global i32 11
@.g.a12 = global i32 12
@.g.a13 = global i32 13
@.g.a14 = global i32 14
@.g.a15 = global i32 15
@.g.a16 = global i32 16
@.g.a17 = global i32 1
@.g.a18 = global i32 2
@.g.a19 = global i32 3
@.g.a20 = global i32 4
@.g.a21 = global i32 5
@.g.a22 = global i32 6
@.g.a23 = global i32 7
@.g.a24 = global i32 8
@.g.a25 = global i32 9
@.g.a26 = global i32 10
@.g.a27 = global i32 11
@.g.a28 = global i32 12
@.g.a29 = global i32 13
@.g.a30 = global i32 14
@.g.a31 = global i32 15
@.g.a32 = global i32 16
define i32 @func(i32 %.51, i32 %.54){
.49:
  %.96 = alloca i32
  %.95 = alloca i32
  %.94 = alloca i32
  %.93 = alloca i32
  %.92 = alloca i32
  %.91 = alloca i32
  %.90 = alloca i32
  %.89 = alloca i32
  %.88 = alloca i32
  %.87 = alloca i32
  %.86 = alloca i32
  %.85 = alloca i32
  %.84 = alloca i32
  %.83 = alloca i32
  %.82 = alloca i32
  %.81 = alloca i32
  %.80 = alloca i32
  %.79 = alloca i32
  %.78 = alloca i32
  %.77 = alloca i32
  %.76 = alloca i32
  %.75 = alloca i32
  %.74 = alloca i32
  %.73 = alloca i32
  %.72 = alloca i32
  %.71 = alloca i32
  %.70 = alloca i32
  %.69 = alloca i32
  %.68 = alloca i32
  %.67 = alloca i32
  %.66 = alloca i32
  %.65 = alloca i32
  %.64 = alloca i32
  %.63 = alloca i32
  %.62 = alloca i32
  %.61 = alloca i32
  %.56 = alloca i32
  %.53 = alloca i32
  %.50 = alloca i32
  store i32 %.51, i32* %.50
  store i32 %.54, i32* %.53
  %.57 = load i32, i32* %.50
  %.58 = load i32, i32* %.53
  %.59 = add i32 %.57, %.58
  store i32 %.59, i32* %.56
  %.98at47 = call i32 @getint()
  store i32 %.98at47, i32* %.61
  %.100at47 = call i32 @getint()
  store i32 %.100at47, i32* %.62
  %.102at47 = call i32 @getint()
  store i32 %.102at47, i32* %.63
  %.104at47 = call i32 @getint()
  store i32 %.104at47, i32* %.64
  %.106 = load i32, i32* %.61
  %.107 = add i32 1, %.106
  %.108 = load i32, i32* @.g.a1
  %.109 = add i32 %.107, %.108
  store i32 %.109, i32* %.65
  %.111 = load i32, i32* %.62
  %.112 = add i32 2, %.111
  %.113 = load i32, i32* @.g.a2
  %.114 = add i32 %.112, %.113
  store i32 %.114, i32* %.66
  %.116 = load i32, i32* %.63
  %.117 = add i32 3, %.116
  %.118 = load i32, i32* @.g.a3
  %.119 = add i32 %.117, %.118
  store i32 %.119, i32* %.67
  %.121 = load i32, i32* %.64
  %.122 = add i32 4, %.121
  %.123 = load i32, i32* @.g.a4
  %.124 = add i32 %.122, %.123
  store i32 %.124, i32* %.68
  %.126 = load i32, i32* %.65
  %.127 = add i32 1, %.126
  %.128 = load i32, i32* @.g.a5
  %.129 = add i32 %.127, %.128
  store i32 %.129, i32* %.69
  %.131 = load i32, i32* %.66
  %.132 = add i32 2, %.131
  %.133 = load i32, i32* @.g.a6
  %.134 = add i32 %.132, %.133
  store i32 %.134, i32* %.70
  %.136 = load i32, i32* %.67
  %.137 = add i32 3, %.136
  %.138 = load i32, i32* @.g.a7
  %.139 = add i32 %.137, %.138
  store i32 %.139, i32* %.71
  %.141 = load i32, i32* %.68
  %.142 = add i32 4, %.141
  %.143 = load i32, i32* @.g.a8
  %.144 = add i32 %.142, %.143
  store i32 %.144, i32* %.72
  %.146 = load i32, i32* %.69
  %.147 = add i32 1, %.146
  %.148 = load i32, i32* @.g.a9
  %.149 = add i32 %.147, %.148
  store i32 %.149, i32* %.73
  %.151 = load i32, i32* %.70
  %.152 = add i32 2, %.151
  %.153 = load i32, i32* @.g.a10
  %.154 = add i32 %.152, %.153
  store i32 %.154, i32* %.74
  %.156 = load i32, i32* %.71
  %.157 = add i32 3, %.156
  %.158 = load i32, i32* @.g.a11
  %.159 = add i32 %.157, %.158
  store i32 %.159, i32* %.75
  %.161 = load i32, i32* %.72
  %.162 = add i32 4, %.161
  %.163 = load i32, i32* @.g.a12
  %.164 = add i32 %.162, %.163
  store i32 %.164, i32* %.76
  %.166 = load i32, i32* %.73
  %.167 = add i32 1, %.166
  %.168 = load i32, i32* @.g.a13
  %.169 = add i32 %.167, %.168
  store i32 %.169, i32* %.77
  %.171 = load i32, i32* %.74
  %.172 = add i32 2, %.171
  %.173 = load i32, i32* @.g.a14
  %.174 = add i32 %.172, %.173
  store i32 %.174, i32* %.78
  %.176 = load i32, i32* %.75
  %.177 = add i32 3, %.176
  %.178 = load i32, i32* @.g.a15
  %.179 = add i32 %.177, %.178
  store i32 %.179, i32* %.79
  %.181 = load i32, i32* %.76
  %.182 = add i32 4, %.181
  %.183 = load i32, i32* @.g.a16
  %.184 = add i32 %.182, %.183
  store i32 %.184, i32* %.80
  %.186 = load i32, i32* %.77
  %.187 = add i32 1, %.186
  %.188 = load i32, i32* @.g.a17
  %.189 = add i32 %.187, %.188
  store i32 %.189, i32* %.81
  %.191 = load i32, i32* %.78
  %.192 = add i32 2, %.191
  %.193 = load i32, i32* @.g.a18
  %.194 = add i32 %.192, %.193
  store i32 %.194, i32* %.82
  %.196 = load i32, i32* %.79
  %.197 = add i32 3, %.196
  %.198 = load i32, i32* @.g.a19
  %.199 = add i32 %.197, %.198
  store i32 %.199, i32* %.83
  %.201 = load i32, i32* %.80
  %.202 = add i32 4, %.201
  %.203 = load i32, i32* @.g.a20
  %.204 = add i32 %.202, %.203
  store i32 %.204, i32* %.84
  %.206 = load i32, i32* %.81
  %.207 = add i32 1, %.206
  %.208 = load i32, i32* @.g.a21
  %.209 = add i32 %.207, %.208
  store i32 %.209, i32* %.85
  %.211 = load i32, i32* %.82
  %.212 = add i32 2, %.211
  %.213 = load i32, i32* @.g.a22
  %.214 = add i32 %.212, %.213
  store i32 %.214, i32* %.86
  %.216 = load i32, i32* %.83
  %.217 = add i32 3, %.216
  %.218 = load i32, i32* @.g.a23
  %.219 = add i32 %.217, %.218
  store i32 %.219, i32* %.87
  %.221 = load i32, i32* %.84
  %.222 = add i32 4, %.221
  %.223 = load i32, i32* @.g.a24
  %.224 = add i32 %.222, %.223
  store i32 %.224, i32* %.88
  %.226 = load i32, i32* %.85
  %.227 = add i32 1, %.226
  %.228 = load i32, i32* @.g.a25
  %.229 = add i32 %.227, %.228
  store i32 %.229, i32* %.89
  %.231 = load i32, i32* %.86
  %.232 = add i32 2, %.231
  %.233 = load i32, i32* @.g.a26
  %.234 = add i32 %.232, %.233
  store i32 %.234, i32* %.90
  %.236 = load i32, i32* %.87
  %.237 = add i32 3, %.236
  %.238 = load i32, i32* @.g.a27
  %.239 = add i32 %.237, %.238
  store i32 %.239, i32* %.91
  %.241 = load i32, i32* %.88
  %.242 = add i32 4, %.241
  %.243 = load i32, i32* @.g.a28
  %.244 = add i32 %.242, %.243
  store i32 %.244, i32* %.92
  %.246 = load i32, i32* %.89
  %.247 = add i32 1, %.246
  %.248 = load i32, i32* @.g.a29
  %.249 = add i32 %.247, %.248
  store i32 %.249, i32* %.93
  %.251 = load i32, i32* %.90
  %.252 = add i32 2, %.251
  %.253 = load i32, i32* @.g.a30
  %.254 = add i32 %.252, %.253
  store i32 %.254, i32* %.94
  %.256 = load i32, i32* %.91
  %.257 = add i32 3, %.256
  %.258 = load i32, i32* @.g.a31
  %.259 = add i32 %.257, %.258
  store i32 %.259, i32* %.95
  %.261 = load i32, i32* %.92
  %.262 = add i32 4, %.261
  %.263 = load i32, i32* @.g.a32
  %.264 = add i32 %.262, %.263
  store i32 %.264, i32* %.96
  %.266 = load i32, i32* %.50
  %.267 = load i32, i32* %.53
  %.268 = sub i32 %.266, %.267
  %.269 = add i32 %.268, 10
  store i32 %.269, i32* %.56
  %.271 = load i32, i32* %.89
  %.272 = add i32 1, %.271
  %.273 = load i32, i32* @.g.a29
  %.274 = add i32 %.272, %.273
  store i32 %.274, i32* %.93
  %.276 = load i32, i32* %.90
  %.277 = add i32 2, %.276
  %.278 = load i32, i32* @.g.a30
  %.279 = add i32 %.277, %.278
  store i32 %.279, i32* %.94
  %.281 = load i32, i32* %.91
  %.282 = add i32 3, %.281
  %.283 = load i32, i32* @.g.a31
  %.284 = add i32 %.282, %.283
  store i32 %.284, i32* %.95
  %.286 = load i32, i32* %.92
  %.287 = add i32 4, %.286
  %.288 = load i32, i32* @.g.a32
  %.289 = add i32 %.287, %.288
  store i32 %.289, i32* %.96
  %.291 = load i32, i32* %.85
  %.292 = add i32 1, %.291
  %.293 = load i32, i32* @.g.a25
  %.294 = add i32 %.292, %.293
  store i32 %.294, i32* %.89
  %.296 = load i32, i32* %.86
  %.297 = add i32 2, %.296
  %.298 = load i32, i32* @.g.a26
  %.299 = add i32 %.297, %.298
  store i32 %.299, i32* %.90
  %.301 = load i32, i32* %.87
  %.302 = add i32 3, %.301
  %.303 = load i32, i32* @.g.a27
  %.304 = add i32 %.302, %.303
  store i32 %.304, i32* %.91
  %.306 = load i32, i32* %.88
  %.307 = add i32 4, %.306
  %.308 = load i32, i32* @.g.a28
  %.309 = add i32 %.307, %.308
  store i32 %.309, i32* %.92
  %.311 = load i32, i32* %.81
  %.312 = add i32 1, %.311
  %.313 = load i32, i32* @.g.a21
  %.314 = add i32 %.312, %.313
  store i32 %.314, i32* %.85
  %.316 = load i32, i32* %.82
  %.317 = add i32 2, %.316
  %.318 = load i32, i32* @.g.a22
  %.319 = add i32 %.317, %.318
  store i32 %.319, i32* %.86
  %.321 = load i32, i32* %.83
  %.322 = add i32 3, %.321
  %.323 = load i32, i32* @.g.a23
  %.324 = add i32 %.322, %.323
  store i32 %.324, i32* %.87
  %.326 = load i32, i32* %.84
  %.327 = add i32 4, %.326
  %.328 = load i32, i32* @.g.a24
  %.329 = add i32 %.327, %.328
  store i32 %.329, i32* %.88
  %.331 = load i32, i32* %.77
  %.332 = add i32 1, %.331
  %.333 = load i32, i32* @.g.a17
  %.334 = add i32 %.332, %.333
  store i32 %.334, i32* %.81
  %.336 = load i32, i32* %.78
  %.337 = add i32 2, %.336
  %.338 = load i32, i32* @.g.a18
  %.339 = add i32 %.337, %.338
  store i32 %.339, i32* %.82
  %.341 = load i32, i32* %.79
  %.342 = add i32 3, %.341
  %.343 = load i32, i32* @.g.a19
  %.344 = add i32 %.342, %.343
  store i32 %.344, i32* %.83
  %.346 = load i32, i32* %.80
  %.347 = add i32 4, %.346
  %.348 = load i32, i32* @.g.a20
  %.349 = add i32 %.347, %.348
  store i32 %.349, i32* %.84
  %.351 = load i32, i32* %.73
  %.352 = add i32 1, %.351
  %.353 = load i32, i32* @.g.a13
  %.354 = add i32 %.352, %.353
  store i32 %.354, i32* %.77
  %.356 = load i32, i32* %.74
  %.357 = add i32 2, %.356
  %.358 = load i32, i32* @.g.a14
  %.359 = add i32 %.357, %.358
  store i32 %.359, i32* %.78
  %.361 = load i32, i32* %.75
  %.362 = add i32 3, %.361
  %.363 = load i32, i32* @.g.a15
  %.364 = add i32 %.362, %.363
  store i32 %.364, i32* %.79
  %.366 = load i32, i32* %.76
  %.367 = add i32 4, %.366
  %.368 = load i32, i32* @.g.a16
  %.369 = add i32 %.367, %.368
  store i32 %.369, i32* %.80
  %.371 = load i32, i32* %.69
  %.372 = add i32 1, %.371
  %.373 = load i32, i32* @.g.a9
  %.374 = add i32 %.372, %.373
  store i32 %.374, i32* %.73
  %.376 = load i32, i32* %.70
  %.377 = add i32 2, %.376
  %.378 = load i32, i32* @.g.a10
  %.379 = add i32 %.377, %.378
  store i32 %.379, i32* %.74
  %.381 = load i32, i32* %.71
  %.382 = add i32 3, %.381
  %.383 = load i32, i32* @.g.a11
  %.384 = add i32 %.382, %.383
  store i32 %.384, i32* %.75
  %.386 = load i32, i32* %.72
  %.387 = add i32 4, %.386
  %.388 = load i32, i32* @.g.a12
  %.389 = add i32 %.387, %.388
  store i32 %.389, i32* %.76
  %.391 = load i32, i32* %.65
  %.392 = add i32 1, %.391
  %.393 = load i32, i32* @.g.a5
  %.394 = add i32 %.392, %.393
  store i32 %.394, i32* %.69
  %.396 = load i32, i32* %.66
  %.397 = add i32 2, %.396
  %.398 = load i32, i32* @.g.a6
  %.399 = add i32 %.397, %.398
  store i32 %.399, i32* %.70
  %.401 = load i32, i32* %.67
  %.402 = add i32 3, %.401
  %.403 = load i32, i32* @.g.a7
  %.404 = add i32 %.402, %.403
  store i32 %.404, i32* %.71
  %.406 = load i32, i32* %.68
  %.407 = add i32 4, %.406
  %.408 = load i32, i32* @.g.a8
  %.409 = add i32 %.407, %.408
  store i32 %.409, i32* %.72
  %.411 = load i32, i32* %.61
  %.412 = add i32 1, %.411
  %.413 = load i32, i32* @.g.a1
  %.414 = add i32 %.412, %.413
  store i32 %.414, i32* %.65
  %.416 = load i32, i32* %.62
  %.417 = add i32 2, %.416
  %.418 = load i32, i32* @.g.a2
  %.419 = add i32 %.417, %.418
  store i32 %.419, i32* %.66
  %.421 = load i32, i32* %.63
  %.422 = add i32 3, %.421
  %.423 = load i32, i32* @.g.a3
  %.424 = add i32 %.422, %.423
  store i32 %.424, i32* %.67
  %.426 = load i32, i32* %.64
  %.427 = add i32 4, %.426
  %.428 = load i32, i32* @.g.a4
  %.429 = add i32 %.427, %.428
  store i32 %.429, i32* %.68
  %.431 = load i32, i32* %.61
  %.432 = add i32 1, %.431
  %.433 = load i32, i32* @.g.a1
  %.434 = add i32 %.432, %.433
  store i32 %.434, i32* %.65
  %.436 = load i32, i32* %.62
  %.437 = add i32 2, %.436
  %.438 = load i32, i32* @.g.a2
  %.439 = add i32 %.437, %.438
  store i32 %.439, i32* %.66
  %.441 = load i32, i32* %.63
  %.442 = add i32 3, %.441
  %.443 = load i32, i32* @.g.a3
  %.444 = add i32 %.442, %.443
  store i32 %.444, i32* %.67
  %.446 = load i32, i32* %.64
  %.447 = add i32 4, %.446
  %.448 = load i32, i32* @.g.a4
  %.449 = add i32 %.447, %.448
  store i32 %.449, i32* %.68
  %.451 = load i32, i32* %.56
  %.452 = load i32, i32* %.61
  %.453 = add i32 %.451, %.452
  %.454 = load i32, i32* %.62
  %.455 = add i32 %.453, %.454
  %.456 = load i32, i32* %.63
  %.457 = add i32 %.455, %.456
  %.458 = load i32, i32* %.64
  %.459 = add i32 %.457, %.458
  %.460 = load i32, i32* %.65
  %.461 = sub i32 %.459, %.460
  %.462 = load i32, i32* %.66
  %.463 = sub i32 %.461, %.462
  %.464 = load i32, i32* %.67
  %.465 = sub i32 %.463, %.464
  %.466 = load i32, i32* %.68
  %.467 = sub i32 %.465, %.466
  %.468 = load i32, i32* %.69
  %.469 = add i32 %.467, %.468
  %.470 = load i32, i32* %.70
  %.471 = add i32 %.469, %.470
  %.472 = load i32, i32* %.71
  %.473 = add i32 %.471, %.472
  %.474 = load i32, i32* %.72
  %.475 = add i32 %.473, %.474
  %.476 = load i32, i32* %.73
  %.477 = sub i32 %.475, %.476
  %.478 = load i32, i32* %.74
  %.479 = sub i32 %.477, %.478
  %.480 = load i32, i32* %.75
  %.481 = sub i32 %.479, %.480
  %.482 = load i32, i32* %.76
  %.483 = sub i32 %.481, %.482
  %.484 = load i32, i32* %.77
  %.485 = add i32 %.483, %.484
  %.486 = load i32, i32* %.78
  %.487 = add i32 %.485, %.486
  %.488 = load i32, i32* %.79
  %.489 = add i32 %.487, %.488
  %.490 = load i32, i32* %.80
  %.491 = add i32 %.489, %.490
  %.492 = load i32, i32* %.81
  %.493 = sub i32 %.491, %.492
  %.494 = load i32, i32* %.82
  %.495 = sub i32 %.493, %.494
  %.496 = load i32, i32* %.83
  %.497 = sub i32 %.495, %.496
  %.498 = load i32, i32* %.84
  %.499 = sub i32 %.497, %.498
  %.500 = load i32, i32* %.85
  %.501 = add i32 %.499, %.500
  %.502 = load i32, i32* %.86
  %.503 = add i32 %.501, %.502
  %.504 = load i32, i32* %.87
  %.505 = add i32 %.503, %.504
  %.506 = load i32, i32* %.88
  %.507 = add i32 %.505, %.506
  %.508 = load i32, i32* %.89
  %.509 = sub i32 %.507, %.508
  %.510 = load i32, i32* %.90
  %.511 = sub i32 %.509, %.510
  %.512 = load i32, i32* %.91
  %.513 = sub i32 %.511, %.512
  %.514 = load i32, i32* %.92
  %.515 = sub i32 %.513, %.514
  %.516 = load i32, i32* %.93
  %.517 = add i32 %.515, %.516
  %.518 = load i32, i32* %.94
  %.519 = add i32 %.517, %.518
  %.520 = load i32, i32* %.95
  %.521 = add i32 %.519, %.520
  %.522 = load i32, i32* %.96
  %.523 = add i32 %.521, %.522
  %.524 = load i32, i32* @.g.a1
  %.525 = add i32 %.523, %.524
  %.526 = load i32, i32* @.g.a2
  %.527 = sub i32 %.525, %.526
  %.528 = load i32, i32* @.g.a3
  %.529 = add i32 %.527, %.528
  %.530 = load i32, i32* @.g.a4
  %.531 = sub i32 %.529, %.530
  %.532 = load i32, i32* @.g.a5
  %.533 = add i32 %.531, %.532
  %.534 = load i32, i32* @.g.a6
  %.535 = sub i32 %.533, %.534
  %.536 = load i32, i32* @.g.a7
  %.537 = add i32 %.535, %.536
  %.538 = load i32, i32* @.g.a8
  %.539 = sub i32 %.537, %.538
  %.540 = load i32, i32* @.g.a9
  %.541 = add i32 %.539, %.540
  %.542 = load i32, i32* @.g.a10
  %.543 = sub i32 %.541, %.542
  %.544 = load i32, i32* @.g.a11
  %.545 = add i32 %.543, %.544
  %.546 = load i32, i32* @.g.a12
  %.547 = sub i32 %.545, %.546
  %.548 = load i32, i32* @.g.a13
  %.549 = add i32 %.547, %.548
  %.550 = load i32, i32* @.g.a14
  %.551 = sub i32 %.549, %.550
  %.552 = load i32, i32* @.g.a15
  %.553 = add i32 %.551, %.552
  %.554 = load i32, i32* @.g.a16
  %.555 = sub i32 %.553, %.554
  %.556 = load i32, i32* @.g.a17
  %.557 = add i32 %.555, %.556
  %.558 = load i32, i32* @.g.a18
  %.559 = sub i32 %.557, %.558
  %.560 = load i32, i32* @.g.a19
  %.561 = add i32 %.559, %.560
  %.562 = load i32, i32* @.g.a20
  %.563 = sub i32 %.561, %.562
  %.564 = load i32, i32* @.g.a21
  %.565 = add i32 %.563, %.564
  %.566 = load i32, i32* @.g.a22
  %.567 = sub i32 %.565, %.566
  %.568 = load i32, i32* @.g.a23
  %.569 = add i32 %.567, %.568
  %.570 = load i32, i32* @.g.a24
  %.571 = sub i32 %.569, %.570
  %.572 = load i32, i32* @.g.a25
  %.573 = add i32 %.571, %.572
  %.574 = load i32, i32* @.g.a26
  %.575 = sub i32 %.573, %.574
  %.576 = load i32, i32* @.g.a27
  %.577 = add i32 %.575, %.576
  %.578 = load i32, i32* @.g.a28
  %.579 = sub i32 %.577, %.578
  %.580 = load i32, i32* @.g.a29
  %.581 = add i32 %.579, %.580
  %.582 = load i32, i32* @.g.a30
  %.583 = sub i32 %.581, %.582
  %.584 = load i32, i32* @.g.a31
  %.585 = add i32 %.583, %.584
  %.586 = load i32, i32* @.g.a32
  %.587 = sub i32 %.585, %.586
  ret i32 %.587 
}
define i32 @main(){
.590:
  %.592 = alloca i32
  %.591 = alloca i32
  %.593at89 = call i32 @getin