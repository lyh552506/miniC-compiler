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
@.g.cnt = global [400020 x i32] zeroinitializer
@.g.x = global [100005 x i32] zeroinitializer
@.g.a = global [100005 x i32] zeroinitializer
@.g.b = global [100005 x i32] zeroinitializer
@.g.c = global [100005 x i32] zeroinitializer
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
define void @sortA(i32* %.72){
.70:
  %.108 = alloca i32
  %.76 = alloca i32
  %.74 = alloca i32
  %.71 = alloca i32*
  store i32* %.72, i32** %.71
  store i32 0, i32* %.74
  br label %.77wc18 
.77wc18:
  %.81 = load i32, i32* %.74
  %.82 = load i32, i32* @.g.n
  %.83 = icmp slt i32 %.81, %.82
  br i1 %.83, label %.78wloop.18.29, label %.79wn29
.78wloop.18.29:
  %.85 = load i32, i32* %.74
  %.86 = add i32 %.85, 1
  store i32 %.86, i32* %.76
  br label %.88wc20 
.79wn29:
  ret void
.88wc20:
  %.92 = load i32, i32* %.76
  %.93 = load i32, i32* @.g.n
  %.94 = icmp slt i32 %.92, %.93
  br i1 %.94, label %.89wloop.20.27, label %.90wn27
.89wloop.20.27:
  %.98 = load i32, i32* %.74
  %.99 = load i32*, i32** %.71
  %.100 = getelementptr inbounds i32, i32* %.99, i32 %.98
  %.101 = load i32, i32* %.100
  %.102 = load i32, i32* %.76
  %.103 = load i32*, i32** %.71
  %.104 = getelementptr inbounds i32, i32* %.103, i32 %.102
  %.105 = load i32, i32* %.104
  %.106 = icmp sgt i32 %.101, %.105
  br i1 %.106, label %.96, label %.97
.90wn27:
  %.132 = load i32, i32* %.74
  %.133 = add i32 %.132, 1
  store i32 %.133, i32* %.74
  br label %.77wc18 
.96:
  %.109 = load i32, i32* %.74
  %.110 = load i32*, i32** %.71
  %.111 = getelementptr inbounds i32, i32* %.110, i32 %.109
  %.112 = load i32, i32* %.111
  store i32 %.112, i32* %.108
  %.114 = load i32, i32* %.76
  %.115 = load i32*, i32** %.71
  %.116 = getelementptr inbounds i32, i32* %.115, i32 %.114
  %.117 = load i32, i32* %.116
  %.118 = load i32, i32* %.74
  %.119 = load i32*, i32** %.71
  %.120 = getelementptr inbounds i32, i32* %.119, i32 %.118
  store i32 %.117, i32* %.120
  %.122 = load i32, i32* %.108
  %.123 = load i32, i32* %.76
  %.124 = load i32*, i32** %.71
  %.125 = getelementptr inbounds i32, i32* %.124, i32 %.123
  store i32 %.122, i32* %.125
  br label %.97 
.97:
  %.128 = load i32, i32* %.76
  %.129 = add i32 %.128, 1
  store i32 %.129, i32* %.76
  br label %.88wc20 
}
define void @sortB(i32* %.143){
.141:
  %.202 = alloca i32
  %.192 = alloca i32
  %.147 = alloca i32
  %.145 = alloca i32
  %.142 = alloca i32*
  store i32* %.143, i32** %.142
  store i32 0, i32* %.145
  store i32 -100, i32* %.147
  br label %.151wc34 
.151wc34:
  %.155 = load i32, i32* %.145
  %.156 = load i32, i32* @.g.n
  %.157 = icmp slt i32 %.155, %.156
  br i1 %.157, label %.152wloop.34.38, label %.153wn38
.152wloop.34.38:
  %.159 = load i32, i32* %.145
  %.160 = load i32*, i32** %.142
  %.161 = getelementptr inbounds i32, i32* %.160, i32 %.159
  %.162 = load i32, i32* %.161
  %.163 = getelementptr inbounds [400020 x i32], [400020 x i32]* @.g.cnt, i32 0, i32 %.162
  %.164 = load i32, i32* %.163
  %.165 = add i32 %.164, 1
  %.166 = load i32, i32* %.145
  %.167 = load i32*, i32** %.142
  %.168 = getelementptr inbounds i32, i32* %.167, i32 %.166
  %.169 = load i32, i32* %.168
  %.170 = getelementptr inbounds [400020 x i32], [400020 x i32]* @.g.cnt, i32 0, i32 %.169
  store i32 %.165, i32* %.170
  %.174 = load i32, i32* %.145
  %.175 = load i32*, i32** %.142
  %.176 = getelementptr inbounds i32, i32* %.175, i32 %.174
  %.177 = load i32, i32* %.176
  %.178 = load i32, i32* %.147
  %.179 = icmp sgt i32 %.177, %.178
  br i1 %.179, label %.172, label %.173
.153wn38:
  store i32 0, i32* %.145
  store i32 0, i32* %.192
  br label %.194wc40 
.172:
  %.181 = load i32, i32* %.145
  %.182 = load i32*, i32** %.142
  %.183 = getelementptr inbounds i32, i32* %.182, i32 %.181
  %.184 = load i32, i32* %.183
  store i32 %.184, i32* %.147
  br label %.173 
.173:
  %.187 = load i32, i32* %.145
  %.188 = add i32 %.187, 1
  store i32 %.188, i32* %.145
  br label %.151wc34 
.194wc40:
  %.198 = load i32, i32* %.145
  %.199 = load i32, i32* %.147
  %.200 = icmp sle i32 %.198, %.199
  br i1 %.200, label %.195wloop.40.48, label %.196wn48
.195wloop.40.48:
  %.203 = load i32, i32* %.145
  %.204 = getelementptr inbounds [400020 x i32], [400020 x i32]* @.g.cnt, i32 0, i32 %.203
  %.205 = load i32, i32* %.204
  store i32 %.205, i32* %.202
  br label %.207wc42 
.196wn48:
  ret void
.207wc42:
  %.211 = load i32, i32* %.202
  %.212 = icmp ne i32 %.211, 0
  br i1 %.212, label %.208wloop.42.46, label %.209wn46
.208wloop.42.46:
  %.214 = load i32, i32* %.145
  %.215 = load i32, i32* %.192
  %.216 = load i32*, i32** %.142
  %.217 = getelementptr inbounds i32, i32* %.216, i32 %.215
  store i32 %.214, i32* %.217
  %.219 = load i32, i32* %.192
  %.220 = add i32 %.219, 1
  store i32 %.220, i32* %.192
  %.222 = load i32, i32* %.202
  %.223 = sub i32 %.222, 1
  store i32 %.223, i32* %.202
  br label %.207wc42 
.209wn46:
  %.226 = load i32, i32* %.145
  %.227 = add i32 %.226, 1
  store i32 %.227, i32* %.145
  br label %.194wc40 
}
define void @sortC(i32* %.234){
.232:
  %.280 = alloca i32
  %.249 = alloca i32
  %.246 = alloca i32
  %.236 = alloca i32
  %.233 = alloca i32*
  store i32* %.234, i32** %.233
  store i32 0, i32* %.236
  br label %.238wc52 
.238wc52:
  %.242 = load i32, i32* %.236
  %.243 = load i32, i32* @.g.n
  %.244 = icmp slt i32 %.242, %.243
  br i1 %.244, label %.239wloop.52.63, label %.240wn63
.239wloop.52.63:
  %.247 = load i32, i32* %.236
  store i32 %.247, i32* %.246
  %.250 = load i32, i32* %.236
  %.251 = add i32 %.250, 1
  store i32 %.251, i32* %.249
  br label %.253wc54 
.240wn63:
  ret void
.253wc54:
  %.257 = load i32, i32* %.249
  %.258 = load i32, i32* @.g.n
  %.259 = icmp slt i32 %.257, %.258
  br i1 %.259, label %.254wloop.54.58, label %.255wn58
.254wloop.54.58:
  %.263 = load i32, i32* %.249
  %.264 = load i32*, i32** %.233
  %.265 = getelementptr inbounds i32, i32* %.264, i32 %.263
  %.266 = load i32, i32* %.265
  %.267 = load i32, i32* %.246
  %.268 = load i32*, i32** %.233
  %.269 = getelementptr inbounds i32, i32* %.268, i32 %.267
  %.270 = load i32, i32* %.269
  %.271 = icmp slt i32 %.266, %.270
  br i1 %.271, label %.261, label %.262
.255wn58:
  %.281 = load i32, i32* %.236
  %.282 = load i32*, i32** %.233
  %.283 = getelementptr inbounds i32, i32* %.282, i32 %.281
  %.284 = load i32, i32* %.283
  store i32 %.284, i32* %.280
  %.286 = load i32, i32* %.246
  %.287 = load i32*, i32** %.233
  %.288 = getelementptr inbounds i32, i32* %.287, i32 %.286
  %.289 = load i32, i32* %.288
  %.290 = load i32, i32* %.236
  %.291 = load i32*, i32** %.233
  %.292 = getelementptr inbounds i32, i32* %.291, i32 %.290
  store i32 %.289, i32* %.292
  %.294 = load i32, i32* %.280
  %.295 = load i32, i32* %.246
  %.296 = load i32*, i32** %.233
  %.297 = getelementptr inbounds i32, i32* %.296, i32 %.295
  store i32 %.294, i32* %.297
  %.299 = load i32, i32* %.236
  %.300 = add i32 %.299, 1
  store i32 %.300, i32* %.236
  br label %.238wc52 
.261:
  %.273 = load i32, i32* %.249
  store i32 %.273, i32* %.246
  br label %.262 
.262:
  %.276 = load i32, i32* %.249
  %.277 = add i32 %.276, 1
  store i32 %.277, i32* %.249
  br label %.253wc54 
}
define i32 @main(){
.309:
  %.312 = alloca i32
  %.310at68 = call i32 @quick_read()
  store i32 %.310at68, i32* @.g.n
  store i32 0, i32* %.312
  br label %.314wc70 
.314wc70:
  %.318 = load i32, i32* %.312
  %.319 = load i32, i32* @.g.n
  %.320 = icmp ne i32 %.318, %.319
  br i1 %.320, label %.315wloop.70.75, label %.316wn75
.315wloop.70.75:
  %.322at71 = call i32 @quick_read()
  %.323 = load i32, i32* %.312
  %.324 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 %.323
  store i32 %.322at71, i32* %.324
  %.326 = load i32, i32* %.312
  %.327 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 %.326
  %.328 = load i32, i32* %.327
  %.329 = load i32, i32* %.312
  %.330 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.329
  store i32 %.328, i32* %.330
  %.332 = load i32, i32* %.312
  %.333 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.332
  %.334 = load i32, i32* %.333
  %.335 = load i32, i32* %.312
  %.336 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 %.335
  store i32 %.334, i32* %.336
  %.338 = load i32, i32* %.312
  %.339 = add i32 %.338, 1
  store i32 %.339, i32* %.312
  br label %.314wc70 
.316wn75:
  %.342 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 0
  call void @sortA(i32* %.342)
  %.344 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 0
  call void @sortB(i32* %.344)
  %.346 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 0
  call void @sortC(i32* %.346)
  store i32 0, i32* %.312
  br label %.349wc80 
.349wc80:
  %.353 = load i32, i32* @.g.n
  %.354 = load i32, i32* %.312
  %.355 = sub i32 %.353, %.354
  %.356 = icmp ne i32 %.355, 0
  br i1 %.356, label %.350wloop.80.84, label %.351wn84
.350wloop.80.84:
  %.358 = load i32, i32* %.312
  %.359 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.358
  %.360 = load i32, i32* %.359
  %.361 = load i32, i32* %.312
  %.362 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 %.361
  %.363 = load i32, i32* %.362
  %.364 = sub i32 %.360, %.363
  %.365 = load i32, i32* %.312
  %.366 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.365
  store i32 %.364, i32* %.366
  %.368 = load i32, i32* %.312
  %.369 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 %.368
  %.370 = load i32, i32* %.369
  %.371 = load i32, i32* %.312
  %.372 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.371
  %.373 = load i32, i32* %.372
  %.374 = sub i32 %.370, %.373
  %.375 = load i32, i32* %.312
  %.376 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 %.375
  %.377 = load i32, i32* %.376
  %.378 = sub i32 %.374, %.377
  %.379 = load i32, i32* %.312
  %.380 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 %.379
  store i32 %.378, i32* %.380
  %.382 = load i32, i32* %.312
  %.383 = add i32 %.382, 1
  store i32 %.383, i32* %.312
  br label %.349wc80 
.351wn84:
  store i32 0, i32* %.312
  br label %.387wc86 
.387wc86:
  %.391 = load i32, i32* %.312
  %.392 = load i32, i32* @.g.n
  %.393 = sub i32 %.391, %.392
  %.394 = icmp ne i32 %.393, 0
  br i1 %.394, label %.388wloop.86.90, label %.389wn90
.388wloop.86.90:
  %.398 = load i32, i32* %.312
  %.399 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.398
  %.400 = load i32, i32* %.399
  %.401 = icmp ne i32 %.400, 0
  br i1 %.401, label %.396, label %.397
.389wn90:
  ret i32 -123 
.396:
  ret i32 1 
.397:
  %.406 = load i32, i32* %.312
  %.407 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 %.406
  %.408 = load i32, i32* %.407
  %.409 = icmp ne i32 %.408, 0
  br i1 %.409, label %.404, label %.405
.404:
  ret i32 2 
.405:
  %.413 = load i32, i32* %.312
  %.414 = add i32 %.413, 1
  store i32 %.414, i32* %.312
  br label %.387wc86 
}
@.g.n = global i32 zeroinitializer
@.g.cnt = global [400020 x i32] zeroinitializer
@.g.x = global [100005 x i32] zeroinitializer
@.g.a = global [100005 x i32] zeroinitializer
@.g.b = global [100005 x i32] zeroinitializer
@.g.c = global [100005 x i32] zeroinitializer
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
define void @sortA(i32* %.72){
.70:
  %.108 = alloca i32
  %.76 = alloca i32
  %.74 = alloca i32
  %.71 = alloca i32*
  store i32* %.72, i32** %.71
  store i32 0, i32* %.74
  br label %.77wc18 
.77wc18:
  %.81 = load i32, i32* %.74
  %.82 = load i32, i32* @.g.n
  %.83 = icmp slt i32 %.81, %.82
  br i1 %.83, label %.78wloop.18.29, label %.79wn29
.78wloop.18.29:
  %.85 = load i32, i32* %.74
  %.86 = add i32 %.85, 1
  store i32 %.86, i32* %.76
  br label %.88wc20 
.79wn29:
  ret void
.88wc20:
  %.92 = load i32, i32* %.76
  %.93 = load i32, i32* @.g.n
  %.94 = icmp slt i32 %.92, %.93
  br i1 %.94, label %.89wloop.20.27, label %.90wn27
.89wloop.20.27:
  %.98 = load i32, i32* %.74
  %.99 = load i32*, i32** %.71
  %.100 = getelementptr inbounds i32, i32* %.99, i32 %.98
  %.101 = load i32, i32* %.100
  %.102 = load i32, i32* %.76
  %.103 = load i32*, i32** %.71
  %.104 = getelementptr inbounds i32, i32* %.103, i32 %.102
  %.105 = load i32, i32* %.104
  %.106 = icmp sgt i32 %.101, %.105
  br i1 %.106, label %.96, label %.97
.90wn27:
  %.132 = load i32, i32* %.74
  %.133 = add i32 %.132, 1
  store i32 %.133, i32* %.74
  br label %.77wc18 
.96:
  %.109 = load i32, i32* %.74
  %.110 = load i32*, i32** %.71
  %.111 = getelementptr inbounds i32, i32* %.110, i32 %.109
  %.112 = load i32, i32* %.111
  store i32 %.112, i32* %.108
  %.114 = load i32, i32* %.76
  %.115 = load i32*, i32** %.71
  %.116 = getelementptr inbounds i32, i32* %.115, i32 %.114
  %.117 = load i32, i32* %.116
  %.118 = load i32, i32* %.74
  %.119 = load i32*, i32** %.71
  %.120 = getelementptr inbounds i32, i32* %.119, i32 %.118
  store i32 %.117, i32* %.120
  %.122 = load i32, i32* %.108
  %.123 = load i32, i32* %.76
  %.124 = load i32*, i32** %.71
  %.125 = getelementptr inbounds i32, i32* %.124, i32 %.123
  store i32 %.122, i32* %.125
  br label %.97 
.97:
  %.128 = load i32, i32* %.76
  %.129 = add i32 %.128, 1
  store i32 %.129, i32* %.76
  br label %.88wc20 
}
define void @sortB(i32* %.143){
.141:
  %.202 = alloca i32
  %.192 = alloca i32
  %.147 = alloca i32
  %.145 = alloca i32
  %.142 = alloca i32*
  store i32* %.143, i32** %.142
  store i32 0, i32* %.145
  store i32 -100, i32* %.147
  br label %.151wc34 
.151wc34:
  %.155 = load i32, i32* %.145
  %.156 = load i32, i32* @.g.n
  %.157 = icmp slt i32 %.155, %.156
  br i1 %.157, label %.152wloop.34.38, label %.153wn38
.152wloop.34.38:
  %.159 = load i32, i32* %.145
  %.160 = load i32*, i32** %.142
  %.161 = getelementptr inbounds i32, i32* %.160, i32 %.159
  %.162 = load i32, i32* %.161
  %.163 = getelementptr inbounds [400020 x i32], [400020 x i32]* @.g.cnt, i32 0, i32 %.162
  %.164 = load i32, i32* %.163
  %.165 = add i32 %.164, 1
  %.166 = load i32, i32* %.145
  %.167 = load i32*, i32** %.142
  %.168 = getelementptr inbounds i32, i32* %.167, i32 %.166
  %.169 = load i32, i32* %.168
  %.170 = getelementptr inbounds [400020 x i32], [400020 x i32]* @.g.cnt, i32 0, i32 %.169
  store i32 %.165, i32* %.170
  %.174 = load i32, i32* %.145
  %.175 = load i32*, i32** %.142
  %.176 = getelementptr inbounds i32, i32* %.175, i32 %.174
  %.177 = load i32, i32* %.176
  %.178 = load i32, i32* %.147
  %.179 = icmp sgt i32 %.177, %.178
  br i1 %.179, label %.172, label %.173
.153wn38:
  store i32 0, i32* %.145
  store i32 0, i32* %.192
  br label %.194wc40 
.172:
  %.181 = load i32, i32* %.145
  %.182 = load i32*, i32** %.142
  %.183 = getelementptr inbounds i32, i32* %.182, i32 %.181
  %.184 = load i32, i32* %.183
  store i32 %.184, i32* %.147
  br label %.173 
.173:
  %.187 = load i32, i32* %.145
  %.188 = add i32 %.187, 1
  store i32 %.188, i32* %.145
  br label %.151wc34 
.194wc40:
  %.198 = load i32, i32* %.145
  %.199 = load i32, i32* %.147
  %.200 = icmp sle i32 %.198, %.199
  br i1 %.200, label %.195wloop.40.48, label %.196wn48
.195wloop.40.48:
  %.203 = load i32, i32* %.145
  %.204 = getelementptr inbounds [400020 x i32], [400020 x i32]* @.g.cnt, i32 0, i32 %.203
  %.205 = load i32, i32* %.204
  store i32 %.205, i32* %.202
  br label %.207wc42 
.196wn48:
  ret void
.207wc42:
  %.211 = load i32, i32* %.202
  %.212 = icmp ne i32 %.211, 0
  br i1 %.212, label %.208wloop.42.46, label %.209wn46
.208wloop.42.46:
  %.214 = load i32, i32* %.145
  %.215 = load i32, i32* %.192
  %.216 = load i32*, i32** %.142
  %.217 = getelementptr inbounds i32, i32* %.216, i32 %.215
  store i32 %.214, i32* %.217
  %.219 = load i32, i32* %.192
  %.220 = add i32 %.219, 1
  store i32 %.220, i32* %.192
  %.222 = load i32, i32* %.202
  %.223 = sub i32 %.222, 1
  store i32 %.223, i32* %.202
  br label %.207wc42 
.209wn46:
  %.226 = load i32, i32* %.145
  %.227 = add i32 %.226, 1
  store i32 %.227, i32* %.145
  br label %.194wc40 
}
define void @sortC(i32* %.234){
.232:
  %.280 = alloca i32
  %.249 = alloca i32
  %.246 = alloca i32
  %.236 = alloca i32
  %.233 = alloca i32*
  store i32* %.234, i32** %.233
  store i32 0, i32* %.236
  br label %.238wc52 
.238wc52:
  %.242 = load i32, i32* %.236
  %.243 = load i32, i32* @.g.n
  %.244 = icmp slt i32 %.242, %.243
  br i1 %.244, label %.239wloop.52.63, label %.240wn63
.239wloop.52.63:
  %.247 = load i32, i32* %.236
  store i32 %.247, i32* %.246
  %.250 = load i32, i32* %.236
  %.251 = add i32 %.250, 1
  store i32 %.251, i32* %.249
  br label %.253wc54 
.240wn63:
  ret void
.253wc54:
  %.257 = load i32, i32* %.249
  %.258 = load i32, i32* @.g.n
  %.259 = icmp slt i32 %.257, %.258
  br i1 %.259, label %.254wloop.54.58, label %.255wn58
.254wloop.54.58:
  %.263 = load i32, i32* %.249
  %.264 = load i32*, i32** %.233
  %.265 = getelementptr inbounds i32, i32* %.264, i32 %.263
  %.266 = load i32, i32* %.265
  %.267 = load i32, i32* %.246
  %.268 = load i32*, i32** %.233
  %.269 = getelementptr inbounds i32, i32* %.268, i32 %.267
  %.270 = load i32, i32* %.269
  %.271 = icmp slt i32 %.266, %.270
  br i1 %.271, label %.261, label %.262
.255wn58:
  %.281 = load i32, i32* %.236
  %.282 = load i32*, i32** %.233
  %.283 = getelementptr inbounds i32, i32* %.282, i32 %.281
  %.284 = load i32, i32* %.283
  store i32 %.284, i32* %.280
  %.286 = load i32, i32* %.246
  %.287 = load i32*, i32** %.233
  %.288 = getelementptr inbounds i32, i32* %.287, i32 %.286
  %.289 = load i32, i32* %.288
  %.290 = load i32, i32* %.236
  %.291 = load i32*, i32** %.233
  %.292 = getelementptr inbounds i32, i32* %.291, i32 %.290
  store i32 %.289, i32* %.292
  %.294 = load i32, i32* %.280
  %.295 = load i32, i32* %.246
  %.296 = load i32*, i32** %.233
  %.297 = getelementptr inbounds i32, i32* %.296, i32 %.295
  store i32 %.294, i32* %.297
  %.299 = load i32, i32* %.236
  %.300 = add i32 %.299, 1
  store i32 %.300, i32* %.236
  br label %.238wc52 
.261:
  %.273 = load i32, i32* %.249
  store i32 %.273, i32* %.246
  br label %.262 
.262:
  %.276 = load i32, i32* %.249
  %.277 = add i32 %.276, 1
  store i32 %.277, i32* %.249
  br label %.253wc54 
}
define i32 @main(){
.309:
  %.312 = alloca i32
  %.310at68 = call i32 @quick_read()
  store i32 %.310at68, i32* @.g.n
  store i32 0, i32* %.312
  br label %.314wc70 
.314wc70:
  %.318 = load i32, i32* %.312
  %.319 = load i32, i32* @.g.n
  %.320 = icmp ne i32 %.318, %.319
  br i1 %.320, label %.315wloop.70.75, label %.316wn75
.315wloop.70.75:
  %.322at71 = call i32 @quick_read()
  %.323 = load i32, i32* %.312
  %.324 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 %.323
  store i32 %.322at71, i32* %.324
  %.326 = load i32, i32* %.312
  %.327 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 %.326
  %.328 = load i32, i32* %.327
  %.329 = load i32, i32* %.312
  %.330 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.329
  store i32 %.328, i32* %.330
  %.332 = load i32, i32* %.312
  %.333 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.332
  %.334 = load i32, i32* %.333
  %.335 = load i32, i32* %.312
  %.336 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 %.335
  store i32 %.334, i32* %.336
  %.338 = load i32, i32* %.312
  %.339 = add i32 %.338, 1
  store i32 %.339, i32* %.312
  br label %.314wc70 
.316wn75:
  %.342 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 0
  call void @sortA(i32* %.342)
  %.344 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 0
  call void @sortB(i32* %.344)
  %.346 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 0
  call void @sortC(i32* %.346)
  store i32 0, i32* %.312
  br label %.349wc80 
.349wc80:
  %.353 = load i32, i32* @.g.n
  %.354 = load i32, i32* %.312
  %.355 = sub i32 %.353, %.354
  %.356 = icmp ne i32 %.355, 0
  br i1 %.356, label %.350wloop.80.84, label %.351wn84
.350wloop.80.84:
  %.358 = load i32, i32* %.312
  %.359 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.358
  %.360 = load i32, i32* %.359
  %.361 = load i32, i32* %.312
  %.362 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 %.361
  %.363 = load i32, i32* %.362
  %.364 = sub i32 %.360, %.363
  %.365 = load i32, i32* %.312
  %.366 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.365
  store i32 %.364, i32* %.366
  %.368 = load i32, i32* %.312
  %.369 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 %.368
  %.370 = load i32, i32* %.369
  %.371 = load i32, i32* %.312
  %.372 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.371
  %.373 = load i32, i32* %.372
  %.374 = sub i32 %.370, %.373
  %.375 = load i32, i32* %.312
  %.376 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.a, i32 0, i32 %.375
  %.377 = load i32, i32* %.376
  %.378 = sub i32 %.374, %.377
  %.379 = load i32, i32* %.312
  %.380 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 %.379
  store i32 %.378, i32* %.380
  %.382 = load i32, i32* %.312
  %.383 = add i32 %.382, 1
  store i32 %.383, i32* %.312
  br label %.349wc80 
.351wn84:
  store i32 0, i32* %.312
  br label %.387wc86 
.387wc86:
  %.391 = load i32, i32* %.312
  %.392 = load i32, i32* @.g.n
  %.393 = sub i32 %.391, %.392
  %.394 = icmp ne i32 %.393, 0
  br i1 %.394, label %.388wloop.86.90, label %.389wn90
.388wloop.86.90:
  %.398 = load i32, i32* %.312
  %.399 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.b, i32 0, i32 %.398
  %.400 = load i32, i32* %.399
  %.401 = icmp ne i32 %.400, 0
  br i1 %.401, label %.396, label %.397
.389wn90:
  ret i32 -123 
.396:
  ret i32 1 
.397:
  %.406 = load i32, i32* %.312
  %.407 = getelementptr inbounds [100005 x i32], [100005 x i32]* @.g.c, i32 0, i32 %.406
  %.408 = load i32, i32* %.407
  %.409 = icmp ne i32 %.408, 0
  br i1 %.409, label %.404, label %.405
.404:
  ret i32 2 
.405:
  %.413 = load i32, i32* %.312
  %.414 = add i32 %.413, 1
  store i32 %.414, i32* %.312
  br