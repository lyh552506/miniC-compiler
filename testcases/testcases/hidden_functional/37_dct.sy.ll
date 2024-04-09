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
@.g.test_block = global [8 x [8 x float]] zeroinitializer
@.g.test_dct = global [8 x [8 x float]] zeroinitializer
@.g.test_idct = global [8 x [8 x float]] zeroinitializer
define float @my_fabs(float %.10){
.8:
  %.9 = alloca float
  store float %.10, float* %.9
  %.14 = load float, float* %.9
  %.16 = sitofp i32 0 to float
  %.17 = fcmp ugt float %.14, %.16
  br i1 %.17, label %.12, label %.13
.12:
  %.19 = load float, float* %.9
  ret float %.19 
.13:
  %.21 = load float, float* %.9
  %.23 = fsub float 0x0, %.21
  ret float %.23 
}
define float @p(float %.28){
.26:
  %.27 = alloca float
  store float %.28, float* %.27
  %.31 = load float, float* %.27
  %.32 = sitofp i32 3 to float
  %.33 = fmul float %.32, %.31
  %.35 = load float, float* %.27
  %.36 = sitofp i32 4 to float
  %.37 = fmul float %.36, %.35
  %.38 = load float, float* %.27
  %.39 = fmul float %.37, %.38
  %.40 = load float, float* %.27
  %.41 = fmul float %.39, %.40
  %.42 = fsub float %.33, %.41
  ret float %.42 
}
define float @my_sin_impl(float %.47){
.45:
  %.46 = alloca float
  store float %.47, float* %.46
  %.51 = load float, float* %.46
  %.52at19 = call float @my_fabs(float %.51)
  %.53 = fcmp ule float %.52at19, 0x3eb0c6f7a0000000
  br i1 %.53, label %.49, label %.50
.49:
  %.55 = load float, float* %.46
  ret float %.55 
.50:
  %.57 = load float, float* %.46
  %.59 = fdiv float %.57, 0x4008000000000000
  %.60at20 = call float @my_sin_impl(float %.59)
  %.61at20 = call float @p(float %.60at20)
  ret float %.61at20 
}
define float @my_sin(float %.66){
.64:
  %.78 = alloca i32
  %.65 = alloca float
  store float %.66, float* %.65
  %.71 = load float, float* %.65
  %.72 = fcmp ugt float %.71, 0x401921fb60000000
  br i1 %.72, label %.68, label %.70
.68:
  %.79 = load float, float* %.65
  %.80 = fdiv float %.79, 0x401921fb60000000
  %.81 = fptosi float %.80 to i32
  store i32 %.81, i32* %.78
  %.83 = load float, float* %.65
  %.84 = load i32, i32* %.78
  %.85 = sitofp i32 %.84 to float
  %.86 = fmul float %.85, 0x401921fb60000000
  %.87 = fsub float %.83, %.86
  store float %.87, float* %.65
  br label %.69 
.69:
  %.92 = load float, float* %.65
  %.93 = fcmp ugt float %.92, 0x400921fb60000000
  br i1 %.93, label %.90, label %.91
.70:
  %.74 = load float, float* %.65
  %.76 = fcmp ult float %.74, 0xc01921fb60000000
  br i1 %.76, label %.68, label %.69
.90:
  %.95 = load float, float* %.65
  %.96 = fsub float %.95, 0x401921fb60000000
  store float %.96, float* %.65
  br label %.91 
.91:
  %.101 = load float, float* %.65
  %.103 = fcmp ult float %.101, 0xc00921fb60000000
  br i1 %.103, label %.99, label %.100
.99:
  %.105 = load float, float* %.65
  %.106 = fadd float %.105, 0x401921fb60000000
  store float %.106, float* %.65
  br label %.100 
.100:
  %.109 = load float, float* %.65
  %.110at30 = call float @my_sin_impl(float %.109)
  ret float %.110at30 
}
define float @my_cos(float %.115){
.113:
  %.114 = alloca float
  store float %.115, float* %.114
  %.117 = load float, float* %.114
  %.120 = fadd float %.117, 0x3ff921fb60000000
  %.121at33 = call float @my_sin(float %.120)
  ret float %.121at33 
}
define void @write_mat([8 x float]* %.126, i32 %.129, i32 %.132){
.124:
  %.150 = alloca i32
  %.134 = alloca i32
  %.131 = alloca i32
  %.128 = alloca i32
  %.125 = alloca [8 x float]*
  store [8 x float]* %.126, [8 x float]** %.125
  store i32 %.129, i32* %.128
  store i32 %.132, i32* %.131
  store i32 0, i32* %.134
  br label %.136wc37 
.136wc37:
  %.140 = load i32, i32* %.134
  %.141 = load i32, i32* %.128
  %.142 = icmp slt i32 %.140, %.141
  br i1 %.142, label %.137wloop.37.47, label %.138wn47
.137wloop.37.47:
  %.144 = load i32, i32* %.134
  %.145 = load [8 x float]*, [8 x float]** %.125
  %.146 = getelementptr inbounds [8 x float], [8 x float]* %.145, i32 %.144, i32 0
  %.147 = load float, float* %.146
  call void @putfloat(float %.147)
  store i32 1, i32* %.150
  br label %.153wc40 
.138wn47:
  call void @putch(i32 10)
  ret void
.153wc40:
  %.157 = load i32, i32* %.150
  %.158 = load i32, i32* %.131
  %.159 = icmp slt i32 %.157, %.158
  br i1 %.159, label %.154wloop.40.44, label %.155wn44
.154wloop.40.44:
  call void @putch(i32 32)
  %.164 = load i32, i32* %.134
  %.165 = load i32, i32* %.150
  %.166 = load [8 x float]*, [8 x float]** %.125
  %.167 = getelementptr inbounds [8 x float], [8 x float]* %.166, i32 %.164, i32 %.165
  %.168 = load float, float* %.167
  call void @putfloat(float %.168)
  %.170 = load i32, i32* %.150
  %.171 = add i32 %.170, 1
  store i32 %.171, i32* %.150
  br label %.153wc40 
.155wn44:
  call void @putch(i32 10)
  %.176 = load i32, i32* %.134
  %.177 = add i32 %.176, 1
  store i32 %.177, i32* %.134
  br label %.136wc37 
}
define void @dct([8 x float]* %.185, [8 x float]* %.188, i32 %.191, i32 %.194){
.183:
  %.232 = alloca i32
  %.222 = alloca i32
  %.206 = alloca i32
  %.196 = alloca i32
  %.193 = alloca i32
  %.190 = alloca i32
  %.187 = alloca [8 x float]*
  %.184 = alloca [8 x float]*
  store [8 x float]* %.185, [8 x float]** %.184
  store [8 x float]* %.188, [8 x float]** %.187
  store i32 %.191, i32* %.190
  store i32 %.194, i32* %.193
  store i32 0, i32* %.196
  br label %.198wc53 
.198wc53:
  %.202 = load i32, i32* %.196
  %.203 = load i32, i32* %.190
  %.204 = icmp slt i32 %.202, %.203
  br i1 %.204, label %.199wloop.53.71, label %.200wn71
.199wloop.53.71:
  store i32 0, i32* %.206
  br label %.208wc55 
.200wn71:
  ret void
.208wc55:
  %.212 = load i32, i32* %.206
  %.213 = load i32, i32* %.193
  %.214 = icmp slt i32 %.212, %.213
  br i1 %.214, label %.209wloop.55.69, label %.210wn69
.209wloop.55.69:
  %.216 = load i32, i32* %.196
  %.217 = load i32, i32* %.206
  %.218 = load [8 x float]*, [8 x float]** %.184
  %.219 = getelementptr inbounds [8 x float], [8 x float]* %.218, i32 %.216, i32 %.217
  %.220 = sitofp i32 0 to float
  store float %.220, float* %.219
  store i32 0, i32* %.222
  br label %.224wc58 
.210wn69:
  %.297 = load i32, i32* %.196
  %.298 = add i32 %.297, 1
  store i32 %.298, i32* %.196
  br label %.198wc53 
.224wc58:
  %.228 = load i32, i32* %.222
  %.229 = load i32, i32* %.190
  %.230 = icmp slt i32 %.228, %.229
  br i1 %.230, label %.225wloop.58.67, label %.226wn67
.225wloop.58.67:
  store i32 0, i32* %.232
  br label %.234wc60 
.226wn67:
  %.293 = load i32, i32* %.206
  %.294 = add i32 %.293, 1
  store i32 %.294, i32* %.206
  br label %.208wc55 
.234wc60:
  %.238 = load i32, i32* %.232
  %.239 = load i32, i32* %.193
  %.240 = icmp slt i32 %.238, %.239
  br i1 %.240, label %.235wloop.60.65, label %.236wn65
.235wloop.60.65:
  %.242 = load i32, i32* %.196
  %.243 = load i32, i32* %.206
  %.244 = load [8 x float]*, [8 x float]** %.184
  %.245 = getelementptr inbounds [8 x float], [8 x float]* %.244, i32 %.242, i32 %.243
  %.246 = load float, float* %.245
  %.247 = load i32, i32* %.222
  %.248 = load i32, i32* %.232
  %.249 = load [8 x float]*, [8 x float]** %.187
  %.250 = getelementptr inbounds [8 x float], [8 x float]* %.249, i32 %.247, i32 %.248
  %.251 = load float, float* %.250
  %.252 = load i32, i32* %.190
  %.253 = sitofp i32 %.252 to float
  %.254 = fdiv float 0x400921fb60000000, %.253
  %.255 = load i32, i32* %.222
  %.259 = sitofp i32 %.255 to float
  %.260 = fadd float %.259, 0x3fe0000000000000
  %.261 = fmul float %.254, %.260
  %.262 = load i32, i32* %.196
  %.263 = sitofp i32 %.262 to float
  %.264 = fmul float %.261, %.263
  %.265at62 = call float @my_cos(float %.264)
  %.266 = fmul float %.251, %.265at62
  %.267 = load i32, i32* %.193
  %.268 = sitofp i32 %.267 to float
  %.269 = fdiv float 0x400921fb60000000, %.268
  %.270 = load i32, i32* %.232
  %.271 = sitofp i32 %.270 to float
  %.272 = fadd float %.271, 0x3fe0000000000000
  %.273 = fmul float %.269, %.272
  %.274 = load i32, i32* %.206
  %.275 = sitofp i32 %.274 to float
  %.276 = fmul float %.273, %.275
  %.277at63 = call float @my_cos(float %.276)
  %.278 = fmul float %.266, %.277at63
  %.279 = fadd float %.246, %.278
  %.280 = load i32, i32* %.196
  %.281 = load i32, i32* %.206
  %.282 = load [8 x float]*, [8 x float]** %.184
  %.283 = getelementptr inbounds [8 x float], [8 x float]* %.282, i32 %.280, i32 %.281
  store float %.279, float* %.283
  %.285 = load i32, i32* %.232
  %.286 = add i32 %.285, 1
  store i32 %.286, i32* %.232
  br label %.234wc60 
.236wn65:
  %.289 = load i32, i32* %.222
  %.290 = add i32 %.289, 1
  store i32 %.290, i32* %.222
  br label %.224wc58 
}
define void @idct([8 x float]* %.305, [8 x float]* %.308, i32 %.311, i32 %.314){
.303:
  %.348 = alloca i32
  %.347 = alloca i32
  %.326 = alloca i32
  %.316 = alloca i32
  %.313 = alloca i32
  %.310 = alloca i32
  %.307 = alloca [8 x float]*
  %.304 = alloca [8 x float]*
  store [8 x float]* %.305, [8 x float]** %.304
  store [8 x float]* %.308, [8 x float]** %.307
  store i32 %.311, i32* %.310
  store i32 %.314, i32* %.313
  store i32 0, i32* %.316
  br label %.318wc76 
.318wc76:
  %.322 = load i32, i32* %.316
  %.323 = load i32, i32* %.310
  %.324 = icmp slt i32 %.322, %.323
  br i1 %.324, label %.319wloop.76.108, label %.320wn108
.319wloop.76.108:
  store i32 0, i32* %.326
  br label %.328wc78 
.320wn108:
  ret void
.328wc78:
  %.332 = load i32, i32* %.326
  %.333 = load i32, i32* %.313
  %.334 = icmp slt i32 %.332, %.333
  br i1 %.334, label %.329wloop.78.106, label %.330wn106
.329wloop.78.106:
  %.338 = load [8 x float]*, [8 x float]** %.307
  %.339 = getelementptr inbounds [8 x float], [8 x float]* %.338, i32 0, i32 0
  %.340 = load float, float* %.339
  %.341 = fmul float 0x3fd0000000000000, %.340
  %.342 = load i32, i32* %.316
  %.343 = load i32, i32* %.326
  %.344 = load [8 x float]*, [8 x float]** %.304
  %.345 = getelementptr inbounds [8 x float], [8 x float]* %.344, i32 %.342, i32 %.343
  store float %.341, float* %.345
  store i32 1, i32* %.347
  br label %.350wc83 
.330wn106:
  %.495 = load i32, i32* %.316
  %.496 = add i32 %.495, 1
  store i32 %.496, i32* %.316
  br label %.318wc76 
.350wc83:
  %.354 = load i32, i32* %.347
  %.355 = load i32, i32* %.310
  %.356 = icmp slt i32 %.354, %.355
  br i1 %.356, label %.351wloop.83.86, label %.352wn86
.351wloop.83.86:
  %.358 = load i32, i32* %.316
  %.359 = load i32, i32* %.326
  %.360 = load [8 x float]*, [8 x float]** %.304
  %.361 = getelementptr inbounds [8 x float], [8 x float]* %.360, i32 %.358, i32 %.359
  %.362 = load float, float* %.361
  %.363 = load i32, i32* %.347
  %.364 = load [8 x float]*, [8 x float]** %.307
  %.365 = getelementptr inbounds [8 x float], [8 x float]* %.364, i32 %.363, i32 0
  %.366 = load float, float* %.365
  %.367 = fmul float 0x3fe0000000000000, %.366
  %.368 = fadd float %.362, %.367
  %.369 = load i32, i32* %.316
  %.370 = load i32, i32* %.326
  %.371 = load [8 x float]*, [8 x float]** %.304
  %.372 = getelementptr inbounds [8 x float], [8 x float]* %.371, i32 %.369, i32 %.370
  store float %.368, float* %.372
  %.374 = load i32, i32* %.347
  %.375 = add i32 %.374, 1
  store i32 %.375, i32* %.347
  br label %.350wc83 
.352wn86:
  store i32 1, i32* %.348
  br label %.379wc88 
.379wc88:
  %.383 = load i32, i32* %.348
  %.384 = load i32, i32* %.313
  %.385 = icmp slt i32 %.383, %.384
  br i1 %.385, label %.380wloop.88.91, label %.381wn91
.380wloop.88.91:
  %.387 = load i32, i32* %.316
  %.388 = load i32, i32* %.326
  %.389 = load [8 x float]*, [8 x float]** %.304
  %.390 = getelementptr inbounds [8 x float], [8 x float]* %.389, i32 %.387, i32 %.388
  %.391 = load float, float* %.390
  %.392 = load i32, i32* %.348
  %.393 = load [8 x float]*, [8 x float]** %.307
  %.394 = getelementptr inbounds [8 x float], [8 x float]* %.393, i32 0, i32 %.392
  %.395 = load float, float* %.394
  %.396 = fmul float 0x3fe0000000000000, %.395
  %.397 = fadd float %.391, %.396
  %.398 = load i32, i32* %.316
  %.399 = load i32, i32* %.326
  %.400 = load [8 x float]*, [8 x float]** %.304
  %.401 = getelementptr inbounds [8 x float], [8 x float]* %.400, i32 %.398, i32 %.399
  store float %.397, float* %.401
  %.403 = load i32, i32* %.348
  %.404 = add i32 %.403, 1
  store i32 %.404, i32* %.348
  br label %.379wc88 
.381wn91:
  store i32 1, i32* %.347
  br label %.408wc94 
.408wc94:
  %.412 = load i32, i32* %.347
  %.413 = load i32, i32* %.310
  %.414 = icmp slt i32 %.412, %.413
  br i1 %.414, label %.409wloop.94.103, label %.410wn103
.409wloop.94.103:
  store i32 1, i32* %.348
  br label %.417wc96 
.410wn103:
  %.473 = load i32, i32* %.316
  %.474 = load i32, i32* %.326
  %.475 = load [8 x float]*, [8 x float]** %.304
  %.476 = getelementptr inbounds [8 x float], [8 x float]* %.475, i32 %.473, i32 %.474
  %.477 = load float, float* %.476
  %.478 = fmul float %.477, 0x4000000000000000
  %.479 = load i32, i32* %.310
  %.480 = sitofp i32 %.479 to float
  %.481 = fdiv float %.478, %.480
  %.482 = fmul float %.481, 0x4000000000000000
  %.483 = load i32, i32* %.313
  %.484 = sitofp i32 %.483 to float
  %.485 = fdiv float %.482, %.484
  %.486 = load i32, i32* %.316
  %.487 = load i32, i32* %.326
  %.488 = load [8 x float]*, [8 x float]** %.304
  %.489 = getelementptr inbounds [8 x float], [8 x float]* %.488, i32 %.486, i32 %.487
  store float %.485, float* %.489
  %.491 = load i32, i32* %.326
  %.492 = add i32 %.491, 1
  store i32 %.492, i32* %.326
  br label %.328wc78 
.417wc96:
  %.421 = load i32, i32* %.348
  %.422 = load i32, i32* %.313
  %.423 = icmp slt i32 %.421, %.422
  br i1 %.423, label %.418wloop.96.101, label %.419wn101
.418wloop.96.101:
  %.425 = load i32, i32* %.316
  %.426 = load i32, i32* %.326
  %.427 = load [8 x float]*, [8 x float]** %.304
  %.428 = getelementptr inbounds [8 x float], [8 x float]* %.427, i32 %.425, i32 %.426
  %.429 = load float, float* %.428
  %.430 = load i32, i32* %.347
  %.431 = load i32, i32* %.348
  %.432 = load [8 x float]*, [8 x float]** %.307
  %.433 = getelementptr inbounds [8 x float], [8 x float]* %.432, i32 %.430, i32 %.431
  %.434 = load float, float* %.433
  %.435 = load i32, i32* %.310
  %.436 = sitofp i32 %.435 to float
  %.437 = fdiv float 0x400921fb60000000, %.436
  %.438 = load i32, i32* %.316
  %.439 = sitofp i32 %.438 to float
  %.440 = fadd float %.439, 0x3fe0000000000000
  %.441 = fmul float %.437, %.440
  %.442 = load i32, i32* %.347
  %.443 = sitofp i32 %.442 to float
  %.444 = fmul float %.441, %.443
  %.445at98 = call float @my_cos(float %.444)
  %.446 = fmul float %.434, %.445at98
  %.447 = load i32, i32* %.313
  %.448 = sitofp i32 %.447 to float
  %.449 = fdiv float 0x400921fb60000000, %.448
  %.450 = load i32, i32* %.326
  %.451 = sitofp i32 %.450 to float
  %.452 = fadd float %.451, 0x3fe0000000000000
  %.453 = fmul float %.449, %.452
  %.454 = load i32, i32* %.348
  %.455 = sitofp i32 %.454 to float
  %.456 = fmul float %.453, %.455
  %.457at99 = call float @my_cos(float %.456)
  %.458 = fmul float %.446, %.457at99
  %.459 = fadd float %.429, %.458
  %.460 = load i32, i32* %.316
  %.461 = load i32, i32* %.326
  %.462 = load [8 x float]*, [8 x float]** %.304
  %.463 = getelementptr inbounds [8 x float], [8 x float]* %.462, i32 %.460, i32 %.461
  store float %.459, float* %.463
  %.465 = load i32, i32* %.348
  %.466 = add i32 %.465, 1
  store i32 %.466, i32* %.348
  br label %.417wc96 
.419wn101:
  %.469 = load i32, i32* %.347
  %.470 = add i32 %.469, 1
  store i32 %.470, i32* %.347
  br label %.408wc94 
}
define i32 @main(){
.501:
  %.519 = alloca i32
  %.509 = alloca i32
  %.506 = alloca i32
  %.502 = alloca i32
  %.504at112 = call i32 @getint()
  store i32 %.504at112, i32* %.502
  %.507at112 = call i32 @getint()
  store i32 %.507at112, i32* %.506
  store i32 0, i32* %.509
  br label %.511wc115 
.511wc115:
  %.515 = load i32, i32* %.509
  %.516 = load i32, i32* %.502
  %.517 = icmp slt i32 %.515, %.516
  br i1 %.517, label %.512wloop.115.122, label %.513wn122
.512wloop.115.122:
  store i32 0, i32* %.519
  br label %.521wc117 
.513wn122:
  %.543 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_dct, i32 0, i32 0
  %.544 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_block, i32 0, i32 0
  %.545 = load i32, i32* %.502
  %.546 = load i32, i32* %.506
  call void @dct([8 x float]* %.543, [8 x float]* %.544, i32 %.545, i32 %.546)
  %.548 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_dct, i32 0, i32 0
  %.549 = load i32, i32* %.502
  %.550 = load i32, i32* %.506
  call void @write_mat([8 x float]* %.548, i32 %.549, i32 %.550)
  %.552 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_idct, i32 0, i32 0
  %.553 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_dct, i32 0, i32 0
  %.554 = load i32, i32* %.502
  %.555 = load i32, i32* %.506
  call void @idct([8 x float]* %.552, [8 x float]* %.553, i32 %.554, i32 %.555)
  %.557 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_idct, i32 0, i32 0
  %.558 = load i32, i32* %.502
  %.559 = load i32, i32* %.506
  call void @write_mat([8 x float]* %.557, i32 %.558, i32 %.559)
  ret i32 0 
.521wc117:
  %.525 = load i32, i32* %.519
  %.526 = load i32, i32* %.506
  %.527 = icmp slt i32 %.525, %.526
  br i1 %.527, label %.522wloop.117.120, label %.523wn120
.522wloop.117.120:
  %.530at118 = call float @getfloat()
  %.531 = load i32, i32* %.509
  %.532 = load i32, i32* %.519
  %.533 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_block, i32 0, i32 %.531, i32 %.532
  store float %.530at118, float* %.533
  %.535 = load i32, i32* %.519
  %.536 = add i32 %.535, 1
  store i32 %.536, i32* %.519
  br label %.521wc117 
.523wn120:
  %.539 = load i32, i32* %.509
  %.540 = add i32 %.539, 1
  store i32 %.540, i32* %.509
  br label %.511wc115 
}
@.g.test_block = global [8 x [8 x float]] zeroinitializer
@.g.test_dct = global [8 x [8 x float]] zeroinitializer
@.g.test_idct = global [8 x [8 x float]] zeroinitializer
define float @my_fabs(float %.10){
.8:
  %.9 = alloca float
  store float %.10, float* %.9
  %.14 = load float, float* %.9
  %.16 = sitofp i32 0 to float
  %.17 = fcmp ugt float %.14, %.16
  br i1 %.17, label %.12, label %.13
.12:
  %.19 = load float, float* %.9
  ret float %.19 
.13:
  %.21 = load float, float* %.9
  %.23 = fsub float 0x0, %.21
  ret float %.23 
}
define float @p(float %.28){
.26:
  %.27 = alloca float
  store float %.28, float* %.27
  %.31 = load float, float* %.27
  %.32 = sitofp i32 3 to float
  %.33 = fmul float %.32, %.31
  %.35 = load float, float* %.27
  %.36 = sitofp i32 4 to float
  %.37 = fmul float %.36, %.35
  %.38 = load float, float* %.27
  %.39 = fmul float %.37, %.38
  %.40 = load float, float* %.27
  %.41 = fmul float %.39, %.40
  %.42 = fsub float %.33, %.41
  ret float %.42 
}
define float @my_sin_impl(float %.47){
.45:
  %.46 = alloca float
  store float %.47, float* %.46
  %.51 = load float, float* %.46
  %.52at19 = call float @my_fabs(float %.51)
  %.53 = fcmp ule float %.52at19, 0x3eb0c6f7a0000000
  br i1 %.53, label %.49, label %.50
.49:
  %.55 = load float, float* %.46
  ret float %.55 
.50:
  %.57 = load float, float* %.46
  %.59 = fdiv float %.57, 0x4008000000000000
  %.60at20 = call float @my_sin_impl(float %.59)
  %.61at20 = call float @p(float %.60at20)
  ret float %.61at20 
}
define float @my_sin(float %.66){
.64:
  %.78 = alloca i32
  %.65 = alloca float
  store float %.66, float* %.65
  %.71 = load float, float* %.65
  %.72 = fcmp ugt float %.71, 0x401921fb60000000
  br i1 %.72, label %.68, label %.70
.68:
  %.79 = load float, float* %.65
  %.80 = fdiv float %.79, 0x401921fb60000000
  %.81 = fptosi float %.80 to i32
  store i32 %.81, i32* %.78
  %.83 = load float, float* %.65
  %.84 = load i32, i32* %.78
  %.85 = sitofp i32 %.84 to float
  %.86 = fmul float %.85, 0x401921fb60000000
  %.87 = fsub float %.83, %.86
  store float %.87, float* %.65
  br label %.69 
.69:
  %.92 = load float, float* %.65
  %.93 = fcmp ugt float %.92, 0x400921fb60000000
  br i1 %.93, label %.90, label %.91
.70:
  %.74 = load float, float* %.65
  %.76 = fcmp ult float %.74, 0xc01921fb60000000
  br i1 %.76, label %.68, label %.69
.90:
  %.95 = load float, float* %.65
  %.96 = fsub float %.95, 0x401921fb60000000
  store float %.96, float* %.65
  br label %.91 
.91:
  %.101 = load float, float* %.65
  %.103 = fcmp ult float %.101, 0xc00921fb60000000
  br i1 %.103, label %.99, label %.100
.99:
  %.105 = load float, float* %.65
  %.106 = fadd float %.105, 0x401921fb60000000
  store float %.106, float* %.65
  br label %.100 
.100:
  %.109 = load float, float* %.65
  %.110at30 = call float @my_sin_impl(float %.109)
  ret float %.110at30 
}
define float @my_cos(float %.115){
.113:
  %.114 = alloca float
  store float %.115, float* %.114
  %.117 = load float, float* %.114
  %.120 = fadd float %.117, 0x3ff921fb60000000
  %.121at33 = call float @my_sin(float %.120)
  ret float %.121at33 
}
define void @write_mat([8 x float]* %.126, i32 %.129, i32 %.132){
.124:
  %.150 = alloca i32
  %.134 = alloca i32
  %.131 = alloca i32
  %.128 = alloca i32
  %.125 = alloca [8 x float]*
  store [8 x float]* %.126, [8 x float]** %.125
  store i32 %.129, i32* %.128
  store i32 %.132, i32* %.131
  store i32 0, i32* %.134
  br label %.136wc37 
.136wc37:
  %.140 = load i32, i32* %.134
  %.141 = load i32, i32* %.128
  %.142 = icmp slt i32 %.140, %.141
  br i1 %.142, label %.137wloop.37.47, label %.138wn47
.137wloop.37.47:
  %.144 = load i32, i32* %.134
  %.145 = load [8 x float]*, [8 x float]** %.125
  %.146 = getelementptr inbounds [8 x float], [8 x float]* %.145, i32 %.144, i32 0
  %.147 = load float, float* %.146
  call void @putfloat(float %.147)
  store i32 1, i32* %.150
  br label %.153wc40 
.138wn47:
  call void @putch(i32 10)
  ret void
.153wc40:
  %.157 = load i32, i32* %.150
  %.158 = load i32, i32* %.131
  %.159 = icmp slt i32 %.157, %.158
  br i1 %.159, label %.154wloop.40.44, label %.155wn44
.154wloop.40.44:
  call void @putch(i32 32)
  %.164 = load i32, i32* %.134
  %.165 = load i32, i32* %.150
  %.166 = load [8 x float]*, [8 x float]** %.125
  %.167 = getelementptr inbounds [8 x float], [8 x float]* %.166, i32 %.164, i32 %.165
  %.168 = load float, float* %.167
  call void @putfloat(float %.168)
  %.170 = load i32, i32* %.150
  %.171 = add i32 %.170, 1
  store i32 %.171, i32* %.150
  br label %.153wc40 
.155wn44:
  call void @putch(i32 10)
  %.176 = load i32, i32* %.134
  %.177 = add i32 %.176, 1
  store i32 %.177, i32* %.134
  br label %.136wc37 
}
define void @dct([8 x float]* %.185, [8 x float]* %.188, i32 %.191, i32 %.194){
.183:
  %.232 = alloca i32
  %.222 = alloca i32
  %.206 = alloca i32
  %.196 = alloca i32
  %.193 = alloca i32
  %.190 = alloca i32
  %.187 = alloca [8 x float]*
  %.184 = alloca [8 x float]*
  store [8 x float]* %.185, [8 x float]** %.184
  store [8 x float]* %.188, [8 x float]** %.187
  store i32 %.191, i32* %.190
  store i32 %.194, i32* %.193
  store i32 0, i32* %.196
  br label %.198wc53 
.198wc53:
  %.202 = load i32, i32* %.196
  %.203 = load i32, i32* %.190
  %.204 = icmp slt i32 %.202, %.203
  br i1 %.204, label %.199wloop.53.71, label %.200wn71
.199wloop.53.71:
  store i32 0, i32* %.206
  br label %.208wc55 
.200wn71:
  ret void
.208wc55:
  %.212 = load i32, i32* %.206
  %.213 = load i32, i32* %.193
  %.214 = icmp slt i32 %.212, %.213
  br i1 %.214, label %.209wloop.55.69, label %.210wn69
.209wloop.55.69:
  %.216 = load i32, i32* %.196
  %.217 = load i32, i32* %.206
  %.218 = load [8 x float]*, [8 x float]** %.184
  %.219 = getelementptr inbounds [8 x float], [8 x float]* %.218, i32 %.216, i32 %.217
  %.220 = sitofp i32 0 to float
  store float %.220, float* %.219
  store i32 0, i32* %.222
  br label %.224wc58 
.210wn69:
  %.297 = load i32, i32* %.196
  %.298 = add i32 %.297, 1
  store i32 %.298, i32* %.196
  br label %.198wc53 
.224wc58:
  %.228 = load i32, i32* %.222
  %.229 = load i32, i32* %.190
  %.230 = icmp slt i32 %.228, %.229
  br i1 %.230, label %.225wloop.58.67, label %.226wn67
.225wloop.58.67:
  store i32 0, i32* %.232
  br label %.234wc60 
.226wn67:
  %.293 = load i32, i32* %.206
  %.294 = add i32 %.293, 1
  store i32 %.294, i32* %.206
  br label %.208wc55 
.234wc60:
  %.238 = load i32, i32* %.232
  %.239 = load i32, i32* %.193
  %.240 = icmp slt i32 %.238, %.239
  br i1 %.240, label %.235wloop.60.65, label %.236wn65
.235wloop.60.65:
  %.242 = load i32, i32* %.196
  %.243 = load i32, i32* %.206
  %.244 = load [8 x float]*, [8 x float]** %.184
  %.245 = getelementptr inbounds [8 x float], [8 x float]* %.244, i32 %.242, i32 %.243
  %.246 = load float, float* %.245
  %.247 = load i32, i32* %.222
  %.248 = load i32, i32* %.232
  %.249 = load [8 x float]*, [8 x float]** %.187
  %.250 = getelementptr inbounds [8 x float], [8 x float]* %.249, i32 %.247, i32 %.248
  %.251 = load float, float* %.250
  %.252 = load i32, i32* %.190
  %.253 = sitofp i32 %.252 to float
  %.254 = fdiv float 0x400921fb60000000, %.253
  %.255 = load i32, i32* %.222
  %.259 = sitofp i32 %.255 to float
  %.260 = fadd float %.259, 0x3fe0000000000000
  %.261 = fmul float %.254, %.260
  %.262 = load i32, i32* %.196
  %.263 = sitofp i32 %.262 to float
  %.264 = fmul float %.261, %.263
  %.265at62 = call float @my_cos(float %.264)
  %.266 = fmul float %.251, %.265at62
  %.267 = load i32, i32* %.193
  %.268 = sitofp i32 %.267 to float
  %.269 = fdiv float 0x400921fb60000000, %.268
  %.270 = load i32, i32* %.232
  %.271 = sitofp i32 %.270 to float
  %.272 = fadd float %.271, 0x3fe0000000000000
  %.273 = fmul float %.269, %.272
  %.274 = load i32, i32* %.206
  %.275 = sitofp i32 %.274 to float
  %.276 = fmul float %.273, %.275
  %.277at63 = call float @my_cos(float %.276)
  %.278 = fmul float %.266, %.277at63
  %.279 = fadd float %.246, %.278
  %.280 = load i32, i32* %.196
  %.281 = load i32, i32* %.206
  %.282 = load [8 x float]*, [8 x float]** %.184
  %.283 = getelementptr inbounds [8 x float], [8 x float]* %.282, i32 %.280, i32 %.281
  store float %.279, float* %.283
  %.285 = load i32, i32* %.232
  %.286 = add i32 %.285, 1
  store i32 %.286, i32* %.232
  br label %.234wc60 
.236wn65:
  %.289 = load i32, i32* %.222
  %.290 = add i32 %.289, 1
  store i32 %.290, i32* %.222
  br label %.224wc58 
}
define void @idct([8 x float]* %.305, [8 x float]* %.308, i32 %.311, i32 %.314){
.303:
  %.348 = alloca i32
  %.347 = alloca i32
  %.326 = alloca i32
  %.316 = alloca i32
  %.313 = alloca i32
  %.310 = alloca i32
  %.307 = alloca [8 x float]*
  %.304 = alloca [8 x float]*
  store [8 x float]* %.305, [8 x float]** %.304
  store [8 x float]* %.308, [8 x float]** %.307
  store i32 %.311, i32* %.310
  store i32 %.314, i32* %.313
  store i32 0, i32* %.316
  br label %.318wc76 
.318wc76:
  %.322 = load i32, i32* %.316
  %.323 = load i32, i32* %.310
  %.324 = icmp slt i32 %.322, %.323
  br i1 %.324, label %.319wloop.76.108, label %.320wn108
.319wloop.76.108:
  store i32 0, i32* %.326
  br label %.328wc78 
.320wn108:
  ret void
.328wc78:
  %.332 = load i32, i32* %.326
  %.333 = load i32, i32* %.313
  %.334 = icmp slt i32 %.332, %.333
  br i1 %.334, label %.329wloop.78.106, label %.330wn106
.329wloop.78.106:
  %.338 = load [8 x float]*, [8 x float]** %.307
  %.339 = getelementptr inbounds [8 x float], [8 x float]* %.338, i32 0, i32 0
  %.340 = load float, float* %.339
  %.341 = fmul float 0x3fd0000000000000, %.340
  %.342 = load i32, i32* %.316
  %.343 = load i32, i32* %.326
  %.344 = load [8 x float]*, [8 x float]** %.304
  %.345 = getelementptr inbounds [8 x float], [8 x float]* %.344, i32 %.342, i32 %.343
  store float %.341, float* %.345
  store i32 1, i32* %.347
  br label %.350wc83 
.330wn106:
  %.495 = load i32, i32* %.316
  %.496 = add i32 %.495, 1
  store i32 %.496, i32* %.316
  br label %.318wc76 
.350wc83:
  %.354 = load i32, i32* %.347
  %.355 = load i32, i32* %.310
  %.356 = icmp slt i32 %.354, %.355
  br i1 %.356, label %.351wloop.83.86, label %.352wn86
.351wloop.83.86:
  %.358 = load i32, i32* %.316
  %.359 = load i32, i32* %.326
  %.360 = load [8 x float]*, [8 x float]** %.304
  %.361 = getelementptr inbounds [8 x float], [8 x float]* %.360, i32 %.358, i32 %.359
  %.362 = load float, float* %.361
  %.363 = load i32, i32* %.347
  %.364 = load [8 x float]*, [8 x float]** %.307
  %.365 = getelementptr inbounds [8 x float], [8 x float]* %.364, i32 %.363, i32 0
  %.366 = load float, float* %.365
  %.367 = fmul float 0x3fe0000000000000, %.366
  %.368 = fadd float %.362, %.367
  %.369 = load i32, i32* %.316
  %.370 = load i32, i32* %.326
  %.371 = load [8 x float]*, [8 x float]** %.304
  %.372 = getelementptr inbounds [8 x float], [8 x float]* %.371, i32 %.369, i32 %.370
  store float %.368, float* %.372
  %.374 = load i32, i32* %.347
  %.375 = add i32 %.374, 1
  store i32 %.375, i32* %.347
  br label %.350wc83 
.352wn86:
  store i32 1, i32* %.348
  br label %.379wc88 
.379wc88:
  %.383 = load i32, i32* %.348
  %.384 = load i32, i32* %.313
  %.385 = icmp slt i32 %.383, %.384
  br i1 %.385, label %.380wloop.88.91, label %.381wn91
.380wloop.88.91:
  %.387 = load i32, i32* %.316
  %.388 = load i32, i32* %.326
  %.389 = load [8 x float]*, [8 x float]** %.304
  %.390 = getelementptr inbounds [8 x float], [8 x float]* %.389, i32 %.387, i32 %.388
  %.391 = load float, float* %.390
  %.392 = load i32, i32* %.348
  %.393 = load [8 x float]*, [8 x float]** %.307
  %.394 = getelementptr inbounds [8 x float], [8 x float]* %.393, i32 0, i32 %.392
  %.395 = load float, float* %.394
  %.396 = fmul float 0x3fe0000000000000, %.395
  %.397 = fadd float %.391, %.396
  %.398 = load i32, i32* %.316
  %.399 = load i32, i32* %.326
  %.400 = load [8 x float]*, [8 x float]** %.304
  %.401 = getelementptr inbounds [8 x float], [8 x float]* %.400, i32 %.398, i32 %.399
  store float %.397, float* %.401
  %.403 = load i32, i32* %.348
  %.404 = add i32 %.403, 1
  store i32 %.404, i32* %.348
  br label %.379wc88 
.381wn91:
  store i32 1, i32* %.347
  br label %.408wc94 
.408wc94:
  %.412 = load i32, i32* %.347
  %.413 = load i32, i32* %.310
  %.414 = icmp slt i32 %.412, %.413
  br i1 %.414, label %.409wloop.94.103, label %.410wn103
.409wloop.94.103:
  store i32 1, i32* %.348
  br label %.417wc96 
.410wn103:
  %.473 = load i32, i32* %.316
  %.474 = load i32, i32* %.326
  %.475 = load [8 x float]*, [8 x float]** %.304
  %.476 = getelementptr inbounds [8 x float], [8 x float]* %.475, i32 %.473, i32 %.474
  %.477 = load float, float* %.476
  %.478 = fmul float %.477, 0x4000000000000000
  %.479 = load i32, i32* %.310
  %.480 = sitofp i32 %.479 to float
  %.481 = fdiv float %.478, %.480
  %.482 = fmul float %.481, 0x4000000000000000
  %.483 = load i32, i32* %.313
  %.484 = sitofp i32 %.483 to float
  %.485 = fdiv float %.482, %.484
  %.486 = load i32, i32* %.316
  %.487 = load i32, i32* %.326
  %.488 = load [8 x float]*, [8 x float]** %.304
  %.489 = getelementptr inbounds [8 x float], [8 x float]* %.488, i32 %.486, i32 %.487
  store float %.485, float* %.489
  %.491 = load i32, i32* %.326
  %.492 = add i32 %.491, 1
  store i32 %.492, i32* %.326
  br label %.328wc78 
.417wc96:
  %.421 = load i32, i32* %.348
  %.422 = load i32, i32* %.313
  %.423 = icmp slt i32 %.421, %.422
  br i1 %.423, label %.418wloop.96.101, label %.419wn101
.418wloop.96.101:
  %.425 = load i32, i32* %.316
  %.426 = load i32, i32* %.326
  %.427 = load [8 x float]*, [8 x float]** %.304
  %.428 = getelementptr inbounds [8 x float], [8 x float]* %.427, i32 %.425, i32 %.426
  %.429 = load float, float* %.428
  %.430 = load i32, i32* %.347
  %.431 = load i32, i32* %.348
  %.432 = load [8 x float]*, [8 x float]** %.307
  %.433 = getelementptr inbounds [8 x float], [8 x float]* %.432, i32 %.430, i32 %.431
  %.434 = load float, float* %.433
  %.435 = load i32, i32* %.310
  %.436 = sitofp i32 %.435 to float
  %.437 = fdiv float 0x400921fb60000000, %.436
  %.438 = load i32, i32* %.316
  %.439 = sitofp i32 %.438 to float
  %.440 = fadd float %.439, 0x3fe0000000000000
  %.441 = fmul float %.437, %.440
  %.442 = load i32, i32* %.347
  %.443 = sitofp i32 %.442 to float
  %.444 = fmul float %.441, %.443
  %.445at98 = call float @my_cos(float %.444)
  %.446 = fmul float %.434, %.445at98
  %.447 = load i32, i32* %.313
  %.448 = sitofp i32 %.447 to float
  %.449 = fdiv float 0x400921fb60000000, %.448
  %.450 = load i32, i32* %.326
  %.451 = sitofp i32 %.450 to float
  %.452 = fadd float %.451, 0x3fe0000000000000
  %.453 = fmul float %.449, %.452
  %.454 = load i32, i32* %.348
  %.455 = sitofp i32 %.454 to float
  %.456 = fmul float %.453, %.455
  %.457at99 = call float @my_cos(float %.456)
  %.458 = fmul float %.446, %.457at99
  %.459 = fadd float %.429, %.458
  %.460 = load i32, i32* %.316
  %.461 = load i32, i32* %.326
  %.462 = load [8 x float]*, [8 x float]** %.304
  %.463 = getelementptr inbounds [8 x float], [8 x float]* %.462, i32 %.460, i32 %.461
  store float %.459, float* %.463
  %.465 = load i32, i32* %.348
  %.466 = add i32 %.465, 1
  store i32 %.466, i32* %.348
  br label %.417wc96 
.419wn101:
  %.469 = load i32, i32* %.347
  %.470 = add i32 %.469, 1
  store i32 %.470, i32* %.347
  br label %.408wc94 
}
define i32 @main(){
.501:
  %.519 = alloca i32
  %.509 = alloca i32
  %.506 = alloca i32
  %.502 = alloca i32
  %.504at112 = call i32 @getint()
  store i32 %.504at112, i32* %.502
  %.507at112 = call i32 @getint()
  store i32 %.507at112, i32* %.506
  store i32 0, i32* %.509
  br label %.511wc115 
.511wc115:
  %.515 = load i32, i32* %.509
  %.516 = load i32, i32* %.502
  %.517 = icmp slt i32 %.515, %.516
  br i1 %.517, label %.512wloop.115.122, label %.513wn122
.512wloop.115.122:
  store i32 0, i32* %.519
  br label %.521wc117 
.513wn122:
  %.543 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_dct, i32 0, i32 0
  %.544 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_block, i32 0, i32 0
  %.545 = load i32, i32* %.502
  %.546 = load i32, i32* %.506
  call void @dct([8 x float]* %.543, [8 x float]* %.544, i32 %.545, i32 %.546)
  %.548 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_dct, i32 0, i32 0
  %.549 = load i32, i32* %.502
  %.550 = load i32, i32* %.506
  call void @write_mat([8 x float]* %.548, i32 %.549, i32 %.550)
  %.552 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_idct, i32 0, i32 0
  %.553 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_dct, i32 0, i32 0
  %.554 = load i32, i32* %.502
  %.555 = load i32, i32* %.506
  call void @idct([8 x float]* %.552, [8 x float]* %.553, i32 %.554, i32 %.555)
  %.557 = getelementptr inbounds [8 x [8 x float]], [8 x [8 x float]]* @.g.test_idct, i32 0, i32 0
  %.558 = load i32, i32* %.502
  %.559 = load i32, i32* %.506
  call void @write_mat([8 x float]* %.557, i32 %.558, i32 %.559)
  ret i32 0 
.521wc117:
  %.525 = load i32, i32* %.519
  %.526 = load i32, i32* %.506
  %.527 = icmp slt i32 %.525, %.526
  br i1 %.527, label %.522wloop.117.120, label %.523wn120
.522wl