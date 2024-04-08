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
@.g.a = global [30000010 x i32] zeroinitializer
@.g.ans = global i32 zeroinitializer
@__constant..90 = constant [16 x i32] zeroinitializer
@__constant..98 = constant [16 x i32] zeroinitializer
@__constant..102 = constant [16 x i32] zeroinitializer
define i32 @getMaxNum(i32 %.4, i32* %.7){
.2:
  %.12 = alloca i32
  %.9 = alloca i32
  %.6 = alloca i32*
  %.3 = alloca i32
  store i32 %.4, i32* %.3
  store i32* %.7, i32** %.6
  store i32 0, i32* %.9
  store i32 0, i32* %.12
  br label %.14wc6 
.14wc6:
  %.18 = load i32, i32* %.12
  %.19 = load i32, i32* %.3
  %.20 = icmp slt i32 %.18, %.19
  br i1 %.20, label %.15wloop.6.9, label %.16wn9
.15wloop.6.9:
  %.24 = load i32, i32* %.12
  %.25 = load i32*, i32** %.6
  %.26 = getelementptr inbounds i32, i32* %.25, i32 %.24
  %.27 = load i32, i32* %.26
  %.28 = load i32, i32* %.9
  %.29 = icmp sgt i32 %.27, %.28
  br i1 %.29, label %.22, label %.23
.16wn9:
  %.42 = load i32, i32* %.9
  ret i32 %.42 
.22:
  %.31 = load i32, i32* %.12
  %.32 = load i32*, i32** %.6
  %.33 = getelementptr inbounds i32, i32* %.32, i32 %.31
  %.34 = load i32, i32* %.33
  store i32 %.34, i32* %.9
  br label %.23 
.23:
  %.37 = load i32, i32* %.12
  %.39 = add i32 %.37, 1
  store i32 %.39, i32* %.12
  br label %.14wc6 
}
define i32 @getNumPos(i32 %.47, i32 %.50){
.45:
  %.54 = alloca i32
  %.52 = alloca i32
  %.49 = alloca i32
  %.46 = alloca i32
  store i32 %.47, i32* %.46
  store i32 %.50, i32* %.49
  store i32 1, i32* %.52
  store i32 0, i32* %.54
  br label %.56wc16 
.56wc16:
  %.60 = load i32, i32* %.54
  %.61 = load i32, i32* %.49
  %.62 = icmp slt i32 %.60, %.61
  br i1 %.62, label %.57wloop.16.19, label %.58wn19
.57wloop.16.19:
  %.64 = load i32, i32* %.46
  %.65 = sdiv i32 %.64, 16
  store i32 %.65, i32* %.46
  %.67 = load i32, i32* %.54
  %.68 = add i32 %.67, 1
  store i32 %.68, i32* %.54
  br label %.56wc16 
.58wn19:
  %.71 = load i32, i32* %.46
  %.72 = srem i32 %.71, 16
  ret i32 %.72 
}
define void @radixSort(i32 %.77, i32* %.80, i32 %.83, i32 %.86){
.75:
  %.277 = alloca i32
  %.225 = alloca i32
  %.207 = alloca i32
  %.117 = alloca i32
  %.100 = alloca [16 x i32]
  %.96 = alloca [16 x i32]
  %.88 = alloca [16 x i32]
  %.85 = alloca i32
  %.82 = alloca i32
  %.79 = alloca i32*
  %.76 = alloca i32
  store i32 %.77, i32* %.76
  store i32* %.80, i32** %.79
  store i32 %.83, i32* %.82
  store i32 %.86, i32* %.85
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.88, [16 x i32]* @__constant..90, i32 64, i1 false)
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.96, [16 x i32]* @__constant..98, i32 64, i1 false)
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.100, [16 x i32]* @__constant..102, i32 64, i1 false)
  %.107 = load i32, i32* %.76
  %.109 = icmp eq i32 %.107, -1
  br i1 %.109, label %.104, label %.106
.104:
  ret void
.105:
  %.118 = load i32, i32* %.82
  store i32 %.118, i32* %.117
  br label %.120wc33 
.106:
  %.111 = load i32, i32* %.82
  %.112 = add i32 %.111, 1
  %.113 = load i32, i32* %.85
  %.114 = icmp sge i32 %.112, %.113
  br i1 %.114, label %.104, label %.105
