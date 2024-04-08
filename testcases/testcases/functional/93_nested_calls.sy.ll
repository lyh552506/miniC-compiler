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
define i32 @func1(i32 %.3, i32 %.6, i32 %.9){
.1:
  %.8 = alloca i32
  %.5 = alloca i32
  %.2 = alloca i32
  store i32 %.3, i32* %.2
  store i32 %.6, i32* %.5
  store i32 %.9, i32* %.8
  %.13 = load i32, i32* %.8
  %.15 = icmp eq i32 %.13, 0
  br i1 %.15, label %.11, label %.12
.11:
  %.17 = load i32, i32* %.2
  %.18 = load i32, i32* %.5
  %.19 = mul i32 %.17, %.18
  ret i32 %.19 
.12:
  %.21 = load i32, i32* %.2
  %.22 = load i32, i32* %.5
  %.23 = load i32, i32* %.8
  %.24 = sub i32 %.22, %.23
  %.25at6 = call i32 @func1(i32 %.21, i32 %.24, i32 0)
  ret i32 %.25at6 
}
define i32 @func2(i32 %.30, i32 %.33){
.28:
  %.32 = alloca i32
  %.29 = alloca i32
  store i32 %.30, i32* %.29
  store i32 %.33, i32* %.32
  %.37 = load i32, i32* %.32
  %.38 = icmp ne i32 %.37, 0
  br i1 %.38, label %.35, label %.36
.35:
  %.40 = load i32, i32* %.29
  %.41 = load i32, i32* %.32
  %.42 = srem i32 %.40, %.41
  %.43at12 = call i32 @func2(i32 %.42, i32 0)
  ret i32 %.43at12 
.36:
  %.45 = load i32, i32* %.29
  ret i32 %.45 
}
define i32 @func3(i32 %.50, i32 %.53){
.48:
  %.52 = alloca i32
  %.49 = alloca i32
  store i32 %.50, i32* %.49
  store i32 %.53, i32* %.52
  %.57 = load i32, i32* %.52
  %.58 = icmp eq i32 %.57, 0
  br i1 %.58, label %.55, label %.56
.55:
  %.60 = load i32, i32* %.49
  %.62 = add i32 %.60, 1
  ret i32 %.62 
.56:
  %.64 = load i32, i32* %.49
  %.65 = load i32, i32* %.52
  %.66 = add i32 %.64, %.65
  %.67at24 = call i32 @func3(i32 %.66, i32 0)
  ret i32 %.67at24 
}
define i32 @func4(i32 %.72, i32 %.75, i32 %.78){
.70:
  %.77 = alloca i32
  %.74 = alloca i32
  %.71 = alloca i32
  store i32 %.72, i32* %.71
  store i32 %.75, i32* %.74
  store i32 %.78, i32* %.77
  %.82 = load i32, i32* %.71
  %.83 = icmp ne i32 %.82, 0
  br i1 %.83, label %.80, label %.81
.80:
  %.85 = load i32, i32* %.74
  ret i32 %.85 
.81:
  %.87 = load i32, i32* %.77
  ret i32 %.87 
}
define i32 @func5(i32 %.92){
.90:
  %.91 = alloca i32
  store i32 %.92, i32* %.91
  %.94 = load i32, i32* %.91
  %.95 = sub i32 0, %.94
  ret i32 %.95 
}
define i32 @func6(i32 %.100, i32 %.103){
.98:
  %.102 = alloca i32
  %.99 = alloca i32
  store i32 %.100, i32* %.99
  store i32 %.103, i32* %.102
  %.107 = load i32, i32* %.99
  %.108 = icmp ne i32 %.107, 0
  br i1 %.108, label %.109, label %.106
.105:
  ret i32 1 
.106:
  ret i32 0 
.109:
  %.111 = load i32, i32* %.102
  %.112 = icmp ne i32 %.111, 0
  br i1 %.112, label %.105, label %.106
}
define i32 @func7(i32 %.119){
.117:
  %.118 = alloca i32
  store i32 %.119, i32* %.118
  %.123 = load i32, i32* %.118
  %.124 = icmp eq i32 %.123, 0
  br i1 %.124, label %.121, label %.122
.121:
  ret i32 1 
.122:
  ret i32 0 
}
define i32 @main(){
.129:
  %.162 = alloca i32
  %.145 = alloca i32
  %.144 = alloca [10 x i32]
  %.140 = alloca i32
  %.137 = alloca i32
  %.134 = alloca i32
  %.130 = alloca i32
  %.132at60 = call i32 @getint()
  store i32 %.132at60, i32* %.130
  %.135at60 = call i32 @getint()
  store i32 %.135at60, i32* %.134
  %.138at60 = call i32 @getint()
  store i32 %.138at60, i32* %.137
  %.141at60 = call i32 @getint()
  store i32 %.141at60, i32* %.140
  store i32 0, i32* %.145
  br label %.147wc63 
.147wc63:
  %.151 = load i32, i32* %.145
  %.152 = icmp slt i32 %.151, 10
  br i1 %.152, label %.148wloop.63.66, label %.149wn66
.148wloop.63.66:
  %.154at64 = call i32 @getint()
  %.155 = load i32, i32* %.145
  %.156 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 %.155
  store i32 %.154at64, i32* %.156
  %.158 = load i32, i32* %.145
  %.159 = add i32 %.158, 1
  store i32 %.159, i32* %.145
  br label %.147wc63 
.149wn66:
  %.163 = load i32, i32* %.130
  %.164at73 = call i32 @func7(i32 %.163)
  %.165 = load i32, i32* %.134
  %.166at73 = call i32 @func5(i32 %.165)
  %.167at73 = call i32 @func6(i32 %.164at73, i32 %.166at73)
  %.168 = load i32, i32* %.137
  %.169at73 = call i32 @func2(i32 %.167at73, i32 %.168)
  %.170 = load i32, i32* %.140
  %.171at73 = call i32 @func3(i32 %.169at73, i32 %.170)
  %.172at73 = call i32 @func5(i32 %.171at73)
  %.173 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 0
  %.174 = load i32, i32* %.173
  %.175 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 1
  %.176 = load i32, i32* %.175
  %.177at79 = call i32 @func5(i32 %.176)
  %.179 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 2
  %.180 = load i32, i32* %.179
  %.182 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 3
  %.183 = load i32, i32* %.182
  %.184at81 = call i32 @func7(i32 %.183)
  %.185at81 = call i32 @func6(i32 %.180, i32 %.184at81)
  %.187 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 4
  %.188 = load i32, i32* %.187
  %.190 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 5
  %.191 = load i32, i32* %.190
  %.192at82 = call i32 @func7(i32 %.191)
  %.193at82 = call i32 @func2(i32 %.188, i32 %.192at82)
  %.194at79 = call i32 @func4(i32 %.177at79, i32 %.185at81, i32 %.193at82)
  %.196 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 6
  %.197 = load i32, i32* %.196
  %.198at79 = call i32 @func3(i32 %.194at79, i32 %.197)
  %.200 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 7
  %.201 = load i32, i32* %.200
  %.202at79 = call i32 @func2(i32 %.198at79, i32 %.201)
  %.204 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 8
  %.205 = load i32, i32* %.204
  %.207 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 9
  %.208 = load i32, i32* %.207
  %.209at85 = call i32 @func7(i32 %.208)
  %.210at85 = call i32 @func3(i32 %.205, i32 %.209at85)
  %.211 = load i32, i32* %.130
  %.212at79 = call i32 @func1(i32 %.202at79, i32 %.210at85, i32 %.211)
  %.213at73 = call i32 @func4(i32 %.172at73, i32 %.174, i32 %.212at79)
  %.214 = load i32, i32* %.134
  %.215 = load i32, i32* %.137
  %.216at86 = call i32 @func7(i32 %.215)
  %.217 = load i32, i32* %.140
  %.218at86 = call i32 @func3(i32 %.216at86, i32 %.217)
  %.219at86 = call i32 @func2(i32 %.214, i32 %.218at86)
  %.220at73 = call i32 @func3(i32 %.213at73, i32 %.219at86)
  %.221 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 0
  %.222 = load i32, i32* %.221
  %.223 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 1
  %.224 = load i32, i32* %.223
  %.225at71 = call i32 @func1(i32 %.220at73, i32 %.222, i32 %.224)
  %.226 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 2
  %.227 = load i32, i32* %.226
  %.228at69 = call i32 @func2(i32 %.225at71, i32 %.227)
  %.229 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 3
  %.230 = load i32, i32* %.229
  %.231 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 4
  %.232 = load i32, i32* %.231
  %.233 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 5
  %.234 = load i32, i32* %.233
  %.235at90 = call i32 @func5(i32 %.234)
  %.236at90 = call i32 @func3(i32 %.232, i32 %.235at90)
  %.237 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 6
  %.238 = load i32, i32* %.237
  %.239at90 = call i32 @func5(i32 %.238)
  %.240at90 = call i32 @func2(i32 %.236at90, i32 %.239at90)
  %.241 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 7
  %.242 = load i32, i32* %.241
  %.243 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 8
  %.244 = load i32, i32* %.243
  %.245at91 = call i32 @func7(i32 %.244)
  %.246at90 = call i32 @func1(i32 %.240at90, i32 %.242, i32 %.245at91)
  %.247 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 9
  %.248 = load i32, i32* %.247
  %.249at92 = call i32 @func5(i32 %.248)
  %.250at90 = call i32 @func2(i32 %.246at90, i32 %.249at92)
  %.251 = load i32, i32* %.130
  %.252at90 = call i32 @func3(i32 %.250at90, i32 %.251)
  %.253at67 = call i32 @func1(i32 %.228at69, i32 %.230, i32 %.252at90)
  store i32 %.253at67, i32* %.162
  %.255 = load i32, i32* %.162
  ret i32 %.255 
}
define i32 @func1(i32 %.3, i32 %.6, i32 %.9){
.1:
  %.8 = alloca i32
  %.5 = alloca i32
  %.2 = alloca i32
  store i32 %.3, i32* %.2
  store i32 %.6, i32* %.5
  store i32 %.9, i32* %.8
  %.13 = load i32, i32* %.8
  %.15 = icmp eq i32 %.13, 0
  br i1 %.15, label %.11, label %.12
.11:
  %.17 = load i32, i32* %.2
  %.18 = load i32, i32* %.5
  %.19 = mul i32 %.17, %.18
  ret i32 %.19 
.12:
  %.21 = load i32, i32* %.2
  %.22 = load i32, i32* %.5
  %.23 = load i32, i32* %.8
  %.24 = sub i32 %.22, %.23
  %.25at6 = call i32 @func1(i32 %.21, i32 %.24, i32 0)
  ret i32 %.25at6 
}
define i32 @func2(i32 %.30, i32 %.33){
.28:
  %.32 = alloca i32
  %.29 = alloca i32
  store i32 %.30, i32* %.29
  store i32 %.33, i32* %.32
  %.37 = load i32, i32* %.32
  %.38 = icmp ne i32 %.37, 0
  br i1 %.38, label %.35, label %.36
.35:
  %.40 = load i32, i32* %.29
  %.41 = load i32, i32* %.32
  %.42 = srem i32 %.40, %.41
  %.43at12 = call i32 @func2(i32 %.42, i32 0)
  ret i32 %.43at12 
.36:
  %.45 = load i32, i32* %.29
  ret i32 %.45 
}
define i32 @func3(i32 %.50, i32 %.53){
.48:
  %.52 = alloca i32
  %.49 = alloca i32
  store i32 %.50, i32* %.49
  store i32 %.53, i32* %.52
  %.57 = load i32, i32* %.52
  %.58 = icmp eq i32 %.57, 0
  br i1 %.58, label %.55, label %.56
.55:
  %.60 = load i32, i32* %.49
  %.62 = add i32 %.60, 1
  ret i32 %.62 
.56:
  %.64 = load i32, i32* %.49
  %.65 = load i32, i32* %.52
  %.66 = add i32 %.64, %.65
  %.67at24 = call i32 @func3(i32 %.66, i32 0)
  ret i32 %.67at24 
}
define i32 @func4(i32 %.72, i32 %.75, i32 %.78){
.70:
  %.77 = alloca i32
  %.74 = alloca i32
  %.71 = alloca i32
  store i32 %.72, i32* %.71
  store i32 %.75, i32* %.74
  store i32 %.78, i32* %.77
  %.82 = load i32, i32* %.71
  %.83 = icmp ne i32 %.82, 0
  br i1 %.83, label %.80, label %.81
.80:
  %.85 = load i32, i32* %.74
  ret i32 %.85 
.81:
  %.87 = load i32, i32* %.77
  ret i32 %.87 
}
define i32 @func5(i32 %.92){
.90:
  %.91 = alloca i32
  store i32 %.92, i32* %.91
  %.94 = load i32, i32* %.91
  %.95 = sub i32 0, %.94
  ret i32 %.95 
}
define i32 @func6(i32 %.100, i32 %.103){
.98:
  %.102 = alloca i32
  %.99 = alloca i32
  store i32 %.100, i32* %.99
  store i32 %.103, i32* %.102
  %.107 = load i32, i32* %.99
  %.108 = icmp ne i32 %.107, 0
  br i1 %.108, label %.109, label %.106
.105:
  ret i32 1 
.106:
  ret i32 0 
.109:
  %.111 = load i32, i32* %.102
  %.112 = icmp ne i32 %.111, 0
  br i1 %.112, label %.105, label %.106
}
define i32 @func7(i32 %.119){
.117:
  %.118 = alloca i32
  store i32 %.119, i32* %.118
  %.123 = load i32, i32* %.118
  %.124 = icmp eq i32 %.123, 0
  br i1 %.124, label %.121, label %.122
.121:
  ret i32 1 
.122:
  ret i32 0 
}
define i32 @main(){
.129:
  %.162 = alloca i32
  %.145 = alloca i32
  %.144 = alloca [10 x i32]
  %.140 = alloca i32
  %.137 = alloca i32
  %.134 = alloca i32
  %.130 = alloca i32
  %.132at60 = call i32 @getint()
  store i32 %.132at60, i32* %.130
  %.135at60 = call i32 @getint()
  store i32 %.135at60, i32* %.134
  %.138at60 = call i32 @getint()
  store i32 %.138at60, i32* %.137
  %.141at60 = call i32 @getint()
  store i32 %.141at60, i32* %.140
  store i32 0, i32* %.145
  br label %.147wc63 
.147wc63:
  %.151 = load i32, i32* %.145
  %.152 = icmp slt i32 %.151, 10
  br i1 %.152, label %.148wloop.63.66, label %.149wn66
.148wloop.63.66:
  %.154at64 = call i32 @getint()
  %.155 = load i32, i32* %.145
  %.156 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 %.155
  store i32 %.154at64, i32* %.156
  %.158 = load i32, i32* %.145
  %.159 = add i32 %.158, 1
  store i32 %.159, i32* %.145
  br label %.147wc63 
.149wn66:
  %.163 = load i32, i32* %.130
  %.164at73 = call i32 @func7(i32 %.163)
  %.165 = load i32, i32* %.134
  %.166at73 = call i32 @func5(i32 %.165)
  %.167at73 = call i32 @func6(i32 %.164at73, i32 %.166at73)
  %.168 = load i32, i32* %.137
  %.169at73 = call i32 @func2(i32 %.167at73, i32 %.168)
  %.170 = load i32, i32* %.140
  %.171at73 = call i32 @func3(i32 %.169at73, i32 %.170)
  %.172at73 = call i32 @func5(i32 %.171at73)
  %.173 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 0
  %.174 = load i32, i32* %.173
  %.175 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 1
  %.176 = load i32, i32* %.175
  %.177at79 = call i32 @func5(i32 %.176)
  %.179 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 2
  %.180 = load i32, i32* %.179
  %.182 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 3
  %.183 = load i32, i32* %.182
  %.184at81 = call i32 @func7(i32 %.183)
  %.185at81 = call i32 @func6(i32 %.180, i32 %.184at81)
  %.187 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 4
  %.188 = load i32, i32* %.187
  %.190 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 5
  %.191 = load i32, i32* %.190
  %.192at82 = call i32 @func7(i32 %.191)
  %.193at82 = call i32 @func2(i32 %.188, i32 %.192at82)
  %.194at79 = call i32 @func4(i32 %.177at79, i32 %.185at81, i32 %.193at82)
  %.196 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 6
  %.197 = load i32, i32* %.196
  %.198at79 = call i32 @func3(i32 %.194at79, i32 %.197)
  %.200 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 7
  %.201 = load i32, i32* %.200
  %.202at79 = call i32 @func2(i32 %.198at79, i32 %.201)
  %.204 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 8
  %.205 = load i32, i32* %.204
  %.207 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 9
  %.208 = load i32, i32* %.207
  %.209at85 = call i32 @func7(i32 %.208)
  %.210at85 = call i32 @func3(i32 %.205, i32 %.209at85)
  %.211 = load i32, i32* %.130
  %.212at79 = call i32 @func1(i32 %.202at79, i32 %.210at85, i32 %.211)
  %.213at73 = call i32 @func4(i32 %.172at73, i32 %.174, i32 %.212at79)
  %.214 = load i32, i32* %.134
  %.215 = load i32, i32* %.137
  %.216at86 = call i32 @func7(i32 %.215)
  %.217 = load i32, i32* %.140
  %.218at86 = call i32 @func3(i32 %.216at86, i32 %.217)
  %.219at86 = call i32 @func2(i32 %.214, i32 %.218at86)
  %.220at73 = call i32 @func3(i32 %.213at73, i32 %.219at86)
  %.221 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 0
  %.222 = load i32, i32* %.221
  %.223 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 1
  %.224 = load i32, i32* %.223
  %.225at71 = call i32 @func1(i32 %.220at73, i32 %.222, i32 %.224)
  %.226 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 2
  %.227 = load i32, i32* %.226
  %.228at69 = call i32 @func2(i32 %.225at71, i32 %.227)
  %.229 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 3
  %.230 = load i32, i32* %.229
  %.231 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 4
  %.232 = load i32, i32* %.231
  %.233 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 5
  %.234 = load i32, i32* %.233
  %.235at90 = call i32 @func5(i32 %.234)
  %.236at90 = call i32 @func3(i32 %.232, i32 %.235at90)
  %.237 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 6
  %.238 = load i32, i32* %.237
  %.239at90 = call i32 @func5(i32 %.238)
  %.240at90 = call i32 @func2(i32 %.236at90, i32 %.239at90)
  %.241 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 7
  %.242 = load i32, i32* %.241
  %.243 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 8
  %.244 = load i32, i32* %.243
  %.245at91 = call i32 @func7(i32 %.244)
  %.246at90 = call i32 @func1(i32 %.240at90, i32 %.242, i32 %.245at91)
  %.247 = getelementptr inbounds [10 x i32], [10 x i32]* %.144, i32 0, i32 9
  %.248 = load i32, i32* %.247
  %.249at92 = call i32 @func5(i32 %.248)
  %.250at90 = call i32 @func2(i32 %.246at90, i32 %.249at92)
  %.251 = load i32, i32* %.130
  %.252at90 = call i32 @func3(i32 %.250at90, i32 %.251)
  %.253at67 = call i32 @func1(i32 %.228at69, i32 %.230, i32 %.252at90)
  store i32 %.253at67, i32* %.16