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
@.g.sum = global i32 0
@.g.array = global [20 x i32] zeroinitializer
define i32 @f(i32 %.7, i32 %.10){
.5:
  %.9 = alloca i32
  %.6 = alloca i32
  store i32 %.7, i32* %.6
  store i32 %.10, i32* %.9
  %.12 = load i32, i32* @.g.sum
  %.14 = add i32 %.12, 1
  store i32 %.14, i32* @.g.sum
  %.19 = load i32, i32* %.6
  %.20 = load i32, i32* %.9
  %.21 = icmp sge i32 %.19, %.20
  br i1 %.21, label %.16, label %.18
.16:
  ret i32 0 
.17:
  %.27 = load i32, i32* %.6
  %.28 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.27
  store i32 1, i32* %.28
  %.32 = load i32, i32* %.6
  %.33 = icmp eq i32 %.32, 0
  br i1 %.33, label %.30, label %.31
.18:
  %.23 = load i32, i32* %.6
  %.24 = icmp sge i32 %.23, 20
  br i1 %.24, label %.16, label %.17
.30:
  %.35 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 0
  %.36 = load i32, i32* %.35
  ret i32 %.36 
.31:
  %.38 = load i32, i32* %.6
  %.39 = sub i32 %.38, 1
  %.40 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.39
  %.41 = load i32, i32* %.40
  ret i32 %.41 
}
define i32 @g(i32 %.46, i32 %.49){
.44:
  %.48 = alloca i32
  %.45 = alloca i32
  store i32 %.46, i32* %.45
  store i32 %.49, i32* %.48
  %.51 = load i32, i32* @.g.sum
  %.53 = add i32 %.51, 2
  store i32 %.53, i32* @.g.sum
  %.58 = load i32, i32* %.45
  %.59 = load i32, i32* %.48
  %.60 = icmp sge i32 %.58, %.59
  br i1 %.60, label %.55, label %.57
.55:
  ret i32 1 
.56:
  %.66 = load i32, i32* %.45
  %.67 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.66
  store i32 0, i32* %.67
  %.71 = load i32, i32* %.45
  %.72 = icmp eq i32 %.71, 0
  br i1 %.72, label %.69, label %.70
.57:
  %.62 = load i32, i32* %.45
  %.63 = icmp sge i32 %.62, 20
  br i1 %.63, label %.55, label %.56
.69:
  %.74 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 0
  %.75 = load i32, i32* %.74
  ret i32 %.75 
.70:
  %.77 = load i32, i32* %.45
  %.78 = sub i32 %.77, 1
  %.79 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.78
  %.80 = load i32, i32* %.79
  ret i32 %.80 
}
define i32 @h(i32 %.85){
.83:
  %.84 = alloca i32
  store i32 %.85, i32* %.84
  %.87 = load i32, i32* @.g.sum
  %.89 = add i32 %.87, 3
  store i32 %.89, i32* @.g.sum
  %.94 = load i32, i32* %.84
  %.95 = icmp slt i32 %.94, 0
  br i1 %.95, label %.91, label %.93
.91:
  ret i32 0 
.92:
  %.101 = load i32, i32* %.84
  %.102 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.101
  %.103 = load i32, i32* %.102
  ret i32 %.103 
.93:
  %.97 = load i32, i32* %.84
  %.98 = icmp sge i32 %.97, 20
  br i1 %.98, label %.91, label %.92
}
define i32 @main(){
.106:
  %.371 = alloca i32
  %.107 = alloca i32
  store i32 0, i32* %.107
  br label %.109wc28 
.109wc28:
  %.113 = load i32, i32* %.107
  %.114 = icmp slt i32 %.113, 20
  br i1 %.114, label %.110wloop.28.34, label %.111wn34
.110wloop.28.34:
  %.118 = load i32, i32* %.107
  %.119at29 = call i32 @f(i32 0, i32 %.118)
  %.120 = icmp ne i32 %.119at29, 0
  br i1 %.120, label %.121, label %.117
.111wn34:
  store i32 0, i32* %.107
  br label %.239wc36 
.116:
  br label %.117 
.117:
  %.234 = load i32, i32* %.107
  %.235 = add i32 %.234, 1
  store i32 %.235, i32* %.107
  br label %.109wc28 
.121:
  %.123 = load i32, i32* %.107
  %.124at29 = call i32 @f(i32 1, i32 %.123)
  %.125 = icmp ne i32 %.124at29, 0
  br i1 %.125, label %.126, label %.117
.126:
  %.128 = load i32, i32* %.107
  %.129at29 = call i32 @f(i32 2, i32 %.128)
  %.130 = icmp ne i32 %.129at29, 0
  br i1 %.130, label %.131, label %.117
.131:
  %.133 = load i32, i32* %.107
  %.134at29 = call i32 @f(i32 3, i32 %.133)
  %.135 = icmp ne i32 %.134at29, 0
  br i1 %.135, label %.136, label %.117
.136:
  %.139 = load i32, i32* %.107
  %.140at29 = call i32 @f(i32 4, i32 %.139)
  %.141 = icmp ne i32 %.140at29, 0
  br i1 %.141, label %.142, label %.117
.142:
  %.145 = load i32, i32* %.107
  %.146at29 = call i32 @f(i32 5, i32 %.145)
  %.147 = icmp ne i32 %.146at29, 0
  br i1 %.147, label %.148, label %.117
.148:
  %.151 = load i32, i32* %.107
  %.152at30 = call i32 @f(i32 6, i32 %.151)
  %.153 = icmp ne i32 %.152at30, 0
  br i1 %.153, label %.154, label %.117
.154:
  %.157 = load i32, i32* %.107
  %.158at30 = call i32 @f(i32 7, i32 %.157)
  %.159 = icmp ne i32 %.158at30, 0
  br i1 %.159, label %.160, label %.117
.160:
  %.163 = load i32, i32* %.107
  %.164at30 = call i32 @f(i32 8, i32 %.163)
  %.165 = icmp ne i32 %.164at30, 0
  br i1 %.165, label %.166, label %.117
.166:
  %.169 = load i32, i32* %.107
  %.170at30 = call i32 @f(i32 9, i32 %.169)
  %.171 = icmp ne i32 %.170at30, 0
  br i1 %.171, label %.172, label %.117
.172:
  %.175 = load i32, i32* %.107
  %.176at30 = call i32 @f(i32 10, i32 %.175)
  %.177 = icmp ne i32 %.176at30, 0
  br i1 %.177, label %.178, label %.117
.178:
  %.181 = load i32, i32* %.107
  %.182at30 = call i32 @f(i32 11, i32 %.181)
  %.183 = icmp ne i32 %.182at30, 0
  br i1 %.183, label %.184, label %.117
.184:
  %.187 = load i32, i32* %.107
  %.188at31 = call i32 @f(i32 12, i32 %.187)
  %.189 = icmp ne i32 %.188at31, 0
  br i1 %.189, label %.190, label %.117
.190:
  %.193 = load i32, i32* %.107
  %.194at31 = call i32 @f(i32 13, i32 %.193)
  %.195 = icmp ne i32 %.194at31, 0
  br i1 %.195, label %.196, label %.117
.196:
  %.199 = load i32, i32* %.107
  %.200at31 = call i32 @f(i32 14, i32 %.199)
  %.201 = icmp ne i32 %.200at31, 0
  br i1 %.201, label %.202, label %.117
.202:
  %.205 = load i32, i32* %.107
  %.206at31 = call i32 @f(i32 15, i32 %.205)
  %.207 = icmp ne i32 %.206at31, 0
  br i1 %.207, label %.208, label %.117
.208:
  %.211 = load i32, i32* %.107
  %.212at31 = call i32 @f(i32 16, i32 %.211)
  %.213 = icmp ne i32 %.212at31, 0
  br i1 %.213, label %.214, label %.117
.214:
  %.217 = load i32, i32* %.107
  %.218at31 = call i32 @f(i32 17, i32 %.217)
  %.219 = icmp ne i32 %.218at31, 0
  br i1 %.219, label %.220, label %.117
.220:
  %.223 = load i32, i32* %.107
  %.224at32 = call i32 @f(i32 18, i32 %.223)
  %.225 = icmp ne i32 %.224at32, 0
  br i1 %.225, label %.226, label %.117
.226:
  %.229 = load i32, i32* %.107
  %.230at32 = call i32 @f(i32 19, i32 %.229)
  %.231 = icmp ne i32 %.230at32, 0
  br i1 %.231, label %.116, label %.117
.239wc36:
  %.243 = load i32, i32* %.107
  %.244 = icmp slt i32 %.243, 20
  br i1 %.244, label %.240wloop.36.42, label %.241wn42
.240wloop.36.42:
  %.249 = load i32, i32* %.107
  %.250at37 = call i32 @g(i32 0, i32 %.249)
  %.251 = icmp ne i32 %.250at37, 0
  br i1 %.251, label %.246, label %.248
.241wn42:
  store i32 1, i32* %.107
  br label %.353wc44 
.246:
  br label %.247 
.247:
  %.348 = load i32, i32* %.107
  %.349 = add i32 %.348, 1
  store i32 %.349, i32* %.107
  br label %.239wc36 
.248:
  %.254 = load i32, i32* %.107
  %.255at37 = call i32 @g(i32 1, i32 %.254)
  %.256 = icmp ne i32 %.255at37, 0
  br i1 %.256, label %.246, label %.253
.253:
  %.259 = load i32, i32* %.107
  %.260at37 = call i32 @g(i32 2, i32 %.259)
  %.261 = icmp ne i32 %.260at37, 0
  br i1 %.261, label %.246, label %.258
.258:
  %.264 = load i32, i32* %.107
  %.265at37 = call i32 @g(i32 3, i32 %.264)
  %.266 = icmp ne i32 %.265at37, 0
  br i1 %.266, label %.246, label %.263
.263:
  %.269 = load i32, i32* %.107
  %.270at37 = call i32 @g(i32 4, i32 %.269)
  %.271 = icmp ne i32 %.270at37, 0
  br i1 %.271, label %.246, label %.268
.268:
  %.274 = load i32, i32* %.107
  %.275at37 = call i32 @g(i32 5, i32 %.274)
  %.276 = icmp ne i32 %.275at37, 0
  br i1 %.276, label %.246, label %.273
.273:
  %.279 = load i32, i32* %.107
  %.280at38 = call i32 @g(i32 6, i32 %.279)
  %.281 = icmp ne i32 %.280at38, 0
  br i1 %.281, label %.246, label %.278
.278:
  %.284 = load i32, i32* %.107
  %.285at38 = call i32 @g(i32 7, i32 %.284)
  %.286 = icmp ne i32 %.285at38, 0
  br i1 %.286, label %.246, label %.283
.283:
  %.289 = load i32, i32* %.107
  %.290at38 = call i32 @g(i32 8, i32 %.289)
  %.291 = icmp ne i32 %.290at38, 0
  br i1 %.291, label %.246, label %.288
.288:
  %.294 = load i32, i32* %.107
  %.295at38 = call i32 @g(i32 9, i32 %.294)
  %.296 = icmp ne i32 %.295at38, 0
  br i1 %.296, label %.246, label %.293
.293:
  %.299 = load i32, i32* %.107
  %.300at38 = call i32 @g(i32 10, i32 %.299)
  %.301 = icmp ne i32 %.300at38, 0
  br i1 %.301, label %.246, label %.298
.298:
  %.304 = load i32, i32* %.107
  %.305at38 = call i32 @g(i32 11, i32 %.304)
  %.306 = icmp ne i32 %.305at38, 0
  br i1 %.306, label %.246, label %.303
.303:
  %.309 = load i32, i32* %.107
  %.310at39 = call i32 @g(i32 12, i32 %.309)
  %.311 = icmp ne i32 %.310at39, 0
  br i1 %.311, label %.246, label %.308
.308:
  %.314 = load i32, i32* %.107
  %.315at39 = call i32 @g(i32 13, i32 %.314)
  %.316 = icmp ne i32 %.315at39, 0
  br i1 %.316, label %.246, label %.313
.313:
  %.319 = load i32, i32* %.107
  %.320at39 = call i32 @g(i32 14, i32 %.319)
  %.321 = icmp ne i32 %.320at39, 0
  br i1 %.321, label %.246, label %.318
.318:
  %.324 = load i32, i32* %.107
  %.325at39 = call i32 @g(i32 15, i32 %.324)
  %.326 = icmp ne i32 %.325at39, 0
  br i1 %.326, label %.246, label %.323
.323:
  %.329 = load i32, i32* %.107
  %.330at39 = call i32 @g(i32 16, i32 %.329)
  %.331 = icmp ne i32 %.330at39, 0
  br i1 %.331, label %.246, label %.328
.328:
  %.334 = load i32, i32* %.107
  %.335at39 = call i32 @g(i32 17, i32 %.334)
  %.336 = icmp ne i32 %.335at39, 0
  br i1 %.336, label %.246, label %.333
.333:
  %.339 = load i32, i32* %.107
  %.340at40 = call i32 @g(i32 18, i32 %.339)
  %.341 = icmp ne i32 %.340at40, 0
  br i1 %.341, label %.246, label %.338
.338:
  %.343 = load i32, i32* %.107
  %.344at40 = call i32 @g(i32 19, i32 %.343)
  %.345 = icmp ne i32 %.344at40, 0
  br i1 %.345, label %.246, label %.247
.353wc44:
  %.357 = load i32, i32* %.107
  %.358 = icmp slt i32 %.357, 20
  br i1 %.358, label %.359, label %.355wn45
.354wloop.44.45:
  %.367 = load i32, i32* %.107
  %.368 = add i32 %.367, 1
  store i32 %.368, i32* %.107
  br label %.353wc44 
.355wn45:
  store i32 0, i32* %.371
  %.376at49 = call i32 @h(i32 0)
  %.377 = icmp ne i32 %.376at49, 0
  br i1 %.377, label %.378, label %.375
.359:
  %.361 = load i32, i32* %.107
  %.362 = sub i32 %.361, 1
  %.363 = load i32, i32* %.107
  %.364at44 = call i32 @f(i32 %.362, i32 %.363)
  %.365 = icmp ne i32 %.364at44, 0
  br i1 %.365, label %.354wloop.44.45, label %.355wn45
.373:
  store i32 1, i32* %.371
  br label %.374 
.374:
  %.392 = load i32, i32* @.g.sum
  %.393 = load i32, i32* %.371
  %.394 = add i32 %.392, %.393
  store i32 0, i32* %.371
  %.399at52 = call i32 @h(i32 4)
  %.400 = icmp eq i32 %.399at52, 0
  br i1 %.400, label %.396, label %.398
.375:
  %.384at49 = call i32 @h(i32 2)
  %.385 = icmp eq i32 %.384at49, 0
  br i1 %.385, label %.373, label %.383
.378:
  %.380at49 = call i32 @h(i32 1)
  %.381 = icmp ne i32 %.380at49, 0
  br i1 %.381, label %.373, label %.375
.383:
  %.387at49 = call i32 @h(i32 3)
  %.388 = icmp ne i32 %.387at49, 0
  br i1 %.388, label %.373, label %.374
.396:
  store i32 1, i32* %.371
  br label %.397 
.397:
  %.419 = load i32, i32* @.g.sum
  %.420 = load i32, i32* %.371
  %.421 = mul i32 %.419, %.420
  store i32 0, i32* %.371
  %.426at55 = call i32 @h(i32 9)
  %.427 = icmp ne i32 %.426at55, 0
  br i1 %.427, label %.428, label %.425
.398:
  %.403at52 = call i32 @h(i32 5)
  %.404 = icmp ne i32 %.403at52, 0
  br i1 %.404, label %.405, label %.402
.402:
  %.414at52 = call i32 @h(i32 8)
  %.415 = icmp eq i32 %.414at52, 0
  br i1 %.415, label %.396, label %.397
.405:
  %.407at52 = call i32 @h(i32 6)
  %.408 = icmp eq i32 %.407at52, 0
  br i1 %.408, label %.409, label %.402
.409:
  %.411at52 = call i32 @h(i32 7)
  %.412 = icmp ne i32 %.411at52, 0
  br i1 %.412, label %.396, label %.402
.423:
  store i32 1, i32* %.371
  br label %.424 
.424:
  %.454 = load i32, i32* @.g.sum
  %.455 = load i32, i32* %.371
  %.456 = sub i32 %.454, %.455
  store i32 0, i32* %.371
  %.461at58 = call i32 @h(i32 0)
  %.462 = icmp ne i32 %.461at58, 0
  br i1 %.462, label %.463, label %.460
.425:
  %.434at55 = call i32 @h(i32 11)
  %.435 = icmp eq i32 %.434at55, 0
  br i1 %.435, label %.423, label %.433
.428:
  %.430at55 = call i32 @h(i32 10)
  %.431 = icmp eq i32 %.430at55, 0
  br i1 %.431, label %.423, label %.425
.433:
  %.438at55 = call i32 @h(i32 12)
  %.439 = icmp eq i32 %.438at55, 0
  br i1 %.439, label %.423, label %.437
.437:
  %.442at55 = call i32 @h(i32 13)
  %.443 = icmp eq i32 %.442at55, 0
  br i1 %.443, label %.423, label %.441
.441:
  %.445at55 = call i32 @h(i32 14)
  %.446 = icmp ne i32 %.445at55, 0
  br i1 %.446, label %.447, label %.424
.447:
  %.449at55 = call i32 @h(i32 15)
  %.450 = icmp ne i32 %.449at55, 0
  br i1 %.450, label %.423, label %.424
.458:
  store i32 1, i32* %.371
  br label %.459 
.459:
  %.493 = load i32, i32* @.g.sum
  %.494 = load i32, i32* %.371
  %.495 = add i32 %.493, %.494
  call void @putint(i32 %.495)
  ret i32 0 
.460:
  %.477at58 = call i32 @h(i32 5)
  %.478 = icmp ne i32 %.477at58, 0
  br i1 %.478, label %.458, label %.476
.463:
  %.465at58 = call i32 @h(i32 2)
  %.466 = icmp ne i32 %.465at58, 0
  br i1 %.466, label %.467, label %.460
.467:
  %.469at58 = call i32 @h(i32 3)
  %.470 = icmp eq i32 %.469at58, 0
  br i1 %.470, label %.471, label %.460
.471:
  %.473at58 = call i32 @h(i32 4)
  %.474 = icmp eq i32 %.473at58, 0
  br i1 %.474, label %.458, label %.460
.476:
  %.481at58 = call i32 @h(i32 6)
  %.482 = icmp ne i32 %.481at58, 0
  br i1 %.482, label %.483, label %.480
.480:
  %.488at58 = call i32 @h(i32 8)
  %.489 = icmp ne i32 %.488at58, 0
  br i1 %.489, label %.458, label %.459
.483:
  %.485at58 = call i32 @h(i32 7)
  %.486 = icmp eq i32 %.485at58, 0
  br i1 %.486, label %.458, label %.480
}
@.g.sum = global i32 0
@.g.array = global [20 x i32] zeroinitializer
define i32 @f(i32 %.7, i32 %.10){
.5:
  %.9 = alloca i32
  %.6 = alloca i32
  store i32 %.7, i32* %.6
  store i32 %.10, i32* %.9
  %.12 = load i32, i32* @.g.sum
  %.14 = add i32 %.12, 1
  store i32 %.14, i32* @.g.sum
  %.19 = load i32, i32* %.6
  %.20 = load i32, i32* %.9
  %.21 = icmp sge i32 %.19, %.20
  br i1 %.21, label %.16, label %.18
.16:
  ret i32 0 
.17:
  %.27 = load i32, i32* %.6
  %.28 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.27
  store i32 1, i32* %.28
  %.32 = load i32, i32* %.6
  %.33 = icmp eq i32 %.32, 0
  br i1 %.33, label %.30, label %.31
.18:
  %.23 = load i32, i32* %.6
  %.24 = icmp sge i32 %.23, 20
  br i1 %.24, label %.16, label %.17
.30:
  %.35 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 0
  %.36 = load i32, i32* %.35
  ret i32 %.36 
.31:
  %.38 = load i32, i32* %.6
  %.39 = sub i32 %.38, 1
  %.40 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.39
  %.41 = load i32, i32* %.40
  ret i32 %.41 
}
define i32 @g(i32 %.46, i32 %.49){
.44:
  %.48 = alloca i32
  %.45 = alloca i32
  store i32 %.46, i32* %.45
  store i32 %.49, i32* %.48
  %.51 = load i32, i32* @.g.sum
  %.53 = add i32 %.51, 2
  store i32 %.53, i32* @.g.sum
  %.58 = load i32, i32* %.45
  %.59 = load i32, i32* %.48
  %.60 = icmp sge i32 %.58, %.59
  br i1 %.60, label %.55, label %.57
.55:
  ret i32 1 
.56:
  %.66 = load i32, i32* %.45
  %.67 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.66
  store i32 0, i32* %.67
  %.71 = load i32, i32* %.45
  %.72 = icmp eq i32 %.71, 0
  br i1 %.72, label %.69, label %.70
.57:
  %.62 = load i32, i32* %.45
  %.63 = icmp sge i32 %.62, 20
  br i1 %.63, label %.55, label %.56
.69:
  %.74 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 0
  %.75 = load i32, i32* %.74
  ret i32 %.75 
.70:
  %.77 = load i32, i32* %.45
  %.78 = sub i32 %.77, 1
  %.79 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.78
  %.80 = load i32, i32* %.79
  ret i32 %.80 
}
define i32 @h(i32 %.85){
.83:
  %.84 = alloca i32
  store i32 %.85, i32* %.84
  %.87 = load i32, i32* @.g.sum
  %.89 = add i32 %.87, 3
  store i32 %.89, i32* @.g.sum
  %.94 = load i32, i32* %.84
  %.95 = icmp slt i32 %.94, 0
  br i1 %.95, label %.91, label %.93
.91:
  ret i32 0 
.92:
  %.101 = load i32, i32* %.84
  %.102 = getelementptr inbounds [20 x i32], [20 x i32]* @.g.array, i32 0, i32 %.101
  %.103 = load i32, i32* %.102
  ret i32 %.103 
.93:
  %.97 = load i32, i32* %.84
  %.98 = icmp sge i32 %.97, 20
  br i1 %.98, label %.91, label %.92
}
define i32 @main(){
.106:
  %.371 = alloca i32
  %.107 = alloca i32
  store i32 0, i32* %.107
  br label %.109wc28 
.109wc28:
  %.113 = load i32, i32* %.107
  %.114 = icmp slt i32 %.113, 20
  br i1 %.114, label %.110wloop.28.34, label %.111wn34
.110wloop.28.34:
  %.118 = load i32, i32* %.107
  %.119at29 = call i32 @f(i32 0, i32 %.118)
  %.120 = icmp ne i32 %.119at29, 0
  br i1 %.120, label %.121, label %.117
.111wn34:
  store i32 0, i32* %.107
  br label %.239wc36 
.116:
  br label %.117 
.117:
  %.234 = load i32, i32* %.107
  %.235 = add i32 %.234, 1
  store i32 %.235, i32* %.107
  br label %.109wc28 
.121:
  %.123 = load i32, i32* %.107
  %.124at29 = call i32 @f(i32 1, i32 %.123)
  %.125 = icmp ne i32 %.124at29, 0
  br i1 %.125, label %.126, label %.117
.126:
  %.128 = load i32, i32* %.107
  %.129at29 = call i32 @f(i32 2, i32 %.128)
  %.130 = icmp ne i32 %.129at29, 0
  br i1 %.130, label %.131, label %.117
.131:
  %.133 = load i32, i32* %.107
  %.134at29 = call i32 @f(i32 3, i32 %.133)
  %.135 = icmp ne i32 %.134at29, 0
  br i1 %.135, label %.136, label %.117
.136:
  %.139 = load i32, i32* %.107
  %.140at29 = call i32 @f(i32 4, i32 %.139)
  %.141 = icmp ne i32 %.140at29, 0
  br i1 %.141, label %.142, label %.117
.142:
  %.145 = load i32, i32* %.107
  %.146at29 = call i32 @f(i32 5, i32 %.145)
  %.147 = icmp ne i32 %.146at29, 0
  br i1 %.147, label %.148, label %.117
.148:
  %.151 = load i32, i32* %.107
  %.152at30 = call i32 @f(i32 6, i32 %.151)
  %.153 = icmp ne i32 %.152at30, 0
  br i1 %.153, label %.154, label %.117
.154:
  %.157 = load i32, i32* %.107
  %.158at30 = call i32 @f(i32 7, i32 %.157)
  %.159 = icmp ne i32 %.158at30, 0
  br i1 %.159, label %.160, label %.117
.160:
  %.163 = load i32, i32* %.107
  %.164at30 = call i32 @f(i32 8, i32 %.163)
  %.165 = icmp ne i32 %.164at30, 0
  br i1 %.165, label %.166, label %.117
.166:
  %.169 = load i32, i32* %.107
  %.170at30 = call i32 @f(i32 9, i32 %.169)
  %.171 = icmp ne i32 %.170at30, 0
  br i1 %.171, label %.172, label %.117
.172:
  %.175 = load i32, i32* %.107
  %.176at30 = call i32 @f(i32 10, i32 %.175)
  %.177 = icmp ne i32 %.176at30, 0
  br i1 %.177, label %.178, label %.117
.178:
  %.181 = load i32, i32* %.107
  %.182at30 = call i32 @f(i32 11, i32 %.181)
  %.183 = icmp ne i32 %.182at30, 0
  br i1 %.183, label %.184, label %.117
.184:
  %.187 = load i32, i32* %.107
  %.188at31 = call i32 @f(i32 12, i32 %.187)
  %.189 = icmp ne i32 %.188at31, 0
  br i1 %.189, label %.190, label %.117
.190:
  %.193 = load i32, i32* %.107
  %.194at31 = call i32 @f(i32 13, i32 %.193)
  %.195 = icmp ne i32 %.194at31, 0
  br i1 %.195, label %.196, label %.117
.196:
  %.199 = load i32, i32* %.107
  %.200at31 = call i32 @f(i32 14, i32 %.199)
  %.201 = icmp ne i32 %.200at31, 0
  br i1 %.201, label %.202, label %.117
.202:
  %.205 = load i32, i32* %.107
  %.206at31 = call i32 @f(i32 15, i32 %.205)
  %.207 = icmp ne i32 %.206at31, 0
  br i1 %.207, label %.208, label %.117
.208:
  %.211 = load i32, i32* %.107
  %.212at31 = call i32 @f(i32 16, i32 %.211)
  %.213 = icmp ne i32 %.212at31, 0
  br i1 %.213, label %.214, label %.117
.214:
  %.217 = load i32, i32* %.107
  %.218at31 = call i32 @f(i32 17, i32 %.217)
  %.219 = icmp ne i32 %.218at31, 0
  br i1 %.219, label %.220, label %.117
.220:
  %.223 = load i32, i32* %.107
  %.224at32 = call i32 @f(i32 18, i32 %.223)
  %.225 = icmp ne i32 %.224at32, 0
  br i1 %.225, label %.226, label %.117
.226:
  %.229 = load i32, i32* %.107
  %.230at32 = call i32 @f(i32 19, i32 %.229)
  %.231 = icmp ne i32 %.230at32, 0
  br i1 %.231, label %.116, label %.117
.239wc36:
  %.243 = load i32, i32* %.107
  %.244 = icmp slt i32 %.243, 20
  br i1 %.244, label %.240wloop.36.42, label %.241wn42
.240wloop.36.42:
  %.249 = load i32, i32* %.107
  %.250at37 = call i32 @g(i32 0, i32 %.249)
  %.251 = icmp ne i32 %.250at37, 0
  br i1 %.251, label %.246, label %.248
.241wn42:
  store i32 1, i32* %.107
  br label %.353wc44 
.246:
  br label %.247 
.247:
  %.348 = load i32, i32* %.107
  %.349 = add i32 %.348, 1
  store i32 %.349, i32* %.107
  br label %.239wc36 
.248:
  %.254 = load i32, i32* %.107
  %.255at37 = call i32 @g(i32 1, i32 %.254)
  %.256 = icmp ne i32 %.255at37, 0
  br i1 %.256, label %.246, label %.253
.253:
  %.259 = load i32, i32* %.107
  %.260at37 = call i32 @g(i32 2, i32 %.259)
  %.261 = icmp ne i32 %.260at37, 0
  br i1 %.261, label %.246, label %.258
.258:
  %.264 = load i32, i32* %.107
  %.265at37 = call i32 @g(i32 3, i32 %.264)
  %.266 = icmp ne i32 %.265at37, 0
  br i1 %.266, label %.246, label %.263
.263:
  %.269 = load i32, i32* %.107
  %.270at37 = call i32 @g(i32 4, i32 %.269)
  %.271 = icmp ne i32 %.270at37, 0
  br i1 %.271, label %.246, label %.268
.268:
  %.274 = load i32, i32* %.107
  %.275at37 = call i32 @g(i32 5, i32 %.274)
  %.276 = icmp ne i32 %.275at37, 0
  br i1 %.276, label %.246, label %.273
.273:
  %.279 = load i32, i32* %.107
  %.280at38 = call i32 @g(i32 6, i32 %.279)
  %.281 = icmp ne i32 %.280at38, 0
  br i1 %.281, label %.246, label %.278
.278:
  %.284 = load i32, i32* %.107
  %.285at38 = call i32 @g(i32 7, i32 %.284)
  %.286 = icmp ne i32 %.285at38, 0
  br i1 %.286, label %.246, label %.283
.283:
  %.289 = load i32, i32* %.107
  %.290at38 = call i32 @g(i32 8, i32 %.289)
  %.291 = icmp ne i32 %.290at38, 0
  br i1 %.291, label %.246, label %.288
.288:
  %.294 = load i32, i32* %.107
  %.295at38 = call i32 @g(i32 9, i32 %.294)
  %.296 = icmp ne i32 %.295at38, 0
  br i1 %.296, label %.246, label %.293
.293:
  %.299 = load i32, i32* %.107
  %.300at38 = call i32 @g(i32 10, i32 %.299)
  %.301 = icmp ne i32 %.300at38, 0
  br i1 %.301, label %.246, label %.298
.298:
  %.304 = load i32, i32* %.107
  %.305at38 = call i32 @g(i32 11, i32 %.304)
  %.306 = icmp ne i32 %.305at38, 0
  br i1 %.306, label %.246, label %.303
.303:
  %.309 = load i32, i32* %.107
  %.310at39 = call i32 @g(i32 12, i32 %.309)
  %.311 = icmp ne i32 %.310at39, 0
  br i1 %.311, label %.246, label %.308
.308:
  %.314 = load i32, i32* %.107
  %.315at39 = call i32 @g(i32 13, i32 %.314)
  %.316 = icmp ne i32 %.315at39, 0
  br i1 %.316, label %.246, label %.313
.313:
  %.319 = load i32, i32* %.107
  %.320at39 = call i32 @g(i32 14, i32 %.319)
  %.321 = icmp ne i32 %.320at39, 0
  br i1 %.321, label %.246, label %.318
.318:
  %.324 = load i32, i32* %.107
  %.325at39 = call i32 @g(i32 15, i32 %.324)
  %.326 = icmp ne i32 %.325at39, 0
  br i1 %.326, label %.246, label %.323
.323:
  %.329 = load i32, i32* %.107
  %.330at39 = call i32 @g(i32 16, i32 %.329)
  %.331 = icmp ne i32 %.330at39, 0
  br i1 %.331, label %.246, label %.328
.328:
  %.334 = load i32, i32* %.107
  %.335at39 = call i32 @g(i32 17, i32 %.334)
  %.336 = icmp ne i32 %.335at39, 0
  br i1 %.336, label %.246, label %.333
.333:
  %.339 = load i32, i32* %.107
  %.340at40 = call i32 @g(i32 18, i32 %.339)
  %.341 = icmp ne i32 %.340at40, 0
  br i1 %.341, label %.246, label %.338
.338:
  %.343 = load i32, i32* %.107
  %.344at40 = call i32 @g(i32 19, i32 %.343)
  %.345 = icmp ne i32 %.344at40, 0
  br i1 %.345, label %.246, label %.247
.353wc44:
  %.357 = load i32, i32* %.107
  %.358 = icmp slt i32 %.357, 20
  br i1 %.358, label %.359, label %.355wn45
.354wloop.44.45:
  %.367 = load i32, i32* %.107
  %.368 = add i32 %.367, 1
  store i32 %.368, i32* %.107
  br label %.353wc44 
.355wn45:
  store i32 0, i32* %.371
  %.376at49 = call i32 @h(i32 0)
  %.377 = icmp ne i32 %.376at49, 0
  br i1 %.377, label %.378, label %.375
.359:
  %.361 = load i32, i32* %.107
  %.362 = sub i32 %.361, 1
  %.363 = load i32, i32* %.107
  %.364at44 = call i32 @f(i32 %.362, i32 %.363)
  %.365 = icmp ne i32 %.364at44, 0
  br i1 %.365, label %.354wloop.44.45, label %.355wn45
.373:
  store i32 1, i32* %.371
  br label %.374 
.374:
  %.392 = load i32, i32* @.g.sum
  %.393 = load i32, i32* %.371
  %.394 = add i32 %.392, %.393
  store i32 0, i32* %.371
  %.399at52 = call i32 @h(i32 4)
  %.400 = icmp eq i32 %.399at52, 0
  br i1 %.400, label %.396, label %.398
.375:
  %.384at49 = call i32 @h(i32 2)
  %.385 = icmp eq i32 %.384at49, 0
  br i1 %.385, label %.373, label %.383
.378:
  %.380at49 = call i32 @h(i32 1)
  %.381 = icmp ne i32 %.380at49, 0
  br i1 %.381, label %.373, label %.375
.383:
  %.387at49 = call i32 @h(i32 3)
  %.388 = icmp ne i32 %.387at49, 0
  br i1 %.388, label %.373, label %.374
.396:
  store i32 1, i32* %.371
  br label %.397 
.397:
  %.419 = load i32, i32* @.g.sum
  %.420 = load i32, i32* %.371
  %.421 = mul i32 %.419, %.420
  store i32 0, i32* %.371
  %.426at55 = call i32 @h(i32 9)
  %.427 = icmp ne i32 %.426at55, 0
  br i1 %.427, label %.428, label %.425
.398:
  %.403at52 = call i32 @h(i32 5)
  %.404 = icmp ne i32 %.403at52, 0
  br i1 %.404, label %.405, label %.402
.402:
  %.414at52 = call i32 @h(i32 8)
  %.415 = icmp eq i32 %.414at52, 0
  br i1 %.415, label %.396, label %.397
.405:
  %.407at52 = call i32 @h(i32 6)
  %.408 = icmp eq i32 %.407at52, 0
  br i1 %.408, label %.409, label %.402
.409:
  %.411at52 = call i32 @h(i32 7)
  %.412 = icmp ne i32 %.411at52, 0
  br i1 %.412, label %.396, label %.402
.423:
  store i32 1, i32* %.371
  br label %.424 
.424:
  %.454 = load i32, i32* @.g.sum
  %.455 = load i32, i32* %.371
  %.456 = sub i32 %.454, %.455
  store i32 0, i32* %.371
  %.461at58 = call i32 @h(i32 0)
  %.462 = icmp ne i32 %.461at58, 0
  br i1 %.462, label %.463, label %.460
.425:
  %.434at55 = call i32 @h(i32 11)
  %.435 = icmp eq i32 %.434at55, 0
  br i1 %.435, label %.423, label %.433
.428:
  %.430at55 = call i32 @h(i32 10)
  %.431 = icmp eq i32 %.430at55, 0
  br i1 %.431, label %.423, label %.425
.433:
  %.438at55 = call i32 @h(i32 12)
  %.439 = icmp eq i32 %.438at55, 0
  br i1 %.439, label %.423, label %.437
.437:
  %.442at55 = call i32 @h(i32 13)
  %.443 = icmp eq i32 %.442at55, 0
  br i1 %.443, label %.423, label %.441
.441:
  %.445at55 = call i32 @h(i32 14)
  %.446 = icmp ne i32 %.445at55, 0
  br i1 %.446, label %.447, label %.424
.447:
  %.449at55 = call i32 @h(i32 15)
  %.450 = icmp ne i32 %.449at55, 0
  br i1 %.450, label %.423, label %.424
.458:
  store i32 1, i32* %.371
  br label %.459 
.459:
  %.493 = load i32, i32* @.g.sum
  %.494 = load i32, i32* %.371
  %.495 = add i32 %.493, %.494
  call void @putint(i32 %.495)
  ret i32 0 
.460:
  %.477at58 = call i32 @h(i32 5)
  %.478 = icmp ne i32 %.477at58, 0
  br i1 %.478, label %.458, label %.476
.463:
  %.465at58 = call i32 @h(i32 2)
  %.466 = icmp ne i32 %.465at58, 0
  br i1 %.466, label %.467, label %.460
.467:
  %.469at58 = call i32 @h(i32 3)
  %.470 = icmp eq i32 %.469at58, 0
  br i1 %.470, label %.471, label %.460
.471:
  %.473at58 = call i32 @h(i32 4)
  %.474 = icmp eq i32 %.473at58, 0
  br i1 %.474, label %.458, label %.460
.476:
  %.481at58 = call i32 @h(i32 6)
  %.482 = icmp ne i32 %.481at58, 0
  br i1 %.482, label %.483, label %.480
.480:
  %.488a