.120wc33:
  %.124 = load i32, i32* %.117
  %.125 = load i32, i32* %.85
  %.126 = icmp slt i32 %.124, %.125
  br i1 %.126, label %.121wloop.33.37, label %.122wn37
.121wloop.33.37:
  %.128 = load i32, i32* %.117
  %.129 = load i32*, i32** %.79
  %.130 = getelementptr inbounds i32, i32* %.129, i32 %.128
  %.131 = load i32, i32* %.130
  %.132 = load i32, i32* %.76
  %.133at35 = call i32 @getNumPos(i32 %.131, i32 %.132)
  %.134 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 %.133at35
  %.135 = load i32, i32* %.134
  %.136 = add i32 %.135, 1
  %.137 = load i32, i32* %.117
  %.138 = load i32*, i32** %.79
  %.139 = getelementptr inbounds i32, i32* %.138, i32 %.137
  %.140 = load i32, i32* %.139
  %.141 = load i32, i32* %.76
  %.142at34 = call i32 @getNumPos(i32 %.140, i32 %.141)
  %.143 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 %.142at34
  store i32 %.136, i32* %.143
  %.145 = load i32, i32* %.117
  %.146 = add i32 %.145, 1
  store i32 %.146, i32* %.117
  br label %.120wc33 
.122wn37:
  %.149 = load i32, i32* %.82
  %.150 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 0
  store i32 %.149, i32* %.150
  %.152 = load i32, i32* %.82
  %.153 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 0
  %.154 = load i32, i32* %.153
  %.155 = add i32 %.152, %.154
  %.156 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 0
  store i32 %.155, i32* %.156
  store i32 1, i32* %.117
  br label %.159wc42 
.159wc42:
  %.163 = load i32, i32* %.117
  %.164 = icmp slt i32 %.163, 16
  br i1 %.164, label %.160wloop.42.46, label %.161wn46
.160wloop.42.46:
  %.166 = load i32, i32* %.117
  %.167 = sub i32 %.166, 1
  %.168 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.167
  %.169 = load i32, i32* %.168
  %.170 = load i32, i32* %.117
  %.171 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.170
  store i32 %.169, i32* %.171
  %.173 = load i32, i32* %.117
  %.174 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.173
  %.175 = load i32, i32* %.174
  %.176 = load i32, i32* %.117
  %.177 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 %.176
  %.178 = load i32, i32* %.177
  %.179 = add i32 %.175, %.178
  %.180 = load i32, i32* %.117
  %.181 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.180
  store i32 %.179, i32* %.181
  %.183 = load i32, i32* %.117
  %.184 = add i32 %.183, 1
  store i32 %.184, i32* %.117
  br label %.159wc42 
.161wn46:
  store i32 0, i32* %.117
  br label %.188wc48 
.188wc48:
  %.192 = load i32, i32* %.117
  %.193 = icmp slt i32 %.192, 16
  br i1 %.193, label %.189wloop.48.61, label %.190wn61
.189wloop.48.61:
  br label %.195wc49 
.190wn61:
  %.278 = load i32, i32* %.82
  store i32 %.278, i32* %.277
  %.280 = load i32, i32* %.82
  %.281 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 0
  store i32 %.280, i32* %.281
  %.283 = load i32, i32* %.82
  %.284 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 0
  %.285 = load i32, i32* %.284
  %.286 = add i32 %.283, %.285
  %.287 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 0
  store i32 %.286, i32* %.287
  store i32 0, i32* %.277
  br label %.290wc71 
.195wc49:
  %.199 = load i32, i32* %.117
  %.200 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.199
  %.201 = load i32, i32* %.200
  %.202 = load i32, i32* %.117
  %.203 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.202
  %.204 = load i32, i32* %.203
  %.205 = icmp slt i32 %.201, %.204
  br i1 %.205, label %.196wloop.49.59, label %.197wn59
.196wloop.49.59:
  %.208 = load i32, i32* %.117
  %.209 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.208
  %.210 = load i32, i32* %.209
  %.211 = load i32*, i32** %.79
  %.212 = getelementptr inbounds i32, i32* %.211, i32 %.210
  %.213 = load i32, i32* %.212
  store i32 %.213, i32* %.207
  br label %.215wc51 
.197wn59:
  %.273 = load i32, i32* %.117
  %.274 = add i32 %.273, 1
  store i32 %.274, i32* %.117
  br label %.188wc48 
