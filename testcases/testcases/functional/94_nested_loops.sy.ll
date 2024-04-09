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
@.g.arr1 = global [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]] zeroinitializer
@.g.arr2 = global [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]] zeroinitializer
define void @loop1(i32 %.13, i32 %.16){
.11:
  %.24 = alloca i32
  %.23 = alloca i32
  %.22 = alloca i32
  %.21 = alloca i32
  %.20 = alloca i32
  %.19 = alloca i32
  %.18 = alloca i32
  %.15 = alloca i32
  %.12 = alloca i32
  store i32 %.13, i32* %.12
  store i32 %.16, i32* %.15
  store i32 0, i32* %.18
  br label %.27wc7 
.27wc7:
  %.31 = load i32, i32* %.18
  %.32 = load i32, i32* %.12
  %.33 = icmp slt i32 %.31, %.32
  br i1 %.33, label %.34, label %.29wn34
.28wloop.7.34:
  store i32 0, i32* %.19
  br label %.41wc9 
.29wn34:
  ret void
.34:
  %.36 = load i32, i32* %.18
  %.37 = load i32, i32* %.15
  %.38 = icmp slt i32 %.36, %.37
  br i1 %.38, label %.28wloop.7.34, label %.29wn34
.41wc9:
  %.45 = load i32, i32* %.19
  %.46 = icmp slt i32 %.45, 2
  br i1 %.46, label %.42wloop.9.32, label %.43wn32
.42wloop.9.32:
  store i32 0, i32* %.20
  br label %.49wc11 
.43wn32:
  %.139 = load i32, i32* %.18
  %.140 = add i32 %.139, 1
  store i32 %.140, i32* %.18
  br label %.27wc7 
.49wc11:
  %.53 = load i32, i32* %.20
  %.54 = icmp slt i32 %.53, 3
  br i1 %.54, label %.50wloop.11.30, label %.51wn30
.50wloop.11.30:
  store i32 0, i32* %.21
  br label %.57wc13 
.51wn30:
  %.135 = load i32, i32* %.19
  %.136 = add i32 %.135, 1
  store i32 %.136, i32* %.19
  br label %.41wc9 
.57wc13:
  %.61 = load i32, i32* %.21
  %.62 = icmp slt i32 %.61, 4
  br i1 %.62, label %.58wloop.13.28, label %.59wn28
.58wloop.13.28:
  store i32 0, i32* %.22
  br label %.65wc15 
.59wn28:
  %.131 = load i32, i32* %.20
  %.132 = add i32 %.131, 1
  store i32 %.132, i32* %.20
  br label %.49wc11 
.65wc15:
  %.69 = load i32, i32* %.22
  %.70 = icmp slt i32 %.69, 5
  br i1 %.70, label %.66wloop.15.26, label %.67wn26
.66wloop.15.26:
  store i32 0, i32* %.23
  br label %.73wc17 
.67wn26:
  %.127 = load i32, i32* %.21
  %.128 = add i32 %.127, 1
  store i32 %.128, i32* %.21
  br label %.57wc13 
.73wc17:
  %.77 = load i32, i32* %.23
  %.78 = icmp slt i32 %.77, 6
  br i1 %.78, label %.74wloop.17.24, label %.75wn24
.74wloop.17.24:
  store i32 0, i32* %.24
  br label %.81wc19 
.75wn24:
  %.123 = load i32, i32* %.22
  %.124 = add i32 %.123, 1
  store i32 %.124, i32* %.22
  br label %.65wc15 
.81wc19:
  %.85 = load i32, i32* %.24
  %.86 = icmp slt i32 %.85, 2
  br i1 %.86, label %.82wloop.19.22, label %.83wn22
.82wloop.19.22:
  %.88 = load i32, i32* %.18
  %.89 = load i32, i32* %.19
  %.90 = add i32 %.88, %.89
  %.91 = load i32, i32* %.20
  %.92 = add i32 %.90, %.91
  %.93 = load i32, i32* %.21
  %.94 = add i32 %.92, %.93
  %.95 = load i32, i32* %.22
  %.96 = add i32 %.94, %.95
  %.97 = load i32, i32* %.23
  %.98 = add i32 %.96, %.97
  %.99 = load i32, i32* %.24
  %.100 = add i32 %.98, %.99
  %.101 = load i32, i32* %.12
  %.102 = add i32 %.100, %.101
  %.103 = load i32, i32* %.15
  %.104 = add i32 %.102, %.103
  %.105 = load i32, i32* %.18
  %.106 = load i32, i32* %.19
  %.107 = load i32, i32* %.20
  %.108 = load i32, i32* %.21
  %.109 = load i32, i32* %.22
  %.110 = load i32, i32* %.23
  %.111 = load i32, i32* %.24
  %.112 = getelementptr inbounds [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]], [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]]* @.g.arr1, i32 0, i32 %.105, i32 %.106, i32 %.107, i32 %.108, i32 %.109, i32 %.110, i32 %.111
  store i32 %.104, i32* %.112
  %.114 = load i32, i32* %.24
  %.116 = add i32 %.114, 1
  store i32 %.116, i32* %.24
  br label %.81wc19 
