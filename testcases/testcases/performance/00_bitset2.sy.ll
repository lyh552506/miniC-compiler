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
@.g.seed = global [3 x i32]  [i32 19971231, i32 19981013, i32 1000000007]
@.g.staticvalue = global i32 0
@.g.a = global [10000 x i32] zeroinitializer
@__constant..16 = constant [31 x i32] zeroinitializer
define i32 @set(i32* %.3, i32 %.6, i32 %.9){
.1:
  %.105 = alloca i32
  %.84 = alloca i32
  %.14 = alloca [31 x i32]
  %.8 = alloca i32
  %.5 = alloca i32
  %.2 = alloca i32*
  store i32* %.3, i32** %.2
  store i32 %.6, i32* %.5
  store i32 %.9, i32* %.8
  call void @llvm.memcpy.p0.p0.i32([31 x i32]* %.14, [31 x i32]* @__constant..16, i32 124, i1 false)
  %.23 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 0
  store i32 1, i32* %.23
  %.25 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 0
  %.26 = load i32, i32* %.25
  %.28 = mul i32 %.26, 2
  %.29 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 1
  store i32 %.28, i32* %.29
  %.31 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 1
  %.32 = load i32, i32* %.31
  %.33 = mul i32 %.32, 2
  %.34 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 2
  store i32 %.33, i32* %.34
  %.36 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 2
  %.37 = load i32, i32* %.36
  %.38 = mul i32 %.37, 2
  %.40 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 3
  store i32 %.38, i32* %.40
  %.42 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 3
  %.43 = load i32, i32* %.42
  %.44 = mul i32 %.43, 2
  %.46 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 4
  store i32 %.44, i32* %.46
  %.48 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 4
  %.49 = load i32, i32* %.48
  %.50 = mul i32 %.49, 2
  %.52 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 5
  store i32 %.50, i32* %.52
  %.54 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 5
  %.55 = load i32, i32* %.54
  %.56 = mul i32 %.55, 2
  %.58 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 6
  store i32 %.56, i32* %.58
  %.60 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 6
  %.61 = load i32, i32* %.60
  %.62 = mul i32 %.61, 2
  %.64 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 7
  store i32 %.62, i32* %.64
  %.66 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 7
  %.67 = load i32, i32* %.66
  %.68 = mul i32 %.67, 2
  %.70 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 8
  store i32 %.68, i32* %.70
  %.72 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 8
  %.73 = load i32, i32* %.72
  %.74 = mul i32 %.73, 2
  %.76 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 9
  store i32 %.74, i32* %.76
  %.78 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 9
  %.79 = load i32, i32* %.78
  %.80 = mul i32 %.79, 2
  %.82 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 10
  store i32 %.80, i32* %.82
  store i32 10, i32* %.84
  br label %.86wc18 
.86wc18:
  %.90 = load i32, i32* %.84
  %.91 = icmp slt i32 %.90, 30
  br i1 %.91, label %.87wloop.18.21, label %.88wn21
.87wloop.18.21:
  %.93 = load i32, i32* %.84
  %.94 = add i32 %.93, 1
  store i32 %.94, i32* %.84
  %.96 = load i32, i32* %.84
  %.97 = sub i32 %.96, 1
  %.98 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.97
  %.99 = load i32, i32* %.98
  %.100 = mul i32 %.99, 2
  %.101 = load i32, i32* %.84
  %.102 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.101
  store i32 %.100, i32* %.102
  br label %.86wc18 
.88wn21:
  store i32 0, i32* %.105
  %.109 = load i32, i32* %.5
  %.110 = sdiv i32 %.109, 30
  %.112 = icmp sge i32 %.110, 10000
  br i1 %.112, label %.107, label %.108
.107:
  ret i32 0 
.108:
  %.117 = load i32, i32* %.5
  %.118 = sdiv i32 %.117, 30
  %.119 = load i32*, i32** %.2
  %.120 = getelementptr inbounds i32, i32* %.119, i32 %.118
  %.121 = load i32, i32* %.120
  %.122 = load i32, i32* %.5
  %.123 = srem i32 %.122, 30
  %.124 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.123
  %.125 = load i32, i32* %.124
  %.126 = sdiv i32 %.121, %.125
  %.127 = srem i32 %.126, 2
  %.128 = load i32, i32* %.8
  %.129 = icmp ne i32 %.127, %.128
  br i1 %.129, label %.115, label %.116
.115:
  %.133 = load i32, i32* %.5
  %.134 = sdiv i32 %.133, 30
  %.135 = load i32*, i32** %.2
  %.136 = getelementptr inbounds i32, i32* %.135, i32 %.134
  %.137 = load i32, i32* %.136
  %.138 = load i32, i32* %.5
  %.139 = srem i32 %.138, 30
  %.140 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.139
  %.141 = load i32, i32* %.140
  %.142 = sdiv i32 %.137, %.141
  %.143 = srem i32 %.142, 2
  %.144 = icmp eq i32 %.143, 0
  br i1 %.144, label %.131, label %.132
.116:
  %.188 = load i32, i32* %.5
  %.189 = sdiv i32 %.188, 30
  %.190 = load i32*, i32** %.2
  %.191 = getelementptr inbounds i32, i32* %.190, i32 %.189
  %.192 = load i32, i32* %.191
  %.193 = load i32, i32* %.105
  %.194 = add i32 %.192, %.193
  %.195 = load i32, i32* %.5
  %.196 = sdiv i32 %.195, 30
  %.197 = load i32*, i32** %.2
  %.198 = getelementptr inbounds i32, i32* %.197, i32 %.196
  store i32 %.194, i32* %.198
  ret i32 0 
.131:
  %.148 = load i32, i32* %.8
  %.149 = icmp eq i32 %.148, 1
  br i1 %.149, label %.146, label %.147
.132:
  %.160 = load i32, i32* %.5
  %.161 = sdiv i32 %.160, 30
  %.162 = load i32*, i32** %.2
  %.163 = getelementptr inbounds i32, i32* %.162, i32 %.161
  %.164 = load i32, i32* %.163
  %.165 = load i32, i32* %.5
  %.166 = srem i32 %.165, 30
  %.167 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.166
  %.168 = load i32, i32* %.167
  %.169 = sdiv i32 %.164, %.168
  %.170 = srem i32 %.169, 2
  %.171 = icmp eq i32 %.170, 1
  br i1 %.171, label %.158, label %.159
.146:
  %.151 = load i32, i32* %.5
  %.152 = srem i32 %.151, 30
  %.153 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.152
  %.154 = load i32, i32* %.153
  store i32 %.154, i32* %.105
  br label %.147 
.147:
  br label %.132 
.158:
  %.175 = load i32, i32* %.8
  %.176 = icmp eq i32 %.175, 0
  br i1 %.176, label %.173, label %.174
.159:
  br label %.116 
.173:
  %.178 = load i32, i32* %.105
  %.179 = load i32, i32* %.5
  %.180 = srem i32 %.179, 30
  %.181 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.180
  %.182 = load i32, i32* %.181
  %.183 = sub i32 %.178, %.182
  store i32 %.183, i32* %.105
  br label %.174 
.174:
  br label %.159 
}
define i32 @rand(){
.209:
  %.210 = load i32, i32* @.g.staticvalue
  %.211 = getelementptr inbounds [3 x i32], [3 x i32]* @.g.seed, i32 0, i32 0
  %.212 = load i32, i32* %.211
  %.213 = mul i32 %.210, %.212
  %.214 = getelementptr inbounds [3 x i32], [3 x i32]* @.g.seed, i32 0, i32 1
  %.215 = load i32, i32* %.214
  %.216 = add i32 %.213, %.215
  store i32 %.216, i32* @.g.staticvalue
  %.218 = load i32, i32* @.g.staticvalue
  %.219 = getelementptr inbounds [3 x i32], [3 x i32]* @.g.seed, i32 0, i32 2
  %.220 = load i32, i32* %.219
  %.221 = srem i32 %.218, %.220
  store i32 %.221, i32* @.g.staticvalue
  %.225 = load i32, i32* @.g.staticvalue
  %.226 = icmp slt i32 %.225, 0
  br i1 %.226, label %.223, label %.224
.223:
  %.228 = getelementptr inbounds [3 x i32], [3 x i32]* @.g.seed, i32 0, i32 2
  %.229 = load i32, i32* %.228
  %.230 = load i32, i32* @.g.staticvalue
  %.231 = add i32 %.229, %.230
  store i32 %.231, i32* @.g.staticvalue
  br label %.224 
.224:
  %.234 = load i32, i32* @.g.staticvalue
  ret i32 %.234 
}
define i32 @main(){
.239:
  %.250 = alloca i32
  %.249 = alloca i32
  %.240 = alloca i32
  %.242at54 = call i32 @getint()
  store i32 %.242at54, i32* %.240
  %.244at55 = call i32 @getint()
  store i32 %.244at55, i32* @.g.staticvalue
  call void @_sysy_starttime(i32 56)
  br label %.251wc58 
.251wc58:
  %.255 = load i32, i32* %.240
  %.256 = icmp sgt i32 %.255, 0
  br i1 %.256, label %.252wloop.58.63, label %.253wn63
.252wloop.58.63:
  %.258 = load i32, i32* %.240
  %.259 = sub i32 %.258, 1
  store i32 %.259, i32* %.240
  %.261at60 = call i32 @rand()
  %.263 = srem i32 %.261at60, 300000
  store i32 %.263, i32* %.249
  %.265at61 = call i32 @rand()
  %.266 = srem i32 %.265at61, 2
  store i32 %.266, i32* %.250
  %.268 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.a, i32 0, i32 0
  %.269 = load i32, i32* %.249
  %.270 = load i32, i32* %.250
  %.271at62 = call i32 @set(i32* %.268, i32 %.269, i32 %.270)
  br label %.251wc58 
.253wn63:
  call void @_sysy_stoptime(i32 64)
  %.276 = getelementptr inbounds [10000 x i32], [10000 x i32]* @.g.a, i32 0, i32 0
  call void @putarray(i32 10000, i32* %.276)
  ret i32 0 
}
@.g.seed = global [3 x i32]  [i32 19971231, i32 19981013, i32 1000000007]
@.g.staticvalue = global i32 0
@.g.a = global [10000 x i32] zeroinitializer
@__constant..16 = constant [31 x i32] zeroinitializer
define i32 @set(i32* %.3, i32 %.6, i32 %.9){
.1:
  %.105 = alloca i32
  %.84 = alloca i32
  %.14 = alloca [31 x i32]
  %.8 = alloca i32
  %.5 = alloca i32
  %.2 = alloca i32*
  store i32* %.3, i32** %.2
  store i32 %.6, i32* %.5
  store i32 %.9, i32* %.8
  call void @llvm.memcpy.p0.p0.i32([31 x i32]* %.14, [31 x i32]* @__constant..16, i32 124, i1 false)
  %.23 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 0
  store i32 1, i32* %.23
  %.25 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 0
  %.26 = load i32, i32* %.25
  %.28 = mul i32 %.26, 2
  %.29 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 1
  store i32 %.28, i32* %.29
  %.31 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 1
  %.32 = load i32, i32* %.31
  %.33 = mul i32 %.32, 2
  %.34 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 2
  store i32 %.33, i32* %.34
  %.36 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 2
  %.37 = load i32, i32* %.36
  %.38 = mul i32 %.37, 2
  %.40 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 3
  store i32 %.38, i32* %.40
  %.42 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 3
  %.43 = load i32, i32* %.42
  %.44 = mul i32 %.43, 2
  %.46 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 4
  store i32 %.44, i32* %.46
  %.48 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 4
  %.49 = load i32, i32* %.48
  %.50 = mul i32 %.49, 2
  %.52 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 5
  store i32 %.50, i32* %.52
  %.54 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 5
  %.55 = load i32, i32* %.54
  %.56 = mul i32 %.55, 2
  %.58 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 6
  store i32 %.56, i32* %.58
  %.60 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 6
  %.61 = load i32, i32* %.60
  %.62 = mul i32 %.61, 2
  %.64 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 7
  store i32 %.62, i32* %.64
  %.66 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 7
  %.67 = load i32, i32* %.66
  %.68 = mul i32 %.67, 2
  %.70 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 8
  store i32 %.68, i32* %.70
  %.72 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 8
  %.73 = load i32, i32* %.72
  %.74 = mul i32 %.73, 2
  %.76 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 9
  store i32 %.74, i32* %.76
  %.78 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 9
  %.79 = load i32, i32* %.78
  %.80 = mul i32 %.79, 2
  %.82 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 10
  store i32 %.80, i32* %.82
  store i32 10, i32* %.84
  br label %.86wc18 
.86wc18:
  %.90 = load i32, i32* %.84
  %.91 = icmp slt i32 %.90, 30
  br i1 %.91, label %.87wloop.18.21, label %.88wn21
.87wloop.18.21:
  %.93 = load i32, i32* %.84
  %.94 = add i32 %.93, 1
  store i32 %.94, i32* %.84
  %.96 = load i32, i32* %.84
  %.97 = sub i32 %.96, 1
  %.98 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.97
  %.99 = load i32, i32* %.98
  %.100 = mul i32 %.99, 2
  %.101 = load i32, i32* %.84
  %.102 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.101
  store i32 %.100, i32* %.102
  br label %.86wc18 
.88wn21:
  store i32 0, i32* %.105
  %.109 = load i32, i32* %.5
  %.110 = sdiv i32 %.109, 30
  %.112 = icmp sge i32 %.110, 10000
  br i1 %.112, label %.107, label %.108
.107:
  ret i32 0 
.108:
  %.117 = load i32, i32* %.5
  %.118 = sdiv i32 %.117, 30
  %.119 = load i32*, i32** %.2
  %.120 = getelementptr inbounds i32, i32* %.119, i32 %.118
  %.121 = load i32, i32* %.120
  %.122 = load i32, i32* %.5
  %.123 = srem i32 %.122, 30
  %.124 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.123
  %.125 = load i32, i32* %.124
  %.126 = sdiv i32 %.121, %.125
  %.127 = srem i32 %.126, 2
  %.128 = load i32, i32* %.8
  %.129 = icmp ne i32 %.127, %.128
  br i1 %.129, label %.115, label %.116
.115:
  %.133 = load i32, i32* %.5
  %.134 = sdiv i32 %.133, 30
  %.135 = load i32*, i32** %.2
  %.136 = getelementptr inbounds i32, i32* %.135, i32 %.134
  %.137 = load i32, i32* %.136
  %.138 = load i32, i32* %.5
  %.139 = srem i32 %.138, 30
  %.140 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.139
  %.141 = load i32, i32* %.140
  %.142 = sdiv i32 %.137, %.141
  %.143 = srem i32 %.142, 2
  %.144 = icmp eq i32 %.143, 0
  br i1 %.144, label %.131, label %.132
.116:
  %.188 = load i32, i32* %.5
  %.189 = sdiv i32 %.188, 30
  %.190 = load i32*, i32** %.2
  %.191 = getelementptr inbounds i32, i32* %.190, i32 %.189
  %.192 = load i32, i32* %.191
  %.193 = load i32, i32* %.105
  %.194 = add i32 %.192, %.193
  %.195 = load i32, i32* %.5
  %.196 = sdiv i32 %.195, 30
  %.197 = load i32*, i32** %.2
  %.198 = getelementptr inbounds i32, i32* %.197, i32 %.196
  store i32 %.194, i32* %.198
  ret i32 0 
.131:
  %.148 = load i32, i32* %.8
  %.149 = icmp eq i32 %.148, 1
  br i1 %.149, label %.146, label %.147
.132:
  %.160 = load i32, i32* %.5
  %.161 = sdiv i32 %.160, 30
  %.162 = load i32*, i32** %.2
  %.163 = getelementptr inbounds i32, i32* %.162, i32 %.161
  %.164 = load i32, i32* %.163
  %.165 = load i32, i32* %.5
  %.166 = srem i32 %.165, 30
  %.167 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.166
  %.168 = load i32, i32* %.167
  %.169 = sdiv i32 %.164, %.168
  %.170 = srem i32 %.169, 2
  %.171 = icmp eq i32 %.170, 1
  br i1 %.171, label %.158, label %.159
.146:
  %.151 = load i32, i32* %.5
  %.152 = srem i32 %.151, 30
  %.153 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.152
  %.154 = load i32, i32* %.153
  store i32 %.154, i32* %.105
  br label %.147 
.147:
  br label %.132 
.158:
  %.175 = load i32, i32* %.8
  %.176 = icmp eq i32 %.175, 0
  br i1 %.176, label %.173, label %.174
.159:
  br label %.116 
.173:
  %.178 = load i32, i32* %.105
  %.179 = load i32, i32* %.5
  %.180 = srem i32 %.179, 30
  %.181 = getelementptr inbounds [31 x i32], [31 x i32]* %.14, i32 0, i32 %.180
  %.182 = load i32, i32* %.181
  %.183 = sub i32 %.178, %.182
  store i32 %.183, i32* %.105
  br label %.174 
.174:
  br label %.159 
}
define i32 @rand(){
.209:
  %.210 = load i32, i32* @.g.staticvalue
  %.211 = getelementptr inbounds [3 x i32], [3 x i32]* @.g.seed, i32 0, i32 0
  %.212 = load i32, i32* %.211
  %.213 = mul i32 %.210, %.212
  %.214 = getelementptr inbounds [3 x i32], [3 x i32]* @.g.seed, i32 0, i32 1
  %.215 = load i32, i32* %.214
  %.216 = add i32 %.213, %.215
  store i32 %.216, i32* @.g.staticvalue
  %.218 = load i32, i32* @.g.staticvalue
  %.219 = getelementptr inbounds [3 x i32], [3 x i32]* @.g.seed, i32 0, i32 2
  %.220 = load i32, i32* %.219
  %.221 = srem i32 %.218, %.220
  store i32 %.221, i32* @.g.staticvalue
  %.225 = load i32, i32* @.g.staticvalue
  %.226 = icmp slt i32 %.225, 0
  br i1 %.226, label %.223, label %.224
.223:
  %.228 = getelementptr inbounds [3 x i32], [3 x i32]* @.g.seed, i32 0, i32 2
  %.229 = load i32, i32* %.228
  %.230 = load i32, i32* @.g.staticvalue
  %.231 = add i32 %.229, %.230
  store i32 %.231, i32* @.g.staticvalue
  br label %.224 
.224:
  %.234 = load i32, i32* @.g.staticvalue
  ret i32 %.234 
}
define i32 @main(){
.239:
  %.250 = alloca i32
  %.249 = alloca i32
  %.240 = alloca i32
  %.242at54 = call i32 @getint()
  store i32 %.242at54, i32* %.240
  %.244at55 = call i32 @getint()
  store i32 %.244at55, i32* @.g.staticvalue
  call void @_sysy_starttime(i32 56)
  br label %.251wc58 
.251wc58:
  %.255 = load i32, i32* %.240
  %.256 = icmp sgt i32 %.255, 0
  br i1 %.256, label %.252wloop.58.63, label %.253wn63
.252wloop.58.63:
  %.258 = load i32, i32* %.240
  %.259 = sub i32 %.258, 1
  store i32 %.259, i32* %.240
  %.261at60 = call i32 @rand()
  %.263 = srem i32 %.261at60, 300000
  store i32 %.263, i32* %.249
  %.265at61 = call i32 @rand()
  %.266 = srem i32 %.265at