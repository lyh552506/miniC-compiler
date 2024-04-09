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
@.g.value = global [10000 x i32] zeroinitializer
@.g.left_child = global [10000 x i32] zeroinitializer
@.g.right_child = global [10000 x i32] zeroinitializer
@.g.now = global i32 zeroinitializer
define i32 @search(i32 %.10, i32 %.13){
.8:
  %.12 = alloca i32
  %.9 = alloca i32
  store i32 %.10, i32* %.9
  store i32 %.13, i32* %.12
  %.18 = load i32, i32* %.9
  %.22 = icmp eq i32 %.18, -1
  br i1 %.22, label %.15, label %.17
.15:
  %.30 = load i32, i32* %.9
  ret i32 %.30 
.16:
  %.34 = load i32, i32* %.12
  %.35 = load i32, i32* %.9
  %.36 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.35
  %.37 = load i32, i32* %.36
  %.38 = icmp sgt i32 %.34, %.37
  br i1 %.38, label %.32, label %.33
.17:
  %.24 = load i32, i32* %.9
  %.25 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.24
  %.26 = load i32, i32* %.25
  %.27 = load i32, i32* %.12
  %.28 = icmp eq i32 %.26, %.27
  br i1 %.28, label %.15, label %.16
.32:
  %.40 = load i32, i32* %.9
  %.41 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.40
  %.42 = load i32, i32* %.41
  %.43 = load i32, i32* %.12
  %.44at13 = call i32 @search(i32 %.42, i32 %.43)
  ret i32 %.44at13 
.33:
  %.46 = load i32, i32* %.9
  %.47 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.46
  %.48 = load i32, i32* %.47
  %.49 = load i32, i32* %.12
  %.50at15 = call i32 @search(i32 %.48, i32 %.49)
  ret i32 %.50at15 
}
define i32 @find_minimum(i32 %.55){
.53:
  %.54 = alloca i32
  store i32 %.55, i32* %.54
  %.59 = load i32, i32* %.54
  %.60 = icmp eq i32 %.59, -1
  br i1 %.60, label %.57, label %.58
.57:
  ret i32 -1 
.58:
  %.65 = load i32, i32* %.54
  %.66 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.65
  %.67 = load i32, i32* %.66
  %.68 = icmp ne i32 %.67, -1
  br i1 %.68, label %.63, label %.64
.63:
  %.70 = load i32, i32* %.54
  %.71 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.70
  %.72 = load i32, i32* %.71
  %.73at23 = call i32 @find_minimum(i32 %.72)
  ret i32 %.73at23 
.64:
  br label %.75 
.75:
  %.77 = load i32, i32* %.54
  ret i32 %.77 
}
define i32 @new_node(i32 %.82){
.80:
  %.81 = alloca i32
  store i32 %.82, i32* %.81
  %.84 = load i32, i32* %.81
  %.85 = load i32, i32* @.g.now
  %.86 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.85
  store i32 %.84, i32* %.86
  %.88 = load i32, i32* @.g.now
  %.89 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.88
  store i32 -1, i32* %.89
  %.91 = load i32, i32* @.g.now
  %.92 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.91
  store i32 -1, i32* %.92
  %.94 = load i32, i32* @.g.now
  %.95 = add i32 %.94, 1
  store i32 %.95, i32* @.g.now
  %.97 = load i32, i32* @.g.now
  %.98 = sub i32 %.97, 1
  ret i32 %.98 
}
define i32 @insert(i32 %.103, i32 %.106){
.101:
  %.105 = alloca i32
  %.102 = alloca i32
  store i32 %.103, i32* %.102
  store i32 %.106, i32* %.105
  %.110 = load i32, i32* %.102
  %.111 = icmp eq i32 %.110, -1
  br i1 %.111, label %.108, label %.109
.108:
  %.113 = load i32, i32* %.105
  %.114at38 = call i32 @new_node(i32 %.113)
  ret i32 %.114at38 
.109:
  %.118 = load i32, i32* %.105
  %.119 = load i32, i32* %.102
  %.120 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.119
  %.121 = load i32, i32* %.120
  %.122 = icmp sgt i32 %.118, %.121
  br i1 %.122, label %.116, label %.117
.116:
  %.124 = load i32, i32* %.102
  %.125 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.124
  %.126 = load i32, i32* %.125
  %.127 = load i32, i32* %.105
  %.128at41 = call i32 @insert(i32 %.126, i32 %.127)
  %.129 = load i32, i32* %.102
  %.130 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.129
  store i32 %.128at41, i32* %.130
  br label %.132 
.117:
  %.134 = load i32, i32* %.102
  %.135 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.134
  %.136 = load i32, i32* %.135
  %.137 = load i32, i32* %.105
  %.138at43 = call i32 @insert(i32 %.136, i32 %.137)
  %.139 = load i32, i32* %.102
  %.140 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.139
  store i32 %.138at43, i32* %.140
  br label %.132 
.132:
  br label %.143 
.143:
  %.145 = load i32, i32* %.102
  ret i32 %.145 
}
define i32 @delete(i32 %.150, i32 %.153){
.148:
  %.239 = alloca i32
  %.152 = alloca i32
  %.149 = alloca i32
  store i32 %.150, i32* %.149
  store i32 %.153, i32* %.152
  %.157 = load i32, i32* %.149
  %.158 = icmp eq i32 %.157, -1
  br i1 %.158, label %.155, label %.156
.155:
  ret i32 -1 
.156:
  %.163 = load i32, i32* %.152
  %.164 = load i32, i32* %.149
  %.165 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.164
  %.166 = load i32, i32* %.165
  %.167 = icmp sgt i32 %.163, %.166
  br i1 %.167, label %.161, label %.162
.161:
  %.169 = load i32, i32* %.149
  %.170 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.169
  %.171 = load i32, i32* %.170
  %.172 = load i32, i32* %.152
  %.173at50 = call i32 @delete(i32 %.171, i32 %.172)
  %.174 = load i32, i32* %.149
  %.175 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.174
  store i32 %.173at50, i32* %.175
  br label %.177 
.162:
  %.181 = load i32, i32* %.152
  %.182 = load i32, i32* %.149
  %.183 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.182
  %.184 = load i32, i32* %.183
  %.185 = icmp slt i32 %.181, %.184
  br i1 %.185, label %.179, label %.180
.177:
  %.267 = load i32, i32* %.149
  ret i32 %.267 
.179:
  %.187 = load i32, i32* %.149
  %.188 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.187
  %.189 = load i32, i32* %.188
  %.190 = load i32, i32* %.152
  %.191at51 = call i32 @delete(i32 %.189, i32 %.190)
  %.192 = load i32, i32* %.149
  %.193 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.192
  store i32 %.191at51, i32* %.193
  br label %.195 
.180:
  %.199 = load i32, i32* %.149
  %.200 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.199
  %.201 = load i32, i32* %.200
  %.202 = icmp eq i32 %.201, -1
  br i1 %.202, label %.203, label %.198
.195:
  br label %.177 
.197:
  ret i32 -1 
.198:
  %.214 = load i32, i32* %.149
  %.215 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.214
  %.216 = load i32, i32* %.215
  %.217 = icmp eq i32 %.216, -1
  br i1 %.217, label %.211, label %.213
.203:
  %.205 = load i32, i32* %.149
  %.206 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.205
  %.207 = load i32, i32* %.206
  %.208 = icmp eq i32 %.207, -1
  br i1 %.208, label %.197, label %.198
.211:
  %.226 = load i32, i32* %.149
  %.227 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.226
  %.228 = load i32, i32* %.227
  %.229 = icmp eq i32 %.228, -1
  br i1 %.229, label %.224, label %.225
.212:
  %.240 = load i32, i32* %.149
  %.241 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.240
  %.242 = load i32, i32* %.241
  %.243at60 = call i32 @find_minimum(i32 %.242)
  store i32 %.243at60, i32* %.239
  %.245 = load i32, i32* %.239
  %.246 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.245
  %.247 = load i32, i32* %.246
  %.248 = load i32, i32* %.149
  %.249 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.248
  store i32 %.247, i32* %.249
  %.251 = load i32, i32* %.149
  %.252 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.251
  %.253 = load i32, i32* %.252
  %.254 = load i32, i32* %.239
  %.255 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.254
  %.256 = load i32, i32* %.255
  %.257at62 = call i32 @delete(i32 %.253, i32 %.256)
  %.258 = load i32, i32* %.149
  %.259 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.258
  store i32 %.257at62, i32* %.259
  br label %.261 
.213:
  %.219 = load i32, i32* %.149
  %.220 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.219
  %.221 = load i32, i32* %.220
  %.222 = icmp eq i32 %.221, -1
  br i1 %.222, label %.211, label %.212
.224:
  %.231 = load i32, i32* %.149
  %.232 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.231
  %.233 = load i32, i32* %.232
  ret i32 %.233 
.225:
  %.235 = load i32, i32* %.149
  %.236 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.235
  %.237 = load i32, i32* %.236
  ret i32 %.237 
.261:
  br label %.263 
.263:
  br label %.195 
}
define void @inorder(i32 %.272){
.270:
  %.271 = alloca i32
  store i32 %.272, i32* %.271
  %.276 = load i32, i32* %.271
  %.277 = icmp ne i32 %.276, -1
  br i1 %.277, label %.274, label %.275
.274:
  %.279 = load i32, i32* %.271
  %.280 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.279
  %.281 = load i32, i32* %.280
  call void @inorder(i32 %.281)
  %.283 = load i32, i32* %.271
  %.284 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.283
  %.285 = load i32, i32* %.284
  call void @putint(i32 %.285)
  call void @putch(i32 32)
  %.290 = load i32, i32* %.271
  %.291 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.290
  %.292 = load i32, i32* %.291
  call void @inorder(i32 %.292)
  br label %.275 
.275:
  ret void
}
define i32 @main(){
.297:
  %.313 = alloca i32
  %.309 = alloca i32
  %.299 = alloca i32
  store i32 0, i32* @.g.now
  %.301at78 = call i32 @getint()
  store i32 %.301at78, i32* %.299
  %.305 = load i32, i32* %.299
  %.306 = icmp eq i32 %.305, 0
  br i1 %.306, label %.303, label %.304
.303:
  ret i32 0 
.304:
  %.310at80 = call i32 @getint()
  %.311at80 = call i32 @new_node(i32 %.310at80)
  store i32 %.311at80, i32* %.309
  store i32 1, i32* %.313
  br label %.315wc81 
.315wc81:
  %.319 = load i32, i32* %.313
  %.320 = load i32, i32* %.299
  %.321 = icmp slt i32 %.319, %.320
  br i1 %.321, label %.316wloop.81.84, label %.317wn84
.316wloop.81.84:
  %.323 = load i32, i32* %.309
  %.324at82 = call i32 @getint()
  %.325at82 = call i32 @insert(i32 %.323, i32 %.324at82)
  %.326 = load i32, i32* %.313
  %.327 = add i32 %.326, 1
  store i32 %.327, i32* %.313
  br label %.315wc81 
.317wn84:
  %.330 = load i32, i32* %.309
  call void @inorder(i32 %.330)
  call void @putch(i32 10)
  %.333at87 = call i32 @getint()
  store i32 %.333at87, i32* %.299
  store i32 0, i32* %.313
  br label %.336wc88 
.336wc88:
  %.340 = load i32, i32* %.313
  %.341 = load i32, i32* %.299
  %.342 = icmp slt i32 %.340, %.341
  br i1 %.342, label %.337wloop.88.91, label %.338wn91
.337wloop.88.91:
  %.344 = load i32, i32* %.309
  %.345at89 = call i32 @getint()
  %.346at89 = call i32 @delete(i32 %.344, i32 %.345at89)
  store i32 %.346at89, i32* %.309
  %.348 = load i32, i32* %.313
  %.349 = add i32 %.348, 1
  store i32 %.349, i32* %.313
  br label %.336wc88 
.338wn91:
  %.352 = load i32, i32* %.309
  call void @inorder(i32 %.352)
  call void @putch(i32 10)
  ret i32 0 
}
@.g.value = global [10000 x i32] zeroinitializer
@.g.left_child = global [10000 x i32] zeroinitializer
@.g.right_child = global [10000 x i32] zeroinitializer
@.g.now = global i32 zeroinitializer
define i32 @search(i32 %.10, i32 %.13){
.8:
  %.12 = alloca i32
  %.9 = alloca i32
  store i32 %.10, i32* %.9
  store i32 %.13, i32* %.12
  %.18 = load i32, i32* %.9
  %.22 = icmp eq i32 %.18, -1
  br i1 %.22, label %.15, label %.17
.15:
  %.30 = load i32, i32* %.9
  ret i32 %.30 
.16:
  %.34 = load i32, i32* %.12
  %.35 = load i32, i32* %.9
  %.36 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.35
  %.37 = load i32, i32* %.36
  %.38 = icmp sgt i32 %.34, %.37
  br i1 %.38, label %.32, label %.33
.17:
  %.24 = load i32, i32* %.9
  %.25 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.24
  %.26 = load i32, i32* %.25
  %.27 = load i32, i32* %.12
  %.28 = icmp eq i32 %.26, %.27
  br i1 %.28, label %.15, label %.16
.32:
  %.40 = load i32, i32* %.9
  %.41 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.40
  %.42 = load i32, i32* %.41
  %.43 = load i32, i32* %.12
  %.44at13 = call i32 @search(i32 %.42, i32 %.43)
  ret i32 %.44at13 
.33:
  %.46 = load i32, i32* %.9
  %.47 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.46
  %.48 = load i32, i32* %.47
  %.49 = load i32, i32* %.12
  %.50at15 = call i32 @search(i32 %.48, i32 %.49)
  ret i32 %.50at15 
}
define i32 @find_minimum(i32 %.55){
.53:
  %.54 = alloca i32
  store i32 %.55, i32* %.54
  %.59 = load i32, i32* %.54
  %.60 = icmp eq i32 %.59, -1
  br i1 %.60, label %.57, label %.58
.57:
  ret i32 -1 
.58:
  %.65 = load i32, i32* %.54
  %.66 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.65
  %.67 = load i32, i32* %.66
  %.68 = icmp ne i32 %.67, -1
  br i1 %.68, label %.63, label %.64
.63:
  %.70 = load i32, i32* %.54
  %.71 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.70
  %.72 = load i32, i32* %.71
  %.73at23 = call i32 @find_minimum(i32 %.72)
  ret i32 %.73at23 
.64:
  br label %.75 
.75:
  %.77 = load i32, i32* %.54
  ret i32 %.77 
}
define i32 @new_node(i32 %.82){
.80:
  %.81 = alloca i32
  store i32 %.82, i32* %.81
  %.84 = load i32, i32* %.81
  %.85 = load i32, i32* @.g.now
  %.86 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.85
  store i32 %.84, i32* %.86
  %.88 = load i32, i32* @.g.now
  %.89 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.88
  store i32 -1, i32* %.89
  %.91 = load i32, i32* @.g.now
  %.92 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.91
  store i32 -1, i32* %.92
  %.94 = load i32, i32* @.g.now
  %.95 = add i32 %.94, 1
  store i32 %.95, i32* @.g.now
  %.97 = load i32, i32* @.g.now
  %.98 = sub i32 %.97, 1
  ret i32 %.98 
}
define i32 @insert(i32 %.103, i32 %.106){
.101:
  %.105 = alloca i32
  %.102 = alloca i32
  store i32 %.103, i32* %.102
  store i32 %.106, i32* %.105
  %.110 = load i32, i32* %.102
  %.111 = icmp eq i32 %.110, -1
  br i1 %.111, label %.108, label %.109
.108:
  %.113 = load i32, i32* %.105
  %.114at38 = call i32 @new_node(i32 %.113)
  ret i32 %.114at38 
.109:
  %.118 = load i32, i32* %.105
  %.119 = load i32, i32* %.102
  %.120 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.119
  %.121 = load i32, i32* %.120
  %.122 = icmp sgt i32 %.118, %.121
  br i1 %.122, label %.116, label %.117
.116:
  %.124 = load i32, i32* %.102
  %.125 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.124
  %.126 = load i32, i32* %.125
  %.127 = load i32, i32* %.105
  %.128at41 = call i32 @insert(i32 %.126, i32 %.127)
  %.129 = load i32, i32* %.102
  %.130 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.129
  store i32 %.128at41, i32* %.130
  br label %.132 
.117:
  %.134 = load i32, i32* %.102
  %.135 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.134
  %.136 = load i32, i32* %.135
  %.137 = load i32, i32* %.105
  %.138at43 = call i32 @insert(i32 %.136, i32 %.137)
  %.139 = load i32, i32* %.102
  %.140 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.139
  store i32 %.138at43, i32* %.140
  br label %.132 
.132:
  br label %.143 
.143:
  %.145 = load i32, i32* %.102
  ret i32 %.145 
}
define i32 @delete(i32 %.150, i32 %.153){
.148:
  %.239 = alloca i32
  %.152 = alloca i32
  %.149 = alloca i32
  store i32 %.150, i32* %.149
  store i32 %.153, i32* %.152
  %.157 = load i32, i32* %.149
  %.158 = icmp eq i32 %.157, -1
  br i1 %.158, label %.155, label %.156
.155:
  ret i32 -1 
.156:
  %.163 = load i32, i32* %.152
  %.164 = load i32, i32* %.149
  %.165 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.164
  %.166 = load i32, i32* %.165
  %.167 = icmp sgt i32 %.163, %.166
  br i1 %.167, label %.161, label %.162
.161:
  %.169 = load i32, i32* %.149
  %.170 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.169
  %.171 = load i32, i32* %.170
  %.172 = load i32, i32* %.152
  %.173at50 = call i32 @delete(i32 %.171, i32 %.172)
  %.174 = load i32, i32* %.149
  %.175 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.174
  store i32 %.173at50, i32* %.175
  br label %.177 
.162:
  %.181 = load i32, i32* %.152
  %.182 = load i32, i32* %.149
  %.183 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.182
  %.184 = load i32, i32* %.183
  %.185 = icmp slt i32 %.181, %.184
  br i1 %.185, label %.179, label %.180
.177:
  %.267 = load i32, i32* %.149
  ret i32 %.267 
.179:
  %.187 = load i32, i32* %.149
  %.188 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.187
  %.189 = load i32, i32* %.188
  %.190 = load i32, i32* %.152
  %.191at51 = call i32 @delete(i32 %.189, i32 %.190)
  %.192 = load i32, i32* %.149
  %.193 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.192
  store i32 %.191at51, i32* %.193
  br label %.195 
.180:
  %.199 = load i32, i32* %.149
  %.200 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.199
  %.201 = load i32, i32* %.200
  %.202 = icmp eq i32 %.201, -1
  br i1 %.202, label %.203, label %.198
.195:
  br label %.177 
.197:
  ret i32 -1 
.198:
  %.214 = load i32, i32* %.149
  %.215 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.214
  %.216 = load i32, i32* %.215
  %.217 = icmp eq i32 %.216, -1
  br i1 %.217, label %.211, label %.213
.203:
  %.205 = load i32, i32* %.149
  %.206 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.205
  %.207 = load i32, i32* %.206
  %.208 = icmp eq i32 %.207, -1
  br i1 %.208, label %.197, label %.198
.211:
  %.226 = load i32, i32* %.149
  %.227 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.226
  %.228 = load i32, i32* %.227
  %.229 = icmp eq i32 %.228, -1
  br i1 %.229, label %.224, label %.225
.212:
  %.240 = load i32, i32* %.149
  %.241 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.240
  %.242 = load i32, i32* %.241
  %.243at60 = call i32 @find_minimum(i32 %.242)
  store i32 %.243at60, i32* %.239
  %.245 = load i32, i32* %.239
  %.246 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.245
  %.247 = load i32, i32* %.246
  %.248 = load i32, i32* %.149
  %.249 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.248
  store i32 %.247, i32* %.249
  %.251 = load i32, i32* %.149
  %.252 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.251
  %.253 = load i32, i32* %.252
  %.254 = load i32, i32* %.239
  %.255 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.254
  %.256 = load i32, i32* %.255
  %.257at62 = call i32 @delete(i32 %.253, i32 %.256)
  %.258 = load i32, i32* %.149
  %.259 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.258
  store i32 %.257at62, i32* %.259
  br label %.261 
.213:
  %.219 = load i32, i32* %.149
  %.220 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.219
  %.221 = load i32, i32* %.220
  %.222 = icmp eq i32 %.221, -1
  br i1 %.222, label %.211, label %.212
.224:
  %.231 = load i32, i32* %.149
  %.232 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.231
  %.233 = load i32, i32* %.232
  ret i32 %.233 
.225:
  %.235 = load i32, i32* %.149
  %.236 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.235
  %.237 = load i32, i32* %.236
  ret i32 %.237 
.261:
  br label %.263 
.263:
  br label %.195 
}
define void @inorder(i32 %.272){
.270:
  %.271 = alloca i32
  store i32 %.272, i32* %.271
  %.276 = load i32, i32* %.271
  %.277 = icmp ne i32 %.276, -1
  br i1 %.277, label %.274, label %.275
.274:
  %.279 = load i32, i32* %.271
  %.280 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.left_child, i32 0, i32 %.279
  %.281 = load i32, i32* %.280
  call void @inorder(i32 %.281)
  %.283 = load i32, i32* %.271
  %.284 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.value, i32 0, i32 %.283
  %.285 = load i32, i32* %.284
  call void @putint(i32 %.285)
  call void @putch(i32 32)
  %.290 = load i32, i32* %.271
  %.291 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.right_child, i32 0, i32 %.290
  %.292 = load i32, i32* %.291
  call void @inorder(i32 %.292)
  br label %.275 
.275:
  ret void
}
define i32 @main(){
.297:
  %.313 = alloca i32
  %.309 = alloca i32
  %.299 = alloca i32
  store i32 0, i32* @.g.now
  %.301at78 = call i32 @getint()
  store i32 %.301at78, i32* %.299
  %.305 = load i32, i32* %.299
  %.306 = icmp eq i32 %.305, 0
  br i1 %.306, label %.303, label %.304
.303:
  ret i32 0 
.304:
  %.310at80 = call i32 @getint()
  %.311at80 = call i32 @new_node(i32 %.310at80)
  store i32 %.311at80, i32* %.309
  store i32 1, i32* %.313
  br label %.315wc81 
.315wc81:
  %.319 = load i32, i32* %.313
  %.320 = load i32, i32* %.299
  %.321 = icmp slt i32 %.319, %.320
  br i1 %.321, label %.316wloop.81.84, label %.317wn84
.316wloop.81.84:
  %.323 = load i32, i32* %.309
  %.324at82 = call i32 @getint()
  %.325at82 = call i32 @insert(i32 %.323, i32 %.324at82)
  %.326 = load i32, i32* %.313
  %.327 = add i32 %.326, 1
  store i32 %.327, i32* %.313
  br label %.315wc81 
.317wn84:
  %.330 = load i32, i32* %.309
  call void @inorder(i32 %.330)
  call void @putch(i32 10)
  %.333at87 = call i32 @getint()
  store i32 %.333at87, i32* %.299
  store i32 0, i32* %.313
  br label %.336wc88 
.336wc88:
  %.340 = load i32, i32* %.313
  %.341 = load i32, i32* %.299
  %.342 = icmp slt i32 %.340, %.341
  br i1 %.342, label %.337wloop.88.91, label %.338wn91
.