.83wn22:
  %.119 = load i32, i32* %.23
  %.120 = add i32 %.119, 1
  store i32 %.120, i32* %.23
  br label %.73wc17 
}
define void @loop2(){
.145:
  %.152 = alloca i32
  %.151 = alloca i32
  %.150 = alloca i32
  %.149 = alloca i32
  %.148 = alloca i32
  %.147 = alloca i32
  %.146 = alloca i32
  store i32 0, i32* %.146
  br label %.154wc40 
.154wc40:
  %.158 = load i32, i32* %.146
  %.159 = icmp slt i32 %.158, 10
  br i1 %.159, label %.155wloop.40.67, label %.156wn67
.155wloop.40.67:
  store i32 0, i32* %.147
  br label %.162wc42 
.156wn67:
  ret void
.162wc42:
  %.166 = load i32, i32* %.147
  %.167 = icmp slt i32 %.166, 2
  br i1 %.167, label %.163wloop.42.65, label %.164wn65
.163wloop.42.65:
  store i32 0, i32* %.148
  br label %.170wc44 
.164wn65:
  %.249 = load i32, i32* %.146
  %.250 = add i32 %.249, 1
  store i32 %.250, i32* %.146
  br label %.154wc40 
.170wc44:
  %.174 = load i32, i32* %.148
  %.175 = icmp slt i32 %.174, 3
  br i1 %.175, label %.171wloop.44.63, label %.172wn63
.171wloop.44.63:
  store i32 0, i32* %.149
  br label %.178wc46 
.172wn63:
  %.245 = load i32, i32* %.147
  %.246 = add i32 %.245, 1
  store i32 %.246, i32* %.147
  br label %.162wc42 
.178wc46:
  %.182 = load i32, i32* %.149
  %.183 = icmp slt i32 %.182, 2
  br i1 %.183, label %.179wloop.46.61, label %.180wn61
.179wloop.46.61:
  store i32 0, i32* %.150
  br label %.186wc48 
.180wn61:
  %.241 = load i32, i32* %.148
  %.242 = add i32 %.241, 1
  store i32 %.242, i32* %.148
  br label %.170wc44 
.186wc48:
  %.190 = load i32, i32* %.150
  %.191 = icmp slt i32 %.190, 4
  br i1 %.191, label %.187wloop.48.59, label %.188wn59
.187wloop.48.59:
  store i32 0, i32* %.151
  br label %.194wc50 
.188wn59:
  %.237 = load i32, i32* %.149
  %.238 = add i32 %.237, 1
  store i32 %.238, i32* %.149
  br label %.178wc46 
.194wc50:
  %.198 = load i32, i32* %.151
  %.199 = icmp slt i32 %.198, 8
  br i1 %.199, label %.195wloop.50.57, label %.196wn57
.195wloop.50.57:
  store i32 0, i32* %.152
  br label %.202wc52 
.196wn57:
  %.233 = load i32, i32* %.150
  %.234 = add i32 %.233, 1
  store i32 %.234, i32* %.150
  br label %.186wc48 
.202wc52:
  %.206 = load i32, i32* %.152
  %.207 = icmp slt i32 %.206, 7
  br i1 %.207, label %.203wloop.52.55, label %.204wn55
.203wloop.52.55:
  %.209 = load i32, i32* %.146
  %.210 = load i32, i32* %.147
  %.211 = add i32 %.209, %.210
  %.212 = load i32, i32* %.149
  %.213 = add i32 %.211, %.212
  %.214 = load i32, i32* %.152
  %.215 = add i32 %.213, %.214
  %.216 = load i32, i32* %.146
  %.217 = load i32, i32* %.147
  %.218 = load i32, i32* %.148
  %.219 = load i32, i32* %.149
  %.220 = load i32, i32* %.150
  %.221 = load i32, i32* %.151
  %.222 = load i32, i32* %.152
  %.223 = getelementptr inbounds [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]], [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]]* @.g.arr2, i32 0, i32 %.216, i32 %.217, i32 %.218, i32 %.219, i32 %.220, i32 %.221, i32 %.222
  store i32 %.215, i32* %.223
  %.225 = load i32, i32* %.152
  %.226 = add i32 %.225, 1
  store i32 %.226, i32* %.152
  br label %.202wc52 