.215wc51:
  %.219 = load i32, i32* %.207
  %.220 = load i32, i32* %.76
  %.221at51 = call i32 @getNumPos(i32 %.219, i32 %.220)
  %.222 = load i32, i32* %.117
  %.223 = icmp ne i32 %.221at51, %.222
  br i1 %.223, label %.216wloop.51.56, label %.217wn56
.216wloop.51.56:
  %.226 = load i32, i32* %.207
  store i32 %.226, i32* %.225
  %.228 = load i32, i32* %.225
  %.229 = load i32, i32* %.76
  %.230at53 = call i32 @getNumPos(i32 %.228, i32 %.229)
  %.231 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.230at53
  %.232 = load i32, i32* %.231
  %.233 = load i32*, i32** %.79
  %.234 = getelementptr inbounds i32, i32* %.233, i32 %.232
  %.235 = load i32, i32* %.234
  store i32 %.235, i32* %.207
  %.237 = load i32, i32* %.225
  %.238 = load i32, i32* %.225
  %.239 = load i32, i32* %.76
  %.240at54 = call i32 @getNumPos(i32 %.238, i32 %.239)
  %.241 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.240at54
  %.242 = load i32, i32* %.241
  %.243 = load i32*, i32** %.79
  %.244 = getelementptr inbounds i32, i32* %.243, i32 %.242
  store i32 %.237, i32* %.244
  %.246 = load i32, i32* %.225
  %.247 = load i32, i32* %.76
  %.248at55 = call i32 @getNumPos(i32 %.246, i32 %.247)
  %.249 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.248at55
  %.250 = load i32, i32* %.249
  %.251 = add i32 %.250, 1
  %.252 = load i32, i32* %.225
  %.253 = load i32, i32* %.76
  %.254at55 = call i32 @getNumPos(i32 %.252, i32 %.253)
  %.255 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.254at55
  store i32 %.251, i32* %.255
  br label %.215wc51 
.217wn56:
  %.258 = load i32, i32* %.207
  %.259 = load i32, i32* %.117
  %.260 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.259
  %.261 = load i32, i32* %.260
  %.262 = load i32*, i32** %.79
  %.263 = getelementptr inbounds i32, i32* %.262, i32 %.261
  store i32 %.258, i32* %.263
  %.265 = load i32, i32* %.117
  %.266 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.265
  %.267 = load i32, i32* %.266
  %.268 = add i32 %.267, 1
  %.269 = load i32, i32* %.117
  %.270 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.269
  store i32 %.268, i32* %.270
  br label %.195wc49 
.290wc71:
  %.294 = load i32, i32* %.277
  %.295 = icmp slt i32 %.294, 16
  br i1 %.295, label %.291wloop.71.78, label %.292wn78
.291wloop.71.78:
  %.299 = load i32, i32* %.277
  %.300 = icmp sgt i32 %.299, 0
  br i1 %.300, label %.297, label %.298
.292wn78:
  ret void
.297:
  %.302 = load i32, i32* %.277
  %.303 = sub i32 %.302, 1
  %.304 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.303
  %.305 = load i32, i32* %.304
  %.306 = load i32, i32* %.277
  %.307 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.306
  store i32 %.305, i32* %.307
  %.309 = load i32, i32* %.277
  %.310 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.309
  %.311 = load i32, i32* %.310
  %.312 = load i32, i32* %.277
  %.313 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 %.312
  %.314 = load i32, i32* %.313
  %.315 = add i32 %.311, %.314
  %.316 = load i32, i32* %.277
  %.317 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.316
  store i32 %.315, i32* %.317
  br label %.298 
