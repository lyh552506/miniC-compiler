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
@.g.image = global [1048576 x i32] zeroinitializer
@.g.width = global i32 zeroinitializer
@.g.height = global i32 zeroinitializer
define float @my_fabs(float %.11){
.9:
  %.10 = alloca float
  store float %.11, float* %.10
  %.15 = load float, float* %.10
  %.17 = sitofp i32 0 to float
  %.18 = fcmp ugt float %.15, %.17
  br i1 %.18, label %.13, label %.14
.13:
  %.20 = load float, float* %.10
  ret float %.20 
.14:
  %.22 = load float, float* %.10
  %.24 = fsub float 0x0, %.22
  ret float %.24 
}
define float @p(float %.29){
.27:
  %.28 = alloca float
  store float %.29, float* %.28
  %.32 = load float, float* %.28
  %.33 = sitofp i32 3 to float
  %.34 = fmul float %.33, %.32
  %.36 = load float, float* %.28
  %.37 = sitofp i32 4 to float
  %.38 = fmul float %.37, %.36
  %.39 = load float, float* %.28
  %.40 = fmul float %.38, %.39
  %.41 = load float, float* %.28
  %.42 = fmul float %.40, %.41
  %.43 = fsub float %.34, %.42
  ret float %.43 
}
define float @my_sin_impl(float %.48){
.46:
  %.47 = alloca float
  store float %.48, float* %.47
  %.52 = load float, float* %.47
  %.53at14 = call float @my_fabs(float %.52)
  %.54 = fcmp ule float %.53at14, 0x3eb0c6f7a0000000
  br i1 %.54, label %.50, label %.51
.50:
  %.56 = load float, float* %.47
  ret float %.56 
.51:
  %.58 = load float, float* %.47
  %.60 = fdiv float %.58, 0x4008000000000000
  %.61at15 = call float @my_sin_impl(float %.60)
  %.62at15 = call float @p(float %.61at15)
  ret float %.62at15 
}
define float @my_sin(float %.67){
.65:
  %.79 = alloca i32
  %.66 = alloca float
  store float %.67, float* %.66
  %.72 = load float, float* %.66
  %.73 = fcmp ugt float %.72, 0x401921fb60000000
  br i1 %.73, label %.69, label %.71
.69:
  %.80 = load float, float* %.66
  %.81 = fdiv float %.80, 0x401921fb60000000
  %.82 = fptosi float %.81 to i32
  store i32 %.82, i32* %.79
  %.84 = load float, float* %.66
  %.85 = load i32, i32* %.79
  %.86 = sitofp i32 %.85 to float
  %.87 = fmul float %.86, 0x401921fb60000000
  %.88 = fsub float %.84, %.87
  store float %.88, float* %.66
  br label %.70 
.70:
  %.93 = load float, float* %.66
  %.94 = fcmp ugt float %.93, 0x400921fb60000000
  br i1 %.94, label %.91, label %.92
.71:
  %.75 = load float, float* %.66
  %.77 = fcmp ult float %.75, 0xc01921fb60000000
  br i1 %.77, label %.69, label %.70
.91:
  %.96 = load float, float* %.66
  %.97 = fsub float %.96, 0x401921fb60000000
  store float %.97, float* %.66
  br label %.92 
.92:
  %.102 = load float, float* %.66
  %.104 = fcmp ult float %.102, 0xc00921fb60000000
  br i1 %.104, label %.100, label %.101
.100:
  %.106 = load float, float* %.66
  %.107 = fadd float %.106, 0x401921fb60000000
  store float %.107, float* %.66
  br label %.101 
.101:
  %.110 = load float, float* %.66
  %.111at25 = call float @my_sin_impl(float %.110)
  ret float %.111at25 
}
define float @my_cos(float %.116){
.114:
  %.115 = alloca float
  store float %.116, float* %.115
  %.118 = load float, float* %.115
  %.121 = fadd float %.118, 0x3ff921fb60000000
  %.122at28 = call float @my_sin(float %.121)
  ret float %.122at28 
}
define i32 @read_image(){
.125:
  %.171 = alloca i32
  %.161 = alloca i32
  %.130at31 = call i32 @getch()
  %.132 = icmp ne i32 %.130at31, 80
  br i1 %.132, label %.126, label %.128
.126:
  ret i32 -1 
.127:
  %.142at32 = call i32 @getint()
  store i32 %.142at32, i32* @.g.width
  %.144at33 = call i32 @getint()
  store i32 %.144at33, i32* @.g.height
  %.149 = load i32, i32* @.g.width
  %.150 = icmp sgt i32 %.149, 1024
  br i1 %.150, label %.146, label %.148
.128:
  %.134at31 = call i32 @getch()
  %.136 = icmp ne i32 %.134at31, 50
  br i1 %.136, label %.126, label %.127
.146:
  ret i32 -1 
.147:
  store i32 0, i32* %.161
  br label %.163wc36 
.148:
  %.153 = load i32, i32* @.g.height
  %.154 = icmp sgt i32 %.153, 1024
  br i1 %.154, label %.146, label %.152
.152:
  %.156at34 = call i32 @getint()
  %.158 = icmp ne i32 %.156at34, 255
  br i1 %.158, label %.146, label %.147
.163wc36:
  %.167 = load i32, i32* %.161
  %.168 = load i32, i32* @.g.height
  %.169 = icmp slt i32 %.167, %.168
  br i1 %.169, label %.164wloop.36.43, label %.165wn43
.164wloop.36.43:
  store i32 0, i32* %.171
  br label %.173wc38 
.165wn43:
  ret i32 0 
.173wc38:
  %.177 = load i32, i32* %.171
  %.178 = load i32, i32* @.g.width
  %.179 = icmp slt i32 %.177, %.178
  br i1 %.179, label %.174wloop.38.41, label %.175wn41
.174wloop.38.41:
  %.181at39 = call i32 @getint()
  %.182 = load i32, i32* %.161
  %.183 = load i32, i32* @.g.width
  %.184 = mul i32 %.182, %.183
  %.185 = load i32, i32* %.171
  %.186 = add i32 %.184, %.185
  %.187 = getelementptr inbounds [1048576 x i32], [1048576 x i32]* @.g.image, i32 0, i32 %.186
  store i32 %.181at39, i32* %.187
  %.189 = load i32, i32* %.171
  %.190 = add i32 %.189, 1
  store i32 %.190, i32* %.171
  br label %.173wc38 
.175wn41:
  %.193 = load i32, i32* %.161
  %.194 = add i32 %.193, 1
  store i32 %.194, i32* %.161
  br label %.163wc36 
}
define i32 @rotate(i32 %.201, i32 %.204, float %.207){
.199:
  %.250 = alloca i32
  %.235 = alloca i32
  %.230 = alloca i32
  %.225 = alloca i32
  %.221 = alloca i32
  %.217 = alloca i32
  %.213 = alloca float
  %.209 = alloca float
  %.206 = alloca float
  %.203 = alloca i32
  %.200 = alloca i32
  store i32 %.201, i32* %.200
  store i32 %.204, i32* %.203
  store float %.207, float* %.206
  %.210 = load float, float* %.206
  %.211at48 = call float @my_sin(float %.210)
  store float %.211at48, float* %.209
  %.214 = load float, float* %.206
  %.215at48 = call float @my_cos(float %.214)
  store float %.215at48, float* %.213
  %.218 = load i32, i32* @.g.width
  %.219 = sdiv i32 %.218, 2
  store i32 %.219, i32* %.217
  %.222 = load i32, i32* @.g.height
  %.223 = sdiv i32 %.222, 2
  store i32 %.223, i32* %.221
  %.226 = load i32, i32* %.200
  %.227 = load i32, i32* %.217
  %.228 = sub i32 %.226, %.227
  store i32 %.228, i32* %.225
  %.231 = load i32, i32* %.203
  %.232 = load i32, i32* %.221
  %.233 = sub i32 %.231, %.232
  store i32 %.233, i32* %.230
  %.236 = load i32, i32* %.225
  %.237 = load float, float* %.213
  %.238 = sitofp i32 %.236 to float
  %.239 = fmul float %.238, %.237
  %.240 = load i32, i32* %.230
  %.241 = load float, float* %.209
  %.242 = sitofp i32 %.240 to float
  %.243 = fmul float %.242, %.241
  %.244 = fsub float %.239, %.243
  %.245 = load i32, i32* %.217
  %.246 = sitofp i32 %.245 to float
  %.247 = fadd float %.244, %.246
  %.248 = fptosi float %.247 to i32
  store i32 %.248, i32* %.235
  %.251 = load i32, i32* %.225
  %.252 = load float, float* %.209
  %.253 = sitofp i32 %.251 to float
  %.254 = fmul float %.253, %.252
  %.255 = load i32, i32* %.230
  %.256 = load float, float* %.213
  %.257 = sitofp i32 %.255 to float
  %.258 = fmul float %.257, %.256
  %.259 = fadd float %.254, %.258
  %.260 = load i32, i32* %.221
  %.261 = sitofp i32 %.260 to float
  %.262 = fadd float %.259, %.261
  %.263 = fptosi float %.262 to i32
  store i32 %.263, i32* %.250
  %.268 = load i32, i32* %.235
  %.269 = icmp slt i32 %.268, 0
  br i1 %.269, label %.265, label %.267
.265:
  ret i32 0 
.266:
  %.285 = load i32, i32* %.250
  %.286 = load i32, i32* @.g.width
  %.287 = mul i32 %.285, %.286
  %.288 = load i32, i32* %.235
  %.289 = add i32 %.287, %.288
  %.290 = getelementptr inbounds [1048576 x i32], [1048576 x i32]* @.g.image, i32 0, i32 %.289
  %.291 = load i32, i32* %.290
  ret i32 %.291 
.267:
  %.272 = load i32, i32* %.235
  %.273 = load i32, i32* @.g.width
  %.274 = icmp sge i32 %.272, %.273
  br i1 %.274, label %.265, label %.271
.271:
  %.277 = load i32, i32* %.250
  %.278 = icmp slt i32 %.277, 0
  br i1 %.278, label %.265, label %.276
.276:
  %.280 = load i32, i32* %.250
  %.281 = load i32, i32* @.g.height
  %.282 = icmp sge i32 %.280, %.281
  br i1 %.282, label %.265, label %.266
}
define void @write_pgm(float %.296){
.294:
  %.323 = alloca i32
  %.313 = alloca i32
  %.295 = alloca float
  store float %.296, float* %.295
  call void @putch(i32 80)
  call void @putch(i32 50)
  call void @putch(i32 10)
  %.303 = load i32, i32* @.g.width
  call void @putint(i32 %.303)
  call void @putch(i32 32)
  %.308 = load i32, i32* @.g.height
  call void @putint(i32 %.308)
  call void @putch(i32 32)
  call void @putint(i32 255)
  call void @putch(i32 10)
  store i32 0, i32* %.313
  br label %.315wc62 
.315wc62:
  %.319 = load i32, i32* %.313
  %.320 = load i32, i32* @.g.height
  %.321 = icmp slt i32 %.319, %.320
  br i1 %.321, label %.316wloop.62.71, label %.317wn71
.316wloop.62.71:
  store i32 0, i32* %.323
  br label %.325wc64 
.317wn71:
  ret void
.325wc64:
  %.329 = load i32, i32* %.323
  %.330 = load i32, i32* @.g.width
  %.331 = icmp slt i32 %.329, %.330
  br i1 %.331, label %.326wloop.64.68, label %.327wn68
.326wloop.64.68:
  %.333 = load i32, i32* %.323
  %.334 = load i32, i32* %.313
  %.335 = load float, float* %.295
  %.336at65 = call i32 @rotate(i32 %.333, i32 %.334, float %.335)
  call void @putint(i32 %.336at65)
  call void @putch(i32 32)
  %.339 = load i32, i32* %.323
  %.340 = add i32 %.339, 1
  store i32 %.340, i32* %.323
  br label %.325wc64 
.327wn68:
  call void @putch(i32 10)
  %.344 = load i32, i32* %.313
  %.345 = add i32 %.344, 1
  store i32 %.345, i32* %.313
  br label %.315wc62 
}
define i32 @main(){
.350:
  %.351 = alloca float
  %.353at75 = call float @getfloat()
  store float %.353at75, float* %.351
  %.355at76 = call i32 @getch()
  %.358at77 = call i32 @read_image()
  %.359 = icmp slt i32 %.358at77, 0
  br i1 %.359, label %.356, label %.357
.356:
  ret i32 -1 
.357:
  %.362 = load float, float* %.351
  call void @write_pgm(float %.362)
  ret i32 0 
}
@.g.image = global [1048576 x i32] zeroinitializer
@.g.width = global i32 zeroinitializer
@.g.height = global i32 zeroinitializer
define float @my_fabs(float %.11){
.9:
  %.10 = alloca float
  store float %.11, float* %.10
  %.15 = load float, float* %.10
  %.17 = sitofp i32 0 to float
  %.18 = fcmp ugt float %.15, %.17
  br i1 %.18, label %.13, label %.14
.13:
  %.20 = load float, float* %.10
  ret float %.20 
.14:
  %.22 = load float, float* %.10
  %.24 = fsub float 0x0, %.22
  ret float %.24 
}
define float @p(float %.29){
.27:
  %.28 = alloca float
  store float %.29, float* %.28
  %.32 = load float, float* %.28
  %.33 = sitofp i32 3 to float
  %.34 = fmul float %.33, %.32
  %.36 = load float, float* %.28
  %.37 = sitofp i32 4 to float
  %.38 = fmul float %.37, %.36
  %.39 = load float, float* %.28
  %.40 = fmul float %.38, %.39
  %.41 = load float, float* %.28
  %.42 = fmul float %.40, %.41
  %.43 = fsub float %.34, %.42
  ret float %.43 
}
define float @my_sin_impl(float %.48){
.46:
  %.47 = alloca float
  store float %.48, float* %.47
  %.52 = load float, float* %.47
  %.53at14 = call float @my_fabs(float %.52)
  %.54 = fcmp ule float %.53at14, 0x3eb0c6f7a0000000
  br i1 %.54, label %.50, label %.51
.50:
  %.56 = load float, float* %.47
  ret float %.56 
.51:
  %.58 = load float, float* %.47
  %.60 = fdiv float %.58, 0x4008000000000000
  %.61at15 = call float @my_sin_impl(float %.60)
  %.62at15 = call float @p(float %.61at15)
  ret float %.62at15 
}
define float @my_sin(float %.67){
.65:
  %.79 = alloca i32
  %.66 = alloca float
  store float %.67, float* %.66
  %.72 = load float, float* %.66
  %.73 = fcmp ugt float %.72, 0x401921fb60000000
  br i1 %.73, label %.69, label %.71
.69:
  %.80 = load float, float* %.66
  %.81 = fdiv float %.80, 0x401921fb60000000
  %.82 = fptosi float %.81 to i32
  store i32 %.82, i32* %.79
  %.84 = load float, float* %.66
  %.85 = load i32, i32* %.79
  %.86 = sitofp i32 %.85 to float
  %.87 = fmul float %.86, 0x401921fb60000000
  %.88 = fsub float %.84, %.87
  store float %.88, float* %.66
  br label %.70 
.70:
  %.93 = load float, float* %.66
  %.94 = fcmp ugt float %.93, 0x400921fb60000000
  br i1 %.94, label %.91, label %.92
.71:
  %.75 = load float, float* %.66
  %.77 = fcmp ult float %.75, 0xc01921fb60000000
  br i1 %.77, label %.69, label %.70
.91:
  %.96 = load float, float* %.66
  %.97 = fsub float %.96, 0x401921fb60000000
  store float %.97, float* %.66
  br label %.92 
.92:
  %.102 = load float, float* %.66
  %.104 = fcmp ult float %.102, 0xc00921fb60000000
  br i1 %.104, label %.100, label %.101
.100:
  %.106 = load float, float* %.66
  %.107 = fadd float %.106, 0x401921fb60000000
  store float %.107, float* %.66
  br label %.101 
.101:
  %.110 = load float, float* %.66
  %.111at25 = call float @my_sin_impl(float %.110)
  ret float %.111at25 
}
define float @my_cos(float %.116){
.114:
  %.115 = alloca float
  store float %.116, float* %.115
  %.118 = load float, float* %.115
  %.121 = fadd float %.118, 0x3ff921fb60000000
  %.122at28 = call float @my_sin(float %.121)
  ret float %.122at28 
}
define i32 @read_image(){
.125:
  %.171 = alloca i32
  %.161 = alloca i32
  %.130at31 = call i32 @getch()
  %.132 = icmp ne i32 %.130at31, 80
  br i1 %.132, label %.126, label %.128
.126:
  ret i32 -1 
.127:
  %.142at32 = call i32 @getint()
  store i32 %.142at32, i32* @.g.width
  %.144at33 = call i32 @getint()
  store i32 %.144at33, i32* @.g.height
  %.149 = load i32, i32* @.g.width
  %.150 = icmp sgt i32 %.149, 1024
  br i1 %.150, label %.146, label %.148
.128:
  %.134at31 = call i32 @getch()
  %.136 = icmp ne i32 %.134at31, 50
  br i1 %.136, label %.126, label %.127
.146:
  ret i32 -1 
.147:
  store i32 0, i32* %.161
  br label %.163wc36 
.148:
  %.153 = load i32, i32* @.g.height
  %.154 = icmp sgt i32 %.153, 1024
  br i1 %.154, label %.146, label %.152
.152:
  %.156at34 = call i32 @getint()
  %.158 = icmp ne i32 %.156at34, 255
  br i1 %.158, label %.146, label %.147
.163wc36:
  %.167 = load i32, i32* %.161
  %.168 = load i32, i32* @.g.height
  %.169 = icmp slt i32 %.167, %.168
  br i1 %.169, label %.164wloop.36.43, label %.165wn43
.164wloop.36.43:
  store i32 0, i32* %.171
  br label %.173wc38 
.165wn43:
  ret i32 0 
.173wc38:
  %.177 = load i32, i32* %.171
  %.178 = load i32, i32* @.g.width
  %.179 = icmp slt i32 %.177, %.178
  br i1 %.179, label %.174wloop.38.41, label %.175wn41
.174wloop.38.41:
  %.181at39 = call i32 @getint()
  %.182 = load i32, i32* %.161
  %.183 = load i32, i32* @.g.width
  %.184 = mul i32 %.182, %.183
  %.185 = load i32, i32* %.171
  %.186 = add i32 %.184, %.185
  %.187 = getelementptr inbounds [1048576 x i32], [1048576 x i32]* @.g.image, i32 0, i32 %.186
  store i32 %.181at39, i32* %.187
  %.189 = load i32, i32* %.171
  %.190 = add i32 %.189, 1
  store i32 %.190, i32* %.171
  br label %.173wc38 
.175wn41:
  %.193 = load i32, i32* %.161
  %.194 = add i32 %.193, 1
  store i32 %.194, i32* %.161
  br label %.163wc36 
}
define i32 @rotate(i32 %.201, i32 %.204, float %.207){
.199:
  %.250 = alloca i32
  %.235 = alloca i32
  %.230 = alloca i32
  %.225 = alloca i32
  %.221 = alloca i32
  %.217 = alloca i32
  %.213 = alloca float
  %.209 = alloca float
  %.206 = alloca float
  %.203 = alloca i32
  %.200 = alloca i32
  store i32 %.201, i32* %.200
  store i32 %.204, i32* %.203
  store float %.207, float* %.206
  %.210 = load float, float* %.206
  %.211at48 = call float @my_sin(float %.210)
  store float %.211at48, float* %.209
  %.214 = load float, float* %.206
  %.215at48 = call float @my_cos(float %.214)
  store float %.215at48, float* %.213
  %.218 = load i32, i32* @.g.width
  %.219 = sdiv i32 %.218, 2
  store i32 %.219, i32* %.217
  %.222 = load i32, i32* @.g.height
  %.223 = sdiv i32 %.222, 2
  store i32 %.223, i32* %.221
  %.226 = load i32, i32* %.200
  %.227 = load i32, i32* %.217
  %.228 = sub i32 %.226, %.227
  store i32 %.228, i32* %.225
  %.231 = load i32, i32* %.203
  %.232 = load i32, i32* %.221
  %.233 = sub i32 %.231, %.232
  store i32 %.233, i32* %.230
  %.236 = load i32, i32* %.225
  %.237 = load float, float* %.213
  %.238 = sitofp i32 %.236 to float
  %.239 = fmul float %.238, %.237
  %.240 = load i32, i32* %.230
  %.241 = load float, float* %.209
  %.242 = sitofp i32 %.240 to float
  %.243 = fmul float %.242, %.241
  %.244 = fsub float %.239, %.243
  %.245 = load i32, i32* %.217
  %.246 = sitofp i32 %.245 to float
  %.247 = fadd float %.244, %.246
  %.248 = fptosi float %.247 to i32
  store i32 %.248, i32* %.235
  %.251 = load i32, i32* %.225
  %.252 = load float, float* %.209
  %.253 = sitofp i32 %.251 to float
  %.254 = fmul float %.253, %.252
  %.255 = load i32, i32* %.230
  %.256 = load float, float* %.213
  %.257 = sitofp i32 %.255 to float
  %.258 = fmul float %.257, %.256
  %.259 = fadd float %.254, %.258
  %.260 = load i32, i32* %.221
  %.261 = sitofp i32 %.260 to float
  %.262 = fadd float %.259, %.261
  %.263 = fptosi float %.262 to i32
  store i32 %.263, i32* %.250
  %.268 = load i32, i32* %.235
  %.269 = icmp slt i32 %.268, 0
  br i1 %.269, label %.265, label %.267
.265:
  ret i32 0 
.266:
  %.285 = load i32, i32* %.250
  %.286 = load i32, i32* @.g.width
  %.287 = mul i32 %.285, %.286
  %.288 = load i32, i32* %.235
  %.289 = add i32 %.287, %.288
  %.290 = getelementptr inbounds [1048576 x i32], [1048576 x i32]* @.g.image, i32 0, i32 %.289
  %.291 = load i32, i32* %.290
  ret i32 %.291 
.267:
  %.272 = load i32, i32* %.235
  %.273 = load i32, i32* @.g.width
  %.274 = icmp sge i32 %.272, %.273
  br i1 %.274, label %.265, label %.271
.271:
  %.277 = load i32, i32* %.250
  %.278 = icmp slt i32 %.277, 0
  br i1 %.278, label %.265, label %.276
.276:
  %.280 = load i32, i32* %.250
  %.281 = load i32, i32* @.g.height
  %.282 = icmp sge i32 %.280, %.281
  br i1 %.282, label %.265, label %.266
}
define void @write_pgm(float %.296){
.294:
  %.323 = alloca i32
  %.313 = alloca i32
  %.295 = alloca float
  store float %.296, float* %.295
  call void @putch(i32 80)
  call void @putch(i32 50)
  call void @putch(i32 10)
  %.303 = load i32, i32* @.g.width
  call void @putint(i32 %.303)
  call void @putch(i32 32)
  %.308 = load i32, i32* @.g.height
  call void @putint(i32 %.308)
  call void @putch(i32 32)
  call void @putint(i32 255)
  call void @putch(i32 10)
  store i32 0, i32* %.313
  br label %.315wc62 
.315wc62:
  %.319 = load i32, i32* %.313
  %.320 = load i32, i32* @.g.height
  %.321 = icmp slt i32 %.319, %.320
  br i1 %.321, label %.316wloop.62.71, label %.317wn71
.316wloop.62.71:
  store i32 0, i32* %.323
  br label %.325wc64 
.317wn71:
  ret void
.325wc64:
  %.329 = load i32, i32* %.323
  %.330 = load i32, i32* @.g.width
  %.331 = icmp slt i32 %.329, %.330
  br i1 %.331, label %.326wloop.64.68, label %.327wn68
.326wloop.64.68:
  %.333 = load i32, i32* %.323
  %.334 = load i32, i32* %.313
  %.335 = load float, float* %.295
  %.336at65 = call i32 @rotate(i32 %.333, i32 %.334, float %.335)
  call void @putint(i32 %.336at65)
  call void @putch(i32 32)
  %.339 = load i32, i32* %.323
  %.340 = add i32 %.339, 1
  store i32 %.340, i32* %.323
  br label %.325wc64 
.327wn68:
  call void @putch(i32 10)
  %.344 = load i32, i32* %.313
  %.345 = add i32 %.344, 1
  store i32 %.345, i32* %.313
  br label %.315wc62 
}
define i32 @main(){
.350:
  %.351 = alloca float
  %.353at7