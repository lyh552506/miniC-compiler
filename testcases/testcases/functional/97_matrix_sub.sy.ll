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
@.g.N = global i32 zeroinitializer
@.g.M = global i32 zeroinitializer
@.g.L = global i32 zeroinitializer
define i32 @sub(float* %.6, float* %.9, float* %.12, float* %.15, float* %.18, float* %.21, float* %.24, float* %.27, float* %.30){
.4:
  %.32 = alloca i32
  %.29 = alloca float*
  %.26 = alloca float*
  %.23 = alloca float*
  %.20 = alloca float*
  %.17 = alloca float*
  %.14 = alloca float*
  %.11 = alloca float*
  %.8 = alloca float*
  %.5 = alloca float*
  store float* %.6, float** %.5
  store float* %.9, float** %.8
  store float* %.12, float** %.11
  store float* %.15, float** %.14
  store float* %.18, float** %.17
  store float* %.21, float** %.20
  store float* %.24, float** %.23
  store float* %.27, float** %.26
  store float* %.30, float** %.29
  store i32 0, i32* %.32
  br label %.35wc9 
.35wc9:
  %.39 = load i32, i32* %.32
  %.41 = icmp slt i32 %.39, 3
  br i1 %.41, label %.36wloop.9.15, label %.37wn15
.36wloop.9.15:
  %.43 = load i32, i32* %.32
  %.44 = load float*, float** %.5
  %.45 = getelementptr inbounds float, float* %.44, i32 %.43
  %.46 = load float, float* %.45
  %.47 = load i32, i32* %.32
  %.48 = load float*, float** %.14
  %.49 = getelementptr inbounds float, float* %.48, i32 %.47
  %.50 = load float, float* %.49
  %.51 = fsub float %.46, %.50
  %.52 = load i32, i32* %.32
  %.53 = load float*, float** %.23
  %.54 = getelementptr inbounds float, float* %.53, i32 %.52
  store float %.51, float* %.54
  %.56 = load i32, i32* %.32
  %.57 = load float*, float** %.8
  %.58 = getelementptr inbounds float, float* %.57, i32 %.56
  %.59 = load float, float* %.58
  %.60 = load i32, i32* %.32
  %.61 = load float*, float** %.17
  %.62 = getelementptr inbounds float, float* %.61, i32 %.60
  %.63 = load float, float* %.62
  %.64 = fsub float %.59, %.63
  %.65 = load i32, i32* %.32
  %.66 = load float*, float** %.26
  %.67 = getelementptr inbounds float, float* %.66, i32 %.65
  store float %.64, float* %.67
  %.69 = load i32, i32* %.32
  %.70 = load float*, float** %.11
  %.71 = getelementptr inbounds float, float* %.70, i32 %.69
  %.72 = load float, float* %.71
  %.73 = load i32, i32* %.32
  %.74 = load float*, float** %.20
  %.75 = getelementptr inbounds float, float* %.74, i32 %.73
  %.76 = load float, float* %.75
  %.77 = fsub float %.72, %.76
  %.78 = load i32, i32* %.32
  %.79 = load float*, float** %.29
  %.80 = getelementptr inbounds float, float* %.79, i32 %.78
  store float %.77, float* %.80
  %.82 = load i32, i32* %.32
  %.84 = add i32 %.82, 1
  store i32 %.84, i32* %.32
  br label %.35wc9 
.37wn15:
  ret i32 0 
}
define i32 @main(){
.89:
  %.157 = alloca i32
  %.103 = alloca i32
  %.102 = alloca [3 x float]
  %.101 = alloca [3 x float]
  %.100 = alloca [6 x float]
  %.98 = alloca [3 x float]
  %.97 = alloca [3 x float]
  %.96 = alloca [3 x float]
  %.95 = alloca [3 x float]
  %.94 = alloca [3 x float]
  %.93 = alloca [3 x float]
  store i32 3, i32* @.g.N
  store i32 3, i32* @.g.M
  store i32 3, i32* @.g.L
  store i32 0, i32* %.103
  br label %.105wc29 
.105wc29:
  %.109 = load i32, i32* %.103
  %.110 = icmp slt i32 %.109, 3
  br i1 %.110, label %.106wloop.29.38, label %.107wn38
.106wloop.29.38:
  %.112 = load i32, i32* %.103
  %.113 = load i32, i32* %.103
  %.114 = getelementptr inbounds [3 x float], [3 x float]* %.93, i32 0, i32 %.113
  %.115 = sitofp i32 %.112 to float
  store float %.115, float* %.114
  %.117 = load i32, i32* %.103
  %.118 = load i32, i32* %.103
  %.119 = getelementptr inbounds [3 x float], [3 x float]* %.94, i32 0, i32 %.118
  %.120 = sitofp i32 %.117 to float
  store float %.120, float* %.119
  %.122 = load i32, i32* %.103
  %.123 = load i32, i32* %.103
  %.124 = getelementptr inbounds [3 x float], [3 x float]* %.95, i32 0, i32 %.123
  %.125 = sitofp i32 %.122 to float
  store float %.125, float* %.124
  %.127 = load i32, i32* %.103
  %.128 = load i32, i32* %.103
  %.129 = getelementptr inbounds [3 x float], [3 x float]* %.96, i32 0, i32 %.128
  %.130 = sitofp i32 %.127 to float
  store float %.130, float* %.129
  %.132 = load i32, i32* %.103
  %.133 = load i32, i32* %.103
  %.134 = getelementptr inbounds [3 x float], [3 x float]* %.97, i32 0, i32 %.133
  %.135 = sitofp i32 %.132 to float
  store float %.135, float* %.134
  %.137 = load i32, i32* %.103
  %.138 = load i32, i32* %.103
  %.139 = getelementptr inbounds [3 x float], [3 x float]* %.98, i32 0, i32 %.138
  %.140 = sitofp i32 %.137 to float
  store float %.140, float* %.139
  %.142 = load i32, i32* %.103
  %.143 = add i32 %.142, 1
  store i32 %.143, i32* %.103
  br label %.105wc29 
.107wn38:
  %.146 = getelementptr inbounds [3 x float], [3 x float]* %.93, i32 0, i32 0
  %.147 = getelementptr inbounds [3 x float], [3 x float]* %.94, i32 0, i32 0
  %.148 = getelementptr inbounds [3 x float], [3 x float]* %.95, i32 0, i32 0
  %.149 = getelementptr inbounds [3 x float], [3 x float]* %.96, i32 0, i32 0
  %.150 = getelementptr inbounds [3 x float], [3 x float]* %.97, i32 0, i32 0
  %.151 = getelementptr inbounds [3 x float], [3 x float]* %.98, i32 0, i32 0
  %.152 = getelementptr inbounds [6 x float], [6 x float]* %.100, i32 0, i32 0
  %.153 = getelementptr inbounds [3 x float], [3 x float]* %.101, i32 0, i32 0
  %.154 = getelementptr inbounds [3 x float], [3 x float]* %.102, i32 0, i32 0
  %.155at39 = call i32 @sub(float* %.146, float* %.147, float* %.148, float* %.149, float* %.150, float* %.151, float* %.152, float* %.153, float* %.154)
  store i32 %.155at39, i32* %.103
  br label %.158wc41 
.158wc41:
  %.162 = load i32, i32* %.103
  %.163 = icmp slt i32 %.162, 3
  br i1 %.163, label %.159wloop.41.47, label %.160wn47
.159wloop.41.47:
  %.165 = load i32, i32* %.103
  %.166 = getelementptr inbounds [6 x float], [6 x float]* %.100, i32 0, i32 %.165
  %.167 = load float, float* %.166
  %.168 = fptosi float %.167 to i32
  store i32 %.168, i32* %.157
  %.170 = load i32, i32* %.157
  call void @putint(i32 %.170)
  %.173 = load i32, i32* %.103
  %.174 = add i32 %.173, 1
  store i32 %.174, i32* %.103
  br label %.158wc41 
.160wn47:
  store i32 10, i32* %.157
  store i32 0, i32* %.103
  %.180 = load i32, i32* %.157
  call void @putch(i32 %.180)
  br label %.183wc51 
.183wc51:
  %.187 = load i32, i32* %.103
  %.188 = icmp slt i32 %.187, 3
  br i1 %.188, label %.184wloop.51.57, label %.185wn57
.184wloop.51.57:
  %.190 = load i32, i32* %.103
  %.191 = getelementptr inbounds [3 x float], [3 x float]* %.101, i32 0, i32 %.190
  %.192 = load float, float* %.191
  %.193 = fptosi float %.192 to i32
  store i32 %.193, i32* %.157
  %.195 = load i32, i32* %.157
  call void @putint(i32 %.195)
  %.197 = load i32, i32* %.103
  %.198 = add i32 %.197, 1
  store i32 %.198, i32* %.103
  br label %.183wc51 
.185wn57:
  store i32 10, i32* %.157
  store i32 0, i32* %.103
  %.203 = load i32, i32* %.157
  call void @putch(i32 %.203)
  br label %.205wc61 
.205wc61:
  %.209 = load i32, i32* %.103
  %.210 = icmp slt i32 %.209, 3
  br i1 %.210, label %.206wloop.61.67, label %.207wn67
.206wloop.61.67:
  %.212 = load i32, i32* %.103
  %.213 = getelementptr inbounds [3 x float], [3 x float]* %.102, i32 0, i32 %.212
  %.214 = load float, float* %.213
  %.215 = fptosi float %.214 to i32
  store i32 %.215, i32* %.157
  %.217 = load i32, i32* %.157
  call void @putint(i32 %.217)
  %.219 = load i32, i32* %.103
  %.220 = add i32 %.219, 1
  store i32 %.220, i32* %.103
  br label %.205wc61 
.207wn67:
  store i32 10, i32* %.157
  %.224 = load i32, i32* %.157
  call void @putch(i32 %.224)
  ret i32 0 
}
@.g.N = global i32 zeroinitializer
@.g.M = global i32 zeroinitializer
@.g.L = global i32 zeroinitializer
define i32 @sub(float* %.6, float* %.9, float* %.12, float* %.15, float* %.18, float* %.21, float* %.24, float* %.27, float* %.30){
.4:
  %.32 = alloca i32
  %.29 = alloca float*
  %.26 = alloca float*
  %.23 = alloca float*
  %.20 = alloca float*
  %.17 = alloca float*
  %.14 = alloca float*
  %.11 = alloca float*
  %.8 = alloca float*
  %.5 = alloca float*
  store float* %.6, float** %.5
  store float* %.9, float** %.8
  store float* %.12, float** %.11
  store float* %.15, float** %.14
  store float* %.18, float** %.17
  store float* %.21, float** %.20
  store float* %.24, float** %.23
  store float* %.27, float** %.26
  store float* %.30, float** %.29
  store i32 0, i32* %.32
  br label %.35wc9 
.35wc9:
  %.39 = load i32, i32* %.32
  %.41 = icmp slt i32 %.39, 3
  br i1 %.41, label %.36wloop.9.15, label %.37wn15
.36wloop.9.15:
  %.43 = load i32, i32* %.32
  %.44 = load float*, float** %.5
  %.45 = getelementptr inbounds float, float* %.44, i32 %.43
  %.46 = load float, float* %.45
  %.47 = load i32, i32* %.32
  %.48 = load float*, float** %.14
  %.49 = getelementptr inbounds float, float* %.48, i32 %.47
  %.50 = load float, float* %.49
  %.51 = fsub float %.46, %.50
  %.52 = load i32, i32* %.32
  %.53 = load float*, float** %.23
  %.54 = getelementptr inbounds float, float* %.53, i32 %.52
  store float %.51, float* %.54
  %.56 = load i32, i32* %.32
  %.57 = load float*, float** %.8
  %.58 = getelementptr inbounds float, float* %.57, i32 %.56
  %.59 = load float, float* %.58
  %.60 = load i32, i32* %.32
  %.61 = load float*, float** %.17
  %.62 = getelementptr inbounds float, float* %.61, i32 %.60
  %.63 = load float, float* %.62
  %.64 = fsub float %.59, %.63
  %.65 = load i32, i32* %.32
  %.66 = load float*, float** %.26
  %.67 = getelementptr inbounds float, float* %.66, i32 %.65
  store float %.64, float* %.67
  %.69 = load i32, i32* %.32
  %.70 = load float*, float** %.11
  %.71 = getelementptr inbounds float, float* %.70, i32 %.69
  %.72 = load float, float* %.71
  %.73 = load i32, i32* %.32
  %.74 = load float*, float** %.20
  %.75 = getelementptr inbounds float, float* %.74, i32 %.73
  %.76 = load float, float* %.75
  %.77 = fsub float %.72, %.76
  %.78 = load i32, i32* %.32
  %.79 = load float*, float** %.29
  %.80 = getelementptr inbounds float, float* %.79, i32 %.78
  store float %.77, float* %.80
  %.82 = load i32, i32* %.32
  %.84 = add i32 %.82, 1
  store i32 %.84, i32* %.32
  br label %.35wc9 
.37wn15:
  ret i32 0 
}
define i32 @main(){
.89:
  %.157 = alloca i32
  %.103 = alloca i32
  %.102 = alloca [3 x float]
  %.101 = alloca [3 x float]
  %.100 = alloca [6 x float]
  %.98 = alloca [3 x float]
  %.97 = alloca [3 x float]
  %.96 = alloca [3 x float]
  %.95 = alloca [3 x float]
  %.94 = alloca [3 x float]
  %.93 = alloca [3 x float]
  store i32 3, i32* @.g.N
  store i32 3, i32* @.g.M
  store i32 3, i32* @.g.L
  store i32 0, i32* %.103
  br label %.105wc29 
.105wc29:
  %.109 = load i32, i32* %.103
  %.110 = icmp slt i32 %.109, 3
  br i1 %.110, label %.106wloop.29.38, label %.107wn38
.106wloop.29.38:
  %.112 = load i32, i32* %.103
  %.113 = load i32, i32* %.103
  %.114 = getelementptr inbounds [3 x float], [3 x float]* %.93, i32 0, i32 %.113
  %.115 = sitofp i32 %.112 to float
  store float %.115, float* %.114
  %.117 = load i32, i32* %.103
  %.118 = load i32, i32* %.103
  %.119 = getelementptr inbounds [3 x float], [3 x float]* %.94, i32 0, i32 %.118
  %.120 = sitofp i32 %.117 to float
  store float %.120, float* %.119
  %.122 = load i32, i32* %.103
  %.123 = load i32, i32* %.103
  %.124 = getelementptr inbounds [3 x float], [3 x float]* %.95, i32 0, i32 %.123
  %.125 = sitofp i32 %.122 to float
  store float %.125, float* %.124
  %.127 = load i32, i32* %.103
  %.128 = load i32, i32* %.103
  %.129 = getelementptr inbounds [3 x float], [3 x float]* %.96, i32 0, i32 %.128
  %.130 = sitofp i32 %.127 to float
  store float %.130, float* %.129
  %.132 = load i32, i32* %.103
  %.133 = load i32, i32* %.103
  %.134 = getelementptr inbounds [3 x float], [3 x float]* %.97, i32 0, i32 %.133
  %.135 = sitofp i32 %.132 to float
  store float %.135, float* %.134
  %.137 = load i32, i32* %.103
  %.138 = load i32, i32* %.103
  %.139 = getelementptr inbounds [3 x float], [3 x float]* %.98, i32 0, i32 %.138
  %.140 = sitofp i32 %.137 to float
  store float %.140, float* %.139
  %.142 = load i32, i32* %.103
  %.143 = add i32 %.142, 1
  store i32 %.143, i32* %.103
  br label %.105wc29 
.107wn38:
  %.146 = getelementptr inbounds [3 x float], [3 x float]* %.93, i32 0, i32 0
  %.147 = getelementptr inbounds [3 x float], [3 x float]* %.94, i32 0, i32 0
  %.148 = getelementptr inbounds [3 x float], [3 x float]* %.95, i32 0, i32 0
  %.149 = getelementptr inbounds [3 x float], [3 x float]* %.96, i32 0, i32 0
  %.150 = getelementptr inbounds [3 x float], [3 x float]* %.97, i32 0, i32 0
  %.151 = getelementptr inbounds [3 x float], [3 x float]* %.98, i32 0, i32 0
  %.152 = getelementptr inbounds [6 x float], [6 x float]* %.100, i32 0, i32 0
  %.153 = getelementptr inbounds [3 x float], [3 x float]* %.101, i32 0, i32 0
  %.154 = getelementptr inbounds [3 x float], [3 x float]* %.102, i32 0, i32 0
  %.155at39 = call i32 @sub(float* %.146, float* %.147, float* %.148, float* %.149, float* %.150, float* %.151, float* %.152, float* %.153, float* %.154)
  store i32 %.155at39, i32* %.103
  br label %.158wc41 
.158wc41:
  %.162 = load i32, i32* %.103
  %.163 = icmp slt i32 %.162, 3
  br i1 %.163, label %.159wloop.41.47, label %.160wn47
.159wloop.41.47:
  %.165 = load i32, i32* %.103
  %.166 = getelementptr inbounds [6 x float], [6 x float]* %.100, i32 0, i32 %.165
  %.167 = load float, float* %.166
  %.168 = fptosi float %.167 to i32
  store i32 %.168, i32* %.157
  %.170 = load i32, i32* %.157
  call void @putint(i32 %.170)
  %.173 = load i32, i32* %.103
  %.174 = add i32 %.173, 1
  store i32 %.174, i32* %.103
  br label %.158wc41 
.160wn47:
  store i32 10, i32* %.157
  store i32 0, i32* %.103
  %.180 = load i32, i32* %.157
  call void @putch(i32 %.180)
  br label %.183wc51 
.183wc51:
  %.187 = load i32, i32* %.103
  %.188 = icmp slt i32 %.187, 3
  br i1 %.188, label %.184wloop.51.57, label %.185wn57
.184wloop.51.57:
  %.190 = load i32, i32* %.103
  %.191 = getelementptr inbounds [3 x float], [3 x float]* %.101, i32 0, i32 %.190
  %.192 = load float, float* %.191
  %.193 = fptosi float %.192 to i32
  store i32 %.193, i32* %.157
  %.195 = load i32, i32* %.157
  call void @putint(i32 %.195)
  %.197 = load i32, i32* %.103
  %.198 = add i32 %.197, 1
  store i32 %.198, i32* %.103
  br label %.183wc51 
.185wn57:
  store i32 10, i32* %.157
  store i32 0, i32* %.103
  %.203 = load i32, i32* %.157
  call void @putch(i32 %.203)
  br label %.205wc61 
.205wc61:
  %.209 = load i32, i32* %.103
  %.210 = icmp slt i32 %.209, 3
  br i1 %.210, label %.206wloop.61.67, label %.207wn67
.206wloop.61.67:
  %.212 = load i32, i32* %.103
  %.213 = getelementptr inbounds [3 x float], [3 x float]* %.102, i32 0, i32 %.212
  %.214 = load float, float* %.213
  %.215 = fptosi float %.214 to i32
  store i32 %.215, i32* %.157
  %.217 = load i32, i32* %.157
  call void @putint(i32 %.217)
  %.219 = load i32, i32* %.103
  %.220 = add i32 %.219, 1
  store i32 %.220, i32*