.298:
  %.320 = load i32, i32* %.76
  %.321 = sub i32 %.320, 1
  %.322 = load i32*, i32** %.79
  %.323 = load i32, i32* %.277
  %.324 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.323
  %.325 = load i32, i32* %.324
  %.326 = load i32, i32* %.277
  %.327 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.326
  %.328 = load i32, i32* %.327
  call void @radixSort(i32 %.321, i32* %.322, i32 %.325, i32 %.328)
  %.330 = load i32, i32* %.277
  %.331 = add i32 %.330, 1
  store i32 %.331, i32* %.277
  br label %.290wc71 
}
define i32 @main(){
.339:
  %.352 = alloca i32
  %.340 = alloca i32
  %.341 = getelementptr inbounds [30000010 x i32], [30000010 x i32]* @.g.a, i32 0, i32 0
  %.343at88 = call i32 @getarray(i32* %.341)
  store i32 %.343at88, i32* %.340
  call void @_sysy_starttime(i32 90)
  %.349 = getelementptr inbounds [30000010 x i32], [30000010 x i32]* @.g.a, i32 0, i32 0
  %.350 = load i32, i32* %.340
  call void @radixSort(i32 8, i32* %.349, i32 0, i32 %.350)
  store i32 0, i32* %.352
  br label %.354wc95 
.354wc95:
  %.358 = load i32, i32* %.352
  %.359 = load i32, i32* %.340
  %.360 = icmp slt i32 %.358, %.359
  br i1 %.360, label %.355wloop.95.98, label %.356wn98
.355wloop.95.98:
  %.362 = load i32, i32* @.g.ans
  %.363 = load i32, i32* %.352
  %.364 = load i32, i32* %.352
  %.365 = getelementptr inbounds [30000010 x i32], [30000010 x i32]* @.g.a, i32 0, i32 %.364
  %.366 = load i32, i32* %.365
  %.368 = load i32, i32* %.352
  %.369 = add i32 2, %.368
  %.370 = srem i32 %.366, %.369
  %.371 = mul i32 %.363, %.370
  %.372 = add i32 %.362, %.371
  store i32 %.372, i32* @.g.ans
  %.374 = load i32, i32* %.352
  %.375 = add i32 %.374, 1
  store i32 %.375, i32* %.352
  br label %.354wc95 
.356wn98:
  %.380 = load i32, i32* @.g.ans
  %.381 = icmp slt i32 %.380, 0
  br i1 %.381, label %.378, label %.379
.378:
  %.383 = load i32, i32* @.g.ans
  %.384 = sub i32 0, %.383
  store i32 %.384, i32* @.g.ans
  br label %.379 
.379:
  call void @_sysy_stoptime(i32 102)
  %.390 = load i32, i32* @.g.ans
  call void @putint(i32 %.390)
  call void @putch(i32 10)
  ret i32 0 
}
@.g.a = global [30000010 x i32] zeroinitializer
@.g.ans = global i32 zeroinitializer
@__constant..90 = constant [16 x i32] zeroinitializer
@__constant..98 = constant [16 x i32] zeroinitializer
@__constant..102 = constant [16 x i32] zeroinitializer
define i32 @getMaxNum(i32 %.4, i32* %.7){
.2:
  %.12 = alloca i32
  %.9 = alloca i32
  %.6 = alloca i32*
  %.3 = alloca i32
  store i32 %.4, i32* %.3
  store i32* %.7, i32** %.6
  store i32 0, i32* %.9
  store i32 0, i32* %.12
  br label %.14wc6 
.14wc6:
  %.18 = load i32, i32* %.12
  %.19 = load i32, i32* %.3
  %.20 = icmp slt i32 %.18, %.19
  br i1 %.20, label %.15wloop.6.9, label %.16wn9
.15wloop.6.9:
  %.24 = load i32, i32* %.12
  %.25 = load i32*, i32** %.6
  %.26 = getelementptr inbounds i32, i32* %.25, i32 %.24
  %.27 = load i32, i32* %.26
  %.28 = load i32, i32* %.9
  %.29 = icmp sgt i32 %.27, %.28
  br i1 %.29, label %.22, label %.23
.16wn9:
  %.42 = load i32, i32* %.9
  ret i32 %.42 
.22:
  %.31 = load i32, i32* %.12
  %.32 = load i32*, i32** %.6
  %.33 = getelementptr inbounds i32, i32* %.32, i32 %.31
  %.34 = load i32, i32* %.33
  store i32 %.34, i32* %.9
  br label %.23 
.23:
  %.37 = load i32, i32* %.12
  %.39 = add i32 %.37, 1
  store i32 %.39, i32* %.12
  br label %.14wc6 
}
define i32 @getNumPos(i32 %.47, i32 %.50){
.45:
  %.54 = alloca i32
  %.52 = alloca i32
  %.49 = alloca i32
  %.46 = alloca i32
  store i32 %.47, i32* %.46
  store i32 %.50, i32* %.49
  store i32 1, i32* %.52
  store i32 0, i32* %.54
  br label %.56wc16 
.56wc16:
  %.60 = load i32, i32* %.54
  %.61 = load i32, i32* %.49
  %.62 = icmp slt i32 %.60, %.61
  br i1 %.62, label %.57wloop.16.19, label %.58wn19
.57wloop.16.19:
  %.64 = load i32, i32* %.46
  %.65 = sdiv i32 %.64, 16
  store i32 %.65, i32* %.46
  %.67 = load i32, i32* %.54
  %.68 = add i32 %.67, 1
  store i32 %.68, i32* %.54
  br label %.56wc16 
.58wn19:
  %.71 = load i32, i32* %.46
  %.72 = srem i32 %.71, 16
  ret i32 %.72 
}
define void @radixSort(i32 %.77, i32* %.80, i32 %.83, i32 %.86){
.75:
  %.277 = alloca i32
  %.225 = alloca i32
  %.207 = alloca i32
  %.117 = alloca i32
  %.100 = alloca [16 x i32]
  %.96 = alloca [16 x i32]
  %.88 = alloca [16 x i32]
  %.85 = alloca i32
  %.82 = alloca i32
  %.79 = alloca i32*
  %.76 = alloca i32
  store i32 %.77, i32* %.76
  store i32* %.80, i32** %.79
  store i32 %.83, i32* %.82
  store i32 %.86, i32* %.85
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.88, [16 x i32]* @__constant..90, i32 64, i1 false)
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.96, [16 x i32]* @__constant..98, i32 64, i1 false)
  call void @llvm.memcpy.p0.p0.i32([16 x i32]* %.100, [16 x i32]* @__constant..102, i32 64, i1 false)
  %.107 = load i32, i32* %.76
  %.109 = icmp eq i32 %.107, -1
  br i1 %.109, label %.104, label %.106
