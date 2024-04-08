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
@.g.m = global i32 zeroinitializer
@.g.to = global [5005 x i32] zeroinitializer
@.g.next = global [5005 x i32] zeroinitializer
@.g.head = global [1005 x i32] zeroinitializer
@.g.cnt = global i32 0
@.g.que = global [1005 x i32] zeroinitializer
@.g.h = global i32 zeroinitializer
@.g.tail = global i32 zeroinitializer
@.g.inq = global [1005 x i32] zeroinitializer
define i32 @quick_read(){
.1:
  %.9 = alloca i32
  %.6 = alloca i32
  %.2 = alloca i32
  %.4at2 = call i32 @getch()
  store i32 %.4at2, i32* %.2
  store i32 0, i32* %.6
  store i32 0, i32* %.9
  br label %.11wc3 
.11wc3:
  %.16 = load i32, i32* %.2
  %.18 = icmp slt i32 %.16, 48
  br i1 %.18, label %.12wloop.3.6, label %.15
.12wloop.3.6:
  %.26 = load i32, i32* %.2
  %.28 = icmp eq i32 %.26, 45
  br i1 %.28, label %.24, label %.25
.13wn6:
  br label %.36wc7 
.15:
  %.20 = load i32, i32* %.2
  %.22 = icmp sgt i32 %.20, 57
  br i1 %.22, label %.12wloop.3.6, label %.13wn6
.24:
  store i32 1, i32* %.9
  br label %.25 
.25:
  %.33at5 = call i32 @getch()
  store i32 %.33at5, i32* %.2
  br label %.11wc3 
.36wc7:
  %.40 = load i32, i32* %.2
  %.41 = icmp sge i32 %.40, 48
  br i1 %.41, label %.42, label %.38wn10
.37wloop.7.10:
  %.47 = load i32, i32* %.6
  %.49 = mul i32 %.47, 10
  %.50 = load i32, i32* %.2
  %.51 = add i32 %.49, %.50
  %.52 = sub i32 %.51, 48
  store i32 %.52, i32* %.6
  %.54at9 = call i32 @getch()
  store i32 %.54at9, i32* %.2
  br label %.36wc7 
.38wn10:
  %.59 = load i32, i32* %.9
  %.60 = icmp ne i32 %.59, 0
  br i1 %.60, label %.57, label %.58
.42:
  %.44 = load i32, i32* %.2
  %.45 = icmp sle i32 %.44, 57
  br i1 %.45, label %.37wloop.7.10, label %.38wn10
.57:
  %.62 = load i32, i32* %.6
  %.63 = sub i32 0, %.62
  ret i32 %.63 
.58:
  %.65 = load i32, i32* %.6
  ret i32 %.65 
}
define void @add_edge(i32 %.82, i32 %.85){
.80:
  %.84 = alloca i32
  %.81 = alloca i32
  store i32 %.82, i32* %.81
  store i32 %.85, i32* %.84
  %.87 = load i32, i32* %.84
  %.88 = load i32, i32* @.g.cnt
  %.89 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.to, i32 0, i32 %.88
  store i32 %.87, i32* %.89
  %.91 = load i32, i32* %.81
  %.92 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.91
  %.93 = load i32, i32* %.92
  %.94 = load i32, i32* @.g.cnt
  %.95 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.next, i32 0, i32 %.94
  store i32 %.93, i32* %.95
  %.97 = load i32, i32* @.g.cnt
  %.98 = load i32, i32* %.81
  %.99 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.98
  store i32 %.97, i32* %.99
  %.101 = load i32, i32* @.g.cnt
  %.102 = add i32 %.101, 1
  store i32 %.102, i32* @.g.cnt
  %.104 = load i32, i32* %.81
  %.105 = load i32, i32* @.g.cnt
  %.106 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.to, i32 0, i32 %.105
  store i32 %.104, i32* %.106
  %.108 = load i32, i32* %.84
  %.109 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.108
  %.110 = load i32, i32* %.109
  %.111 = load i32, i32* @.g.cnt
  %.112 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.next, i32 0, i32 %.111
  store i32 %.110, i32* %.112
  %.114 = load i32, i32* @.g.cnt
  %.115 = load i32, i32* %.84
  %.116 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.115
  store i32 %.114, i32* %.116
  %.118 = load i32, i32* @.g.cnt
  %.119 = add i32 %.118, 1
  store i32 %.119, i32* @.g.cnt
  ret void
}
define void @init(){
.123:
  %.124 = alloca i32
  store i32 0, i32* %.124
  br label %.126wc31 
.126wc31:
  %.130 = load i32, i32* %.124
  %.131 = icmp slt i32 %.130, 1005
  br i1 %.131, label %.127wloop.31.34, label %.128wn34
.127wloop.31.34:
  %.134 = load i32, i32* %.124
  %.135 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.134
  store i32 -1, i32* %.135
  %.137 = load i32, i32* %.124
  %.138 = add i32 %.137, 1
  store i32 %.138, i32* %.124
  br label %.126wc31 
.128wn34:
  ret void
}
define void @inqueue(i32 %.145){
.143:
  %.144 = alloca i32
  store i32 %.145, i32* %.144
  %.147 = load i32, i32* %.144
  %.148 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.inq, i32 0, i32 %.147
  store i32 1, i32* %.148
  %.150 = load i32, i32* @.g.tail
  %.151 = add i32 %.150, 1
  store i32 %.151, i32* @.g.tail
  %.153 = load i32, i32* %.144
  %.154 = load i32, i32* @.g.tail
  %.155 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.que, i32 0, i32 %.154
  store i32 %.153, i32* %.155
  ret void
}
define i32 @pop_queue(){
.159:
  %.163 = alloca i32
  %.160 = load i32, i32* @.g.h
  %.161 = add i32 %.160, 1
  store i32 %.161, i32* @.g.h
  %.164 = load i32, i32* @.g.h
  %.165 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.que, i32 0, i32 %.164
  %.166 = load i32, i32* %.165
  store i32 %.166, i32* %.163
  %.168 = load i32, i32* @.g.h
  %.169 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.que, i32 0, i32 %.168
  %.170 = load i32, i32* %.169
  ret i32 %.170 
}
define i32 @same(i32 %.175, i32 %.178){
.173:
  %.237 = alloca i32
  %.205 = alloca i32
  %.194 = alloca i32
  %.184 = alloca i32
  %.177 = alloca i32
  %.174 = alloca i32
  store i32 %.175, i32* %.174
  store i32 %.178, i32* %.177
  store i32 0, i32* @.g.h
  store i32 0, i32* @.g.tail
  %.182 = load i32, i32* %.174
  call void @inqueue(i32 %.182)
  store i32 0, i32* %.184
  br label %.186wc51 
.186wc51:
  %.190 = load i32, i32* @.g.h
  %.191 = load i32, i32* @.g.tail
  %.192 = icmp slt i32 %.190, %.191
  br i1 %.192, label %.187wloop.51.59, label %.188wn59
.187wloop.51.59:
  %.195at52 = call i32 @pop_queue()
  store i32 %.195at52, i32* %.194
  %.199 = load i32, i32* %.194
  %.200 = load i32, i32* %.177
  %.201 = icmp eq i32 %.199, %.200
  br i1 %.201, label %.197, label %.198
.188wn59:
  store i32 0, i32* %.237
  br label %.239wc61 
.197:
  store i32 1, i32* %.184
  br label %.198 
.198:
  %.206 = load i32, i32* %.194
  %.207 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.206
  %.208 = load i32, i32* %.207
  store i32 %.208, i32* %.205
  br label %.210wc55 
.210wc55:
  %.214 = load i32, i32* %.205
  %.215 = icmp ne i32 %.214, -1
  br i1 %.215, label %.211wloop.55.58, label %.212wn58
.211wloop.55.58:
  %.219 = load i32, i32* %.205
  %.220 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.to, i32 0, i32 %.219
  %.221 = load i32, i32* %.220
  %.222 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.inq, i32 0, i32 %.221
  %.223 = load i32, i32* %.222
  %.224 = icmp eq i32 %.223, 0
  br i1 %.224, label %.217, label %.218
.212wn58:
  br label %.186wc51 
.217:
  %.226 = load i32, i32* %.205
  %.227 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.to, i32 0, i32 %.226
  %.228 = load i32, i32* %.227
  call void @inqueue(i32 %.228)
  br label %.218 
.218:
  %.231 = load i32, i32* %.205
  %.232 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.next, i32 0, i32 %.231
  %.233 = load i32, i32* %.232
  store i32 %.233, i32* %.205
  br label %.210wc55 
.239wc61:
  %.243 = load i32, i32* %.237
  %.244 = load i32, i32* @.g.tail
  %.245 = icmp sle i32 %.243, %.244
  br i1 %.245, label %.240wloop.61.64, label %.241wn64
.240wloop.61.64:
  %.247 = load i32, i32* %.237
  %.248 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.que, i32 0, i32 %.247
  %.249 = load i32, i32* %.248
  %.250 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.inq, i32 0, i32 %.249
  store i32 0, i32* %.250
  %.252 = load i32, i32* %.237
  %.253 = add i32 %.252, 1
  store i32 %.253, i32* %.237
  br label %.239wc61 
.241wn64:
  %.256 = load i32, i32* %.184
  ret i32 %.256 
}
define i32 @main(){
.259:
  %.314 = alloca i32
  %.311 = alloca i32
  %.299 = alloca i32
  %.296 = alloca i32
  %.272 = alloca i32
  %.260at68 = call i32 @quick_read()
  store i32 %.260at68, i32* @.g.n
  %.262at68 = call i32 @quick_read()
  store i32 %.262at68, i32* @.g.m
  call void @init()
  br label %.265wc70 
.265wc70:
  %.269 = load i32, i32* @.g.m
  %.270 = icmp ne i32 %.269, 0
  br i1 %.270, label %.266wloop.70.84, label %.267wn84
.266wloop.70.84:
  %.273at71 = call i32 @getch()
  store i32 %.273at71, i32* %.272
  br label %.275wc72 
.267wn84:
  ret i32 0 
.275wc72:
  %.279 = load i32, i32* %.272
  %.281 = icmp ne i32 %.279, 81
  br i1 %.281, label %.282, label %.277wn74
.276wloop.72.74:
  %.288at73 = call i32 @getch()
  store i32 %.288at73, i32* %.272
  br label %.275wc72 
.277wn74:
  %.293 = load i32, i32* %.272
  %.294 = icmp eq i32 %.293, 81
  br i1 %.294, label %.291, label %.292
.282:
  %.284 = load i32, i32* %.272
  %.286 = icmp ne i32 %.284, 85
  br i1 %.286, label %.276wloop.72.74, label %.277wn74
.291:
  %.297at76 = call i32 @quick_read()
  store i32 %.297at76, i32* %.296
  %.300at76 = call i32 @quick_read()
  store i32 %.300at76, i32* %.299
  %.302 = load i32, i32* %.296
  %.303 = load i32, i32* %.299
  %.304at77 = call i32 @same(i32 %.302, i32 %.303)
  call void @putint(i32 %.304at77)
  call void @putch(i32 10)
  br label %.309 
.292:
  %.312at80 = call i32 @quick_read()
  store i32 %.312at80, i32* %.311
  %.315at80 = call i32 @quick_read()
  store i32 %.315at80, i32* %.314
  %.317 = load i32, i32* %.311
  %.318 = load i32, i32* %.314
  call void @add_edge(i32 %.317, i32 %.318)
  br label %.309 
.309:
  %.321 = load i32, i32* @.g.m
  %.322 = sub i32 %.321, 1
  store i32 %.322, i32* @.g.m
  br label %.265wc70 
}
@.g.n = global i32 zeroinitializer
@.g.m = global i32 zeroinitializer
@.g.to = global [5005 x i32] zeroinitializer
@.g.next = global [5005 x i32] zeroinitializer
@.g.head = global [1005 x i32] zeroinitializer
@.g.cnt = global i32 0
@.g.que = global [1005 x i32] zeroinitializer
@.g.h = global i32 zeroinitializer
@.g.tail = global i32 zeroinitializer
@.g.inq = global [1005 x i32] zeroinitializer
define i32 @quick_read(){
.1:
  %.9 = alloca i32
  %.6 = alloca i32
  %.2 = alloca i32
  %.4at2 = call i32 @getch()
  store i32 %.4at2, i32* %.2
  store i32 0, i32* %.6
  store i32 0, i32* %.9
  br label %.11wc3 
.11wc3:
  %.16 = load i32, i32* %.2
  %.18 = icmp slt i32 %.16, 48
  br i1 %.18, label %.12wloop.3.6, label %.15
.12wloop.3.6:
  %.26 = load i32, i32* %.2
  %.28 = icmp eq i32 %.26, 45
  br i1 %.28, label %.24, label %.25
.13wn6:
  br label %.36wc7 
.15:
  %.20 = load i32, i32* %.2
  %.22 = icmp sgt i32 %.20, 57
  br i1 %.22, label %.12wloop.3.6, label %.13wn6
.24:
  store i32 1, i32* %.9
  br label %.25 
.25:
  %.33at5 = call i32 @getch()
  store i32 %.33at5, i32* %.2
  br label %.11wc3 
.36wc7:
  %.40 = load i32, i32* %.2
  %.41 = icmp sge i32 %.40, 48
  br i1 %.41, label %.42, label %.38wn10
.37wloop.7.10:
  %.47 = load i32, i32* %.6
  %.49 = mul i32 %.47, 10
  %.50 = load i32, i32* %.2
  %.51 = add i32 %.49, %.50
  %.52 = sub i32 %.51, 48
  store i32 %.52, i32* %.6
  %.54at9 = call i32 @getch()
  store i32 %.54at9, i32* %.2
  br label %.36wc7 
.38wn10:
  %.59 = load i32, i32* %.9
  %.60 = icmp ne i32 %.59, 0
  br i1 %.60, label %.57, label %.58
.42:
  %.44 = load i32, i32* %.2
  %.45 = icmp sle i32 %.44, 57
  br i1 %.45, label %.37wloop.7.10, label %.38wn10
.57:
  %.62 = load i32, i32* %.6
  %.63 = sub i32 0, %.62
  ret i32 %.63 
.58:
  %.65 = load i32, i32* %.6
  ret i32 %.65 
}
define void @add_edge(i32 %.82, i32 %.85){
.80:
  %.84 = alloca i32
  %.81 = alloca i32
  store i32 %.82, i32* %.81
  store i32 %.85, i32* %.84
  %.87 = load i32, i32* %.84
  %.88 = load i32, i32* @.g.cnt
  %.89 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.to, i32 0, i32 %.88
  store i32 %.87, i32* %.89
  %.91 = load i32, i32* %.81
  %.92 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.91
  %.93 = load i32, i32* %.92
  %.94 = load i32, i32* @.g.cnt
  %.95 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.next, i32 0, i32 %.94
  store i32 %.93, i32* %.95
  %.97 = load i32, i32* @.g.cnt
  %.98 = load i32, i32* %.81
  %.99 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.98
  store i32 %.97, i32* %.99
  %.101 = load i32, i32* @.g.cnt
  %.102 = add i32 %.101, 1
  store i32 %.102, i32* @.g.cnt
  %.104 = load i32, i32* %.81
  %.105 = load i32, i32* @.g.cnt
  %.106 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.to, i32 0, i32 %.105
  store i32 %.104, i32* %.106
  %.108 = load i32, i32* %.84
  %.109 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.108
  %.110 = load i32, i32* %.109
  %.111 = load i32, i32* @.g.cnt
  %.112 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.next, i32 0, i32 %.111
  store i32 %.110, i32* %.112
  %.114 = load i32, i32* @.g.cnt
  %.115 = load i32, i32* %.84
  %.116 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.115
  store i32 %.114, i32* %.116
  %.118 = load i32, i32* @.g.cnt
  %.119 = add i32 %.118, 1
  store i32 %.119, i32* @.g.cnt
  ret void
}
define void @init(){
.123:
  %.124 = alloca i32
  store i32 0, i32* %.124
  br label %.126wc31 
.126wc31:
  %.130 = load i32, i32* %.124
  %.131 = icmp slt i32 %.130, 1005
  br i1 %.131, label %.127wloop.31.34, label %.128wn34
.127wloop.31.34:
  %.134 = load i32, i32* %.124
  %.135 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.134
  store i32 -1, i32* %.135
  %.137 = load i32, i32* %.124
  %.138 = add i32 %.137, 1
  store i32 %.138, i32* %.124
  br label %.126wc31 
.128wn34:
  ret void
}
define void @inqueue(i32 %.145){
.143:
  %.144 = alloca i32
  store i32 %.145, i32* %.144
  %.147 = load i32, i32* %.144
  %.148 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.inq, i32 0, i32 %.147
  store i32 1, i32* %.148
  %.150 = load i32, i32* @.g.tail
  %.151 = add i32 %.150, 1
  store i32 %.151, i32* @.g.tail
  %.153 = load i32, i32* %.144
  %.154 = load i32, i32* @.g.tail
  %.155 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.que, i32 0, i32 %.154
  store i32 %.153, i32* %.155
  ret void
}
define i32 @pop_queue(){
.159:
  %.163 = alloca i32
  %.160 = load i32, i32* @.g.h
  %.161 = add i32 %.160, 1
  store i32 %.161, i32* @.g.h
  %.164 = load i32, i32* @.g.h
  %.165 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.que, i32 0, i32 %.164
  %.166 = load i32, i32* %.165
  store i32 %.166, i32* %.163
  %.168 = load i32, i32* @.g.h
  %.169 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.que, i32 0, i32 %.168
  %.170 = load i32, i32* %.169
  ret i32 %.170 
}
define i32 @same(i32 %.175, i32 %.178){
.173:
  %.237 = alloca i32
  %.205 = alloca i32
  %.194 = alloca i32
  %.184 = alloca i32
  %.177 = alloca i32
  %.174 = alloca i32
  store i32 %.175, i32* %.174
  store i32 %.178, i32* %.177
  store i32 0, i32* @.g.h
  store i32 0, i32* @.g.tail
  %.182 = load i32, i32* %.174
  call void @inqueue(i32 %.182)
  store i32 0, i32* %.184
  br label %.186wc51 
.186wc51:
  %.190 = load i32, i32* @.g.h
  %.191 = load i32, i32* @.g.tail
  %.192 = icmp slt i32 %.190, %.191
  br i1 %.192, label %.187wloop.51.59, label %.188wn59
.187wloop.51.59:
  %.195at52 = call i32 @pop_queue()
  store i32 %.195at52, i32* %.194
  %.199 = load i32, i32* %.194
  %.200 = load i32, i32* %.177
  %.201 = icmp eq i32 %.199, %.200
  br i1 %.201, label %.197, label %.198
.188wn59:
  store i32 0, i32* %.237
  br label %.239wc61 
.197:
  store i32 1, i32* %.184
  br label %.198 
.198:
  %.206 = load i32, i32* %.194
  %.207 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.head, i32 0, i32 %.206
  %.208 = load i32, i32* %.207
  store i32 %.208, i32* %.205
  br label %.210wc55 
.210wc55:
  %.214 = load i32, i32* %.205
  %.215 = icmp ne i32 %.214, -1
  br i1 %.215, label %.211wloop.55.58, label %.212wn58
.211wloop.55.58:
  %.219 = load i32, i32* %.205
  %.220 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.to, i32 0, i32 %.219
  %.221 = load i32, i32* %.220
  %.222 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.inq, i32 0, i32 %.221
  %.223 = load i32, i32* %.222
  %.224 = icmp eq i32 %.223, 0
  br i1 %.224, label %.217, label %.218
.212wn58:
  br label %.186wc51 
.217:
  %.226 = load i32, i32* %.205
  %.227 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.to, i32 0, i32 %.226
  %.228 = load i32, i32* %.227
  call void @inqueue(i32 %.228)
  br label %.218 
.218:
  %.231 = load i32, i32* %.205
  %.232 = getelementptr inbounds [5005 x i32], [5005 x i32]* @.g.next, i32 0, i32 %.231
  %.233 = load i32, i32* %.232
  store i32 %.233, i32* %.205
  br label %.210wc55 
.239wc61:
  %.243 = load i32, i32* %.237
  %.244 = load i32, i32* @.g.tail
  %.245 = icmp sle i32 %.243, %.244
  br i1 %.245, label %.240wloop.61.64, label %.241wn64
.240wloop.61.64:
  %.247 = load i32, i32* %.237
  %.248 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.que, i32 0, i32 %.247
  %.249 = load i32, i32* %.248
  %.250 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.inq, i32 0, i32 %.249
  store i32 0, i32* %.250
  %.252 = load i32, i32* %.237
  %.253 = add i32 %.252, 1
  store i32 %.253, i32* %.237
  br label %.239wc61 
.241wn64:
  %.256 = load i32, i32* %.184
  ret i32 %.256 
}
define i32 @main(){
.259:
  %.314 = alloca i32
  %.311 = alloca i32
  %.299 = alloca i32
  %.296 = alloca i32
  %.272 = alloca i32
  %.260at68 = call i32 @quick_read()
  store i32 %.260at68, i32* @.g.n
  %.262at68 = call i32 @quick_read()
  store i32 %.262at68, i32* @.g.m
  call void @init()
  br label %.265wc70 
.265wc70:
  %.269 = load i32, i32* @.g.m
  %.270 = icmp ne i32 %.269, 0
  br i1 %.270, label %.266wloop.70.84, label %.267wn84
.266wloop.70.84:
  %.273at71 = call i32 @getch()
  store i32 %.273at71, i32* %.272
  br label %.275wc72 
.267wn84:
  ret i32 0 
.275wc72:
  %.279 = load i32, i32* %.272
  %.281 = icmp ne i32 %.279, 81
  br i1 %.281, label %.282, label %.277wn74
.276wloop.72.74:
  %.288at73 = call i32 @getch()
  store i32 %.288at73, i32* %.272
  br label %.275wc72 
.277wn74:
  %.293 = load i32, i32* %.272
  %.294 = icmp eq i32 %.293, 81
  br i1 %.294, label %.291, label %.292
.282:
  %.284 = load i32, i32* %.272
  %.286 = icmp ne i32 %.284, 85
  br i1 %.286, label %.276wloop.72.74, label %.277wn74
.291:
  %.297at76 = call i32 @quick_read()
  store i32 %.297at76, i32* %.296
  %.300at76 = call i32 @quick_read()
  store i32 %.300at76, i32* %.299
  %.302 = load i32, i32* %.296
  %.303 = load i32, i32* %.299
  %.304at77 = call i32 @same(i32 %.302, i32 %.303)
  call void @putint(i32 %.304at77)
  call void @putch(i32 10)
  br label %.309 
.292:
  %.312at80 = call i32 @quick_read()