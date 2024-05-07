define i32 @rand(){
  .13:
    %.484 = alloca i32
    store i32 0, i32* %.484
    %.14 = load i32, i32* %.484
    %.16 = mul i32 %.14, 19980130
    %.18 = add i32 %.16, 23333
    %.19 = srem i32 %.18, 100000007
    store i32 %.19, i32* %.484
    %.23 = load i32, i32* %.484
    %.24 = icmp slt i32 %.23, 0
    br i1 %.24, label %.21, label %.22
  .21:
    %.26 = load i32, i32* %.484
    %.27 = add i32 %.26, 100000007
    store i32 %.27, i32* %.484
    br label %.22 
  .22:
    %.30 = load i32, i32* %.484
    ret i32 %.30 
  }
  define float @my_fabs(float %.35){
  .33:
    %.40 = sitofp i32 0 to float
    %.41 = fcmp ugt float %.35, %.40
    br i1 %.41, label %.37, label %.38
  .37:
    ret float %.35 
  .38:
    %.47 = fsub float 0x0, %.35
    ret float %.47 
  }
  define float @my_sqrt(float %.52){
  .50:
    %.57 = sitofp i32 8 to float
    %.58 = fdiv float %.52, %.57
    %.60 = fadd float %.58, 0x3fe0000000000000
    %.63 = sitofp i32 2 to float
    %.64 = fmul float %.63, %.52
    %.67 = sitofp i32 4 to float
    %.68 = fadd float %.67, %.52
    %.69 = fdiv float %.64, %.68
    %.70 = fadd float %.60, %.69
    br label %.74wc27 
  .74wc27:
    %.471 = phi float [%.70, %.50], [%.87, %.75wloop.27.30]
    %.470 = phi i32 [10, %.50], [%.90, %.75wloop.27.30]
    %.79 = icmp ne i32 %.470, 0
    br i1 %.79, label %.75wloop.27.30, label %.76wn30
  .75wloop.27.30:
    %.84 = fdiv float %.52, %.471
    %.85 = fadd float %.471, %.84
    %.86 = sitofp i32 2 to float
    %.87 = fdiv float %.85, %.86
    %.90 = sub i32 %.470, 1
    br label %.74wc27 
  .76wn30:
    ret float %.471 
  }
  define float @p(float %.98){
  .96:
    %.102 = sitofp i32 3 to float
    %.103 = fmul float %.102, %.98
    %.105 = sitofp i32 4 to float
    %.106 = fmul float %.105, %.98
    %.108 = fmul float %.106, %.98
    %.110 = fmul float %.108, %.98
    %.111 = fsub float %.103, %.110
    ret float %.111 
  }
  define float @my_sin_impl(float %.116){
  .114:
    %.121at37 = call float @my_fabs(float %.116)
    %.122 = fcmp ule float %.121at37, 0x3eb0c6f7a0000000
    br i1 %.122, label %.118, label %.119
  .118:
    ret float %.116 
  .119:
    %.128 = fdiv float %.116, 0x4008000000000000
    %.129at38 = call float @my_sin_impl(float %.128)
    %.130at38 = call float @p(float %.129at38)
    ret float %.130at38 
  }
  define float @my_sin(float %.135){
  .133:
    %.141 = fcmp ugt float %.135, 0x401921fb60000000
    br i1 %.141, label %.137, label %.139
  .137:
    %.149 = fdiv float %.135, 0x401921fb60000000
    %.150 = fptosi float %.149 to i32
    %.154 = sitofp i32 %.150 to float
    %.155 = fmul float %.154, 0x401921fb60000000
    %.156 = fsub float %.135, %.155
    br label %.138 
  .138:
    %.476 = phi float [%.135, %.139], [%.156, %.137]
    %.162 = fcmp ugt float %.476, 0x400921fb60000000
    br i1 %.162, label %.159, label %.160
  .139:
    %.145 = fcmp ult float %.135, 0xc01921fb60000000
    br i1 %.145, label %.137, label %.138
  .159:
    %.165 = fsub float %.476, 0x401921fb60000000
    br label %.160 
  .160:
    %.475 = phi float [%.476, %.138], [%.165, %.159]
    %.172 = fcmp ult float %.475, 0xc00921fb60000000
    br i1 %.172, label %.168, label %.169
  .168:
    %.175 = fadd float %.475, 0x401921fb60000000
    br label %.169 
  .169:
    %.474 = phi float [%.475, %.160], [%.175, %.168]
    %.179at48 = call float @my_sin_impl(float %.474)
    ret float %.179at48 
  }
  define float @my_cos(float %.184){
  .182:
    %.188 = fadd float %.184, 0x3ff921fb60000000
    %.189at51 = call float @my_sin(float %.188)
    ret float %.189at51 
  }
  define float @circle_sdf(float %.194, float %.197, float %.200, float %.203, float %.206){
  .192:
    %.211 = fsub float %.194, %.200
    %.216 = fsub float %.197, %.203
    %.220 = fmul float %.211, %.211
    %.223 = fmul float %.216, %.216
    %.224 = fadd float %.220, %.223
    %.225at55 = call float @my_sqrt(float %.224)
    %.227 = fsub float %.225at55, %.206
    ret float %.227 
  }
  define void @scene(float %.232, float %.235, float* %.238){
  .230:
    %.245at59 = call float @circle_sdf(float %.232, float %.235, float 0x3fd99999a0000000, float 0x3fd99999a0000000, float 0x3fb99999a0000000)
    %.252at60 = call float @circle_sdf(float %.232, float %.235, float 0x3fe3333340000000, float 0x3fe3333340000000, float 0x3fa99999a0000000)
    %.258 = fcmp ult float %.245at59, %.252at60
    br i1 %.258, label %.254, label %.255
  .254:
    %.262 = getelementptr inbounds float, float* %.238, i32 0
    store float %.245at59, float* %.262
    %.265 = getelementptr inbounds float, float* %.238, i32 1
    store float 0x4008000000000000, float* %.265
    br label %.267 
  .255:
    %.271 = getelementptr inbounds float, float* %.238, i32 0
    store float %.252at60, float* %.271
    %.274 = getelementptr inbounds float, float* %.238, i32 1
    store float 0x0, float* %.274
    br label %.267 
  .267:
    ret void
  }
  define float @trace(float %.281, float %.284, float %.287, float %.290){
  .279:
    %.307 = alloca [2 x float]
    br label %.296wc73 
  .296wc73:
    %.478 = phi float [0x0, %.279], [%.332, %.321]
    %.477 = phi i32 [0, %.279], [%.335, %.321]
    %.301 = icmp slt i32 %.477, 10
    br i1 %.301, label %.302, label %.298wn79
  .297wloop.73.79:
    %.311 = fmul float %.287, %.478
    %.312 = fadd float %.281, %.311
    %.316 = fmul float %.290, %.478
    %.317 = fadd float %.284, %.316
    %.318 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
    call void @scene(float %.312, float %.317, float* %.318)
    %.322 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
    %.323 = load float, float* %.322
    %.324 = fcmp ult float %.323, 0x3eb0c6f7a0000000
    br i1 %.324, label %.320, label %.321
  .298wn79:
    ret float 0x0 
  .302:
    %.305 = fcmp ult float %.478, 0x4000000000000000
    br i1 %.305, label %.297wloop.73.79, label %.298wn79
  .320:
    %.326 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 1
    %.327 = load float, float* %.326
    ret float %.327 
  .321:
    %.330 = getelementptr inbounds [2 x float], [2 x float]* %.307, i32 0, i32 0
    %.331 = load float, float* %.330
    %.332 = fadd float %.478, %.331
    %.335 = add i32 %.477, 1
    br label %.296wc73 
  }
  define float @sample(float %.342, float %.345){
  .340:
    br label %.351wc86 
  .351wc86:
    %.480 = phi i32 [0, %.340], [%.384, %.352wloop.86.91]
    %.479 = phi float [0x0, %.340], [%.381, %.352wloop.86.91]
    %.356 = icmp slt i32 %.480, 24
    br i1 %.356, label %.352wloop.86.91, label %.353wn91
  .352wloop.86.91:
    %.359at87 = call i32 @rand()
    %.360 = sitofp i32 %.359at87 to float
    %.365 = sitofp i32 100000006 to float
    %.366 = fdiv float %.360, %.365
    %.367 = sitofp i32 %.480 to float
    %.368 = fadd float %.367, %.366
    %.369 = fmul float 0x401921fb60000000, %.368
    %.370 = sitofp i32 24 to float
    %.371 = fdiv float %.369, %.370
    %.377at89 = call float @my_cos(float %.371)
    %.379at89 = call float @my_sin(float %.371)
    %.380at89 = call float @trace(float %.342, float %.345, float %.377at89, float %.379at89)
    %.381 = fadd float %.479, %.380at89
    %.384 = add i32 %.480, 1
    br label %.351wc86 
  .353wn91:
    %.388 = sitofp i32 24 to float
    %.389 = fdiv float %.479, %.388
    ret float %.389 
  }
  define void @write_pgm(){
  .392:
    call void @putch(i32 80)
    call void @putch(i32 50)
    call void @putch(i32 10)
    call void @putint(i32 192)
    call void @putch(i32 32)
    call void @putint(i32 192)
    call void @putch(i32 32)
    call void @putint(i32 255)
    call void @putch(i32 10)
    br label %.410wc99 
  .410wc99:
    %.482 = phi i32 [0, %.392], [%.462, %.421wn108]
    %.415 = icmp slt i32 %.482, 192
    br i1 %.415, label %.411wloop.99.111, label %.412wn111
  .411wloop.99.111:
    br label %.419wc101 
  .412wn111:
    ret void
  .419wc101:
    %.483 = phi i32 [0, %.411wloop.99.111], [%.457, %.447]
    %.424 = icmp slt i32 %.483, 192
    br i1 %.424, label %.420wloop.101.108, label %.421wn108
  .420wloop.101.108:
    %.428 = sitofp i32 %.483 to float
    %.432 = sitofp i32 %.482 to float
    %.436 = sitofp i32 192 to float
    %.437 = fdiv float %.428, %.436
    %.439 = sitofp i32 192 to float
    %.440 = fdiv float %.432, %.439
    %.441at103 = call float @sample(float %.437, float %.440)
    %.443 = fmul float %.441at103, 0x406fe00000000000
    %.444 = fptosi float %.443 to i32
    %.449 = icmp sgt i32 %.444, 255
    br i1 %.449, label %.446, label %.447
  .421wn108:
    call void @putch(i32 10)
    %.462 = add i32 %.482, 1
    br label %.410wc99 
  .446:
    br label %.447 
  .447:
    %.481 = phi i32 [%.444, %.420wloop.101.108], [255, %.446]
    call void @putint(i32 %.481)
    call void @putch(i32 32)
    %.457 = add i32 %.483, 1
    br label %.419wc101 
  }
  define i32 @main(){
  .467:
    call void @write_pgm()
    ret i32 0 
  }
  