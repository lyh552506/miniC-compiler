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
@.g.f = global [10005 x [20 x i32]] zeroinitializer
@.g.dep = global [10005 x i32] zeroinitializer
@.g.to = global [10005 x i32] zeroinitializer
@.g.next = global [10005 x i32] zeroinitializer
@.g.head = global [10005 x i32] zeroinitializer
@.g.cnt = global i32 0
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
define void @add_edge(i32 %.80, i32 %.83){
.78:
  %.82 = alloca i32
  %.79 = alloca i32
  store i32 %.80, i32* %.79
  store i32 %.83, i32* %.82
  %.85 = load i32, i32* %.82
  %.86 = load i32, i32* @.g.cnt
  %.87 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.to, i32 0, i32 %.86
  store i32 %.85, i32* %.87
  %.89 = load i32, i32* %.79
  %.90 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.head, i32 0, i32 %.89
  %.91 = load i32, i32* %.90
  %.92 = load i32, i32* @.g.cnt
  %.93 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.next, i32 0, i32 %.92
  store i32 %.91, i32* %.93
  %.95 = load i32, i32* @.g.cnt
  %.96 = load i32, i32* %.79
  %.97 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.head, i32 0, i32 %.96
  store i32 %.95, i32* %.97
  %.99 = load i32, i32* @.g.cnt
  %.100 = add i32 %.99, 1
  store i32 %.100, i32* @.g.cnt
  %.102 = load i32, i32* %.79
  %.103 = load i32, i32* %.82
  %.104 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.103, i32 0
  store i32 %.102, i32* %.104
  ret void
}
define void @init(){
.108:
  %.112 = alloca i32
  %.110 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 0
  store i32 1061109567, i32* %.110
  store i32 1, i32* %.112
  br label %.114wc27 
.114wc27:
  %.118 = load i32, i32* %.112
  %.119 = load i32, i32* @.g.n
  %.120 = icmp sle i32 %.118, %.119
  br i1 %.120, label %.115wloop.27.30, label %.116wn30
.115wloop.27.30:
  %.123 = load i32, i32* %.112
  %.124 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.head, i32 0, i32 %.123
  store i32 -1, i32* %.124
  %.126 = load i32, i32* %.112
  %.127 = add i32 %.126, 1
  store i32 %.127, i32* %.112
  br label %.114wc27 
.116wn30:
  ret void
}
define void @tree(i32 %.134, i32 %.137){
.132:
  %.182 = alloca i32
  %.143 = alloca i32
  %.136 = alloca i32
  %.133 = alloca i32
  store i32 %.134, i32* %.133
  store i32 %.137, i32* %.136
  %.139 = load i32, i32* %.136
  %.140 = load i32, i32* %.133
  %.141 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.140
  store i32 %.139, i32* %.141
  store i32 0, i32* %.143
  br label %.145wc35 
.145wc35:
  %.149 = load i32, i32* %.133
  %.150 = load i32, i32* %.143
  %.151 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.149, i32 %.150
  %.152 = load i32, i32* %.151
  %.153 = icmp ne i32 %.152, 0
  br i1 %.153, label %.146wloop.35.38, label %.147wn38
.146wloop.35.38:
  %.155 = load i32, i32* %.133
  %.156 = load i32, i32* %.143
  %.157 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.155, i32 %.156
  %.158 = load i32, i32* %.157
  %.159 = load i32, i32* %.143
  %.160 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.158, i32 %.159
  %.161 = load i32, i32* %.160
  %.162 = load i32, i32* %.133
  %.163 = load i32, i32* %.143
  %.164 = add i32 %.163, 1
  %.165 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.162, i32 %.164
  store i32 %.161, i32* %.165
  %.167 = load i32, i32* %.143
  %.168 = add i32 %.167, 1
  store i32 %.168, i32* %.143
  br label %.145wc35 
.147wn38:
  %.171 = load i32, i32* %.133
  %.172 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.head, i32 0, i32 %.171
  %.173 = load i32, i32* %.172
  store i32 %.173, i32* %.143
  br label %.175wc40 
.175wc40:
  %.179 = load i32, i32* %.143
  %.180 = icmp ne i32 %.179, -1
  br i1 %.180, label %.176wloop.40.44, label %.177wn44
.176wloop.40.44:
  %.183 = load i32, i32* %.143
  %.184 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.to, i32 0, i32 %.183
  %.185 = load i32, i32* %.184
  store i32 %.185, i32* %.182
  %.187 = load i32, i32* %.182
  %.188 = load i32, i32* %.136
  %.189 = add i32 %.188, 1
  call void @tree(i32 %.187, i32 %.189)
  %.191 = load i32, i32* %.143
  %.192 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.next, i32 0, i32 %.191
  %.193 = load i32, i32* %.192
  store i32 %.193, i32* %.143
  br label %.175wc40 
.177wn44:
  ret void
}
define i32 @LCA(i32 %.200, i32 %.203){
.198:
  %.223 = alloca i32
  %.215 = alloca i32
  %.202 = alloca i32
  %.199 = alloca i32
  store i32 %.200, i32* %.199
  store i32 %.203, i32* %.202
  %.207 = load i32, i32* %.199
  %.208 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.207
  %.209 = load i32, i32* %.208
  %.210 = load i32, i32* %.202
  %.211 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.210
  %.212 = load i32, i32* %.211
  %.213 = icmp slt i32 %.209, %.212
  br i1 %.213, label %.205, label %.206
.205:
  %.216 = load i32, i32* %.199
  store i32 %.216, i32* %.215
  %.218 = load i32, i32* %.202
  store i32 %.218, i32* %.199
  %.220 = load i32, i32* %.215
  store i32 %.220, i32* %.202
  br label %.206 
.206:
  store i32 19, i32* %.223
  br label %.226wc53 
.226wc53:
  %.230 = load i32, i32* %.199
  %.231 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.230
  %.232 = load i32, i32* %.231
  %.233 = load i32, i32* %.202
  %.234 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.233
  %.235 = load i32, i32* %.234
  %.236 = icmp sgt i32 %.232, %.235
  br i1 %.236, label %.227wloop.53.57, label %.228wn57
.227wloop.53.57:
  %.240 = load i32, i32* %.199
  %.241 = load i32, i32* %.223
  %.242 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.240, i32 %.241
  %.243 = load i32, i32* %.242
  %.244 = icmp ne i32 %.243, 0
  br i1 %.244, label %.245, label %.239
.228wn57:
  %.270 = load i32, i32* %.199
  %.271 = load i32, i32* %.202
  %.272 = icmp eq i32 %.270, %.271
  br i1 %.272, label %.268, label %.269
.238:
  %.258 = load i32, i32* %.199
  %.259 = load i32, i32* %.223
  %.260 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.258, i32 %.259
  %.261 = load i32, i32* %.260
  store i32 %.261, i32* %.199
  br label %.239 
.239:
  %.264 = load i32, i32* %.223
  %.265 = sub i32 %.264, 1
  store i32 %.265, i32* %.223
  br label %.226wc53 
.245:
  %.247 = load i32, i32* %.199
  %.248 = load i32, i32* %.223
  %.249 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.247, i32 %.248
  %.250 = load i32, i32* %.249
  %.251 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.250
  %.252 = load i32, i32* %.251
  %.253 = load i32, i32* %.202
  %.254 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.253
  %.255 = load i32, i32* %.254
  %.256 = icmp sge i32 %.252, %.255
  br i1 %.256, label %.238, label %.239
.268:
  %.274 = load i32, i32* %.199
  ret i32 %.274 
.269:
  store i32 19, i32* %.223
  br label %.277wc60 
.277wc60:
  %.281 = load i32, i32* %.223
  %.282 = icmp sge i32 %.281, 0
  br i1 %.282, label %.278wloop.60.66, label %.279wn66
.278wloop.60.66:
  %.286 = load i32, i32* %.199
  %.287 = load i32, i32* %.223
  %.288 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.286, i32 %.287
  %.289 = load i32, i32* %.288
  %.290 = load i32, i32* %.202
  %.291 = load i32, i32* %.223
  %.292 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.290, i32 %.291
  %.293 = load i32, i32* %.292
  %.294 = icmp ne i32 %.289, %.293
  br i1 %.294, label %.284, label %.285
.279wn66:
  %.311 = load i32, i32* %.199
  %.312 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.311, i32 0
  %.313 = load i32, i32* %.312
  ret i32 %.313 
.284:
  %.296 = load i32, i32* %.199
  %.297 = load i32, i32* %.223
  %.298 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.296, i32 %.297
  %.299 = load i32, i32* %.298
  store i32 %.299, i32* %.199
  %.301 = load i32, i32* %.202
  %.302 = load i32, i32* %.223
  %.303 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.301, i32 %.302
  %.304 = load i32, i32* %.303
  store i32 %.304, i32* %.202
  br label %.285 
.285:
  %.307 = load i32, i32* %.223
  %.308 = sub i32 %.307, 1
  store i32 %.308, i32* %.223
  br label %.277wc60 
}
define i32 @main(){
.316:
  %.356 = alloca i32
  %.353 = alloca i32
  %.335 = alloca i32
  %.332 = alloca i32
  %.322 = alloca i32
  %.317at70 = call i32 @quick_read()
  store i32 %.317at70, i32* @.g.n
  %.319at70 = call i32 @quick_read()
  store i32 %.319at70, i32* @.g.m
  call void @init()
  store i32 1, i32* %.322
  br label %.324wc73 
.324wc73:
  %.328 = load i32, i32* %.322
  %.329 = load i32, i32* @.g.n
  %.330 = icmp ne i32 %.328, %.329
  br i1 %.330, label %.325wloop.73.77, label %.326wn77
.325wloop.73.77:
  %.333at74 = call i32 @quick_read()
  store i32 %.333at74, i32* %.332
  %.336at74 = call i32 @quick_read()
  store i32 %.336at74, i32* %.335
  %.338 = load i32, i32* %.332
  %.339 = load i32, i32* %.335
  call void @add_edge(i32 %.338, i32 %.339)
  %.341 = load i32, i32* %.322
  %.342 = add i32 %.341, 1
  store i32 %.342, i32* %.322
  br label %.324wc73 
.326wn77:
  call void @tree(i32 1, i32 1)
  br label %.346wc79 
.346wc79:
  %.350 = load i32, i32* @.g.m
  %.351 = icmp ne i32 %.350, 0
  br i1 %.351, label %.347wloop.79.84, label %.348wn84
.347wloop.79.84:
  %.354at80 = call i32 @quick_read()
  store i32 %.354at80, i32* %.353
  %.357at80 = call i32 @quick_read()
  store i32 %.357at80, i32* %.356
  %.359 = load i32, i32* %.353
  %.360 = load i32, i32* %.356
  %.361at81 = call i32 @LCA(i32 %.359, i32 %.360)
  call void @putint(i32 %.361at81)
  call void @putch(i32 10)
  %.366 = load i32, i32* @.g.m
  %.367 = sub i32 %.366, 1
  store i32 %.367, i32* @.g.m
  br label %.346wc79 
.348wn84:
  ret i32 0 
}
@.g.n = global i32 zeroinitializer
@.g.m = global i32 zeroinitializer
@.g.f = global [10005 x [20 x i32]] zeroinitializer
@.g.dep = global [10005 x i32] zeroinitializer
@.g.to = global [10005 x i32] zeroinitializer
@.g.next = global [10005 x i32] zeroinitializer
@.g.head = global [10005 x i32] zeroinitializer
@.g.cnt = global i32 0
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
define void @add_edge(i32 %.80, i32 %.83){
.78:
  %.82 = alloca i32
  %.79 = alloca i32
  store i32 %.80, i32* %.79
  store i32 %.83, i32* %.82
  %.85 = load i32, i32* %.82
  %.86 = load i32, i32* @.g.cnt
  %.87 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.to, i32 0, i32 %.86
  store i32 %.85, i32* %.87
  %.89 = load i32, i32* %.79
  %.90 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.head, i32 0, i32 %.89
  %.91 = load i32, i32* %.90
  %.92 = load i32, i32* @.g.cnt
  %.93 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.next, i32 0, i32 %.92
  store i32 %.91, i32* %.93
  %.95 = load i32, i32* @.g.cnt
  %.96 = load i32, i32* %.79
  %.97 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.head, i32 0, i32 %.96
  store i32 %.95, i32* %.97
  %.99 = load i32, i32* @.g.cnt
  %.100 = add i32 %.99, 1
  store i32 %.100, i32* @.g.cnt
  %.102 = load i32, i32* %.79
  %.103 = load i32, i32* %.82
  %.104 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.103, i32 0
  store i32 %.102, i32* %.104
  ret void
}
define void @init(){
.108:
  %.112 = alloca i32
  %.110 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 0
  store i32 1061109567, i32* %.110
  store i32 1, i32* %.112
  br label %.114wc27 
.114wc27:
  %.118 = load i32, i32* %.112
  %.119 = load i32, i32* @.g.n
  %.120 = icmp sle i32 %.118, %.119
  br i1 %.120, label %.115wloop.27.30, label %.116wn30
.115wloop.27.30:
  %.123 = load i32, i32* %.112
  %.124 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.head, i32 0, i32 %.123
  store i32 -1, i32* %.124
  %.126 = load i32, i32* %.112
  %.127 = add i32 %.126, 1
  store i32 %.127, i32* %.112
  br label %.114wc27 
.116wn30:
  ret void
}
define void @tree(i32 %.134, i32 %.137){
.132:
  %.182 = alloca i32
  %.143 = alloca i32
  %.136 = alloca i32
  %.133 = alloca i32
  store i32 %.134, i32* %.133
  store i32 %.137, i32* %.136
  %.139 = load i32, i32* %.136
  %.140 = load i32, i32* %.133
  %.141 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.140
  store i32 %.139, i32* %.141
  store i32 0, i32* %.143
  br label %.145wc35 
.145wc35:
  %.149 = load i32, i32* %.133
  %.150 = load i32, i32* %.143
  %.151 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.149, i32 %.150
  %.152 = load i32, i32* %.151
  %.153 = icmp ne i32 %.152, 0
  br i1 %.153, label %.146wloop.35.38, label %.147wn38
.146wloop.35.38:
  %.155 = load i32, i32* %.133
  %.156 = load i32, i32* %.143
  %.157 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.155, i32 %.156
  %.158 = load i32, i32* %.157
  %.159 = load i32, i32* %.143
  %.160 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.158, i32 %.159
  %.161 = load i32, i32* %.160
  %.162 = load i32, i32* %.133
  %.163 = load i32, i32* %.143
  %.164 = add i32 %.163, 1
  %.165 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.162, i32 %.164
  store i32 %.161, i32* %.165
  %.167 = load i32, i32* %.143
  %.168 = add i32 %.167, 1
  store i32 %.168, i32* %.143
  br label %.145wc35 
.147wn38:
  %.171 = load i32, i32* %.133
  %.172 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.head, i32 0, i32 %.171
  %.173 = load i32, i32* %.172
  store i32 %.173, i32* %.143
  br label %.175wc40 
.175wc40:
  %.179 = load i32, i32* %.143
  %.180 = icmp ne i32 %.179, -1
  br i1 %.180, label %.176wloop.40.44, label %.177wn44
.176wloop.40.44:
  %.183 = load i32, i32* %.143
  %.184 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.to, i32 0, i32 %.183
  %.185 = load i32, i32* %.184
  store i32 %.185, i32* %.182
  %.187 = load i32, i32* %.182
  %.188 = load i32, i32* %.136
  %.189 = add i32 %.188, 1
  call void @tree(i32 %.187, i32 %.189)
  %.191 = load i32, i32* %.143
  %.192 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.next, i32 0, i32 %.191
  %.193 = load i32, i32* %.192
  store i32 %.193, i32* %.143
  br label %.175wc40 
.177wn44:
  ret void
}
define i32 @LCA(i32 %.200, i32 %.203){
.198:
  %.223 = alloca i32
  %.215 = alloca i32
  %.202 = alloca i32
  %.199 = alloca i32
  store i32 %.200, i32* %.199
  store i32 %.203, i32* %.202
  %.207 = load i32, i32* %.199
  %.208 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.207
  %.209 = load i32, i32* %.208
  %.210 = load i32, i32* %.202
  %.211 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.210
  %.212 = load i32, i32* %.211
  %.213 = icmp slt i32 %.209, %.212
  br i1 %.213, label %.205, label %.206
.205:
  %.216 = load i32, i32* %.199
  store i32 %.216, i32* %.215
  %.218 = load i32, i32* %.202
  store i32 %.218, i32* %.199
  %.220 = load i32, i32* %.215
  store i32 %.220, i32* %.202
  br label %.206 
.206:
  store i32 19, i32* %.223
  br label %.226wc53 
.226wc53:
  %.230 = load i32, i32* %.199
  %.231 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.230
  %.232 = load i32, i32* %.231
  %.233 = load i32, i32* %.202
  %.234 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.233
  %.235 = load i32, i32* %.234
  %.236 = icmp sgt i32 %.232, %.235
  br i1 %.236, label %.227wloop.53.57, label %.228wn57
.227wloop.53.57:
  %.240 = load i32, i32* %.199
  %.241 = load i32, i32* %.223
  %.242 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.240, i32 %.241
  %.243 = load i32, i32* %.242
  %.244 = icmp ne i32 %.243, 0
  br i1 %.244, label %.245, label %.239
.228wn57:
  %.270 = load i32, i32* %.199
  %.271 = load i32, i32* %.202
  %.272 = icmp eq i32 %.270, %.271
  br i1 %.272, label %.268, label %.269
.238:
  %.258 = load i32, i32* %.199
  %.259 = load i32, i32* %.223
  %.260 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.258, i32 %.259
  %.261 = load i32, i32* %.260
  store i32 %.261, i32* %.199
  br label %.239 
.239:
  %.264 = load i32, i32* %.223
  %.265 = sub i32 %.264, 1
  store i32 %.265, i32* %.223
  br label %.226wc53 
.245:
  %.247 = load i32, i32* %.199
  %.248 = load i32, i32* %.223
  %.249 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.247, i32 %.248
  %.250 = load i32, i32* %.249
  %.251 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.250
  %.252 = load i32, i32* %.251
  %.253 = load i32, i32* %.202
  %.254 = getelementptr inbounds [10005 x i32], [10005 x i32]* @.g.dep, i32 0, i32 %.253
  %.255 = load i32, i32* %.254
  %.256 = icmp sge i32 %.252, %.255
  br i1 %.256, label %.238, label %.239
.268:
  %.274 = load i32, i32* %.199
  ret i32 %.274 
.269:
  store i32 19, i32* %.223
  br label %.277wc60 
.277wc60:
  %.281 = load i32, i32* %.223
  %.282 = icmp sge i32 %.281, 0
  br i1 %.282, label %.278wloop.60.66, label %.279wn66
.278wloop.60.66:
  %.286 = load i32, i32* %.199
  %.287 = load i32, i32* %.223
  %.288 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.286, i32 %.287
  %.289 = load i32, i32* %.288
  %.290 = load i32, i32* %.202
  %.291 = load i32, i32* %.223
  %.292 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.290, i32 %.291
  %.293 = load i32, i32* %.292
  %.294 = icmp ne i32 %.289, %.293
  br i1 %.294, label %.284, label %.285
.279wn66:
  %.311 = load i32, i32* %.199
  %.312 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.311, i32 0
  %.313 = load i32, i32* %.312
  ret i32 %.313 
.284:
  %.296 = load i32, i32* %.199
  %.297 = load i32, i32* %.223
  %.298 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.296, i32 %.297
  %.299 = load i32, i32* %.298
  store i32 %.299, i32* %.199
  %.301 = load i32, i32* %.202
  %.302 = load i32, i32* %.223
  %.303 = getelementptr inbounds [10005 x [20 x i32]], [10005 x [20 x i32]]* @.g.f, i32 0, i32 %.301, i32 %.302
  %.304 = load i32, i32* %.303
  store i32 %.304, i32* %.202
  br label %.285 
.285:
  %.307 = load i32, i32* %.223
  %.308 = sub i32 %.307, 1
  store i32 %.308, i32* %.223
  br label %.277wc60 
}
define i32 @main(){
.316:
  %.356 = alloca i32
  %.353 = alloca i32
  %.335 = alloca i32
  %.332 = alloca i32
  %.322 = alloca i32
  %.317at70 = call i32 @quick_read()
  store i32 %.317at70, i32* @.g.n
  %.319at70 = call i32 @quick_read()
  store i32 %.319at70, i32* @.g.m
  call void @init()
  store i32 1, i32* %.322
  br label %.324wc73 
.324wc73:
  %.328 = load i32, i32* %.322
  %.329 = load i32, i32* @.g.n
  %.330 = icmp ne i32 %.328, %.329
  br i1 %.330, label %.325wloop.73.77, label %.326wn77
.325wloop.73.77:
  %.333at74 = call i32 @quick_read()
  store i32 %.333at74, i32* %.332
  %.336at74 = call i32 @quick_read()
  store i32 %.336at74, i32* %.335
  %.338 = load i32, i32* %.332
  %.339 = load i32, i32* %.335
  call void @add_edge(i32 %.338, i32 %.339)
  %.341 = load i32, i32* %.322
  %.342 = add i32 %.341, 1
  store i32 %.342, i32* %.322
  br label %.324wc73 
.326wn77:
  call void @tree(i32 1, i32 1)
  br label %.346wc79 
.346wc79:
  %.350 = load i32, i32* @.g.m
  %.351 = icmp ne i32 %.350, 0
  br i1 %.351, label %.347wloop.79.84, label %.348wn84
.347wloop.79.84:
  %.354at80 = call i32 @quick_read()
  store i32 %.354at80, i32* %.353
  %.357at80 = call i32 @quick_read()
  store i32 %.357at80, i32* %.356
  %.359 = load i32, i32* %.353
  %.360 = load i32, i32* %.356
  %.361at81 = call i32 @LCA(i32 %.359, i32 %.360)
  call void @putint(i32 %.361at81)
  call void @putch(i32 10)
  %.366 = load i32, i32* @.g.m
  %.367 = sub i32 %.36