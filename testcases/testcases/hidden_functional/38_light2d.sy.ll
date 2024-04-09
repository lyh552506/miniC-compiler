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
@.g.seed = global i32 0
define i32 @rand(){
.13:
  %.14 = load i32, i32* @.g.seed
  %.16 = mul i32 %.14, 19980130
  %.18 = add i32 %.16, 23333
  %.19 = srem i32 %.18, 100000007
  store i32 %.19, i32* @.g.seed
  %.23 = load i32, i32* @.g.seed
  %.24 = icmp slt i32 %.23, 0
  br i1 %.24, label %.21, label %.22
.21:
  %.26 = load i32, i32* @.g.seed
  %.27 = add i32 %.26, 100000007
  store i32 %.27, i32* @.g.seed
  br label %.22 
.22:
  %.30 = load i32, i32* @.g.seed
  ret i32 %.30 
}
define float @my_fabs(float %.35){
.33:
  %.34 = alloca float
  store float %.35, float* %.34
  %.39 = load float, float* %.34
  %.40 = sitofp i32 0 to float
  %.41 = fcmp ugt float %.39, %.40
  br i1 %.41, label %.37, label %.38
.37:
  %.43 = load float, float* %.34
  ret float %.43 
.38:
  %.45 = load float, float* %.34
  %.47 = fsub float 0x0, %.45
  ret float %.47 
}
define float @my_sqrt(float %.52){
.50:
  %.72 = alloca i32
  %.54 = alloca float
  %.51 = alloca float
  store float %.52, float* %.51
  %.55 = load float, float* %.51
  %.57 = sitofp i32 8 to float
  %.58 = fdiv float %.55, %.57
  %.60 = fadd float %.58, 0x3fe0000000000000
  %.62 = load float, float* %.51
  %.63 = sitofp i32 2 to float
  %.64 = fmul float %.63, %.62
  %.66 = load float, float* %.51
  %.67 = sitofp i32 4 to float
  %.68 = fadd float %.67, %.66
  %.69 = fdiv float %.64, %.68
  %.70 = fadd float %.60, %.69
  store float %.70, float* %.54
  store i32 10, i32* %.72
  br label %.74wc27 
.74wc27:
  %.78 = load i32, i32* %.72
  %.79 = icmp ne i32 %.78, 0
  br i1 %.79, label %.75wloop.27.30, label %.76wn30
.75wloop.27.30:
  %.81 = load float, float* %.54
  %.82 = load float, float* %.51
  %.83 = load float, float* %.54
  %.84 = fdiv float %.82, %.83
  %.85 = fadd float %.81, %.84
  %.86 = sitofp i32 2 to float
  %.87 = fdiv float %.85, %.86
  store float %.87, float* %.54
  %.89 = load i32, i32* %.72
  %.90 = sub i32 %.89, 1
  store i32 %.90, i32* %.72
  br label %.74wc27 
.76wn30:
  %.93 = load float, float* %.54
  ret float %.93 
}
define float @p(float %.98){
.96:
  %.97 = alloca float
  store float %.98, float* %.97
  %.101 = load float, float* %.97
  %.102 = sitofp i32 3 to float
  %.103 = fmul float %.102, %.101
  %.104 = load float, float* %.97
  %.105 = sitofp i32 4 to float
  %.106 = fmul float %.105, %.104
  %.107 = load float, float* %.97
  %.108 = fmul float %.106, %.107
  %.109 = load float, float* %.97
  %.110 = fmul float %.108, %.109
  %.111 = fsub float %.103, %.110
  ret float %.111 
}
define float @my_sin_impl(float %.116){
.114:
  %.115 = alloca float
  store float %.116, float* %.115
  %.120 = load float, float* %.115
  %.121at37 = call float @my_fabs(float %.120)
  %.122 = fcmp ule float %.121at37, 0x3eb0c6f7a0000000
  br i1 %.122, label %.118, label %.119
.118:
  %.124 = load float, float* %.115
  ret float %.124 
.119:
  %.126 = load float, float* %.115
  %.128 = fdiv float %.126, 0x4008000000000000
  %.129at38 = call float @my_sin_impl(float %.128)
  %.130at38 = call float @p(float %.129at38)
  ret float %.130at38 
}
define float @my_sin(float %.135){
.133:
  %.147 = alloca i32
  %.134 = alloca float
  store float %.135, float* %.134
  %.140 = load float, float* %.134
  %.141 = fcmp ugt float %.140, 0x401921fb60000000
  br i1 %.141, label %.137, label %.139
.137:
  %.148 = load float, float* %.134
  %.149 = fdiv float %.148, 0x401921fb60000000
  %.150 = fptosi float %.149 to i32
  store i32 %.150, i32* %.147
  %.152 = load float, float* %.134
  %.153 = load i32, i32* %.147
  %.154 = sitofp i32 %.153 to float
  %.155 = fmul float %.154, 0x401921fb60000000
  %.156 = fsub float %.152, %.155
  store float %.156, float* %.134
  br label %.138 
.138:
  %.161 = load float, float* %.134
  %.162 = fcmp ugt float %.161, 0x400921fb60000000
  br i1 %.162, label %.159, label %.160
.139:
  %.143 = load float, float* %.134
  %.145 = fcmp ult float %.143, 0xc01921fb60000000
  br i1 %.145, label %.137, label %.138
.159:
  %.164 = load float, float* %.134
  %.165 = fsub float %.164, 0x401921fb60000000
  store float %.165, float* %.134
  br label %.160 
.160:
  %.170 = load float, float* %.134
  %.172 = fcmp ult float %.170, 0xc00921fb60000000
  br i1 %.172, label %.168, label %.169
.168:
  %.174 = load float, float* %.134
  %.175 = fadd float %.174, 0x401921fb60000000
  store float %.175, float* %.134
  br label %.169 
.169:
  %.178 = load float, float* %.134
  %.179at48 = call float @my_sin_impl(float %.178)
  ret float %.179at48 
}
define float @my_cos(float %.184){
.182:
  %.183 = alloca float
  store float %.184, float* %.183
  %.186 = load float, float* %.183
  %.188 = fadd float %.186, 0x3ff921fb60000000
  %.189at51 = call float @my_sin(float %.188)
  ret float %.189at51 
}
define float @circle_sdf(float %.194, float %.197, float %.200, float %.203, float %.206){
.192:
  %.213 = alloca float
  %.208 = alloca float
  %.205 = alloca float
  %.202 = alloca float
  %.199 = alloca float
  %.196 = alloca float
  %.193 = alloca float
  store float %.194, float* %.193
  store float %.197, float* %.196
  store float %.200, float* %.199
  store float %.203, float* %.202
  store float %.206, float* %.205
  %.209 = load float, float* %.193
  %.210 = load float, float* %.199
  %.211 = fsub float %.209, %.210
  store float %.211, float* %.208
  %.214 = load float, float* %.196
  %.215 = load float, float* %.202
  %.216 = fsub float %.214, %.215
  store float %.216, float* %.213
  %.218 = load float, float* %.208
  %.219 = load float, float* %.208
  %.220 = fmul float %.218, %.219
  %.221 = load float, float* %.213
  %.222 = load float, float* %.213
  %.223 = fmul float %.221, %.222
  %.224 = fadd float %.220, %.223
  %.225at55 = call float @my_sqrt(float %.224)
  %.226 = load float, float* %.205
  %.227 = fsub float %.225at55, %.226
  ret float %.227 
}
define void @scene(float %.232, float %.235, float* %.238){
.230:
  %.247 = alloca float
  %.240 = alloca float
  %.237 = alloca float*
  %.234 = alloca float
  %.231 = alloca float
  store float %.232, float* %.231
  store float %.235, float* %.234
  store float* %.238, float** %.237
  %.241 = load float, float* %.231
  %.242 = load float, float* %.234
  %.245at59 = call float @circle_sdf(float %.241, float %.242, float 0x3fd99999a0000000, float 0x3fd99999a0000000, float 0x3fb99999a0000000)
  store float %.245at59, float* %.240
  %.248 = load float, float* %.231
  %.249 = load float, float* %.234
  %.252at60 = call float @circle_sdf(float %.248, float %.249, float 0x3fe3333340000000, float 0x3fe3333340000000, float 0x3fa99999a0000000)
  store float %.252at60, float* %.247
  %.256 = load float, float* %.240
  %.257 = load float, float* %.247
  %.258 = fcmp ult float %.256, %.257
  br i1 %.258, label %.254, label %.255
.254:
  %.260 = load float, float* %.240
  %.261 = load float*, float** %.237
  %.262 = getelementptr inbounds float, float* %.261, i32 0
  store float %.260, float* %.262
  %.264 = load float*, float** %.237
  %.265 = getelementptr inbounds float, float* %.264, i32 1
  store float 0x4008000000000000, float* %.265
  br label %.267 
.255:
  %.269 = load float, float* %.247
  %.270 = load float*, float** %.237
  %.271 = getelementptr inbounds float, float* %.270, i32 0
  store float %.269, float* %.271
  %.273 = load float*, float** %.237
  %.274 = getelementptr inbounds float, float* %.273, i32 1
  store float 0x0, float* %.274
  br label %.267 
.267:
  ret void
}
define float @trace(float %.281, float %.284, float %.287, float %.290){
.279:
  %.307 = alloca [2 x float]
  %.294 = alloca i32
  %.292 = alloca float
  %.289 = alloca float
  %.286 = alloca float
  %.283 = alloca float
  %.280 = alloca float
  store float %.281, float* %.280
  store float %.284, float* %.283
  store float %.287, float* %.286
  store float %.290, float* %.289
  store float 0x0, float* %.292
  store i32 0, i32* %.294
  br label %.296wc73 
.296wc73:
  %.300 = load i32, i32* %.294
  %.301 = icmp slt i32 %.300, 10
  br i1 %.301, label %.302, label %.298wn79
.297wloop.73.79:
  %.308 = load float, float* %.280
  %.309 = load float, float* %.286
  %.310 = load float, float* %.292
  %.311 = fmul float %.309, %.310
  %.312 = fadd float %.308, %.311
  %.313 = load float, float* %.283
  %.314 = load float, float* %.289
  %.315 = load float, float* %.292
  %.316 = fmul float %.314, %.315
  %.317 = fadd float %.313, %.316
  %.318 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
  call void @scene(float %.312, float %.317, float* %.318)
  %.322 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
  %.323 = load float, float* %.322
  %.324 = fcmp ult float %.323, 0x3eb0c6f7a0000000
  br i1 %.324, label %.320, label %.321
.298wn79:
  ret float 0x0 
.302:
  %.304 = load float, float* %.292
  %.305 = fcmp ult float %.304, 0x4000000000000000
  br i1 %.305, label %.297wloop.73.79, label %.298wn79
.320:
  %.326 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 1
  %.327 = load float, float* %.326
  ret float %.327 
.321:
  %.329 = load float, float* %.292
  %.330 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
  %.331 = load float, float* %.330
  %.332 = fadd float %.329, %.331
  store float %.332, float* %.292
  %.334 = load i32, i32* %.294
  %.335 = add i32 %.334, 1
  store i32 %.335, i32* %.294
  br label %.296wc73 
}
define float @sample(float %.342, float %.345){
.340:
  %.362 = alloca float
  %.358 = alloca float
  %.349 = alloca i32
  %.347 = alloca float
  %.344 = alloca float
  %.341 = alloca float
  store float %.342, float* %.341
  store float %.345, float* %.344
  store float 0x0, float* %.347
  store i32 0, i32* %.349
  br label %.351wc86 
.351wc86:
  %.355 = load i32, i32* %.349
  %.356 = icmp slt i32 %.355, 24
  br i1 %.356, label %.352wloop.86.91, label %.353wn91
.352wloop.86.91:
  %.359at87 = call i32 @rand()
  %.360 = sitofp i32 %.359at87 to float
  store float %.360, float* %.358
  %.363 = load i32, i32* %.349
  %.364 = load float, float* %.358
  %.365 = sitofp i32 100000006 to float
  %.366 = fdiv float %.364, %.365
  %.367 = sitofp i32 %.363 to float
  %.368 = fadd float %.367, %.366
  %.369 = fmul float 0x401921fb60000000, %.368
  %.370 = sitofp i32 24 to float
  %.371 = fdiv float %.369, %.370
  store float %.371, float* %.362
  %.373 = load float, float* %.347
  %.374 = load float, float* %.341
  %.375 = load float, float* %.344
  %.376 = load float, float* %.362
  %.377at89 = call float @my_cos(float %.376)
  %.378 = load float, float* %.362
  %.379at89 = call float @my_sin(float %.378)
  %.380at89 = call float @trace(float %.374, float %.375, float %.377at89, float %.379at89)
  %.381 = fadd float %.373, %.380at89
  store float %.381, float* %.347
  %.383 = load i32, i32* %.349
  %.384 = add i32 %.383, 1
  store i32 %.384, i32* %.349
  br label %.351wc86 
.353wn91:
  %.387 = load float, float* %.347
  %.388 = sitofp i32 24 to float
  %.389 = fdiv float %.387, %.388
  ret float %.389 
}
define void @write_pgm(){
.392:
  %.434 = alloca i32
  %.430 = alloca float
  %.426 = alloca float
  %.417 = alloca i32
  %.408 = alloca i32
  call void @putch(i32 80)
  call void @putch(i32 50)
  call void @putch(i32 10)
  call void @putint(i32 192)
  call void @putch(i32 32)
  call void @putint(i32 192)
  call void @putch(i32 32)
  call void @putint(i32 255)
  call void @putch(i32 10)
  store i32 0, i32* %.408
  br label %.410wc99 
.410wc99:
  %.414 = load i32, i32* %.408
  %.415 = icmp slt i32 %.414, 192
  br i1 %.415, label %.411wloop.99.111, label %.412wn111
.411wloop.99.111:
  store i32 0, i32* %.417
  br label %.419wc101 
.412wn111:
  ret void
.419wc101:
  %.423 = load i32, i32* %.417
  %.424 = icmp slt i32 %.423, 192
  br i1 %.424, label %.420wloop.101.108, label %.421wn108
.420wloop.101.108:
  %.427 = load i32, i32* %.417
  %.428 = sitofp i32 %.427 to float
  store float %.428, float* %.426
  %.431 = load i32, i32* %.408
  %.432 = sitofp i32 %.431 to float
  store float %.432, float* %.430
  %.435 = load float, float* %.426
  %.436 = sitofp i32 192 to float
  %.437 = fdiv float %.435, %.436
  %.438 = load float, float* %.430
  %.439 = sitofp i32 192 to float
  %.440 = fdiv float %.438, %.439
  %.441at103 = call float @sample(float %.437, float %.440)
  %.443 = fmul float %.441at103, 0x406fe00000000000
  %.444 = fptosi float %.443 to i32
  store i32 %.444, i32* %.434
  %.448 = load i32, i32* %.434
  %.449 = icmp sgt i32 %.448, 255
  br i1 %.449, label %.446, label %.447
.421wn108:
  call void @putch(i32 10)
  %.461 = load i32, i32* %.408
  %.462 = add i32 %.461, 1
  store i32 %.462, i32* %.408
  br label %.410wc99 
.446:
  store i32 255, i32* %.434
  br label %.447 
.447:
  %.453 = load i32, i32* %.434
  call void @putint(i32 %.453)
  call void @putch(i32 32)
  %.456 = load i32, i32* %.417
  %.457 = add i32 %.456, 1
  store i32 %.457, i32* %.417
  br label %.419wc101 
}
define i32 @main(){
.467:
  call void @write_pgm()
  ret i32 0 
}
@.g.seed = global i32 0
define i32 @rand(){
.13:
  %.14 = load i32, i32* @.g.seed
  %.16 = mul i32 %.14, 19980130
  %.18 = add i32 %.16, 23333
  %.19 = srem i32 %.18, 100000007
  store i32 %.19, i32* @.g.seed
  %.23 = load i32, i32* @.g.seed
  %.24 = icmp slt i32 %.23, 0
  br i1 %.24, label %.21, label %.22
.21:
  %.26 = load i32, i32* @.g.seed
  %.27 = add i32 %.26, 100000007
  store i32 %.27, i32* @.g.seed
  br label %.22 
.22:
  %.30 = load i32, i32* @.g.seed
  ret i32 %.30 
}
define float @my_fabs(float %.35){
.33:
  %.34 = alloca float
  store float %.35, float* %.34
  %.39 = load float, float* %.34
  %.40 = sitofp i32 0 to float
  %.41 = fcmp ugt float %.39, %.40
  br i1 %.41, label %.37, label %.38
.37:
  %.43 = load float, float* %.34
  ret float %.43 
.38:
  %.45 = load float, float* %.34
  %.47 = fsub float 0x0, %.45
  ret float %.47 
}
define float @my_sqrt(float %.52){
.50:
  %.72 = alloca i32
  %.54 = alloca float
  %.51 = alloca float
  store float %.52, float* %.51
  %.55 = load float, float* %.51
  %.57 = sitofp i32 8 to float
  %.58 = fdiv float %.55, %.57
  %.60 = fadd float %.58, 0x3fe0000000000000
  %.62 = load float, float* %.51
  %.63 = sitofp i32 2 to float
  %.64 = fmul float %.63, %.62
  %.66 = load float, float* %.51
  %.67 = sitofp i32 4 to float
  %.68 = fadd float %.67, %.66
  %.69 = fdiv float %.64, %.68
  %.70 = fadd float %.60, %.69
  store float %.70, float* %.54
  store i32 10, i32* %.72
  br label %.74wc27 
.74wc27:
  %.78 = load i32, i32* %.72
  %.79 = icmp ne i32 %.78, 0
  br i1 %.79, label %.75wloop.27.30, label %.76wn30
.75wloop.27.30:
  %.81 = load float, float* %.54
  %.82 = load float, float* %.51
  %.83 = load float, float* %.54
  %.84 = fdiv float %.82, %.83
  %.85 = fadd float %.81, %.84
  %.86 = sitofp i32 2 to float
  %.87 = fdiv float %.85, %.86
  store float %.87, float* %.54
  %.89 = load i32, i32* %.72
  %.90 = sub i32 %.89, 1
  store i32 %.90, i32* %.72
  br label %.74wc27 
.76wn30:
  %.93 = load float, float* %.54
  ret float %.93 
}
define float @p(float %.98){
.96:
  %.97 = alloca float
  store float %.98, float* %.97
  %.101 = load float, float* %.97
  %.102 = sitofp i32 3 to float
  %.103 = fmul float %.102, %.101
  %.104 = load float, float* %.97
  %.105 = sitofp i32 4 to float
  %.106 = fmul float %.105, %.104
  %.107 = load float, float* %.97
  %.108 = fmul float %.106, %.107
  %.109 = load float, float* %.97
  %.110 = fmul float %.108, %.109
  %.111 = fsub float %.103, %.110
  ret float %.111 
}
define float @my_sin_impl(float %.116){
.114:
  %.115 = alloca float
  store float %.116, float* %.115
  %.120 = load float, float* %.115
  %.121at37 = call float @my_fabs(float %.120)
  %.122 = fcmp ule float %.121at37, 0x3eb0c6f7a0000000
  br i1 %.122, label %.118, label %.119
.118:
  %.124 = load float, float* %.115
  ret float %.124 
.119:
  %.126 = load float, float* %.115
  %.128 = fdiv float %.126, 0x4008000000000000
  %.129at38 = call float @my_sin_impl(float %.128)
  %.130at38 = call float @p(float %.129at38)
  ret float %.130at38 
}
define float @my_sin(float %.135){
.133:
  %.147 = alloca i32
  %.134 = alloca float
  store float %.135, float* %.134
  %.140 = load float, float* %.134
  %.141 = fcmp ugt float %.140, 0x401921fb60000000
  br i1 %.141, label %.137, label %.139
.137:
  %.148 = load float, float* %.134
  %.149 = fdiv float %.148, 0x401921fb60000000
  %.150 = fptosi float %.149 to i32
  store i32 %.150, i32* %.147
  %.152 = load float, float* %.134
  %.153 = load i32, i32* %.147
  %.154 = sitofp i32 %.153 to float
  %.155 = fmul float %.154, 0x401921fb60000000
  %.156 = fsub float %.152, %.155
  store float %.156, float* %.134
  br label %.138 
.138:
  %.161 = load float, float* %.134
  %.162 = fcmp ugt float %.161, 0x400921fb60000000
  br i1 %.162, label %.159, label %.160
.139:
  %.143 = load float, float* %.134
  %.145 = fcmp ult float %.143, 0xc01921fb60000000
  br i1 %.145, label %.137, label %.138
.159:
  %.164 = load float, float* %.134
  %.165 = fsub float %.164, 0x401921fb60000000
  store float %.165, float* %.134
  br label %.160 
.160:
  %.170 = load float, float* %.134
  %.172 = fcmp ult float %.170, 0xc00921fb60000000
  br i1 %.172, label %.168, label %.169
.168:
  %.174 = load float, float* %.134
  %.175 = fadd float %.174, 0x401921fb60000000
  store float %.175, float* %.134
  br label %.169 
.169:
  %.178 = load float, float* %.134
  %.179at48 = call float @my_sin_impl(float %.178)
  ret float %.179at48 
}
define float @my_cos(float %.184){
.182:
  %.183 = alloca float
  store float %.184, float* %.183
  %.186 = load float, float* %.183
  %.188 = fadd float %.186, 0x3ff921fb60000000
  %.189at51 = call float @my_sin(float %.188)
  ret float %.189at51 
}
define float @circle_sdf(float %.194, float %.197, float %.200, float %.203, float %.206){
.192:
  %.213 = alloca float
  %.208 = alloca float
  %.205 = alloca float
  %.202 = alloca float
  %.199 = alloca float
  %.196 = alloca float
  %.193 = alloca float
  store float %.194, float* %.193
  store float %.197, float* %.196
  store float %.200, float* %.199
  store float %.203, float* %.202
  store float %.206, float* %.205
  %.209 = load float, float* %.193
  %.210 = load float, float* %.199
  %.211 = fsub float %.209, %.210
  store float %.211, float* %.208
  %.214 = load float, float* %.196
  %.215 = load float, float* %.202
  %.216 = fsub float %.214, %.215
  store float %.216, float* %.213
  %.218 = load float, float* %.208
  %.219 = load float, float* %.208
  %.220 = fmul float %.218, %.219
  %.221 = load float, float* %.213
  %.222 = load float, float* %.213
  %.223 = fmul float %.221, %.222
  %.224 = fadd float %.220, %.223
  %.225at55 = call float @my_sqrt(float %.224)
  %.226 = load float, float* %.205
  %.227 = fsub float %.225at55, %.226
  ret float %.227 
}
define void @scene(float %.232, float %.235, float* %.238){
.230:
  %.247 = alloca float
  %.240 = alloca float
  %.237 = alloca float*
  %.234 = alloca float
  %.231 = alloca float
  store float %.232, float* %.231
  store float %.235, float* %.234
  store float* %.238, float** %.237
  %.241 = load float, float* %.231
  %.242 = load float, float* %.234
  %.245at59 = call float @circle_sdf(float %.241, float %.242, float 0x3fd99999a0000000, float 0x3fd99999a0000000, float 0x3fb99999a0000000)
  store float %.245at59, float* %.240
  %.248 = load float, float* %.231
  %.249 = load float, float* %.234
  %.252at60 = call float @circle_sdf(float %.248, float %.249, float 0x3fe3333340000000, float 0x3fe3333340000000, float 0x3fa99999a0000000)
  store float %.252at60, float* %.247
  %.256 = load float, float* %.240
  %.257 = load float, float* %.247
  %.258 = fcmp ult float %.256, %.257
  br i1 %.258, label %.254, label %.255
.254:
  %.260 = load float, float* %.240
  %.261 = load float*, float** %.237
  %.262 = getelementptr inbounds float, float* %.261, i32 0
  store float %.260, float* %.262
  %.264 = load float*, float** %.237
  %.265 = getelementptr inbounds float, float* %.264, i32 1
  store float 0x4008000000000000, float* %.265
  br label %.267 
.255:
  %.269 = load float, float* %.247
  %.270 = load float*, float** %.237
  %.271 = getelementptr inbounds float, float* %.270, i32 0
  store float %.269, float* %.271
  %.273 = load float*, float** %.237
  %.274 = getelementptr inbounds float, float* %.273, i32 1
  store float 0x0, float* %.274
  br label %.267 
.267:
  ret void
}
define float @trace(float %.281, float %.284, float %.287, float %.290){
.279:
  %.307 = alloca [2 x float]
  %.294 = alloca i32
  %.292 = alloca float
  %.289 = alloca float
  %.286 = alloca float
  %.283 = alloca float
  %.280 = alloca float
  store float %.281, float* %.280
  store float %.284, float* %.283
  store float %.287, float* %.286
  store float %.290, float* %.289
  store float 0x0, float* %.292
  store i32 0, i32* %.294
  br label %.296wc73 
.296wc73:
  %.300 = load i32, i32* %.294
  %.301 = icmp slt i32 %.300, 10
  br i1 %.301, label %.302, label %.298wn79
.297wloop.73.79:
  %.308 = load float, float* %.280
  %.309 = load float, float* %.286
  %.310 = load float, float* %.292
  %.311 = fmul float %.309, %.310
  %.312 = fadd float %.308, %.311
  %.313 = load float, float* %.283
  %.314 = load float, float* %.289
  %.315 = load float, float* %.292
  %.316 = fmul float %.314, %.315
  %.317 = fadd float %.313, %.316
  %.318 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
  call void @scene(float %.312, float %.317, float* %.318)
  %.322 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
  %.323 = load float, float* %.322
  %.324 = fcmp ult float %.323, 0x3eb0c6f7a0000000
  br i1 %.324, label %.320, label %.321
.298wn79:
  ret float 0x0 
.302:
  %.304 = load float, float* %.292
  %.305 = fcmp ult float %.304, 0x4000000000000000
  br i1 %.305, label %.297wloop.73.79, label %.298wn79
.320:
  %.326 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 1
  %.327 = load float, float* %.326
  ret float %.327 
.321:
  %.329 = load float, float* %.292
  %.330 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
  %.331 = load float, float* %.330
  %.332 = fadd float %.329, %.331
  store float %.332, float* %.292
  %.334 = load i32, i32* %.294
  %.335 = add i32 %.334, 1
  store i32 %.335, i32* %.294
  br label %.296wc73 
}
define float @sample(float %.342, float %.345){
.340:
  %.362 = alloca float
  %.358 = alloca float
  %.349 = alloca i32
  %.347 = alloca float
  %.344 = alloca float
  %.341 = alloca float
  store float %.342, float* %.341
  store float %.345, float* %.344
  store float 0x0, float* %.347
  store i32 0, i32* %.349
  br label %.351wc86 
.351wc86:
  %.355 = load i32, i32* %.349
  %.356 = icmp slt i32 %.355, 24
  br i1 %.356, label %.352wloop.86.91, label %.353wn91
.352wloop.86.91:
  %.359at87 = call i32 @rand()
  %.360 = sitofp i32 %.359at87 to float
  store float %.360, float* %.358
  %.363 = load i32, i32* %.349
  %.364 = load float, float* %.358
  %.365 = sitofp i32 100000006 to float
  %.366 = fdiv float %.364, %.365
  %.367 = sitofp i32 %.363 to float
  %.368 = fadd float %.367, %.366
  %.369 = fmul float 0x401921fb60000000, %.368
  %.370 = sitofp i32 24 to float
  %.371 = fdiv float %.369, %.370
  store float %.371, float* %.362
  %.373 = load float, float* %.347
  %.374 = load float, float* %.341
  %.375 = load float, float* %.344
  %.376 = load float, float* %.362
  %.377at89 = call float @my_cos(float %.376)
  %.378 = load float, float* %.362
  %.379at89 = call float @my_sin(float %.378)
  %.380at89 = call float @trace(float %.374, float %.375, float %.377at89, float %.379at89)
  %.381 = fadd float %.373, %.380at89
  store float %.381, float* %.347
  %.383 = load i32, i32* %.349
  %.384 = add i32 %.383, 1
  store i32 %.384, i32* %.349
  br label %.351wc86 
.353wn91:
  %.387 = load float, float* %.347
  %.388 = sitofp i32 24 to float
  %.389 = fdiv float %.387, %.388
  ret float %.389 
}
define void @write_pgm(){
.392:
  %.434 = alloca i32
  %.430 = alloca float
  %.426 = alloca float
  %.417 = alloca i32
  %.408 = alloca i32
  call void @putch(i32 80)
  call void @putch(i32 50)
  call void @putch(i32 10)
  call void @putint(i32 192)
  call void @putch(i32 32)
  call void @putint(i32 192)
  call void @putch(i32 32)
  call void @putint(i32 255)
  call void @putch(i32 10)
  store i32 0, i32* %.408
  br label %.410wc99 
.410wc99:
  %.414 = load i32, i32* %.408
  %.415 = icmp slt i32 %.414, 192
  br i1 %.415, label %.411wloop.99.111, label %.412wn111
.411wloop.99.111:
  store i32 0, i32* %.417
  br label %.419wc101 
.412wn111:
  ret void
.419wc101:
  %.423 = load i32, i32* %.417
  %.424 = icmp slt i32 %.423, 192
  br i1 %.424, label %.420wloop.101.108, label %.421wn108
.420wloop.101.108:
  %.427 = load i32, i32* %.417
  %.428 = sitofp i32 %.427 to float
  store float %.428, float* %.426
  %.431 = load i32, i32* %.408
  %.432 = sitofp i32 %.431 to float
  store float %.432, float* %.430
  %.435 = load float, float* %.426
  %.436 = sitofp i32 192 to float
  %.437 = fdiv float %.435, %.436
  %.438 = load float, float* %.430
  %.439 = sitofp i32 192 to float
  %.440 = fdiv float %.438, %.439
  %.441at103 = call float @sample(float %.437, float %.440)
  %.443 = fmul float %.441at103, 0x406fe00000000000
  %.444 = fptosi float %.443 to i32
  store i32 %.444, i32* %.434
  %.448 = load i32, i32* %.434
  %.449 = icmp sgt i32 %.448, 255
  br i1 %.449, label %.446, label %.447
.421wn108:
  call void @putch(i32 10)
  %.461 = load i32, i32* %.408
  %.462 = add i32 %.461, 1
  store i32 %.462, i32* %.408
  br label %.410wc99 
.446:
  store i32 255, i32* %.