.104:
  ret void
.105:
  %.118 = load i32, i32* %.82
  store i32 %.118, i32* %.117
  br label %.120wc33 
.106:
  %.111 = load i32, i32* %.82
  %.112 = add i32 %.111, 1
  %.113 = load i32, i32* %.85
  %.114 = icmp sge i32 %.112, %.113
  br i1 %.114, label %.104, label %.105
.120wc33:
  %.124 = load i32, i32* %.117
  %.125 = load i32, i32* %.85
  %.126 = icmp slt i32 %.124, %.125
  br i1 %.126, label %.121wloop.33.37, label %.122wn37
.121wloop.33.37:
  %.128 = load i32, i32* %.117
  %.129 = load i32*, i32** %.79
  %.130 = getelementptr inbounds i32, i32* %.129, i32 %.128
  %.131 = load i32, i32* %.130
  %.132 = load i32, i32* %.76
  %.133at35 = call i32 @getNumPos(i32 %.131, i32 %.132)
  %.134 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 %.133at35
  %.135 = load i32, i32* %.134
  %.136 = add i32 %.135, 1
  %.137 = load i32, i32* %.117
  %.138 = load i32*, i32** %.79
  %.139 = getelementptr inbounds i32, i32* %.138, i32 %.137
  %.140 = load i32, i32* %.139
  %.141 = load i32, i32* %.76
  %.142at34 = call i32 @getNumPos(i32 %.140, i32 %.141)
  %.143 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 %.142at34
  store i32 %.136, i32* %.143
  %.145 = load i32, i32* %.117
  %.146 = add i32 %.145, 1
  store i32 %.146, i32* %.117
  br label %.120wc33 
.122wn37:
  %.149 = load i32, i32* %.82
  %.150 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 0
  store i32 %.149, i32* %.150
  %.152 = load i32, i32* %.82
  %.153 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 0
  %.154 = load i32, i32* %.153
  %.155 = add i32 %.152, %.154
  %.156 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 0
  store i32 %.155, i32* %.156
  store i32 1, i32* %.117
  br label %.159wc42 
.159wc42:
  %.163 = load i32, i32* %.117
  %.164 = icmp slt i32 %.163, 16
  br i1 %.164, label %.160wloop.42.46, label %.161wn46