.204wn55:
  %.229 = load i32, i32* %.151
  %.230 = add i32 %.229, 1
  store i32 %.230, i32* %.151
  br label %.194wc50 
}
define i32 @loop3(i32 %.257, i32 %.260, i32 %.263, i32 %.266, i32 %.269, i32 %.272, i32 %.275){
.255:
  %.284 = alloca i32
  %.283 = alloca i32
  %.282 = alloca i32
  %.281 = alloca i32
  %.280 = alloca i32
  %.279 = alloca i32
  %.278 = alloca i32
  %.277 = alloca i32
  %.274 = alloca i32
  %.271 = alloca i32
  %.268 = alloca i32
  %.265 = alloca i32
  %.262 = alloca i32
  %.259 = alloca i32
  %.256 = alloca i32
  store i32 %.257, i32* %.256
  store i32 %.260, i32* %.259
  store i32 %.263, i32* %.262
  store i32 %.266, i32* %.265
  store i32 %.269, i32* %.268
  store i32 %.272, i32* %.271
  store i32 %.275, i32* %.274
  store i32 0, i32* %.284
  store i32 0, i32* %.277
  br label %.287wc74 
.287wc74:
  %.291 = load i32, i32* %.277
  %.292 = icmp slt i32 %.291, 10
  br i1 %.292, label %.288wloop.74.108, label %.289wn108
.288wloop.74.108:
  store i32 0, i32* %.278
  br label %.295wc76 
.289wn108:
  %.449 = load i32, i32* %.284
  ret i32 %.449 
.295wc76:
  %.299 = load i32, i32* %.278
  %.301 = icmp slt i32 %.299, 100
  br i1 %.301, label %.296wloop.76.105, label %.297wn105
.296wloop.76.105:
  store i32 0, i32* %.279
  br label %.304wc78 
.297wn105:
  %.438 = load i32, i32* %.277
  %.439 = add i32 %.438, 1
  store i32 %.439, i32* %.277
  %.443 = load i32, i32* %.277
  %.444 = load i32, i32* %.256
  %.445 = icmp sge i32 %.443, %.444
  br i1 %.445, label %.441, label %.442
.304wc78:
  %.308 = load i32, i32* %.279
  %.310 = icmp slt i32 %.308, 1000
  br i1 %.310, label %.305wloop.78.102, label %.306wn102
.305wloop.78.102:
  store i32 0, i32* %.280
  br label %.313wc80 
.306wn102:
  %.427 = load i32, i32* %.278
  %.428 = add i32 %.427, 1
  store i32 %.428, i32* %.278
  %.432 = load i32, i32* %.278
  %.433 = load i32, i32* %.259
  %.434 = icmp sge i32 %.432, %.433
  br i1 %.434, label %.430, label %.431
.313wc80:
  %.317 = load i32, i32* %.280
  %.319 = icmp slt i32 %.317, 10000
  br i1 %.319, label %.314wloop.80.99, label %.315wn99
.314wloop.80.99:
  store i32 0, i32* %.281
  br label %.322wc82 
.315wn99:
  %.416 = load i32, i32* %.279
  %.417 = add i32 %.416, 1
  store i32 %.417, i32* %.279
  %.421 = load i32, i32* %.279
  %.422 = load i32, i32* %.262
  %.423 = icmp sge i32 %.421, %.422
  br i1 %.423, label %.419, label %.420
.322wc82:
  %.326 = load i32, i32* %.281
  %.328 = icmp slt i32 %.326, 100000
  br i1 %.328, label %.323wloop.82.96, label %.324wn96
.323wloop.82.96:
  store i32 0, i32* %.282
  br label %.331wc84 
.324wn96:
  %.405 = load i32, i32* %.280
  %.406 = add i32 %.405, 1
  store i32 %.406, i32* %.280
  %.410 = load i32, i32* %.280
  %.411 = load i32, i32* %.265
  %.412 = icmp sge i32 %.410, %.411
  br i1 %.412, label %.408, label %.409
.331wc84:
  %.335 = load i32, i32* %.282
  %.337 = icmp slt i32 %.335, 1000000
  br i1 %.337, label %.332wloop.84.93, label %.333wn93
.332wloop.84.93:
  store i32 0, i32* %.283
  br label %.340wc86 
.333wn93:
  %.394 = load i32, i32* %.281
  %.395 = add i32 %.394, 1
  store i32 %.395, i32* %.281
  %.399 = load i32, i32* %.281
  %.400 = load i32, i32* %.268
  %.401 = icmp sge i32 %.399, %.400
  br i1 %.401, label %.397, label %.398
.340wc86:
  %.344 = load i32, i32* %.283
  %.346 = icmp slt i32 %.344, 10000000
  br i1 %.346, label %.341wloop.86.90, label %.342wn90
.341wloop.86.90:
  %.348 = load i32, i32* %.284
  %.350 = srem i32 %.348, 817
  %.351 = load i32, i32* %.277
  %.352 = load i32, i32* %.278
  %.353 = load i32, i32* %.279
  %.354 = load i32, i32* %.280
  %.355 = load i32, i32* %.281
  %.356 = load i32, i32* %.282
  %.357 = load i32, i32* %.283
  %.358 = getelementptr inbounds [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]], [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]]* @.g.arr1, i32 0, i32 %.351, i32 %.352, i32 %.353, i32 %.354, i32 %.355, i32 %.356, i32 %.357
  %.359 = load i32, i32* %.358
  %.360 = add i32 %.350, %.359
  %.361 = load i32, i32* %.277
  %.362 = load i32, i32* %.278
  %.363 = load i32, i32* %.279
  %.364 = load i32, i32* %.280
  %.365 = load i32, i32* %.281
  %.366 = load i32, i32* %.282
  %.367 = load i32, i32* %.283
  %.368 = getelementptr inbounds [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]], [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]]* @.g.arr2, i32 0, i32 %.361, i32 %.362, i32 %.363, i32 %.364, i32 %.365, i32 %.366, i32 %.367
  %.369 = load i32, i32* %.368
  %.370 = add i32 %.360, %.369
  store i32 %.370, i32* %.284
  %.372 = load i32, i32* %.283
  %.373 = add i32 %.372, 1
  store i32 %.373, i32* %.283
  %.377 = load i32, i32* %.283
  %.378 = load i32, i32* %.274
  %.379 = icmp sge i32 %.377, %.378
  br i1 %.379, label %.375, label %.376
