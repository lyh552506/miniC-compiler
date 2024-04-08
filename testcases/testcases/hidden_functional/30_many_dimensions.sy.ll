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
@__constant..160 = constant [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]  [[2 x [2 x [2 x [2 x [2 x i32]]]]]  [[2 x [2 x [2 x [2 x i32]]]]  [[2 x [2 x [2 x i32]]]  [[2 x [2 x i32]]  [[2 x i32]  [i32 0, i32 zeroinitializer], [2 x i32] zeroinitializer], [2 x [2 x i32]] zeroinitializer], [2 x [2 x [2 x i32]]] zeroinitializer], [2 x [2 x [2 x [2 x i32]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x i32]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]] zeroinitializer]
define i32 @sum(i32* %.3, [2 x i32]* %.7, [2 x [2 x i32]]* %.10, [2 x [2 x [2 x i32]]]* %.13, [2 x [2 x [2 x [2 x i32]]]]* %.16, [2 x [2 x [2 x [2 x [2 x i32]]]]]* %.19, [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %.22, [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %.25, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %.28, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %.31, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %.34, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %.37, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %.40, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %.43, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %.46, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %.49, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %.52, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %.55, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %.58){
.1:
  %.57 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]*
  %.54 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]*
  %.51 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]*
  %.48 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]*
  %.45 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]*
  %.42 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]*
  %.39 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]*
  %.36 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]*
  %.33 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]*
  %.30 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]*
  %.27 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]*
  %.24 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]*
  %.21 = alloca [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]*
  %.18 = alloca [2 x [2 x [2 x [2 x [2 x i32]]]]]*
  %.15 = alloca [2 x [2 x [2 x [2 x i32]]]]*
  %.12 = alloca [2 x [2 x [2 x i32]]]*
  %.9 = alloca [2 x [2 x i32]]*
  %.6 = alloca [2 x i32]*
  %.2 = alloca i32*
  store i32* %.3, i32** %.2
  store [2 x i32]* %.7, [2 x i32]** %.6
  store [2 x [2 x i32]]* %.10, [2 x [2 x i32]]** %.9
  store [2 x [2 x [2 x i32]]]* %.13, [2 x [2 x [2 x i32]]]** %.12
  store [2 x [2 x [2 x [2 x i32]]]]* %.16, [2 x [2 x [2 x [2 x i32]]]]** %.15
  store [2 x [2 x [2 x [2 x [2 x i32]]]]]* %.19, [2 x [2 x [2 x [2 x [2 x i32]]]]]** %.18
  store [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %.22, [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]** %.21
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %.25, [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]** %.24
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %.28, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]** %.27
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %.31, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]** %.30
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %.34, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]** %.33
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %.37, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]** %.36
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %.40, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]** %.39
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %.43, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]** %.42
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %.46, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]** %.45
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %.49, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]** %.48
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %.52, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]** %.51
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %.55, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]** %.54
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %.58, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]** %.57
  %.61 = load i32*, i32** %.2
  %.62 = getelementptr inbounds i32, i32* %.61, i32 0
  %.63 = load i32, i32* %.62
  %.65 = load [2 x i32]*, [2 x i32]** %.6
  %.66 = getelementptr inbounds [2 x i32], [2 x i32]* %.65, i32 1, i32 0
  %.67 = load i32, i32* %.66
  %.68 = add i32 %.63, %.67
  %.69 = load [2 x [2 x i32]]*, [2 x [2 x i32]]** %.9
  %.70 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %.69, i32 0, i32 0, i32 1
  %.71 = load i32, i32* %.70
  %.72 = add i32 %.68, %.71
  %.73 = load [2 x [2 x [2 x i32]]]*, [2 x [2 x [2 x i32]]]** %.12
  %.74 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %.73, i32 1, i32 0, i32 1, i32 0
  %.75 = load i32, i32* %.74
  %.76 = add i32 %.72, %.75
  %.77 = load [2 x [2 x [2 x [2 x i32]]]]*, [2 x [2 x [2 x [2 x i32]]]]** %.15
  %.78 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %.77, i32 0, i32 0, i32 1, i32 1, i32 0
  %.79 = load i32, i32* %.78
  %.80 = add i32 %.76, %.79
  %.81 = load [2 x [2 x [2 x [2 x [2 x i32]]]]]*, [2 x [2 x [2 x [2 x [2 x i32]]]]]** %.18
  %.82 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x i32]]]]], [2 x [2 x [2 x [2 x [2 x i32]]]]]* %.81, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1
  %.83 = load i32, i32* %.82
  %.84 = add i32 %.80, %.83
  %.85 = load [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]** %.21
  %.86 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %.85, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 0
  %.87 = load i32, i32* %.86
  %.88 = add i32 %.84, %.87
  %.89 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]** %.24
  %.90 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %.89, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 1
  %.91 = load i32, i32* %.90
  %.92 = add i32 %.88, %.91
  %.93 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]** %.27
  %.94 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %.93, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0
  %.95 = load i32, i32* %.94
  %.96 = add i32 %.92, %.95
  %.97 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]** %.30
  %.98 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %.97, i32 0, i32 0, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0, i32 1
  %.99 = load i32, i32* %.98
  %.100 = add i32 %.96, %.99
  %.101 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]** %.33
  %.102 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %.101, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 1
  %.103 = load i32, i32* %.102
  %.104 = add i32 %.100, %.103
  %.105 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]** %.36
  %.106 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %.105, i32 0, i32 0, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0, i32 1, i32 1, i32 0
  %.107 = load i32, i32* %.106
  %.108 = add i32 %.104, %.107
  %.109 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]** %.39
  %.110 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %.109, i32 1, i32 1, i32 0, i32 0, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0
  %.111 = load i32, i32* %.110
  %.112 = add i32 %.108, %.111
  %.113 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]** %.42
  %.114 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %.113, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1
  %.115 = load i32, i32* %.114
  %.116 = add i32 %.112, %.115
  %.117 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]** %.45
  %.118 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %.117, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1
  %.119 = load i32, i32* %.118
  %.120 = add i32 %.116, %.119
  %.121 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]** %.48
  %.122 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %.121, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0
  %.123 = load i32, i32* %.122
  %.124 = add i32 %.120, %.123
  %.125 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]** %.51
  %.126 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %.125, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1
  %.127 = load i32, i32* %.126
  %.128 = add i32 %.124, %.127
  %.129 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]** %.54
  %.130 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %.129, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 1, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 1
  %.131 = load i32, i32* %.130
  %.132 = add i32 %.128, %.131
  %.133 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]** %.57
  %.134 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %.133, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0, i32 1, i32 0, i32 0, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.135 = load i32, i32* %.134
  %.136 = add i32 %.132, %.135
  ret i32 %.136 
}
define i32 @main(){
.139:
  %.330 = alloca i32
  %.321 = alloca i32
  %.312 = alloca i32
  %.303 = alloca i32
  %.294 = alloca i32
  %.285 = alloca i32
  %.276 = alloca i32
  %.267 = alloca i32
  %.258 = alloca i32
  %.249 = alloca i32
  %.240 = alloca i32
  %.231 = alloca i32
  %.222 = alloca i32
  %.213 = alloca i32
  %.204 = alloca i32
  %.195 = alloca i32
  %.186 = alloca i32
  %.177 = alloca i32
  %.168 = alloca i32
  %.166 = alloca i32
  %.140 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]
  call void @llvm.memcpy.p0.p0.i32([2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* @__constant..160, i32 2097152, i1 false)
  store i32 0, i32* %.166
  store i32 0, i32* %.168
  br label %.170wc32 
.170wc32:
  %.174 = load i32, i32* %.168
  %.175 = icmp slt i32 %.174, 2
  br i1 %.175, label %.171wloop.32.108, label %.172wn108
.171wloop.32.108:
  store i32 0, i32* %.177
  br label %.179wc34 
.172wn108:
  %.440 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.441 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.442 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.443 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.444 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.445 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.446 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.447 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.448 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.449 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.450 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.451 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.452 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.453 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.454 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.455 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0
  %.456 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0
  %.457 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0
  %.458 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0
  %.459at109 = call i32 @sum(i32* %.440, [2 x i32]* %.441, [2 x [2 x i32]]* %.442, [2 x [2 x [2 x i32]]]* %.443, [2 x [2 x [2 x [2 x i32]]]]* %.444, [2 x [2 x [2 x [2 x [2 x i32]]]]]* %.445, [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %.446, [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %.447, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %.448, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %.449, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %.450, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %.451, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %.452, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %.453, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %.454, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %.455, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %.456, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %.457, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %.458)
  call void @putint(i32 %.459at109)
  ret i32 0 
.179wc34:
  %.183 = load i32, i32* %.177
  %.184 = icmp slt i32 %.183, 2
  br i1 %.184, label %.180wloop.34.106, label %.181wn106
.180wloop.34.106:
  store i32 0, i32* %.186
  br label %.188wc36 
.181wn106:
  %.436 = load i32, i32* %.168
  %.437 = add i32 %.436, 1
  store i32 %.437, i32* %.168
  br label %.170wc32 
.188wc36:
  %.192 = load i32, i32* %.186
  %.193 = icmp slt i32 %.192, 2
  br i1 %.193, label %.189wloop.36.104, label %.190wn104
.189wloop.36.104:
  store i32 0, i32* %.195
  br label %.197wc38 
.190wn104:
  %.432 = load i32, i32* %.177
  %.433 = add i32 %.432, 1
  store i32 %.433, i32* %.177
  br label %.179wc34 
.197wc38:
  %.201 = load i32, i32* %.195
  %.202 = icmp slt i32 %.201, 2
  br i1 %.202, label %.198wloop.38.102, label %.199wn102
.198wloop.38.102:
  store i32 0, i32* %.204
  br label %.206wc40 
.199wn102:
  %.428 = load i32, i32* %.186
  %.429 = add i32 %.428, 1
  store i32 %.429, i32* %.186
  br label %.188wc36 
.206wc40:
  %.210 = load i32, i32* %.204
  %.211 = icmp slt i32 %.210, 2
  br i1 %.211, label %.207wloop.40.100, label %.208wn100
.207wloop.40.100:
  store i32 0, i32* %.213
  br label %.215wc42 
.208wn100:
  %.424 = load i32, i32* %.195
  %.425 = add i32 %.424, 1
  store i32 %.425, i32* %.195
  br label %.197wc38 
.215wc42:
  %.219 = load i32, i32* %.213
  %.220 = icmp slt i32 %.219, 2
  br i1 %.220, label %.216wloop.42.98, label %.217wn98
.216wloop.42.98:
  store i32 0, i32* %.222
  br label %.224wc44 
.217wn98:
  %.420 = load i32, i32* %.204
  %.421 = add i32 %.420, 1
  store i32 %.421, i32* %.204
  br label %.206wc40 
.224wc44:
  %.228 = load i32, i32* %.222
  %.229 = icmp slt i32 %.228, 2
  br i1 %.229, label %.225wloop.44.96, label %.226wn96
.225wloop.44.96:
  store i32 0, i32* %.231
  br label %.233wc46 
.226wn96:
  %.416 = load i32, i32* %.213
  %.417 = add i32 %.416, 1
  store i32 %.417, i32* %.213
  br label %.215wc42 
.233wc46:
  %.237 = load i32, i32* %.231
  %.238 = icmp slt i32 %.237, 2
  br i1 %.238, label %.234wloop.46.94, label %.235wn94
.234wloop.46.94:
  store i32 0, i32* %.240
  br label %.242wc48 
.235wn94:
  %.412 = load i32, i32* %.222
  %.413 = add i32 %.412, 1
  store i32 %.413, i32* %.222
  br label %.224wc44 
.242wc48:
  %.246 = load i32, i32* %.240
  %.247 = icmp slt i32 %.246, 2
  br i1 %.247, label %.243wloop.48.92, label %.244wn92
.243wloop.48.92:
  store i32 0, i32* %.249
  br label %.251wc50 
.244wn92:
  %.408 = load i32, i32* %.231
  %.409 = add i32 %.408, 1
  store i32 %.409, i32* %.231
  br label %.233wc46 
.251wc50:
  %.255 = load i32, i32* %.249
  %.256 = icmp slt i32 %.255, 2
  br i1 %.256, label %.252wloop.50.90, label %.253wn90
.252wloop.50.90:
  store i32 0, i32* %.258
  br label %.260wc52 
.253wn90:
  %.404 = load i32, i32* %.240
  %.405 = add i32 %.404, 1
  store i32 %.405, i32* %.240
  br label %.242wc48 
.260wc52:
  %.264 = load i32, i32* %.258
  %.265 = icmp slt i32 %.264, 2
  br i1 %.265, label %.261wloop.52.88, label %.262wn88
.261wloop.52.88:
  store i32 0, i32* %.267
  br label %.269wc54 
.262wn88:
  %.400 = load i32, i32* %.249
  %.401 = add i32 %.400, 1
  store i32 %.401, i32* %.249
  br label %.251wc50 
.269wc54:
  %.273 = load i32, i32* %.267
  %.274 = icmp slt i32 %.273, 2
  br i1 %.274, label %.270wloop.54.86, label %.271wn86
.270wloop.54.86:
  store i32 0, i32* %.276
  br label %.278wc56 
.271wn86:
  %.396 = load i32, i32* %.258
  %.397 = add i32 %.396, 1
  store i32 %.397, i32* %.258
  br label %.260wc52 
.278wc56:
  %.282 = load i32, i32* %.276
  %.283 = icmp slt i32 %.282, 2
  br i1 %.283, label %.279wloop.56.84, label %.280wn84
.279wloop.56.84:
  store i32 0, i32* %.285
  br label %.287wc58 
.280wn84:
  %.392 = load i32, i32* %.267
  %.393 = add i32 %.392, 1
  store i32 %.393, i32* %.267
  br label %.269wc54 
.287wc58:
  %.291 = load i32, i32* %.285
  %.292 = icmp slt i32 %.291, 2
  br i1 %.292, label %.288wloop.58.82, label %.289wn82
.288wloop.58.82:
  store i32 0, i32* %.294
  br label %.296wc60 
.289wn82:
  %.388 = load i32, i32* %.276
  %.389 = add i32 %.388, 1
  store i32 %.389, i32* %.276
  br label %.278wc56 
.296wc60:
  %.300 = load i32, i32* %.294
  %.301 = icmp slt i32 %.300, 2
  br i1 %.301, label %.297wloop.60.80, label %.298wn80
.297wloop.60.80:
  store i32 0, i32* %.303
  br label %.305wc62 
.298wn80:
  %.384 = load i32, i32* %.285
  %.385 = add i32 %.384, 1
  store i32 %.385, i32* %.285
  br label %.287wc58 
.305wc62:
  %.309 = load i32, i32* %.303
  %.310 = icmp slt i32 %.309, 2
  br i1 %.310, label %.306wloop.62.78, label %.307wn78
.306wloop.62.78:
  store i32 0, i32* %.312
  br label %.314wc64 
.307wn78:
  %.380 = load i32, i32* %.294
  %.381 = add i32 %.380, 1
  store i32 %.381, i32* %.294
  br label %.296wc60 
.314wc64:
  %.318 = load i32, i32* %.312
  %.319 = icmp slt i32 %.318, 2
  br i1 %.319, label %.315wloop.64.76, label %.316wn76
.315wloop.64.76:
  store i32 0, i32* %.321
  br label %.323wc66 
.316wn76:
  %.376 = load i32, i32* %.303
  %.377 = add i32 %.376, 1
  store i32 %.377, i32* %.303
  br label %.305wc62 
.323wc66:
  %.327 = load i32, i32* %.321
  %.328 = icmp slt i32 %.327, 2
  br i1 %.328, label %.324wloop.66.74, label %.325wn74
.324wloop.66.74:
  store i32 0, i32* %.330
  br label %.332wc68 
.325wn74:
  %.372 = load i32, i32* %.312
  %.373 = add i32 %.372, 1
  store i32 %.373, i32* %.312
  br label %.314wc64 
.332wc68:
  %.336 = load i32, i32* %.330
  %.337 = icmp slt i32 %.336, 2
  br i1 %.337, label %.333wloop.68.72, label %.334wn72
.333wloop.68.72:
  %.339 = load i32, i32* %.166
  %.340 = load i32, i32* %.168
  %.341 = load i32, i32* %.177
  %.342 = load i32, i32* %.186
  %.343 = load i32, i32* %.195
  %.344 = load i32, i32* %.204
  %.345 = load i32, i32* %.213
  %.346 = load i32, i32* %.222
  %.347 = load i32, i32* %.231
  %.348 = load i32, i32* %.240
  %.349 = load i32, i32* %.249
  %.350 = load i32, i32* %.258
  %.351 = load i32, i32* %.267
  %.352 = load i32, i32* %.276
  %.353 = load i32, i32* %.285
  %.354 = load i32, i32* %.294
  %.355 = load i32, i32* %.303
  %.356 = load i32, i32* %.312
  %.357 = load i32, i32* %.321
  %.358 = load i32, i32* %.330
  %.359 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 %.340, i32 %.341, i32 %.342, i32 %.343, i32 %.344, i32 %.345, i32 %.346, i32 %.347, i32 %.348, i32 %.349, i32 %.350, i32 %.351, i32 %.352, i32 %.353, i32 %.354, i32 %.355, i32 %.356, i32 %.357, i32 %.358
  store i32 %.339, i32* %.359
  %.361 = load i32, i32* %.166
  %.362 = add i32 %.361, 1
  store i32 %.362, i32* %.166
  %.364 = load i32, i32* %.330
  %.365 = add i32 %.364, 1
  store i32 %.365, i32* %.330
  br label %.332wc68 
.334wn72:
  %.368 = load i32, i32* %.321
  %.369 = add i32 %.368, 1
  store i32 %.369, i32* %.321
  br label %.323wc66 
}
@__constant..160 = constant [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]  [[2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]  [[2 x [2 x [2 x [2 x [2 x i32]]]]]  [[2 x [2 x [2 x [2 x i32]]]]  [[2 x [2 x [2 x i32]]]  [[2 x [2 x i32]]  [[2 x i32]  [i32 0, i32 zeroinitializer], [2 x i32] zeroinitializer], [2 x [2 x i32]] zeroinitializer], [2 x [2 x [2 x i32]]] zeroinitializer], [2 x [2 x [2 x [2 x i32]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x i32]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]] zeroinitializer], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]] zeroinitializer]
define i32 @sum(i32* %.3, [2 x i32]* %.7, [2 x [2 x i32]]* %.10, [2 x [2 x [2 x i32]]]* %.13, [2 x [2 x [2 x [2 x i32]]]]* %.16, [2 x [2 x [2 x [2 x [2 x i32]]]]]* %.19, [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %.22, [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %.25, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %.28, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %.31, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %.34, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %.37, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %.40, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %.43, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %.46, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %.49, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %.52, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %.55, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %.58){
.1:
  %.57 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]*
  %.54 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]*
  %.51 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]*
  %.48 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]*
  %.45 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]*
  %.42 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]*
  %.39 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]*
  %.36 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]*
  %.33 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]*
  %.30 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]*
  %.27 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]*
  %.24 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]*
  %.21 = alloca [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]*
  %.18 = alloca [2 x [2 x [2 x [2 x [2 x i32]]]]]*
  %.15 = alloca [2 x [2 x [2 x [2 x i32]]]]*
  %.12 = alloca [2 x [2 x [2 x i32]]]*
  %.9 = alloca [2 x [2 x i32]]*
  %.6 = alloca [2 x i32]*
  %.2 = alloca i32*
  store i32* %.3, i32** %.2
  store [2 x i32]* %.7, [2 x i32]** %.6
  store [2 x [2 x i32]]* %.10, [2 x [2 x i32]]** %.9
  store [2 x [2 x [2 x i32]]]* %.13, [2 x [2 x [2 x i32]]]** %.12
  store [2 x [2 x [2 x [2 x i32]]]]* %.16, [2 x [2 x [2 x [2 x i32]]]]** %.15
  store [2 x [2 x [2 x [2 x [2 x i32]]]]]* %.19, [2 x [2 x [2 x [2 x [2 x i32]]]]]** %.18
  store [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %.22, [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]** %.21
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %.25, [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]** %.24
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %.28, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]** %.27
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %.31, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]** %.30
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %.34, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]** %.33
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %.37, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]** %.36
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %.40, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]** %.39
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %.43, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]** %.42
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %.46, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]** %.45
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %.49, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]** %.48
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %.52, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]** %.51
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %.55, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]** %.54
  store [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %.58, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]** %.57
  %.61 = load i32*, i32** %.2
  %.62 = getelementptr inbounds i32, i32* %.61, i32 0
  %.63 = load i32, i32* %.62
  %.65 = load [2 x i32]*, [2 x i32]** %.6
  %.66 = getelementptr inbounds [2 x i32], [2 x i32]* %.65, i32 1, i32 0
  %.67 = load i32, i32* %.66
  %.68 = add i32 %.63, %.67
  %.69 = load [2 x [2 x i32]]*, [2 x [2 x i32]]** %.9
  %.70 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %.69, i32 0, i32 0, i32 1
  %.71 = load i32, i32* %.70
  %.72 = add i32 %.68, %.71
  %.73 = load [2 x [2 x [2 x i32]]]*, [2 x [2 x [2 x i32]]]** %.12
  %.74 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %.73, i32 1, i32 0, i32 1, i32 0
  %.75 = load i32, i32* %.74
  %.76 = add i32 %.72, %.75
  %.77 = load [2 x [2 x [2 x [2 x i32]]]]*, [2 x [2 x [2 x [2 x i32]]]]** %.15
  %.78 = getelementptr inbounds [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %.77, i32 0, i32 0, i32 1, i32 1, i32 0
  %.79 = load i32, i32* %.78
  %.80 = add i32 %.76, %.79
  %.81 = load [2 x [2 x [2 x [2 x [2 x i32]]]]]*, [2 x [2 x [2 x [2 x [2 x i32]]]]]** %.18
  %.82 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x i32]]]]], [2 x [2 x [2 x [2 x [2 x i32]]]]]* %.81, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1
  %.83 = load i32, i32* %.82
  %.84 = add i32 %.80, %.83
  %.85 = load [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]** %.21
  %.86 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %.85, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 0
  %.87 = load i32, i32* %.86
  %.88 = add i32 %.84, %.87
  %.89 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]** %.24
  %.90 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %.89, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 1
  %.91 = load i32, i32* %.90
  %.92 = add i32 %.88, %.91
  %.93 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]** %.27
  %.94 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %.93, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0
  %.95 = load i32, i32* %.94
  %.96 = add i32 %.92, %.95
  %.97 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]** %.30
  %.98 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %.97, i32 0, i32 0, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0, i32 1
  %.99 = load i32, i32* %.98
  %.100 = add i32 %.96, %.99
  %.101 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]** %.33
  %.102 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %.101, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 1
  %.103 = load i32, i32* %.102
  %.104 = add i32 %.100, %.103
  %.105 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]** %.36
  %.106 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %.105, i32 0, i32 0, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0, i32 1, i32 1, i32 0
  %.107 = load i32, i32* %.106
  %.108 = add i32 %.104, %.107
  %.109 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]** %.39
  %.110 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %.109, i32 1, i32 1, i32 0, i32 0, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0
  %.111 = load i32, i32* %.110
  %.112 = add i32 %.108, %.111
  %.113 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]** %.42
  %.114 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %.113, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1
  %.115 = load i32, i32* %.114
  %.116 = add i32 %.112, %.115
  %.117 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]** %.45
  %.118 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %.117, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1
  %.119 = load i32, i32* %.118
  %.120 = add i32 %.116, %.119
  %.121 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]** %.48
  %.122 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %.121, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 0
  %.123 = load i32, i32* %.122
  %.124 = add i32 %.120, %.123
  %.125 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]** %.51
  %.126 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %.125, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1
  %.127 = load i32, i32* %.126
  %.128 = add i32 %.124, %.127
  %.129 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]** %.54
  %.130 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %.129, i32 1, i32 1, i32 0, i32 0, i32 1, i32 0, i32 1, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 1, i32 1
  %.131 = load i32, i32* %.130
  %.132 = add i32 %.128, %.131
  %.133 = load [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]*, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]** %.57
  %.134 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %.133, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0, i32 1, i32 0, i32 0, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.135 = load i32, i32* %.134
  %.136 = add i32 %.132, %.135
  ret i32 %.136 
}
define i32 @main(){
.139:
  %.330 = alloca i32
  %.321 = alloca i32
  %.312 = alloca i32
  %.303 = alloca i32
  %.294 = alloca i32
  %.285 = alloca i32
  %.276 = alloca i32
  %.267 = alloca i32
  %.258 = alloca i32
  %.249 = alloca i32
  %.240 = alloca i32
  %.231 = alloca i32
  %.222 = alloca i32
  %.213 = alloca i32
  %.204 = alloca i32
  %.195 = alloca i32
  %.186 = alloca i32
  %.177 = alloca i32
  %.168 = alloca i32
  %.166 = alloca i32
  %.140 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]
  call void @llvm.memcpy.p0.p0.i32([2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* @__constant..160, i32 2097152, i1 false)
  store i32 0, i32* %.166
  store i32 0, i32* %.168
  br label %.170wc32 
.170wc32:
  %.174 = load i32, i32* %.168
  %.175 = icmp slt i32 %.174, 2
  br i1 %.175, label %.171wloop.32.108, label %.172wn108
.171wloop.32.108:
  store i32 0, i32* %.177
  br label %.179wc34 
.172wn108:
  %.440 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.441 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.442 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.443 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.444 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.445 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.446 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.447 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.448 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.449 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.450 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.451 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.452 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.453 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.454 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %.455 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0, i32 0
  %.456 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0, i32 0
  %.457 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0, i32 0
  %.458 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 0
  %.459at109 = call i32 @sum(i32* %.440, [2 x i32]* %.441, [2 x [2 x i32]]* %.442, [2 x [2 x [2 x i32]]]* %.443, [2 x [2 x [2 x [2 x i32]]]]* %.444, [2 x [2 x [2 x [2 x [2 x i32]]]]]* %.445, [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %.446, [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %.447, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %.448, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %.449, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %.450, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %.451, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %.452, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %.453, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %.454, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %.455, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %.456, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %.457, [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %.458)
  call void @putint(i32 %.459at109)
  ret i32 0 
.179wc34:
  %.183 = load i32, i32* %.177
  %.184 = icmp slt i32 %.183, 2
  br i1 %.184, label %.180wloop.34.106, label %.181wn106
.180wloop.34.106:
  store i32 0, i32* %.186
  br label %.188wc36 
.181wn106:
  %.436 = load i32, i32* %.168
  %.437 = add i32 %.436, 1
  store i32 %.437, i32* %.168
  br label %.170wc32 
.188wc36:
  %.192 = load i32, i32* %.186
  %.193 = icmp slt i32 %.192, 2
  br i1 %.193, label %.189wloop.36.104, label %.190wn104
.189wloop.36.104:
  store i32 0, i32* %.195
  br label %.197wc38 
.190wn104:
  %.432 = load i32, i32* %.177
  %.433 = add i32 %.432, 1
  store i32 %.433, i32* %.177
  br label %.179wc34 
.197wc38:
  %.201 = load i32, i32* %.195
  %.202 = icmp slt i32 %.201, 2
  br i1 %.202, label %.198wloop.38.102, label %.199wn102
.198wloop.38.102:
  store i32 0, i32* %.204
  br label %.206wc40 
.199wn102:
  %.428 = load i32, i32* %.186
  %.429 = add i32 %.428, 1
  store i32 %.429, i32* %.186
  br label %.188wc36 
.206wc40:
  %.210 = load i32, i32* %.204
  %.211 = icmp slt i32 %.210, 2
  br i1 %.211, label %.207wloop.40.100, label %.208wn100
.207wloop.40.100:
  store i32 0, i32* %.213
  br label %.215wc42 
.208wn100:
  %.424 = load i32, i32* %.195
  %.425 = add i32 %.424, 1
  store i32 %.425, i32* %.195
  br label %.197wc38 
.215wc42:
  %.219 = load i32, i32* %.213
  %.220 = icmp slt i32 %.219, 2
  br i1 %.220, label %.216wloop.42.98, label %.217wn98
.216wloop.42.98:
  store i32 0, i32* %.222
  br label %.224wc44 
.217wn98:
  %.420 = load i32, i32* %.204
  %.421 = add i32 %.420, 1
  store i32 %.421, i32* %.204
  br label %.206wc40 
.224wc44:
  %.228 = load i32, i32* %.222
  %.229 = icmp slt i32 %.228, 2
  br i1 %.229, label %.225wloop.44.96, label %.226wn96
.225wloop.44.96:
  store i32 0, i32* %.231
  br label %.233wc46 
.226wn96:
  %.416 = load i32, i32* %.213
  %.417 = add i32 %.416, 1
  store i32 %.417, i32* %.213
  br label %.215wc42 
.233wc46:
  %.237 = load i32, i32* %.231
  %.238 = icmp slt i32 %.237, 2
  br i1 %.238, label %.234wloop.46.94, label %.235wn94
.234wloop.46.94:
  store i32 0, i32* %.240
  br label %.242wc48 
.235wn94:
  %.412 = load i32, i32* %.222
  %.413 = add i32 %.412, 1
  store i32 %.413, i32* %.222
  br label %.224wc44 
.242wc48:
  %.246 = load i32, i32* %.240
  %.247 = icmp slt i32 %.246, 2
  br i1 %.247, label %.243wloop.48.92, label %.244wn92
.243wloop.48.92:
  store i32 0, i32* %.249
  br label %.251wc50 
.244wn92:
  %.408 = load i32, i32* %.231
  %.409 = add i32 %.408, 1
  store i32 %.409, i32* %.231
  br label %.233wc46 
.251wc50:
  %.255 = load i32, i32* %.249
  %.256 = icmp slt i32 %.255, 2
  br i1 %.256, label %.252wloop.50.90, label %.253wn90
.252wloop.50.90:
  store i32 0, i32* %.258
  br label %.260wc52 
.253wn90:
  %.404 = load i32, i32* %.240
  %.405 = add i32 %.404, 1
  store i32 %.405, i32* %.240
  br label %.242wc48 
.260wc52:
  %.264 = load i32, i32* %.258
  %.265 = icmp slt i32 %.264, 2
  br i1 %.265, label %.261wloop.52.88, label %.262wn88
.261wloop.52.88:
  store i32 0, i32* %.267
  br label %.269wc54 
.262wn88:
  %.400 = load i32, i32* %.249
  %.401 = add i32 %.400, 1
  store i32 %.401, i32* %.249
  br label %.251wc50 
.269wc54:
  %.273 = load i32, i32* %.267
  %.274 = icmp slt i32 %.273, 2
  br i1 %.274, label %.270wloop.54.86, label %.271wn86
.270wloop.54.86:
  store i32 0, i32* %.276
  br label %.278wc56 
.271wn86:
  %.396 = load i32, i32* %.258
  %.397 = add i32 %.396, 1
  store i32 %.397, i32* %.258
  br label %.260wc52 
.278wc56:
  %.282 = load i32, i32* %.276
  %.283 = icmp slt i32 %.282, 2
  br i1 %.283, label %.279wloop.56.84, label %.280wn84
.279wloop.56.84:
  store i32 0, i32* %.285
  br label %.287wc58 
.280wn84:
  %.392 = load i32, i32* %.267
  %.393 = add i32 %.392, 1
  store i32 %.393, i32* %.267
  br label %.269wc54 
.287wc58:
  %.291 = load i32, i32* %.285
  %.292 = icmp slt i32 %.291, 2
  br i1 %.292, label %.288wloop.58.82, label %.289wn82
.288wloop.58.82:
  store i32 0, i32* %.294
  br label %.296wc60 
.289wn82:
  %.388 = load i32, i32* %.276
  %.389 = add i32 %.388, 1
  store i32 %.389, i32* %.276
  br label %.278wc56 
.296wc60:
  %.300 = load i32, i32* %.294
  %.301 = icmp slt i32 %.300, 2
  br i1 %.301, label %.297wloop.60.80, label %.298wn80
.297wloop.60.80:
  store i32 0, i32* %.303
  br label %.305wc62 
.298wn80:
  %.384 = load i32, i32* %.285
  %.385 = add i32 %.384, 1
  store i32 %.385, i32* %.285
  br label %.287wc58 
.305wc62:
  %.309 = load i32, i32* %.303
  %.310 = icmp slt i32 %.309, 2
  br i1 %.310, label %.306wloop.62.78, label %.307wn78
.306wloop.62.78:
  store i32 0, i32* %.312
  br label %.314wc64 
.307wn78:
  %.380 = load i32, i32* %.294
  %.381 = add i32 %.380, 1
  store i32 %.381, i32* %.294
  br label %.296wc60 
.314wc64:
  %.318 = load i32, i32* %.312
  %.319 = icmp slt i32 %.318, 2
  br i1 %.319, label %.315wloop.64.76, label %.316wn76
.315wloop.64.76:
  store i32 0, i32* %.321
  br label %.323wc66 
.316wn76:
  %.376 = load i32, i32* %.303
  %.377 = add i32 %.376, 1
  store i32 %.377, i32* %.303
  br label %.305wc62 
.323wc66:
  %.327 = load i32, i32* %.321
  %.328 = icmp slt i32 %.327, 2
  br i1 %.328, label %.324wloop.66.74, label %.325wn74
.324wloop.66.74:
  store i32 0, i32* %.330
  br label %.332wc68 
.325wn74:
  %.372 = load i32, i32* %.312
  %.373 = add i32 %.372, 1
  store i32 %.373, i32* %.312
  br label %.314wc64 
.332wc68:
  %.336 = load i32, i32* %.330
  %.337 = icmp slt i32 %.336, 2
  br i1 %.337, label %.333wloop.68.72, label %.334wn72
.333wloop.68.72:
  %.339 = load i32, i32* %.166
  %.340 = load i32, i32* %.168
  %.341 = load i32, i32* %.177
  %.342 = load i32, i32* %.186
  %.343 = load i32, i32* %.195
  %.344 = load i32, i32* %.204
  %.345 = load i32, i32* %.213
  %.346 = load i32, i32* %.222
  %.347 = load i32, i32* %.231
  %.348 = load i32, i32* %.240
  %.349 = load i32, i32* %.249
  %.350 = load i32, i32* %.258
  %.351 = load i32, i32* %.267
  %.352 = load i32, i32* %.276
  %.353 = load i32, i32* %.285
  %.354 = load i32, i32* %.294
  %.355 = load i32, i32* %.303
  %.356 = load i32, i32* %.312
  %.357 = load i32, i32* %.321
  %.358 = load i32, i32* %.330
  %.359 = getelementptr inbounds [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %.140, i32 0, i32 %.340, i32 %.341, i32 %.342, i32 %.343, i32 %.344, i32 %.345, i32 %.346, i32 %.347, i32 %.348, i32 %.349, i32 %.350, i32 %.351, i32 %.352, i32 %.353, i32 %.354, i32 %.355, i32 %.356, i32 %.357, i32 %.358
  store i32 %.339, i32* %.359
  %.361 = load i32, i32* %.166
  %.362 = add i32 %.361, 1
  store i32 %.362, i32* %.166
  %.364 = load i32, i32* %.330
  %.365 = add i32 %.364, 1
  store i32 %.365, i32* %.330
  br label %.332wc68 
.334wn72:
  %.368 = load i32, i32* %.321
  %.369 = add i32 %.368, 1
  store i32 %.369, i32* 