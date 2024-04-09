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
@.g.k = global i32 zeroinitializer
@__constant..203 = constant [10 x float]  [float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0]
@__constant..563 = constant [10 x float]  [float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0]
@__constant..627 = constant [8 x i32]  [i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]
@__constant..1061 = constant [10 x float]  [float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0]
@__constant..1450 = constant [10 x float]  [float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float zeroinitializer]
@__constant..1561 = constant [10 x i32]  [i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 zeroinitializer]
define float @params_f40(float %.4, float %.7, float %.10, float %.13, float %.16, float %.19, float %.22, float %.25, float %.28, float %.31, float %.34, float %.37, float %.40, float %.43, float %.46, float %.49, float %.52, float %.55, float %.58, float %.61, float %.64, float %.67, float %.70, float %.73, float %.76, float %.79, float %.82, float %.85, float %.88, float %.91, float %.94, float %.97, float %.100, float %.103, float %.106, float %.109, float %.112, float %.115, float %.118, float %.121){
.2:
  %.131 = alloca [10 x float]
  %.120 = alloca float
  %.117 = alloca float
  %.114 = alloca float
  %.111 = alloca float
  %.108 = alloca float
  %.105 = alloca float
  %.102 = alloca float
  %.99 = alloca float
  %.96 = alloca float
  %.93 = alloca float
  %.90 = alloca float
  %.87 = alloca float
  %.84 = alloca float
  %.81 = alloca float
  %.78 = alloca float
  %.75 = alloca float
  %.72 = alloca float
  %.69 = alloca float
  %.66 = alloca float
  %.63 = alloca float
  %.60 = alloca float
  %.57 = alloca float
  %.54 = alloca float
  %.51 = alloca float
  %.48 = alloca float
  %.45 = alloca float
  %.42 = alloca float
  %.39 = alloca float
  %.36 = alloca float
  %.33 = alloca float
  %.30 = alloca float
  %.27 = alloca float
  %.24 = alloca float
  %.21 = alloca float
  %.18 = alloca float
  %.15 = alloca float
  %.12 = alloca float
  %.9 = alloca float
  %.6 = alloca float
  %.3 = alloca float
  store float %.4, float* %.3
  store float %.7, float* %.6
  store float %.10, float* %.9
  store float %.13, float* %.12
  store float %.16, float* %.15
  store float %.19, float* %.18
  store float %.22, float* %.21
  store float %.25, float* %.24
  store float %.28, float* %.27
  store float %.31, float* %.30
  store float %.34, float* %.33
  store float %.37, float* %.36
  store float %.40, float* %.39
  store float %.43, float* %.42
  store float %.46, float* %.45
  store float %.49, float* %.48
  store float %.52, float* %.51
  store float %.55, float* %.54
  store float %.58, float* %.57
  store float %.61, float* %.60
  store float %.64, float* %.63
  store float %.67, float* %.66
  store float %.70, float* %.69
  store float %.73, float* %.72
  store float %.76, float* %.75
  store float %.79, float* %.78
  store float %.82, float* %.81
  store float %.85, float* %.84
  store float %.88, float* %.87
  store float %.91, float* %.90
  store float %.94, float* %.93
  store float %.97, float* %.96
  store float %.100, float* %.99
  store float %.103, float* %.102
  store float %.106, float* %.105
  store float %.109, float* %.108
  store float %.112, float* %.111
  store float %.115, float* %.114
  store float %.118, float* %.117
  store float %.121, float* %.120
  %.125 = load float, float* %.120
  %.127 = sitofp i32 0 to float
  %.128 = fcmp une float %.125, %.127
  br i1 %.128, label %.123, label %.124
.123:
  %.133 = load float, float* %.3
  %.134 = load float, float* %.6
  %.135 = fadd float %.133, %.134
  %.136 = load float, float* %.9
  %.137 = fadd float %.135, %.136
  %.138 = load float, float* %.12
  %.139 = fadd float %.137, %.138
  %.140 = load float, float* %.15
  %.141 = load float, float* %.18
  %.142 = fadd float %.140, %.141
  %.143 = load float, float* %.21
  %.144 = fadd float %.142, %.143
  %.145 = load float, float* %.24
  %.146 = fadd float %.144, %.145
  %.147 = load float, float* %.27
  %.148 = load float, float* %.30
  %.149 = fadd float %.147, %.148
  %.150 = load float, float* %.33
  %.151 = fadd float %.149, %.150
  %.152 = load float, float* %.36
  %.153 = fadd float %.151, %.152
  %.154 = load float, float* %.39
  %.155 = load float, float* %.42
  %.156 = fadd float %.154, %.155
  %.157 = load float, float* %.45
  %.158 = fadd float %.156, %.157
  %.159 = load float, float* %.48
  %.160 = fadd float %.158, %.159
  %.161 = load float, float* %.51
  %.162 = load float, float* %.54
  %.163 = fadd float %.161, %.162
  %.164 = load float, float* %.57
  %.165 = fadd float %.163, %.164
  %.166 = load float, float* %.60
  %.167 = fadd float %.165, %.166
  %.168 = load float, float* %.63
  %.169 = load float, float* %.66
  %.170 = fadd float %.168, %.169
  %.171 = load float, float* %.69
  %.172 = fadd float %.170, %.171
  %.173 = load float, float* %.72
  %.174 = fadd float %.172, %.173
  %.175 = load float, float* %.75
  %.176 = load float, float* %.78
  %.177 = fadd float %.175, %.176
  %.178 = load float, float* %.81
  %.179 = fadd float %.177, %.178
  %.180 = load float, float* %.84
  %.181 = fadd float %.179, %.180
  %.182 = load float, float* %.87
  %.183 = load float, float* %.90
  %.184 = fadd float %.182, %.183
  %.185 = load float, float* %.93
  %.186 = fadd float %.184, %.185
  %.187 = load float, float* %.96
  %.188 = fadd float %.186, %.187
  %.189 = load float, float* %.99
  %.190 = load float, float* %.102
  %.191 = fadd float %.189, %.190
  %.192 = load float, float* %.105
  %.193 = fadd float %.191, %.192
  %.194 = load float, float* %.108
  %.195 = fadd float %.193, %.194
  %.196 = load float, float* %.111
  %.197 = load float, float* %.114
  %.198 = fadd float %.196, %.197
  %.199 = load float, float* %.117
  %.200 = fadd float %.198, %.199
  %.201 = load float, float* %.120
  %.202 = fadd float %.200, %.201
  call void @llvm.memcpy.p0.p0.i32([10 x float]* %.131, [10 x float]* @__constant..203, i32 40, i1 false)
  %.209 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 0
  store float %.139, float* %.209
  %.212 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 1
  store float %.146, float* %.212
  %.215 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 2
  store float %.153, float* %.215
  %.218 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 3
  store float %.160, float* %.218
  %.221 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 4
  store float %.167, float* %.221
  %.224 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 5
  store float %.174, float* %.224
  %.227 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 6
  store float %.181, float* %.227
  %.230 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 7
  store float %.188, float* %.230
  %.233 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 8
  store float %.195, float* %.233
  %.236 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 9
  store float %.202, float* %.236
  %.239 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 0
  call void @putfarray(i32 10, float* %.239)
  %.242 = load i32, i32* @.g.k
  %.243 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 %.242
  %.244 = load float, float* %.243
  ret float %.244 
.124:
  %.246 = load float, float* %.6
  %.247 = load float, float* %.9
  %.248 = load float, float* %.12
  %.249 = load float, float* %.15
  %.250 = load float, float* %.18
  %.251 = load float, float* %.21
  %.252 = load float, float* %.24
  %.253 = load float, float* %.27
  %.254 = load float, float* %.30
  %.255 = load float, float* %.33
  %.256 = load float, float* %.36
  %.257 = load float, float* %.39
  %.258 = load float, float* %.42
  %.259 = load float, float* %.45
  %.260 = load float, float* %.48
  %.261 = load float, float* %.51
  %.262 = load float, float* %.54
  %.263 = load float, float* %.57
  %.264 = load float, float* %.60
  %.265 = load float, float* %.63
  %.266 = load float, float* %.66
  %.267 = load float, float* %.69
  %.268 = load float, float* %.72
  %.269 = load float, float* %.75
  %.270 = load float, float* %.78
  %.271 = load float, float* %.81
  %.272 = load float, float* %.84
  %.273 = load float, float* %.87
  %.274 = load float, float* %.90
  %.275 = load float, float* %.93
  %.276 = load float, float* %.96
  %.277 = load float, float* %.99
  %.278 = load float, float* %.102
  %.279 = load float, float* %.105
  %.280 = load float, float* %.108
  %.281 = load float, float* %.111
  %.282 = load float, float* %.114
  %.283 = load float, float* %.117
  %.284 = load float, float* %.120
  %.285 = load float, float* %.3
  %.286 = load float, float* %.6
  %.287 = fadd float %.285, %.286
  %.288 = load float, float* %.9
  %.289 = fadd float %.287, %.288
  %.290at20 = call float @params_f40(float %.246, float %.247, float %.248, float %.249, float %.250, float %.251, float %.252, float %.253, float %.254, float %.255, float %.256, float %.257, float %.258, float %.259, float %.260, float %.261, float %.262, float %.263, float %.264, float %.265, float %.266, float %.267, float %.268, float %.269, float %.270, float %.271, float %.272, float %.273, float %.274, float %.275, float %.276, float %.277, float %.278, float %.279, float %.280, float %.281, float %.282, float %.283, float %.284, float %.289)
  ret float %.290at20 
}
define float @params_f40_i24(i32 %.295, i32 %.298, i32 %.301, float %.304, i32 %.307, i32 %.310, i32 %.313, float %.316, float %.319, float %.322, i32 %.325, float %.328, float %.331, i32 %.334, float %.337, i32 %.340, float %.343, float %.346, float %.349, float %.352, float %.355, float %.358, i32 %.361, float %.364, i32 %.367, i32 %.370, float %.373, float %.376, float %.379, float %.382, float %.385, i32 %.388, float %.391, i32 %.394, float %.397, float %.400, float %.403, float %.406, i32 %.409, i32 %.412, float %.415, float %.418, float %.421, i32 %.424, float %.427, i32 %.430, i32 %.433, float %.436, float %.439, float %.442, float %.445, i32 %.448, i32 %.451, i32 %.454, float %.457, float %.460, float %.463, float %.466, float %.469, float %.472, i32 %.475, float %.478, i32 %.481, float %.484){
.293:
  %.651 = alloca i32
  %.585 = alloca [8 x i32]
  %.491 = alloca [10 x float]
  %.483 = alloca float
  %.480 = alloca i32
  %.477 = alloca float
  %.474 = alloca i32
  %.471 = alloca float
  %.468 = alloca float
  %.465 = alloca float
  %.462 = alloca float
  %.459 = alloca float
  %.456 = alloca float
  %.453 = alloca i32
  %.450 = alloca i32
  %.447 = alloca i32
  %.444 = alloca float
  %.441 = alloca float
  %.438 = alloca float
  %.435 = alloca float
  %.432 = alloca i32
  %.429 = alloca i32
  %.426 = alloca float
  %.423 = alloca i32
  %.420 = alloca float
  %.417 = alloca float
  %.414 = alloca float
  %.411 = alloca i32
  %.408 = alloca i32
  %.405 = alloca float
  %.402 = alloca float
  %.399 = alloca float
  %.396 = alloca float
  %.393 = alloca i32
  %.390 = alloca float
  %.387 = alloca i32
  %.384 = alloca float
  %.381 = alloca float
  %.378 = alloca float
  %.375 = alloca float
  %.372 = alloca float
  %.369 = alloca i32
  %.366 = alloca i32
  %.363 = alloca float
  %.360 = alloca i32
  %.357 = alloca float
  %.354 = alloca float
  %.351 = alloca float
  %.348 = alloca float
  %.345 = alloca float
  %.342 = alloca float
  %.339 = alloca i32
  %.336 = alloca float
  %.333 = alloca i32
  %.330 = alloca float
  %.327 = alloca float
  %.324 = alloca i32
  %.321 = alloca float
  %.318 = alloca float
  %.315 = alloca float
  %.312 = alloca i32
  %.309 = alloca i32
  %.306 = alloca i32
  %.303 = alloca float
  %.300 = alloca i32
  %.297 = alloca i32
  %.294 = alloca i32
  store i32 %.295, i32* %.294
  store i32 %.298, i32* %.297
  store i32 %.301, i32* %.300
  store float %.304, float* %.303
  store i32 %.307, i32* %.306
  store i32 %.310, i32* %.309
  store i32 %.313, i32* %.312
  store float %.316, float* %.315
  store float %.319, float* %.318
  store float %.322, float* %.321
  store i32 %.325, i32* %.324
  store float %.328, float* %.327
  store float %.331, float* %.330
  store i32 %.334, i32* %.333
  store float %.337, float* %.336
  store i32 %.340, i32* %.339
  store float %.343, float* %.342
  store float %.346, float* %.345
  store float %.349, float* %.348
  store float %.352, float* %.351
  store float %.355, float* %.354
  store float %.358, float* %.357
  store i32 %.361, i32* %.360
  store float %.364, float* %.363
  store i32 %.367, i32* %.366
  store i32 %.370, i32* %.369
  store float %.373, float* %.372
  store float %.376, float* %.375
  store float %.379, float* %.378
  store float %.382, float* %.381
  store float %.385, float* %.384
  store i32 %.388, i32* %.387
  store float %.391, float* %.390
  store i32 %.394, i32* %.393
  store float %.397, float* %.396
  store float %.400, float* %.399
  store float %.403, float* %.402
  store float %.406, float* %.405
  store i32 %.409, i32* %.408
  store i32 %.412, i32* %.411
  store float %.415, float* %.414
  store float %.418, float* %.417
  store float %.421, float* %.420
  store i32 %.424, i32* %.423
  store float %.427, float* %.426
  store i32 %.430, i32* %.429
  store i32 %.433, i32* %.432
  store float %.436, float* %.435
  store float %.439, float* %.438
  store float %.442, float* %.441
  store float %.445, float* %.444
  store i32 %.448, i32* %.447
  store i32 %.451, i32* %.450
  store i32 %.454, i32* %.453
  store float %.457, float* %.456
  store float %.460, float* %.459
  store float %.463, float* %.462
  store float %.466, float* %.465
  store float %.469, float* %.468
  store float %.472, float* %.471
  store i32 %.475, i32* %.474
  store float %.478, float* %.477
  store i32 %.481, i32* %.480
  store float %.484, float* %.483
  %.488 = load i32, i32* %.294
  %.489 = icmp ne i32 %.488, 0
  br i1 %.489, label %.486, label %.487
.486:
  %.493 = load float, float* %.420
  %.494 = load float, float* %.348
  %.495 = fadd float %.493, %.494
  %.496 = load float, float* %.477
  %.497 = fadd float %.495, %.496
  %.498 = load float, float* %.327
  %.499 = fadd float %.497, %.498
  %.500 = load float, float* %.303
  %.501 = load float, float* %.402
  %.502 = fadd float %.500, %.501
  %.503 = load float, float* %.357
  %.504 = fadd float %.502, %.503
  %.505 = load float, float* %.321
  %.506 = fadd float %.504, %.505
  %.507 = load float, float* %.315
  %.508 = load float, float* %.381
  %.509 = fadd float %.507, %.508
  %.510 = load float, float* %.417
  %.511 = fadd float %.509, %.510
  %.512 = load float, float* %.351
  %.513 = fadd float %.511, %.512
  %.514 = load float, float* %.345
  %.515 = load float, float* %.441
  %.516 = fadd float %.514, %.515
  %.517 = load float, float* %.414
  %.518 = fadd float %.516, %.517
  %.519 = load float, float* %.318
  %.520 = fadd float %.518, %.519
  %.521 = load float, float* %.399
  %.522 = load float, float* %.471
  %.523 = fadd float %.521, %.522
  %.524 = load float, float* %.456
  %.525 = fadd float %.523, %.524
  %.526 = load float, float* %.459
  %.527 = fadd float %.525, %.526
  %.528 = load float, float* %.372
  %.529 = load float, float* %.396
  %.530 = fadd float %.528, %.529
  %.531 = load float, float* %.462
  %.532 = fadd float %.530, %.531
  %.533 = load float, float* %.378
  %.534 = fadd float %.532, %.533
  %.535 = load float, float* %.438
  %.536 = load float, float* %.384
  %.537 = fadd float %.535, %.536
  %.538 = load float, float* %.465
  %.539 = fadd float %.537, %.538
  %.540 = load float, float* %.435
  %.541 = fadd float %.539, %.540
  %.542 = load float, float* %.330
  %.543 = load float, float* %.444
  %.544 = fadd float %.542, %.543
  %.545 = load float, float* %.342
  %.546 = fadd float %.544, %.545
  %.547 = load float, float* %.426
  %.548 = fadd float %.546, %.547
  %.549 = load float, float* %.363
  %.550 = load float, float* %.375
  %.551 = fadd float %.549, %.550
  %.552 = load float, float* %.405
  %.553 = fadd float %.551, %.552
  %.554 = load float, float* %.483
  %.555 = fadd float %.553, %.554
  %.556 = load float, float* %.468
  %.557 = load float, float* %.336
  %.558 = fadd float %.556, %.557
  %.559 = load float, float* %.354
  %.560 = fadd float %.558, %.559
  %.561 = load float, float* %.390
  %.562 = fadd float %.560, %.561
  call void @llvm.memcpy.p0.p0.i32([10 x float]* %.491, [10 x float]* @__constant..563, i32 40, i1 false)
  %.565 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 0
  store float %.499, float* %.565
  %.567 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 1
  store float %.506, float* %.567
  %.569 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 2
  store float %.513, float* %.569
  %.571 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 3
  store float %.520, float* %.571
  %.573 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 4
  store float %.527, float* %.573
  %.575 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 5
  store float %.534, float* %.575
  %.577 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 6
  store float %.541, float* %.577
  %.579 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 7
  store float %.548, float* %.579
  %.581 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 8
  store float %.555, float* %.581
  %.583 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 9
  store float %.562, float* %.583
  %.587 = load i32, i32* %.333
  %.588 = load i32, i32* %.306
  %.589 = add i32 %.587, %.588
  %.590 = load i32, i32* %.297
  %.591 = add i32 %.589, %.590
  %.592 = load i32, i32* %.447
  %.593 = load i32, i32* %.309
  %.594 = add i32 %.592, %.593
  %.595 = load i32, i32* %.312
  %.596 = add i32 %.594, %.595
  %.597 = load i32, i32* %.300
  %.598 = load i32, i32* %.360
  %.599 = add i32 %.597, %.598
  %.600 = load i32, i32* %.387
  %.601 = add i32 %.599, %.600
  %.602 = load i32, i32* %.411
  %.603 = load i32, i32* %.366
  %.604 = add i32 %.602, %.603
  %.605 = load i32, i32* %.429
  %.606 = add i32 %.604, %.605
  %.607 = load i32, i32* %.423
  %.608 = load i32, i32* %.369
  %.609 = add i32 %.607, %.608
  %.610 = load i32, i32* %.480
  %.611 = add i32 %.609, %.610
  %.612 = load i32, i32* %.474
  %.613 = load i32, i32* %.432
  %.614 = add i32 %.612, %.613
  %.615 = load i32, i32* %.393
  %.616 = add i32 %.614, %.615
  %.617 = load i32, i32* %.408
  %.618 = load i32, i32* %.339
  %.619 = add i32 %.617, %.618
  %.620 = load i32, i32* %.453
  %.621 = add i32 %.619, %.620
  %.622 = load i32, i32* %.450
  %.623 = load i32, i32* %.324
  %.624 = add i32 %.622, %.623
  %.625 = load i32, i32* %.294
  %.626 = add i32 %.624, %.625
  call void @llvm.memcpy.p0.p0.i32([8 x i32]* %.585, [8 x i32]* @__constant..627, i32 32, i1 false)
  %.630 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 0
  store i32 %.591, i32* %.630
  %.632 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 1
  store i32 %.596, i32* %.632
  %.634 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 2
  store i32 %.601, i32* %.634
  %.636 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 3
  store i32 %.606, i32* %.636
  %.638 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 4
  store i32 %.611, i32* %.638
  %.640 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 5
  store i32 %.616, i32* %.640
  %.642 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 6
  store i32 %.621, i32* %.642
  %.644 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 7
  store i32 %.626, i32* %.644
  %.646 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 0
  call void @putfarray(i32 10, float* %.646)
  %.648 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 0
  call void @putarray(i32 8, i32* %.648)
  store i32 0, i32* %.651
  br label %.653wc51 
.487:
  %.681 = load i32, i32* %.306
  %.682 = load i32, i32* %.297
  %.683 = load i32, i32* %.300
  %.684 = load float, float* %.303
  %.685 = load i32, i32* %.306
  %.686 = load i32, i32* %.309
  %.687 = load i32, i32* %.312
  %.688 = load float, float* %.315
  %.689 = load float, float* %.318
  %.690 = load float, float* %.321
  %.691 = load i32, i32* %.324
  %.692 = load float, float* %.327
  %.693 = load float, float* %.330
  %.694 = load i32, i32* %.333
  %.695 = load float, float* %.336
  %.696 = load i32, i32* %.339
  %.697 = load float, float* %.342
  %.698 = load float, float* %.345
  %.699 = load float, float* %.348
  %.700 = load float, float* %.351
  %.701 = load float, float* %.354
  %.702 = load float, float* %.357
  %.703 = load i32, i32* %.360
  %.704 = load float, float* %.363
  %.705 = load i32, i32* %.366
  %.706 = load i32, i32* %.369
  %.707 = load float, float* %.372
  %.708 = load float, float* %.375
  %.709 = load float, float* %.378
  %.710 = load float, float* %.381
  %.711 = load float, float* %.384
  %.712 = load i32, i32* %.387
  %.713 = load float, float* %.390
  %.714 = load i32, i32* %.393
  %.715 = load float, float* %.396
  %.716 = load float, float* %.399
  %.717 = load float, float* %.402
  %.718 = load float, float* %.405
  %.719 = load i32, i32* %.408
  %.720 = load i32, i32* %.411
  %.721 = load float, float* %.414
  %.722 = load float, float* %.417
  %.723 = load float, float* %.420
  %.724 = load i32, i32* %.423
  %.725 = load float, float* %.426
  %.726 = load i32, i32* %.429
  %.727 = load i32, i32* %.432
  %.728 = load float, float* %.435
  %.729 = load float, float* %.438
  %.730 = load float, float* %.441
  %.731 = load float, float* %.444
  %.732 = load i32, i32* %.447
  %.733 = load i32, i32* %.450
  %.734 = load i32, i32* %.453
  %.735 = load float, float* %.456
  %.736 = load float, float* %.459
  %.737 = load float, float* %.462
  %.738 = load float, float* %.465
  %.739 = load float, float* %.468
  %.740 = load float, float* %.471
  %.741 = load i32, i32* %.474
  %.742 = load float, float* %.477
  %.743 = load i32, i32* %.480
  %.744 = load float, float* %.483
  %.745at57 = call float @params_f40_i24(i32 %.681, i32 %.682, i32 %.683, float %.684, i32 %.685, i32 %.686, i32 %.687, float %.688, float %.689, float %.690, i32 %.691, float %.692, float %.693, i32 %.694, float %.695, i32 %.696, float %.697, float %.698, float %.699, float %.700, float %.701, float %.702, i32 %.703, float %.704, i32 %.705, i32 %.706, float %.707, float %.708, float %.709, float %.710, float %.711, i32 %.712, float %.713, i32 %.714, float %.715, float %.716, float %.717, float %.718, i32 %.719, i32 %.720, float %.721, float %.722, float %.723, i32 %.724, float %.725, i32 %.726, i32 %.727, float %.728, float %.729, float %.730, float %.731, i32 %.732, i32 %.733, i32 %.734, float %.735, float %.736, float %.737, float %.738, float %.739, float %.740, i32 %.741, float %.742, i32 %.743, float %.744)
  ret float %.745at57 
.653wc51:
  %.657 = load i32, i32* %.651
  %.658 = icmp slt i32 %.657, 8
  br i1 %.658, label %.654wloop.51.54, label %.655wn54
.654wloop.51.54:
  %.660 = load i32, i32* %.651
  %.661 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 %.660
  %.662 = load i32, i32* %.661
  %.663 = load i32, i32* %.651
  %.664 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 %.663
  %.665 = load float, float* %.664
  %.666 = sitofp i32 %.662 to float
  %.667 = fsub float %.666, %.665
  %.668 = load i32, i32* %.651
  %.669 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 %.668
  %.670 = fptosi float %.667 to i32
  store i32 %.670, i32* %.669
  %.672 = load i32, i32* %.651
  %.673 = add i32 %.672, 1
  store i32 %.673, i32* %.651
  br label %.653wc51 
.655wn54:
  %.676 = load i32, i32* @.g.k
  %.677 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 %.676
  %.678 = load i32, i32* %.677
  %.679 = sitofp i32 %.678 to float
  ret float %.679 
}
define float @params_fa40(float* %.750, float* %.753, float* %.756, float* %.759, float* %.762, float* %.765, float* %.768, float* %.771, float* %.774, float* %.777, float* %.780, float* %.783, float* %.786, float* %.789, float* %.792, float* %.795, float* %.798, float* %.801, float* %.804, float* %.807, float* %.810, float* %.813, float* %.816, float* %.819, float* %.822, float* %.825, float* %.828, float* %.831, float* %.834, float* %.837, float* %.840, float* %.843, float* %.846, float* %.849, float* %.852, float* %.855, float* %.858, float* %.861, float* %.864, float* %.867){
.748:
  %.869 = alloca [10 x float]
  %.866 = alloca float*
  %.863 = alloca float*
  %.860 = alloca float*
  %.857 = alloca float*
  %.854 = alloca float*
  %.851 = alloca float*
  %.848 = alloca float*
  %.845 = alloca float*
  %.842 = alloca float*
  %.839 = alloca float*
  %.836 = alloca float*
  %.833 = alloca float*
  %.830 = alloca float*
  %.827 = alloca float*
  %.824 = alloca float*
  %.821 = alloca float*
  %.818 = alloca float*
  %.815 = alloca float*
  %.812 = alloca float*
  %.809 = alloca float*
  %.806 = alloca float*
  %.803 = alloca float*
  %.800 = alloca float*
  %.797 = alloca float*
  %.794 = alloca float*
  %.791 = alloca float*
  %.788 = alloca float*
  %.785 = alloca float*
  %.782 = alloca float*
  %.779 = alloca float*
  %.776 = alloca float*
  %.773 = alloca float*
  %.770 = alloca float*
  %.767 = alloca float*
  %.764 = alloca float*
  %.761 = alloca float*
  %.758 = alloca float*
  %.755 = alloca float*
  %.752 = alloca float*
  %.749 = alloca float*
  store float* %.750, float** %.749
  store float* %.753, float** %.752
  store float* %.756, float** %.755
  store float* %.759, float** %.758
  store float* %.762, float** %.761
  store float* %.765, float** %.764
  store float* %.768, float** %.767
  store float* %.771, float** %.770
  store float* %.774, float** %.773
  store float* %.777, float** %.776
  store float* %.780, float** %.779
  store float* %.783, float** %.782
  store float* %.786, float** %.785
  store float* %.789, float** %.788
  store float* %.792, float** %.791
  store float* %.795, float** %.794
  store float* %.798, float** %.797
  store float* %.801, float** %.800
  store float* %.804, float** %.803
  store float* %.807, float** %.806
  store float* %.810, float** %.809
  store float* %.813, float** %.812
  store float* %.816, float** %.815
  store float* %.819, float** %.818
  store float* %.822, float** %.821
  store float* %.825, float** %.824
  store float* %.828, float** %.827
  store float* %.831, float** %.830
  store float* %.834, float** %.833
  store float* %.837, float** %.836
  store float* %.840, float** %.839
  store float* %.843, float** %.842
  store float* %.846, float** %.845
  store float* %.849, float** %.848
  store float* %.852, float** %.851
  store float* %.855, float** %.854
  store float* %.858, float** %.857
  store float* %.861, float** %.860
  store float* %.864, float** %.863
  store float* %.867, float** %.866
  %.871 = load i32, i32* @.g.k
  %.872 = load float*, float** %.749
  %.873 = getelementptr inbounds float, float* %.872, i32 %.871
  %.874 = load float, float* %.873
  %.875 = load i32, i32* @.g.k
  %.876 = load float*, float** %.752
  %.877 = getelementptr inbounds float, float* %.876, i32 %.875
  %.878 = load float, float* %.877
  %.879 = fadd float %.874, %.878
  %.880 = load i32, i32* @.g.k
  %.881 = load float*, float** %.755
  %.882 = getelementptr inbounds float, float* %.881, i32 %.880
  %.883 = load float, float* %.882
  %.884 = fadd float %.879, %.883
  %.885 = load i32, i32* @.g.k
  %.886 = load float*, float** %.758
  %.887 = getelementptr inbounds float, float* %.886, i32 %.885
  %.888 = load float, float* %.887
  %.889 = fadd float %.884, %.888
  %.890 = load i32, i32* @.g.k
  %.891 = load float*, float** %.761
  %.892 = getelementptr inbounds float, float* %.891, i32 %.890
  %.893 = load float, float* %.892
  %.894 = load i32, i32* @.g.k
  %.895 = load float*, float** %.764
  %.896 = getelementptr inbounds float, float* %.895, i32 %.894
  %.897 = load float, float* %.896
  %.898 = fadd float %.893, %.897
  %.899 = load i32, i32* @.g.k
  %.900 = load float*, float** %.767
  %.901 = getelementptr inbounds float, float* %.900, i32 %.899
  %.902 = load float, float* %.901
  %.903 = fadd float %.898, %.902
  %.904 = load i32, i32* @.g.k
  %.905 = load float*, float** %.770
  %.906 = getelementptr inbounds float, float* %.905, i32 %.904
  %.907 = load float, float* %.906
  %.908 = fadd float %.903, %.907
  %.909 = load i32, i32* @.g.k
  %.910 = load float*, float** %.773
  %.911 = getelementptr inbounds float, float* %.910, i32 %.909
  %.912 = load float, float* %.911
  %.913 = load i32, i32* @.g.k
  %.914 = load float*, float** %.776
  %.915 = getelementptr inbounds float, float* %.914, i32 %.913
  %.916 = load float, float* %.915
  %.917 = fadd float %.912, %.916
  %.918 = load i32, i32* @.g.k
  %.919 = load float*, float** %.779
  %.920 = getelementptr inbounds float, float* %.919, i32 %.918
  %.921 = load float, float* %.920
  %.922 = fadd float %.917, %.921
  %.923 = load i32, i32* @.g.k
  %.924 = load float*, float** %.782
  %.925 = getelementptr inbounds float, float* %.924, i32 %.923
  %.926 = load float, float* %.925
  %.927 = fadd float %.922, %.926
  %.928 = load i32, i32* @.g.k
  %.929 = load float*, float** %.785
  %.930 = getelementptr inbounds float, float* %.929, i32 %.928
  %.931 = load float, float* %.930
  %.932 = load i32, i32* @.g.k
  %.933 = load float*, float** %.788
  %.934 = getelementptr inbounds float, float* %.933, i32 %.932
  %.935 = load float, float* %.934
  %.936 = fadd float %.931, %.935
  %.937 = load i32, i32* @.g.k
  %.938 = load float*, float** %.791
  %.939 = getelementptr inbounds float, float* %.938, i32 %.937
  %.940 = load float, float* %.939
  %.941 = fadd float %.936, %.940
  %.942 = load i32, i32* @.g.k
  %.943 = load float*, float** %.794
  %.944 = getelementptr inbounds float, float* %.943, i32 %.942
  %.945 = load float, float* %.944
  %.946 = fadd float %.941, %.945
  %.947 = load i32, i32* @.g.k
  %.948 = load float*, float** %.797
  %.949 = getelementptr inbounds float, float* %.948, i32 %.947
  %.950 = load float, float* %.949
  %.951 = load i32, i32* @.g.k
  %.952 = load float*, float** %.800
  %.953 = getelementptr inbounds float, float* %.952, i32 %.951
  %.954 = load float, float* %.953
  %.955 = fadd float %.950, %.954
  %.956 = load i32, i32* @.g.k
  %.957 = load float*, float** %.803
  %.958 = getelementptr inbounds float, float* %.957, i32 %.956
  %.959 = load float, float* %.958
  %.960 = fadd float %.955, %.959
  %.961 = load i32, i32* @.g.k
  %.962 = load float*, float** %.806
  %.963 = getelementptr inbounds float, float* %.962, i32 %.961
  %.964 = load float, float* %.963
  %.965 = fadd float %.960, %.964
  %.966 = load i32, i32* @.g.k
  %.967 = load float*, float** %.809
  %.968 = getelementptr inbounds float, float* %.967, i32 %.966
  %.969 = load float, float* %.968
  %.970 = load i32, i32* @.g.k
  %.971 = load float*, float** %.812
  %.972 = getelementptr inbounds float, float* %.971, i32 %.970
  %.973 = load float, float* %.972
  %.974 = fadd float %.969, %.973
  %.975 = load i32, i32* @.g.k
  %.976 = load float*, float** %.815
  %.977 = getelementptr inbounds float, float* %.976, i32 %.975
  %.978 = load float, float* %.977
  %.979 = fadd float %.974, %.978
  %.980 = load i32, i32* @.g.k
  %.981 = load float*, float** %.818
  %.982 = getelementptr inbounds float, float* %.981, i32 %.980
  %.983 = load float, float* %.982
  %.984 = fadd float %.979, %.983
  %.985 = load i32, i32* @.g.k
  %.986 = load float*, float** %.821
  %.987 = getelementptr inbounds float, float* %.986, i32 %.985
  %.988 = load float, float* %.987
  %.989 = load i32, i32* @.g.k
  %.990 = load float*, float** %.824
  %.991 = getelementptr inbounds float, float* %.990, i32 %.989
  %.992 = load float, float* %.991
  %.993 = fadd float %.988, %.992
  %.994 = load i32, i32* @.g.k
  %.995 = load float*, float** %.827
  %.996 = getelementptr inbounds float, float* %.995, i32 %.994
  %.997 = load float, float* %.996
  %.998 = fadd float %.993, %.997
  %.999 = load i32, i32* @.g.k
  %.1000 = load float*, float** %.830
  %.1001 = getelementptr inbounds float, float* %.1000, i32 %.999
  %.1002 = load float, float* %.1001
  %.1003 = fadd float %.998, %.1002
  %.1004 = load i32, i32* @.g.k
  %.1005 = load float*, float** %.833
  %.1006 = getelementptr inbounds float, float* %.1005, i32 %.1004
  %.1007 = load float, float* %.1006
  %.1008 = load i32, i32* @.g.k
  %.1009 = load float*, float** %.836
  %.1010 = getelementptr inbounds float, float* %.1009, i32 %.1008
  %.1011 = load float, float* %.1010
  %.1012 = fadd float %.1007, %.1011
  %.1013 = load i32, i32* @.g.k
  %.1014 = load float*, float** %.839
  %.1015 = getelementptr inbounds float, float* %.1014, i32 %.1013
  %.1016 = load float, float* %.1015
  %.1017 = fadd float %.1012, %.1016
  %.1018 = load i32, i32* @.g.k
  %.1019 = load float*, float** %.842
  %.1020 = getelementptr inbounds float, float* %.1019, i32 %.1018
  %.1021 = load float, float* %.1020
  %.1022 = fadd float %.1017, %.1021
  %.1023 = load i32, i32* @.g.k
  %.1024 = load float*, float** %.845
  %.1025 = getelementptr inbounds float, float* %.1024, i32 %.1023
  %.1026 = load float, float* %.1025
  %.1027 = load i32, i32* @.g.k
  %.1028 = load float*, float** %.848
  %.1029 = getelementptr inbounds float, float* %.1028, i32 %.1027
  %.1030 = load float, float* %.1029
  %.1031 = fadd float %.1026, %.1030
  %.1032 = load i32, i32* @.g.k
  %.1033 = load float*, float** %.851
  %.1034 = getelementptr inbounds float, float* %.1033, i32 %.1032
  %.1035 = load float, float* %.1034
  %.1036 = fadd float %.1031, %.1035
  %.1037 = load i32, i32* @.g.k
  %.1038 = load float*, float** %.854
  %.1039 = getelementptr inbounds float, float* %.1038, i32 %.1037
  %.1040 = load float, float* %.1039
  %.1041 = fadd float %.1036, %.1040
  %.1042 = load i32, i32* @.g.k
  %.1043 = load float*, float** %.857
  %.1044 = getelementptr inbounds float, float* %.1043, i32 %.1042
  %.1045 = load float, float* %.1044
  %.1046 = load i32, i32* @.g.k
  %.1047 = load float*, float** %.860
  %.1048 = getelementptr inbounds float, float* %.1047, i32 %.1046
  %.1049 = load float, float* %.1048
  %.1050 = fadd float %.1045, %.1049
  %.1051 = load i32, i32* @.g.k
  %.1052 = load float*, float** %.863
  %.1053 = getelementptr inbounds float, float* %.1052, i32 %.1051
  %.1054 = load float, float* %.1053
  %.1055 = fadd float %.1050, %.1054
  %.1056 = load i32, i32* @.g.k
  %.1057 = load float*, float** %.866
  %.1058 = getelementptr inbounds float, float* %.1057, i32 %.1056
  %.1059 = load float, float* %.1058
  %.1060 = fadd float %.1055, %.1059
  call void @llvm.memcpy.p0.p0.i32([10 x float]* %.869, [10 x float]* @__constant..1061, i32 40, i1 false)
  %.1063 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 0
  store float %.889, float* %.1063
  %.1065 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 1
  store float %.908, float* %.1065
  %.1067 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 2
  store float %.927, float* %.1067
  %.1069 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 3
  store float %.946, float* %.1069
  %.1071 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 4
  store float %.965, float* %.1071
  %.1073 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 5
  store float %.984, float* %.1073
  %.1075 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 6
  store float %.1003, float* %.1075
  %.1077 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 7
  store float %.1022, float* %.1077
  %.1079 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 8
  store float %.1041, float* %.1079
  %.1081 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 9
  store float %.1060, float* %.1081
  %.1085 = load i32, i32* @.g.k
  %.1086 = load float*, float** %.866
  %.1087 = getelementptr inbounds float, float* %.1086, i32 %.1085
  %.1088 = load float, float* %.1087
  %.1089 = sitofp i32 0 to float
  %.1090 = fcmp une float %.1088, %.1089
  %.1091 = zext i1 %.1090 to i32  %.1092 = icmp ne i32 %.1091, 0
  %.1093 = sitofp i1 %.1092 to float
  %.1094 = fcmp une float %.1093, 0x0
  %.1095 = sitofp i1 %.1094 to float
  %.1096 = fcmp une float %.1095, 0x0
  br i1 %.1096, label %.1083, label %.1084
.1083:
  %.1098 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 0
  call void @putfarray(i32 10, float* %.1098)
  %.1100 = load i32, i32* @.g.k
  %.1101 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 %.1100
  %.1102 = load float, float* %.1101
  ret float %.1102 
.1084:
  %.1104 = load float*, float** %.752
  %.1105 = load float*, float** %.755
  %.1106 = load float*, float** %.758
  %.1107 = load float*, float** %.761
  %.1108 = load float*, float** %.764
  %.1109 = load float*, float** %.767
  %.1110 = load float*, float** %.770
  %.1111 = load float*, float** %.773
  %.1112 = load float*, float** %.776
  %.1113 = load float*, float** %.779
  %.1114 = load float*, float** %.782
  %.1115 = load float*, float** %.785
  %.1116 = load float*, float** %.788
  %.1117 = load float*, float** %.791
  %.1118 = load float*, float** %.794
  %.1119 = load float*, float** %.797
  %.1120 = load float*, float** %.800
  %.1121 = load float*, float** %.803
  %.1122 = load float*, float** %.806
  %.1123 = load float*, float** %.809
  %.1124 = load float*, float** %.812
  %.1125 = load float*, float** %.815
  %.1126 = load float*, float** %.818
  %.1127 = load float*, float** %.821
  %.1128 = load float*, float** %.824
  %.1129 = load float*, float** %.827
  %.1130 = load float*, float** %.830
  %.1131 = load float*, float** %.833
  %.1132 = load float*, float** %.836
  %.1133 = load float*, float** %.839
  %.1134 = load float*, float** %.842
  %.1135 = load float*, float** %.845
  %.1136 = load float*, float** %.848
  %.1137 = load float*, float** %.851
  %.1138 = load float*, float** %.854
  %.1139 = load float*, float** %.857
  %.1140 = load float*, float** %.860
  %.1141 = load float*, float** %.863
  %.1142 = load float*, float** %.866
  %.1143 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 0
  %.1144at86 = call float @params_fa40(float* %.1104, float* %.1105, float* %.1106, float* %.1107, float* %.1108, float* %.1109, float* %.1110, float* %.1111, float* %.1112, float* %.1113, float* %.1114, float* %.1115, float* %.1116, float* %.1117, float* %.1118, float* %.1119, float* %.1120, float* %.1121, float* %.1122, float* %.1123, float* %.1124, float* %.1125, float* %.1126, float* %.1127, float* %.1128, float* %.1129, float* %.1130, float* %.1131, float* %.1132, float* %.1133, float* %.1134, float* %.1135, float* %.1136, float* %.1137, float* %.1138, float* %.1139, float* %.1140, float* %.1141, float* %.1142, float* %.1143)
  ret float %.1144at86 
}
define i32 @params_mix(float %.1149, i32* %.1152, i32 %.1155, float* %.1158, float %.1161, i32 %.1164, float %.1167, float %.1170, float* %.1173, i32* %.1176, i32 %.1179, i32 %.1182, float* %.1185, i32* %.1188, i32* %.1191, i32 %.1194, float* %.1197, float* %.1200, float %.1203, float %.1206, float %.1209, float* %.1212, i32 %.1215, float %.1218, float %.1221, float %.1224, i32* %.1227, float* %.1230, i32* %.1233, i32* %.1236, float* %.1239, float %.1242, float %.1245, i32* %.1248, i32 %.1251, float* %.1254, float* %.1257, float %.1260, float %.1263, i32* %.1266, i32* %.1269, i32 %.1272, i32 %.1275, float %.1278, float %.1281, i32* %.1284, i32 %.1287, float* %.1290, i32 %.1293, i32* %.1296, i32* %.1299, float %.1302, float %.1305, float* %.1308, i32 %.1311, i32* %.1314, float* %.1317, float %.1320, i32 %.1323, float %.1326, float* %.1329, float* %.1332, float %.1335, i32 %.1338){
.1147:
  %.1590 = alloca i32
  %.1470 = alloca [10 x i32]
  %.1340 = alloca [10 x float]
  %.1337 = alloca i32
  %.1334 = alloca float
  %.1331 = alloca float*
  %.1328 = alloca float*
  %.1325 = alloca float
  %.1322 = alloca i32
  %.1319 = alloca float
  %.1316 = alloca float*
  %.1313 = alloca i32*
  %.1310 = alloca i32
  %.1307 = alloca float*
  %.1304 = alloca float
  %.1301 = alloca float
  %.1298 = alloca i32*
  %.1295 = alloca i32*
  %.1292 = alloca i32
  %.1289 = alloca float*
  %.1286 = alloca i32
  %.1283 = alloca i32*
  %.1280 = alloca float
  %.1277 = alloca float
  %.1274 = alloca i32
  %.1271 = alloca i32
  %.1268 = alloca i32*
  %.1265 = alloca i32*
  %.1262 = alloca float
  %.1259 = alloca float
  %.1256 = alloca float*
  %.1253 = alloca float*
  %.1250 = alloca i32
  %.1247 = alloca i32*
  %.1244 = alloca float
  %.1241 = alloca float
  %.1238 = alloca float*
  %.1235 = alloca i32*
  %.1232 = alloca i32*
  %.1229 = alloca float*
  %.1226 = alloca i32*
  %.1223 = alloca float
  %.1220 = alloca float
  %.1217 = alloca float
  %.1214 = alloca i32
  %.1211 = alloca float*
  %.1208 = alloca float
  %.1205 = alloca float
  %.1202 = alloca float
  %.1199 = alloca float*
  %.1196 = alloca float*
  %.1193 = alloca i32
  %.1190 = alloca i32*
  %.1187 = alloca i32*
  %.1184 = alloca float*
  %.1181 = alloca i32
  %.1178 = alloca i32
  %.1175 = alloca i32*
  %.1172 = alloca float*
  %.1169 = alloca float
  %.1166 = alloca float
  %.1163 = alloca i32
  %.1160 = alloca float
  %.1157 = alloca float*
  %.1154 = alloca i32
  %.1151 = alloca i32*
  %.1148 = alloca float
  store float %.1149, float* %.1148
  store i32* %.1152, i32** %.1151
  store i32 %.1155, i32* %.1154
  store float* %.1158, float** %.1157
  store float %.1161, float* %.1160
  store i32 %.1164, i32* %.1163
  store float %.1167, float* %.1166
  store float %.1170, float* %.1169
  store float* %.1173, float** %.1172
  store i32* %.1176, i32** %.1175
  store i32 %.1179, i32* %.1178
  store i32 %.1182, i32* %.1181
  store float* %.1185, float** %.1184
  store i32* %.1188, i32** %.1187
  store i32* %.1191, i32** %.1190
  store i32 %.1194, i32* %.1193
  store float* %.1197, float** %.1196
  store float* %.1200, float** %.1199
  store float %.1203, float* %.1202
  store float %.1206, float* %.1205
  store float %.1209, float* %.1208
  store float* %.1212, float** %.1211
  store i32 %.1215, i32* %.1214
  store float %.1218, float* %.1217
  store float %.1221, float* %.1220
  store float %.1224, float* %.1223
  store i32* %.1227, i32** %.1226
  store float* %.1230, float** %.1229
  store i32* %.1233, i32** %.1232
  store i32* %.1236, i32** %.1235
  store float* %.1239, float** %.1238
  store float %.1242, float* %.1241
  store float %.1245, float* %.1244
  store i32* %.1248, i32** %.1247
  store i32 %.1251, i32* %.1250
  store float* %.1254, float** %.1253
  store float* %.1257, float** %.1256
  store float %.1260, float* %.1259
  store float %.1263, float* %.1262
  store i32* %.1266, i32** %.1265
  store i32* %.1269, i32** %.1268
  store i32 %.1272, i32* %.1271
  store i32 %.1275, i32* %.1274
  store float %.1278, float* %.1277
  store float %.1281, float* %.1280
  store i32* %.1284, i32** %.1283
  store i32 %.1287, i32* %.1286
  store float* %.1290, float** %.1289
  store i32 %.1293, i32* %.1292
  store i32* %.1296, i32** %.1295
  store i32* %.1299, i32** %.1298
  store float %.1302, float* %.1301
  store float %.1305, float* %.1304
  store float* %.1308, float** %.1307
  store i32 %.1311, i32* %.1310
  store i32* %.1314, i32** %.1313
  store float* %.1317, float** %.1316
  store float %.1320, float* %.1319
  store i32 %.1323, i32* %.1322
  store float %.1326, float* %.1325
  store float* %.1329, float** %.1328
  store float* %.1332, float** %.1331
  store float %.1335, float* %.1334
  store i32 %.1338, i32* %.1337
  %.1342 = load float, float* %.1148
  %.1343 = load i32, i32* @.g.k
  %.1344 = load float*, float** %.1157
  %.1345 = getelementptr inbounds float, float* %.1344, i32 %.1343
  %.1346 = load float, float* %.1345
  %.1347 = fadd float %.1342, %.1346
  %.1348 = load float, float* %.1160
  %.1349 = fadd float %.1347, %.1348
  %.1350 = load float, float* %.1166
  %.1351 = fadd float %.1349, %.1350
  %.1352 = load float, float* %.1169
  %.1353 = load i32, i32* @.g.k
  %.1354 = load float*, float** %.1172
  %.1355 = getelementptr inbounds float, float* %.1354, i32 %.1353
  %.1356 = load float, float* %.1355
  %.1357 = fadd float %.1352, %.1356
  %.1358 = load i32, i32* @.g.k
  %.1359 = load float*, float** %.1184
  %.1360 = getelementptr inbounds float, float* %.1359, i32 %.1358
  %.1361 = load float, float* %.1360
  %.1362 = fadd float %.1357, %.1361
  %.1363 = load i32, i32* @.g.k
  %.1364 = load float*, float** %.1196
  %.1365 = getelementptr inbounds float, float* %.1364, i32 %.1363
  %.1366 = load float, float* %.1365
  %.1367 = fadd float %.1362, %.1366
  %.1368 = load i32, i32* @.g.k
  %.1369 = load float*, float** %.1199
  %.1370 = getelementptr inbounds float, float* %.1369, i32 %.1368
  %.1371 = load float, float* %.1370
  %.1372 = load float, float* %.1202
  %.1373 = fadd float %.1371, %.1372
  %.1374 = load float, float* %.1205
  %.1375 = fadd float %.1373, %.1374
  %.1376 = load float, float* %.1208
  %.1377 = fadd float %.1375, %.1376
  %.1378 = load i32, i32* @.g.k
  %.1379 = load float*, float** %.1211
  %.1380 = getelementptr inbounds float, float* %.1379, i32 %.1378
  %.1381 = load float, float* %.1380
  %.1382 = load float, float* %.1217
  %.1383 = fadd float %.1381, %.1382
  %.1384 = load float, float* %.1220
  %.1385 = fadd float %.1383, %.1384
  %.1386 = load float, float* %.1223
  %.1387 = fadd float %.1385, %.1386
  %.1388 = load i32, i32* @.g.k
  %.1389 = load float*, float** %.1229
  %.1390 = getelementptr inbounds float, float* %.1389, i32 %.1388
  %.1391 = load float, float* %.1390
  %.1392 = load i32, i32* @.g.k
  %.1393 = load float*, float** %.1238
  %.1394 = getelementptr inbounds float, float* %.1393, i32 %.1392
  %.1395 = load float, float* %.1394
  %.1396 = fadd float %.1391, %.1395
  %.1397 = load float, float* %.1241
  %.1398 = fadd float %.1396, %.1397
  %.1399 = load float, float* %.1244
  %.1400 = fadd float %.1398, %.1399
  %.1401 = load i32, i32* @.g.k
  %.1402 = load float*, float** %.1253
  %.1403 = getelementptr inbounds float, float* %.1402, i32 %.1401
  %.1404 = load float, float* %.1403
  %.1405 = load i32, i32* @.g.k
  %.1406 = load float*, float** %.1256
  %.1407 = getelementptr inbounds float, float* %.1406, i32 %.1405
  %.1408 = load float, float* %.1407
  %.1409 = fadd float %.1404, %.1408
  %.1410 = load float, float* %.1259
  %.1411 = fadd float %.1409, %.1410
  %.1412 = load float, float* %.1262
  %.1413 = fadd float %.1411, %.1412
  %.1414 = load float, float* %.1277
  %.1415 = load float, float* %.1280
  %.1416 = fadd float %.1414, %.1415
  %.1417 = load i32, i32* @.g.k
  %.1418 = load float*, float** %.1289
  %.1419 = getelementptr inbounds float, float* %.1418, i32 %.1417
  %.1420 = load float, float* %.1419
  %.1421 = fadd float %.1416, %.1420
  %.1422 = load float, float* %.1301
  %.1423 = fadd float %.1421, %.1422
  %.1424 = load float, float* %.1304
  %.1425 = load i32, i32* @.g.k
  %.1426 = load float*, float** %.1307
  %.1427 = getelementptr inbounds float, float* %.1426, i32 %.1425
  %.1428 = load float, float* %.1427
  %.1429 = fadd float %.1424, %.1428
  %.1430 = load i32, i32* @.g.k
  %.1431 = load float*, float** %.1316
  %.1432 = getelementptr inbounds float, float* %.1431, i32 %.1430
  %.1433 = load float, float* %.1432
  %.1434 = fadd float %.1429, %.1433
  %.1435 = load float, float* %.1319
  %.1436 = fadd float %.1434, %.1435
  %.1437 = load float, float* %.1325
  %.1438 = load i32, i32* @.g.k
  %.1439 = load float*, float** %.1328
  %.1440 = getelementptr inbounds float, float* %.1439, i32 %.1438
  %.1441 = load float, float* %.1440
  %.1442 = fadd float %.1437, %.1441
  %.1443 = load i32, i32* @.g.k
  %.1444 = load float*, float** %.1331
  %.1445 = getelementptr inbounds float, float* %.1444, i32 %.1443
  %.1446 = load float, float* %.1445
  %.1447 = fadd float %.1442, %.1446
  %.1448 = load float, float* %.1334
  %.1449 = fadd float %.1447, %.1448
  call void @llvm.memcpy.p0.p0.i32([10 x float]* %.1340, [10 x float]* @__constant..1450, i32 40, i1 false)
  %.1452 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 0
  store float %.1351, float* %.1452
  %.1454 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 1
  store float %.1367, float* %.1454
  %.1456 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 2
  store float %.1377, float* %.1456
  %.1458 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 3
  store float %.1387, float* %.1458
  %.1460 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 4
  store float %.1400, float* %.1460
  %.1462 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 5
  store float %.1413, float* %.1462
  %.1464 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 6
  store float %.1423, float* %.1464
  %.1466 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 7
  store float %.1436, float* %.1466
  %.1468 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 8
  store float %.1449, float* %.1468
  %.1472 = load i32, i32* @.g.k
  %.1473 = load i32*, i32** %.1151
  %.1474 = getelementptr inbounds i32, i32* %.1473, i32 %.1472
  %.1475 = load i32, i32* %.1474
  %.1476 = load i32, i32* %.1154
  %.1477 = add i32 %.1475, %.1476
  %.1478 = load i32, i32* %.1163
  %.1479 = add i32 %.1477, %.1478
  %.1480 = load i32, i32* @.g.k
  %.1481 = load i32*, i32** %.1175
  %.1482 = getelementptr inbounds i32, i32* %.1481, i32 %.1480
  %.1483 = load i32, i32* %.1482
  %.1484 = load i32, i32* %.1178
  %.1485 = add i32 %.1483, %.1484
  %.1486 = load i32, i32* %.1181
  %.1487 = add i32 %.1485, %.1486
  %.1488 = load i32, i32* @.g.k
  %.1489 = load i32*, i32** %.1187
  %.1490 = getelementptr inbounds i32, i32* %.1489, i32 %.1488
  %.1491 = load i32, i32* %.1490
  %.1492 = load i32, i32* @.g.k
  %.1493 = load i32*, i32** %.1190
  %.1494 = getelementptr inbounds i32, i32* %.1493, i32 %.1492
  %.1495 = load i32, i32* %.1494
  %.1496 = add i32 %.1491, %.1495
  %.1497 = load i32, i32* %.1193
  %.1498 = add i32 %.1496, %.1497
  %.1499 = load i32, i32* %.1214
  %.1500 = load i32, i32* @.g.k
  %.1501 = load i32*, i32** %.1226
  %.1502 = getelementptr inbounds i32, i32* %.1501, i32 %.1500
  %.1503 = load i32, i32* %.1502
  %.1504 = add i32 %.1499, %.1503
  %.1505 = load i32, i32* @.g.k
  %.1506 = load i32*, i32** %.1232
  %.1507 = getelementptr inbounds i32, i32* %.1506, i32 %.1505
  %.1508 = load i32, i32* %.1507
  %.1509 = add i32 %.1504, %.1508
  %.1510 = load i32, i32* @.g.k
  %.1511 = load i32*, i32** %.1235
  %.1512 = getelementptr inbounds i32, i32* %.1511, i32 %.1510
  %.1513 = load i32, i32* %.1512
  %.1514 = load i32, i32* @.g.k
  %.1515 = load i32*, i32** %.1247
  %.1516 = getelementptr inbounds i32, i32* %.1515, i32 %.1514
  %.1517 = load i32, i32* %.1516
  %.1518 = add i32 %.1513, %.1517
  %.1519 = load i32, i32* %.1250
  %.1520 = add i32 %.1518, %.1519
  %.1521 = load i32, i32* @.g.k
  %.1522 = load i32*, i32** %.1265
  %.1523 = getelementptr inbounds i32, i32* %.1522, i32 %.1521
  %.1524 = load i32, i32* %.1523
  %.1525 = load i32, i32* @.g.k
  %.1526 = load i32*, i32** %.1268
  %.1527 = getelementptr inbounds i32, i32* %.1526, i32 %.1525
  %.1528 = load i32, i32* %.1527
  %.1529 = add i32 %.1524, %.1528
  %.1530 = load i32, i32* %.1271
  %.1531 = add i32 %.1529, %.1530
  %.1532 = load i32, i32* %.1274
  %.1533 = load i32, i32* @.g.k
  %.1534 = load i32*, i32** %.1283
  %.1535 = getelementptr inbounds i32, i32* %.1534, i32 %.1533
  %.1536 = load i32, i32* %.1535
  %.1537 = add i32 %.1532, %.1536
  %.1538 = load i32, i32* %.1286
  %.1539 = add i32 %.1537, %.1538
  %.1540 = load i32, i32* %.1292
  %.1541 = load i32, i32* @.g.k
  %.1542 = load i32*, i32** %.1295
  %.1543 = getelementptr inbounds i32, i32* %.1542, i32 %.1541
  %.1544 = load i32, i32* %.1543
  %.1545 = add i32 %.1540, %.1544
  %.1546 = load i32, i32* @.g.k
  %.1547 = load i32*, i32** %.1298
  %.1548 = getelementptr inbounds i32, i32* %.1547, i32 %.1546
  %.1549 = load i32, i32* %.1548
  %.1550 = add i32 %.1545, %.1549
  %.1551 = load i32, i32* %.1310
  %.1552 = load i32, i32* @.g.k
  %.1553 = load i32*, i32** %.1313
  %.1554 = getelementptr inbounds i32, i32* %.1553, i32 %.1552
  %.1555 = load i32, i32* %.1554
  %.1556 = add i32 %.1551, %.1555
  %.1557 = load i32, i32* %.1322
  %.1558 = add i32 %.1556, %.1557
  %.1559 = load i32, i32* %.1337
  %.1560 = add i32 %.1558, %.1559
  call void @llvm.memcpy.p0.p0.i32([10 x i32]* %.1470, [10 x i32]* @__constant..1561, i32 40, i1 false)
  %.1563 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 0
  store i32 %.1479, i32* %.1563
  %.1565 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 1
  store i32 %.1487, i32* %.1565
  %.1567 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 2
  store i32 %.1498, i32* %.1567
  %.1569 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 3
  store i32 %.1509, i32* %.1569
  %.1571 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 4
  store i32 %.1520, i32* %.1571
  %.1573 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 5
  store i32 %.1531, i32* %.1573
  %.1575 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 6
  store i32 %.1539, i32* %.1575
  %.1577 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 7
  store i32 %.1550, i32* %.1577
  %.1579 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 8
  store i32 %.1560, i32* %.1579
  %.1583 = load i32, i32* %.1337
  %.1584 = icmp ne i32 %.1583, 0
  br i1 %.1584, label %.1581, label %.1582
.1581:
  %.1586 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 0
  call void @putfarray(i32 10, float* %.1586)
  %.1588 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 0
  call void @putarray(i32 10, i32* %.1588)
  store i32 0, i32* %.1590
  br label %.1592wc118 
.1582:
  %.1624 = load float, float* %.1148
  %.1625 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 0
  %.1626 = load i32, i32* %.1154
  %.1627 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 0
  %.1628 = load float, float* %.1160
  %.1629 = load i32, i32* %.1163
  %.1630 = load float, float* %.1166
  %.1631 = load float, float* %.1169
  %.1632 = load float*, float** %.1172
  %.1633 = load i32*, i32** %.1175
  %.1634 = load i32, i32* %.1178
  %.1635 = load i32, i32* %.1181
  %.1636 = load float*, float** %.1184
  %.1637 = load i32*, i32** %.1187
  %.1638 = load i32*, i32** %.1190
  %.1639 = load i32, i32* %.1193
  %.1640 = load float*, float** %.1196
  %.1641 = load float*, float** %.1199
  %.1642 = load float, float* %.1202
  %.1643 = load float, float* %.1205
  %.1644 = load float, float* %.1208
  %.1645 = load float*, float** %.1211
  %.1646 = load i32, i32* %.1214
  %.1647 = load float, float* %.1217
  %.1648 = load float, float* %.1220
  %.1649 = load float, float* %.1223
  %.1650 = load i32*, i32** %.1226
  %.1651 = load float*, float** %.1229
  %.1652 = load i32*, i32** %.1232
  %.1653 = load i32*, i32** %.1235
  %.1654 = load float*, float** %.1238
  %.1655 = load float, float* %.1241
  %.1656 = load float, float* %.1244
  %.1657 = load i32*, i32** %.1247
  %.1658 = load i32, i32* %.1250
  %.1659 = load float*, float** %.1253
  %.1660 = load float*, float** %.1256
  %.1661 = load float, float* %.1259
  %.1662 = load float, float* %.1262
  %.1663 = load i32*, i32** %.1265
  %.1664 = load i32*, i32** %.1268
  %.1665 = load i32, i32* %.1271
  %.1666 = load i32, i32* %.1274
  %.1667 = load float, float* %.1277
  %.1668 = load float, float* %.1280
  %.1669 = load i32*, i32** %.1283
  %.1670 = load i32, i32* %.1286
  %.1671 = load float*, float** %.1289
  %.1672 = load i32, i32* %.1292
  %.1673 = load i32*, i32** %.1295
  %.1674 = load i32*, i32** %.1298
  %.1675 = load float, float* %.1301
  %.1676 = load float, float* %.1304
  %.1677 = load float*, float** %.1307
  %.1678 = load i32, i32* %.1310
  %.1679 = load i32*, i32** %.1313
  %.1680 = load float*, float** %.1316
  %.1681 = load float, float* %.1319
  %.1682 = load i32, i32* %.1322
  %.1683 = load float, float* %.1325
  %.1684 = load float*, float** %.1328
  %.1685 = load float*, float** %.1331
  %.1686 = load i32, i32* %.1337
  %.1687 = load float, float* %.1334
  %.1688 = sitofp i32 %.1686 to float
  %.1689 = fptosi float %.1687 to i32
  %.1690at124 = call i32 @params_mix(float %.1624, i32* %.1625, i32 %.1626, float* %.1627, float %.1628, i32 %.1629, float %.1630, float %.1631, float* %.1632, i32* %.1633, i32 %.1634, i32 %.1635, float* %.1636, i32* %.1637, i32* %.1638, i32 %.1639, float* %.1640, float* %.1641, float %.1642, float %.1643, float %.1644, float* %.1645, i32 %.1646, float %.1647, float %.1648, float %.1649, i32* %.1650, float* %.1651, i32* %.1652, i32* %.1653, float* %.1654, float %.1655, float %.1656, i32* %.1657, i32 %.1658, float* %.1659, float* %.1660, float %.1661, float %.1662, i32* %.1663, i32* %.1664, i32 %.1665, i32 %.1666, float %.1667, float %.1668, i32* %.1669, i32 %.1670, float* %.1671, i32 %.1672, i32* %.1673, i32* %.1674, float %.1675, float %.1676, float* %.1677, i32 %.1678, i32* %.1679, float* %.1680, float %.1681, i32 %.1682, float %.1683, float* %.1684, float* %.1685, float %.1688, i32 %.1689)
  ret i32 %.1690at124 
.1592wc118:
  %.1596 = load i32, i32* %.1590
  %.1597 = icmp slt i32 %.1596, 10
  br i1 %.1597, label %.1593wloop.118.121, label %.1594wn121
.1593wloop.118.121:
  %.1599 = load i32, i32* %.1590
  %.1600 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 %.1599
  %.1601 = load i32, i32* %.1600
  %.1602 = load i32, i32* %.1590
  %.1603 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 %.1602
  %.1604 = load float, float* %.1603
  %.1605 = sitofp i32 %.1601 to float
  %.1606 = fsub float %.1605, %.1604
  %.1607 = load i32, i32* %.1590
  %.1608 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 %.1607
  %.1609 = fptosi float %.1606 to i32
  store i32 %.1609, i32* %.1608
  %.1611 = load i32, i32* %.1590
  %.1612 = add i32 %.1611, 1
  store i32 %.1612, i32* %.1590
  br label %.1592wc118 
.1594wn121:
  %.1615 = load i32, i32* @.g.k
  %.1616 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 %.1615
  %.1617 = load i32, i32* %.1616
  %.1618 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 8
  %.1619 = load float, float* %.1618
  %.1620 = sitofp i32 %.1617 to float
  %.1621 = fmul float %.1620, %.1619
  %.1622 = fptosi float %.1621 to i32
  ret i32 %.1622 
}
define i32 @main(){
.1693:
  %.2121 = alloca i32
  %.2078 = alloca float
  %.1883 = alloca float
  %.1733 = alloca float
  %.1697 = alloca i32
  %.1696 = alloca [24 x [3 x i32]]
  %.1694 = alloca [40 x [3 x float]]
  %.1699at137 = call i32 @getint()
  store i32 %.1699at137, i32* @.g.k
  store i32 0, i32* %.1697
  br label %.1702wc139 
.1702wc139:
  %.1706 = load i32, i32* %.1697
  %.1707 = icmp slt i32 %.1706, 40
  br i1 %.1707, label %.1703wloop.139.142, label %.1704wn142
.1703wloop.139.142:
  %.1709 = load i32, i32* %.1697
  %.1710 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 %.1709, i32 0
  %.1712at140 = call i32 @getfarray(float* %.1710)
  %.1713 = load i32, i32* %.1697
  %.1714 = add i32 %.1713, 1
  store i32 %.1714, i32* %.1697
  br label %.1702wc139 
.1704wn142:
  store i32 0, i32* %.1697
  br label %.1718wc144 
.1718wc144:
  %.1722 = load i32, i32* %.1697
  %.1723 = icmp slt i32 %.1722, 24
  br i1 %.1723, label %.1719wloop.144.147, label %.1720wn147
.1719wloop.144.147:
  %.1725 = load i32, i32* %.1697
  %.1726 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 %.1725, i32 0
  %.1728at145 = call i32 @getarray(i32* %.1726)
  %.1729 = load i32, i32* %.1697
  %.1730 = add i32 %.1729, 1
  store i32 %.1730, i32* %.1697
  br label %.1718wc144 
.1720wn147:
  %.1734 = load i32, i32* @.g.k
  %.1735 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 0, i32 %.1734
  %.1736 = load float, float* %.1735
  %.1737 = load i32, i32* @.g.k
  %.1738 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 1, i32 %.1737
  %.1739 = load float, float* %.1738
  %.1740 = load i32, i32* @.g.k
  %.1741 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 2, i32 %.1740
  %.1742 = load float, float* %.1741
  %.1743 = load i32, i32* @.g.k
  %.1744 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 3, i32 %.1743
  %.1745 = load float, float* %.1744
  %.1746 = load i32, i32* @.g.k
  %.1747 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 4, i32 %.1746
  %.1748 = load float, float* %.1747
  %.1749 = load i32, i32* @.g.k
  %.1750 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 5, i32 %.1749
  %.1751 = load float, float* %.1750
  %.1752 = load i32, i32* @.g.k
  %.1753 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 6, i32 %.1752
  %.1754 = load float, float* %.1753
  %.1755 = load i32, i32* @.g.k
  %.1756 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 7, i32 %.1755
  %.1757 = load float, float* %.1756
  %.1758 = load i32, i32* @.g.k
  %.1759 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 8, i32 %.1758
  %.1760 = load float, float* %.1759
  %.1761 = load i32, i32* @.g.k
  %.1762 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 9, i32 %.1761
  %.1763 = load float, float* %.1762
  %.1764 = load i32, i32* @.g.k
  %.1765 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 10, i32 %.1764
  %.1766 = load float, float* %.1765
  %.1768 = load i32, i32* @.g.k
  %.1769 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 11, i32 %.1768
  %.1770 = load float, float* %.1769
  %.1772 = load i32, i32* @.g.k
  %.1773 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 12, i32 %.1772
  %.1774 = load float, float* %.1773
  %.1776 = load i32, i32* @.g.k
  %.1777 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 13, i32 %.1776
  %.1778 = load float, float* %.1777
  %.1780 = load i32, i32* @.g.k
  %.1781 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 14, i32 %.1780
  %.1782 = load float, float* %.1781
  %.1784 = load i32, i32* @.g.k
  %.1785 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 15, i32 %.1784
  %.1786 = load float, float* %.1785
  %.1788 = load i32, i32* @.g.k
  %.1789 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 16, i32 %.1788
  %.1790 = load float, float* %.1789
  %.1792 = load i32, i32* @.g.k
  %.1793 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 17, i32 %.1792
  %.1794 = load float, float* %.1793
  %.1796 = load i32, i32* @.g.k
  %.1797 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 18, i32 %.1796
  %.1798 = load float, float* %.1797
  %.1800 = load i32, i32* @.g.k
  %.1801 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 19, i32 %.1800
  %.1802 = load float, float* %.1801
  %.1804 = load i32, i32* @.g.k
  %.1805 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 20, i32 %.1804
  %.1806 = load float, float* %.1805
  %.1808 = load i32, i32* @.g.k
  %.1809 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 21, i32 %.1808
  %.1810 = load float, float* %.1809
  %.1812 = load i32, i32* @.g.k
  %.1813 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 22, i32 %.1812
  %.1814 = load float, float* %.1813
  %.1816 = load i32, i32* @.g.k
  %.1817 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 23, i32 %.1816
  %.1818 = load float, float* %.1817
  %.1819 = load i32, i32* @.g.k
  %.1820 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 24, i32 %.1819
  %.1821 = load float, float* %.1820
  %.1823 = load i32, i32* @.g.k
  %.1824 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 25, i32 %.1823
  %.1825 = load float, float* %.1824
  %.1827 = load i32, i32* @.g.k
  %.1828 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 26, i32 %.1827
  %.1829 = load float, float* %.1828
  %.1831 = load i32, i32* @.g.k
  %.1832 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 27, i32 %.1831
  %.1833 = load float, float* %.1832
  %.1835 = load i32, i32* @.g.k
  %.1836 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 28, i32 %.1835
  %.1837 = load float, float* %.1836
  %.1839 = load i32, i32* @.g.k
  %.1840 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 29, i32 %.1839
  %.1841 = load float, float* %.1840
  %.1843 = load i32, i32* @.g.k
  %.1844 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 30, i32 %.1843
  %.1845 = load float, float* %.1844
  %.1847 = load i32, i32* @.g.k
  %.1848 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 31, i32 %.1847
  %.1849 = load float, float* %.1848
  %.1850 = load i32, i32* @.g.k
  %.1851 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 32, i32 %.1850
  %.1852 = load float, float* %.1851
  %.1854 = load i32, i32* @.g.k
  %.1855 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 33, i32 %.1854
  %.1856 = load float, float* %.1855
  %.1858 = load i32, i32* @.g.k
  %.1859 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 34, i32 %.1858
  %.1860 = load float, float* %.1859
  %.1862 = load i32, i32* @.g.k
  %.1863 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 35, i32 %.1862
  %.1864 = load float, float* %.1863
  %.1866 = load i32, i32* @.g.k
  %.1867 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 36, i32 %.1866
  %.1868 = load float, float* %.1867
  %.1870 = load i32, i32* @.g.k
  %.1871 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 37, i32 %.1870
  %.1872 = load float, float* %.1871
  %.1874 = load i32, i32* @.g.k
  %.1875 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 38, i32 %.1874
  %.1876 = load float, float* %.1875
  %.1878 = load i32, i32* @.g.k
  %.1879 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 39, i32 %.1878
  %.1880 = load float, float* %.1879
  %.1881at149 = call float @params_f40(float %.1736, float %.1739, float %.1742, float %.1745, float %.1748, float %.1751, float %.1754, float %.1757, float %.1760, float %.1763, float %.1766, float %.1770, float %.1774, float %.1778, float %.1782, float %.1786, float %.1790, float %.1794, float %.1798, float %.1802, float %.1806, float %.1810, float %.1814, float %.1818, float %.1821, float %.1825, float %.1829, float %.1833, float %.1837, float %.1841, float %.1845, float %.1849, float %.1852, float %.1856, float %.1860, float %.1864, float %.1868, float %.1872, float %.1876, float %.1880)
  store float %.1881at149, float* %.1733
  %.1884 = load i32, i32* @.g.k
  %.1885 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 23, i32 %.1884
  %.1886 = load i32, i32* %.1885
  %.1887 = load i32, i32* @.g.k
  %.1888 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 2, i32 %.1887
  %.1889 = load i32, i32* %.1888
  %.1890 = load i32, i32* @.g.k
  %.1891 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 6, i32 %.1890
  %.1892 = load i32, i32* %.1891
  %.1893 = load i32, i32* @.g.k
  %.1894 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 4, i32 %.1893
  %.1895 = load float, float* %.1894
  %.1896 = load i32, i32* @.g.k
  %.1897 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 1, i32 %.1896
  %.1898 = load i32, i32* %.1897
  %.1899 = load i32, i32* @.g.k
  %.1900 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 4, i32 %.1899
  %.1901 = load i32, i32* %.1900
  %.1902 = load i32, i32* @.g.k
  %.1903 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 5, i32 %.1902
  %.1904 = load i32, i32* %.1903
  %.1905 = load i32, i32* @.g.k
  %.1906 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 8, i32 %.1905
  %.1907 = load float, float* %.1906
  %.1908 = load i32, i32* @.g.k
  %.1909 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 15, i32 %.1908
  %.1910 = load float, float* %.1909
  %.1911 = load i32, i32* @.g.k
  %.1912 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 7, i32 %.1911
  %.1913 = load float, float* %.1912
  %.1914 = load i32, i32* @.g.k
  %.1915 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 22, i32 %.1914
  %.1916 = load i32, i32* %.1915
  %.1917 = load i32, i32* @.g.k
  %.1918 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 3, i32 %.1917
  %.1919 = load float, float* %.1918
  %.1920 = load i32, i32* @.g.k
  %.1921 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 28, i32 %.1920
  %.1922 = load float, float* %.1921
  %.1923 = load i32, i32* @.g.k
  %.1924 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 0, i32 %.1923
  %.1925 = load i32, i32* %.1924
  %.1926 = load i32, i32* @.g.k
  %.1927 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 37, i32 %.1926
  %.1928 = load float, float* %.1927
  %.1929 = load i32, i32* @.g.k
  %.1930 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 19, i32 %.1929
  %.1931 = load i32, i32* %.1930
  %.1932 = load i32, i32* @.g.k
  %.1933 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 30, i32 %.1932
  %.1934 = load float, float* %.1933
  %.1935 = load i32, i32* @.g.k
  %.1936 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 12, i32 %.1935
  %.1937 = load float, float* %.1936
  %.1938 = load i32, i32* @.g.k
  %.1939 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 1, i32 %.1938
  %.1940 = load float, float* %.1939
  %.1941 = load i32, i32* @.g.k
  %.1942 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 11, i32 %.1941
  %.1943 = load float, float* %.1942
  %.1944 = load i32, i32* @.g.k
  %.1945 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 38, i32 %.1944
  %.1946 = load float, float* %.1945
  %.1947 = load i32, i32* @.g.k
  %.1948 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 6, i32 %.1947
  %.1949 = load float, float* %.1948
  %.1950 = load i32, i32* @.g.k
  %.1951 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 7, i32 %.1950
  %.1952 = load i32, i32* %.1951
  %.1953 = load i32, i32* @.g.k
  %.1954 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 32, i32 %.1953
  %.1955 = load float, float* %.1954
  %.1956 = load i32, i32* @.g.k
  %.1957 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 10, i32 %.1956
  %.1958 = load i32, i32* %.1957
  %.1959 = load i32, i32* @.g.k
  %.1960 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 13, i32 %.1959
  %.1961 = load i32, i32* %.1960
  %.1962 = load i32, i32* @.g.k
  %.1963 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 20, i32 %.1962
  %.1964 = load float, float* %.1963
  %.1965 = load i32, i32* @.g.k
  %.1966 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 33, i32 %.1965
  %.1967 = load float, float* %.1966
  %.1968 = load i32, i32* @.g.k
  %.1969 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 23, i32 %.1968
  %.1970 = load float, float* %.1969
  %.1971 = load i32, i32* @.g.k
  %.1972 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 9, i32 %.1971
  %.1973 = load float, float* %.1972
  %.1974 = load i32, i32* @.g.k
  %.1975 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 25, i32 %.1974
  %.1976 = load float, float* %.1975
  %.1977 = load i32, i32* @.g.k
  %.1978 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 8, i32 %.1977
  %.1979 = load i32, i32* %.1978
  %.1980 = load i32, i32* @.g.k
  %.1981 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 39, i32 %.1980
  %.1982 = load float, float* %.1981
  %.1983 = load i32, i32* @.g.k
  %.1984 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 17, i32 %.1983
  %.1985 = load i32, i32* %.1984
  %.1986 = load i32, i32* @.g.k
  %.1987 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 21, i32 %.1986
  %.1988 = load float, float* %.1987
  %.1989 = load i32, i32* @.g.k
  %.1990 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 16, i32 %.1989
  %.1991 = load float, float* %.1990
  %.1992 = load i32, i32* @.g.k
  %.1993 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 5, i32 %.1992
  %.1994 = load float, float* %.1993
  %.1995 = load i32, i32* @.g.k
  %.1996 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 34, i32 %.1995
  %.1997 = load float, float* %.1996
  %.1998 = load i32, i32* @.g.k
  %.1999 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 18, i32 %.1998
  %.2000 = load i32, i32* %.1999
  %.2001 = load i32, i32* @.g.k
  %.2002 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 9, i32 %.2001
  %.2003 = load i32, i32* %.2002
  %.2004 = load i32, i32* @.g.k
  %.2005 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 14, i32 %.2004
  %.2006 = load float, float* %.2005
  %.2007 = load i32, i32* @.g.k
  %.2008 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 10, i32 %.2007
  %.2009 = load float, float* %.2008
  %.2010 = load i32, i32* @.g.k
  %.2011 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 0, i32 %.2010
  %.2012 = load float, float* %.2011
  %.2013 = load i32, i32* @.g.k
  %.2014 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 12, i32 %.2013
  %.2015 = load i32, i32* %.2014
  %.2016 = load i32, i32* @.g.k
  %.2017 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 31, i32 %.2016
  %.2018 = load float, float* %.2017
  %.2019 = load i32, i32* @.g.k
  %.2020 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 11, i32 %.2019
  %.2021 = load i32, i32* %.2020
  %.2022 = load i32, i32* @.g.k
  %.2023 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 16, i32 %.2022
  %.2024 = load i32, i32* %.2023
  %.2025 = load i32, i32* @.g.k
  %.2026 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 27, i32 %.2025
  %.2027 = load float, float* %.2026
  %.2028 = load i32, i32* @.g.k
  %.2029 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 24, i32 %.2028
  %.2030 = load float, float* %.2029
  %.2031 = load i32, i32* @.g.k
  %.2032 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 13, i32 %.2031
  %.2033 = load float, float* %.2032
  %.2034 = load i32, i32* @.g.k
  %.2035 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 29, i32 %.2034
  %.2036 = load float, float* %.2035
  %.2037 = load i32, i32* @.g.k
  %.2038 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 3, i32 %.2037
  %.2039 = load i32, i32* %.2038
  %.2040 = load i32, i32* @.g.k
  %.2041 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 21, i32 %.2040
  %.2042 = load i32, i32* %.2041
  %.2043 = load i32, i32* @.g.k
  %.2044 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 20, i32 %.2043
  %.2045 = load i32, i32* %.2044
  %.2046 = load i32, i32* @.g.k
  %.2047 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 18, i32 %.2046
  %.2048 = load float, float* %.2047
  %.2049 = load i32, i32* @.g.k
  %.2050 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 19, i32 %.2049
  %.2051 = load float, float* %.2050
  %.2052 = load i32, i32* @.g.k
  %.2053 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 22, i32 %.2052
  %.2054 = load float, float* %.2053
  %.2055 = load i32, i32* @.g.k
  %.2056 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 26, i32 %.2055
  %.2057 = load float, float* %.2056
  %.2058 = load i32, i32* @.g.k
  %.2059 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 36, i32 %.2058
  %.2060 = load float, float* %.2059
  %.2061 = load i32, i32* @.g.k
  %.2062 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 17, i32 %.2061
  %.2063 = load float, float* %.2062
  %.2064 = load i32, i32* @.g.k
  %.2065 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 15, i32 %.2064
  %.2066 = load i32, i32* %.2065
  %.2067 = load i32, i32* @.g.k
  %.2068 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 2, i32 %.2067
  %.2069 = load float, float* %.2068
  %.2070 = load i32, i32* @.g.k
  %.2071 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 14, i32 %.2070
  %.2072 = load i32, i32* %.2071
  %.2073 = load i32, i32* @.g.k
  %.2074 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 35, i32 %.2073
  %.2075 = load float, float* %.2074
  %.2076at157 = call float @params_f40_i24(i32 %.1886, i32 %.1889, i32 %.1892, float %.1895, i32 %.1898, i32 %.1901, i32 %.1904, float %.1907, float %.1910, float %.1913, i32 %.1916, float %.1919, float %.1922, i32 %.1925, float %.1928, i32 %.1931, float %.1934, float %.1937, float %.1940, float %.1943, float %.1946, float %.1949, i32 %.1952, float %.1955, i32 %.1958, i32 %.1961, float %.1964, float %.1967, float %.1970, float %.1973, float %.1976, i32 %.1979, float %.1982, i32 %.1985, float %.1988, float %.1991, float %.1994, float %.1997, i32 %.2000, i32 %.2003, float %.2006, float %.2009, float %.2012, i32 %.2015, float %.2018, i32 %.2021, i32 %.2024, float %.2027, float %.2030, float %.2033, float %.2036, i32 %.2039, i32 %.2042, i32 %.2045, float %.2048, float %.2051, float %.2054, float %.2057, float %.2060, float %.2063, i32 %.2066, float %.2069, i32 %.2072, float %.2075)
  store float %.2076at157, float* %.1883
  %.2079 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 0, i32 0
  %.2080 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 1, i32 0
  %.2081 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 2, i32 0
  %.2082 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 3, i32 0
  %.2083 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 4, i32 0
  %.2084 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 5, i32 0
  %.2085 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 6, i32 0
  %.2086 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 7, i32 0
  %.2087 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 8, i32 0
  %.2088 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 9, i32 0
  %.2089 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 10, i32 0
  %.2090 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 11, i32 0
  %.2091 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 12, i32 0
  %.2092 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 13, i32 0
  %.2093 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 14, i32 0
  %.2094 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 15, i32 0
  %.2095 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 16, i32 0
  %.2096 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 17, i32 0
  %.2097 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 18, i32 0
  %.2098 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 19, i32 0
  %.2099 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 20, i32 0
  %.2100 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 21, i32 0
  %.2101 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 22, i32 0
  %.2102 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 23, i32 0
  %.2103 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 24, i32 0
  %.2104 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 25, i32 0
  %.2105 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 26, i32 0
  %.2106 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 27, i32 0
  %.2107 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 28, i32 0
  %.2108 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 29, i32 0
  %.2109 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 30, i32 0
  %.2110 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 31, i32 0
  %.2111 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 32, i32 0
  %.2112 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 33, i32 0
  %.2113 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 34, i32 0
  %.2114 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 35, i32 0
  %.2115 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 36, i32 0
  %.2116 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 37, i32 0
  %.2117 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 38, i32 0
  %.2118 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 39, i32 0
  %.2119at169 = call float @params_fa40(float* %.2079, float* %.2080, float* %.2081, float* %.2082, float* %.2083, float* %.2084, float* %.2085, float* %.2086, float* %.2087, float* %.2088, float* %.2089, float* %.2090, float* %.2091, float* %.2092, float* %.2093, float* %.2094, float* %.2095, float* %.2096, float* %.2097, float* %.2098, float* %.2099, float* %.2100, float* %.2101, float* %.2102, float* %.2103, float* %.2104, float* %.2105, float* %.2106, float* %.2107, float* %.2108, float* %.2109, float* %.2110, float* %.2111, float* %.2112, float* %.2113, float* %.2114, float* %.2115, float* %.2116, float* %.2117, float* %.2118)
  store float %.2119at169, float* %.2078
  %.2122 = load i32, i32* @.g.k
  %.2123 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 0, i32 %.2122
  %.2124 = load float, float* %.2123
  %.2125 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 0, i32 0
  %.2126 = load i32, i32* @.g.k
  %.2127 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 1, i32 %.2126
  %.2128 = load i32, i32* %.2127
  %.2129 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 1, i32 0
  %.2130 = load i32, i32* @.g.k
  %.2131 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 2, i32 %.2130
  %.2132 = load float, float* %.2131
  %.2133 = load i32, i32* @.g.k
  %.2134 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 2, i32 %.2133
  %.2135 = load i32, i32* %.2134
  %.2136 = load i32, i32* @.g.k
  %.2137 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 3, i32 %.2136
  %.2138 = load float, float* %.2137
  %.2139 = load i32, i32* @.g.k
  %.2140 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 4, i32 %.2139
  %.2141 = load float, float* %.2140
  %.2142 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 5, i32 0
  %.2143 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 3, i32 0
  %.2144 = load i32, i32* @.g.k
  %.2145 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 4, i32 %.2144
  %.2146 = load i32, i32* %.2145
  %.2147 = load i32, i32* @.g.k
  %.2148 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 5, i32 %.2147
  %.2149 = load i32, i32* %.2148
  %.2150 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 6, i32 0
  %.2151 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 6, i32 0
  %.2152 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 7, i32 0
  %.2153 = load i32, i32* @.g.k
  %.2154 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 8, i32 %.2153
  %.2155 = load i32, i32* %.2154
  %.2156 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 7, i32 0
  %.2157 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 8, i32 0
  %.2158 = load i32, i32* @.g.k
  %.2159 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 9, i32 %.2158
  %.2160 = load float, float* %.2159
  %.2161 = load i32, i32* @.g.k
  %.2162 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 10, i32 %.2161
  %.2163 = load float, float* %.2162
  %.2164 = load i32, i32* @.g.k
  %.2165 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 11, i32 %.2164
  %.2166 = load float, float* %.2165
  %.2167 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 12, i32 0
  %.2168 = load i32, i32* @.g.k
  %.2169 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 9, i32 %.2168
  %.2170 = load i32, i32* %.2169
  %.2171 = load i32, i32* @.g.k
  %.2172 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 13, i32 %.2171
  %.2173 = load float, float* %.2172
  %.2174 = load i32, i32* @.g.k
  %.2175 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 14, i32 %.2174
  %.2176 = load float, float* %.2175
  %.2177 = load i32, i32* @.g.k
  %.2178 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 15, i32 %.2177
  %.2179 = load float, float* %.2178
  %.2180 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 10, i32 0
  %.2181 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 16, i32 0
  %.2182 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 11, i32 0
  %.2183 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 12, i32 0
  %.2184 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 17, i32 0
  %.2185 = load i32, i32* @.g.k
  %.2186 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 18, i32 %.2185
  %.2187 = load float, float* %.2186
  %.2188 = load i32, i32* @.g.k
  %.2189 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 19, i32 %.2188
  %.2190 = load float, float* %.2189
  %.2191 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 13, i32 0
  %.2192 = load i32, i32* @.g.k
  %.2193 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 14, i32 %.2192
  %.2194 = load i32, i32* %.2193
  %.2195 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 20, i32 0
  %.2196 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 21, i32 0
  %.2197 = load i32, i32* @.g.k
  %.2198 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 22, i32 %.2197
  %.2199 = load float, float* %.2198
  %.2200 = load i32, i32* @.g.k
  %.2201 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 23, i32 %.2200
  %.2202 = load float, float* %.2201
  %.2203 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 15, i32 0
  %.2204 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 16, i32 0
  %.2205 = load i32, i32* @.g.k
  %.2206 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 17, i32 %.2205
  %.2207 = load i32, i32* %.2206
  %.2208 = load i32, i32* @.g.k
  %.2209 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 18, i32 %.2208
  %.2210 = load i32, i32* %.2209
  %.2211 = load i32, i32* @.g.k
  %.2212 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 24, i32 %.2211
  %.2213 = load float, float* %.2212
  %.2214 = load i32, i32* @.g.k
  %.2215 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 25, i32 %.2214
  %.2216 = load float, float* %.2215
  %.2217 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 19, i32 0
  %.2218 = load i32, i32* @.g.k
  %.2219 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 20, i32 %.2218
  %.2220 = load i32, i32* %.2219
  %.2221 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 26, i32 0
  %.2222 = load i32, i32* @.g.k
  %.2223 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 21, i32 %.2222
  %.2224 = load i32, i32* %.2223
  %.2225 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 22, i32 0
  %.2226 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 23, i32 0
  %.2227 = load i32, i32* @.g.k
  %.2228 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 27, i32 %.2227
  %.2229 = load float, float* %.2228
  %.2230 = load i32, i32* @.g.k
  %.2231 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 28, i32 %.2230
  %.2232 = load float, float* %.2231
  %.2233 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 29, i32 0
  %.2234 = load i32, i32* @.g.k
  %.2235 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 0, i32 %.2234
  %.2236 = load i32, i32* %.2235
  %.2237 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 1, i32 0
  %.2238 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 30, i32 0
  %.2239 = load i32, i32* @.g.k
  %.2240 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 31, i32 %.2239
  %.2241 = load float, float* %.2240
  %.2242 = load i32, i32* @.g.k
  %.2243 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 2, i32 %.2242
  %.2244 = load i32, i32* %.2243
  %.2245 = load i32, i32* @.g.k
  %.2246 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 32, i32 %.2245
  %.2247 = load float, float* %.2246
  %.2248 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 33, i32 0
  %.2249 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 34, i32 0
  %.2250 = load i32, i32* @.g.k
  %.2251 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 35, i32 %.2250
  %.2252 = load float, float* %.2251
  %.2253 = load i32, i32* @.g.k
  %.2254 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 3, i32 %.2253
  %.2255 = load i32, i32* %.2254
  %.2256at175 = call i32 @params_mix(float %.2124, i32* %.2125, i32 %.2128, float* %.2129, float %.2132, i32 %.2135, float %.2138, float %.2141, float* %.2142, i32* %.2143, i32 %.2146, i32 %.2149, float* %.2150, i32* %.2151, i32* %.2152, i32 %.2155, float* %.2156, float* %.2157, float %.2160, float %.2163, float %.2166, float* %.2167, i32 %.2170, float %.2173, float %.2176, float %.2179, i32* %.2180, float* %.2181, i32* %.2182, i32* %.2183, float* %.2184, float %.2187, float %.2190, i32* %.2191, i32 %.2194, float* %.2195, float* %.2196, float %.2199, float %.2202, i32* %.2203, i32* %.2204, i32 %.2207, i32 %.2210, float %.2213, float %.2216, i32* %.2217, i32 %.2220, float* %.2221, i32 %.2224, i32* %.2225, i32* %.2226, float %.2229, float %.2232, float* %.2233, i32 %.2236, i32* %.2237, float* %.2238, float %.2241, i32 %.2244, float %.2247, float* %.2248, float* %.2249, float %.2252, i32 %.2255)
  store i32 %.2256at175, i32* %.2121
  %.2258 = load float, float* %.1733
  call void @putfloat(float %.2258)
  call void @putch(i32 10)
  %.2263 = load float, float* %.1883
  call void @putfloat(float %.2263)
  call void @putch(i32 10)
  %.2266 = load float, float* %.2078
  call void @putfloat(float %.2266)
  call void @putch(i32 10)
  %.2269 = load i32, i32* %.2121
  call void @putint(i32 %.2269)
  call void @putch(i32 10)
  ret i32 0 
}
@.g.k = global i32 zeroinitializer
@__constant..203 = constant [10 x float]  [float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0]
@__constant..563 = constant [10 x float]  [float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0]
@__constant..627 = constant [8 x i32]  [i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0]
@__constant..1061 = constant [10 x float]  [float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0]
@__constant..1450 = constant [10 x float]  [float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float 0x0, float zeroinitializer]
@__constant..1561 = constant [10 x i32]  [i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 zeroinitializer]
define float @params_f40(float %.4, float %.7, float %.10, float %.13, float %.16, float %.19, float %.22, float %.25, float %.28, float %.31, float %.34, float %.37, float %.40, float %.43, float %.46, float %.49, float %.52, float %.55, float %.58, float %.61, float %.64, float %.67, float %.70, float %.73, float %.76, float %.79, float %.82, float %.85, float %.88, float %.91, float %.94, float %.97, float %.100, float %.103, float %.106, float %.109, float %.112, float %.115, float %.118, float %.121){
.2:
  %.131 = alloca [10 x float]
  %.120 = alloca float
  %.117 = alloca float
  %.114 = alloca float
  %.111 = alloca float
  %.108 = alloca float
  %.105 = alloca float
  %.102 = alloca float
  %.99 = alloca float
  %.96 = alloca float
  %.93 = alloca float
  %.90 = alloca float
  %.87 = alloca float
  %.84 = alloca float
  %.81 = alloca float
  %.78 = alloca float
  %.75 = alloca float
  %.72 = alloca float
  %.69 = alloca float
  %.66 = alloca float
  %.63 = alloca float
  %.60 = alloca float
  %.57 = alloca float
  %.54 = alloca float
  %.51 = alloca float
  %.48 = alloca float
  %.45 = alloca float
  %.42 = alloca float
  %.39 = alloca float
  %.36 = alloca float
  %.33 = alloca float
  %.30 = alloca float
  %.27 = alloca float
  %.24 = alloca float
  %.21 = alloca float
  %.18 = alloca float
  %.15 = alloca float
  %.12 = alloca float
  %.9 = alloca float
  %.6 = alloca float
  %.3 = alloca float
  store float %.4, float* %.3
  store float %.7, float* %.6
  store float %.10, float* %.9
  store float %.13, float* %.12
  store float %.16, float* %.15
  store float %.19, float* %.18
  store float %.22, float* %.21
  store float %.25, float* %.24
  store float %.28, float* %.27
  store float %.31, float* %.30
  store float %.34, float* %.33
  store float %.37, float* %.36
  store float %.40, float* %.39
  store float %.43, float* %.42
  store float %.46, float* %.45
  store float %.49, float* %.48
  store float %.52, float* %.51
  store float %.55, float* %.54
  store float %.58, float* %.57
  store float %.61, float* %.60
  store float %.64, float* %.63
  store float %.67, float* %.66
  store float %.70, float* %.69
  store float %.73, float* %.72
  store float %.76, float* %.75
  store float %.79, float* %.78
  store float %.82, float* %.81
  store float %.85, float* %.84
  store float %.88, float* %.87
  store float %.91, float* %.90
  store float %.94, float* %.93
  store float %.97, float* %.96
  store float %.100, float* %.99
  store float %.103, float* %.102
  store float %.106, float* %.105
  store float %.109, float* %.108
  store float %.112, float* %.111
  store float %.115, float* %.114
  store float %.118, float* %.117
  store float %.121, float* %.120
  %.125 = load float, float* %.120
  %.127 = sitofp i32 0 to float
  %.128 = fcmp une float %.125, %.127
  br i1 %.128, label %.123, label %.124
.123:
  %.133 = load float, float* %.3
  %.134 = load float, float* %.6
  %.135 = fadd float %.133, %.134
  %.136 = load float, float* %.9
  %.137 = fadd float %.135, %.136
  %.138 = load float, float* %.12
  %.139 = fadd float %.137, %.138
  %.140 = load float, float* %.15
  %.141 = load float, float* %.18
  %.142 = fadd float %.140, %.141
  %.143 = load float, float* %.21
  %.144 = fadd float %.142, %.143
  %.145 = load float, float* %.24
  %.146 = fadd float %.144, %.145
  %.147 = load float, float* %.27
  %.148 = load float, float* %.30
  %.149 = fadd float %.147, %.148
  %.150 = load float, float* %.33
  %.151 = fadd float %.149, %.150
  %.152 = load float, float* %.36
  %.153 = fadd float %.151, %.152
  %.154 = load float, float* %.39
  %.155 = load float, float* %.42
  %.156 = fadd float %.154, %.155
  %.157 = load float, float* %.45
  %.158 = fadd float %.156, %.157
  %.159 = load float, float* %.48
  %.160 = fadd float %.158, %.159
  %.161 = load float, float* %.51
  %.162 = load float, float* %.54
  %.163 = fadd float %.161, %.162
  %.164 = load float, float* %.57
  %.165 = fadd float %.163, %.164
  %.166 = load float, float* %.60
  %.167 = fadd float %.165, %.166
  %.168 = load float, float* %.63
  %.169 = load float, float* %.66
  %.170 = fadd float %.168, %.169
  %.171 = load float, float* %.69
  %.172 = fadd float %.170, %.171
  %.173 = load float, float* %.72
  %.174 = fadd float %.172, %.173
  %.175 = load float, float* %.75
  %.176 = load float, float* %.78
  %.177 = fadd float %.175, %.176
  %.178 = load float, float* %.81
  %.179 = fadd float %.177, %.178
  %.180 = load float, float* %.84
  %.181 = fadd float %.179, %.180
  %.182 = load float, float* %.87
  %.183 = load float, float* %.90
  %.184 = fadd float %.182, %.183
  %.185 = load float, float* %.93
  %.186 = fadd float %.184, %.185
  %.187 = load float, float* %.96
  %.188 = fadd float %.186, %.187
  %.189 = load float, float* %.99
  %.190 = load float, float* %.102
  %.191 = fadd float %.189, %.190
  %.192 = load float, float* %.105
  %.193 = fadd float %.191, %.192
  %.194 = load float, float* %.108
  %.195 = fadd float %.193, %.194
  %.196 = load float, float* %.111
  %.197 = load float, float* %.114
  %.198 = fadd float %.196, %.197
  %.199 = load float, float* %.117
  %.200 = fadd float %.198, %.199
  %.201 = load float, float* %.120
  %.202 = fadd float %.200, %.201
  call void @llvm.memcpy.p0.p0.i32([10 x float]* %.131, [10 x float]* @__constant..203, i32 40, i1 false)
  %.209 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 0
  store float %.139, float* %.209
  %.212 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 1
  store float %.146, float* %.212
  %.215 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 2
  store float %.153, float* %.215
  %.218 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 3
  store float %.160, float* %.218
  %.221 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 4
  store float %.167, float* %.221
  %.224 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 5
  store float %.174, float* %.224
  %.227 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 6
  store float %.181, float* %.227
  %.230 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 7
  store float %.188, float* %.230
  %.233 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 8
  store float %.195, float* %.233
  %.236 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 9
  store float %.202, float* %.236
  %.239 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 0
  call void @putfarray(i32 10, float* %.239)
  %.242 = load i32, i32* @.g.k
  %.243 = getelementptr inbounds [10 x float], [10 x float]* %.131, i32 0, i32 %.242
  %.244 = load float, float* %.243
  ret float %.244 
.124:
  %.246 = load float, float* %.6
  %.247 = load float, float* %.9
  %.248 = load float, float* %.12
  %.249 = load float, float* %.15
  %.250 = load float, float* %.18
  %.251 = load float, float* %.21
  %.252 = load float, float* %.24
  %.253 = load float, float* %.27
  %.254 = load float, float* %.30
  %.255 = load float, float* %.33
  %.256 = load float, float* %.36
  %.257 = load float, float* %.39
  %.258 = load float, float* %.42
  %.259 = load float, float* %.45
  %.260 = load float, float* %.48
  %.261 = load float, float* %.51
  %.262 = load float, float* %.54
  %.263 = load float, float* %.57
  %.264 = load float, float* %.60
  %.265 = load float, float* %.63
  %.266 = load float, float* %.66
  %.267 = load float, float* %.69
  %.268 = load float, float* %.72
  %.269 = load float, float* %.75
  %.270 = load float, float* %.78
  %.271 = load float, float* %.81
  %.272 = load float, float* %.84
  %.273 = load float, float* %.87
  %.274 = load float, float* %.90
  %.275 = load float, float* %.93
  %.276 = load float, float* %.96
  %.277 = load float, float* %.99
  %.278 = load float, float* %.102
  %.279 = load float, float* %.105
  %.280 = load float, float* %.108
  %.281 = load float, float* %.111
  %.282 = load float, float* %.114
  %.283 = load float, float* %.117
  %.284 = load float, float* %.120
  %.285 = load float, float* %.3
  %.286 = load float, float* %.6
  %.287 = fadd float %.285, %.286
  %.288 = load float, float* %.9
  %.289 = fadd float %.287, %.288
  %.290at20 = call float @params_f40(float %.246, float %.247, float %.248, float %.249, float %.250, float %.251, float %.252, float %.253, float %.254, float %.255, float %.256, float %.257, float %.258, float %.259, float %.260, float %.261, float %.262, float %.263, float %.264, float %.265, float %.266, float %.267, float %.268, float %.269, float %.270, float %.271, float %.272, float %.273, float %.274, float %.275, float %.276, float %.277, float %.278, float %.279, float %.280, float %.281, float %.282, float %.283, float %.284, float %.289)
  ret float %.290at20 
}
define float @params_f40_i24(i32 %.295, i32 %.298, i32 %.301, float %.304, i32 %.307, i32 %.310, i32 %.313, float %.316, float %.319, float %.322, i32 %.325, float %.328, float %.331, i32 %.334, float %.337, i32 %.340, float %.343, float %.346, float %.349, float %.352, float %.355, float %.358, i32 %.361, float %.364, i32 %.367, i32 %.370, float %.373, float %.376, float %.379, float %.382, float %.385, i32 %.388, float %.391, i32 %.394, float %.397, float %.400, float %.403, float %.406, i32 %.409, i32 %.412, float %.415, float %.418, float %.421, i32 %.424, float %.427, i32 %.430, i32 %.433, float %.436, float %.439, float %.442, float %.445, i32 %.448, i32 %.451, i32 %.454, float %.457, float %.460, float %.463, float %.466, float %.469, float %.472, i32 %.475, float %.478, i32 %.481, float %.484){
.293:
  %.651 = alloca i32
  %.585 = alloca [8 x i32]
  %.491 = alloca [10 x float]
  %.483 = alloca float
  %.480 = alloca i32
  %.477 = alloca float
  %.474 = alloca i32
  %.471 = alloca float
  %.468 = alloca float
  %.465 = alloca float
  %.462 = alloca float
  %.459 = alloca float
  %.456 = alloca float
  %.453 = alloca i32
  %.450 = alloca i32
  %.447 = alloca i32
  %.444 = alloca float
  %.441 = alloca float
  %.438 = alloca float
  %.435 = alloca float
  %.432 = alloca i32
  %.429 = alloca i32
  %.426 = alloca float
  %.423 = alloca i32
  %.420 = alloca float
  %.417 = alloca float
  %.414 = alloca float
  %.411 = alloca i32
  %.408 = alloca i32
  %.405 = alloca float
  %.402 = alloca float
  %.399 = alloca float
  %.396 = alloca float
  %.393 = alloca i32
  %.390 = alloca float
  %.387 = alloca i32
  %.384 = alloca float
  %.381 = alloca float
  %.378 = alloca float
  %.375 = alloca float
  %.372 = alloca float
  %.369 = alloca i32
  %.366 = alloca i32
  %.363 = alloca float
  %.360 = alloca i32
  %.357 = alloca float
  %.354 = alloca float
  %.351 = alloca float
  %.348 = alloca float
  %.345 = alloca float
  %.342 = alloca float
  %.339 = alloca i32
  %.336 = alloca float
  %.333 = alloca i32
  %.330 = alloca float
  %.327 = alloca float
  %.324 = alloca i32
  %.321 = alloca float
  %.318 = alloca float
  %.315 = alloca float
  %.312 = alloca i32
  %.309 = alloca i32
  %.306 = alloca i32
  %.303 = alloca float
  %.300 = alloca i32
  %.297 = alloca i32
  %.294 = alloca i32
  store i32 %.295, i32* %.294
  store i32 %.298, i32* %.297
  store i32 %.301, i32* %.300
  store float %.304, float* %.303
  store i32 %.307, i32* %.306
  store i32 %.310, i32* %.309
  store i32 %.313, i32* %.312
  store float %.316, float* %.315
  store float %.319, float* %.318
  store float %.322, float* %.321
  store i32 %.325, i32* %.324
  store float %.328, float* %.327
  store float %.331, float* %.330
  store i32 %.334, i32* %.333
  store float %.337, float* %.336
  store i32 %.340, i32* %.339
  store float %.343, float* %.342
  store float %.346, float* %.345
  store float %.349, float* %.348
  store float %.352, float* %.351
  store float %.355, float* %.354
  store float %.358, float* %.357
  store i32 %.361, i32* %.360
  store float %.364, float* %.363
  store i32 %.367, i32* %.366
  store i32 %.370, i32* %.369
  store float %.373, float* %.372
  store float %.376, float* %.375
  store float %.379, float* %.378
  store float %.382, float* %.381
  store float %.385, float* %.384
  store i32 %.388, i32* %.387
  store float %.391, float* %.390
  store i32 %.394, i32* %.393
  store float %.397, float* %.396
  store float %.400, float* %.399
  store float %.403, float* %.402
  store float %.406, float* %.405
  store i32 %.409, i32* %.408
  store i32 %.412, i32* %.411
  store float %.415, float* %.414
  store float %.418, float* %.417
  store float %.421, float* %.420
  store i32 %.424, i32* %.423
  store float %.427, float* %.426
  store i32 %.430, i32* %.429
  store i32 %.433, i32* %.432
  store float %.436, float* %.435
  store float %.439, float* %.438
  store float %.442, float* %.441
  store float %.445, float* %.444
  store i32 %.448, i32* %.447
  store i32 %.451, i32* %.450
  store i32 %.454, i32* %.453
  store float %.457, float* %.456
  store float %.460, float* %.459
  store float %.463, float* %.462
  store float %.466, float* %.465
  store float %.469, float* %.468
  store float %.472, float* %.471
  store i32 %.475, i32* %.474
  store float %.478, float* %.477
  store i32 %.481, i32* %.480
  store float %.484, float* %.483
  %.488 = load i32, i32* %.294
  %.489 = icmp ne i32 %.488, 0
  br i1 %.489, label %.486, label %.487
.486:
  %.493 = load float, float* %.420
  %.494 = load float, float* %.348
  %.495 = fadd float %.493, %.494
  %.496 = load float, float* %.477
  %.497 = fadd float %.495, %.496
  %.498 = load float, float* %.327
  %.499 = fadd float %.497, %.498
  %.500 = load float, float* %.303
  %.501 = load float, float* %.402
  %.502 = fadd float %.500, %.501
  %.503 = load float, float* %.357
  %.504 = fadd float %.502, %.503
  %.505 = load float, float* %.321
  %.506 = fadd float %.504, %.505
  %.507 = load float, float* %.315
  %.508 = load float, float* %.381
  %.509 = fadd float %.507, %.508
  %.510 = load float, float* %.417
  %.511 = fadd float %.509, %.510
  %.512 = load float, float* %.351
  %.513 = fadd float %.511, %.512
  %.514 = load float, float* %.345
  %.515 = load float, float* %.441
  %.516 = fadd float %.514, %.515
  %.517 = load float, float* %.414
  %.518 = fadd float %.516, %.517
  %.519 = load float, float* %.318
  %.520 = fadd float %.518, %.519
  %.521 = load float, float* %.399
  %.522 = load float, float* %.471
  %.523 = fadd float %.521, %.522
  %.524 = load float, float* %.456
  %.525 = fadd float %.523, %.524
  %.526 = load float, float* %.459
  %.527 = fadd float %.525, %.526
  %.528 = load float, float* %.372
  %.529 = load float, float* %.396
  %.530 = fadd float %.528, %.529
  %.531 = load float, float* %.462
  %.532 = fadd float %.530, %.531
  %.533 = load float, float* %.378
  %.534 = fadd float %.532, %.533
  %.535 = load float, float* %.438
  %.536 = load float, float* %.384
  %.537 = fadd float %.535, %.536
  %.538 = load float, float* %.465
  %.539 = fadd float %.537, %.538
  %.540 = load float, float* %.435
  %.541 = fadd float %.539, %.540
  %.542 = load float, float* %.330
  %.543 = load float, float* %.444
  %.544 = fadd float %.542, %.543
  %.545 = load float, float* %.342
  %.546 = fadd float %.544, %.545
  %.547 = load float, float* %.426
  %.548 = fadd float %.546, %.547
  %.549 = load float, float* %.363
  %.550 = load float, float* %.375
  %.551 = fadd float %.549, %.550
  %.552 = load float, float* %.405
  %.553 = fadd float %.551, %.552
  %.554 = load float, float* %.483
  %.555 = fadd float %.553, %.554
  %.556 = load float, float* %.468
  %.557 = load float, float* %.336
  %.558 = fadd float %.556, %.557
  %.559 = load float, float* %.354
  %.560 = fadd float %.558, %.559
  %.561 = load float, float* %.390
  %.562 = fadd float %.560, %.561
  call void @llvm.memcpy.p0.p0.i32([10 x float]* %.491, [10 x float]* @__constant..563, i32 40, i1 false)
  %.565 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 0
  store float %.499, float* %.565
  %.567 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 1
  store float %.506, float* %.567
  %.569 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 2
  store float %.513, float* %.569
  %.571 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 3
  store float %.520, float* %.571
  %.573 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 4
  store float %.527, float* %.573
  %.575 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 5
  store float %.534, float* %.575
  %.577 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 6
  store float %.541, float* %.577
  %.579 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 7
  store float %.548, float* %.579
  %.581 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 8
  store float %.555, float* %.581
  %.583 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 9
  store float %.562, float* %.583
  %.587 = load i32, i32* %.333
  %.588 = load i32, i32* %.306
  %.589 = add i32 %.587, %.588
  %.590 = load i32, i32* %.297
  %.591 = add i32 %.589, %.590
  %.592 = load i32, i32* %.447
  %.593 = load i32, i32* %.309
  %.594 = add i32 %.592, %.593
  %.595 = load i32, i32* %.312
  %.596 = add i32 %.594, %.595
  %.597 = load i32, i32* %.300
  %.598 = load i32, i32* %.360
  %.599 = add i32 %.597, %.598
  %.600 = load i32, i32* %.387
  %.601 = add i32 %.599, %.600
  %.602 = load i32, i32* %.411
  %.603 = load i32, i32* %.366
  %.604 = add i32 %.602, %.603
  %.605 = load i32, i32* %.429
  %.606 = add i32 %.604, %.605
  %.607 = load i32, i32* %.423
  %.608 = load i32, i32* %.369
  %.609 = add i32 %.607, %.608
  %.610 = load i32, i32* %.480
  %.611 = add i32 %.609, %.610
  %.612 = load i32, i32* %.474
  %.613 = load i32, i32* %.432
  %.614 = add i32 %.612, %.613
  %.615 = load i32, i32* %.393
  %.616 = add i32 %.614, %.615
  %.617 = load i32, i32* %.408
  %.618 = load i32, i32* %.339
  %.619 = add i32 %.617, %.618
  %.620 = load i32, i32* %.453
  %.621 = add i32 %.619, %.620
  %.622 = load i32, i32* %.450
  %.623 = load i32, i32* %.324
  %.624 = add i32 %.622, %.623
  %.625 = load i32, i32* %.294
  %.626 = add i32 %.624, %.625
  call void @llvm.memcpy.p0.p0.i32([8 x i32]* %.585, [8 x i32]* @__constant..627, i32 32, i1 false)
  %.630 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 0
  store i32 %.591, i32* %.630
  %.632 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 1
  store i32 %.596, i32* %.632
  %.634 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 2
  store i32 %.601, i32* %.634
  %.636 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 3
  store i32 %.606, i32* %.636
  %.638 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 4
  store i32 %.611, i32* %.638
  %.640 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 5
  store i32 %.616, i32* %.640
  %.642 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 6
  store i32 %.621, i32* %.642
  %.644 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 7
  store i32 %.626, i32* %.644
  %.646 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 0
  call void @putfarray(i32 10, float* %.646)
  %.648 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 0
  call void @putarray(i32 8, i32* %.648)
  store i32 0, i32* %.651
  br label %.653wc51 
.487:
  %.681 = load i32, i32* %.306
  %.682 = load i32, i32* %.297
  %.683 = load i32, i32* %.300
  %.684 = load float, float* %.303
  %.685 = load i32, i32* %.306
  %.686 = load i32, i32* %.309
  %.687 = load i32, i32* %.312
  %.688 = load float, float* %.315
  %.689 = load float, float* %.318
  %.690 = load float, float* %.321
  %.691 = load i32, i32* %.324
  %.692 = load float, float* %.327
  %.693 = load float, float* %.330
  %.694 = load i32, i32* %.333
  %.695 = load float, float* %.336
  %.696 = load i32, i32* %.339
  %.697 = load float, float* %.342
  %.698 = load float, float* %.345
  %.699 = load float, float* %.348
  %.700 = load float, float* %.351
  %.701 = load float, float* %.354
  %.702 = load float, float* %.357
  %.703 = load i32, i32* %.360
  %.704 = load float, float* %.363
  %.705 = load i32, i32* %.366
  %.706 = load i32, i32* %.369
  %.707 = load float, float* %.372
  %.708 = load float, float* %.375
  %.709 = load float, float* %.378
  %.710 = load float, float* %.381
  %.711 = load float, float* %.384
  %.712 = load i32, i32* %.387
  %.713 = load float, float* %.390
  %.714 = load i32, i32* %.393
  %.715 = load float, float* %.396
  %.716 = load float, float* %.399
  %.717 = load float, float* %.402
  %.718 = load float, float* %.405
  %.719 = load i32, i32* %.408
  %.720 = load i32, i32* %.411
  %.721 = load float, float* %.414
  %.722 = load float, float* %.417
  %.723 = load float, float* %.420
  %.724 = load i32, i32* %.423
  %.725 = load float, float* %.426
  %.726 = load i32, i32* %.429
  %.727 = load i32, i32* %.432
  %.728 = load float, float* %.435
  %.729 = load float, float* %.438
  %.730 = load float, float* %.441
  %.731 = load float, float* %.444
  %.732 = load i32, i32* %.447
  %.733 = load i32, i32* %.450
  %.734 = load i32, i32* %.453
  %.735 = load float, float* %.456
  %.736 = load float, float* %.459
  %.737 = load float, float* %.462
  %.738 = load float, float* %.465
  %.739 = load float, float* %.468
  %.740 = load float, float* %.471
  %.741 = load i32, i32* %.474
  %.742 = load float, float* %.477
  %.743 = load i32, i32* %.480
  %.744 = load float, float* %.483
  %.745at57 = call float @params_f40_i24(i32 %.681, i32 %.682, i32 %.683, float %.684, i32 %.685, i32 %.686, i32 %.687, float %.688, float %.689, float %.690, i32 %.691, float %.692, float %.693, i32 %.694, float %.695, i32 %.696, float %.697, float %.698, float %.699, float %.700, float %.701, float %.702, i32 %.703, float %.704, i32 %.705, i32 %.706, float %.707, float %.708, float %.709, float %.710, float %.711, i32 %.712, float %.713, i32 %.714, float %.715, float %.716, float %.717, float %.718, i32 %.719, i32 %.720, float %.721, float %.722, float %.723, i32 %.724, float %.725, i32 %.726, i32 %.727, float %.728, float %.729, float %.730, float %.731, i32 %.732, i32 %.733, i32 %.734, float %.735, float %.736, float %.737, float %.738, float %.739, float %.740, i32 %.741, float %.742, i32 %.743, float %.744)
  ret float %.745at57 
.653wc51:
  %.657 = load i32, i32* %.651
  %.658 = icmp slt i32 %.657, 8
  br i1 %.658, label %.654wloop.51.54, label %.655wn54
.654wloop.51.54:
  %.660 = load i32, i32* %.651
  %.661 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 %.660
  %.662 = load i32, i32* %.661
  %.663 = load i32, i32* %.651
  %.664 = getelementptr inbounds [10 x float], [10 x float]* %.491, i32 0, i32 %.663
  %.665 = load float, float* %.664
  %.666 = sitofp i32 %.662 to float
  %.667 = fsub float %.666, %.665
  %.668 = load i32, i32* %.651
  %.669 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 %.668
  %.670 = fptosi float %.667 to i32
  store i32 %.670, i32* %.669
  %.672 = load i32, i32* %.651
  %.673 = add i32 %.672, 1
  store i32 %.673, i32* %.651
  br label %.653wc51 
.655wn54:
  %.676 = load i32, i32* @.g.k
  %.677 = getelementptr inbounds [8 x i32], [8 x i32]* %.585, i32 0, i32 %.676
  %.678 = load i32, i32* %.677
  %.679 = sitofp i32 %.678 to float
  ret float %.679 
}
define float @params_fa40(float* %.750, float* %.753, float* %.756, float* %.759, float* %.762, float* %.765, float* %.768, float* %.771, float* %.774, float* %.777, float* %.780, float* %.783, float* %.786, float* %.789, float* %.792, float* %.795, float* %.798, float* %.801, float* %.804, float* %.807, float* %.810, float* %.813, float* %.816, float* %.819, float* %.822, float* %.825, float* %.828, float* %.831, float* %.834, float* %.837, float* %.840, float* %.843, float* %.846, float* %.849, float* %.852, float* %.855, float* %.858, float* %.861, float* %.864, float* %.867){
.748:
  %.869 = alloca [10 x float]
  %.866 = alloca float*
  %.863 = alloca float*
  %.860 = alloca float*
  %.857 = alloca float*
  %.854 = alloca float*
  %.851 = alloca float*
  %.848 = alloca float*
  %.845 = alloca float*
  %.842 = alloca float*
  %.839 = alloca float*
  %.836 = alloca float*
  %.833 = alloca float*
  %.830 = alloca float*
  %.827 = alloca float*
  %.824 = alloca float*
  %.821 = alloca float*
  %.818 = alloca float*
  %.815 = alloca float*
  %.812 = alloca float*
  %.809 = alloca float*
  %.806 = alloca float*
  %.803 = alloca float*
  %.800 = alloca float*
  %.797 = alloca float*
  %.794 = alloca float*
  %.791 = alloca float*
  %.788 = alloca float*
  %.785 = alloca float*
  %.782 = alloca float*
  %.779 = alloca float*
  %.776 = alloca float*
  %.773 = alloca float*
  %.770 = alloca float*
  %.767 = alloca float*
  %.764 = alloca float*
  %.761 = alloca float*
  %.758 = alloca float*
  %.755 = alloca float*
  %.752 = alloca float*
  %.749 = alloca float*
  store float* %.750, float** %.749
  store float* %.753, float** %.752
  store float* %.756, float** %.755
  store float* %.759, float** %.758
  store float* %.762, float** %.761
  store float* %.765, float** %.764
  store float* %.768, float** %.767
  store float* %.771, float** %.770
  store float* %.774, float** %.773
  store float* %.777, float** %.776
  store float* %.780, float** %.779
  store float* %.783, float** %.782
  store float* %.786, float** %.785
  store float* %.789, float** %.788
  store float* %.792, float** %.791
  store float* %.795, float** %.794
  store float* %.798, float** %.797
  store float* %.801, float** %.800
  store float* %.804, float** %.803
  store float* %.807, float** %.806
  store float* %.810, float** %.809
  store float* %.813, float** %.812
  store float* %.816, float** %.815
  store float* %.819, float** %.818
  store float* %.822, float** %.821
  store float* %.825, float** %.824
  store float* %.828, float** %.827
  store float* %.831, float** %.830
  store float* %.834, float** %.833
  store float* %.837, float** %.836
  store float* %.840, float** %.839
  store float* %.843, float** %.842
  store float* %.846, float** %.845
  store float* %.849, float** %.848
  store float* %.852, float** %.851
  store float* %.855, float** %.854
  store float* %.858, float** %.857
  store float* %.861, float** %.860
  store float* %.864, float** %.863
  store float* %.867, float** %.866
  %.871 = load i32, i32* @.g.k
  %.872 = load float*, float** %.749
  %.873 = getelementptr inbounds float, float* %.872, i32 %.871
  %.874 = load float, float* %.873
  %.875 = load i32, i32* @.g.k
  %.876 = load float*, float** %.752
  %.877 = getelementptr inbounds float, float* %.876, i32 %.875
  %.878 = load float, float* %.877
  %.879 = fadd float %.874, %.878
  %.880 = load i32, i32* @.g.k
  %.881 = load float*, float** %.755
  %.882 = getelementptr inbounds float, float* %.881, i32 %.880
  %.883 = load float, float* %.882
  %.884 = fadd float %.879, %.883
  %.885 = load i32, i32* @.g.k
  %.886 = load float*, float** %.758
  %.887 = getelementptr inbounds float, float* %.886, i32 %.885
  %.888 = load float, float* %.887
  %.889 = fadd float %.884, %.888
  %.890 = load i32, i32* @.g.k
  %.891 = load float*, float** %.761
  %.892 = getelementptr inbounds float, float* %.891, i32 %.890
  %.893 = load float, float* %.892
  %.894 = load i32, i32* @.g.k
  %.895 = load float*, float** %.764
  %.896 = getelementptr inbounds float, float* %.895, i32 %.894
  %.897 = load float, float* %.896
  %.898 = fadd float %.893, %.897
  %.899 = load i32, i32* @.g.k
  %.900 = load float*, float** %.767
  %.901 = getelementptr inbounds float, float* %.900, i32 %.899
  %.902 = load float, float* %.901
  %.903 = fadd float %.898, %.902
  %.904 = load i32, i32* @.g.k
  %.905 = load float*, float** %.770
  %.906 = getelementptr inbounds float, float* %.905, i32 %.904
  %.907 = load float, float* %.906
  %.908 = fadd float %.903, %.907
  %.909 = load i32, i32* @.g.k
  %.910 = load float*, float** %.773
  %.911 = getelementptr inbounds float, float* %.910, i32 %.909
  %.912 = load float, float* %.911
  %.913 = load i32, i32* @.g.k
  %.914 = load float*, float** %.776
  %.915 = getelementptr inbounds float, float* %.914, i32 %.913
  %.916 = load float, float* %.915
  %.917 = fadd float %.912, %.916
  %.918 = load i32, i32* @.g.k
  %.919 = load float*, float** %.779
  %.920 = getelementptr inbounds float, float* %.919, i32 %.918
  %.921 = load float, float* %.920
  %.922 = fadd float %.917, %.921
  %.923 = load i32, i32* @.g.k
  %.924 = load float*, float** %.782
  %.925 = getelementptr inbounds float, float* %.924, i32 %.923
  %.926 = load float, float* %.925
  %.927 = fadd float %.922, %.926
  %.928 = load i32, i32* @.g.k
  %.929 = load float*, float** %.785
  %.930 = getelementptr inbounds float, float* %.929, i32 %.928
  %.931 = load float, float* %.930
  %.932 = load i32, i32* @.g.k
  %.933 = load float*, float** %.788
  %.934 = getelementptr inbounds float, float* %.933, i32 %.932
  %.935 = load float, float* %.934
  %.936 = fadd float %.931, %.935
  %.937 = load i32, i32* @.g.k
  %.938 = load float*, float** %.791
  %.939 = getelementptr inbounds float, float* %.938, i32 %.937
  %.940 = load float, float* %.939
  %.941 = fadd float %.936, %.940
  %.942 = load i32, i32* @.g.k
  %.943 = load float*, float** %.794
  %.944 = getelementptr inbounds float, float* %.943, i32 %.942
  %.945 = load float, float* %.944
  %.946 = fadd float %.941, %.945
  %.947 = load i32, i32* @.g.k
  %.948 = load float*, float** %.797
  %.949 = getelementptr inbounds float, float* %.948, i32 %.947
  %.950 = load float, float* %.949
  %.951 = load i32, i32* @.g.k
  %.952 = load float*, float** %.800
  %.953 = getelementptr inbounds float, float* %.952, i32 %.951
  %.954 = load float, float* %.953
  %.955 = fadd float %.950, %.954
  %.956 = load i32, i32* @.g.k
  %.957 = load float*, float** %.803
  %.958 = getelementptr inbounds float, float* %.957, i32 %.956
  %.959 = load float, float* %.958
  %.960 = fadd float %.955, %.959
  %.961 = load i32, i32* @.g.k
  %.962 = load float*, float** %.806
  %.963 = getelementptr inbounds float, float* %.962, i32 %.961
  %.964 = load float, float* %.963
  %.965 = fadd float %.960, %.964
  %.966 = load i32, i32* @.g.k
  %.967 = load float*, float** %.809
  %.968 = getelementptr inbounds float, float* %.967, i32 %.966
  %.969 = load float, float* %.968
  %.970 = load i32, i32* @.g.k
  %.971 = load float*, float** %.812
  %.972 = getelementptr inbounds float, float* %.971, i32 %.970
  %.973 = load float, float* %.972
  %.974 = fadd float %.969, %.973
  %.975 = load i32, i32* @.g.k
  %.976 = load float*, float** %.815
  %.977 = getelementptr inbounds float, float* %.976, i32 %.975
  %.978 = load float, float* %.977
  %.979 = fadd float %.974, %.978
  %.980 = load i32, i32* @.g.k
  %.981 = load float*, float** %.818
  %.982 = getelementptr inbounds float, float* %.981, i32 %.980
  %.983 = load float, float* %.982
  %.984 = fadd float %.979, %.983
  %.985 = load i32, i32* @.g.k
  %.986 = load float*, float** %.821
  %.987 = getelementptr inbounds float, float* %.986, i32 %.985
  %.988 = load float, float* %.987
  %.989 = load i32, i32* @.g.k
  %.990 = load float*, float** %.824
  %.991 = getelementptr inbounds float, float* %.990, i32 %.989
  %.992 = load float, float* %.991
  %.993 = fadd float %.988, %.992
  %.994 = load i32, i32* @.g.k
  %.995 = load float*, float** %.827
  %.996 = getelementptr inbounds float, float* %.995, i32 %.994
  %.997 = load float, float* %.996
  %.998 = fadd float %.993, %.997
  %.999 = load i32, i32* @.g.k
  %.1000 = load float*, float** %.830
  %.1001 = getelementptr inbounds float, float* %.1000, i32 %.999
  %.1002 = load float, float* %.1001
  %.1003 = fadd float %.998, %.1002
  %.1004 = load i32, i32* @.g.k
  %.1005 = load float*, float** %.833
  %.1006 = getelementptr inbounds float, float* %.1005, i32 %.1004
  %.1007 = load float, float* %.1006
  %.1008 = load i32, i32* @.g.k
  %.1009 = load float*, float** %.836
  %.1010 = getelementptr inbounds float, float* %.1009, i32 %.1008
  %.1011 = load float, float* %.1010
  %.1012 = fadd float %.1007, %.1011
  %.1013 = load i32, i32* @.g.k
  %.1014 = load float*, float** %.839
  %.1015 = getelementptr inbounds float, float* %.1014, i32 %.1013
  %.1016 = load float, float* %.1015
  %.1017 = fadd float %.1012, %.1016
  %.1018 = load i32, i32* @.g.k
  %.1019 = load float*, float** %.842
  %.1020 = getelementptr inbounds float, float* %.1019, i32 %.1018
  %.1021 = load float, float* %.1020
  %.1022 = fadd float %.1017, %.1021
  %.1023 = load i32, i32* @.g.k
  %.1024 = load float*, float** %.845
  %.1025 = getelementptr inbounds float, float* %.1024, i32 %.1023
  %.1026 = load float, float* %.1025
  %.1027 = load i32, i32* @.g.k
  %.1028 = load float*, float** %.848
  %.1029 = getelementptr inbounds float, float* %.1028, i32 %.1027
  %.1030 = load float, float* %.1029
  %.1031 = fadd float %.1026, %.1030
  %.1032 = load i32, i32* @.g.k
  %.1033 = load float*, float** %.851
  %.1034 = getelementptr inbounds float, float* %.1033, i32 %.1032
  %.1035 = load float, float* %.1034
  %.1036 = fadd float %.1031, %.1035
  %.1037 = load i32, i32* @.g.k
  %.1038 = load float*, float** %.854
  %.1039 = getelementptr inbounds float, float* %.1038, i32 %.1037
  %.1040 = load float, float* %.1039
  %.1041 = fadd float %.1036, %.1040
  %.1042 = load i32, i32* @.g.k
  %.1043 = load float*, float** %.857
  %.1044 = getelementptr inbounds float, float* %.1043, i32 %.1042
  %.1045 = load float, float* %.1044
  %.1046 = load i32, i32* @.g.k
  %.1047 = load float*, float** %.860
  %.1048 = getelementptr inbounds float, float* %.1047, i32 %.1046
  %.1049 = load float, float* %.1048
  %.1050 = fadd float %.1045, %.1049
  %.1051 = load i32, i32* @.g.k
  %.1052 = load float*, float** %.863
  %.1053 = getelementptr inbounds float, float* %.1052, i32 %.1051
  %.1054 = load float, float* %.1053
  %.1055 = fadd float %.1050, %.1054
  %.1056 = load i32, i32* @.g.k
  %.1057 = load float*, float** %.866
  %.1058 = getelementptr inbounds float, float* %.1057, i32 %.1056
  %.1059 = load float, float* %.1058
  %.1060 = fadd float %.1055, %.1059
  call void @llvm.memcpy.p0.p0.i32([10 x float]* %.869, [10 x float]* @__constant..1061, i32 40, i1 false)
  %.1063 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 0
  store float %.889, float* %.1063
  %.1065 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 1
  store float %.908, float* %.1065
  %.1067 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 2
  store float %.927, float* %.1067
  %.1069 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 3
  store float %.946, float* %.1069
  %.1071 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 4
  store float %.965, float* %.1071
  %.1073 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 5
  store float %.984, float* %.1073
  %.1075 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 6
  store float %.1003, float* %.1075
  %.1077 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 7
  store float %.1022, float* %.1077
  %.1079 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 8
  store float %.1041, float* %.1079
  %.1081 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 9
  store float %.1060, float* %.1081
  %.1085 = load i32, i32* @.g.k
  %.1086 = load float*, float** %.866
  %.1087 = getelementptr inbounds float, float* %.1086, i32 %.1085
  %.1088 = load float, float* %.1087
  %.1089 = sitofp i32 0 to float
  %.1090 = fcmp une float %.1088, %.1089
  %.1091 = zext i1 %.1090 to i32  %.1092 = icmp ne i32 %.1091, 0
  %.1093 = sitofp i1 %.1092 to float
  %.1094 = fcmp une float %.1093, 0x0
  %.1095 = sitofp i1 %.1094 to float
  %.1096 = fcmp une float %.1095, 0x0
  br i1 %.1096, label %.1083, label %.1084
.1083:
  %.1098 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 0
  call void @putfarray(i32 10, float* %.1098)
  %.1100 = load i32, i32* @.g.k
  %.1101 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 %.1100
  %.1102 = load float, float* %.1101
  ret float %.1102 
.1084:
  %.1104 = load float*, float** %.752
  %.1105 = load float*, float** %.755
  %.1106 = load float*, float** %.758
  %.1107 = load float*, float** %.761
  %.1108 = load float*, float** %.764
  %.1109 = load float*, float** %.767
  %.1110 = load float*, float** %.770
  %.1111 = load float*, float** %.773
  %.1112 = load float*, float** %.776
  %.1113 = load float*, float** %.779
  %.1114 = load float*, float** %.782
  %.1115 = load float*, float** %.785
  %.1116 = load float*, float** %.788
  %.1117 = load float*, float** %.791
  %.1118 = load float*, float** %.794
  %.1119 = load float*, float** %.797
  %.1120 = load float*, float** %.800
  %.1121 = load float*, float** %.803
  %.1122 = load float*, float** %.806
  %.1123 = load float*, float** %.809
  %.1124 = load float*, float** %.812
  %.1125 = load float*, float** %.815
  %.1126 = load float*, float** %.818
  %.1127 = load float*, float** %.821
  %.1128 = load float*, float** %.824
  %.1129 = load float*, float** %.827
  %.1130 = load float*, float** %.830
  %.1131 = load float*, float** %.833
  %.1132 = load float*, float** %.836
  %.1133 = load float*, float** %.839
  %.1134 = load float*, float** %.842
  %.1135 = load float*, float** %.845
  %.1136 = load float*, float** %.848
  %.1137 = load float*, float** %.851
  %.1138 = load float*, float** %.854
  %.1139 = load float*, float** %.857
  %.1140 = load float*, float** %.860
  %.1141 = load float*, float** %.863
  %.1142 = load float*, float** %.866
  %.1143 = getelementptr inbounds [10 x float], [10 x float]* %.869, i32 0, i32 0
  %.1144at86 = call float @params_fa40(float* %.1104, float* %.1105, float* %.1106, float* %.1107, float* %.1108, float* %.1109, float* %.1110, float* %.1111, float* %.1112, float* %.1113, float* %.1114, float* %.1115, float* %.1116, float* %.1117, float* %.1118, float* %.1119, float* %.1120, float* %.1121, float* %.1122, float* %.1123, float* %.1124, float* %.1125, float* %.1126, float* %.1127, float* %.1128, float* %.1129, float* %.1130, float* %.1131, float* %.1132, float* %.1133, float* %.1134, float* %.1135, float* %.1136, float* %.1137, float* %.1138, float* %.1139, float* %.1140, float* %.1141, float* %.1142, float* %.1143)
  ret float %.1144at86 
}
define i32 @params_mix(float %.1149, i32* %.1152, i32 %.1155, float* %.1158, float %.1161, i32 %.1164, float %.1167, float %.1170, float* %.1173, i32* %.1176, i32 %.1179, i32 %.1182, float* %.1185, i32* %.1188, i32* %.1191, i32 %.1194, float* %.1197, float* %.1200, float %.1203, float %.1206, float %.1209, float* %.1212, i32 %.1215, float %.1218, float %.1221, float %.1224, i32* %.1227, float* %.1230, i32* %.1233, i32* %.1236, float* %.1239, float %.1242, float %.1245, i32* %.1248, i32 %.1251, float* %.1254, float* %.1257, float %.1260, float %.1263, i32* %.1266, i32* %.1269, i32 %.1272, i32 %.1275, float %.1278, float %.1281, i32* %.1284, i32 %.1287, float* %.1290, i32 %.1293, i32* %.1296, i32* %.1299, float %.1302, float %.1305, float* %.1308, i32 %.1311, i32* %.1314, float* %.1317, float %.1320, i32 %.1323, float %.1326, float* %.1329, float* %.1332, float %.1335, i32 %.1338){
.1147:
  %.1590 = alloca i32
  %.1470 = alloca [10 x i32]
  %.1340 = alloca [10 x float]
  %.1337 = alloca i32
  %.1334 = alloca float
  %.1331 = alloca float*
  %.1328 = alloca float*
  %.1325 = alloca float
  %.1322 = alloca i32
  %.1319 = alloca float
  %.1316 = alloca float*
  %.1313 = alloca i32*
  %.1310 = alloca i32
  %.1307 = alloca float*
  %.1304 = alloca float
  %.1301 = alloca float
  %.1298 = alloca i32*
  %.1295 = alloca i32*
  %.1292 = alloca i32
  %.1289 = alloca float*
  %.1286 = alloca i32
  %.1283 = alloca i32*
  %.1280 = alloca float
  %.1277 = alloca float
  %.1274 = alloca i32
  %.1271 = alloca i32
  %.1268 = alloca i32*
  %.1265 = alloca i32*
  %.1262 = alloca float
  %.1259 = alloca float
  %.1256 = alloca float*
  %.1253 = alloca float*
  %.1250 = alloca i32
  %.1247 = alloca i32*
  %.1244 = alloca float
  %.1241 = alloca float
  %.1238 = alloca float*
  %.1235 = alloca i32*
  %.1232 = alloca i32*
  %.1229 = alloca float*
  %.1226 = alloca i32*
  %.1223 = alloca float
  %.1220 = alloca float
  %.1217 = alloca float
  %.1214 = alloca i32
  %.1211 = alloca float*
  %.1208 = alloca float
  %.1205 = alloca float
  %.1202 = alloca float
  %.1199 = alloca float*
  %.1196 = alloca float*
  %.1193 = alloca i32
  %.1190 = alloca i32*
  %.1187 = alloca i32*
  %.1184 = alloca float*
  %.1181 = alloca i32
  %.1178 = alloca i32
  %.1175 = alloca i32*
  %.1172 = alloca float*
  %.1169 = alloca float
  %.1166 = alloca float
  %.1163 = alloca i32
  %.1160 = alloca float
  %.1157 = alloca float*
  %.1154 = alloca i32
  %.1151 = alloca i32*
  %.1148 = alloca float
  store float %.1149, float* %.1148
  store i32* %.1152, i32** %.1151
  store i32 %.1155, i32* %.1154
  store float* %.1158, float** %.1157
  store float %.1161, float* %.1160
  store i32 %.1164, i32* %.1163
  store float %.1167, float* %.1166
  store float %.1170, float* %.1169
  store float* %.1173, float** %.1172
  store i32* %.1176, i32** %.1175
  store i32 %.1179, i32* %.1178
  store i32 %.1182, i32* %.1181
  store float* %.1185, float** %.1184
  store i32* %.1188, i32** %.1187
  store i32* %.1191, i32** %.1190
  store i32 %.1194, i32* %.1193
  store float* %.1197, float** %.1196
  store float* %.1200, float** %.1199
  store float %.1203, float* %.1202
  store float %.1206, float* %.1205
  store float %.1209, float* %.1208
  store float* %.1212, float** %.1211
  store i32 %.1215, i32* %.1214
  store float %.1218, float* %.1217
  store float %.1221, float* %.1220
  store float %.1224, float* %.1223
  store i32* %.1227, i32** %.1226
  store float* %.1230, float** %.1229
  store i32* %.1233, i32** %.1232
  store i32* %.1236, i32** %.1235
  store float* %.1239, float** %.1238
  store float %.1242, float* %.1241
  store float %.1245, float* %.1244
  store i32* %.1248, i32** %.1247
  store i32 %.1251, i32* %.1250
  store float* %.1254, float** %.1253
  store float* %.1257, float** %.1256
  store float %.1260, float* %.1259
  store float %.1263, float* %.1262
  store i32* %.1266, i32** %.1265
  store i32* %.1269, i32** %.1268
  store i32 %.1272, i32* %.1271
  store i32 %.1275, i32* %.1274
  store float %.1278, float* %.1277
  store float %.1281, float* %.1280
  store i32* %.1284, i32** %.1283
  store i32 %.1287, i32* %.1286
  store float* %.1290, float** %.1289
  store i32 %.1293, i32* %.1292
  store i32* %.1296, i32** %.1295
  store i32* %.1299, i32** %.1298
  store float %.1302, float* %.1301
  store float %.1305, float* %.1304
  store float* %.1308, float** %.1307
  store i32 %.1311, i32* %.1310
  store i32* %.1314, i32** %.1313
  store float* %.1317, float** %.1316
  store float %.1320, float* %.1319
  store i32 %.1323, i32* %.1322
  store float %.1326, float* %.1325
  store float* %.1329, float** %.1328
  store float* %.1332, float** %.1331
  store float %.1335, float* %.1334
  store i32 %.1338, i32* %.1337
  %.1342 = load float, float* %.1148
  %.1343 = load i32, i32* @.g.k
  %.1344 = load float*, float** %.1157
  %.1345 = getelementptr inbounds float, float* %.1344, i32 %.1343
  %.1346 = load float, float* %.1345
  %.1347 = fadd float %.1342, %.1346
  %.1348 = load float, float* %.1160
  %.1349 = fadd float %.1347, %.1348
  %.1350 = load float, float* %.1166
  %.1351 = fadd float %.1349, %.1350
  %.1352 = load float, float* %.1169
  %.1353 = load i32, i32* @.g.k
  %.1354 = load float*, float** %.1172
  %.1355 = getelementptr inbounds float, float* %.1354, i32 %.1353
  %.1356 = load float, float* %.1355
  %.1357 = fadd float %.1352, %.1356
  %.1358 = load i32, i32* @.g.k
  %.1359 = load float*, float** %.1184
  %.1360 = getelementptr inbounds float, float* %.1359, i32 %.1358
  %.1361 = load float, float* %.1360
  %.1362 = fadd float %.1357, %.1361
  %.1363 = load i32, i32* @.g.k
  %.1364 = load float*, float** %.1196
  %.1365 = getelementptr inbounds float, float* %.1364, i32 %.1363
  %.1366 = load float, float* %.1365
  %.1367 = fadd float %.1362, %.1366
  %.1368 = load i32, i32* @.g.k
  %.1369 = load float*, float** %.1199
  %.1370 = getelementptr inbounds float, float* %.1369, i32 %.1368
  %.1371 = load float, float* %.1370
  %.1372 = load float, float* %.1202
  %.1373 = fadd float %.1371, %.1372
  %.1374 = load float, float* %.1205
  %.1375 = fadd float %.1373, %.1374
  %.1376 = load float, float* %.1208
  %.1377 = fadd float %.1375, %.1376
  %.1378 = load i32, i32* @.g.k
  %.1379 = load float*, float** %.1211
  %.1380 = getelementptr inbounds float, float* %.1379, i32 %.1378
  %.1381 = load float, float* %.1380
  %.1382 = load float, float* %.1217
  %.1383 = fadd float %.1381, %.1382
  %.1384 = load float, float* %.1220
  %.1385 = fadd float %.1383, %.1384
  %.1386 = load float, float* %.1223
  %.1387 = fadd float %.1385, %.1386
  %.1388 = load i32, i32* @.g.k
  %.1389 = load float*, float** %.1229
  %.1390 = getelementptr inbounds float, float* %.1389, i32 %.1388
  %.1391 = load float, float* %.1390
  %.1392 = load i32, i32* @.g.k
  %.1393 = load float*, float** %.1238
  %.1394 = getelementptr inbounds float, float* %.1393, i32 %.1392
  %.1395 = load float, float* %.1394
  %.1396 = fadd float %.1391, %.1395
  %.1397 = load float, float* %.1241
  %.1398 = fadd float %.1396, %.1397
  %.1399 = load float, float* %.1244
  %.1400 = fadd float %.1398, %.1399
  %.1401 = load i32, i32* @.g.k
  %.1402 = load float*, float** %.1253
  %.1403 = getelementptr inbounds float, float* %.1402, i32 %.1401
  %.1404 = load float, float* %.1403
  %.1405 = load i32, i32* @.g.k
  %.1406 = load float*, float** %.1256
  %.1407 = getelementptr inbounds float, float* %.1406, i32 %.1405
  %.1408 = load float, float* %.1407
  %.1409 = fadd float %.1404, %.1408
  %.1410 = load float, float* %.1259
  %.1411 = fadd float %.1409, %.1410
  %.1412 = load float, float* %.1262
  %.1413 = fadd float %.1411, %.1412
  %.1414 = load float, float* %.1277
  %.1415 = load float, float* %.1280
  %.1416 = fadd float %.1414, %.1415
  %.1417 = load i32, i32* @.g.k
  %.1418 = load float*, float** %.1289
  %.1419 = getelementptr inbounds float, float* %.1418, i32 %.1417
  %.1420 = load float, float* %.1419
  %.1421 = fadd float %.1416, %.1420
  %.1422 = load float, float* %.1301
  %.1423 = fadd float %.1421, %.1422
  %.1424 = load float, float* %.1304
  %.1425 = load i32, i32* @.g.k
  %.1426 = load float*, float** %.1307
  %.1427 = getelementptr inbounds float, float* %.1426, i32 %.1425
  %.1428 = load float, float* %.1427
  %.1429 = fadd float %.1424, %.1428
  %.1430 = load i32, i32* @.g.k
  %.1431 = load float*, float** %.1316
  %.1432 = getelementptr inbounds float, float* %.1431, i32 %.1430
  %.1433 = load float, float* %.1432
  %.1434 = fadd float %.1429, %.1433
  %.1435 = load float, float* %.1319
  %.1436 = fadd float %.1434, %.1435
  %.1437 = load float, float* %.1325
  %.1438 = load i32, i32* @.g.k
  %.1439 = load float*, float** %.1328
  %.1440 = getelementptr inbounds float, float* %.1439, i32 %.1438
  %.1441 = load float, float* %.1440
  %.1442 = fadd float %.1437, %.1441
  %.1443 = load i32, i32* @.g.k
  %.1444 = load float*, float** %.1331
  %.1445 = getelementptr inbounds float, float* %.1444, i32 %.1443
  %.1446 = load float, float* %.1445
  %.1447 = fadd float %.1442, %.1446
  %.1448 = load float, float* %.1334
  %.1449 = fadd float %.1447, %.1448
  call void @llvm.memcpy.p0.p0.i32([10 x float]* %.1340, [10 x float]* @__constant..1450, i32 40, i1 false)
  %.1452 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 0
  store float %.1351, float* %.1452
  %.1454 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 1
  store float %.1367, float* %.1454
  %.1456 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 2
  store float %.1377, float* %.1456
  %.1458 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 3
  store float %.1387, float* %.1458
  %.1460 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 4
  store float %.1400, float* %.1460
  %.1462 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 5
  store float %.1413, float* %.1462
  %.1464 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 6
  store float %.1423, float* %.1464
  %.1466 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 7
  store float %.1436, float* %.1466
  %.1468 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 8
  store float %.1449, float* %.1468
  %.1472 = load i32, i32* @.g.k
  %.1473 = load i32*, i32** %.1151
  %.1474 = getelementptr inbounds i32, i32* %.1473, i32 %.1472
  %.1475 = load i32, i32* %.1474
  %.1476 = load i32, i32* %.1154
  %.1477 = add i32 %.1475, %.1476
  %.1478 = load i32, i32* %.1163
  %.1479 = add i32 %.1477, %.1478
  %.1480 = load i32, i32* @.g.k
  %.1481 = load i32*, i32** %.1175
  %.1482 = getelementptr inbounds i32, i32* %.1481, i32 %.1480
  %.1483 = load i32, i32* %.1482
  %.1484 = load i32, i32* %.1178
  %.1485 = add i32 %.1483, %.1484
  %.1486 = load i32, i32* %.1181
  %.1487 = add i32 %.1485, %.1486
  %.1488 = load i32, i32* @.g.k
  %.1489 = load i32*, i32** %.1187
  %.1490 = getelementptr inbounds i32, i32* %.1489, i32 %.1488
  %.1491 = load i32, i32* %.1490
  %.1492 = load i32, i32* @.g.k
  %.1493 = load i32*, i32** %.1190
  %.1494 = getelementptr inbounds i32, i32* %.1493, i32 %.1492
  %.1495 = load i32, i32* %.1494
  %.1496 = add i32 %.1491, %.1495
  %.1497 = load i32, i32* %.1193
  %.1498 = add i32 %.1496, %.1497
  %.1499 = load i32, i32* %.1214
  %.1500 = load i32, i32* @.g.k
  %.1501 = load i32*, i32** %.1226
  %.1502 = getelementptr inbounds i32, i32* %.1501, i32 %.1500
  %.1503 = load i32, i32* %.1502
  %.1504 = add i32 %.1499, %.1503
  %.1505 = load i32, i32* @.g.k
  %.1506 = load i32*, i32** %.1232
  %.1507 = getelementptr inbounds i32, i32* %.1506, i32 %.1505
  %.1508 = load i32, i32* %.1507
  %.1509 = add i32 %.1504, %.1508
  %.1510 = load i32, i32* @.g.k
  %.1511 = load i32*, i32** %.1235
  %.1512 = getelementptr inbounds i32, i32* %.1511, i32 %.1510
  %.1513 = load i32, i32* %.1512
  %.1514 = load i32, i32* @.g.k
  %.1515 = load i32*, i32** %.1247
  %.1516 = getelementptr inbounds i32, i32* %.1515, i32 %.1514
  %.1517 = load i32, i32* %.1516
  %.1518 = add i32 %.1513, %.1517
  %.1519 = load i32, i32* %.1250
  %.1520 = add i32 %.1518, %.1519
  %.1521 = load i32, i32* @.g.k
  %.1522 = load i32*, i32** %.1265
  %.1523 = getelementptr inbounds i32, i32* %.1522, i32 %.1521
  %.1524 = load i32, i32* %.1523
  %.1525 = load i32, i32* @.g.k
  %.1526 = load i32*, i32** %.1268
  %.1527 = getelementptr inbounds i32, i32* %.1526, i32 %.1525
  %.1528 = load i32, i32* %.1527
  %.1529 = add i32 %.1524, %.1528
  %.1530 = load i32, i32* %.1271
  %.1531 = add i32 %.1529, %.1530
  %.1532 = load i32, i32* %.1274
  %.1533 = load i32, i32* @.g.k
  %.1534 = load i32*, i32** %.1283
  %.1535 = getelementptr inbounds i32, i32* %.1534, i32 %.1533
  %.1536 = load i32, i32* %.1535
  %.1537 = add i32 %.1532, %.1536
  %.1538 = load i32, i32* %.1286
  %.1539 = add i32 %.1537, %.1538
  %.1540 = load i32, i32* %.1292
  %.1541 = load i32, i32* @.g.k
  %.1542 = load i32*, i32** %.1295
  %.1543 = getelementptr inbounds i32, i32* %.1542, i32 %.1541
  %.1544 = load i32, i32* %.1543
  %.1545 = add i32 %.1540, %.1544
  %.1546 = load i32, i32* @.g.k
  %.1547 = load i32*, i32** %.1298
  %.1548 = getelementptr inbounds i32, i32* %.1547, i32 %.1546
  %.1549 = load i32, i32* %.1548
  %.1550 = add i32 %.1545, %.1549
  %.1551 = load i32, i32* %.1310
  %.1552 = load i32, i32* @.g.k
  %.1553 = load i32*, i32** %.1313
  %.1554 = getelementptr inbounds i32, i32* %.1553, i32 %.1552
  %.1555 = load i32, i32* %.1554
  %.1556 = add i32 %.1551, %.1555
  %.1557 = load i32, i32* %.1322
  %.1558 = add i32 %.1556, %.1557
  %.1559 = load i32, i32* %.1337
  %.1560 = add i32 %.1558, %.1559
  call void @llvm.memcpy.p0.p0.i32([10 x i32]* %.1470, [10 x i32]* @__constant..1561, i32 40, i1 false)
  %.1563 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 0
  store i32 %.1479, i32* %.1563
  %.1565 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 1
  store i32 %.1487, i32* %.1565
  %.1567 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 2
  store i32 %.1498, i32* %.1567
  %.1569 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 3
  store i32 %.1509, i32* %.1569
  %.1571 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 4
  store i32 %.1520, i32* %.1571
  %.1573 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 5
  store i32 %.1531, i32* %.1573
  %.1575 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 6
  store i32 %.1539, i32* %.1575
  %.1577 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 7
  store i32 %.1550, i32* %.1577
  %.1579 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 8
  store i32 %.1560, i32* %.1579
  %.1583 = load i32, i32* %.1337
  %.1584 = icmp ne i32 %.1583, 0
  br i1 %.1584, label %.1581, label %.1582
.1581:
  %.1586 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 0
  call void @putfarray(i32 10, float* %.1586)
  %.1588 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 0
  call void @putarray(i32 10, i32* %.1588)
  store i32 0, i32* %.1590
  br label %.1592wc118 
.1582:
  %.1624 = load float, float* %.1148
  %.1625 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 0
  %.1626 = load i32, i32* %.1154
  %.1627 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 0
  %.1628 = load float, float* %.1160
  %.1629 = load i32, i32* %.1163
  %.1630 = load float, float* %.1166
  %.1631 = load float, float* %.1169
  %.1632 = load float*, float** %.1172
  %.1633 = load i32*, i32** %.1175
  %.1634 = load i32, i32* %.1178
  %.1635 = load i32, i32* %.1181
  %.1636 = load float*, float** %.1184
  %.1637 = load i32*, i32** %.1187
  %.1638 = load i32*, i32** %.1190
  %.1639 = load i32, i32* %.1193
  %.1640 = load float*, float** %.1196
  %.1641 = load float*, float** %.1199
  %.1642 = load float, float* %.1202
  %.1643 = load float, float* %.1205
  %.1644 = load float, float* %.1208
  %.1645 = load float*, float** %.1211
  %.1646 = load i32, i32* %.1214
  %.1647 = load float, float* %.1217
  %.1648 = load float, float* %.1220
  %.1649 = load float, float* %.1223
  %.1650 = load i32*, i32** %.1226
  %.1651 = load float*, float** %.1229
  %.1652 = load i32*, i32** %.1232
  %.1653 = load i32*, i32** %.1235
  %.1654 = load float*, float** %.1238
  %.1655 = load float, float* %.1241
  %.1656 = load float, float* %.1244
  %.1657 = load i32*, i32** %.1247
  %.1658 = load i32, i32* %.1250
  %.1659 = load float*, float** %.1253
  %.1660 = load float*, float** %.1256
  %.1661 = load float, float* %.1259
  %.1662 = load float, float* %.1262
  %.1663 = load i32*, i32** %.1265
  %.1664 = load i32*, i32** %.1268
  %.1665 = load i32, i32* %.1271
  %.1666 = load i32, i32* %.1274
  %.1667 = load float, float* %.1277
  %.1668 = load float, float* %.1280
  %.1669 = load i32*, i32** %.1283
  %.1670 = load i32, i32* %.1286
  %.1671 = load float*, float** %.1289
  %.1672 = load i32, i32* %.1292
  %.1673 = load i32*, i32** %.1295
  %.1674 = load i32*, i32** %.1298
  %.1675 = load float, float* %.1301
  %.1676 = load float, float* %.1304
  %.1677 = load float*, float** %.1307
  %.1678 = load i32, i32* %.1310
  %.1679 = load i32*, i32** %.1313
  %.1680 = load float*, float** %.1316
  %.1681 = load float, float* %.1319
  %.1682 = load i32, i32* %.1322
  %.1683 = load float, float* %.1325
  %.1684 = load float*, float** %.1328
  %.1685 = load float*, float** %.1331
  %.1686 = load i32, i32* %.1337
  %.1687 = load float, float* %.1334
  %.1688 = sitofp i32 %.1686 to float
  %.1689 = fptosi float %.1687 to i32
  %.1690at124 = call i32 @params_mix(float %.1624, i32* %.1625, i32 %.1626, float* %.1627, float %.1628, i32 %.1629, float %.1630, float %.1631, float* %.1632, i32* %.1633, i32 %.1634, i32 %.1635, float* %.1636, i32* %.1637, i32* %.1638, i32 %.1639, float* %.1640, float* %.1641, float %.1642, float %.1643, float %.1644, float* %.1645, i32 %.1646, float %.1647, float %.1648, float %.1649, i32* %.1650, float* %.1651, i32* %.1652, i32* %.1653, float* %.1654, float %.1655, float %.1656, i32* %.1657, i32 %.1658, float* %.1659, float* %.1660, float %.1661, float %.1662, i32* %.1663, i32* %.1664, i32 %.1665, i32 %.1666, float %.1667, float %.1668, i32* %.1669, i32 %.1670, float* %.1671, i32 %.1672, i32* %.1673, i32* %.1674, float %.1675, float %.1676, float* %.1677, i32 %.1678, i32* %.1679, float* %.1680, float %.1681, i32 %.1682, float %.1683, float* %.1684, float* %.1685, float %.1688, i32 %.1689)
  ret i32 %.1690at124 
.1592wc118:
  %.1596 = load i32, i32* %.1590
  %.1597 = icmp slt i32 %.1596, 10
  br i1 %.1597, label %.1593wloop.118.121, label %.1594wn121
.1593wloop.118.121:
  %.1599 = load i32, i32* %.1590
  %.1600 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 %.1599
  %.1601 = load i32, i32* %.1600
  %.1602 = load i32, i32* %.1590
  %.1603 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 %.1602
  %.1604 = load float, float* %.1603
  %.1605 = sitofp i32 %.1601 to float
  %.1606 = fsub float %.1605, %.1604
  %.1607 = load i32, i32* %.1590
  %.1608 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 %.1607
  %.1609 = fptosi float %.1606 to i32
  store i32 %.1609, i32* %.1608
  %.1611 = load i32, i32* %.1590
  %.1612 = add i32 %.1611, 1
  store i32 %.1612, i32* %.1590
  br label %.1592wc118 
.1594wn121:
  %.1615 = load i32, i32* @.g.k
  %.1616 = getelementptr inbounds [10 x i32], [10 x i32]* %.1470, i32 0, i32 %.1615
  %.1617 = load i32, i32* %.1616
  %.1618 = getelementptr inbounds [10 x float], [10 x float]* %.1340, i32 0, i32 8
  %.1619 = load float, float* %.1618
  %.1620 = sitofp i32 %.1617 to float
  %.1621 = fmul float %.1620, %.1619
  %.1622 = fptosi float %.1621 to i32
  ret i32 %.1622 
}
define i32 @main(){
.1693:
  %.2121 = alloca i32
  %.2078 = alloca float
  %.1883 = alloca float
  %.1733 = alloca float
  %.1697 = alloca i32
  %.1696 = alloca [24 x [3 x i32]]
  %.1694 = alloca [40 x [3 x float]]
  %.1699at137 = call i32 @getint()
  store i32 %.1699at137, i32* @.g.k
  store i32 0, i32* %.1697
  br label %.1702wc139 
.1702wc139:
  %.1706 = load i32, i32* %.1697
  %.1707 = icmp slt i32 %.1706, 40
  br i1 %.1707, label %.1703wloop.139.142, label %.1704wn142
.1703wloop.139.142:
  %.1709 = load i32, i32* %.1697
  %.1710 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 %.1709, i32 0
  %.1712at140 = call i32 @getfarray(float* %.1710)
  %.1713 = load i32, i32* %.1697
  %.1714 = add i32 %.1713, 1
  store i32 %.1714, i32* %.1697
  br label %.1702wc139 
.1704wn142:
  store i32 0, i32* %.1697
  br label %.1718wc144 
.1718wc144:
  %.1722 = load i32, i32* %.1697
  %.1723 = icmp slt i32 %.1722, 24
  br i1 %.1723, label %.1719wloop.144.147, label %.1720wn147
.1719wloop.144.147:
  %.1725 = load i32, i32* %.1697
  %.1726 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 %.1725, i32 0
  %.1728at145 = call i32 @getarray(i32* %.1726)
  %.1729 = load i32, i32* %.1697
  %.1730 = add i32 %.1729, 1
  store i32 %.1730, i32* %.1697
  br label %.1718wc144 
.1720wn147:
  %.1734 = load i32, i32* @.g.k
  %.1735 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 0, i32 %.1734
  %.1736 = load float, float* %.1735
  %.1737 = load i32, i32* @.g.k
  %.1738 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 1, i32 %.1737
  %.1739 = load float, float* %.1738
  %.1740 = load i32, i32* @.g.k
  %.1741 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 2, i32 %.1740
  %.1742 = load float, float* %.1741
  %.1743 = load i32, i32* @.g.k
  %.1744 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 3, i32 %.1743
  %.1745 = load float, float* %.1744
  %.1746 = load i32, i32* @.g.k
  %.1747 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 4, i32 %.1746
  %.1748 = load float, float* %.1747
  %.1749 = load i32, i32* @.g.k
  %.1750 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 5, i32 %.1749
  %.1751 = load float, float* %.1750
  %.1752 = load i32, i32* @.g.k
  %.1753 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 6, i32 %.1752
  %.1754 = load float, float* %.1753
  %.1755 = load i32, i32* @.g.k
  %.1756 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 7, i32 %.1755
  %.1757 = load float, float* %.1756
  %.1758 = load i32, i32* @.g.k
  %.1759 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 8, i32 %.1758
  %.1760 = load float, float* %.1759
  %.1761 = load i32, i32* @.g.k
  %.1762 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 9, i32 %.1761
  %.1763 = load float, float* %.1762
  %.1764 = load i32, i32* @.g.k
  %.1765 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 10, i32 %.1764
  %.1766 = load float, float* %.1765
  %.1768 = load i32, i32* @.g.k
  %.1769 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 11, i32 %.1768
  %.1770 = load float, float* %.1769
  %.1772 = load i32, i32* @.g.k
  %.1773 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 12, i32 %.1772
  %.1774 = load float, float* %.1773
  %.1776 = load i32, i32* @.g.k
  %.1777 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 13, i32 %.1776
  %.1778 = load float, float* %.1777
  %.1780 = load i32, i32* @.g.k
  %.1781 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 14, i32 %.1780
  %.1782 = load float, float* %.1781
  %.1784 = load i32, i32* @.g.k
  %.1785 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 15, i32 %.1784
  %.1786 = load float, float* %.1785
  %.1788 = load i32, i32* @.g.k
  %.1789 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 16, i32 %.1788
  %.1790 = load float, float* %.1789
  %.1792 = load i32, i32* @.g.k
  %.1793 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 17, i32 %.1792
  %.1794 = load float, float* %.1793
  %.1796 = load i32, i32* @.g.k
  %.1797 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 18, i32 %.1796
  %.1798 = load float, float* %.1797
  %.1800 = load i32, i32* @.g.k
  %.1801 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 19, i32 %.1800
  %.1802 = load float, float* %.1801
  %.1804 = load i32, i32* @.g.k
  %.1805 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 20, i32 %.1804
  %.1806 = load float, float* %.1805
  %.1808 = load i32, i32* @.g.k
  %.1809 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 21, i32 %.1808
  %.1810 = load float, float* %.1809
  %.1812 = load i32, i32* @.g.k
  %.1813 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 22, i32 %.1812
  %.1814 = load float, float* %.1813
  %.1816 = load i32, i32* @.g.k
  %.1817 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 23, i32 %.1816
  %.1818 = load float, float* %.1817
  %.1819 = load i32, i32* @.g.k
  %.1820 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 24, i32 %.1819
  %.1821 = load float, float* %.1820
  %.1823 = load i32, i32* @.g.k
  %.1824 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 25, i32 %.1823
  %.1825 = load float, float* %.1824
  %.1827 = load i32, i32* @.g.k
  %.1828 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 26, i32 %.1827
  %.1829 = load float, float* %.1828
  %.1831 = load i32, i32* @.g.k
  %.1832 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 27, i32 %.1831
  %.1833 = load float, float* %.1832
  %.1835 = load i32, i32* @.g.k
  %.1836 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 28, i32 %.1835
  %.1837 = load float, float* %.1836
  %.1839 = load i32, i32* @.g.k
  %.1840 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 29, i32 %.1839
  %.1841 = load float, float* %.1840
  %.1843 = load i32, i32* @.g.k
  %.1844 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 30, i32 %.1843
  %.1845 = load float, float* %.1844
  %.1847 = load i32, i32* @.g.k
  %.1848 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 31, i32 %.1847
  %.1849 = load float, float* %.1848
  %.1850 = load i32, i32* @.g.k
  %.1851 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 32, i32 %.1850
  %.1852 = load float, float* %.1851
  %.1854 = load i32, i32* @.g.k
  %.1855 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 33, i32 %.1854
  %.1856 = load float, float* %.1855
  %.1858 = load i32, i32* @.g.k
  %.1859 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 34, i32 %.1858
  %.1860 = load float, float* %.1859
  %.1862 = load i32, i32* @.g.k
  %.1863 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 35, i32 %.1862
  %.1864 = load float, float* %.1863
  %.1866 = load i32, i32* @.g.k
  %.1867 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 36, i32 %.1866
  %.1868 = load float, float* %.1867
  %.1870 = load i32, i32* @.g.k
  %.1871 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 37, i32 %.1870
  %.1872 = load float, float* %.1871
  %.1874 = load i32, i32* @.g.k
  %.1875 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 38, i32 %.1874
  %.1876 = load float, float* %.1875
  %.1878 = load i32, i32* @.g.k
  %.1879 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 39, i32 %.1878
  %.1880 = load float, float* %.1879
  %.1881at149 = call float @params_f40(float %.1736, float %.1739, float %.1742, float %.1745, float %.1748, float %.1751, float %.1754, float %.1757, float %.1760, float %.1763, float %.1766, float %.1770, float %.1774, float %.1778, float %.1782, float %.1786, float %.1790, float %.1794, float %.1798, float %.1802, float %.1806, float %.1810, float %.1814, float %.1818, float %.1821, float %.1825, float %.1829, float %.1833, float %.1837, float %.1841, float %.1845, float %.1849, float %.1852, float %.1856, float %.1860, float %.1864, float %.1868, float %.1872, float %.1876, float %.1880)
  store float %.1881at149, float* %.1733
  %.1884 = load i32, i32* @.g.k
  %.1885 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 23, i32 %.1884
  %.1886 = load i32, i32* %.1885
  %.1887 = load i32, i32* @.g.k
  %.1888 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 2, i32 %.1887
  %.1889 = load i32, i32* %.1888
  %.1890 = load i32, i32* @.g.k
  %.1891 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 6, i32 %.1890
  %.1892 = load i32, i32* %.1891
  %.1893 = load i32, i32* @.g.k
  %.1894 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 4, i32 %.1893
  %.1895 = load float, float* %.1894
  %.1896 = load i32, i32* @.g.k
  %.1897 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 1, i32 %.1896
  %.1898 = load i32, i32* %.1897
  %.1899 = load i32, i32* @.g.k
  %.1900 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 4, i32 %.1899
  %.1901 = load i32, i32* %.1900
  %.1902 = load i32, i32* @.g.k
  %.1903 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 5, i32 %.1902
  %.1904 = load i32, i32* %.1903
  %.1905 = load i32, i32* @.g.k
  %.1906 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 8, i32 %.1905
  %.1907 = load float, float* %.1906
  %.1908 = load i32, i32* @.g.k
  %.1909 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 15, i32 %.1908
  %.1910 = load float, float* %.1909
  %.1911 = load i32, i32* @.g.k
  %.1912 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 7, i32 %.1911
  %.1913 = load float, float* %.1912
  %.1914 = load i32, i32* @.g.k
  %.1915 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 22, i32 %.1914
  %.1916 = load i32, i32* %.1915
  %.1917 = load i32, i32* @.g.k
  %.1918 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 3, i32 %.1917
  %.1919 = load float, float* %.1918
  %.1920 = load i32, i32* @.g.k
  %.1921 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 28, i32 %.1920
  %.1922 = load float, float* %.1921
  %.1923 = load i32, i32* @.g.k
  %.1924 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 0, i32 %.1923
  %.1925 = load i32, i32* %.1924
  %.1926 = load i32, i32* @.g.k
  %.1927 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 37, i32 %.1926
  %.1928 = load float, float* %.1927
  %.1929 = load i32, i32* @.g.k
  %.1930 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 19, i32 %.1929
  %.1931 = load i32, i32* %.1930
  %.1932 = load i32, i32* @.g.k
  %.1933 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 30, i32 %.1932
  %.1934 = load float, float* %.1933
  %.1935 = load i32, i32* @.g.k
  %.1936 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 12, i32 %.1935
  %.1937 = load float, float* %.1936
  %.1938 = load i32, i32* @.g.k
  %.1939 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 1, i32 %.1938
  %.1940 = load float, float* %.1939
  %.1941 = load i32, i32* @.g.k
  %.1942 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 11, i32 %.1941
  %.1943 = load float, float* %.1942
  %.1944 = load i32, i32* @.g.k
  %.1945 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 38, i32 %.1944
  %.1946 = load float, float* %.1945
  %.1947 = load i32, i32* @.g.k
  %.1948 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 6, i32 %.1947
  %.1949 = load float, float* %.1948
  %.1950 = load i32, i32* @.g.k
  %.1951 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 7, i32 %.1950
  %.1952 = load i32, i32* %.1951
  %.1953 = load i32, i32* @.g.k
  %.1954 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 32, i32 %.1953
  %.1955 = load float, float* %.1954
  %.1956 = load i32, i32* @.g.k
  %.1957 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 10, i32 %.1956
  %.1958 = load i32, i32* %.1957
  %.1959 = load i32, i32* @.g.k
  %.1960 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 13, i32 %.1959
  %.1961 = load i32, i32* %.1960
  %.1962 = load i32, i32* @.g.k
  %.1963 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 20, i32 %.1962
  %.1964 = load float, float* %.1963
  %.1965 = load i32, i32* @.g.k
  %.1966 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 33, i32 %.1965
  %.1967 = load float, float* %.1966
  %.1968 = load i32, i32* @.g.k
  %.1969 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 23, i32 %.1968
  %.1970 = load float, float* %.1969
  %.1971 = load i32, i32* @.g.k
  %.1972 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 9, i32 %.1971
  %.1973 = load float, float* %.1972
  %.1974 = load i32, i32* @.g.k
  %.1975 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 25, i32 %.1974
  %.1976 = load float, float* %.1975
  %.1977 = load i32, i32* @.g.k
  %.1978 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 8, i32 %.1977
  %.1979 = load i32, i32* %.1978
  %.1980 = load i32, i32* @.g.k
  %.1981 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 39, i32 %.1980
  %.1982 = load float, float* %.1981
  %.1983 = load i32, i32* @.g.k
  %.1984 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 17, i32 %.1983
  %.1985 = load i32, i32* %.1984
  %.1986 = load i32, i32* @.g.k
  %.1987 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 21, i32 %.1986
  %.1988 = load float, float* %.1987
  %.1989 = load i32, i32* @.g.k
  %.1990 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 16, i32 %.1989
  %.1991 = load float, float* %.1990
  %.1992 = load i32, i32* @.g.k
  %.1993 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 5, i32 %.1992
  %.1994 = load float, float* %.1993
  %.1995 = load i32, i32* @.g.k
  %.1996 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 34, i32 %.1995
  %.1997 = load float, float* %.1996
  %.1998 = load i32, i32* @.g.k
  %.1999 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 18, i32 %.1998
  %.2000 = load i32, i32* %.1999
  %.2001 = load i32, i32* @.g.k
  %.2002 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 9, i32 %.2001
  %.2003 = load i32, i32* %.2002
  %.2004 = load i32, i32* @.g.k
  %.2005 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 14, i32 %.2004
  %.2006 = load float, float* %.2005
  %.2007 = load i32, i32* @.g.k
  %.2008 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 10, i32 %.2007
  %.2009 = load float, float* %.2008
  %.2010 = load i32, i32* @.g.k
  %.2011 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 0, i32 %.2010
  %.2012 = load float, float* %.2011
  %.2013 = load i32, i32* @.g.k
  %.2014 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 12, i32 %.2013
  %.2015 = load i32, i32* %.2014
  %.2016 = load i32, i32* @.g.k
  %.2017 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 31, i32 %.2016
  %.2018 = load float, float* %.2017
  %.2019 = load i32, i32* @.g.k
  %.2020 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 11, i32 %.2019
  %.2021 = load i32, i32* %.2020
  %.2022 = load i32, i32* @.g.k
  %.2023 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 16, i32 %.2022
  %.2024 = load i32, i32* %.2023
  %.2025 = load i32, i32* @.g.k
  %.2026 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 27, i32 %.2025
  %.2027 = load float, float* %.2026
  %.2028 = load i32, i32* @.g.k
  %.2029 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 24, i32 %.2028
  %.2030 = load float, float* %.2029
  %.2031 = load i32, i32* @.g.k
  %.2032 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 13, i32 %.2031
  %.2033 = load float, float* %.2032
  %.2034 = load i32, i32* @.g.k
  %.2035 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 29, i32 %.2034
  %.2036 = load float, float* %.2035
  %.2037 = load i32, i32* @.g.k
  %.2038 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 3, i32 %.2037
  %.2039 = load i32, i32* %.2038
  %.2040 = load i32, i32* @.g.k
  %.2041 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 21, i32 %.2040
  %.2042 = load i32, i32* %.2041
  %.2043 = load i32, i32* @.g.k
  %.2044 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 20, i32 %.2043
  %.2045 = load i32, i32* %.2044
  %.2046 = load i32, i32* @.g.k
  %.2047 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 18, i32 %.2046
  %.2048 = load float, float* %.2047
  %.2049 = load i32, i32* @.g.k
  %.2050 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 19, i32 %.2049
  %.2051 = load float, float* %.2050
  %.2052 = load i32, i32* @.g.k
  %.2053 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 22, i32 %.2052
  %.2054 = load float, float* %.2053
  %.2055 = load i32, i32* @.g.k
  %.2056 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 26, i32 %.2055
  %.2057 = load float, float* %.2056
  %.2058 = load i32, i32* @.g.k
  %.2059 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 36, i32 %.2058
  %.2060 = load float, float* %.2059
  %.2061 = load i32, i32* @.g.k
  %.2062 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 17, i32 %.2061
  %.2063 = load float, float* %.2062
  %.2064 = load i32, i32* @.g.k
  %.2065 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 15, i32 %.2064
  %.2066 = load i32, i32* %.2065
  %.2067 = load i32, i32* @.g.k
  %.2068 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 2, i32 %.2067
  %.2069 = load float, float* %.2068
  %.2070 = load i32, i32* @.g.k
  %.2071 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 14, i32 %.2070
  %.2072 = load i32, i32* %.2071
  %.2073 = load i32, i32* @.g.k
  %.2074 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 35, i32 %.2073
  %.2075 = load float, float* %.2074
  %.2076at157 = call float @params_f40_i24(i32 %.1886, i32 %.1889, i32 %.1892, float %.1895, i32 %.1898, i32 %.1901, i32 %.1904, float %.1907, float %.1910, float %.1913, i32 %.1916, float %.1919, float %.1922, i32 %.1925, float %.1928, i32 %.1931, float %.1934, float %.1937, float %.1940, float %.1943, float %.1946, float %.1949, i32 %.1952, float %.1955, i32 %.1958, i32 %.1961, float %.1964, float %.1967, float %.1970, float %.1973, float %.1976, i32 %.1979, float %.1982, i32 %.1985, float %.1988, float %.1991, float %.1994, float %.1997, i32 %.2000, i32 %.2003, float %.2006, float %.2009, float %.2012, i32 %.2015, float %.2018, i32 %.2021, i32 %.2024, float %.2027, float %.2030, float %.2033, float %.2036, i32 %.2039, i32 %.2042, i32 %.2045, float %.2048, float %.2051, float %.2054, float %.2057, float %.2060, float %.2063, i32 %.2066, float %.2069, i32 %.2072, float %.2075)
  store float %.2076at157, float* %.1883
  %.2079 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 0, i32 0
  %.2080 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 1, i32 0
  %.2081 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 2, i32 0
  %.2082 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 3, i32 0
  %.2083 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 4, i32 0
  %.2084 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 5, i32 0
  %.2085 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 6, i32 0
  %.2086 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 7, i32 0
  %.2087 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 8, i32 0
  %.2088 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 9, i32 0
  %.2089 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 10, i32 0
  %.2090 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 11, i32 0
  %.2091 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 12, i32 0
  %.2092 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 13, i32 0
  %.2093 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 14, i32 0
  %.2094 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 15, i32 0
  %.2095 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 16, i32 0
  %.2096 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 17, i32 0
  %.2097 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 18, i32 0
  %.2098 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 19, i32 0
  %.2099 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 20, i32 0
  %.2100 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 21, i32 0
  %.2101 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 22, i32 0
  %.2102 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 23, i32 0
  %.2103 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 24, i32 0
  %.2104 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 25, i32 0
  %.2105 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 26, i32 0
  %.2106 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 27, i32 0
  %.2107 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 28, i32 0
  %.2108 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 29, i32 0
  %.2109 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 30, i32 0
  %.2110 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 31, i32 0
  %.2111 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 32, i32 0
  %.2112 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 33, i32 0
  %.2113 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 34, i32 0
  %.2114 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 35, i32 0
  %.2115 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 36, i32 0
  %.2116 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 37, i32 0
  %.2117 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 38, i32 0
  %.2118 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 39, i32 0
  %.2119at169 = call float @params_fa40(float* %.2079, float* %.2080, float* %.2081, float* %.2082, float* %.2083, float* %.2084, float* %.2085, float* %.2086, float* %.2087, float* %.2088, float* %.2089, float* %.2090, float* %.2091, float* %.2092, float* %.2093, float* %.2094, float* %.2095, float* %.2096, float* %.2097, float* %.2098, float* %.2099, float* %.2100, float* %.2101, float* %.2102, float* %.2103, float* %.2104, float* %.2105, float* %.2106, float* %.2107, float* %.2108, float* %.2109, float* %.2110, float* %.2111, float* %.2112, float* %.2113, float* %.2114, float* %.2115, float* %.2116, float* %.2117, float* %.2118)
  store float %.2119at169, float* %.2078
  %.2122 = load i32, i32* @.g.k
  %.2123 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 0, i32 %.2122
  %.2124 = load float, float* %.2123
  %.2125 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 0, i32 0
  %.2126 = load i32, i32* @.g.k
  %.2127 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 1, i32 %.2126
  %.2128 = load i32, i32* %.2127
  %.2129 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 1, i32 0
  %.2130 = load i32, i32* @.g.k
  %.2131 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 2, i32 %.2130
  %.2132 = load float, float* %.2131
  %.2133 = load i32, i32* @.g.k
  %.2134 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 2, i32 %.2133
  %.2135 = load i32, i32* %.2134
  %.2136 = load i32, i32* @.g.k
  %.2137 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 3, i32 %.2136
  %.2138 = load float, float* %.2137
  %.2139 = load i32, i32* @.g.k
  %.2140 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 4, i32 %.2139
  %.2141 = load float, float* %.2140
  %.2142 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 5, i32 0
  %.2143 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 3, i32 0
  %.2144 = load i32, i32* @.g.k
  %.2145 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 4, i32 %.2144
  %.2146 = load i32, i32* %.2145
  %.2147 = load i32, i32* @.g.k
  %.2148 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 5, i32 %.2147
  %.2149 = load i32, i32* %.2148
  %.2150 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 6, i32 0
  %.2151 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 6, i32 0
  %.2152 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 7, i32 0
  %.2153 = load i32, i32* @.g.k
  %.2154 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 8, i32 %.2153
  %.2155 = load i32, i32* %.2154
  %.2156 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 7, i32 0
  %.2157 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 8, i32 0
  %.2158 = load i32, i32* @.g.k
  %.2159 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 9, i32 %.2158
  %.2160 = load float, float* %.2159
  %.2161 = load i32, i32* @.g.k
  %.2162 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 10, i32 %.2161
  %.2163 = load float, float* %.2162
  %.2164 = load i32, i32* @.g.k
  %.2165 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 11, i32 %.2164
  %.2166 = load float, float* %.2165
  %.2167 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 12, i32 0
  %.2168 = load i32, i32* @.g.k
  %.2169 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 9, i32 %.2168
  %.2170 = load i32, i32* %.2169
  %.2171 = load i32, i32* @.g.k
  %.2172 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 13, i32 %.2171
  %.2173 = load float, float* %.2172
  %.2174 = load i32, i32* @.g.k
  %.2175 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 14, i32 %.2174
  %.2176 = load float, float* %.2175
  %.2177 = load i32, i32* @.g.k
  %.2178 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 15, i32 %.2177
  %.2179 = load float, float* %.2178
  %.2180 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 10, i32 0
  %.2181 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 16, i32 0
  %.2182 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 11, i32 0
  %.2183 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 12, i32 0
  %.2184 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 17, i32 0
  %.2185 = load i32, i32* @.g.k
  %.2186 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 18, i32 %.2185
  %.2187 = load float, float* %.2186
  %.2188 = load i32, i32* @.g.k
  %.2189 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 19, i32 %.2188
  %.2190 = load float, float* %.2189
  %.2191 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 13, i32 0
  %.2192 = load i32, i32* @.g.k
  %.2193 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 14, i32 %.2192
  %.2194 = load i32, i32* %.2193
  %.2195 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 20, i32 0
  %.2196 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 21, i32 0
  %.2197 = load i32, i32* @.g.k
  %.2198 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 22, i32 %.2197
  %.2199 = load float, float* %.2198
  %.2200 = load i32, i32* @.g.k
  %.2201 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 23, i32 %.2200
  %.2202 = load float, float* %.2201
  %.2203 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 15, i32 0
  %.2204 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 16, i32 0
  %.2205 = load i32, i32* @.g.k
  %.2206 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 17, i32 %.2205
  %.2207 = load i32, i32* %.2206
  %.2208 = load i32, i32* @.g.k
  %.2209 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 18, i32 %.2208
  %.2210 = load i32, i32* %.2209
  %.2211 = load i32, i32* @.g.k
  %.2212 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 24, i32 %.2211
  %.2213 = load float, float* %.2212
  %.2214 = load i32, i32* @.g.k
  %.2215 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 25, i32 %.2214
  %.2216 = load float, float* %.2215
  %.2217 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 19, i32 0
  %.2218 = load i32, i32* @.g.k
  %.2219 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 20, i32 %.2218
  %.2220 = load i32, i32* %.2219
  %.2221 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 26, i32 0
  %.2222 = load i32, i32* @.g.k
  %.2223 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 21, i32 %.2222
  %.2224 = load i32, i32* %.2223
  %.2225 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 22, i32 0
  %.2226 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 23, i32 0
  %.2227 = load i32, i32* @.g.k
  %.2228 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 27, i32 %.2227
  %.2229 = load float, float* %.2228
  %.2230 = load i32, i32* @.g.k
  %.2231 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 28, i32 %.2230
  %.2232 = load float, float* %.2231
  %.2233 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 29, i32 0
  %.2234 = load i32, i32* @.g.k
  %.2235 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 0, i32 %.2234
  %.2236 = load i32, i32* %.2235
  %.2237 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 1, i32 0
  %.2238 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 30, i32 0
  %.2239 = load i32, i32* @.g.k
  %.2240 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 31, i32 %.2239
  %.2241 = load float, float* %.2240
  %.2242 = load i32, i32* @.g.k
  %.2243 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 2, i32 %.2242
  %.2244 = load i32, i32* %.2243
  %.2245 = load i32, i32* @.g.k
  %.2246 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 32, i32 %.2245
  %.2247 = load float, float* %.2246
  %.2248 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 33, i32 0
  %.2249 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 34, i32 0
  %.2250 = load i32, i32* @.g.k
  %.2251 = getelementptr inbounds [40 x [3 x float]], [40 x [3 x float]]* %.1694, i32 0, i32 35, i32 %.2250
  %.2252 = load float, float* %.2251
  %.2253 = load i32, i32* @.g.k
  %.2254 = getelementptr inbounds [24 x [3 x i32]], [24 x [3 x i32]]* %.1696, i32 0, i32 3, i32 %.2253
  %.2255 = load i32, i32* %.2254
  %.2256at175 = call i32 @params_mix(float %.2124, i32* %.2125, i32 %.2128, float* %.2129, float %.2132, i32 %.2135, float %.2138, float %.2141, float* %.2142, i32* %.2143, i32 %.2146, i32 %.2149, float* %.2150, i32* %.2151, i32* %.2152, i32 %.2155, float* %.2156, float* %.2157, float %.2160, float %.2163, float %.2166, float* %.2167, i32 %.2170, float %.2173, float %.2176, float %.2179, i32* %.2180, float* %.2181, i32* %.2182, i32* %.2183, float* %.2184, float %.2187, float %.2190, i32* %.2191, i32 %.2194, float* %.2195, float* %.2196, float %.2199, float %.2202, i32* %.2203, i32* %.2204, i32 %.2207, i32 %.2210, float %.2213, float %.2216, i32* %.2217, i32 %.2220, float* %.2221, i32 %.2224, i32* %.2225, i32* %.2226, float %.2229, float %.2232, float* %.2233, i32 %.2236, i32* %.2237, float* %.2238, float %.2241, i32 %.2244, float %.2247, float* %.2248, float* %.2249, float %.2252, i32 %.2255)
  store i32 %.2256at175, i32* %.2121
  %.2258 = load float, float* %.1733
  call void @putfloat(float %.2258)
  call void @putch(i32 10)
  %.2263 = load float, float* %.1883
  call void @putfloat(float %.2263)
  call void @putch(i32 10)
  %.2266 = load float, float* %.2078
  call void @putfloat(float %.2266)
  call void @putch(i32 10)
  %.2269 = load i32, i32* %.2121
  call void @putint(i32 %.2269)
  call void @putch(i32 10)
  ret