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
@__constant..183 = constant [4 x [4 x i32]]  [[4 x i32]  [i32 0, i32 1, i32 1, i32 1], [4 x i32]  [i32 1, i32 0, i32 1, i32 0], [4 x i32]  [i32 1, i32 1, i32 0, i32 1], [4 x i32]  [i32 1, i32 0, i32 1, i32 0]]
define void @printSolution(i32* %.6){
.4:
  %.8 = alloca i32
  %.5 = alloca i32*
  store i32* %.6, i32** %.5
  store i32 0, i32* %.8
  br label %.11wc7 
.11wc7:
  %.15 = load i32, i32* %.8
  %.16 = icmp slt i32 %.15, 4
  br i1 %.16, label %.12wloop.7.11, label %.13wn11
.12wloop.7.11:
  %.18 = load i32, i32* %.8
  %.19 = load i32*, i32** %.5
  %.20 = getelementptr inbounds i32, i32* %.19, i32 %.18
  %.21 = load i32, i32* %.20
  call void @putint(i32 %.21)
  call void @putch(i32 32)
  %.26 = load i32, i32* %.8
  %.28 = add i32 %.26, 1
  store i32 %.28, i32* %.8
  br label %.11wc7 
.13wn11:
  call void @putch(i32 10)
  ret void
}
define void @printMessage(){
.34:
  call void @putch(i32 78)
  call void @putch(i32 111)
  call void @putch(i32 116)
  call void @putch(i32 32)
  call void @putch(i32 101)
  call void @putch(i32 120)
  call void @putch(i32 105)
  call void @putch(i32 115)
  call void @putch(i32 116)
  ret void
}
define i32 @isSafe([4 x i32]* %.55, i32* %.58){
.53:
  %.69 = alloca i32
  %.60 = alloca i32
  %.57 = alloca i32*
  %.54 = alloca [4 x i32]*
  store [4 x i32]* %.55, [4 x i32]** %.54
  store i32* %.58, i32** %.57
  store i32 0, i32* %.60
  br label %.62wc23 
.62wc23:
  %.66 = load i32, i32* %.60
  %.67 = icmp slt i32 %.66, 4
  br i1 %.67, label %.63wloop.23.31, label %.64wn31
.63wloop.23.31:
  %.70 = load i32, i32* %.60
  %.71 = add i32 %.70, 1
  store i32 %.71, i32* %.69
  br label %.73wc25 
.64wn31:
  ret i32 1 
.73wc25:
  %.77 = load i32, i32* %.69
  %.78 = icmp slt i32 %.77, 4
  br i1 %.78, label %.74wloop.25.29, label %.75wn29
.74wloop.25.29:
  %.82 = load i32, i32* %.60
  %.83 = load i32, i32* %.69
  %.84 = load [4 x i32]*, [4 x i32]** %.54
  %.85 = getelementptr inbounds [4 x i32], [4 x i32]* %.84, i32 %.82, i32 %.83
  %.86 = load i32, i32* %.85
  %.87 = icmp ne i32 %.86, 0
  br i1 %.87, label %.88, label %.81
.75wn29:
  %.105 = load i32, i32* %.60
  %.106 = add i32 %.105, 1
  store i32 %.106, i32* %.60
  br label %.62wc23 
.80:
  ret i32 0 
.81:
  %.101 = load i32, i32* %.69
  %.102 = add i32 %.101, 1
  store i32 %.102, i32* %.69
  br label %.73wc25 
.88:
  %.90 = load i32, i32* %.69
  %.91 = load i32*, i32** %.57
  %.92 = getelementptr inbounds i32, i32* %.91, i32 %.90
  %.93 = load i32, i32* %.92
  %.94 = load i32, i32* %.60
  %.95 = load i32*, i32** %.57
  %.96 = getelementptr inbounds i32, i32* %.95, i32 %.94
  %.97 = load i32, i32* %.96
  %.98 = icmp eq i32 %.93, %.97
  br i1 %.98, label %.80, label %.81
}
define i32 @graphColoring([4 x i32]* %.113, i32 %.116, i32 %.119, i32* %.122){
.111:
  %.140 = alloca i32
  %.121 = alloca i32*
  %.118 = alloca i32
  %.115 = alloca i32
  %.112 = alloca [4 x i32]*
  store [4 x i32]* %.113, [4 x i32]** %.112
  store i32 %.116, i32* %.115
  store i32 %.119, i32* %.118
  store i32* %.122, i32** %.121
  %.126 = load i32, i32* %.118
  %.127 = icmp eq i32 %.126, 4
  br i1 %.127, label %.124, label %.125
.124:
  %.131 = load [4 x i32]*, [4 x i32]** %.112
  %.132 = load i32*, i32** %.121
  %.133at37 = call i32 @isSafe([4 x i32]* %.131, i32* %.132)
  %.134 = icmp ne i32 %.133at37, 0
  br i1 %.134, label %.129, label %.130
.125:
  store i32 1, i32* %.140
  br label %.142wc44 
.129:
  %.136 = load i32*, i32** %.121
  call void @printSolution(i32* %.136)
  ret i32 1 
.130:
  ret i32 0 
.142wc44:
  %.146 = load i32, i32* %.140
  %.147 = load i32, i32* %.115
  %.148 = icmp sle i32 %.146, %.147
  br i1 %.148, label %.143wloop.44.50, label %.144wn50
.143wloop.44.50:
  %.150 = load i32, i32* %.140
  %.151 = load i32, i32* %.118
  %.152 = load i32*, i32** %.121
  %.153 = getelementptr inbounds i32, i32* %.152, i32 %.151
  store i32 %.150, i32* %.153
  %.157 = load [4 x i32]*, [4 x i32]** %.112
  %.158 = load i32, i32* %.115
  %.159 = load i32, i32* %.118
  %.160 = add i32 %.159, 1
  %.161 = load i32*, i32** %.121
  %.162at46 = call i32 @graphColoring([4 x i32]* %.157, i32 %.158, i32 %.160, i32* %.161)
  %.163 = icmp ne i32 %.162at46, 0
  br i1 %.163, label %.155, label %.156
.144wn50:
  ret i32 0 
.155:
  ret i32 1 
.156:
  %.166 = load i32, i32* %.118
  %.167 = load i32*, i32** %.121
  %.168 = getelementptr inbounds i32, i32* %.167, i32 %.166
  store i32 0, i32* %.168
  %.170 = load i32, i32* %.140
  %.171 = add i32 %.170, 1
  store i32 %.171, i32* %.140
  br label %.142wc44 
}
define i32 @main(){
.176:
  %.193 = alloca i32
  %.192 = alloca [4 x i32]
  %.189 = alloca i32
  %.177 = alloca [4 x [4 x i32]]
  call void @llvm.memcpy.p0.p0.i32([4 x [4 x i32]]* %.177, [4 x [4 x i32]]* @__constant..183, i32 64, i1 false)
  store i32 3, i32* %.189
  store i32 0, i32* %.193
  br label %.195wc62 
.195wc62:
  %.199 = load i32, i32* %.193
  %.200 = icmp slt i32 %.199, 4
  br i1 %.200, label %.196wloop.62.65, label %.197wn65
.196wloop.62.65:
  %.202 = load i32, i32* %.193
  %.203 = getelementptr inbounds [4 x i32], [4 x i32]* %.192, i32 0, i32 %.202
  store i32 0, i32* %.203
  %.205 = load i32, i32* %.193
  %.206 = add i32 %.205, 1
  store i32 %.206, i32* %.193
  br label %.195wc62 
.197wn65:
  %.211 = getelementptr inbounds [4 x [4 x i32]], [4 x [4 x i32]]* %.177, i32 0, i32 0
  %.212 = load i32, i32* %.189
  %.213 = getelementptr inbounds [4 x i32], [4 x i32]* %.192, i32 0, i32 0
  %.214at66 = call i32 @graphColoring([4 x i32]* %.211, i32 %.212, i32 0, i32* %.213)
  %.215 = icmp eq i32 %.214at66, 0
  br i1 %.215, label %.209, label %.210
.209:
  call void @printMessage()
  br label %.210 
.210:
  ret i32 0 
}
@__constant..183 = constant [4 x [4 x i32]]  [[4 x i32]  [i32 0, i32 1, i32 1, i32 1], [4 x i32]  [i32 1, i32 0, i32 1, i32 0], [4 x i32]  [i32 1, i32 1, i32 0, i32 1], [4 x i32]  [i32 1, i32 0, i32 1, i32 0]]
define void @printSolution(i32* %.6){
.4:
  %.8 = alloca i32
  %.5 = alloca i32*
  store i32* %.6, i32** %.5
  store i32 0, i32* %.8
  br label %.11wc7 
.11wc7:
  %.15 = load i32, i32* %.8
  %.16 = icmp slt i32 %.15, 4
  br i1 %.16, label %.12wloop.7.11, label %.13wn11
.12wloop.7.11:
  %.18 = load i32, i32* %.8
  %.19 = load i32*, i32** %.5
  %.20 = getelementptr inbounds i32, i32* %.19, i32 %.18
  %.21 = load i32, i32* %.20
  call void @putint(i32 %.21)
  call void @putch(i32 32)
  %.26 = load i32, i32* %.8
  %.28 = add i32 %.26, 1
  store i32 %.28, i32* %.8
  br label %.11wc7 
.13wn11:
  call void @putch(i32 10)
  ret void
}
define void @printMessage(){
.34:
  call void @putch(i32 78)
  call void @putch(i32 111)
  call void @putch(i32 116)
  call void @putch(i32 32)
  call void @putch(i32 101)
  call void @putch(i32 120)
  call void @putch(i32 105)
  call void @putch(i32 115)
  call void @putch(i32 116)
  ret void
}
define i32 @isSafe([4 x i32]* %.55, i32* %.58){
.53:
  %.69 = alloca i32
  %.60 = alloca i32
  %.57 = alloca i32*
  %.54 = alloca [4 x i32]*
  store [4 x i32]* %.55, [4 x i32]** %.54
  store i32* %.58, i32** %.57
  store i32 0, i32* %.60
  br label %.62wc23 
.62wc23:
  %.66 = load i32, i32* %.60
  %.67 = icmp slt i32 %.66, 4
  br i1 %.67, label %.63wloop.23.31, label %.64wn31
.63wloop.23.31:
  %.70 = load i32, i32* %.60
  %.71 = add i32 %.70, 1
  store i32 %.71, i32* %.69
  br label %.73wc25 
.64wn31:
  ret i32 1 
.73wc25:
  %.77 = load i32, i32* %.69
  %.78 = icmp slt i32 %.77, 4
  br i1 %.78, label %.74wloop.25.29, label %.75wn29
.74wloop.25.29:
  %.82 = load i32, i32* %.60
  %.83 = load i32, i32* %.69
  %.84 = load [4 x i32]*, [4 x i32]** %.54
  %.85 = getelementptr inbounds [4 x i32], [4 x i32]* %.84, i32 %.82, i32 %.83
  %.86 = load i32, i32* %.85
  %.87 = icmp ne i32 %.86, 0
  br i1 %.87, label %.88, label %.81
.75wn29:
  %.105 = load i32, i32* %.60
  %.106 = add i32 %.105, 1
  store i32 %.106, i32* %.60
  br label %.62wc23 
.80:
  ret i32 0 
.81:
  %.101 = load i32, i32* %.69
  %.102 = add i32 %.101, 1
  store i32 %.102, i32* %.69
  br label %.73wc25 
.88:
  %.90 = load i32, i32* %.69
  %.91 = load i32*, i32** %.57
  %.92 = getelementptr inbounds i32, i32* %.91, i32 %.90
  %.93 = load i32, i32* %.92
  %.94 = load i32, i32* %.60
  %.95 = load i32*, i32** %.57
  %.96 = getelementptr inbounds i32, i32* %.95, i32 %.94
  %.97 = load i32, i32* %.96
  %.98 = icmp eq i32 %.93, %.97
  br i1 %.98, label %.80, label %.81
}
define i32 @graphColoring([4 x i32]* %.113, i32 %.116, i32 %.119, i32* %.122){
.111:
  %.140 = alloca i32
  %.121 = alloca i32*
  %.118 = alloca i32
  %.115 = alloca i32
  %.112 = alloca [4 x i32]*
  store [4 x i32]* %.113, [4 x i32]** %.112
  store i32 %.116, i32* %.115
  store i32 %.119, i32* %.118
  store i32* %.122, i32** %.121
  %.126 = load i32, i32* %.118
  %.127 = icmp eq i32 %.126, 4
  br i1 %.127, label %.124, label %.125
.124:
  %.131 = load [4 x i32]*, [4 x i32]** %.112
  %.132 = load i32*, i32** %.121
  %.133at37 = call i32 @isSafe([4 x i32]* %.131, i32* %.132)
  %.134 = icmp ne i32 %.133at37, 0
  br i1 %.134, label %.129, label %.130
.125:
  store i32 1, i32* %.140
  br label %.142wc44 
.129:
  %.136 = load i32*, i32** %.121
  call void @printSolution(i32* %.136)
  ret i32 1 
.130:
  ret i32 0 
.142wc44:
  %.146 = load i32, i32* %.140
  %.147 = load i32, i32* %.115
  %.148 = icmp sle i32 %.146, %.147
  br i1 %.148, label %.143wloop.44.50, label %.144wn50
.143wloop.44.50:
  %.150 = load i32, i32* %.140
  %.151 = load i32, i32* %.118
  %.152 = load i32*, i32** %.121
  %.153 = getelementptr inbounds i32, i32* %.152, i32 %.151
  store i32 %.150, i32* %.153
  %.157 = load [4 x i32]*, [4 x i32]** %.112
  %.158 = load i32, i32* %.115
  %.159 = load i32, i32* %.118
  %.160 = add i32 %.159, 1
  %.161 = load i32*, i32** %.121
  %.162at46 = call i32 @graphColoring([4 x i32]* %.157, i32 %.158, i32 %.160, i32* %.161)
  %.163 = icmp ne i32 %.162at46, 0
  br i1 %.163, label %.155, label %.156
.144wn50:
  ret i32 0 
.155:
  ret i32 1 
.156:
  %.166 = load i32, i32* %.118
  %.167 = load i32*, i32** %.121
  %.168 = getelementptr inbounds i32, i32* %.167, i32 %.166
  store i32 0, i32* %.168
  %.170 = load i32, i32* %.140
  %.171 = add i32 %.170, 1
  store i32 %.171, i32* %.140
  br label %.142wc44 
}
define i32 @main(){
.176:
  %.193 = alloca i32
  %.192 = alloca [4 x i32]
  %.189 = alloca i32
  %.177 = alloca [4 x [4 x i32]]
  call void @llvm.memcpy.p0.p0.i32([4 x [4 x i32]]* %.177, [4 x [4 x i32]]* @__constant..183, i32 64, i1 false)
  store i32 3, i32* %.189
  store i32 0, i32* %.193
  br label %.195wc62 
.195wc62:
  %.199 = load i32, i32* %.193
  %.200 = icmp slt i32 %.199, 4
  br i1 %.200, label %.196wloop.62.65, label %.197wn65
.196wloop.62.65:
  %.202 = load i32, i32* %.193
  %.203 = getelementptr inbounds [4 x i32], [4 x i32]* %.192, i32 0, i32 %.202
  store i32 0, i32* %.203
  %.205 = load i32, i32* %.193
  %.206 = add i32 %.205, 1
  store i32 %.206, i32* %.193
  br label %.195wc62 
.197wn65:
  %.211 = getelementptr inbounds [4 x [4 x i32]], [4 x [4 x i32]]* %.177, i32 0, i32 0
  %.212 = load i32, i32* %.189
  %.213 = getelementptr inbounds [4 x i32], [4 x i32]* %.192, i32 0, i32 0
  %.214at66 = call i32 @graphColoring([4 x i32]* %.211, i32 %.212, i32 0, i32* %.213)
  %.215 = icmp eq i32 %.214at66, 0
  br i1 %.215, label %.209, label %.210
.209:
  call void @printM