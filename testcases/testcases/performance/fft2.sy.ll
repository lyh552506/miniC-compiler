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
@.g.d = global i32 zeroinitializer
@.g.temp = global [2097152 x i32] zeroinitializer
@.g.a = global [2097152 x i32] zeroinitializer
@.g.b = global [2097152 x i32] zeroinitializer
@.g.c = global [2097152 x i32] zeroinitializer
define i32 @multiply(i32 %.5, i32 %.8){
.3:
  %.26 = alloca i32
  %.7 = alloca i32
  %.4 = alloca i32
  store i32 %.5, i32* %.4
  store i32 %.8, i32* %.7
  %.12 = load i32, i32* %.7
  %.14 = icmp eq i32 %.12, 0
  br i1 %.14, label %.10, label %.11
.10:
  ret i32 0 
.11:
  %.19 = load i32, i32* %.7
  %.21 = icmp eq i32 %.19, 1
  br i1 %.21, label %.17, label %.18
.17:
  %.23 = load i32, i32* %.4
  %.24 = srem i32 %.23, 998244353
  ret i32 %.24 
.18:
  %.27 = load i32, i32* %.4
  %.28 = load i32, i32* %.7
  %.30 = sdiv i32 %.28, 2
  %.31at7 = call i32 @multiply(i32 %.27, i32 %.30)
  store i32 %.31at7, i32* %.26
  %.33 = load i32, i32* %.26
  %.34 = load i32, i32* %.26
  %.35 = add i32 %.33, %.34
  %.36 = srem i32 %.35, 998244353
  store i32 %.36, i32* %.26
  %.40 = load i32, i32* %.7
  %.41 = srem i32 %.40, 2
  %.42 = icmp eq i32 %.41, 1
  br i1 %.42, label %.38, label %.39
.38:
  %.44 = load i32, i32* %.26
  %.45 = load i32, i32* %.4
  %.46 = add i32 %.44, %.45
  %.47 = srem i32 %.46, 998244353
  ret i32 %.47 
.39:
  %.49 = load i32, i32* %.26
  ret i32 %.49 
}
define i32 @power(i32 %.54, i32 %.57){
.52:
  %.65 = alloca i32
  %.56 = alloca i32
  %.53 = alloca i32
  store i32 %.54, i32* %.53
  store i32 %.57, i32* %.56
  %.61 = load i32, i32* %.56
  %.62 = icmp eq i32 %.61, 0
  br i1 %.62, label %.59, label %.60
.59:
  ret i32 1 
.60:
  %.66 = load i32, i32* %.53
  %.67 = load i32, i32* %.56
  %.68 = sdiv i32 %.67, 2
  %.69at15 = call i32 @power(i32 %.66, i32 %.68)
  store i32 %.69at15, i32* %.65
  %.71 = load i32, i32* %.65
  %.72 = load i32, i32* %.65
  %.73at16 = call i32 @multiply(i32 %.71, i32 %.72)
  store i32 %.73at16, i32* %.65
  %.77 = load i32, i32* %.56
  %.78 = srem i32 %.77, 2
  %.79 = icmp eq i32 %.78, 1
  br i1 %.79, label %.75, label %.76
.75:
  %.81 = load i32, i32* %.65
  %.82 = load i32, i32* %.53
  %.83at17 = call i32 @multiply(i32 %.81, i32 %.82)
  ret i32 %.83at17 
.76:
  %.85 = load i32, i32* %.65
  ret i32 %.85 
}
define i32 @memmove(i32* %.95, i32 %.98, i32* %.101, i32 %.104){
.93:
  %.106 = alloca i32
  %.103 = alloca i32
  %.100 = alloca i32*
  %.97 = alloca i32
  %.94 = alloca i32*
  store i32* %.95, i32** %.94
  store i32 %.98, i32* %.97
  store i32* %.101, i32** %.100
  store i32 %.104, i32* %.103
  store i32 0, i32* %.106
  br label %.108wc25 
.108wc25:
  %.112 = load i32, i32* %.106
  %.113 = load i32, i32* %.103
  %.114 = icmp slt i32 %.112, %.113
  br i1 %.114, label %.109wloop.25.28, label %.110wn28
.109wloop.25.28:
  %.116 = load i32, i32* %.106
  %.117 = load i32*, i32** %.100
  %.118 = getelementptr inbounds i32, i32* %.117, i32 %.116
  %.119 = load i32, i32* %.118
  %.120 = load i32, i32* %.97
  %.121 = load i32, i32* %.106
  %.122 = add i32 %.120, %.121
  %.123 = load i32*, i32** %.94
  %.124 = getelementptr inbounds i32, i32* %.123, i32 %.122
  store i32 %.119, i32* %.124
  %.126 = load i32, i32* %.106
  %.127 = add i32 %.126, 1
  store i32 %.127, i32* %.106
  br label %.108wc25 
.110wn28:
  %.130 = load i32, i32* %.106
  ret i32 %.130 
}
define i32 @fft(i32* %.135, i32 %.138, i32 %.141, i32 %.144){
.133:
  %.242 = alloca i32
  %.234 = alloca i32
  %.223 = alloca i32
  %.152 = alloca i32
  %.143 = alloca i32
  %.140 = alloca i32
  %.137 = alloca i32
  %.134 = alloca i32*
  store i32* %.135, i32** %.134
  store i32 %.138, i32* %.137
  store i32 %.141, i32* %.140
  store i32 %.144, i32* %.143
  %.148 = load i32, i32* %.140
  %.149 = icmp eq i32 %.148, 1
  br i1 %.149, label %.146, label %.147
.146:
  ret i32 1 
.147:
  store i32 0, i32* %.152
  br label %.154wc35 
.154wc35:
  %.158 = load i32, i32* %.152
  %.159 = load i32, i32* %.140
  %.160 = icmp slt i32 %.158, %.159
  br i1 %.160, label %.155wloop.35.39, label %.156wn39
.155wloop.35.39:
  %.164 = load i32, i32* %.152
  %.165 = srem i32 %.164, 2
  %.166 = icmp eq i32 %.165, 0
  br i1 %.166, label %.162, label %.163
.156wn39:
  %.198 = load i32*, i32** %.134
  %.199 = load i32, i32* %.137
  %.200 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.temp, i32 0, i32 0
  %.201 = load i32, i32* %.140
  %.202at41 = call i32 @memmove(i32* %.198, i32 %.199, i32* %.200, i32 %.201)
  %.203 = load i32*, i32** %.134
  %.204 = load i32, i32* %.137
  %.205 = load i32, i32* %.140
  %.206 = sdiv i32 %.205, 2
  %.207 = load i32, i32* %.143
  %.208 = load i32, i32* %.143
  %.209at42 = call i32 @multiply(i32 %.207, i32 %.208)
  %.210at42 = call i32 @fft(i32* %.203, i32 %.204, i32 %.206, i32 %.209at42)
  %.211 = load i32*, i32** %.134
  %.212 = load i32, i32* %.137
  %.213 = load i32, i32* %.140
  %.214 = sdiv i32 %.213, 2
  %.215 = add i32 %.212, %.214
  %.216 = load i32, i32* %.140
  %.217 = sdiv i32 %.216, 2
  %.218 = load i32, i32* %.143
  %.219 = load i32, i32* %.143
  %.220at43 = call i32 @multiply(i32 %.218, i32 %.219)
  %.221at43 = call i32 @fft(i32* %.211, i32 %.215, i32 %.217, i32 %.220at43)
  store i32 0, i32* %.152
  store i32 1, i32* %.223
  br label %.225wc46 
.162:
  %.168 = load i32, i32* %.152
  %.169 = load i32, i32* %.137
  %.170 = add i32 %.168, %.169
  %.171 = load i32*, i32** %.134
  %.172 = getelementptr inbounds i32, i32* %.171, i32 %.170
  %.173 = load i32, i32* %.172
  %.174 = load i32, i32* %.152
  %.175 = sdiv i32 %.174, 2
  %.176 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.temp, i32 0, i32 %.175
  store i32 %.173, i32* %.176
  br label %.178 
.163:
  %.180 = load i32, i32* %.152
  %.181 = load i32, i32* %.137
  %.182 = add i32 %.180, %.181
  %.183 = load i32*, i32** %.134
  %.184 = getelementptr inbounds i32, i32* %.183, i32 %.182
  %.185 = load i32, i32* %.184
  %.186 = load i32, i32* %.140
  %.187 = sdiv i32 %.186, 2
  %.188 = load i32, i32* %.152
  %.189 = sdiv i32 %.188, 2
  %.190 = add i32 %.187, %.189
  %.191 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.temp, i32 0, i32 %.190
  store i32 %.185, i32* %.191
  br label %.178 
.178:
  %.194 = load i32, i32* %.152
  %.195 = add i32 %.194, 1
  store i32 %.195, i32* %.152
  br label %.154wc35 
.225wc46:
  %.229 = load i32, i32* %.152
  %.230 = load i32, i32* %.140
  %.231 = sdiv i32 %.230, 2
  %.232 = icmp slt i32 %.229, %.231
  br i1 %.232, label %.226wloop.46.53, label %.227wn53
.226wloop.46.53:
  %.235 = load i32, i32* %.137
  %.236 = load i32, i32* %.152
  %.237 = add i32 %.235, %.236
  %.238 = load i32*, i32** %.134
  %.239 = getelementptr inbounds i32, i32* %.238, i32 %.237
  %.240 = load i32, i32* %.239
  store i32 %.240, i32* %.234
  %.243 = load i32, i32* %.137
  %.244 = load i32, i32* %.152
  %.245 = add i32 %.243, %.244
  %.246 = load i32, i32* %.140
  %.247 = sdiv i32 %.246, 2
  %.248 = add i32 %.245, %.247
  %.249 = load i32*, i32** %.134
  %.250 = getelementptr inbounds i32, i32* %.249, i32 %.248
  %.251 = load i32, i32* %.250
  store i32 %.251, i32* %.242
  %.253 = load i32, i32* %.234
  %.254 = load i32, i32* %.223
  %.255 = load i32, i32* %.242
  %.256at49 = call i32 @multiply(i32 %.254, i32 %.255)
  %.257 = add i32 %.253, %.256at49
  %.258 = srem i32 %.257, 998244353
  %.259 = load i32, i32* %.137
  %.260 = load i32, i32* %.152
  %.261 = add i32 %.259, %.260
  %.262 = load i32*, i32** %.134
  %.263 = getelementptr inbounds i32, i32* %.262, i32 %.261
  store i32 %.258, i32* %.263
  %.265 = load i32, i32* %.234
  %.266 = load i32, i32* %.223
  %.267 = load i32, i32* %.242
  %.268at50 = call i32 @multiply(i32 %.266, i32 %.267)
  %.269 = sub i32 %.265, %.268at50
  %.270 = add i32 %.269, 998244353
  %.271 = srem i32 %.270, 998244353
  %.272 = load i32, i32* %.137
  %.273 = load i32, i32* %.152
  %.274 = add i32 %.272, %.273
  %.275 = load i32, i32* %.140
  %.276 = sdiv i32 %.275, 2
  %.277 = add i32 %.274, %.276
  %.278 = load i32*, i32** %.134
  %.279 = getelementptr inbounds i32, i32* %.278, i32 %.277
  store i32 %.271, i32* %.279
  %.281 = load i32, i32* %.223
  %.282 = load i32, i32* %.143
  %.283at51 = call i32 @multiply(i32 %.281, i32 %.282)
  store i32 %.283at51, i32* %.223
  %.285 = load i32, i32* %.152
  %.286 = add i32 %.285, 1
  store i32 %.286, i32* %.152
  br label %.225wc46 
.227wn53:
  ret i32 0 
}
define i32 @main(){
.291:
  %.334 = alloca i32
  %.297 = alloca i32
  %.292 = alloca i32
  %.293 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 0
  %.295at58 = call i32 @getarray(i32* %.293)
  store i32 %.295at58, i32* %.292
  %.298 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.b, i32 0, i32 0
  %.299at59 = call i32 @getarray(i32* %.298)
  store i32 %.299at59, i32* %.297
  call void @_sysy_starttime(i32 60)
  store i32 1, i32* @.g.d
  br label %.305wc62 
.305wc62:
  %.309 = load i32, i32* @.g.d
  %.310 = load i32, i32* %.292
  %.311 = load i32, i32* %.297
  %.312 = add i32 %.310, %.311
  %.313 = sub i32 %.312, 1
  %.314 = icmp slt i32 %.309, %.313
  br i1 %.314, label %.306wloop.62.64, label %.307wn64
.306wloop.62.64:
  %.316 = load i32, i32* @.g.d
  %.317 = mul i32 %.316, 2
  store i32 %.317, i32* @.g.d
  br label %.305wc62 
.307wn64:
  %.320 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 0
  %.321 = load i32, i32* @.g.d
  %.324 = load i32, i32* @.g.d
  %.325 = sdiv i32 998244352, %.324
  %.326at65 = call i32 @power(i32 3, i32 %.325)
  %.327at65 = call i32 @fft(i32* %.320, i32 0, i32 %.321, i32 %.326at65)
  %.328 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.b, i32 0, i32 0
  %.329 = load i32, i32* @.g.d
  %.330 = load i32, i32* @.g.d
  %.331 = sdiv i32 998244352, %.330
  %.332at66 = call i32 @power(i32 3, i32 %.331)
  %.333at66 = call i32 @fft(i32* %.328, i32 0, i32 %.329, i32 %.332at66)
  store i32 0, i32* %.334
  br label %.336wc69 
.336wc69:
  %.340 = load i32, i32* %.334
  %.341 = load i32, i32* @.g.d
  %.342 = icmp slt i32 %.340, %.341
  br i1 %.342, label %.337wloop.69.72, label %.338wn72
.337wloop.69.72:
  %.344 = load i32, i32* %.334
  %.345 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 %.344
  %.346 = load i32, i32* %.345
  %.347 = load i32, i32* %.334
  %.348 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.b, i32 0, i32 %.347
  %.349 = load i32, i32* %.348
  %.350at70 = call i32 @multiply(i32 %.346, i32 %.349)
  %.351 = load i32, i32* %.334
  %.352 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 %.351
  store i32 %.350at70, i32* %.352
  %.354 = load i32, i32* %.334
  %.355 = add i32 %.354, 1
  store i32 %.355, i32* %.334
  br label %.336wc69 
.338wn72:
  %.358 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 0
  %.359 = load i32, i32* @.g.d
  %.360 = load i32, i32* @.g.d
  %.361 = sdiv i32 998244352, %.360
  %.362 = sub i32 998244352, %.361
  %.363at73 = call i32 @power(i32 3, i32 %.362)
  %.364at73 = call i32 @fft(i32* %.358, i32 0, i32 %.359, i32 %.363at73)
  store i32 0, i32* %.334
  br label %.366wc75 
.366wc75:
  %.370 = load i32, i32* %.334
  %.371 = load i32, i32* @.g.d
  %.372 = icmp slt i32 %.370, %.371
  br i1 %.372, label %.367wloop.75.78, label %.368wn78
.367wloop.75.78:
  %.374 = load i32, i32* %.334
  %.375 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 %.374
  %.376 = load i32, i32* %.375
  %.377 = load i32, i32* @.g.d
  %.379at76 = call i32 @power(i32 %.377, i32 998244351)
  %.380at76 = call i32 @multiply(i32 %.376, i32 %.379at76)
  %.381 = load i32, i32* %.334
  %.382 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 %.381
  store i32 %.380at76, i32* %.382
  %.384 = load i32, i32* %.334
  %.385 = add i32 %.384, 1
  store i32 %.385, i32* %.334
  br label %.366wc75 
.368wn78:
  call void @_sysy_stoptime(i32 79)
  %.391 = load i32, i32* %.292
  %.392 = load i32, i32* %.297
  %.393 = add i32 %.391, %.392
  %.394 = sub i32 %.393, 1
  %.395 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 0
  call void @putarray(i32 %.394, i32* %.395)
  ret i32 0 
}
@.g.d = global i32 zeroinitializer
@.g.temp = global [2097152 x i32] zeroinitializer
@.g.a = global [2097152 x i32] zeroinitializer
@.g.b = global [2097152 x i32] zeroinitializer
@.g.c = global [2097152 x i32] zeroinitializer
define i32 @multiply(i32 %.5, i32 %.8){
.3:
  %.26 = alloca i32
  %.7 = alloca i32
  %.4 = alloca i32
  store i32 %.5, i32* %.4
  store i32 %.8, i32* %.7
  %.12 = load i32, i32* %.7
  %.14 = icmp eq i32 %.12, 0
  br i1 %.14, label %.10, label %.11
.10:
  ret i32 0 
.11:
  %.19 = load i32, i32* %.7
  %.21 = icmp eq i32 %.19, 1
  br i1 %.21, label %.17, label %.18
.17:
  %.23 = load i32, i32* %.4
  %.24 = srem i32 %.23, 998244353
  ret i32 %.24 
.18:
  %.27 = load i32, i32* %.4
  %.28 = load i32, i32* %.7
  %.30 = sdiv i32 %.28, 2
  %.31at7 = call i32 @multiply(i32 %.27, i32 %.30)
  store i32 %.31at7, i32* %.26
  %.33 = load i32, i32* %.26
  %.34 = load i32, i32* %.26
  %.35 = add i32 %.33, %.34
  %.36 = srem i32 %.35, 998244353
  store i32 %.36, i32* %.26
  %.40 = load i32, i32* %.7
  %.41 = srem i32 %.40, 2
  %.42 = icmp eq i32 %.41, 1
  br i1 %.42, label %.38, label %.39
.38:
  %.44 = load i32, i32* %.26
  %.45 = load i32, i32* %.4
  %.46 = add i32 %.44, %.45
  %.47 = srem i32 %.46, 998244353
  ret i32 %.47 
.39:
  %.49 = load i32, i32* %.26
  ret i32 %.49 
}
define i32 @power(i32 %.54, i32 %.57){
.52:
  %.65 = alloca i32
  %.56 = alloca i32
  %.53 = alloca i32
  store i32 %.54, i32* %.53
  store i32 %.57, i32* %.56
  %.61 = load i32, i32* %.56
  %.62 = icmp eq i32 %.61, 0
  br i1 %.62, label %.59, label %.60
.59:
  ret i32 1 
.60:
  %.66 = load i32, i32* %.53
  %.67 = load i32, i32* %.56
  %.68 = sdiv i32 %.67, 2
  %.69at15 = call i32 @power(i32 %.66, i32 %.68)
  store i32 %.69at15, i32* %.65
  %.71 = load i32, i32* %.65
  %.72 = load i32, i32* %.65
  %.73at16 = call i32 @multiply(i32 %.71, i32 %.72)
  store i32 %.73at16, i32* %.65
  %.77 = load i32, i32* %.56
  %.78 = srem i32 %.77, 2
  %.79 = icmp eq i32 %.78, 1
  br i1 %.79, label %.75, label %.76
.75:
  %.81 = load i32, i32* %.65
  %.82 = load i32, i32* %.53
  %.83at17 = call i32 @multiply(i32 %.81, i32 %.82)
  ret i32 %.83at17 
.76:
  %.85 = load i32, i32* %.65
  ret i32 %.85 
}
define i32 @memmove(i32* %.95, i32 %.98, i32* %.101, i32 %.104){
.93:
  %.106 = alloca i32
  %.103 = alloca i32
  %.100 = alloca i32*
  %.97 = alloca i32
  %.94 = alloca i32*
  store i32* %.95, i32** %.94
  store i32 %.98, i32* %.97
  store i32* %.101, i32** %.100
  store i32 %.104, i32* %.103
  store i32 0, i32* %.106
  br label %.108wc25 
.108wc25:
  %.112 = load i32, i32* %.106
  %.113 = load i32, i32* %.103
  %.114 = icmp slt i32 %.112, %.113
  br i1 %.114, label %.109wloop.25.28, label %.110wn28
.109wloop.25.28:
  %.116 = load i32, i32* %.106
  %.117 = load i32*, i32** %.100
  %.118 = getelementptr inbounds i32, i32* %.117, i32 %.116
  %.119 = load i32, i32* %.118
  %.120 = load i32, i32* %.97
  %.121 = load i32, i32* %.106
  %.122 = add i32 %.120, %.121
  %.123 = load i32*, i32** %.94
  %.124 = getelementptr inbounds i32, i32* %.123, i32 %.122
  store i32 %.119, i32* %.124
  %.126 = load i32, i32* %.106
  %.127 = add i32 %.126, 1
  store i32 %.127, i32* %.106
  br label %.108wc25 
.110wn28:
  %.130 = load i32, i32* %.106
  ret i32 %.130 
}
define i32 @fft(i32* %.135, i32 %.138, i32 %.141, i32 %.144){
.133:
  %.242 = alloca i32
  %.234 = alloca i32
  %.223 = alloca i32
  %.152 = alloca i32
  %.143 = alloca i32
  %.140 = alloca i32
  %.137 = alloca i32
  %.134 = alloca i32*
  store i32* %.135, i32** %.134
  store i32 %.138, i32* %.137
  store i32 %.141, i32* %.140
  store i32 %.144, i32* %.143
  %.148 = load i32, i32* %.140
  %.149 = icmp eq i32 %.148, 1
  br i1 %.149, label %.146, label %.147
.146:
  ret i32 1 
.147:
  store i32 0, i32* %.152
  br label %.154wc35 
.154wc35:
  %.158 = load i32, i32* %.152
  %.159 = load i32, i32* %.140
  %.160 = icmp slt i32 %.158, %.159
  br i1 %.160, label %.155wloop.35.39, label %.156wn39
.155wloop.35.39:
  %.164 = load i32, i32* %.152
  %.165 = srem i32 %.164, 2
  %.166 = icmp eq i32 %.165, 0
  br i1 %.166, label %.162, label %.163
.156wn39:
  %.198 = load i32*, i32** %.134
  %.199 = load i32, i32* %.137
  %.200 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.temp, i32 0, i32 0
  %.201 = load i32, i32* %.140
  %.202at41 = call i32 @memmove(i32* %.198, i32 %.199, i32* %.200, i32 %.201)
  %.203 = load i32*, i32** %.134
  %.204 = load i32, i32* %.137
  %.205 = load i32, i32* %.140
  %.206 = sdiv i32 %.205, 2
  %.207 = load i32, i32* %.143
  %.208 = load i32, i32* %.143
  %.209at42 = call i32 @multiply(i32 %.207, i32 %.208)
  %.210at42 = call i32 @fft(i32* %.203, i32 %.204, i32 %.206, i32 %.209at42)
  %.211 = load i32*, i32** %.134
  %.212 = load i32, i32* %.137
  %.213 = load i32, i32* %.140
  %.214 = sdiv i32 %.213, 2
  %.215 = add i32 %.212, %.214
  %.216 = load i32, i32* %.140
  %.217 = sdiv i32 %.216, 2
  %.218 = load i32, i32* %.143
  %.219 = load i32, i32* %.143
  %.220at43 = call i32 @multiply(i32 %.218, i32 %.219)
  %.221at43 = call i32 @fft(i32* %.211, i32 %.215, i32 %.217, i32 %.220at43)
  store i32 0, i32* %.152
  store i32 1, i32* %.223
  br label %.225wc46 
.162:
  %.168 = load i32, i32* %.152
  %.169 = load i32, i32* %.137
  %.170 = add i32 %.168, %.169
  %.171 = load i32*, i32** %.134
  %.172 = getelementptr inbounds i32, i32* %.171, i32 %.170
  %.173 = load i32, i32* %.172
  %.174 = load i32, i32* %.152
  %.175 = sdiv i32 %.174, 2
  %.176 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.temp, i32 0, i32 %.175
  store i32 %.173, i32* %.176
  br label %.178 
.163:
  %.180 = load i32, i32* %.152
  %.181 = load i32, i32* %.137
  %.182 = add i32 %.180, %.181
  %.183 = load i32*, i32** %.134
  %.184 = getelementptr inbounds i32, i32* %.183, i32 %.182
  %.185 = load i32, i32* %.184
  %.186 = load i32, i32* %.140
  %.187 = sdiv i32 %.186, 2
  %.188 = load i32, i32* %.152
  %.189 = sdiv i32 %.188, 2
  %.190 = add i32 %.187, %.189
  %.191 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.temp, i32 0, i32 %.190
  store i32 %.185, i32* %.191
  br label %.178 
.178:
  %.194 = load i32, i32* %.152
  %.195 = add i32 %.194, 1
  store i32 %.195, i32* %.152
  br label %.154wc35 
.225wc46:
  %.229 = load i32, i32* %.152
  %.230 = load i32, i32* %.140
  %.231 = sdiv i32 %.230, 2
  %.232 = icmp slt i32 %.229, %.231
  br i1 %.232, label %.226wloop.46.53, label %.227wn53
.226wloop.46.53:
  %.235 = load i32, i32* %.137
  %.236 = load i32, i32* %.152
  %.237 = add i32 %.235, %.236
  %.238 = load i32*, i32** %.134
  %.239 = getelementptr inbounds i32, i32* %.238, i32 %.237
  %.240 = load i32, i32* %.239
  store i32 %.240, i32* %.234
  %.243 = load i32, i32* %.137
  %.244 = load i32, i32* %.152
  %.245 = add i32 %.243, %.244
  %.246 = load i32, i32* %.140
  %.247 = sdiv i32 %.246, 2
  %.248 = add i32 %.245, %.247
  %.249 = load i32*, i32** %.134
  %.250 = getelementptr inbounds i32, i32* %.249, i32 %.248
  %.251 = load i32, i32* %.250
  store i32 %.251, i32* %.242
  %.253 = load i32, i32* %.234
  %.254 = load i32, i32* %.223
  %.255 = load i32, i32* %.242
  %.256at49 = call i32 @multiply(i32 %.254, i32 %.255)
  %.257 = add i32 %.253, %.256at49
  %.258 = srem i32 %.257, 998244353
  %.259 = load i32, i32* %.137
  %.260 = load i32, i32* %.152
  %.261 = add i32 %.259, %.260
  %.262 = load i32*, i32** %.134
  %.263 = getelementptr inbounds i32, i32* %.262, i32 %.261
  store i32 %.258, i32* %.263
  %.265 = load i32, i32* %.234
  %.266 = load i32, i32* %.223
  %.267 = load i32, i32* %.242
  %.268at50 = call i32 @multiply(i32 %.266, i32 %.267)
  %.269 = sub i32 %.265, %.268at50
  %.270 = add i32 %.269, 998244353
  %.271 = srem i32 %.270, 998244353
  %.272 = load i32, i32* %.137
  %.273 = load i32, i32* %.152
  %.274 = add i32 %.272, %.273
  %.275 = load i32, i32* %.140
  %.276 = sdiv i32 %.275, 2
  %.277 = add i32 %.274, %.276
  %.278 = load i32*, i32** %.134
  %.279 = getelementptr inbounds i32, i32* %.278, i32 %.277
  store i32 %.271, i32* %.279
  %.281 = load i32, i32* %.223
  %.282 = load i32, i32* %.143
  %.283at51 = call i32 @multiply(i32 %.281, i32 %.282)
  store i32 %.283at51, i32* %.223
  %.285 = load i32, i32* %.152
  %.286 = add i32 %.285, 1
  store i32 %.286, i32* %.152
  br label %.225wc46 
.227wn53:
  ret i32 0 
}
define i32 @main(){
.291:
  %.334 = alloca i32
  %.297 = alloca i32
  %.292 = alloca i32
  %.293 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 0
  %.295at58 = call i32 @getarray(i32* %.293)
  store i32 %.295at58, i32* %.292
  %.298 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.b, i32 0, i32 0
  %.299at59 = call i32 @getarray(i32* %.298)
  store i32 %.299at59, i32* %.297
  call void @_sysy_starttime(i32 60)
  store i32 1, i32* @.g.d
  br label %.305wc62 
.305wc62:
  %.309 = load i32, i32* @.g.d
  %.310 = load i32, i32* %.292
  %.311 = load i32, i32* %.297
  %.312 = add i32 %.310, %.311
  %.313 = sub i32 %.312, 1
  %.314 = icmp slt i32 %.309, %.313
  br i1 %.314, label %.306wloop.62.64, label %.307wn64
.306wloop.62.64:
  %.316 = load i32, i32* @.g.d
  %.317 = mul i32 %.316, 2
  store i32 %.317, i32* @.g.d
  br label %.305wc62 
.307wn64:
  %.320 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 0
  %.321 = load i32, i32* @.g.d
  %.324 = load i32, i32* @.g.d
  %.325 = sdiv i32 998244352, %.324
  %.326at65 = call i32 @power(i32 3, i32 %.325)
  %.327at65 = call i32 @fft(i32* %.320, i32 0, i32 %.321, i32 %.326at65)
  %.328 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.b, i32 0, i32 0
  %.329 = load i32, i32* @.g.d
  %.330 = load i32, i32* @.g.d
  %.331 = sdiv i32 998244352, %.330
  %.332at66 = call i32 @power(i32 3, i32 %.331)
  %.333at66 = call i32 @fft(i32* %.328, i32 0, i32 %.329, i32 %.332at66)
  store i32 0, i32* %.334
  br label %.336wc69 
.336wc69:
  %.340 = load i32, i32* %.334
  %.341 = load i32, i32* @.g.d
  %.342 = icmp slt i32 %.340, %.341
  br i1 %.342, label %.337wloop.69.72, label %.338wn72
.337wloop.69.72:
  %.344 = load i32, i32* %.334
  %.345 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 %.344
  %.346 = load i32, i32* %.345
  %.347 = load i32, i32* %.334
  %.348 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.b, i32 0, i32 %.347
  %.349 = load i32, i32* %.348
  %.350at70 = call i32 @multiply(i32 %.346, i32 %.349)
  %.351 = load i32, i32* %.334
  %.352 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 %.351
  store i32 %.350at70, i32* %.352
  %.354 = load i32, i32* %.334
  %.355 = add i32 %.354, 1
  store i32 %.355, i32* %.334
  br label %.336wc69 
.338wn72:
  %.358 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 0
  %.359 = load i32, i32* @.g.d
  %.360 = load i32, i32* @.g.d
  %.361 = sdiv i32 998244352, %.360
  %.362 = sub i32 998244352, %.361
  %.363at73 = call i32 @power(i32 3, i32 %.362)
  %.364at73 = call i32 @fft(i32* %.358, i32 0, i32 %.359, i32 %.363at73)
  store i32 0, i32* %.334
  br label %.366wc75 
.366wc75:
  %.370 = load i32, i32* %.334
  %.371 = load i32, i32* @.g.d
  %.372 = icmp slt i32 %.370, %.371
  br i1 %.372, label %.367wloop.75.78, label %.368wn78
.367wloop.75.78:
  %.374 = load i32, i32* %.334
  %.375 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 %.374
  %.376 = load i32, i32* %.375
  %.377 = load i32, i32* @.g.d
  %.379at76 = call i32 @power(i32 %.377, i32 998244351)
  %.380at76 = call i32 @multiply(i32 %.376, i32 %.379at76)
  %.381 = load i32, i32* %.334
  %.382 = getelementptr inbounds [2097152 x i32], [2097152 x i32]* @.g.a, i32 0, i32 %.381
  store i32 %.380at76, i32* %.382
  %.384 = load i32, i32* %.334
  %.385 = add i32 %.384, 1
  store i32 %.385, i32* %.334
  br label %.366wc75 
.368wn78:
  call void @_sysy_stoptime(i32 79)
  %.391 = load i32, i32* %.292
  %.392 = load i32, i32* %.297
  %.393 = add i32 %.391, %.392