.342wn90:
  %.383 = load i32, i32* %.282
  %.384 = add i32 %.383, 1
  store i32 %.384, i32* %.282
  %.388 = load i32, i32* %.282
  %.389 = load i32, i32* %.271
  %.390 = icmp sge i32 %.388, %.389
  br i1 %.390, label %.386, label %.387
.375:
  br label %.342wn90 
.376:
  br label %.340wc86 
.386:
  br label %.333wn93 
.387:
  br label %.331wc84 
.397:
  br label %.324wn96 
.398:
  br label %.322wc82 
.408:
  br label %.315wn99 
.409:
  br label %.313wc80 
.419:
  br label %.306wn102 
.420:
  br label %.304wc78 
.430:
  br label %.297wn105 
.431:
  br label %.295wc76 
.441:
  br label %.289wn108 
.442:
  br label %.287wc74 
}
define i32 @main(){
.452:
  %.478 = alloca i32
  %.475 = alloca i32
  %.472 = alloca i32
  %.469 = alloca i32
  %.466 = alloca i32
  %.463 = alloca i32
  %.460 = alloca i32
  %.457 = alloca i32
  %.453 = alloca i32
  %.455at113 = call i32 @getint()
  store i32 %.455at113, i32* %.453
  %.458at114 = call i32 @getint()
  store i32 %.458at114, i32* %.457
  %.461at115 = call i32 @getint()
  store i32 %.461at115, i32* %.460
  %.464at116 = call i32 @getint()
  store i32 %.464at116, i32* %.463
  %.467at116 = call i32 @getint()
  store i32 %.467at116, i32* %.466
  %.470at117 = call i32 @getint()
  store i32 %.470at117, i32* %.469
  %.473at118 = call i32 @getint()
  store i32 %.473at118, i32* %.472
  %.476at119 = call i32 @getint()
  store i32 %.476at119, i32* %.475
  %.479at120 = call i32 @getint()
  store i32 %.479at120, i32* %.478
  %.481 = load i32, i32* %.453
  %.482 = load i32, i32* %.457
  call void @loop1(i32 %.481, i32 %.482)
  call void @loop2()
  %.485 = load i32, i32* %.460
  %.486 = load i32, i32* %.463
  %.487 = load i32, i32* %.466
  %.488 = load i32, i32* %.469
  %.489 = load i32, i32* %.472
  %.490 = load i32, i32* %.475
  %.491 = load i32, i32* %.478
  %.492at123 = call i32 @loop3(i32 %.485, i32 %.486, i32 %.487, i32 %.488, i32 %.489, i32 %.490, i32 %.491)
  ret i32 %.492at123 
}
@.g.arr1 = global [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]] zeroinitializer
@.g.arr2 = global [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]] zeroinitializer
define void @loop1(i32 %.13, i32 %.16){
.11:
  %.24 = alloca i32
  %.23 = alloca i32
  %.22 = alloca i32
  %.21 = alloca i32
  %.20 = alloca i32
  %.19 = alloca i32
  %.18 = alloca i32
  %.15 = alloca i32
  %.12 = alloca i32
  store i32 %.13, i32* %.12
  store i32 %.16, i32* %.15
  store i32 0, i32* %.18
  br label %.27wc7 
.27wc7:
  %.31 = load i32, i32* %.18
  %.32 = load i32, i32* %.12
  %.33 = icmp slt i32 %.31, %.32
  br i1 %.33, label %.34, label %.29wn34
.28wloop.7.34:
  store i32 0, i32* %.19
  br label %.41wc9 
.29wn34:
  ret void
.34:
  %.36 = load i32, i32* %.18
  %.37 = load i32, i32* %.15
  %.38 = icmp slt i32 %.36, %.37
  br i1 %.38, label %.28wloop.7.34, label %.29wn34
.41wc9:
  %.45 = load i32, i32* %.19
  %.46 = icmp slt i32 %.45, 2
  br i1 %.46, label %.42wloop.9.32, label %.43wn32
.42wloop.9.32:
  store i32 0, i32* %.20
  br label %.49wc11 
.43wn32:
  %.139 = load i32, i32* %.18
  %.140 = add i32 %.139, 1
  store i32 %.140, i32* %.18
  br label %.27wc7 
.49wc11:
  %.53 = load i32, i32* %.20
  %.54 = icmp slt i32 %.53, 3
  br i1 %.54, label %.50wloop.11.30, label %.51wn30
.50wloop.11.30:
  store i32 0, i32* %.21
  br label %.57wc13 
.51wn30:
  %.135 = load i32, i32* %.19
  %.136 = add i32 %.135, 1
  store i32 %.136, i32* %.19
  br label %.41wc9 
.57wc13:
  %.61 = load i32, i32* %.21
  %.62 = icmp slt i32 %.61, 4
  br i1 %.62, label %.58wloop.13.28, label %.59wn28
.58wloop.13.28:
  store i32 0, i32* %.22
  br label %.65wc15 
.59wn28:
  %.131 = load i32, i32* %.20
  %.132 = add i32 %.131, 1
  store i32 %.132, i32* %.20
  br label %.49wc11 
.65wc15:
  %.69 = load i32, i32* %.22
  %.70 = icmp slt i32 %.69, 5
  br i1 %.70, label %.66wloop.15.26, label %.67wn26
.66wloop.15.26:
  store i32 0, i32* %.23
  br label %.73wc17 
.67wn26:
  %.127 = load i32, i32* %.21
  %.128 = add i32 %.127, 1
  store i32 %.128, i32* %.21
  br label %.57wc13 
.73wc17:
  %.77 = load i32, i32* %.23
  %.78 = icmp slt i32 %.77, 6
  br i1 %.78, label %.74wloop.17.24, label %.75wn24
.74wloop.17.24:
  store i32 0, i32* %.24
  br label %.81wc19 
.75wn24:
  %.123 = load i32, i32* %.22
  %.124 = add i32 %.123, 1
  store i32 %.124, i32* %.22
  br label %.65wc15 
.81wc19:
  %.85 = load i32, i32* %.24
  %.86 = icmp slt i32 %.85, 2
  br i1 %.86, label %.82wloop.19.22, label %.83wn22
.82wloop.19.22:
  %.88 = load i32, i32* %.18
  %.89 = load i32, i32* %.19
  %.90 = add i32 %.88, %.89
  %.91 = load i32, i32* %.20
  %.92 = add i32 %.90, %.91
  %.93 = load i32, i32* %.21
  %.94 = add i32 %.92, %.93
  %.95 = load i32, i32* %.22
  %.96 = add i32 %.94, %.95
  %.97 = load i32, i32* %.23
  %.98 = add i32 %.96, %.97
  %.99 = load i32, i32* %.24
  %.100 = add i32 %.98, %.99
  %.101 = load i32, i32* %.12
  %.102 = add i32 %.100, %.101
  %.103 = load i32, i32* %.15
  %.104 = add i32 %.102, %.103
  %.105 = load i32, i32* %.18
  %.106 = load i32, i32* %.19
  %.107 = load i32, i32* %.20
  %.108 = load i32, i32* %.21
  %.109 = load i32, i32* %.22
  %.110 = load i32, i32* %.23
  %.111 = load i32, i32* %.24
  %.112 = getelementptr inbounds [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]], [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]]* @.g.arr1, i32 0, i32 %.105, i32 %.106, i32 %.107, i32 %.108, i32 %.109, i32 %.110, i32 %.111
  store i32 %.104, i32* %.112
  %.114 = load i32, i32* %.24
  %.116 = add i32 %.114, 1
  store i32 %.116, i32* %.24
  br label %.81wc19 