.160wloop.42.46:
  %.166 = load i32, i32* %.117
  %.167 = sub i32 %.166, 1
  %.168 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.167
  %.169 = load i32, i32* %.168
  %.170 = load i32, i32* %.117
  %.171 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.170
  store i32 %.169, i32* %.171
  %.173 = load i32, i32* %.117
  %.174 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.173
  %.175 = load i32, i32* %.174
  %.176 = load i32, i32* %.117
  %.177 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 %.176
  %.178 = load i32, i32* %.177
  %.179 = add i32 %.175, %.178
  %.180 = load i32, i32* %.117
  %.181 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.180
  store i32 %.179, i32* %.181
  %.183 = load i32, i32* %.117
  %.184 = add i32 %.183, 1
  store i32 %.184, i32* %.117
  br label %.159wc42 
.161wn46:
  store i32 0, i32* %.117
  br label %.188wc48 
.188wc48:
  %.192 = load i32, i32* %.117
  %.193 = icmp slt i32 %.192, 16
  br i1 %.193, label %.189wloop.48.61, label %.190wn61
.189wloop.48.61:
  br label %.195wc49 
.190wn61:
  %.278 = load i32, i32* %.82
  store i32 %.278, i32* %.277
  %.280 = load i32, i32* %.82
  %.281 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 0
  store i32 %.280, i32* %.281
  %.283 = load i32, i32* %.82
  %.284 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 0
  %.285 = load i32, i32* %.284
  %.286 = add i32 %.283, %.285
  %.287 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 0
  store i32 %.286, i32* %.287
  store i32 0, i32* %.277
  br label %.290wc71 
.195wc49:
  %.199 = load i32, i32* %.117
  %.200 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.199
  %.201 = load i32, i32* %.200
  %.202 = load i32, i32* %.117
  %.203 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.202
  %.204 = load i32, i32* %.203
  %.205 = icmp slt i32 %.201, %.204
  br i1 %.205, label %.196wloop.49.59, label %.197wn59
.196wloop.49.59:
  %.208 = load i32, i32* %.117
  %.209 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.208
  %.210 = load i32, i32* %.209
  %.211 = load i32*, i32** %.79
  %.212 = getelementptr inbounds i32, i32* %.211, i32 %.210
  %.213 = load i32, i32* %.212
  store i32 %.213, i32* %.207
  br label %.215wc51 
.197wn59:
  %.273 = load i32, i32* %.117
  %.274 = add i32 %.273, 1
  store i32 %.274, i32* %.117
  br label %.188wc48 
.215wc51:
  %.219 = load i32, i32* %.207
  %.220 = load i32, i32* %.76
  %.221at51 = call i32 @getNumPos(i32 %.219, i32 %.220)
  %.222 = load i32, i32* %.117
  %.223 = icmp ne i32 %.221at51, %.222
  br i1 %.223, label %.216wloop.51.56, label %.217wn56
.216wloop.51.56:
  %.226 = load i32, i32* %.207
  store i32 %.226, i32* %.225
  %.228 = load i32, i32* %.225
  %.229 = load i32, i32* %.76
  %.230at53 = call i32 @getNumPos(i32 %.228, i32 %.229)
  %.231 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.230at53
  %.232 = load i32, i32* %.231
  %.233 = load i32*, i32** %.79
  %.234 = getelementptr inbounds i32, i32* %.233, i32 %.232
  %.235 = load i32, i32* %.234
  store i32 %.235, i32* %.207
  %.237 = load i32, i32* %.225
  %.238 = load i32, i32* %.225
  %.239 = load i32, i32* %.76
  %.240at54 = call i32 @getNumPos(i32 %.238, i32 %.239)
  %.241 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.240at54
  %.242 = load i32, i32* %.241
  %.243 = load i32*, i32** %.79
  %.244 = getelementptr inbounds i32, i32* %.243, i32 %.242
  store i32 %.237, i32* %.244
  %.246 = load i32, i32* %.225
  %.247 = load i32, i32* %.76
  %.248at55 = call i32 @getNumPos(i32 %.246, i32 %.247)
  %.249 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.248at55
  %.250 = load i32, i32* %.249
  %.251 = add i32 %.250, 1
  %.252 = load i32, i32* %.225
  %.253 = load i32, i32* %.76
  %.254at55 = call i32 @getNumPos(i32 %.252, i32 %.253)
  %.255 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.254at55
  store i32 %.251, i32* %.255
  br label %.215wc51 
