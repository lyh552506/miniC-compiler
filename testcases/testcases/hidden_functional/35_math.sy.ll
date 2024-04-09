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
define float @my_fabs(float %.4){
.2:
  %.3 = alloca float
  store float %.4, float* %.3
  %.8 = load float, float* %.3
  %.10 = sitofp i32 0 to float
  %.11 = fcmp ugt float %.8, %.10
  br i1 %.11, label %.6, label %.7
.6:
  %.13 = load float, float* %.3
  ret float %.13 
.7:
  %.15 = load float, float* %.3
  %.17 = fsub float 0x0, %.15
  ret float %.17 
}
define float @my_pow(float %.22, i32 %.25){
.20:
  %.40 = alloca float
  %.24 = alloca i32
  %.21 = alloca float
  store float %.22, float* %.21
  store i32 %.25, i32* %.24
  %.29 = load i32, i32* %.24
  %.30 = icmp slt i32 %.29, 0
  br i1 %.30, label %.27, label %.28
.27:
  %.33 = load float, float* %.21
  %.34 = load i32, i32* %.24
  %.35 = sub i32 0, %.34
  %.36at11 = call float @my_pow(float %.33, i32 %.35)
  %.37 = sitofp i32 1 to float
  %.38 = fdiv float %.37, %.36at11
  ret float %.38 
.28:
  store float 0x3ff0000000000000, float* %.40
  br label %.43wc13 
.43wc13:
  %.47 = load i32, i32* %.24
  %.48 = icmp ne i32 %.47, 0
  br i1 %.48, label %.44wloop.13.17, label %.45wn17
.44wloop.13.17:
  %.52 = load i32, i32* %.24
  %.54 = srem i32 %.52, 2
  %.55 = icmp ne i32 %.54, 0
  br i1 %.55, label %.50, label %.51
.45wn17:
  %.70 = load float, float* %.40
  ret float %.70 
.50:
  %.57 = load float, float* %.40
  %.58 = load float, float* %.21
  %.59 = fmul float %.57, %.58
  store float %.59, float* %.40
  br label %.51 
.51:
  %.62 = load float, float* %.21
  %.63 = load float, float* %.21
  %.64 = fmul float %.62, %.63
  store float %.64, float* %.21
  %.66 = load i32, i32* %.24
  %.67 = sdiv i32 %.66, 2
  store i32 %.67, i32* %.24
  br label %.43wc13 
}
define float @my_sqrt(float %.75){
.73:
  %.108 = alloca i32
  %.91 = alloca float
  %.74 = alloca float
  store float %.75, float* %.74
  %.79 = load float, float* %.74
  %.81 = sitofp i32 100 to float
  %.82 = fcmp ugt float %.79, %.81
  br i1 %.82, label %.77, label %.78
.77:
  %.85 = load float, float* %.74
  %.86 = sitofp i32 100 to float
  %.87 = fdiv float %.85, %.86
  %.88at22 = call float @my_sqrt(float %.87)
  %.89 = fmul float 0x4024000000000000, %.88at22
  ret float %.89 
.78:
  %.92 = load float, float* %.74
  %.94 = sitofp i32 8 to float
  %.95 = fdiv float %.92, %.94
  %.97 = fadd float %.95, 0x3fe0000000000000
  %.98 = load float, float* %.74
  %.99 = sitofp i32 2 to float
  %.100 = fmul float %.99, %.98
  %.102 = load float, float* %.74
  %.103 = sitofp i32 4 to float
  %.104 = fadd float %.103, %.102
  %.105 = fdiv float %.100, %.104
  %.106 = fadd float %.97, %.105
  store float %.106, float* %.91
  store i32 10, i32* %.108
  br label %.111wc25 
.111wc25:
  %.115 = load i32, i32* %.108
  %.116 = icmp ne i32 %.115, 0
  br i1 %.116, label %.112wloop.25.28, label %.113wn28
.112wloop.25.28:
  %.118 = load float, float* %.91
  %.119 = load float, float* %.74
  %.120 = load float, float* %.91
  %.121 = fdiv float %.119, %.120
  %.122 = fadd float %.118, %.121
  %.123 = sitofp i32 2 to float
  %.124 = fdiv float %.122, %.123
  store float %.124, float* %.91
  %.126 = load i32, i32* %.108
  %.127 = sub i32 %.126, 1
  store i32 %.127, i32* %.108
  br label %.111wc25 
.113wn28:
  %.130 = load float, float* %.91
  ret float %.130 
}
define float @F1(float %.135){
.133:
  %.134 = alloca float
  store float %.135, float* %.134
  %.137 = load float, float* %.134
  %.138 = sitofp i32 1 to float
  %.139 = fdiv float %.138, %.137
  ret float %.139 
}
define float @F2(float %.144){
.142:
  %.143 = alloca float
  store float %.144, float* %.143
  %.146 = load float, float* %.143
  %.147 = load float, float* %.143
  %.148 = fmul float %.146, %.147
  %.149 = sitofp i32 1 to float
  %.150 = fsub float %.149, %.148
  %.151at34 = call float @my_sqrt(float %.150)
  %.152 = sitofp i32 1 to float
  %.153 = fdiv float %.152, %.151at34
  ret float %.153 
}
define float @simpson(float %.158, float %.161, i32 %.164){
.156:
  %.166 = alloca float
  %.163 = alloca i32
  %.160 = alloca float
  %.157 = alloca float
  store float %.158, float* %.157
  store float %.161, float* %.160
  store i32 %.164, i32* %.163
  %.167 = load float, float* %.157
  %.168 = load float, float* %.160
  %.169 = load float, float* %.157
  %.170 = fsub float %.168, %.169
  %.171 = sitofp i32 2 to float
  %.172 = fdiv float %.170, %.171
  %.173 = fadd float %.167, %.172
  store float %.173, float* %.166
  %.177 = load i32, i32* %.163
  %.178 = icmp eq i32 %.177, 1
  br i1 %.178, label %.175, label %.176
.175:
  %.180 = load float, float* %.157
  %.181at38 = call float @F1(float %.180)
  %.182 = load float, float* %.166
  %.183at38 = call float @F1(float %.182)
  %.184 = sitofp i32 4 to float
  %.185 = fmul float %.184, %.183at38
  %.186 = fadd float %.181at38, %.185
  %.187 = load float, float* %.160
  %.188at38 = call float @F1(float %.187)
  %.189 = fadd float %.186, %.188at38
  %.190 = load float, float* %.160
  %.191 = load float, float* %.157
  %.192 = fsub float %.190, %.191
  %.193 = fmul float %.189, %.192
  %.195 = sitofp i32 6 to float
  %.196 = fdiv float %.193, %.195
  ret float %.196 
.176:
  %.200 = load i32, i32* %.163
  %.201 = icmp eq i32 %.200, 2
  br i1 %.201, label %.198, label %.199
.198:
  %.203 = load float, float* %.157
  %.204at39 = call float @F2(float %.203)
  %.205 = load float, float* %.166
  %.206at39 = call float @F2(float %.205)
  %.207 = sitofp i32 4 to float
  %.208 = fmul float %.207, %.206at39
  %.209 = fadd float %.204at39, %.208
  %.210 = load float, float* %.160
  %.211at39 = call float @F2(float %.210)
  %.212 = fadd float %.209, %.211at39
  %.213 = load float, float* %.160
  %.214 = load float, float* %.157
  %.215 = fsub float %.213, %.214
  %.216 = fmul float %.212, %.215
  %.217 = sitofp i32 6 to float
  %.218 = fdiv float %.216, %.217
  ret float %.218 
.199:
  %.220 = sitofp i32 0 to float
  ret float %.220 
}
define float @asr5(float %.225, float %.228, float %.231, float %.234, i32 %.237){
.223:
  %.254 = alloca float
  %.248 = alloca float
  %.239 = alloca float
  %.236 = alloca i32
  %.233 = alloca float
  %.230 = alloca float
  %.227 = alloca float
  %.224 = alloca float
  store float %.225, float* %.224
  store float %.228, float* %.227
  store float %.231, float* %.230
  store float %.234, float* %.233
  store i32 %.237, i32* %.236
  %.240 = load float, float* %.224
  %.241 = load float, float* %.227
  %.242 = load float, float* %.224
  %.243 = fsub float %.241, %.242
  %.244 = sitofp i32 2 to float
  %.245 = fdiv float %.243, %.244
  %.246 = fadd float %.240, %.245
  store float %.246, float* %.239
  %.249 = load float, float* %.224
  %.250 = load float, float* %.239
  %.251 = load i32, i32* %.236
  %.252at45 = call float @simpson(float %.249, float %.250, i32 %.251)
  store float %.252at45, float* %.248
  %.255 = load float, float* %.239
  %.256 = load float, float* %.227
  %.257 = load i32, i32* %.236
  %.258at45 = call float @simpson(float %.255, float %.256, i32 %.257)
  store float %.258at45, float* %.254
  %.262 = load float, float* %.248
  %.263 = load float, float* %.254
  %.264 = fadd float %.262, %.263
  %.265 = load float, float* %.233
  %.266 = fsub float %.264, %.265
  %.267at46 = call float @my_fabs(float %.266)
  %.269 = load float, float* %.230
  %.270 = sitofp i32 15 to float
  %.271 = fmul float %.270, %.269
  %.272 = fcmp ule float %.267at46, %.271
  br i1 %.272, label %.260, label %.261
.260:
  %.274 = load float, float* %.248
  %.275 = load float, float* %.254
  %.276 = fadd float %.274, %.275
  %.277 = load float, float* %.248
  %.278 = load float, float* %.254
  %.279 = fadd float %.277, %.278
  %.280 = load float, float* %.233
  %.281 = fsub float %.279, %.280
  %.283 = fdiv float %.281, 0x402e000000000000
  %.284 = fadd float %.276, %.283
  ret float %.284 
.261:
  %.286 = load float, float* %.224
  %.287 = load float, float* %.239
  %.288 = load float, float* %.230
  %.289 = sitofp i32 2 to float
  %.290 = fdiv float %.288, %.289
  %.291 = load float, float* %.248
  %.292 = load i32, i32* %.236
  %.293at47 = call float @asr5(float %.286, float %.287, float %.290, float %.291, i32 %.292)
  %.294 = load float, float* %.239
  %.295 = load float, float* %.227
  %.296 = load float, float* %.230
  %.297 = sitofp i32 2 to float
  %.298 = fdiv float %.296, %.297
  %.299 = load float, float* %.254
  %.300 = load i32, i32* %.236
  %.301at47 = call float @asr5(float %.294, float %.295, float %.298, float %.299, i32 %.300)
  %.302 = fadd float %.293at47, %.301at47
  ret float %.302 
}
define float @asr4(float %.307, float %.310, float %.313, i32 %.316){
.305:
  %.315 = alloca i32
  %.312 = alloca float
  %.309 = alloca float
  %.306 = alloca float
  store float %.307, float* %.306
  store float %.310, float* %.309
  store float %.313, float* %.312
  store i32 %.316, i32* %.315
  %.318 = load float, float* %.306
  %.319 = load float, float* %.309
  %.320 = load float, float* %.312
  %.321 = load float, float* %.306
  %.322 = load float, float* %.309
  %.323 = load i32, i32* %.315
  %.324at51 = call float @simpson(float %.321, float %.322, i32 %.323)
  %.325 = load i32, i32* %.315
  %.326at51 = call float @asr5(float %.318, float %.319, float %.320, float %.324at51, i32 %.325)
  ret float %.326at51 
}
define float @eee(float %.331){
.329:
  %.339 = alloca float
  %.330 = alloca float
  store float %.331, float* %.330
  %.335 = load float, float* %.330
  %.337 = fcmp ugt float %.335, 0x3f50624de0000000
  br i1 %.337, label %.333, label %.334
.333:
  %.340 = load float, float* %.330
  %.341 = sitofp i32 2 to float
  %.342 = fdiv float %.340, %.341
  %.343at56 = call float @eee(float %.342)
  store float %.343at56, float* %.339
  %.345 = load float, float* %.339
  %.346 = load float, float* %.339
  %.347 = fmul float %.345, %.346
  ret float %.347 
.334:
  %.349 = load float, float* %.330
  %.350 = sitofp i32 1 to float
  %.351 = fadd float %.350, %.349
  %.352 = load float, float* %.330
  %.353 = load float, float* %.330
  %.354 = fmul float %.352, %.353
  %.355 = sitofp i32 2 to float
  %.356 = fdiv float %.354, %.355
  %.357 = fadd float %.351, %.356
  %.358 = load float, float* %.330
  %.360at59 = call float @my_pow(float %.358, i32 3)
  %.361 = sitofp i32 6 to float
  %.362 = fdiv float %.360at59, %.361
  %.363 = fadd float %.357, %.362
  %.364 = load float, float* %.330
  %.365at59 = call float @my_pow(float %.364, i32 4)
  %.367 = sitofp i32 24 to float
  %.368 = fdiv float %.365at59, %.367
  %.369 = fadd float %.363, %.368
  %.370 = load float, float* %.330
  %.372at60 = call float @my_pow(float %.370, i32 5)
  %.374 = sitofp i32 120 to float
  %.375 = fdiv float %.372at60, %.374
  %.376 = fadd float %.369, %.375
  ret float %.376 
}
define float @my_exp(float %.381){
.379:
  %.408 = alloca float
  %.404 = alloca float
  %.395 = alloca i32
  %.380 = alloca float
  store float %.381, float* %.380
  %.385 = load float, float* %.380
  %.386 = sitofp i32 0 to float
  %.387 = fcmp ult float %.385, %.386
  br i1 %.387, label %.383, label %.384
.383:
  %.389 = load float, float* %.380
  %.390 = fsub float 0x0, %.389
  %.391at64 = call float @my_exp(float %.390)
  %.392 = sitofp i32 1 to float
  %.393 = fdiv float %.392, %.391at64
  ret float %.393 
.384:
  %.396 = load float, float* %.380
  %.397 = fptosi float %.396 to i32
  store i32 %.397, i32* %.395
  %.399 = load float, float* %.380
  %.400 = load i32, i32* %.395
  %.401 = sitofp i32 %.400 to float
  %.402 = fsub float %.399, %.401
  store float %.402, float* %.380
  %.405 = load i32, i32* %.395
  %.406at67 = call float @my_pow(float 0x4005bf0a80000000, i32 %.405)
  store float %.406at67, float* %.404
  %.409 = load float, float* %.380
  %.410at68 = call float @eee(float %.409)
  store float %.410at68, float* %.408
  %.412 = load float, float* %.404
  %.413 = load float, float* %.408
  %.414 = fmul float %.412, %.413
  ret float %.414 
}
define float @my_ln(float %.419){
.417:
  %.418 = alloca float
  store float %.419, float* %.418
  %.421 = load float, float* %.418
  %.423 = sitofp i32 1 to float
  %.424at72 = call float @asr4(float %.423, float %.421, float 0x3e45798ee0000000, i32 1)
  ret float %.424at72 
}
define float @my_log(float %.429, float %.432){
.427:
  %.431 = alloca float
  %.428 = alloca float
  store float %.429, float* %.428
  store float %.432, float* %.431
  %.434 = load float, float* %.431
  %.435at74 = call float @my_ln(float %.434)
  %.436 = load float, float* %.428
  %.437at74 = call float @my_ln(float %.436)
  %.438 = fdiv float %.435at74, %.437at74
  ret float %.438 
}
define float @my_powf(float %.443, float %.446){
.441:
  %.445 = alloca float
  %.442 = alloca float
  store float %.443, float* %.442
  store float %.446, float* %.445
  %.448 = load float, float* %.445
  %.449 = load float, float* %.442
  %.450at76 = call float @my_ln(float %.449)
  %.451 = fmul float %.448, %.450at76
  %.452at76 = call float @my_exp(float %.451)
  ret float %.452at76 
}
define i32 @main(){
.455:
  %.471 = alloca float
  %.467 = alloca float
  %.456 = alloca i32
  %.458at79 = call i32 @getint()
  store i32 %.458at79, i32* %.456
  br label %.460wc80 
.460wc80:
  %.464 = load i32, i32* %.456
  %.465 = icmp ne i32 %.464, 0
  br i1 %.465, label %.461wloop.80.109, label %.462wn109
.461wloop.80.109:
  %.469at81 = call float @getfloat()
  store float %.469at81, float* %.467
  %.472at81 = call float @getfloat()
  store float %.472at81, float* %.471
  %.474 = load float, float* %.467
  %.475at82 = call float @my_fabs(float %.474)
  call void @putfloat(float %.475at82)
  call void @putch(i32 32)
  %.481 = load float, float* %.467
  %.482at84 = call float @my_pow(float %.481, i32 2)
  call void @putfloat(float %.482at84)
  call void @putch(i32 32)
  %.485 = load float, float* %.467
  %.486at86 = call float @my_sqrt(float %.485)
  call void @putfloat(float %.486at86)
  call void @putch(i32 32)
  %.489 = load float, float* %.467
  %.490at88 = call float @my_exp(float %.489)
  call void @putfloat(float %.490at88)
  call void @putch(i32 32)
  %.495 = load float, float* %.467
  %.496 = sitofp i32 0 to float
  %.497 = fcmp ugt float %.495, %.496
  br i1 %.497, label %.493, label %.494
.462wn109:
  ret i32 0 
.493:
  %.499 = load float, float* %.467
  %.500at91 = call float @my_ln(float %.499)
  call void @putfloat(float %.500at91)
  br label %.502 
.494:
  call void @putch(i32 45)
  br label %.502 
.502:
  call void @putch(i32 32)
  %.510 = load float, float* %.467
  %.511 = sitofp i32 0 to float
  %.512 = fcmp ugt float %.510, %.511
  br i1 %.512, label %.513, label %.509
.508:
  %.519 = load float, float* %.467
  %.520 = load float, float* %.471
  %.521at97 = call float @my_log(float %.519, float %.520)
  call void @putfloat(float %.521at97)
  br label %.523 
.509:
  call void @putch(i32 45)
  br label %.523 
.513:
  %.515 = load float, float* %.471
  %.516 = sitofp i32 0 to float
  %.517 = fcmp ugt float %.515, %.516
  br i1 %.517, label %.508, label %.509
.523:
  call void @putch(i32 32)
  %.530 = load float, float* %.467
  %.531 = sitofp i32 0 to float
  %.532 = fcmp ugt float %.530, %.531
  br i1 %.532, label %.528, label %.529
.528:
  %.534 = load float, float* %.467
  %.535 = load float, float* %.471
  %.536at103 = call float @my_powf(float %.534, float %.535)
  call void @putfloat(float %.536at103)
  br label %.538 
.529:
  call void @putch(i32 45)
  br label %.538 
.538:
  call void @putch(i32 10)
  %.543 = load i32, i32* %.456
  %.544 = sub i32 %.543, 1
  store i32 %.544, i32* %.456
  br label %.460wc80 
}
define float @my_fabs(float %.4){
.2:
  %.3 = alloca float
  store float %.4, float* %.3
  %.8 = load float, float* %.3
  %.10 = sitofp i32 0 to float
  %.11 = fcmp ugt float %.8, %.10
  br i1 %.11, label %.6, label %.7
.6:
  %.13 = load float, float* %.3
  ret float %.13 
.7:
  %.15 = load float, float* %.3
  %.17 = fsub float 0x0, %.15
  ret float %.17 
}
define float @my_pow(float %.22, i32 %.25){
.20:
  %.40 = alloca float
  %.24 = alloca i32
  %.21 = alloca float
  store float %.22, float* %.21
  store i32 %.25, i32* %.24
  %.29 = load i32, i32* %.24
  %.30 = icmp slt i32 %.29, 0
  br i1 %.30, label %.27, label %.28
.27:
  %.33 = load float, float* %.21
  %.34 = load i32, i32* %.24
  %.35 = sub i32 0, %.34
  %.36at11 = call float @my_pow(float %.33, i32 %.35)
  %.37 = sitofp i32 1 to float
  %.38 = fdiv float %.37, %.36at11
  ret float %.38 
.28:
  store float 0x3ff0000000000000, float* %.40
  br label %.43wc13 
.43wc13:
  %.47 = load i32, i32* %.24
  %.48 = icmp ne i32 %.47, 0
  br i1 %.48, label %.44wloop.13.17, label %.45wn17
.44wloop.13.17:
  %.52 = load i32, i32* %.24
  %.54 = srem i32 %.52, 2
  %.55 = icmp ne i32 %.54, 0
  br i1 %.55, label %.50, label %.51
.45wn17:
  %.70 = load float, float* %.40
  ret float %.70 
.50:
  %.57 = load float, float* %.40
  %.58 = load float, float* %.21
  %.59 = fmul float %.57, %.58
  store float %.59, float* %.40
  br label %.51 
.51:
  %.62 = load float, float* %.21
  %.63 = load float, float* %.21
  %.64 = fmul float %.62, %.63
  store float %.64, float* %.21
  %.66 = load i32, i32* %.24
  %.67 = sdiv i32 %.66, 2
  store i32 %.67, i32* %.24
  br label %.43wc13 
}
define float @my_sqrt(float %.75){
.73:
  %.108 = alloca i32
  %.91 = alloca float
  %.74 = alloca float
  store float %.75, float* %.74
  %.79 = load float, float* %.74
  %.81 = sitofp i32 100 to float
  %.82 = fcmp ugt float %.79, %.81
  br i1 %.82, label %.77, label %.78
.77:
  %.85 = load float, float* %.74
  %.86 = sitofp i32 100 to float
  %.87 = fdiv float %.85, %.86
  %.88at22 = call float @my_sqrt(float %.87)
  %.89 = fmul float 0x4024000000000000, %.88at22
  ret float %.89 
.78:
  %.92 = load float, float* %.74
  %.94 = sitofp i32 8 to float
  %.95 = fdiv float %.92, %.94
  %.97 = fadd float %.95, 0x3fe0000000000000
  %.98 = load float, float* %.74
  %.99 = sitofp i32 2 to float
  %.100 = fmul float %.99, %.98
  %.102 = load float, float* %.74
  %.103 = sitofp i32 4 to float
  %.104 = fadd float %.103, %.102
  %.105 = fdiv float %.100, %.104
  %.106 = fadd float %.97, %.105
  store float %.106, float* %.91
  store i32 10, i32* %.108
  br label %.111wc25 
.111wc25:
  %.115 = load i32, i32* %.108
  %.116 = icmp ne i32 %.115, 0
  br i1 %.116, label %.112wloop.25.28, label %.113wn28
.112wloop.25.28:
  %.118 = load float, float* %.91
  %.119 = load float, float* %.74
  %.120 = load float, float* %.91
  %.121 = fdiv float %.119, %.120
  %.122 = fadd float %.118, %.121
  %.123 = sitofp i32 2 to float
  %.124 = fdiv float %.122, %.123
  store float %.124, float* %.91
  %.126 = load i32, i32* %.108
  %.127 = sub i32 %.126, 1
  store i32 %.127, i32* %.108
  br label %.111wc25 
.113wn28:
  %.130 = load float, float* %.91
  ret float %.130 
}
define float @F1(float %.135){
.133:
  %.134 = alloca float
  store float %.135, float* %.134
  %.137 = load float, float* %.134
  %.138 = sitofp i32 1 to float
  %.139 = fdiv float %.138, %.137
  ret float %.139 
}
define float @F2(float %.144){
.142:
  %.143 = alloca float
  store float %.144, float* %.143
  %.146 = load float, float* %.143
  %.147 = load float, float* %.143
  %.148 = fmul float %.146, %.147
  %.149 = sitofp i32 1 to float
  %.150 = fsub float %.149, %.148
  %.151at34 = call float @my_sqrt(float %.150)
  %.152 = sitofp i32 1 to float
  %.153 = fdiv float %.152, %.151at34
  ret float %.153 
}
define float @simpson(float %.158, float %.161, i32 %.164){
.156:
  %.166 = alloca float
  %.163 = alloca i32
  %.160 = alloca float
  %.157 = alloca float
  store float %.158, float* %.157
  store float %.161, float* %.160
  store i32 %.164, i32* %.163
  %.167 = load float, float* %.157
  %.168 = load float, float* %.160
  %.169 = load float, float* %.157
  %.170 = fsub float %.168, %.169
  %.171 = sitofp i32 2 to float
  %.172 = fdiv float %.170, %.171
  %.173 = fadd float %.167, %.172
  store float %.173, float* %.166
  %.177 = load i32, i32* %.163
  %.178 = icmp eq i32 %.177, 1
  br i1 %.178, label %.175, label %.176
.175:
  %.180 = load float, float* %.157
  %.181at38 = call float @F1(float %.180)
  %.182 = load float, float* %.166
  %.183at38 = call float @F1(float %.182)
  %.184 = sitofp i32 4 to float
  %.185 = fmul float %.184, %.183at38
  %.186 = fadd float %.181at38, %.185
  %.187 = load float, float* %.160
  %.188at38 = call float @F1(float %.187)
  %.189 = fadd float %.186, %.188at38
  %.190 = load float, float* %.160
  %.191 = load float, float* %.157
  %.192 = fsub float %.190, %.191
  %.193 = fmul float %.189, %.192
  %.195 = sitofp i32 6 to float
  %.196 = fdiv float %.193, %.195
  ret float %.196 
.176:
  %.200 = load i32, i32* %.163
  %.201 = icmp eq i32 %.200, 2
  br i1 %.201, label %.198, label %.199
.198:
  %.203 = load float, float* %.157
  %.204at39 = call float @F2(float %.203)
  %.205 = load float, float* %.166
  %.206at39 = call float @F2(float %.205)
  %.207 = sitofp i32 4 to float
  %.208 = fmul float %.207, %.206at39
  %.209 = fadd float %.204at39, %.208
  %.210 = load float, float* %.160
  %.211at39 = call float @F2(float %.210)
  %.212 = fadd float %.209, %.211at39
  %.213 = load float, float* %.160
  %.214 = load float, float* %.157
  %.215 = fsub float %.213, %.214
  %.216 = fmul float %.212, %.215
  %.217 = sitofp i32 6 to float
  %.218 = fdiv float %.216, %.217
  ret float %.218 
.199:
  %.220 = sitofp i32 0 to float
  ret float %.220 
}
define float @asr5(float %.225, float %.228, float %.231, float %.234, i32 %.237){
.223:
  %.254 = alloca float
  %.248 = alloca float
  %.239 = alloca float
  %.236 = alloca i32
  %.233 = alloca float
  %.230 = alloca float
  %.227 = alloca float
  %.224 = alloca float
  store float %.225, float* %.224
  store float %.228, float* %.227
  store float %.231, float* %.230
  store float %.234, float* %.233
  store i32 %.237, i32* %.236
  %.240 = load float, float* %.224
  %.241 = load float, float* %.227
  %.242 = load float, float* %.224
  %.243 = fsub float %.241, %.242
  %.244 = sitofp i32 2 to float
  %.245 = fdiv float %.243, %.244
  %.246 = fadd float %.240, %.245
  store float %.246, float* %.239
  %.249 = load float, float* %.224
  %.250 = load float, float* %.239
  %.251 = load i32, i32* %.236
  %.252at45 = call float @simpson(float %.249, float %.250, i32 %.251)
  store float %.252at45, float* %.248
  %.255 = load float, float* %.239
  %.256 = load float, float* %.227
  %.257 = load i32, i32* %.236
  %.258at45 = call float @simpson(float %.255, float %.256, i32 %.257)
  store float %.258at45, float* %.254
  %.262 = load float, float* %.248
  %.263 = load float, float* %.254
  %.264 = fadd float %.262, %.263
  %.265 = load float, float* %.233
  %.266 = fsub float %.264, %.265
  %.267at46 = call float @my_fabs(float %.266)
  %.269 = load float, float* %.230
  %.270 = sitofp i32 15 to float
  %.271 = fmul float %.270, %.269
  %.272 = fcmp ule float %.267at46, %.271
  br i1 %.272, label %.260, label %.261
.260:
  %.274 = load float, float* %.248
  %.275 = load float, float* %.254
  %.276 = fadd float %.274, %.275
  %.277 = load float, float* %.248
  %.278 = load float, float* %.254
  %.279 = fadd float %.277, %.278
  %.280 = load float, float* %.233
  %.281 = fsub float %.279, %.280
  %.283 = fdiv float %.281, 0x402e000000000000
  %.284 = fadd float %.276, %.283
  ret float %.284 
.261:
  %.286 = load float, float* %.224
  %.287 = load float, float* %.239
  %.288 = load float, float* %.230
  %.289 = sitofp i32 2 to float
  %.290 = fdiv float %.288, %.289
  %.291 = load float, float* %.248
  %.292 = load i32, i32* %.236
  %.293at47 = call float @asr5(float %.286, float %.287, float %.290, float %.291, i32 %.292)
  %.294 = load float, float* %.239
  %.295 = load float, float* %.227
  %.296 = load float, float* %.230
  %.297 = sitofp i32 2 to float
  %.298 = fdiv float %.296, %.297
  %.299 = load float, float* %.254
  %.300 = load i32, i32* %.236
  %.301at47 = call float @asr5(float %.294, float %.295, float %.298, float %.299, i32 %.300)
  %.302 = fadd float %.293at47, %.301at47
  ret float %.302 
}
define float @asr4(float %.307, float %.310, float %.313, i32 %.316){
.305:
  %.315 = alloca i32
  %.312 = alloca float
  %.309 = alloca float
  %.306 = alloca float
  store float %.307, float* %.306
  store float %.310, float* %.309
  store float %.313, float* %.312
  store i32 %.316, i32* %.315
  %.318 = load float, float* %.306
  %.319 = load float, float* %.309
  %.320 = load float, float* %.312
  %.321 = load float, float* %.306
  %.322 = load float, float* %.309
  %.323 = load i32, i32* %.315
  %.324at51 = call float @simpson(float %.321, float %.322, i32 %.323)
  %.325 = load i32, i32* %.315
  %.326at51 = call float @asr5(float %.318, float %.319, float %.320, float %.324at51, i32 %.325)
  ret float %.326at51 
}
define float @eee(float %.331){
.329:
  %.339 = alloca float
  %.330 = alloca float
  store float %.331, float* %.330
  %.335 = load float, float* %.330
  %.337 = fcmp ugt float %.335, 0x3f50624de0000000
  br i1 %.337, label %.333, label %.334
.333:
  %.340 = load float, float* %.330
  %.341 = sitofp i32 2 to float
  %.342 = fdiv float %.340, %.341
  %.343at56 = call float @eee(float %.342)
  store float %.343at56, float* %.339
  %.345 = load float, float* %.339
  %.346 = load float, float* %.339
  %.347 = fmul float %.345, %.346
  ret float %.347 
.334:
  %.349 = load float, float* %.330
  %.350 = sitofp i32 1 to float
  %.351 = fadd float %.350, %.349
  %.352 = load float, float* %.330
  %.353 = load float, float* %.330
  %.354 = fmul float %.352, %.353
  %.355 = sitofp i32 2 to float
  %.356 = fdiv float %.354, %.355
  %.357 = fadd float %.351, %.356
  %.358 = load float, float* %.330
  %.360at59 = call float @my_pow(float %.358, i32 3)
  %.361 = sitofp i32 6 to float
  %.362 = fdiv float %.360at59, %.361
  %.363 = fadd float %.357, %.362
  %.364 = load float, float* %.330
  %.365at59 = call float @my_pow(float %.364, i32 4)
  %.367 = sitofp i32 24 to float
  %.368 = fdiv float %.365at59, %.367
  %.369 = fadd float %.363, %.368
  %.370 = load float, float* %.330
  %.372at60 = call float @my_pow(float %.370, i32 5)
  %.374 = sitofp i32 120 to float
  %.375 = fdiv float %.372at60, %.374
  %.376 = fadd float %.369, %.375
  ret float %.376 
}
define float @my_exp(float %.381){
.379:
  %.408 = alloca float
  %.404 = alloca float
  %.395 = alloca i32
  %.380 = alloca float
  store float %.381, float* %.380
  %.385 = load float, float* %.380
  %.386 = sitofp i32 0 to float
  %.387 = fcmp ult float %.385, %.386
  br i1 %.387, label %.383, label %.384
.383:
  %.389 = load float, float* %.380
  %.390 = fsub float 0x0, %.389
  %.391at64 = call float @my_exp(float %.390)
  %.392 = sitofp i32 1 to float
  %.393 = fdiv float %.392, %.391at64
  ret float %.393 
.384:
  %.396 = load float, float* %.380
  %.397 = fptosi float %.396 to i32
  store i32 %.397, i32* %.395
  %.399 = load float, float* %.380
  %.400 = load i32, i32* %.395
  %.401 = sitofp i32 %.400 to float
  %.402 = fsub float %.399, %.401
  store float %.402, float* %.380
  %.405 = load i32, i32* %.395
  %.406at67 = call float @my_pow(float 0x4005bf0a80000000, i32 %.405)
  store float %.406at67, float* %.404
  %.409 = load float, float* %.380
  %.410at68 = call float @eee(float %.409)
  store float %.410at68, float* %.408
  %.412 = load float, float* %.404
  %.413 = load float, float* %.408
  %.414 = fmul float %.412, %.413
  ret float %.414 
}
define float @my_ln(float %.419){
.417:
  %.418 = alloca float
  store float %.419, float* %.418
  %.421 = load float, float* %.418
  %.423 = sitofp i32 1 to float
  %.424at72 = call float @asr4(float %.423, float %.421, float 0x3e45798ee0000000, i32 1)
  ret float %.424at72 
}
define float @my_log(float %.429, float %.432){
.427:
  %.431 = alloca float
  %.428 = alloca float
  store float %.429, float* %.428
  store float %.432, float* %.431
  %.434 = load float, float* %.431
  %.435at74 = call float @my_ln(float %.434)
  %.436 = load float, float* %.428
  %.437at74 = call float @my_ln(float %.436)
  %.438 = fdiv float %.435at74, %.437at74
  ret float %.438 
}
define float @my_powf(float %.443, float %.446){
.441:
  %.445 = alloca float
  %.442 = alloca float
  store float %.443, float* %.442
  store float %.446, float* %.445
  %.448 = load float, float* %.445
  %.449 = load float, float* %.442
  %.450at76 = call float @my_ln(float %.449)
  %.451 = fmul float %.448, %.450at76
  %.452at76 = call float @my_exp(float %.451)
  ret float %.452at76 
}
define i32 @main(){
.455:
  %.471 = alloca float
  %.467 = alloca float
  %.456 = alloca i32
  %.458at79 = call i32 @getint()
  store i32 %.458at79, i32* %.456
  br label %.460wc80 
.460wc80:
  %.464 = load i32, i32* %.456
  %.465 = icmp ne i32 %.464, 0
  br i1 %.465, label %.461wloop.80.109, label %.462wn109
.461wloop.80.109:
  %.469at81 = call float @getfloat()
  store float %.469at81, float* %.467
  %.472at81 = call float @getfloat()
  store float %.472at81, float* %.471
  %.474 = load float, float* %.467
  %.475at82 = call float @my_fabs(float %.474)
  call void @putfloat(float %.475at82)
  call void @putch(i32 32)
  %.481 = load float, float* %.467
  %.482at84 = call float @my_pow(float %.481, i32 2)
  call void @putfloat(float %.482at84)
  call void @putch(i32 32)
  %.485 = load float, float* %.467
  %.486at86 = call float @my_sqrt(float %.485)
  call void @putfloat(float %.486at86)
  call void @putch(i32 32)
  %.489 = load float, float* %.467
  %.490at88 = call float @my_exp(float %.489)
  call void @putfloat(float %.490at88)
  call void @putch(i32 32)
  %.495 = load float, float* %.467
  %.496 = sitofp i32 0 to float
  %.497 = fcmp ugt float %.495, %.496
  br i1 %.497, label %.493, label %.494
.462wn109:
  ret i32 0 
.493:
  %.499 = load float, float* %.467
  %.500at91 = call float @my_ln(float %.499)
  call void @putfloat(float %.500at91)
  br label %.502 
.494:
  call void @putch(i32 45)
  br label %.502 
.502:
  call void @putch(i32 32)
  %.510 = load float, float* %.467
  %.511 = sitofp i32 0 to float
  %.512 = fcmp ugt float %.510, %.511
  br i1 %.512, label %.513, label %.509
.508:
  %.519 = load float, float* %.467
  %.520 = load float, float* %.471
  %.521at97 = call float @my_log(float %.519, float %.520)
  call void @putfloat(float %.521at97)
  br label %.523 
.509:
  call void @putch(i32 45)
  br label %.523 
.513:
  %.515 = load float, float* %.471
  %.516 = sitofp i32 0 to float
  %.517 = fcmp ugt float %.515, %.516
  br i1 %.517, label %.508, label %.509
.523:
  call void @putch(i32 32)
  %.530 = load float, float* %.467
  %.531 = sitofp i32 0 to float
  %.532 = fcmp ugt float %.530, %.531
  br i1 %.532, label %.528, label %.529
.528:
  %.534 = load float, float* %.467
  %.535 = load float, float* %.471
  %.536at103 = call float @my_powf(float %.534, flo