.83wn22:
  %.119 = load i32, i32* %.23
  %.120 = add i32 %.119, 1
  store i32 %.120, i32* %.23
  br label %.73wc17 
}
define void @loop2(){
.145:
  %.152 = alloca i32
  %.151 = alloca i32
  %.150 = alloca i32
  %.149 = alloca i32
  %.148 = alloca i32
  %.147 = alloca i32
  %.146 = alloca i32
  store i32 0, i32* %.146
  br label %.154wc40 
.154wc40:
  %.158 = load i32, i32* %.146
  %.159 = icmp slt i32 %.158, 10
  br i1 %.159, label %.155wloop.40.67, label %.156wn67
.155wloop.40.67:
  store i32 0, i32* %.147
  br label %.162wc42 
.156wn67:
  ret void
.162wc42:
  %.166 = load i32, i32* %.147
  %.167 = icmp slt i32 %.166, 2
  br i1 %.167, label %.163wloop.42.65, label %.164wn65
.163wloop.42.65:
  store i32 0, i32* %.148
  br label %.170wc44 
.164wn65:
  %.249 = load i32, i32* %.146
  %.250 = add i32 %.249, 1
  store i32 %.250, i32* %.146
  br label %.154wc40 
.170wc44:
  %.174 = load i32, i32* %.148
  %.175 = icmp slt i32 %.174, 3
  br i1 %.175, label %.171wloop.44.63, label %.172wn63
.171wloop.44.63:
  store i32 0, i32* %.149
  br label %.178wc46 
.172wn63:
  %.245 = load i32, i32* %.147
  %.246 = add i32 %.245, 1
  store i32 %.246, i32* %.147
  br label %.162wc42 
.178wc46:
  %.182 = load i32, i32* %.149
  %.183 = icmp slt i32 %.182, 2
  br i1 %.183, label %.179wloop.46.61, label %.180wn61
.179wloop.46.61:
  store i32 0, i32* %.150
  br label %.186wc48 
.180wn61:
  %.241 = load i32, i32* %.148
  %.242 = add i32 %.241, 1
  store i32 %.242, i32* %.148
  br label %.170wc44 
.186wc48:
  %.190 = load i32, i32* %.150
  %.191 = icmp slt i32 %.190, 4
  br i1 %.191, label %.187wloop.48.59, label %.188wn59
.187wloop.48.59:
  store i32 0, i32* %.151
  br label %.194wc50 
.188wn59:
  %.237 = load i32, i32* %.149
  %.238 = add i32 %.237, 1
  store i32 %.238, i32* %.149
  br label %.178wc46 
.194wc50:
  %.198 = load i32, i32* %.151
  %.199 = icmp slt i32 %.198, 8
  br i1 %.199, label %.195wloop.50.57, label %.196wn57
.195wloop.50.57:
  store i32 0, i32* %.152
  br label %.202wc52 
.196wn57:
  %.233 = load i32, i32* %.150
  %.234 = add i32 %.233, 1
  store i32 %.234, i32* %.150
  br label %.186wc48 
.202wc52:
  %.206 = load i32, i32* %.152
  %.207 = icmp slt i32 %.206, 7
  br i1 %.207, label %.203wloop.52.55, label %.204wn55
.203wloop.52.55:
  %.209 = load i32, i32* %.146
  %.210 = load i32, i32* %.147
  %.211 = add i32 %.209, %.210
  %.212 = load i32, i32* %.149
  %.213 = add i32 %.211, %.212
  %.214 = load i32, i32* %.152
  %.215 = add i32 %.213, %.214
  %.216 = load i32, i32* %.146
  %.217 = load i32, i32* %.147
  %.218 = load i32, i32* %.148
  %.219 = load i32, i32* %.149
  %.220 = load i32, i32* %.150
  %.221 = load i32, i32* %.151
  %.222 = load i32, i32* %.152
  %.223 = getelementptr inbounds [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]], [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]]* @.g.arr2, i32 0, i32 %.216, i32 %.217, i32 %.218, i32 %.219, i32 %.220, i32 %.221, i32 %.222
  store i32 %.215, i32* %.223
  %.225 = load i32, i32* %.152
  %.226 = add i32 %.225, 1
  store i32 %.226, i32* %.152
  br label %.202wc52 
