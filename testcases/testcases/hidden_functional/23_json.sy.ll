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
@.g.pos = global i32 0
@.g.buffer = global [50000000 x i32] zeroinitializer
@__constant..787 = constant [4 x i32]  [i32 116, i32 114, i32 117, i32 101]
@__constant..869 = constant [5 x i32]  [i32 102, i32 97, i32 108, i32 115, i32 101]
@__constant..961 = constant [4 x i32]  [i32 110, i32 117, i32 108, i32 108]
define i32 @is_number(i32 %.5){
.3:
  %.4 = alloca i32
  store i32 %.5, i32* %.4
  %.9 = load i32, i32* %.4
  %.11 = icmp sge i32 %.9, 48
  br i1 %.11, label %.7, label %.8
.7:
  %.15 = load i32, i32* %.4
  %.17 = icmp sle i32 %.15, 57
  br i1 %.17, label %.13, label %.14
.8:
  ret i32 0 
.13:
  ret i32 1 
.14:
  ret i32 0 
}
define void @skip_space(i32* %.26, i32 %.29){
.24:
  %.28 = alloca i32
  %.25 = alloca i32*
  store i32* %.26, i32** %.25
  store i32 %.29, i32* %.28
  br label %.31wc29 
.31wc29:
  br label %.32wloop.29.44 
.32wloop.29.44:
  %.40 = load i32, i32* @.g.pos
  %.41 = load i32, i32* %.28
  %.42 = icmp sge i32 %.40, %.41
  br i1 %.42, label %.38, label %.39
.33wn44:
  ret void
.38:
  br label %.33wn44 
.39:
  %.47 = load i32, i32* @.g.pos
  %.48 = load i32*, i32** %.25
  %.49 = getelementptr inbounds i32, i32* %.48, i32 %.47
  %.50 = load i32, i32* %.49
  %.52 = icmp eq i32 %.50, 32
  br i1 %.52, label %.45, label %.46
.45:
  %.54 = load i32, i32* @.g.pos
  %.55 = add i32 %.54, 1
  store i32 %.55, i32* @.g.pos
  br label %.57 
.46:
  %.61 = load i32, i32* @.g.pos
  %.62 = load i32*, i32** %.25
  %.63 = getelementptr inbounds i32, i32* %.62, i32 %.61
  %.64 = load i32, i32* %.63
  %.66 = icmp eq i32 %.64, 9
  br i1 %.66, label %.59, label %.60
.57:
  br label %.31wc29 
.59:
  %.68 = load i32, i32* @.g.pos
  %.69 = add i32 %.68, 1
  store i32 %.69, i32* @.g.pos
  br label %.71 
.60:
  %.75 = load i32, i32* @.g.pos
  %.76 = load i32*, i32** %.25
  %.77 = getelementptr inbounds i32, i32* %.76, i32 %.75
  %.78 = load i32, i32* %.77
  %.80 = icmp eq i32 %.78, 10
  br i1 %.80, label %.73, label %.74
.71:
  br label %.57 
.73:
  %.82 = load i32, i32* @.g.pos
  %.83 = add i32 %.82, 1
  store i32 %.83, i32* @.g.pos
  br label %.85 
.74:
  %.89 = load i32, i32* @.g.pos
  %.90 = load i32*, i32** %.25
  %.91 = getelementptr inbounds i32, i32* %.90, i32 %.89
  %.92 = load i32, i32* %.91
  %.94 = icmp eq i32 %.92, 13
  br i1 %.94, label %.87, label %.88
.85:
  br label %.71 
.87:
  %.96 = load i32, i32* @.g.pos
  %.97 = add i32 %.96, 1
  store i32 %.97, i32* @.g.pos
  br label %.99 
.88:
  br label %.33wn44 
.99:
  br label %.85 
}
define i32 @detect_item(i32 %.110, i32* %.113, i32 %.116){
.108:
  %.959 = alloca [4 x i32]
  %.864 = alloca [5 x i32]
  %.783 = alloca [4 x i32]
  %.115 = alloca i32
  %.112 = alloca i32*
  %.109 = alloca i32
  store i32 %.110, i32* %.109
  store i32* %.113, i32** %.112
  store i32 %.116, i32* %.115
  %.120 = load i32, i32* @.g.pos
  %.121 = load i32, i32* %.115
  %.122 = icmp sge i32 %.120, %.121
  br i1 %.122, label %.118, label %.119
.118:
  ret i32 0 
.119:
  %.125 = load i32*, i32** %.112
  %.126 = load i32, i32* %.115
  call void @skip_space(i32* %.125, i32 %.126)
  %.130 = load i32, i32* %.109
  %.131 = icmp eq i32 %.130, 0
  br i1 %.131, label %.128, label %.129
.128:
  %.135 = load i32, i32* @.g.pos
  %.136 = load i32*, i32** %.112
  %.137 = getelementptr inbounds i32, i32* %.136, i32 %.135
  %.138 = load i32, i32* %.137
  %.140 = icmp eq i32 %.138, 123
  br i1 %.140, label %.133, label %.134
.129:
  %.259 = load i32, i32* %.109
  %.260 = icmp eq i32 %.259, 1
  br i1 %.260, label %.257, label %.258
.133:
  %.143 = load i32*, i32** %.112
  %.144 = load i32, i32* %.115
  %.145at55 = call i32 @detect_item(i32 4, i32* %.143, i32 %.144)
  ret i32 %.145at55 
.134:
  %.149 = load i32, i32* @.g.pos
  %.150 = load i32*, i32** %.112
  %.151 = getelementptr inbounds i32, i32* %.150, i32 %.149
  %.152 = load i32, i32* %.151
  %.154 = icmp eq i32 %.152, 91
  br i1 %.154, label %.147, label %.148
.147:
  %.157 = load i32*, i32** %.112
  %.158 = load i32, i32* %.115
  %.159at57 = call i32 @detect_item(i32 3, i32* %.157, i32 %.158)
  ret i32 %.159at57 
.148:
  %.163 = load i32, i32* @.g.pos
  %.164 = load i32*, i32** %.112
  %.165 = getelementptr inbounds i32, i32* %.164, i32 %.163
  %.166 = load i32, i32* %.165
  %.168 = icmp eq i32 %.166, 34
  br i1 %.168, label %.161, label %.162
.161:
  %.171 = load i32*, i32** %.112
  %.172 = load i32, i32* %.115
  %.173at59 = call i32 @detect_item(i32 2, i32* %.171, i32 %.172)
  ret i32 %.173at59 
.162:
  %.177 = load i32, i32* @.g.pos
  %.178 = load i32*, i32** %.112
  %.179 = getelementptr inbounds i32, i32* %.178, i32 %.177
  %.180 = load i32, i32* %.179
  %.181at60 = call i32 @is_number(i32 %.180)
  %.182 = icmp eq i32 %.181at60, 1
  br i1 %.182, label %.175, label %.176
.175:
  %.184 = load i32*, i32** %.112
  %.185 = load i32, i32* %.115
  %.186at62 = call i32 @detect_item(i32 1, i32* %.184, i32 %.185)
  ret i32 %.186at62 
.176:
  %.190 = load i32, i32* @.g.pos
  %.191 = load i32*, i32** %.112
  %.192 = getelementptr inbounds i32, i32* %.191, i32 %.190
  %.193 = load i32, i32* %.192
  %.195 = icmp eq i32 %.193, 43
  br i1 %.195, label %.188, label %.189
.188:
  %.197 = load i32*, i32** %.112
  %.198 = load i32, i32* %.115
  %.199at65 = call i32 @detect_item(i32 1, i32* %.197, i32 %.198)
  ret i32 %.199at65 
.189:
  %.203 = load i32, i32* @.g.pos
  %.204 = load i32*, i32** %.112
  %.205 = getelementptr inbounds i32, i32* %.204, i32 %.203
  %.206 = load i32, i32* %.205
  %.208 = icmp eq i32 %.206, 45
  br i1 %.208, label %.201, label %.202
.201:
  %.210 = load i32*, i32** %.112
  %.211 = load i32, i32* %.115
  %.212at68 = call i32 @detect_item(i32 1, i32* %.210, i32 %.211)
  ret i32 %.212at68 
.202:
  %.216 = load i32, i32* @.g.pos
  %.217 = load i32*, i32** %.112
  %.218 = getelementptr inbounds i32, i32* %.217, i32 %.216
  %.219 = load i32, i32* %.218
  %.221 = icmp eq i32 %.219, 116
  br i1 %.221, label %.214, label %.215
.214:
  %.224 = load i32*, i32** %.112
  %.225 = load i32, i32* %.115
  %.226at71 = call i32 @detect_item(i32 5, i32* %.224, i32 %.225)
  ret i32 %.226at71 
.215:
  %.230 = load i32, i32* @.g.pos
  %.231 = load i32*, i32** %.112
  %.232 = getelementptr inbounds i32, i32* %.231, i32 %.230
  %.233 = load i32, i32* %.232
  %.235 = icmp eq i32 %.233, 102
  br i1 %.235, label %.228, label %.229
.228:
  %.238 = load i32*, i32** %.112
  %.239 = load i32, i32* %.115
  %.240at74 = call i32 @detect_item(i32 6, i32* %.238, i32 %.239)
  ret i32 %.240at74 
.229:
  %.244 = load i32, i32* @.g.pos
  %.245 = load i32*, i32** %.112
  %.246 = getelementptr inbounds i32, i32* %.245, i32 %.244
  %.247 = load i32, i32* %.246
  %.249 = icmp eq i32 %.247, 110
  br i1 %.249, label %.242, label %.243
.242:
  %.252 = load i32*, i32** %.112
  %.253 = load i32, i32* %.115
  %.254at77 = call i32 @detect_item(i32 7, i32* %.252, i32 %.253)
  ret i32 %.254at77 
.243:
  ret i32 0 
.257:
  %.264 = load i32, i32* @.g.pos
  %.265 = load i32*, i32** %.112
  %.266 = getelementptr inbounds i32, i32* %.265, i32 %.264
  %.267 = load i32, i32* %.266
  %.268 = icmp eq i32 %.267, 43
  br i1 %.268, label %.262, label %.263
.258:
  %.455 = load i32, i32* %.109
  %.456 = icmp eq i32 %.455, 2
  br i1 %.456, label %.453, label %.454
.262:
  %.270 = load i32, i32* @.g.pos
  %.271 = add i32 %.270, 1
  store i32 %.271, i32* @.g.pos
  br label %.273 
.263:
  %.277 = load i32, i32* @.g.pos
  %.278 = load i32*, i32** %.112
  %.279 = getelementptr inbounds i32, i32* %.278, i32 %.277
  %.280 = load i32, i32* %.279
  %.281 = icmp eq i32 %.280, 45
  br i1 %.281, label %.275, label %.276
.273:
  %.290 = load i32, i32* @.g.pos
  %.291 = load i32, i32* %.115
  %.292 = icmp sge i32 %.290, %.291
  br i1 %.292, label %.288, label %.289
.275:
  %.283 = load i32, i32* @.g.pos
  %.284 = add i32 %.283, 1
  store i32 %.284, i32* @.g.pos
  br label %.276 
.276:
  br label %.273 
.288:
  ret i32 0 
.289:
  %.297 = load i32, i32* @.g.pos
  %.298 = load i32*, i32** %.112
  %.299 = getelementptr inbounds i32, i32* %.298, i32 %.297
  %.300 = load i32, i32* %.299
  %.301at100 = call i32 @is_number(i32 %.300)
  %.302 = icmp eq i32 %.301at100, 0
  br i1 %.302, label %.295, label %.296
.295:
  ret i32 0 
.296:
  br label %.305 
.305:
  br label %.307wc105 
.307wc105:
  %.311 = load i32, i32* @.g.pos
  %.312 = load i32, i32* %.115
  %.313 = icmp slt i32 %.311, %.312
  br i1 %.313, label %.308wloop.105.110, label %.309wn110
.308wloop.105.110:
  %.317 = load i32, i32* @.g.pos
  %.318 = load i32*, i32** %.112
  %.319 = getelementptr inbounds i32, i32* %.318, i32 %.317
  %.320 = load i32, i32* %.319
  %.321at106 = call i32 @is_number(i32 %.320)
  %.322 = icmp ne i32 %.321at106, 1
  br i1 %.322, label %.315, label %.316
.309wn110:
  %.331 = load i32, i32* @.g.pos
  %.332 = load i32, i32* %.115
  %.333 = icmp slt i32 %.331, %.332
  br i1 %.333, label %.329, label %.330
.315:
  br label %.309wn110 
.316:
  %.325 = load i32, i32* @.g.pos
  %.326 = add i32 %.325, 1
  store i32 %.326, i32* @.g.pos
  br label %.307wc105 
.329:
  %.337 = load i32, i32* @.g.pos
  %.338 = load i32*, i32** %.112
  %.339 = getelementptr inbounds i32, i32* %.338, i32 %.337
  %.340 = load i32, i32* %.339
  %.342 = icmp eq i32 %.340, 46
  br i1 %.342, label %.335, label %.336
.330:
  %.373 = load i32, i32* @.g.pos
  %.374 = load i32, i32* %.115
  %.375 = icmp slt i32 %.373, %.374
  br i1 %.375, label %.371, label %.372
.335:
  %.344 = load i32, i32* @.g.pos
  %.345 = add i32 %.344, 1
  store i32 %.345, i32* @.g.pos
  br label %.347wc116 
.336:
  br label %.330 
.347wc116:
  %.351 = load i32, i32* @.g.pos
  %.352 = load i32, i32* %.115
  %.353 = icmp slt i32 %.351, %.352
  br i1 %.353, label %.348wloop.116.121, label %.349wn121
.348wloop.116.121:
  %.357 = load i32, i32* @.g.pos
  %.358 = load i32*, i32** %.112
  %.359 = getelementptr inbounds i32, i32* %.358, i32 %.357
  %.360 = load i32, i32* %.359
  %.361at117 = call i32 @is_number(i32 %.360)
  %.362 = icmp ne i32 %.361at117, 1
  br i1 %.362, label %.355, label %.356
.349wn121:
  br label %.336 
.355:
  br label %.349wn121 
.356:
  %.365 = load i32, i32* @.g.pos
  %.366 = add i32 %.365, 1
  store i32 %.366, i32* @.g.pos
  br label %.347wc116 
.371:
  %.379 = load i32, i32* @.g.pos
  %.380 = load i32*, i32** %.112
  %.381 = getelementptr inbounds i32, i32* %.380, i32 %.379
  %.382 = load i32, i32* %.381
  %.384 = icmp eq i32 %.382, 101
  br i1 %.384, label %.377, label %.378
.372:
  br label %.451 
.377:
  %.386 = load i32, i32* @.g.pos
  %.387 = add i32 %.386, 1
  store i32 %.387, i32* @.g.pos
  %.391 = load i32, i32* @.g.pos
  %.392 = load i32, i32* %.115
  %.393 = icmp slt i32 %.391, %.392
  br i1 %.393, label %.389, label %.390
.378:
  br label %.372 
.389:
  %.397 = load i32, i32* @.g.pos
  %.398 = load i32*, i32** %.112
  %.399 = getelementptr inbounds i32, i32* %.398, i32 %.397
  %.400 = load i32, i32* %.399
  %.401 = icmp eq i32 %.400, 43
  br i1 %.401, label %.395, label %.396
.390:
  %.410 = load i32, i32* @.g.pos
  %.411 = load i32, i32* %.115
  %.412 = icmp slt i32 %.410, %.411
  br i1 %.412, label %.408, label %.409
.395:
  %.403 = load i32, i32* @.g.pos
  %.404 = add i32 %.403, 1
  store i32 %.404, i32* @.g.pos
  br label %.396 
.396:
  br label %.390 
.408:
  %.416 = load i32, i32* @.g.pos
  %.417 = load i32*, i32** %.112
  %.418 = getelementptr inbounds i32, i32* %.417, i32 %.416
  %.419 = load i32, i32* %.418
  %.420 = icmp eq i32 %.419, 45
  br i1 %.420, label %.414, label %.415
.409:
  br label %.427wc141 
.414:
  %.422 = load i32, i32* @.g.pos
  %.423 = add i32 %.422, 1
  store i32 %.423, i32* @.g.pos
  br label %.415 
.415:
  br label %.409 
.427wc141:
  %.431 = load i32, i32* @.g.pos
  %.432 = load i32, i32* %.115
  %.433 = icmp slt i32 %.431, %.432
  br i1 %.433, label %.428wloop.141.146, label %.429wn146
.428wloop.141.146:
  %.437 = load i32, i32* @.g.pos
  %.438 = load i32*, i32** %.112
  %.439 = getelementptr inbounds i32, i32* %.438, i32 %.437
  %.440 = load i32, i32* %.439
  %.441at142 = call i32 @is_number(i32 %.440)
  %.442 = icmp ne i32 %.441at142, 1
  br i1 %.442, label %.435, label %.436
.429wn146:
  br label %.378 
.435:
  br label %.429wn146 
.436:
  %.445 = load i32, i32* @.g.pos
  %.446 = add i32 %.445, 1
  store i32 %.446, i32* @.g.pos
  br label %.427wc141 
.451:
  br label %.1038 
.453:
  %.458 = load i32, i32* @.g.pos
  %.459 = add i32 %.458, 1
  store i32 %.459, i32* @.g.pos
  br label %.461wc153 
.454:
  %.522 = load i32, i32* %.109
  %.523 = icmp eq i32 %.522, 3
  br i1 %.523, label %.520, label %.521
.461wc153:
  %.465 = load i32, i32* @.g.pos
  %.466 = load i32, i32* %.115
  %.467 = icmp slt i32 %.465, %.466
  br i1 %.467, label %.462wloop.153.162, label %.463wn162
.462wloop.153.162:
  %.471 = load i32, i32* @.g.pos
  %.472 = load i32*, i32** %.112
  %.473 = getelementptr inbounds i32, i32* %.472, i32 %.471
  %.474 = load i32, i32* %.473
  %.475 = icmp eq i32 %.474, 34
  br i1 %.475, label %.469, label %.470
.463wn162:
  %.499 = load i32, i32* @.g.pos
  %.500 = load i32, i32* %.115
  %.501 = icmp sge i32 %.499, %.500
  br i1 %.501, label %.497, label %.498
.469:
  br label %.463wn162 
.470:
  %.480 = load i32, i32* @.g.pos
  %.481 = load i32*, i32** %.112
  %.482 = getelementptr inbounds i32, i32* %.481, i32 %.480
  %.483 = load i32, i32* %.482
  %.485 = icmp eq i32 %.483, 92
  br i1 %.485, label %.478, label %.479
.478:
  %.487 = load i32, i32* @.g.pos
  %.488 = add i32 %.487, 2
  store i32 %.488, i32* @.g.pos
  br label %.490 
.479:
  %.492 = load i32, i32* @.g.pos
  %.493 = add i32 %.492, 1
  store i32 %.493, i32* @.g.pos
  br label %.490 
.490:
  br label %.461wc153 
.497:
  ret i32 0 
.498:
  %.506 = load i32, i32* @.g.pos
  %.507 = load i32*, i32** %.112
  %.508 = getelementptr inbounds i32, i32* %.507, i32 %.506
  %.509 = load i32, i32* %.508
  %.510 = icmp ne i32 %.509, 34
  br i1 %.510, label %.504, label %.505
.504:
  ret i32 0 
.505:
  br label %.513 
.513:
  %.515 = load i32, i32* @.g.pos
  %.516 = add i32 %.515, 1
  store i32 %.516, i32* @.g.pos
  br label %.518 
.518:
  br label %.451 
.520:
  %.525 = load i32, i32* @.g.pos
  %.526 = add i32 %.525, 1
  store i32 %.526, i32* @.g.pos
  %.528 = load i32*, i32** %.112
  %.529 = load i32, i32* %.115
  call void @skip_space(i32* %.528, i32 %.529)
  %.533 = load i32, i32* @.g.pos
  %.534 = load i32, i32* %.115
  %.535 = icmp slt i32 %.533, %.534
  br i1 %.535, label %.531, label %.532
.521:
  %.617 = load i32, i32* %.109
  %.618 = icmp eq i32 %.617, 4
  br i1 %.618, label %.615, label %.616
.531:
  %.539 = load i32, i32* @.g.pos
  %.540 = load i32*, i32** %.112
  %.541 = getelementptr inbounds i32, i32* %.540, i32 %.539
  %.542 = load i32, i32* %.541
  %.544 = icmp eq i32 %.542, 93
  br i1 %.544, label %.537, label %.538
.532:
  %.553 = load i32*, i32** %.112
  %.554 = load i32, i32* %.115
  %.555at191 = call i32 @detect_item(i32 0, i32* %.553, i32 %.554)
  %.556 = icmp eq i32 %.555at191, 0
  br i1 %.556, label %.551, label %.552
.537:
  %.546 = load i32, i32* @.g.pos
  %.547 = add i32 %.546, 1
  store i32 %.547, i32* @.g.pos
  ret i32 1 
.538:
  br label %.532 
.551:
  ret i32 0 
.552:
  %.559 = load i32*, i32** %.112
  %.560 = load i32, i32* %.115
  call void @skip_space(i32* %.559, i32 %.560)
  br label %.562wc197 
.562wc197:
  %.566 = load i32, i32* @.g.pos
  %.567 = load i32*, i32** %.112
  %.568 = getelementptr inbounds i32, i32* %.567, i32 %.566
  %.569 = load i32, i32* %.568
  %.571 = icmp eq i32 %.569, 44
  br i1 %.571, label %.563wloop.197.207, label %.564wn207
.563wloop.197.207:
  %.573 = load i32, i32* @.g.pos
  %.574 = add i32 %.573, 1
  store i32 %.574, i32* @.g.pos
  %.576 = load i32*, i32** %.112
  %.577 = load i32, i32* %.115
  call void @skip_space(i32* %.576, i32 %.577)
  %.581 = load i32*, i32** %.112
  %.582 = load i32, i32* %.115
  %.583at202 = call i32 @detect_item(i32 0, i32* %.581, i32 %.582)
  %.584 = icmp eq i32 %.583at202, 0
  br i1 %.584, label %.579, label %.580
.564wn207:
  %.591 = load i32*, i32** %.112
  %.592 = load i32, i32* %.115
  call void @skip_space(i32* %.591, i32 %.592)
  %.596 = load i32, i32* @.g.pos
  %.597 = load i32, i32* %.115
  %.598 = icmp sge i32 %.596, %.597
  br i1 %.598, label %.594, label %.595
.579:
  ret i32 0 
.580:
  %.587 = load i32*, i32** %.112
  %.588 = load i32, i32* %.115
  call void @skip_space(i32* %.587, i32 %.588)
  br label %.562wc197 
.594:
  ret i32 0 
.595:
  %.603 = load i32, i32* @.g.pos
  %.604 = load i32*, i32** %.112
  %.605 = getelementptr inbounds i32, i32* %.604, i32 %.603
  %.606 = load i32, i32* %.605
  %.607 = icmp ne i32 %.606, 93
  br i1 %.607, label %.601, label %.602
.601:
  ret i32 0 
.602:
  %.610 = load i32, i32* @.g.pos
  %.611 = add i32 %.610, 1
  store i32 %.611, i32* @.g.pos
  br label %.613 
.613:
  br label %.518 
.615:
  %.620 = load i32, i32* @.g.pos
  %.621 = add i32 %.620, 1
  store i32 %.621, i32* @.g.pos
  %.623 = load i32*, i32** %.112
  %.624 = load i32, i32* %.115
  call void @skip_space(i32* %.623, i32 %.624)
  %.628 = load i32, i32* @.g.pos
  %.629 = load i32, i32* %.115
  %.630 = icmp slt i32 %.628, %.629
  br i1 %.630, label %.626, label %.627
.616:
  %.780 = load i32, i32* %.109
  %.781 = icmp eq i32 %.780, 5
  br i1 %.781, label %.778, label %.779
.626:
  %.634 = load i32, i32* @.g.pos
  %.635 = load i32*, i32** %.112
  %.636 = getelementptr inbounds i32, i32* %.635, i32 %.634
  %.637 = load i32, i32* %.636
  %.639 = icmp eq i32 %.637, 125
  br i1 %.639, label %.632, label %.633
.627:
  %.648 = load i32*, i32** %.112
  %.649 = load i32, i32* %.115
  %.650at234 = call i32 @detect_item(i32 2, i32* %.648, i32 %.649)
  %.651 = icmp eq i32 %.650at234, 0
  br i1 %.651, label %.646, label %.647
.632:
  %.641 = load i32, i32* @.g.pos
  %.642 = add i32 %.641, 1
  store i32 %.642, i32* @.g.pos
  ret i32 1 
.633:
  br label %.627 
.646:
  ret i32 0 
.647:
  %.654 = load i32*, i32** %.112
  %.655 = load i32, i32* %.115
  call void @skip_space(i32* %.654, i32 %.655)
  %.659 = load i32, i32* @.g.pos
  %.660 = load i32, i32* %.115
  %.661 = icmp sge i32 %.659, %.660
  br i1 %.661, label %.657, label %.658
.657:
  ret i32 0 
.658:
  %.666 = load i32, i32* @.g.pos
  %.667 = load i32*, i32** %.112
  %.668 = getelementptr inbounds i32, i32* %.667, i32 %.666
  %.669 = load i32, i32* %.668
  %.671 = icmp ne i32 %.669, 58
  br i1 %.671, label %.664, label %.665
.664:
  ret i32 0 
.665:
  %.674 = load i32, i32* @.g.pos
  %.675 = add i32 %.674, 1
  store i32 %.675, i32* @.g.pos
  %.677 = load i32*, i32** %.112
  %.678 = load i32, i32* %.115
  call void @skip_space(i32* %.677, i32 %.678)
  %.682 = load i32*, i32** %.112
  %.683 = load i32, i32* %.115
  %.684at250 = call i32 @detect_item(i32 0, i32* %.682, i32 %.683)
  %.685 = icmp eq i32 %.684at250, 0
  br i1 %.685, label %.680, label %.681
.680:
  ret i32 0 
.681:
  %.688 = load i32*, i32** %.112
  %.689 = load i32, i32* %.115
  call void @skip_space(i32* %.688, i32 %.689)
  br label %.691wc256 
.691wc256:
  %.695 = load i32, i32* @.g.pos
  %.696 = load i32*, i32** %.112
  %.697 = getelementptr inbounds i32, i32* %.696, i32 %.695
  %.698 = load i32, i32* %.697
  %.699 = icmp eq i32 %.698, 44
  br i1 %.699, label %.692wloop.256.283, label %.693wn283
.692wloop.256.283:
  %.701 = load i32, i32* @.g.pos
  %.702 = add i32 %.701, 1
  store i32 %.702, i32* @.g.pos
  %.704 = load i32*, i32** %.112
  %.705 = load i32, i32* %.115
  call void @skip_space(i32* %.704, i32 %.705)
  %.709 = load i32*, i32** %.112
  %.710 = load i32, i32* %.115
  %.711at262 = call i32 @detect_item(i32 2, i32* %.709, i32 %.710)
  %.712 = icmp eq i32 %.711at262, 0
  br i1 %.712, label %.707, label %.708
.693wn283:
  %.752 = load i32*, i32** %.112
  %.753 = load i32, i32* %.115
  call void @skip_space(i32* %.752, i32 %.753)
  %.757 = load i32, i32* @.g.pos
  %.758 = load i32, i32* %.115
  %.759 = icmp sge i32 %.757, %.758
  br i1 %.759, label %.755, label %.756
.707:
  ret i32 0 
.708:
  %.715 = load i32*, i32** %.112
  %.716 = load i32, i32* %.115
  call void @skip_space(i32* %.715, i32 %.716)
  %.720 = load i32, i32* @.g.pos
  %.721 = load i32, i32* %.115
  %.722 = icmp sge i32 %.720, %.721
  br i1 %.722, label %.718, label %.719
.718:
  ret i32 0 
.719:
  %.727 = load i32, i32* @.g.pos
  %.728 = load i32*, i32** %.112
  %.729 = getelementptr inbounds i32, i32* %.728, i32 %.727
  %.730 = load i32, i32* %.729
  %.731 = icmp ne i32 %.730, 58
  br i1 %.731, label %.725, label %.726
.725:
  ret i32 0 
.726:
  %.734 = load i32, i32* @.g.pos
  %.735 = add i32 %.734, 1
  store i32 %.735, i32* @.g.pos
  %.737 = load i32*, i32** %.112
  %.738 = load i32, i32* %.115
  call void @skip_space(i32* %.737, i32 %.738)
  %.742 = load i32*, i32** %.112
  %.743 = load i32, i32* %.115
  %.744at278 = call i32 @detect_item(i32 0, i32* %.742, i32 %.743)
  %.745 = icmp eq i32 %.744at278, 0
  br i1 %.745, label %.740, label %.741
.740:
  ret i32 0 
.741:
  %.748 = load i32*, i32** %.112
  %.749 = load i32, i32* %.115
  call void @skip_space(i32* %.748, i32 %.749)
  br label %.691wc256 
.755:
  ret i32 0 
.756:
  %.764 = load i32, i32* @.g.pos
  %.765 = load i32*, i32** %.112
  %.766 = getelementptr inbounds i32, i32* %.765, i32 %.764
  %.767 = load i32, i32* %.766
  %.768 = icmp ne i32 %.767, 125
  br i1 %.768, label %.762, label %.763
.762:
  ret i32 0 
.763:
  br label %.771 
.771:
  %.773 = load i32, i32* @.g.pos
  %.774 = add i32 %.773, 1
  store i32 %.774, i32* @.g.pos
  br label %.776 
.776:
  br label %.613 
.778:
  call void @llvm.memcpy.p0.p0.i32([4 x i32]* %.783, [4 x i32]* @__constant..787, i32 16, i1 false)
  %.793 = load i32, i32* @.g.pos
  %.794 = add i32 %.793, 3
  %.795 = load i32, i32* %.115
  %.796 = icmp sge i32 %.794, %.795
  br i1 %.796, label %.791, label %.792
.779:
  %.861 = load i32, i32* %.109
  %.862 = icmp eq i32 %.861, 6
  br i1 %.862, label %.859, label %.860
.791:
  ret i32 0 
.792:
  %.801 = load i32, i32* @.g.pos
  %.802 = load i32*, i32** %.112
  %.803 = getelementptr inbounds i32, i32* %.802, i32 %.801
  %.804 = load i32, i32* %.803
  %.805 = getelementptr inbounds [4 x i32], [4 x i32]* %.783, i32 0, i32 0
  %.806 = load i32, i32* %.805
  %.807 = icmp ne i32 %.804, %.806
  br i1 %.807, label %.799, label %.800
.799:
  ret i32 0 
.800:
  %.812 = load i32, i32* @.g.pos
  %.813 = add i32 %.812, 1
  %.814 = load i32*, i32** %.112
  %.815 = getelementptr inbounds i32, i32* %.814, i32 %.813
  %.816 = load i32, i32* %.815
  %.817 = getelementptr inbounds [4 x i32], [4 x i32]* %.783, i32 0, i32 1
  %.818 = load i32, i32* %.817
  %.819 = icmp ne i32 %.816, %.818
  br i1 %.819, label %.810, label %.811
.810:
  ret i32 0 
.811:
  %.824 = load i32, i32* @.g.pos
  %.825 = add i32 %.824, 2
  %.826 = load i32*, i32** %.112
  %.827 = getelementptr inbounds i32, i32* %.826, i32 %.825
  %.828 = load i32, i32* %.827
  %.829 = getelementptr inbounds [4 x i32], [4 x i32]* %.783, i32 0, i32 2
  %.830 = load i32, i32* %.829
  %.831 = icmp ne i32 %.828, %.830
  br i1 %.831, label %.822, label %.823
.822:
  ret i32 0 
.823:
  %.836 = load i32, i32* @.g.pos
  %.837 = add i32 %.836, 3
  %.838 = load i32*, i32** %.112
  %.839 = getelementptr inbounds i32, i32* %.838, i32 %.837
  %.840 = load i32, i32* %.839
  %.841 = getelementptr inbounds [4 x i32], [4 x i32]* %.783, i32 0, i32 3
  %.842 = load i32, i32* %.841
  %.843 = icmp ne i32 %.840, %.842
  br i1 %.843, label %.834, label %.835
.834:
  ret i32 0 
.835:
  br label %.846 
.846:
  br label %.848 
.848:
  br label %.850 
.850:
  br label %.852 
.852:
  %.854 = load i32, i32* @.g.pos
  %.855 = add i32 %.854, 4
  store i32 %.855, i32* @.g.pos
  br label %.857 
.857:
  br label %.776 
.859:
  call void @llvm.memcpy.p0.p0.i32([5 x i32]* %.864, [5 x i32]* @__constant..869, i32 20, i1 false)
  %.874 = load i32, i32* @.g.pos
  %.875 = add i32 %.874, 4
  %.876 = load i32, i32* %.115
  %.877 = icmp sge i32 %.875, %.876
  br i1 %.877, label %.872, label %.873
.860:
  %.956 = load i32, i32* %.109
  %.957 = icmp eq i32 %.956, 7
  br i1 %.957, label %.954, label %.955
.872:
  ret i32 0 
.873:
  %.882 = load i32, i32* @.g.pos
  %.883 = load i32*, i32** %.112
  %.884 = getelementptr inbounds i32, i32* %.883, i32 %.882
  %.885 = load i32, i32* %.884
  %.886 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 0
  %.887 = load i32, i32* %.886
  %.888 = icmp ne i32 %.885, %.887
  br i1 %.888, label %.880, label %.881
.880:
  ret i32 0 
.881:
  %.893 = load i32, i32* @.g.pos
  %.894 = add i32 %.893, 1
  %.895 = load i32*, i32** %.112
  %.896 = getelementptr inbounds i32, i32* %.895, i32 %.894
  %.897 = load i32, i32* %.896
  %.898 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 1
  %.899 = load i32, i32* %.898
  %.900 = icmp ne i32 %.897, %.899
  br i1 %.900, label %.891, label %.892
.891:
  ret i32 0 
.892:
  %.905 = load i32, i32* @.g.pos
  %.906 = add i32 %.905, 2
  %.907 = load i32*, i32** %.112
  %.908 = getelementptr inbounds i32, i32* %.907, i32 %.906
  %.909 = load i32, i32* %.908
  %.910 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 2
  %.911 = load i32, i32* %.910
  %.912 = icmp ne i32 %.909, %.911
  br i1 %.912, label %.903, label %.904
.903:
  ret i32 0 
.904:
  %.917 = load i32, i32* @.g.pos
  %.918 = add i32 %.917, 3
  %.919 = load i32*, i32** %.112
  %.920 = getelementptr inbounds i32, i32* %.919, i32 %.918
  %.921 = load i32, i32* %.920
  %.922 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 3
  %.923 = load i32, i32* %.922
  %.924 = icmp ne i32 %.921, %.923
  br i1 %.924, label %.915, label %.916
.915:
  ret i32 0 
.916:
  %.929 = load i32, i32* @.g.pos
  %.930 = add i32 %.929, 4
  %.931 = load i32*, i32** %.112
  %.932 = getelementptr inbounds i32, i32* %.931, i32 %.930
  %.933 = load i32, i32* %.932
  %.934 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 4
  %.935 = load i32, i32* %.934
  %.936 = icmp ne i32 %.933, %.935
  br i1 %.936, label %.927, label %.928
.927:
  ret i32 0 
.928:
  br label %.939 
.939:
  br label %.941 
.941:
  br label %.943 
.943:
  br label %.945 
.945:
  br label %.947 
.947:
  %.949 = load i32, i32* @.g.pos
  %.950 = add i32 %.949, 5
  store i32 %.950, i32* @.g.pos
  br label %.952 
.952:
  br label %.857 
.954:
  call void @llvm.memcpy.p0.p0.i32([4 x i32]* %.959, [4 x i32]* @__constant..961, i32 16, i1 false)
  %.965 = load i32, i32* @.g.pos
  %.966 = add i32 %.965, 3
  %.967 = load i32, i32* %.115
  %.968 = icmp sge i32 %.966, %.967
  br i1 %.968, label %.963, label %.964
.955:
  ret i32 0 
.963:
  ret i32 0 
.964:
  %.973 = load i32, i32* @.g.pos
  %.974 = load i32*, i32** %.112
  %.975 = getelementptr inbounds i32, i32* %.974, i32 %.973
  %.976 = load i32, i32* %.975
  %.977 = getelementptr inbounds [4 x i32], [4 x i32]* %.959, i32 0, i32 0
  %.978 = load i32, i32* %.977
  %.979 = icmp ne i32 %.976, %.978
  br i1 %.979, label %.971, label %.972
.971:
  ret i32 0 
.972:
  %.984 = load i32, i32* @.g.pos
  %.985 = add i32 %.984, 1
  %.986 = load i32*, i32** %.112
  %.987 = getelementptr inbounds i32, i32* %.986, i32 %.985
  %.988 = load i32, i32* %.987
  %.989 = getelementptr inbounds [4 x i32], [4 x i32]* %.959, i32 0, i32 1
  %.990 = load i32, i32* %.989
  %.991 = icmp ne i32 %.988, %.990
  br i1 %.991, label %.982, label %.983
.982:
  ret i32 0 
.983:
  %.996 = load i32, i32* @.g.pos
  %.997 = add i32 %.996, 2
  %.998 = load i32*, i32** %.112
  %.999 = getelementptr inbounds i32, i32* %.998, i32 %.997
  %.1000 = load i32, i32* %.999
  %.1001 = getelementptr inbounds [4 x i32], [4 x i32]* %.959, i32 0, i32 2
  %.1002 = load i32, i32* %.1001
  %.1003 = icmp ne i32 %.1000, %.1002
  br i1 %.1003, label %.994, label %.995
.994:
  ret i32 0 
.995:
  %.1008 = load i32, i32* @.g.pos
  %.1009 = add i32 %.1008, 3
  %.1010 = load i32*, i32** %.112
  %.1011 = getelementptr inbounds i32, i32* %.1010, i32 %.1009
  %.1012 = load i32, i32* %.1011
  %.1013 = getelementptr inbounds [4 x i32], [4 x i32]* %.959, i32 0, i32 3
  %.1014 = load i32, i32* %.1013
  %.1015 = icmp ne i32 %.1012, %.1014
  br i1 %.1015, label %.1006, label %.1007
.1006:
  ret i32 0 
.1007:
  br label %.1018 
.1018:
  br label %.1020 
.1020:
  br label %.1022 
.1022:
  br label %.1024 
.1024:
  %.1026 = load i32, i32* @.g.pos
  %.1027 = add i32 %.1026, 4
  store i32 %.1027, i32* @.g.pos
  br label %.1029 
.1029:
  br label %.952 
.1038:
  ret i32 1 
}
define i32 @main(){
.1045:
  %.1073 = alloca i32
  %.1050 = alloca i32
  %.1046 = alloca i32
  %.1048at358 = call i32 @getch()
  store i32 %.1048at358, i32* %.1046
  store i32 0, i32* %.1050
  br label %.1052wc360 
.1052wc360:
  %.1056 = load i32, i32* %.1046
  %.1058 = icmp ne i32 %.1056, 35
  br i1 %.1058, label %.1053wloop.360.364, label %.1054wn364
.1053wloop.360.364:
  %.1060 = load i32, i32* %.1046
  %.1061 = load i32, i32* %.1050
  %.1062 = getelementptr inbounds [50000000 x i32], [50000000 x i32]* @.g.buffer, i32 0, i32 %.1061
  store i32 %.1060, i32* %.1062
  %.1064 = load i32, i32* %.1050
  %.1065 = add i32 %.1064, 1
  store i32 %.1065, i32* %.1050
  %.1067at363 = call i32 @getch()
  store i32 %.1067at363, i32* %.1046
  br label %.1052wc360 
.1054wn364:
  %.1070 = getelementptr inbounds [50000000 x i32], [50000000 x i32]* @.g.buffer, i32 0, i32 0
  %.1071 = load i32, i32* %.1050
  call void @skip_space(i32* %.1070, i32 %.1071)
  %.1074 = getelementptr inbounds [50000000 x i32], [50000000 x i32]* @.g.buffer, i32 0, i32 0
  %.1075 = load i32, i32* %.1050
  %.1076at366 = call i32 @detect_item(i32 0, i32* %.1074, i32 %.1075)
  store i32 %.1076at366, i32* %.1073
  %.1078 = getelementptr inbounds [50000000 x i32], [50000000 x i32]* @.g.buffer, i32 0, i32 0
  %.1079 = load i32, i32* %.1050
  call void @skip_space(i32* %.1078, i32 %.1079)
  %.1083 = load i32, i32* %.1073
  %.1084 = icmp ne i32 %.1083, 0
  br i1 %.1084, label %.1081, label %.1082
.1081:
  call void @putch(i32 111)
  call void @putch(i32 107)
  call void @putch(i32 10)
  ret i32 0 
.1082:
  call void @putch(i32 110)
  call void @putch(i32 111)
  call void @putch(i32 116)
  call void @putch(i32 32)
  call void @putch(i32 111)
  call void @putch(i32 107)
  call void @putch(i32 10)
  ret i32 1 
}
@.g.pos = global i32 0
@.g.buffer = global [50000000 x i32] zeroinitializer
@__constant..787 = constant [4 x i32]  [i32 116, i32 114, i32 117, i32 101]
@__constant..869 = constant [5 x i32]  [i32 102, i32 97, i32 108, i32 115, i32 101]
@__constant..961 = constant [4 x i32]  [i32 110, i32 117, i32 108, i32 108]
define i32 @is_number(i32 %.5){
.3:
  %.4 = alloca i32
  store i32 %.5, i32* %.4
  %.9 = load i32, i32* %.4
  %.11 = icmp sge i32 %.9, 48
  br i1 %.11, label %.7, label %.8
.7:
  %.15 = load i32, i32* %.4
  %.17 = icmp sle i32 %.15, 57
  br i1 %.17, label %.13, label %.14
.8:
  ret i32 0 
.13:
  ret i32 1 
.14:
  ret i32 0 
}
define void @skip_space(i32* %.26, i32 %.29){
.24:
  %.28 = alloca i32
  %.25 = alloca i32*
  store i32* %.26, i32** %.25
  store i32 %.29, i32* %.28
  br label %.31wc29 
.31wc29:
  br label %.32wloop.29.44 
.32wloop.29.44:
  %.40 = load i32, i32* @.g.pos
  %.41 = load i32, i32* %.28
  %.42 = icmp sge i32 %.40, %.41
  br i1 %.42, label %.38, label %.39
.33wn44:
  ret void
.38:
  br label %.33wn44 
.39:
  %.47 = load i32, i32* @.g.pos
  %.48 = load i32*, i32** %.25
  %.49 = getelementptr inbounds i32, i32* %.48, i32 %.47
  %.50 = load i32, i32* %.49
  %.52 = icmp eq i32 %.50, 32
  br i1 %.52, label %.45, label %.46
.45:
  %.54 = load i32, i32* @.g.pos
  %.55 = add i32 %.54, 1
  store i32 %.55, i32* @.g.pos
  br label %.57 
.46:
  %.61 = load i32, i32* @.g.pos
  %.62 = load i32*, i32** %.25
  %.63 = getelementptr inbounds i32, i32* %.62, i32 %.61
  %.64 = load i32, i32* %.63
  %.66 = icmp eq i32 %.64, 9
  br i1 %.66, label %.59, label %.60
.57:
  br label %.31wc29 
.59:
  %.68 = load i32, i32* @.g.pos
  %.69 = add i32 %.68, 1
  store i32 %.69, i32* @.g.pos
  br label %.71 
.60:
  %.75 = load i32, i32* @.g.pos
  %.76 = load i32*, i32** %.25
  %.77 = getelementptr inbounds i32, i32* %.76, i32 %.75
  %.78 = load i32, i32* %.77
  %.80 = icmp eq i32 %.78, 10
  br i1 %.80, label %.73, label %.74
.71:
  br label %.57 
.73:
  %.82 = load i32, i32* @.g.pos
  %.83 = add i32 %.82, 1
  store i32 %.83, i32* @.g.pos
  br label %.85 
.74:
  %.89 = load i32, i32* @.g.pos
  %.90 = load i32*, i32** %.25
  %.91 = getelementptr inbounds i32, i32* %.90, i32 %.89
  %.92 = load i32, i32* %.91
  %.94 = icmp eq i32 %.92, 13
  br i1 %.94, label %.87, label %.88
.85:
  br label %.71 
.87:
  %.96 = load i32, i32* @.g.pos
  %.97 = add i32 %.96, 1
  store i32 %.97, i32* @.g.pos
  br label %.99 
.88:
  br label %.33wn44 
.99:
  br label %.85 
}
define i32 @detect_item(i32 %.110, i32* %.113, i32 %.116){
.108:
  %.959 = alloca [4 x i32]
  %.864 = alloca [5 x i32]
  %.783 = alloca [4 x i32]
  %.115 = alloca i32
  %.112 = alloca i32*
  %.109 = alloca i32
  store i32 %.110, i32* %.109
  store i32* %.113, i32** %.112
  store i32 %.116, i32* %.115
  %.120 = load i32, i32* @.g.pos
  %.121 = load i32, i32* %.115
  %.122 = icmp sge i32 %.120, %.121
  br i1 %.122, label %.118, label %.119
.118:
  ret i32 0 
.119:
  %.125 = load i32*, i32** %.112
  %.126 = load i32, i32* %.115
  call void @skip_space(i32* %.125, i32 %.126)
  %.130 = load i32, i32* %.109
  %.131 = icmp eq i32 %.130, 0
  br i1 %.131, label %.128, label %.129
.128:
  %.135 = load i32, i32* @.g.pos
  %.136 = load i32*, i32** %.112
  %.137 = getelementptr inbounds i32, i32* %.136, i32 %.135
  %.138 = load i32, i32* %.137
  %.140 = icmp eq i32 %.138, 123
  br i1 %.140, label %.133, label %.134
.129:
  %.259 = load i32, i32* %.109
  %.260 = icmp eq i32 %.259, 1
  br i1 %.260, label %.257, label %.258
.133:
  %.143 = load i32*, i32** %.112
  %.144 = load i32, i32* %.115
  %.145at55 = call i32 @detect_item(i32 4, i32* %.143, i32 %.144)
  ret i32 %.145at55 
.134:
  %.149 = load i32, i32* @.g.pos
  %.150 = load i32*, i32** %.112
  %.151 = getelementptr inbounds i32, i32* %.150, i32 %.149
  %.152 = load i32, i32* %.151
  %.154 = icmp eq i32 %.152, 91
  br i1 %.154, label %.147, label %.148
.147:
  %.157 = load i32*, i32** %.112
  %.158 = load i32, i32* %.115
  %.159at57 = call i32 @detect_item(i32 3, i32* %.157, i32 %.158)
  ret i32 %.159at57 
.148:
  %.163 = load i32, i32* @.g.pos
  %.164 = load i32*, i32** %.112
  %.165 = getelementptr inbounds i32, i32* %.164, i32 %.163
  %.166 = load i32, i32* %.165
  %.168 = icmp eq i32 %.166, 34
  br i1 %.168, label %.161, label %.162
.161:
  %.171 = load i32*, i32** %.112
  %.172 = load i32, i32* %.115
  %.173at59 = call i32 @detect_item(i32 2, i32* %.171, i32 %.172)
  ret i32 %.173at59 
.162:
  %.177 = load i32, i32* @.g.pos
  %.178 = load i32*, i32** %.112
  %.179 = getelementptr inbounds i32, i32* %.178, i32 %.177
  %.180 = load i32, i32* %.179
  %.181at60 = call i32 @is_number(i32 %.180)
  %.182 = icmp eq i32 %.181at60, 1
  br i1 %.182, label %.175, label %.176
.175:
  %.184 = load i32*, i32** %.112
  %.185 = load i32, i32* %.115
  %.186at62 = call i32 @detect_item(i32 1, i32* %.184, i32 %.185)
  ret i32 %.186at62 
.176:
  %.190 = load i32, i32* @.g.pos
  %.191 = load i32*, i32** %.112
  %.192 = getelementptr inbounds i32, i32* %.191, i32 %.190
  %.193 = load i32, i32* %.192
  %.195 = icmp eq i32 %.193, 43
  br i1 %.195, label %.188, label %.189
.188:
  %.197 = load i32*, i32** %.112
  %.198 = load i32, i32* %.115
  %.199at65 = call i32 @detect_item(i32 1, i32* %.197, i32 %.198)
  ret i32 %.199at65 
.189:
  %.203 = load i32, i32* @.g.pos
  %.204 = load i32*, i32** %.112
  %.205 = getelementptr inbounds i32, i32* %.204, i32 %.203
  %.206 = load i32, i32* %.205
  %.208 = icmp eq i32 %.206, 45
  br i1 %.208, label %.201, label %.202
.201:
  %.210 = load i32*, i32** %.112
  %.211 = load i32, i32* %.115
  %.212at68 = call i32 @detect_item(i32 1, i32* %.210, i32 %.211)
  ret i32 %.212at68 
.202:
  %.216 = load i32, i32* @.g.pos
  %.217 = load i32*, i32** %.112
  %.218 = getelementptr inbounds i32, i32* %.217, i32 %.216
  %.219 = load i32, i32* %.218
  %.221 = icmp eq i32 %.219, 116
  br i1 %.221, label %.214, label %.215
.214:
  %.224 = load i32*, i32** %.112
  %.225 = load i32, i32* %.115
  %.226at71 = call i32 @detect_item(i32 5, i32* %.224, i32 %.225)
  ret i32 %.226at71 
.215:
  %.230 = load i32, i32* @.g.pos
  %.231 = load i32*, i32** %.112
  %.232 = getelementptr inbounds i32, i32* %.231, i32 %.230
  %.233 = load i32, i32* %.232
  %.235 = icmp eq i32 %.233, 102
  br i1 %.235, label %.228, label %.229
.228:
  %.238 = load i32*, i32** %.112
  %.239 = load i32, i32* %.115
  %.240at74 = call i32 @detect_item(i32 6, i32* %.238, i32 %.239)
  ret i32 %.240at74 
.229:
  %.244 = load i32, i32* @.g.pos
  %.245 = load i32*, i32** %.112
  %.246 = getelementptr inbounds i32, i32* %.245, i32 %.244
  %.247 = load i32, i32* %.246
  %.249 = icmp eq i32 %.247, 110
  br i1 %.249, label %.242, label %.243
.242:
  %.252 = load i32*, i32** %.112
  %.253 = load i32, i32* %.115
  %.254at77 = call i32 @detect_item(i32 7, i32* %.252, i32 %.253)
  ret i32 %.254at77 
.243:
  ret i32 0 
.257:
  %.264 = load i32, i32* @.g.pos
  %.265 = load i32*, i32** %.112
  %.266 = getelementptr inbounds i32, i32* %.265, i32 %.264
  %.267 = load i32, i32* %.266
  %.268 = icmp eq i32 %.267, 43
  br i1 %.268, label %.262, label %.263
.258:
  %.455 = load i32, i32* %.109
  %.456 = icmp eq i32 %.455, 2
  br i1 %.456, label %.453, label %.454
.262:
  %.270 = load i32, i32* @.g.pos
  %.271 = add i32 %.270, 1
  store i32 %.271, i32* @.g.pos
  br label %.273 
.263:
  %.277 = load i32, i32* @.g.pos
  %.278 = load i32*, i32** %.112
  %.279 = getelementptr inbounds i32, i32* %.278, i32 %.277
  %.280 = load i32, i32* %.279
  %.281 = icmp eq i32 %.280, 45
  br i1 %.281, label %.275, label %.276
.273:
  %.290 = load i32, i32* @.g.pos
  %.291 = load i32, i32* %.115
  %.292 = icmp sge i32 %.290, %.291
  br i1 %.292, label %.288, label %.289
.275:
  %.283 = load i32, i32* @.g.pos
  %.284 = add i32 %.283, 1
  store i32 %.284, i32* @.g.pos
  br label %.276 
.276:
  br label %.273 
.288:
  ret i32 0 
.289:
  %.297 = load i32, i32* @.g.pos
  %.298 = load i32*, i32** %.112
  %.299 = getelementptr inbounds i32, i32* %.298, i32 %.297
  %.300 = load i32, i32* %.299
  %.301at100 = call i32 @is_number(i32 %.300)
  %.302 = icmp eq i32 %.301at100, 0
  br i1 %.302, label %.295, label %.296
.295:
  ret i32 0 
.296:
  br label %.305 
.305:
  br label %.307wc105 
.307wc105:
  %.311 = load i32, i32* @.g.pos
  %.312 = load i32, i32* %.115
  %.313 = icmp slt i32 %.311, %.312
  br i1 %.313, label %.308wloop.105.110, label %.309wn110
.308wloop.105.110:
  %.317 = load i32, i32* @.g.pos
  %.318 = load i32*, i32** %.112
  %.319 = getelementptr inbounds i32, i32* %.318, i32 %.317
  %.320 = load i32, i32* %.319
  %.321at106 = call i32 @is_number(i32 %.320)
  %.322 = icmp ne i32 %.321at106, 1
  br i1 %.322, label %.315, label %.316
.309wn110:
  %.331 = load i32, i32* @.g.pos
  %.332 = load i32, i32* %.115
  %.333 = icmp slt i32 %.331, %.332
  br i1 %.333, label %.329, label %.330
.315:
  br label %.309wn110 
.316:
  %.325 = load i32, i32* @.g.pos
  %.326 = add i32 %.325, 1
  store i32 %.326, i32* @.g.pos
  br label %.307wc105 
.329:
  %.337 = load i32, i32* @.g.pos
  %.338 = load i32*, i32** %.112
  %.339 = getelementptr inbounds i32, i32* %.338, i32 %.337
  %.340 = load i32, i32* %.339
  %.342 = icmp eq i32 %.340, 46
  br i1 %.342, label %.335, label %.336
.330:
  %.373 = load i32, i32* @.g.pos
  %.374 = load i32, i32* %.115
  %.375 = icmp slt i32 %.373, %.374
  br i1 %.375, label %.371, label %.372
.335:
  %.344 = load i32, i32* @.g.pos
  %.345 = add i32 %.344, 1
  store i32 %.345, i32* @.g.pos
  br label %.347wc116 
.336:
  br label %.330 
.347wc116:
  %.351 = load i32, i32* @.g.pos
  %.352 = load i32, i32* %.115
  %.353 = icmp slt i32 %.351, %.352
  br i1 %.353, label %.348wloop.116.121, label %.349wn121
.348wloop.116.121:
  %.357 = load i32, i32* @.g.pos
  %.358 = load i32*, i32** %.112
  %.359 = getelementptr inbounds i32, i32* %.358, i32 %.357
  %.360 = load i32, i32* %.359
  %.361at117 = call i32 @is_number(i32 %.360)
  %.362 = icmp ne i32 %.361at117, 1
  br i1 %.362, label %.355, label %.356
.349wn121:
  br label %.336 
.355:
  br label %.349wn121 
.356:
  %.365 = load i32, i32* @.g.pos
  %.366 = add i32 %.365, 1
  store i32 %.366, i32* @.g.pos
  br label %.347wc116 
.371:
  %.379 = load i32, i32* @.g.pos
  %.380 = load i32*, i32** %.112
  %.381 = getelementptr inbounds i32, i32* %.380, i32 %.379
  %.382 = load i32, i32* %.381
  %.384 = icmp eq i32 %.382, 101
  br i1 %.384, label %.377, label %.378
.372:
  br label %.451 
.377:
  %.386 = load i32, i32* @.g.pos
  %.387 = add i32 %.386, 1
  store i32 %.387, i32* @.g.pos
  %.391 = load i32, i32* @.g.pos
  %.392 = load i32, i32* %.115
  %.393 = icmp slt i32 %.391, %.392
  br i1 %.393, label %.389, label %.390
.378:
  br label %.372 
.389:
  %.397 = load i32, i32* @.g.pos
  %.398 = load i32*, i32** %.112
  %.399 = getelementptr inbounds i32, i32* %.398, i32 %.397
  %.400 = load i32, i32* %.399
  %.401 = icmp eq i32 %.400, 43
  br i1 %.401, label %.395, label %.396
.390:
  %.410 = load i32, i32* @.g.pos
  %.411 = load i32, i32* %.115
  %.412 = icmp slt i32 %.410, %.411
  br i1 %.412, label %.408, label %.409
.395:
  %.403 = load i32, i32* @.g.pos
  %.404 = add i32 %.403, 1
  store i32 %.404, i32* @.g.pos
  br label %.396 
.396:
  br label %.390 
.408:
  %.416 = load i32, i32* @.g.pos
  %.417 = load i32*, i32** %.112
  %.418 = getelementptr inbounds i32, i32* %.417, i32 %.416
  %.419 = load i32, i32* %.418
  %.420 = icmp eq i32 %.419, 45
  br i1 %.420, label %.414, label %.415
.409:
  br label %.427wc141 
.414:
  %.422 = load i32, i32* @.g.pos
  %.423 = add i32 %.422, 1
  store i32 %.423, i32* @.g.pos
  br label %.415 
.415:
  br label %.409 
.427wc141:
  %.431 = load i32, i32* @.g.pos
  %.432 = load i32, i32* %.115
  %.433 = icmp slt i32 %.431, %.432
  br i1 %.433, label %.428wloop.141.146, label %.429wn146
.428wloop.141.146:
  %.437 = load i32, i32* @.g.pos
  %.438 = load i32*, i32** %.112
  %.439 = getelementptr inbounds i32, i32* %.438, i32 %.437
  %.440 = load i32, i32* %.439
  %.441at142 = call i32 @is_number(i32 %.440)
  %.442 = icmp ne i32 %.441at142, 1
  br i1 %.442, label %.435, label %.436
.429wn146:
  br label %.378 
.435:
  br label %.429wn146 
.436:
  %.445 = load i32, i32* @.g.pos
  %.446 = add i32 %.445, 1
  store i32 %.446, i32* @.g.pos
  br label %.427wc141 
.451:
  br label %.1038 
.453:
  %.458 = load i32, i32* @.g.pos
  %.459 = add i32 %.458, 1
  store i32 %.459, i32* @.g.pos
  br label %.461wc153 
.454:
  %.522 = load i32, i32* %.109
  %.523 = icmp eq i32 %.522, 3
  br i1 %.523, label %.520, label %.521
.461wc153:
  %.465 = load i32, i32* @.g.pos
  %.466 = load i32, i32* %.115
  %.467 = icmp slt i32 %.465, %.466
  br i1 %.467, label %.462wloop.153.162, label %.463wn162
.462wloop.153.162:
  %.471 = load i32, i32* @.g.pos
  %.472 = load i32*, i32** %.112
  %.473 = getelementptr inbounds i32, i32* %.472, i32 %.471
  %.474 = load i32, i32* %.473
  %.475 = icmp eq i32 %.474, 34
  br i1 %.475, label %.469, label %.470
.463wn162:
  %.499 = load i32, i32* @.g.pos
  %.500 = load i32, i32* %.115
  %.501 = icmp sge i32 %.499, %.500
  br i1 %.501, label %.497, label %.498
.469:
  br label %.463wn162 
.470:
  %.480 = load i32, i32* @.g.pos
  %.481 = load i32*, i32** %.112
  %.482 = getelementptr inbounds i32, i32* %.481, i32 %.480
  %.483 = load i32, i32* %.482
  %.485 = icmp eq i32 %.483, 92
  br i1 %.485, label %.478, label %.479
.478:
  %.487 = load i32, i32* @.g.pos
  %.488 = add i32 %.487, 2
  store i32 %.488, i32* @.g.pos
  br label %.490 
.479:
  %.492 = load i32, i32* @.g.pos
  %.493 = add i32 %.492, 1
  store i32 %.493, i32* @.g.pos
  br label %.490 
.490:
  br label %.461wc153 
.497:
  ret i32 0 
.498:
  %.506 = load i32, i32* @.g.pos
  %.507 = load i32*, i32** %.112
  %.508 = getelementptr inbounds i32, i32* %.507, i32 %.506
  %.509 = load i32, i32* %.508
  %.510 = icmp ne i32 %.509, 34
  br i1 %.510, label %.504, label %.505
.504:
  ret i32 0 
.505:
  br label %.513 
.513:
  %.515 = load i32, i32* @.g.pos
  %.516 = add i32 %.515, 1
  store i32 %.516, i32* @.g.pos
  br label %.518 
.518:
  br label %.451 
.520:
  %.525 = load i32, i32* @.g.pos
  %.526 = add i32 %.525, 1
  store i32 %.526, i32* @.g.pos
  %.528 = load i32*, i32** %.112
  %.529 = load i32, i32* %.115
  call void @skip_space(i32* %.528, i32 %.529)
  %.533 = load i32, i32* @.g.pos
  %.534 = load i32, i32* %.115
  %.535 = icmp slt i32 %.533, %.534
  br i1 %.535, label %.531, label %.532
.521:
  %.617 = load i32, i32* %.109
  %.618 = icmp eq i32 %.617, 4
  br i1 %.618, label %.615, label %.616
.531:
  %.539 = load i32, i32* @.g.pos
  %.540 = load i32*, i32** %.112
  %.541 = getelementptr inbounds i32, i32* %.540, i32 %.539
  %.542 = load i32, i32* %.541
  %.544 = icmp eq i32 %.542, 93
  br i1 %.544, label %.537, label %.538
.532:
  %.553 = load i32*, i32** %.112
  %.554 = load i32, i32* %.115
  %.555at191 = call i32 @detect_item(i32 0, i32* %.553, i32 %.554)
  %.556 = icmp eq i32 %.555at191, 0
  br i1 %.556, label %.551, label %.552
.537:
  %.546 = load i32, i32* @.g.pos
  %.547 = add i32 %.546, 1
  store i32 %.547, i32* @.g.pos
  ret i32 1 
.538:
  br label %.532 
.551:
  ret i32 0 
.552:
  %.559 = load i32*, i32** %.112
  %.560 = load i32, i32* %.115
  call void @skip_space(i32* %.559, i32 %.560)
  br label %.562wc197 
.562wc197:
  %.566 = load i32, i32* @.g.pos
  %.567 = load i32*, i32** %.112
  %.568 = getelementptr inbounds i32, i32* %.567, i32 %.566
  %.569 = load i32, i32* %.568
  %.571 = icmp eq i32 %.569, 44
  br i1 %.571, label %.563wloop.197.207, label %.564wn207
.563wloop.197.207:
  %.573 = load i32, i32* @.g.pos
  %.574 = add i32 %.573, 1
  store i32 %.574, i32* @.g.pos
  %.576 = load i32*, i32** %.112
  %.577 = load i32, i32* %.115
  call void @skip_space(i32* %.576, i32 %.577)
  %.581 = load i32*, i32** %.112
  %.582 = load i32, i32* %.115
  %.583at202 = call i32 @detect_item(i32 0, i32* %.581, i32 %.582)
  %.584 = icmp eq i32 %.583at202, 0
  br i1 %.584, label %.579, label %.580
.564wn207:
  %.591 = load i32*, i32** %.112
  %.592 = load i32, i32* %.115
  call void @skip_space(i32* %.591, i32 %.592)
  %.596 = load i32, i32* @.g.pos
  %.597 = load i32, i32* %.115
  %.598 = icmp sge i32 %.596, %.597
  br i1 %.598, label %.594, label %.595
.579:
  ret i32 0 
.580:
  %.587 = load i32*, i32** %.112
  %.588 = load i32, i32* %.115
  call void @skip_space(i32* %.587, i32 %.588)
  br label %.562wc197 
.594:
  ret i32 0 
.595:
  %.603 = load i32, i32* @.g.pos
  %.604 = load i32*, i32** %.112
  %.605 = getelementptr inbounds i32, i32* %.604, i32 %.603
  %.606 = load i32, i32* %.605
  %.607 = icmp ne i32 %.606, 93
  br i1 %.607, label %.601, label %.602
.601:
  ret i32 0 
.602:
  %.610 = load i32, i32* @.g.pos
  %.611 = add i32 %.610, 1
  store i32 %.611, i32* @.g.pos
  br label %.613 
.613:
  br label %.518 
.615:
  %.620 = load i32, i32* @.g.pos
  %.621 = add i32 %.620, 1
  store i32 %.621, i32* @.g.pos
  %.623 = load i32*, i32** %.112
  %.624 = load i32, i32* %.115
  call void @skip_space(i32* %.623, i32 %.624)
  %.628 = load i32, i32* @.g.pos
  %.629 = load i32, i32* %.115
  %.630 = icmp slt i32 %.628, %.629
  br i1 %.630, label %.626, label %.627
.616:
  %.780 = load i32, i32* %.109
  %.781 = icmp eq i32 %.780, 5
  br i1 %.781, label %.778, label %.779
.626:
  %.634 = load i32, i32* @.g.pos
  %.635 = load i32*, i32** %.112
  %.636 = getelementptr inbounds i32, i32* %.635, i32 %.634
  %.637 = load i32, i32* %.636
  %.639 = icmp eq i32 %.637, 125
  br i1 %.639, label %.632, label %.633
.627:
  %.648 = load i32*, i32** %.112
  %.649 = load i32, i32* %.115
  %.650at234 = call i32 @detect_item(i32 2, i32* %.648, i32 %.649)
  %.651 = icmp eq i32 %.650at234, 0
  br i1 %.651, label %.646, label %.647
.632:
  %.641 = load i32, i32* @.g.pos
  %.642 = add i32 %.641, 1
  store i32 %.642, i32* @.g.pos
  ret i32 1 
.633:
  br label %.627 
.646:
  ret i32 0 
.647:
  %.654 = load i32*, i32** %.112
  %.655 = load i32, i32* %.115
  call void @skip_space(i32* %.654, i32 %.655)
  %.659 = load i32, i32* @.g.pos
  %.660 = load i32, i32* %.115
  %.661 = icmp sge i32 %.659, %.660
  br i1 %.661, label %.657, label %.658
.657:
  ret i32 0 
.658:
  %.666 = load i32, i32* @.g.pos
  %.667 = load i32*, i32** %.112
  %.668 = getelementptr inbounds i32, i32* %.667, i32 %.666
  %.669 = load i32, i32* %.668
  %.671 = icmp ne i32 %.669, 58
  br i1 %.671, label %.664, label %.665
.664:
  ret i32 0 
.665:
  %.674 = load i32, i32* @.g.pos
  %.675 = add i32 %.674, 1
  store i32 %.675, i32* @.g.pos
  %.677 = load i32*, i32** %.112
  %.678 = load i32, i32* %.115
  call void @skip_space(i32* %.677, i32 %.678)
  %.682 = load i32*, i32** %.112
  %.683 = load i32, i32* %.115
  %.684at250 = call i32 @detect_item(i32 0, i32* %.682, i32 %.683)
  %.685 = icmp eq i32 %.684at250, 0
  br i1 %.685, label %.680, label %.681
.680:
  ret i32 0 
.681:
  %.688 = load i32*, i32** %.112
  %.689 = load i32, i32* %.115
  call void @skip_space(i32* %.688, i32 %.689)
  br label %.691wc256 
.691wc256:
  %.695 = load i32, i32* @.g.pos
  %.696 = load i32*, i32** %.112
  %.697 = getelementptr inbounds i32, i32* %.696, i32 %.695
  %.698 = load i32, i32* %.697
  %.699 = icmp eq i32 %.698, 44
  br i1 %.699, label %.692wloop.256.283, label %.693wn283
.692wloop.256.283:
  %.701 = load i32, i32* @.g.pos
  %.702 = add i32 %.701, 1
  store i32 %.702, i32* @.g.pos
  %.704 = load i32*, i32** %.112
  %.705 = load i32, i32* %.115
  call void @skip_space(i32* %.704, i32 %.705)
  %.709 = load i32*, i32** %.112
  %.710 = load i32, i32* %.115
  %.711at262 = call i32 @detect_item(i32 2, i32* %.709, i32 %.710)
  %.712 = icmp eq i32 %.711at262, 0
  br i1 %.712, label %.707, label %.708
.693wn283:
  %.752 = load i32*, i32** %.112
  %.753 = load i32, i32* %.115
  call void @skip_space(i32* %.752, i32 %.753)
  %.757 = load i32, i32* @.g.pos
  %.758 = load i32, i32* %.115
  %.759 = icmp sge i32 %.757, %.758
  br i1 %.759, label %.755, label %.756
.707:
  ret i32 0 
.708:
  %.715 = load i32*, i32** %.112
  %.716 = load i32, i32* %.115
  call void @skip_space(i32* %.715, i32 %.716)
  %.720 = load i32, i32* @.g.pos
  %.721 = load i32, i32* %.115
  %.722 = icmp sge i32 %.720, %.721
  br i1 %.722, label %.718, label %.719
.718:
  ret i32 0 
.719:
  %.727 = load i32, i32* @.g.pos
  %.728 = load i32*, i32** %.112
  %.729 = getelementptr inbounds i32, i32* %.728, i32 %.727
  %.730 = load i32, i32* %.729
  %.731 = icmp ne i32 %.730, 58
  br i1 %.731, label %.725, label %.726
.725:
  ret i32 0 
.726:
  %.734 = load i32, i32* @.g.pos
  %.735 = add i32 %.734, 1
  store i32 %.735, i32* @.g.pos
  %.737 = load i32*, i32** %.112
  %.738 = load i32, i32* %.115
  call void @skip_space(i32* %.737, i32 %.738)
  %.742 = load i32*, i32** %.112
  %.743 = load i32, i32* %.115
  %.744at278 = call i32 @detect_item(i32 0, i32* %.742, i32 %.743)
  %.745 = icmp eq i32 %.744at278, 0
  br i1 %.745, label %.740, label %.741
.740:
  ret i32 0 
.741:
  %.748 = load i32*, i32** %.112
  %.749 = load i32, i32* %.115
  call void @skip_space(i32* %.748, i32 %.749)
  br label %.691wc256 
.755:
  ret i32 0 
.756:
  %.764 = load i32, i32* @.g.pos
  %.765 = load i32*, i32** %.112
  %.766 = getelementptr inbounds i32, i32* %.765, i32 %.764
  %.767 = load i32, i32* %.766
  %.768 = icmp ne i32 %.767, 125
  br i1 %.768, label %.762, label %.763
.762:
  ret i32 0 
.763:
  br label %.771 
.771:
  %.773 = load i32, i32* @.g.pos
  %.774 = add i32 %.773, 1
  store i32 %.774, i32* @.g.pos
  br label %.776 
.776:
  br label %.613 
.778:
  call void @llvm.memcpy.p0.p0.i32([4 x i32]* %.783, [4 x i32]* @__constant..787, i32 16, i1 false)
  %.793 = load i32, i32* @.g.pos
  %.794 = add i32 %.793, 3
  %.795 = load i32, i32* %.115
  %.796 = icmp sge i32 %.794, %.795
  br i1 %.796, label %.791, label %.792
.779:
  %.861 = load i32, i32* %.109
  %.862 = icmp eq i32 %.861, 6
  br i1 %.862, label %.859, label %.860
.791:
  ret i32 0 
.792:
  %.801 = load i32, i32* @.g.pos
  %.802 = load i32*, i32** %.112
  %.803 = getelementptr inbounds i32, i32* %.802, i32 %.801
  %.804 = load i32, i32* %.803
  %.805 = getelementptr inbounds [4 x i32], [4 x i32]* %.783, i32 0, i32 0
  %.806 = load i32, i32* %.805
  %.807 = icmp ne i32 %.804, %.806
  br i1 %.807, label %.799, label %.800
.799:
  ret i32 0 
.800:
  %.812 = load i32, i32* @.g.pos
  %.813 = add i32 %.812, 1
  %.814 = load i32*, i32** %.112
  %.815 = getelementptr inbounds i32, i32* %.814, i32 %.813
  %.816 = load i32, i32* %.815
  %.817 = getelementptr inbounds [4 x i32], [4 x i32]* %.783, i32 0, i32 1
  %.818 = load i32, i32* %.817
  %.819 = icmp ne i32 %.816, %.818
  br i1 %.819, label %.810, label %.811
.810:
  ret i32 0 
.811:
  %.824 = load i32, i32* @.g.pos
  %.825 = add i32 %.824, 2
  %.826 = load i32*, i32** %.112
  %.827 = getelementptr inbounds i32, i32* %.826, i32 %.825
  %.828 = load i32, i32* %.827
  %.829 = getelementptr inbounds [4 x i32], [4 x i32]* %.783, i32 0, i32 2
  %.830 = load i32, i32* %.829
  %.831 = icmp ne i32 %.828, %.830
  br i1 %.831, label %.822, label %.823
.822:
  ret i32 0 
.823:
  %.836 = load i32, i32* @.g.pos
  %.837 = add i32 %.836, 3
  %.838 = load i32*, i32** %.112
  %.839 = getelementptr inbounds i32, i32* %.838, i32 %.837
  %.840 = load i32, i32* %.839
  %.841 = getelementptr inbounds [4 x i32], [4 x i32]* %.783, i32 0, i32 3
  %.842 = load i32, i32* %.841
  %.843 = icmp ne i32 %.840, %.842
  br i1 %.843, label %.834, label %.835
.834:
  ret i32 0 
.835:
  br label %.846 
.846:
  br label %.848 
.848:
  br label %.850 
.850:
  br label %.852 
.852:
  %.854 = load i32, i32* @.g.pos
  %.855 = add i32 %.854, 4
  store i32 %.855, i32* @.g.pos
  br label %.857 
.857:
  br label %.776 
.859:
  call void @llvm.memcpy.p0.p0.i32([5 x i32]* %.864, [5 x i32]* @__constant..869, i32 20, i1 false)
  %.874 = load i32, i32* @.g.pos
  %.875 = add i32 %.874, 4
  %.876 = load i32, i32* %.115
  %.877 = icmp sge i32 %.875, %.876
  br i1 %.877, label %.872, label %.873
.860:
  %.956 = load i32, i32* %.109
  %.957 = icmp eq i32 %.956, 7
  br i1 %.957, label %.954, label %.955
.872:
  ret i32 0 
.873:
  %.882 = load i32, i32* @.g.pos
  %.883 = load i32*, i32** %.112
  %.884 = getelementptr inbounds i32, i32* %.883, i32 %.882
  %.885 = load i32, i32* %.884
  %.886 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 0
  %.887 = load i32, i32* %.886
  %.888 = icmp ne i32 %.885, %.887
  br i1 %.888, label %.880, label %.881
.880:
  ret i32 0 
.881:
  %.893 = load i32, i32* @.g.pos
  %.894 = add i32 %.893, 1
  %.895 = load i32*, i32** %.112
  %.896 = getelementptr inbounds i32, i32* %.895, i32 %.894
  %.897 = load i32, i32* %.896
  %.898 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 1
  %.899 = load i32, i32* %.898
  %.900 = icmp ne i32 %.897, %.899
  br i1 %.900, label %.891, label %.892
.891:
  ret i32 0 
.892:
  %.905 = load i32, i32* @.g.pos
  %.906 = add i32 %.905, 2
  %.907 = load i32*, i32** %.112
  %.908 = getelementptr inbounds i32, i32* %.907, i32 %.906
  %.909 = load i32, i32* %.908
  %.910 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 2
  %.911 = load i32, i32* %.910
  %.912 = icmp ne i32 %.909, %.911
  br i1 %.912, label %.903, label %.904
.903:
  ret i32 0 
.904:
  %.917 = load i32, i32* @.g.pos
  %.918 = add i32 %.917, 3
  %.919 = load i32*, i32** %.112
  %.920 = getelementptr inbounds i32, i32* %.919, i32 %.918
  %.921 = load i32, i32* %.920
  %.922 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 3
  %.923 = load i32, i32* %.922
  %.924 = icmp ne i32 %.921, %.923
  br i1 %.924, label %.915, label %.916
.915:
  ret i32 0 
.916:
  %.929 = load i32, i32* @.g.pos
  %.930 = add i32 %.929, 4
  %.931 = load i32*, i32** %.112
  %.932 = getelementptr inbounds i32, i32* %.931, i32 %.930
  %.933 = load i32, i32* %.932
  %.934 = getelementptr inbounds [5 x i32], [5 x i32]* %.864, i32 0, i32 4
  %.935 = load i32, i32* %.934
  %.936 = icmp ne i32 %.933, %.935
  br i1 %.936, label %.927, label %.928
.927:
  ret i32 0 
.928:
  br label %.939 
.939:
  br label %.941 
.941:
  br label %.943 
.943:
  br label %.945 
.945:
  br label %.947 
.947:
  %.949 = load i32, i32* @.g.pos
  %.950 = add i32 %.949, 5
  store i32 %.950, i32* @.g.pos
  br label %.952 
.952:
  br label %.857 
.954:
  call void @llvm.memcpy.p0.p0.i32([4 x i32]* %.959, [4 x i32]* @__constant..961, i32 16, i1 false)
  %.965 = load i32, i32* @.g.pos
  %.966 = add i32 %.965, 3
  %.967 = load i32, i32* %.115
  %.968 = icmp sge i32 %.966, %.967
  br i1 %.968, label %.963, label %.964
.955:
  ret i32 0 
.963:
  ret i32 0 
.964:
  %.973 = load i32, i32* @.g.pos
  %.974 = load i32*, i32** %.112
  %.975 = getelementptr inbounds i32, i32* %.974, i32 %.973
  %.976 = load i32, i32* %.975
  %.977 = getelementptr inbounds [4 x i32], [4 x i32]* %.959, i32 0, i32 0
  %.978 = load i32, i32* %.977
  %.979 = icmp ne i32 %.976, %.978
  br i1 %.979, label %.971, label %.972
.971:
  ret i32 0 
.972:
  %.984 = load i32, i32* @.g.pos
  %.985 = add i32 %.984, 1
  %.986 = load i32*, i32** %.112
  %.987 = getelementptr inbounds i32, i32* %.986, i32 %.985
  %.988 = load i32, i32* %.987
  %.989 = getelementptr inbounds [4 x i32], [4 x i32]* %.959, i32 0, i32 1
  %.990 = load i32, i32* %.989
  %.991 = icmp ne i32 %.988, %.990
  br i1 %.991, label %.982, label %.983
.982:
  ret i32 0 
.983:
  %.996 = load i32, i32* @.g.pos
  %.997 = add i32 %.996, 2
  %.998 = load i32*, i32** %.112
  %.999 = getelementptr inbounds i32, i32* %.998, i32 %.997
  %.1000 = load i32, i32* %.999
  %.1001 = getelementptr inbounds [4 x i32], [4 x i32]* %.959, i32 0, i32 2
  %.1002 = load i32, i32* %.1001
  %.1003 = icmp ne i32 %.1000, %.1002
  br i1 %.1003, label %.994, label %.995
.994:
  ret i32 0 
.995:
  %.1008 = load i32, i32* @.g.pos
  %.1009 = add i32 %.1008, 3
  %.1010 = load i32*, i32** %.112
  %.1011 = getelementptr inbounds i32, i32* %.1010, i32 %.1009
  %.1012 = load i32, i32* %.1011
  %.1013 = getelementptr inbounds [4 x i32], [4 x i32]* %.959, i32 0, i32 3
  %.1014 = load i32, i32* %.1013
  %.1015 = icmp ne i32 %.1012, %.1014
  br i1 %.1015, label %.1006, label %.1007
.1006:
  ret i32 0 
.1007:
  br label %.1018 
.1018:
  br label %.1020 
.1020:
  br label %.1022 
.1022:
  br label %.1024 
.1024:
  %.1026 = load i32, i32* @.g.pos
  %.1027 = add i32 %.1026, 4
  store i32 %.1027, i32* @.g.pos
  br label %.1029 
.1029:
  br label %.952 
.1038:
  ret i32 1 
}
define i32 @main(){
.1045:
  %.1073 = alloca i32
  %.1050 = alloca i32
  %.1046 = alloca i32
  %.1048at358 = call i32 @getch()
  store i32 %.1048at358, i32* %.1046
  store i32 0, i32* %.1050
  br label %.1052wc360 
.1052wc360:
  %.1056 = load i32, i32* %.1046
  %.1058 = icmp ne i32 %.1056, 35
  br i1 %.1058, label %.1053wloop.360.364, label %.1054wn364
.1053wloop.360.364:
  %.1060 = load i32, i32* %.1046
  %.1061 = load i32, i32* %.1050
  %.1062 = getelementptr inbounds [50000000 x i32], [50000000 x i32]* @.g.buffer, i32 0, i32 %.1061
  store i32 %.1060, i32* %.1062
  %.1064 = load i32, i32* %.1050
  %.1065 = add i32 %.1064, 1
  store i32 %.1065, i32* %.1050
  %.1067at363 = call i32 @getch()
  store i32 %.1067at363, i32* %.1046
  br label %.1052wc360 
.1054wn364:
  %.1070 = getelementptr inbounds [50000000 x i32], [50000000 x i32]* @.g.buffer, i32 0, i32 0
  %.1071 = load i32, i32* %.1050
  call void @skip_space(i32* %.1070, i32 %.1071)
  %.1074 = getelementptr inbounds [50000000 x i32], [50000000 x i32]* @.g.buffer, i32 0, i32 0
  %.1075 = load i32, i32* %.1050
  %.1076at366 = call i32 @detect_item(i32 0, i32* %.1074, i32 %.1075)
  store i32 %.1076at366, i32* %.1073
  %.1078 = getelementptr inbounds [50000000 x i32], [50000000 x i32]* @.g.buffer, i32 0, i32 0
  %.1079 = load i32, i32* %.1050
  call void @skip_space(i32* %.1078, i32 %.1079)
  %.1083 = load i32, i32* %.1073
  %.1084 = icmp ne i32 %.1083, 0
  br i1 %.10