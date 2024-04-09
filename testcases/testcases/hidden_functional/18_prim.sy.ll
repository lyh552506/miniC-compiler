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
@.g.u = global [1005 x i32] zeroinitializer
@.g.v = global [1005 x i32] zeroinitializer
@.g.c = global [1005 x i32] zeroinitializer
@.g.fa = global [1005 x i32] zeroinitializer
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
define i32 @find(i32 %.78){
.76:
  %.90 = alloca i32
  %.77 = alloca i32
  store i32 %.78, i32* %.77
  %.82 = load i32, i32* %.77
  %.83 = load i32, i32* %.77
  %.84 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.83
  %.85 = load i32, i32* %.84
  %.86 = icmp eq i32 %.82, %.85
  br i1 %.86, label %.80, label %.81
.80:
  %.88 = load i32, i32* %.77
  ret i32 %.88 
.81:
  %.91 = load i32, i32* %.77
  %.92 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.91
  %.93 = load i32, i32* %.92
  %.94at20 = call i32 @find(i32 %.93)
  store i32 %.94at20, i32* %.90
  %.96 = load i32, i32* %.90
  %.97 = load i32, i32* %.77
  %.98 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.97
  store i32 %.96, i32* %.98
  %.100 = load i32, i32* %.90
  ret i32 %.100 
}
define i32 @same(i32 %.105, i32 %.108){
.103:
  %.107 = alloca i32
  %.104 = alloca i32
  store i32 %.105, i32* %.104
  store i32 %.108, i32* %.107
  %.110 = load i32, i32* %.104
  %.111at25 = call i32 @find(i32 %.110)
  store i32 %.111at25, i32* %.104
  %.113 = load i32, i32* %.107
  %.114at26 = call i32 @find(i32 %.113)
  store i32 %.114at26, i32* %.107
  %.118 = load i32, i32* %.104
  %.119 = load i32, i32* %.107
  %.120 = icmp eq i32 %.118, %.119
  br i1 %.120, label %.116, label %.117
.116:
  ret i32 1 
.117:
  ret i32 0 
}
define i32 @prim(){
.125:
  %.228 = alloca i32
  %.158 = alloca i32
  %.136 = alloca i32
  %.126 = alloca i32
  store i32 0, i32* %.126
  br label %.128wc32 
.128wc32:
  %.132 = load i32, i32* %.126
  %.133 = load i32, i32* @.g.m
  %.134 = icmp slt i32 %.132, %.133
  br i1 %.134, label %.129wloop.32.49, label %.130wn49
.129wloop.32.49:
  %.137 = load i32, i32* %.126
  %.138 = add i32 %.137, 1
  store i32 %.138, i32* %.136
  br label %.140wc34 
.130wn49:
  store i32 1, i32* %.126
  br label %.211wc51 
.140wc34:
  %.144 = load i32, i32* %.136
  %.145 = load i32, i32* @.g.m
  %.146 = icmp slt i32 %.144, %.145
  br i1 %.146, label %.141wloop.34.47, label %.142wn47
.141wloop.34.47:
  %.150 = load i32, i32* %.126
  %.151 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.150
  %.152 = load i32, i32* %.151
  %.153 = load i32, i32* %.136
  %.154 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.153
  %.155 = load i32, i32* %.154
  %.156 = icmp sgt i32 %.152, %.155
  br i1 %.156, label %.148, label %.149
.142wn47:
  %.206 = load i32, i32* %.126
  %.207 = add i32 %.206, 1
  store i32 %.207, i32* %.126
  br label %.128wc32 
.148:
  %.159 = load i32, i32* %.126
  %.160 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.159
  %.161 = load i32, i32* %.160
  store i32 %.161, i32* %.158
  %.163 = load i32, i32* %.136
  %.164 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.163
  %.165 = load i32, i32* %.164
  %.166 = load i32, i32* %.126
  %.167 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.166
  store i32 %.165, i32* %.167
  %.169 = load i32, i32* %.158
  %.170 = load i32, i32* %.136
  %.171 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.170
  store i32 %.169, i32* %.171
  %.173 = load i32, i32* %.126
  %.174 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.173
  %.175 = load i32, i32* %.174
  store i32 %.175, i32* %.158
  %.177 = load i32, i32* %.136
  %.178 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.177
  %.179 = load i32, i32* %.178
  %.180 = load i32, i32* %.126
  %.181 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.180
  store i32 %.179, i32* %.181
  %.183 = load i32, i32* %.158
  %.184 = load i32, i32* %.136
  %.185 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.184
  store i32 %.183, i32* %.185
  %.187 = load i32, i32* %.126
  %.188 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.187
  %.189 = load i32, i32* %.188
  store i32 %.189, i32* %.158
  %.191 = load i32, i32* %.136
  %.192 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.191
  %.193 = load i32, i32* %.192
  %.194 = load i32, i32* %.126
  %.195 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.194
  store i32 %.193, i32* %.195
  %.197 = load i32, i32* %.158
  %.198 = load i32, i32* %.136
  %.199 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.198
  store i32 %.197, i32* %.199
  br label %.149 
.149:
  %.202 = load i32, i32* %.136
  %.203 = add i32 %.202, 1
  store i32 %.203, i32* %.136
  br label %.140wc34 
.211wc51:
  %.215 = load i32, i32* %.126
  %.216 = load i32, i32* @.g.n
  %.217 = icmp sle i32 %.215, %.216
  br i1 %.217, label %.212wloop.51.54, label %.213wn54
.212wloop.51.54:
  %.219 = load i32, i32* %.126
  %.220 = load i32, i32* %.126
  %.221 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.220
  store i32 %.219, i32* %.221
  %.223 = load i32, i32* %.126
  %.224 = add i32 %.223, 1
  store i32 %.224, i32* %.126
  br label %.211wc51 
.213wn54:
  store i32 0, i32* %.126
  store i32 0, i32* %.228
  br label %.230wc57 
.230wc57:
  %.234 = load i32, i32* %.126
  %.235 = load i32, i32* @.g.m
  %.236 = icmp slt i32 %.234, %.235
  br i1 %.236, label %.231wloop.57.62, label %.232wn62
.231wloop.57.62:
  %.240 = load i32, i32* %.126
  %.241 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.240
  %.242 = load i32, i32* %.241
  %.243 = load i32, i32* %.126
  %.244 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.243
  %.245 = load i32, i32* %.244
  %.246at58 = call i32 @same(i32 %.242, i32 %.245)
  %.247 = icmp ne i32 %.246at58, 0
  br i1 %.247, label %.238, label %.239
.232wn62:
  %.269 = load i32, i32* %.228
  ret i32 %.269 
.238:
  br label %.230wc57 
.239:
  %.250 = load i32, i32* %.228
  %.251 = load i32, i32* %.126
  %.252 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.251
  %.253 = load i32, i32* %.252
  %.254 = add i32 %.250, %.253
  store i32 %.254, i32* %.228
  %.256 = load i32, i32* %.126
  %.257 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.256
  %.258 = load i32, i32* %.257
  %.259 = load i32, i32* %.126
  %.260 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.259
  %.261 = load i32, i32* %.260
  %.262at60 = call i32 @find(i32 %.261)
  %.263 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.262at60
  store i32 %.258, i32* %.263
  %.265 = load i32, i32* %.126
  %.266 = add i32 %.265, 1
  store i32 %.266, i32* %.126
  br label %.230wc57 
}
define i32 @main(){
.272:
  %.279 = alloca i32
  %.276 = alloca i32
  %.273 = alloca i32
  %.274at66 = call i32 @quick_read()
  store i32 %.274at66, i32* %.273
  %.277at66 = call i32 @quick_read()
  store i32 %.277at66, i32* %.276
  store i32 0, i32* %.279
  br label %.281wc68 
.281wc68:
  %.285 = load i32, i32* %.279
  %.286 = load i32, i32* %.276
  %.287 = icmp slt i32 %.285, %.286
  br i1 %.287, label %.282wloop.68.73, label %.283wn73
.282wloop.68.73:
  %.289at69 = call i32 @quick_read()
  %.290 = load i32, i32* %.279
  %.291 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.290
  store i32 %.289at69, i32* %.291
  %.293at70 = call i32 @quick_read()
  %.294 = load i32, i32* %.279
  %.295 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.294
  store i32 %.293at70, i32* %.295
  %.297at71 = call i32 @quick_read()
  %.298 = load i32, i32* %.279
  %.299 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.298
  store i32 %.297at71, i32* %.299
  %.301 = load i32, i32* %.279
  %.302 = add i32 %.301, 1
  store i32 %.302, i32* %.279
  br label %.281wc68 
.283wn73:
  %.305at74 = call i32 @prim()
  ret i32 %.305at74 
}
@.g.n = global i32 zeroinitializer
@.g.m = global i32 zeroinitializer
@.g.u = global [1005 x i32] zeroinitializer
@.g.v = global [1005 x i32] zeroinitializer
@.g.c = global [1005 x i32] zeroinitializer
@.g.fa = global [1005 x i32] zeroinitializer
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
define i32 @find(i32 %.78){
.76:
  %.90 = alloca i32
  %.77 = alloca i32
  store i32 %.78, i32* %.77
  %.82 = load i32, i32* %.77
  %.83 = load i32, i32* %.77
  %.84 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.83
  %.85 = load i32, i32* %.84
  %.86 = icmp eq i32 %.82, %.85
  br i1 %.86, label %.80, label %.81
.80:
  %.88 = load i32, i32* %.77
  ret i32 %.88 
.81:
  %.91 = load i32, i32* %.77
  %.92 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.91
  %.93 = load i32, i32* %.92
  %.94at20 = call i32 @find(i32 %.93)
  store i32 %.94at20, i32* %.90
  %.96 = load i32, i32* %.90
  %.97 = load i32, i32* %.77
  %.98 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.97
  store i32 %.96, i32* %.98
  %.100 = load i32, i32* %.90
  ret i32 %.100 
}
define i32 @same(i32 %.105, i32 %.108){
.103:
  %.107 = alloca i32
  %.104 = alloca i32
  store i32 %.105, i32* %.104
  store i32 %.108, i32* %.107
  %.110 = load i32, i32* %.104
  %.111at25 = call i32 @find(i32 %.110)
  store i32 %.111at25, i32* %.104
  %.113 = load i32, i32* %.107
  %.114at26 = call i32 @find(i32 %.113)
  store i32 %.114at26, i32* %.107
  %.118 = load i32, i32* %.104
  %.119 = load i32, i32* %.107
  %.120 = icmp eq i32 %.118, %.119
  br i1 %.120, label %.116, label %.117
.116:
  ret i32 1 
.117:
  ret i32 0 
}
define i32 @prim(){
.125:
  %.228 = alloca i32
  %.158 = alloca i32
  %.136 = alloca i32
  %.126 = alloca i32
  store i32 0, i32* %.126
  br label %.128wc32 
.128wc32:
  %.132 = load i32, i32* %.126
  %.133 = load i32, i32* @.g.m
  %.134 = icmp slt i32 %.132, %.133
  br i1 %.134, label %.129wloop.32.49, label %.130wn49
.129wloop.32.49:
  %.137 = load i32, i32* %.126
  %.138 = add i32 %.137, 1
  store i32 %.138, i32* %.136
  br label %.140wc34 
.130wn49:
  store i32 1, i32* %.126
  br label %.211wc51 
.140wc34:
  %.144 = load i32, i32* %.136
  %.145 = load i32, i32* @.g.m
  %.146 = icmp slt i32 %.144, %.145
  br i1 %.146, label %.141wloop.34.47, label %.142wn47
.141wloop.34.47:
  %.150 = load i32, i32* %.126
  %.151 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.150
  %.152 = load i32, i32* %.151
  %.153 = load i32, i32* %.136
  %.154 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.153
  %.155 = load i32, i32* %.154
  %.156 = icmp sgt i32 %.152, %.155
  br i1 %.156, label %.148, label %.149
.142wn47:
  %.206 = load i32, i32* %.126
  %.207 = add i32 %.206, 1
  store i32 %.207, i32* %.126
  br label %.128wc32 
.148:
  %.159 = load i32, i32* %.126
  %.160 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.159
  %.161 = load i32, i32* %.160
  store i32 %.161, i32* %.158
  %.163 = load i32, i32* %.136
  %.164 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.163
  %.165 = load i32, i32* %.164
  %.166 = load i32, i32* %.126
  %.167 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.166
  store i32 %.165, i32* %.167
  %.169 = load i32, i32* %.158
  %.170 = load i32, i32* %.136
  %.171 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.170
  store i32 %.169, i32* %.171
  %.173 = load i32, i32* %.126
  %.174 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.173
  %.175 = load i32, i32* %.174
  store i32 %.175, i32* %.158
  %.177 = load i32, i32* %.136
  %.178 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.177
  %.179 = load i32, i32* %.178
  %.180 = load i32, i32* %.126
  %.181 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.180
  store i32 %.179, i32* %.181
  %.183 = load i32, i32* %.158
  %.184 = load i32, i32* %.136
  %.185 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.184
  store i32 %.183, i32* %.185
  %.187 = load i32, i32* %.126
  %.188 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.187
  %.189 = load i32, i32* %.188
  store i32 %.189, i32* %.158
  %.191 = load i32, i32* %.136
  %.192 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.191
  %.193 = load i32, i32* %.192
  %.194 = load i32, i32* %.126
  %.195 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.194
  store i32 %.193, i32* %.195
  %.197 = load i32, i32* %.158
  %.198 = load i32, i32* %.136
  %.199 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.198
  store i32 %.197, i32* %.199
  br label %.149 
.149:
  %.202 = load i32, i32* %.136
  %.203 = add i32 %.202, 1
  store i32 %.203, i32* %.136
  br label %.140wc34 
.211wc51:
  %.215 = load i32, i32* %.126
  %.216 = load i32, i32* @.g.n
  %.217 = icmp sle i32 %.215, %.216
  br i1 %.217, label %.212wloop.51.54, label %.213wn54
.212wloop.51.54:
  %.219 = load i32, i32* %.126
  %.220 = load i32, i32* %.126
  %.221 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.220
  store i32 %.219, i32* %.221
  %.223 = load i32, i32* %.126
  %.224 = add i32 %.223, 1
  store i32 %.224, i32* %.126
  br label %.211wc51 
.213wn54:
  store i32 0, i32* %.126
  store i32 0, i32* %.228
  br label %.230wc57 
.230wc57:
  %.234 = load i32, i32* %.126
  %.235 = load i32, i32* @.g.m
  %.236 = icmp slt i32 %.234, %.235
  br i1 %.236, label %.231wloop.57.62, label %.232wn62
.231wloop.57.62:
  %.240 = load i32, i32* %.126
  %.241 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.240
  %.242 = load i32, i32* %.241
  %.243 = load i32, i32* %.126
  %.244 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.243
  %.245 = load i32, i32* %.244
  %.246at58 = call i32 @same(i32 %.242, i32 %.245)
  %.247 = icmp ne i32 %.246at58, 0
  br i1 %.247, label %.238, label %.239
.232wn62:
  %.269 = load i32, i32* %.228
  ret i32 %.269 
.238:
  br label %.230wc57 
.239:
  %.250 = load i32, i32* %.228
  %.251 = load i32, i32* %.126
  %.252 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.251
  %.253 = load i32, i32* %.252
  %.254 = add i32 %.250, %.253
  store i32 %.254, i32* %.228
  %.256 = load i32, i32* %.126
  %.257 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.256
  %.258 = load i32, i32* %.257
  %.259 = load i32, i32* %.126
  %.260 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.259
  %.261 = load i32, i32* %.260
  %.262at60 = call i32 @find(i32 %.261)
  %.263 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.fa, i32 0, i32 %.262at60
  store i32 %.258, i32* %.263
  %.265 = load i32, i32* %.126
  %.266 = add i32 %.265, 1
  store i32 %.266, i32* %.126
  br label %.230wc57 
}
define i32 @main(){
.272:
  %.279 = alloca i32
  %.276 = alloca i32
  %.273 = alloca i32
  %.274at66 = call i32 @quick_read()
  store i32 %.274at66, i32* %.273
  %.277at66 = call i32 @quick_read()
  store i32 %.277at66, i32* %.276
  store i32 0, i32* %.279
  br label %.281wc68 
.281wc68:
  %.285 = load i32, i32* %.279
  %.286 = load i32, i32* %.276
  %.287 = icmp slt i32 %.285, %.286
  br i1 %.287, label %.282wloop.68.73, label %.283wn73
.282wloop.68.73:
  %.289at69 = call i32 @quick_read()
  %.290 = load i32, i32* %.279
  %.291 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.u, i32 0, i32 %.290
  store i32 %.289at69, i32* %.291
  %.293at70 = call i32 @quick_read()
  %.294 = load i32, i32* %.279
  %.295 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.v, i32 0, i32 %.294
  store i32 %.293at70, i32* %.295
  %.297at71 = call i32 @quick_read()
  %.298 = load i32, i32* %.279
  %.299 = getelementptr inbounds [1005 x i32], [1005 x i32]* @.g.c, i32 0, i32 %.298
  store i32 %.297at71, i32* %.299
  %.301 = load i32, i32* %.279
  %.302 = add i32 %.301, 1
  store i3