.204wn55:
  %.229 = load i32, i32* %.151
  %.230 = add i32 %.229, 1
  store i32 %.230, i32* %.151
  br label %.194wc50 
}
define i32 @loop3(i32 %.257, i32 %.260, i32 %.263, i32 %.266, i32 %.269, i32 %.272, i32 %.275){
.255:
  %.284 = alloca i32
  %.283 = alloca i32
  %.282 = alloca i32
  %.281 = alloca i32
  %.280 = alloca i32
  %.279 = alloca i32
  %.278 = alloca i32
  %.277 = alloca i32
  %.274 = alloca i32
  %.271 = alloca i32
  %.268 = alloca i32
  %.265 = alloca i32
  %.262 = alloca i32
  %.259 = alloca i32
  %.256 = alloca i32
  store i32 %.257, i32* %.256
  store i32 %.260, i32* %.259
  store i32 %.263, i32* %.262
  store i32 %.266, i32* %.265
  store i32 %.269, i32* %.268
  store i32 %.272, i32* %.271
  store i32 %.275, i32* %.274
  store i32 0, i32* %.284
  store i32 0, i32* %.277
  br label %.287wc74 
.287wc74:
  %.291 = load i32, i32* %.277
  %.292 = icmp slt i32 %.291, 10
  br i1 %.292, label %.288wloop.74.108, label %.289wn108
.288wloop.74.108:
  store i32 0, i32* %.278
  br label %.295wc76 
.289wn108:
  %.449 = load i32, i32* %.284
  ret i32 %.449 
.295wc76:
  %.299 = load i32, i32* %.278
  %.301 = icmp slt i32 %.299, 100
  br i1 %.301, label %.296wloop.76.105, label %.297wn105
.296wloop.76.105:
  store i32 0, i32* %.279
  br label %.304wc78 
.297wn105:
  %.438 = load i32, i32* %.277
  %.439 = add i32 %.438, 1
  store i32 %.439, i32* %.277
  %.443 = load i32, i32* %.277
  %.444 = load i32, i32* %.256
  %.445 = icmp sge i32 %.443, %.444
  br i1 %.445, label %.441, label %.442
.304wc78:
  %.308 = load i32, i32* %.279
  %.310 = icmp slt i32 %.308, 1000
  br i1 %.310, label %.305wloop.78.102, label %.306wn102
.305wloop.78.102:
  store i32 0, i32* %.280
  br label %.313wc80 
.306wn102:
  %.427 = load i32, i32* %.278
  %.428 = add i32 %.427, 1
  store i32 %.428, i32* %.278
  %.432 = load i32, i32* %.278
  %.433 = load i32, i32* %.259
  %.434 = icmp sge i32 %.432, %.433
  br i1 %.434, label %.430, label %.431
.313wc80:
  %.317 = load i32, i32* %.280
  %.319 = icmp slt i32 %.317, 10000
  br i1 %.319, label %.314wloop.80.99, label %.315wn99
.314wloop.80.99:
  store i32 0, i32* %.281
  br label %.322wc82 
.315wn99:
  %.416 = load i32, i32* %.279
  %.417 = add i32 %.416, 1
  store i32 %.417, i32* %.279
  %.421 = load i32, i32* %.279
  %.422 = load i32, i32* %.262
  %.423 = icmp sge i32 %.421, %.422
  br i1 %.423, label %.419, label %.420
.322wc82:
  %.326 = load i32, i32* %.281
  %.328 = icmp slt i32 %.326, 100000
  br i1 %.328, label %.323wloop.82.96, label %.324wn96
.323wloop.82.96:
  store i32 0, i32* %.282
  br label %.331wc84 
.324wn96:
  %.405 = load i32, i32* %.280
  %.406 = add i32 %.405, 1
  store i32 %.406, i32* %.280
  %.410 = load i32, i32* %.280
  %.411 = load i32, i32* %.265
  %.412 = icmp sge i32 %.410, %.411
  br i1 %.412, label %.408, label %.409
.331wc84:
  %.335 = load i32, i32* %.282
  %.337 = icmp slt i32 %.335, 1000000
  br i1 %.337, label %.332wloop.84.93, label %.333wn93
.332wloop.84.93:
  store i32 0, i32* %.283
  br label %.340wc86 
.333wn93:
  %.394 = load i32, i32* %.281
  %.395 = add i32 %.394, 1
  store i32 %.395, i32* %.281
  %.399 = load i32, i32* %.281
  %.400 = load i32, i32* %.268
  %.401 = icmp sge i32 %.399, %.400
  br i1 %.401, label %.397, label %.398
.340wc86:
  %.344 = load i32, i32* %.283
  %.346 = icmp slt i32 %.344, 10000000
  br i1 %.346, label %.341wloop.86.90, label %.342wn90
.341wloop.86.90:
  %.348 = load i32, i32* %.284
  %.350 = srem i32 %.348, 817
  %.351 = load i32, i32* %.277
  %.352 = load i32, i32* %.278
  %.353 = load i32, i32* %.279
  %.354 = load i32, i32* %.280
  %.355 = load i32, i32* %.281
  %.356 = load i32, i32* %.282
  %.357 = load i32, i32* %.283
  %.358 = getelementptr inbounds [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]], [10 x [2 x [3 x [4 x [5 x [6 x [2 x i32]]]]]]]* @.g.arr1, i32 0, i32 %.351, i32 %.352, i32 %.353, i32 %.354, i32 %.355, i32 %.356, i32 %.357
  %.359 = load i32, i32* %.358
  %.360 = add i32 %.350, %.359
  %.361 = load i32, i32* %.277
  %.362 = load i32, i32* %.278
  %.363 = load i32, i32* %.279
  %.364 = load i32, i32* %.280
  %.365 = load i32, i32* %.281
  %.366 = load i32, i32* %.282
  %.367 = load i32, i32* %.283
  %.368 = getelementptr inbounds [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]], [10 x [2 x [3 x [2 x [4 x [8 x [7 x i32]]]]]]]* @.g.arr2, i32 0, i32 %.361, i32 %.362, i32 %.363, i32 %.364, i32 %.365, i32 %.366, i32 %.367
  %.369 = load i32, i32* %.368
  %.370 = add i32 %.360, %.369
  store i32 %.370, i32* %.284
  %.372 = load i32, i32* %.283
  %.373 = add i32 %.372, 1
  store i32 %.373, i32* %.283
  %.377 = load i32, i32* %.283
  %.378 = load i32, i32* %.274
  %.379 = icmp sge i32 %.377, %.378
  br i1 %.379, label %.375, label %.376