.217wn56:
  %.258 = load i32, i32* %.207
  %.259 = load i32, i32* %.117
  %.260 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.259
  %.261 = load i32, i32* %.260
  %.262 = load i32*, i32** %.79
  %.263 = getelementptr inbounds i32, i32* %.262, i32 %.261
  store i32 %.258, i32* %.263
  %.265 = load i32, i32* %.117
  %.266 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.265
  %.267 = load i32, i32* %.266
  %.268 = add i32 %.267, 1
  %.269 = load i32, i32* %.117
  %.270 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.269
  store i32 %.268, i32* %.270
  br label %.195wc49 
.290wc71:
  %.294 = load i32, i32* %.277
  %.295 = icmp slt i32 %.294, 16
  br i1 %.295, label %.291wloop.71.78, label %.292wn78
.291wloop.71.78:
  %.299 = load i32, i32* %.277
  %.300 = icmp sgt i32 %.299, 0
  br i1 %.300, label %.297, label %.298
.292wn78:
  ret void
.297:
  %.302 = load i32, i32* %.277
  %.303 = sub i32 %.302, 1
  %.304 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.303
  %.305 = load i32, i32* %.304
  %.306 = load i32, i32* %.277
  %.307 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.306
  store i32 %.305, i32* %.307
  %.309 = load i32, i32* %.277
  %.310 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.309
  %.311 = load i32, i32* %.310
  %.312 = load i32, i32* %.277
  %.313 = getelementptr inbounds [16 x i32], [16 x i32]* %.100, i32 0, i32 %.312
  %.314 = load i32, i32* %.313
  %.315 = add i32 %.311, %.314
  %.316 = load i32, i32* %.277
  %.317 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.316
  store i32 %.315, i32* %.317
  br label %.298 
.298:
  %.320 = load i32, i32* %.76
  %.321 = sub i32 %.320, 1
  %.322 = load i32*, i32** %.79
  %.323 = load i32, i32* %.277
  %.324 = getelementptr inbounds [16 x i32], [16 x i32]* %.88, i32 0, i32 %.323
  %.325 = load i32, i32* %.324
  %.326 = load i32, i32* %.277
  %.327 = getelementptr inbounds [16 x i32], [16 x i32]* %.96, i32 0, i32 %.326
  %.328 = load i32, i32* %.327
  call void @radixSort(i32 %.321, i32* %.322, i32 %.325, i32 %.328)
  %.330 = load i32, i32* %.277
  %.331 = add i32 %.330, 1
  store i32 %.331, i32* %.277
  br label %.290wc71 
}
define i32 @main(){
.339:
  %.352 = alloca i32
  %.340 = alloca i32
  %.341 = getelementptr inbounds [30000010 x i32], [30000010 x i32]* @.g.a, i32 0, i32 0
  %.343at88 = call i32 @getarray(i32* %.341)
  store i32 %.343at88, i32* %.340
  call void @_sysy_starttime(i32 90)
  %.349 = getelementptr inbounds [30000010 x i32], [30000010 x i32]* @.g.a, i32 0, i32 0
  %.350 = load i32, i32* %.340
  call void @radixSort(i32 8, i32* %.349, i32 0, i32 %.350)
  store i32 0, i32* %.352
  br label %.354wc95 
.354wc95:
  %.358 = load i32, i32* %.352
  %.359 = load i32, i32* %.340
  %.360 = icmp slt i32 %.358, %.359
  br i1 %.360, label %.355wloop.95.98, label %.356wn98
.355wloop.95.98:
  %.362 = load i32, i32* @.g.ans
  %.363 = load i32, i32* %.352
  %.364 = load i32, i32* %.352
  %.365 = getelementptr inbounds [30000010 x i32], [30000010 x i32]* @.g.a, i32 0, i32 %.364
  %.366 = load i32, i32* %.365
  %.368 = load i32, i32* %.352
  %.369 = add i32 2, %.368
  %.370 = srem i32 %.366, %.369
  %.371 = mul i32 %.363, %.370
  %.372 = add i32 %.362, %.371
  store i32 %.372, i32* @.g.ans
  %.374 = load i32, i32* %.352
  %.375 = add i32 %.374, 1
  store i32 %.375, i32* %.352
  br label %.354wc95 
.356wn98:
  %.380 = load i32, i32* @.g.ans
  %.381 = icmp slt i32 %.380, 0
  br i1 %.381, label %.378, label %.379
.378:
  %.383 = load i32, i32* @.g.ans
  %.384 = sub i32 0, %.383
  store i32 %.384, i32* @.g.ans
  br label %.379 
.379:
  call 