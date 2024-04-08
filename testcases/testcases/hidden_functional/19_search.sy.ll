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
@.g.a = global [30 x [30 x i32]] zeroinitializer
@.g.step = global [4 x [2 x i32]]  [[2 x i32]  [i32 1, i32 0], [2 x i32]  [i32 -1, i32 0], [2 x i32]  [i32 0, i32 1], [2 x i32]  [i32 0, i32 -1]]
@.g.w = global i32 zeroinitializer
@.g.h = global i32 zeroinitializer
@.g.x_0 = global i32 zeroinitializer
@.g.y_0 = global i32 zeroinitializer
@.g.x_1 = global i32 zeroinitializer
@.g.y_1 = global i32 zeroinitializer
define i32 @search(i32 %.23, i32 %.26, i32 %.29){
.21:
  %.145 = alloca i32
  %.54 = alloca i32
  %.51 = alloca i32
  %.49 = alloca i32
  %.40 = alloca i32
  %.38 = alloca i32
  %.28 = alloca i32
  %.25 = alloca i32
  %.22 = alloca i32
  store i32 %.23, i32* %.22
  store i32 %.26, i32* %.25
  store i32 %.29, i32* %.28
  %.33 = load i32, i32* %.28
  %.35 = icmp sgt i32 %.33, 10
  br i1 %.35, label %.31, label %.32
.31:
  ret i32 1073741824 
.32:
  store i32 1073741824, i32* %.38
  store i32 0, i32* %.40
  br label %.42wc12 
.42wc12:
  %.46 = load i32, i32* %.40
  %.47 = icmp slt i32 %.46, 4
  br i1 %.47, label %.43wloop.12.37, label %.44wn37
.43wloop.12.37:
  store i32 0, i32* %.49
  %.52 = load i32, i32* %.22
  store i32 %.52, i32* %.51
  %.55 = load i32, i32* %.25
  store i32 %.55, i32* %.54
  br label %.57wc15 
.44wn37:
  %.180 = load i32, i32* %.38
  %.181 = icmp sgt i32 %.180, 10
  br i1 %.181, label %.178, label %.179
.57wc15:
  %.61 = load i32, i32* %.51
  %.62 = load i32, i32* %.54
  %.63 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.61, i32 %.62
  %.64 = load i32, i32* %.63
  %.65 = icmp ne i32 %.64, 1
  br i1 %.65, label %.58wloop.15.20, label %.59wn20
.58wloop.15.20:
  %.69 = load i32, i32* %.51
  %.70 = load i32, i32* @.g.x_1
  %.71 = icmp eq i32 %.69, %.70
  br i1 %.71, label %.72, label %.68
.59wn20:
  %.97 = load i32, i32* %.51
  %.98 = load i32, i32* @.g.x_1
  %.99 = icmp eq i32 %.97, %.98
  br i1 %.99, label %.100, label %.96
.67:
  br label %.59wn20 
.68:
  %.79 = load i32, i32* %.51
  %.80 = load i32, i32* %.40
  %.81 = getelementptr inbounds [4 x [2 x i32]], [4 x [2 x i32]]* @.g.step, i32 0, i32 %.80, i32 0
  %.82 = load i32, i32* %.81
  %.83 = add i32 %.79, %.82
  store i32 %.83, i32* %.51
  %.85 = load i32, i32* %.54
  %.86 = load i32, i32* %.40
  %.87 = getelementptr inbounds [4 x [2 x i32]], [4 x [2 x i32]]* @.g.step, i32 0, i32 %.86, i32 1
  %.88 = load i32, i32* %.87
  %.89 = add i32 %.85, %.88
  store i32 %.89, i32* %.54
  %.91 = load i32, i32* %.49
  %.92 = add i32 %.91, 1
  store i32 %.92, i32* %.49
  br label %.57wc15 
.72:
  %.74 = load i32, i32* %.54
  %.75 = load i32, i32* @.g.y_1
  %.76 = icmp eq i32 %.74, %.75
  br i1 %.76, label %.67, label %.68
.95:
  ret i32 1 
.96:
  %.109 = load i32, i32* %.49
  %.110 = icmp sle i32 %.109, 1
  br i1 %.110, label %.107, label %.108
.100:
  %.102 = load i32, i32* %.54
  %.103 = load i32, i32* @.g.y_1
  %.104 = icmp eq i32 %.102, %.103
  br i1 %.104, label %.95, label %.96
.107:
  %.112 = load i32, i32* %.40
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* %.40
  br label %.42wc12 
.108:
  %.119 = load i32, i32* %.51
  %.120 = icmp eq i32 %.119, 0
  br i1 %.120, label %.116, label %.118
.116:
  %.137 = load i32, i32* %.40
  %.138 = add i32 %.137, 1
  store i32 %.138, i32* %.40
  br label %.42wc12 
.117:
  %.141 = load i32, i32* %.51
  %.142 = load i32, i32* %.54
  %.143 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.141, i32 %.142
  store i32 0, i32* %.143
  %.146 = load i32, i32* %.51
  %.147 = load i32, i32* %.40
  %.148 = getelementptr inbounds [4 x [2 x i32]], [4 x [2 x i32]]* @.g.step, i32 0, i32 %.147, i32 0
  %.149 = load i32, i32* %.148
  %.150 = sub i32 %.146, %.149
  %.151 = load i32, i32* %.54
  %.152 = load i32, i32* %.40
  %.153 = getelementptr inbounds [4 x [2 x i32]], [4 x [2 x i32]]* @.g.step, i32 0, i32 %.152, i32 1
  %.154 = load i32, i32* %.153
  %.155 = sub i32 %.151, %.154
  %.156 = load i32, i32* %.28
  %.157 = add i32 %.156, 1
  %.158at32 = call i32 @search(i32 %.150, i32 %.155, i32 %.157)
  %.159 = add i32 %.158at32, 1
  store i32 %.159, i32* %.145
  %.163 = load i32, i32* %.145
  %.164 = load i32, i32* %.38
  %.165 = icmp slt i32 %.163, %.164
  br i1 %.165, label %.161, label %.162
.118:
  %.123 = load i32, i32* %.51
  %.124 = load i32, i32* @.g.h
  %.125 = add i32 %.124, 1
  %.126 = icmp eq i32 %.123, %.125
  br i1 %.126, label %.116, label %.122
.122:
  %.129 = load i32, i32* %.54
  %.130 = icmp eq i32 %.129, 0
  br i1 %.130, label %.116, label %.128
.128:
  %.132 = load i32, i32* %.54
  %.133 = load i32, i32* @.g.w
  %.134 = add i32 %.133, 1
  %.135 = icmp eq i32 %.132, %.134
  br i1 %.135, label %.116, label %.117
.161:
  %.167 = load i32, i32* %.145
  store i32 %.167, i32* %.38
  br label %.162 
.162:
  %.170 = load i32, i32* %.51
  %.171 = load i32, i32* %.54
  %.172 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.170, i32 %.171
  store i32 1, i32* %.172
  %.174 = load i32, i32* %.40
  %.175 = add i32 %.174, 1
  store i32 %.175, i32* %.40
  br label %.42wc12 
.178:
  ret i32 1073741824 
.179:
  %.184 = load i32, i32* %.38
  ret i32 %.184 
}
define i32 @main(){
.187:
  %.290 = alloca i32
  %.201 = alloca i32
  %.200 = alloca i32
  %.189at46 = call i32 @getint()
  store i32 %.189at46, i32* @.g.w
  %.191at47 = call i32 @getint()
  store i32 %.191at47, i32* @.g.h
  br label %.193wc48 
.193wc48:
  %.197 = load i32, i32* @.g.w
  %.198 = icmp ne i32 %.197, 0
  br i1 %.198, label %.194wloop.48.87, label %.195wn87
.194wloop.48.87:
  store i32 0, i32* %.200
  br label %.203wc51 
.195wn87:
  ret i32 0 
.203wc51:
  %.207 = load i32, i32* %.200
  %.208 = icmp slt i32 %.207, 30
  br i1 %.208, label %.204wloop.51.58, label %.205wn58
.204wloop.51.58:
  store i32 0, i32* %.201
  br label %.211wc53 
.205wn58:
  store i32 1, i32* %.200
  br label %.231wc60 
.211wc53:
  %.215 = load i32, i32* %.201
  %.216 = icmp slt i32 %.215, 30
  br i1 %.216, label %.212wloop.53.56, label %.213wn56
.212wloop.53.56:
  %.218 = load i32, i32* %.200
  %.219 = load i32, i32* %.201
  %.220 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.218, i32 %.219
  store i32 1, i32* %.220
  %.222 = load i32, i32* %.201
  %.223 = add i32 %.222, 1
  store i32 %.223, i32* %.201
  br label %.211wc53 
.213wn56:
  %.226 = load i32, i32* %.200
  %.227 = add i32 %.226, 1
  store i32 %.227, i32* %.200
  br label %.203wc51 
.231wc60:
  %.235 = load i32, i32* %.200
  %.236 = load i32, i32* @.g.h
  %.237 = icmp sle i32 %.235, %.236
  br i1 %.237, label %.232wloop.60.75, label %.233wn75
.232wloop.60.75:
  store i32 1, i32* %.201
  br label %.240wc62 
.233wn75:
  %.291 = load i32, i32* @.g.x_0
  %.292 = load i32, i32* @.g.y_0
  %.293at76 = call i32 @search(i32 %.291, i32 %.292, i32 1)
  store i32 %.293at76, i32* %.290
  %.297 = load i32, i32* %.290
  %.298 = icmp sle i32 %.297, 10
  br i1 %.298, label %.295, label %.296
.240wc62:
  %.244 = load i32, i32* %.201
  %.245 = load i32, i32* @.g.w
  %.246 = icmp sle i32 %.244, %.245
  br i1 %.246, label %.241wloop.62.73, label %.242wn73
.241wloop.62.73:
  %.248at63 = call i32 @getint()
  %.249 = load i32, i32* %.200
  %.250 = load i32, i32* %.201
  %.251 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.249, i32 %.250
  store i32 %.248at63, i32* %.251
  %.255 = load i32, i32* %.200
  %.256 = load i32, i32* %.201
  %.257 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.255, i32 %.256
  %.258 = load i32, i32* %.257
  %.259 = icmp eq i32 %.258, 2
  br i1 %.259, label %.253, label %.254
.242wn73:
  %.286 = load i32, i32* %.200
  %.287 = add i32 %.286, 1
  store i32 %.287, i32* %.200
  br label %.231wc60 
.253:
  %.261 = load i32, i32* %.200
  store i32 %.261, i32* @.g.x_0
  %.263 = load i32, i32* %.201
  store i32 %.263, i32* @.g.y_0
  br label %.265 
.254:
  %.269 = load i32, i32* %.200
  %.270 = load i32, i32* %.201
  %.271 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.269, i32 %.270
  %.272 = load i32, i32* %.271
  %.274 = icmp eq i32 %.272, 3
  br i1 %.274, label %.267, label %.268
.265:
  %.282 = load i32, i32* %.201
  %.283 = add i32 %.282, 1
  store i32 %.283, i32* %.201
  br label %.240wc62 
.267:
  %.276 = load i32, i32* %.200
  store i32 %.276, i32* @.g.x_1
  %.278 = load i32, i32* %.201
  store i32 %.278, i32* @.g.y_1
  br label %.268 
.268:
  br label %.265 
.295:
  %.300 = load i32, i32* %.290
  call void @putint(i32 %.300)
  call void @putch(i32 10)
  br label %.305 
.296:
  call void @putint(i32 -1)
  call void @putch(i32 10)
  br label %.305 
.305:
  %.310at85 = call i32 @getint()
  store i32 %.310at85, i32* @.g.w
  %.312at86 = call i32 @getint()
  store i32 %.312at86, i32* @.g.h
  br label %.193wc48 
}
@.g.a = global [30 x [30 x i32]] zeroinitializer
@.g.step = global [4 x [2 x i32]]  [[2 x i32]  [i32 1, i32 0], [2 x i32]  [i32 -1, i32 0], [2 x i32]  [i32 0, i32 1], [2 x i32]  [i32 0, i32 -1]]
@.g.w = global i32 zeroinitializer
@.g.h = global i32 zeroinitializer
@.g.x_0 = global i32 zeroinitializer
@.g.y_0 = global i32 zeroinitializer
@.g.x_1 = global i32 zeroinitializer
@.g.y_1 = global i32 zeroinitializer
define i32 @search(i32 %.23, i32 %.26, i32 %.29){
.21:
  %.145 = alloca i32
  %.54 = alloca i32
  %.51 = alloca i32
  %.49 = alloca i32
  %.40 = alloca i32
  %.38 = alloca i32
  %.28 = alloca i32
  %.25 = alloca i32
  %.22 = alloca i32
  store i32 %.23, i32* %.22
  store i32 %.26, i32* %.25
  store i32 %.29, i32* %.28
  %.33 = load i32, i32* %.28
  %.35 = icmp sgt i32 %.33, 10
  br i1 %.35, label %.31, label %.32
.31:
  ret i32 1073741824 
.32:
  store i32 1073741824, i32* %.38
  store i32 0, i32* %.40
  br label %.42wc12 
.42wc12:
  %.46 = load i32, i32* %.40
  %.47 = icmp slt i32 %.46, 4
  br i1 %.47, label %.43wloop.12.37, label %.44wn37
.43wloop.12.37:
  store i32 0, i32* %.49
  %.52 = load i32, i32* %.22
  store i32 %.52, i32* %.51
  %.55 = load i32, i32* %.25
  store i32 %.55, i32* %.54
  br label %.57wc15 
.44wn37:
  %.180 = load i32, i32* %.38
  %.181 = icmp sgt i32 %.180, 10
  br i1 %.181, label %.178, label %.179
.57wc15:
  %.61 = load i32, i32* %.51
  %.62 = load i32, i32* %.54
  %.63 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.61, i32 %.62
  %.64 = load i32, i32* %.63
  %.65 = icmp ne i32 %.64, 1
  br i1 %.65, label %.58wloop.15.20, label %.59wn20
.58wloop.15.20:
  %.69 = load i32, i32* %.51
  %.70 = load i32, i32* @.g.x_1
  %.71 = icmp eq i32 %.69, %.70
  br i1 %.71, label %.72, label %.68
.59wn20:
  %.97 = load i32, i32* %.51
  %.98 = load i32, i32* @.g.x_1
  %.99 = icmp eq i32 %.97, %.98
  br i1 %.99, label %.100, label %.96
.67:
  br label %.59wn20 
.68:
  %.79 = load i32, i32* %.51
  %.80 = load i32, i32* %.40
  %.81 = getelementptr inbounds [4 x [2 x i32]], [4 x [2 x i32]]* @.g.step, i32 0, i32 %.80, i32 0
  %.82 = load i32, i32* %.81
  %.83 = add i32 %.79, %.82
  store i32 %.83, i32* %.51
  %.85 = load i32, i32* %.54
  %.86 = load i32, i32* %.40
  %.87 = getelementptr inbounds [4 x [2 x i32]], [4 x [2 x i32]]* @.g.step, i32 0, i32 %.86, i32 1
  %.88 = load i32, i32* %.87
  %.89 = add i32 %.85, %.88
  store i32 %.89, i32* %.54
  %.91 = load i32, i32* %.49
  %.92 = add i32 %.91, 1
  store i32 %.92, i32* %.49
  br label %.57wc15 
.72:
  %.74 = load i32, i32* %.54
  %.75 = load i32, i32* @.g.y_1
  %.76 = icmp eq i32 %.74, %.75
  br i1 %.76, label %.67, label %.68
.95:
  ret i32 1 
.96:
  %.109 = load i32, i32* %.49
  %.110 = icmp sle i32 %.109, 1
  br i1 %.110, label %.107, label %.108
.100:
  %.102 = load i32, i32* %.54
  %.103 = load i32, i32* @.g.y_1
  %.104 = icmp eq i32 %.102, %.103
  br i1 %.104, label %.95, label %.96
.107:
  %.112 = load i32, i32* %.40
  %.113 = add i32 %.112, 1
  store i32 %.113, i32* %.40
  br label %.42wc12 
.108:
  %.119 = load i32, i32* %.51
  %.120 = icmp eq i32 %.119, 0
  br i1 %.120, label %.116, label %.118
.116:
  %.137 = load i32, i32* %.40
  %.138 = add i32 %.137, 1
  store i32 %.138, i32* %.40
  br label %.42wc12 
.117:
  %.141 = load i32, i32* %.51
  %.142 = load i32, i32* %.54
  %.143 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.141, i32 %.142
  store i32 0, i32* %.143
  %.146 = load i32, i32* %.51
  %.147 = load i32, i32* %.40
  %.148 = getelementptr inbounds [4 x [2 x i32]], [4 x [2 x i32]]* @.g.step, i32 0, i32 %.147, i32 0
  %.149 = load i32, i32* %.148
  %.150 = sub i32 %.146, %.149
  %.151 = load i32, i32* %.54
  %.152 = load i32, i32* %.40
  %.153 = getelementptr inbounds [4 x [2 x i32]], [4 x [2 x i32]]* @.g.step, i32 0, i32 %.152, i32 1
  %.154 = load i32, i32* %.153
  %.155 = sub i32 %.151, %.154
  %.156 = load i32, i32* %.28
  %.157 = add i32 %.156, 1
  %.158at32 = call i32 @search(i32 %.150, i32 %.155, i32 %.157)
  %.159 = add i32 %.158at32, 1
  store i32 %.159, i32* %.145
  %.163 = load i32, i32* %.145
  %.164 = load i32, i32* %.38
  %.165 = icmp slt i32 %.163, %.164
  br i1 %.165, label %.161, label %.162
.118:
  %.123 = load i32, i32* %.51
  %.124 = load i32, i32* @.g.h
  %.125 = add i32 %.124, 1
  %.126 = icmp eq i32 %.123, %.125
  br i1 %.126, label %.116, label %.122
.122:
  %.129 = load i32, i32* %.54
  %.130 = icmp eq i32 %.129, 0
  br i1 %.130, label %.116, label %.128
.128:
  %.132 = load i32, i32* %.54
  %.133 = load i32, i32* @.g.w
  %.134 = add i32 %.133, 1
  %.135 = icmp eq i32 %.132, %.134
  br i1 %.135, label %.116, label %.117
.161:
  %.167 = load i32, i32* %.145
  store i32 %.167, i32* %.38
  br label %.162 
.162:
  %.170 = load i32, i32* %.51
  %.171 = load i32, i32* %.54
  %.172 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.170, i32 %.171
  store i32 1, i32* %.172
  %.174 = load i32, i32* %.40
  %.175 = add i32 %.174, 1
  store i32 %.175, i32* %.40
  br label %.42wc12 
.178:
  ret i32 1073741824 
.179:
  %.184 = load i32, i32* %.38
  ret i32 %.184 
}
define i32 @main(){
.187:
  %.290 = alloca i32
  %.201 = alloca i32
  %.200 = alloca i32
  %.189at46 = call i32 @getint()
  store i32 %.189at46, i32* @.g.w
  %.191at47 = call i32 @getint()
  store i32 %.191at47, i32* @.g.h
  br label %.193wc48 
.193wc48:
  %.197 = load i32, i32* @.g.w
  %.198 = icmp ne i32 %.197, 0
  br i1 %.198, label %.194wloop.48.87, label %.195wn87
.194wloop.48.87:
  store i32 0, i32* %.200
  br label %.203wc51 
.195wn87:
  ret i32 0 
.203wc51:
  %.207 = load i32, i32* %.200
  %.208 = icmp slt i32 %.207, 30
  br i1 %.208, label %.204wloop.51.58, label %.205wn58
.204wloop.51.58:
  store i32 0, i32* %.201
  br label %.211wc53 
.205wn58:
  store i32 1, i32* %.200
  br label %.231wc60 
.211wc53:
  %.215 = load i32, i32* %.201
  %.216 = icmp slt i32 %.215, 30
  br i1 %.216, label %.212wloop.53.56, label %.213wn56
.212wloop.53.56:
  %.218 = load i32, i32* %.200
  %.219 = load i32, i32* %.201
  %.220 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.218, i32 %.219
  store i32 1, i32* %.220
  %.222 = load i32, i32* %.201
  %.223 = add i32 %.222, 1
  store i32 %.223, i32* %.201
  br label %.211wc53 
.213wn56:
  %.226 = load i32, i32* %.200
  %.227 = add i32 %.226, 1
  store i32 %.227, i32* %.200
  br label %.203wc51 
.231wc60:
  %.235 = load i32, i32* %.200
  %.236 = load i32, i32* @.g.h
  %.237 = icmp sle i32 %.235, %.236
  br i1 %.237, label %.232wloop.60.75, label %.233wn75
.232wloop.60.75:
  store i32 1, i32* %.201
  br label %.240wc62 
.233wn75:
  %.291 = load i32, i32* @.g.x_0
  %.292 = load i32, i32* @.g.y_0
  %.293at76 = call i32 @search(i32 %.291, i32 %.292, i32 1)
  store i32 %.293at76, i32* %.290
  %.297 = load i32, i32* %.290
  %.298 = icmp sle i32 %.297, 10
  br i1 %.298, label %.295, label %.296
.240wc62:
  %.244 = load i32, i32* %.201
  %.245 = load i32, i32* @.g.w
  %.246 = icmp sle i32 %.244, %.245
  br i1 %.246, label %.241wloop.62.73, label %.242wn73
.241wloop.62.73:
  %.248at63 = call i32 @getint()
  %.249 = load i32, i32* %.200
  %.250 = load i32, i32* %.201
  %.251 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.249, i32 %.250
  store i32 %.248at63, i32* %.251
  %.255 = load i32, i32* %.200
  %.256 = load i32, i32* %.201
  %.257 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.255, i32 %.256
  %.258 = load i32, i32* %.257
  %.259 = icmp eq i32 %.258, 2
  br i1 %.259, label %.253, label %.254
.242wn73:
  %.286 = load i32, i32* %.200
  %.287 = add i32 %.286, 1
  store i32 %.287, i32* %.200
  br label %.231wc60 
.253:
  %.261 = load i32, i32* %.200
  store i32 %.261, i32* @.g.x_0
  %.263 = load i32, i32* %.201
  store i32 %.263, i32* @.g.y_0
  br label %.265 
.254:
  %.269 = load i32, i32* %.200
  %.270 = load i32, i32* %.201
  %.271 = getelementptr inbounds [30 x [30 x i32]], [30 x [30 x i32]]* @.g.a, i32 0, i32 %.269, i32 %.270
  %.272 = load i32, i32* %.271
  %.274 = icmp eq i32 %.272, 3
  br i1 %.274, label %.267, label %.268
.265:
  %.282 = load i32, i32* %.201
  %.283 = add i32 %.282, 1
  store i32 %.283, i32* %.201
  br label %.240wc62 
.267:
  %.276 = load i32, i32* %.200
  store i32 %.276, i32* @.g.x_1
  %.278 = load i32, i32* %.201
  store i32 %.278, i32* @.g.y_1
  br label %.268 
.268:
  br label %.265 
.295:
  %.300 = load i32, i32* %.290
  call void @putint(i32 %.300)
  call void @putch(i32 10)
  br label %.305 
.296:
  call void @putint(i32 -