.342wn90:
  %.383 = load i32, i32* %.282
  %.384 = add i32 %.383, 1
  store i32 %.384, i32* %.282
  %.388 = load i32, i32* %.282
  %.389 = load i32, i32* %.271
  %.390 = icmp sge i32 %.388, %.389
  br i1 %.390, label %.386, label %.387
.375:
  br label %.342wn90 
.376:
  br label %.340wc86 
.386:
  br label %.333wn93 
.387:
  br label %.331wc84 
.397:
  br label %.324wn96 
.398:
  br label %.322wc82 
.408:
  br label %.315wn99 
.409:
  br label %.313wc80 
.419:
  br label %.306wn102 
.420:
  br label %.304wc78 
.430:
  br label %.297wn105 
.431:
  br label %.295wc76 
.441:
  br label %.289wn108 
.442:
  br label %.287wc74 
}
define i32 @main(){
.452:
  %.478 = alloca i32
  %.475 = alloca i32
  %.472 = alloca i32
  %.469 = alloca i32
  %.466 = alloca i32
  %.463 = alloca i32
  %.460 = alloca i32
  %.457 = alloca i32
  %.453 = alloca i32
  %.455at113 = call i32 @getint()
  store i32 %.455at113, i32* %.453
  %.458at114 = call i32 @getint()
  store i32 %.458at114, i32* %.457
  %.461at115 = call i32 @getint()
  store i32 %.461at115, i32* %.460
  %.464at116 = call i32 @getint()
  store i32 %.464at116, i32* %.463
  %.467at116 = call i32 @getint()
  store i32 %.467at116, i32* %.466
  %.470at117 = call i32 @getint()
  store i32 %.470at117, i32* %.469
  %.473at118 = call i32 @getint()
  store i32 %.473at118, i32* %.472
  %.476at119 = call i32 @getint()
  store i32 %.476at119, i32* %.475
  %.479at120 = call i32 @getint()
  store i32 %.479at120, i32* %.478
  %.481 = load i32, i32* %.453
  %.482 = load i32, i3