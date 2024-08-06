	sw zero, 0(s0)
	sw %436, 0(s0)
	mv %436, a0
	call revert
	mv a0, %368
	call arrCopy
	mv a1, %368
	sw %579, %419
	LoadImmReg %579, 58
	sw %400, %399
	sw %578, %417
	LoadImmReg %578, 279
	sw %398, %397
	sw %394, %393
	addi %383, %575, 24
	LoadLocalAddr %575, 0(s0)
	sw %430, %429
	addi %419, %574, 96
	LoadLocalAddr %574, 0(s0)
	sw %392, %391
	addi %399, %573, 56
	LoadLocalAddr %573, 0(s0)
	sw %406, %405
	mv a0, %572
	LoadLocalAddr %572, 0(s0)
	sw %372, %571
	LoadLocalAddr %571, 0(s0)
	addi %417, %570, 92
	LoadLocalAddr %570, 0(s0)
	sw %428, %427
	LoadLocalAddr %368, 0(s0)
	sw %569, %389
	LoadImmReg %569, 273
	addi %397, %568, 52
	LoadLocalAddr %568, 0(s0)
	sw %408, %407
	addi %393, %567, 44
	LoadLocalAddr %567, 0(s0)
	sw %374, %373
	addi %429, %566, 116
	LoadLocalAddr %566, 0(s0)
	sw %396, %395
	addi %391, %565, 40
	LoadLocalAddr %565, 0(s0)
	sw %434, %433
	addi %405, %564, 68
	LoadLocalAddr %564, 0(s0)
	sw %563, %403
	LoadImmReg %563, 639
	addi %427, %562, 112
	LoadLocalAddr %562, 0(s0)
	sw %370, %371
	addi %389, %561, 36
	LoadLocalAddr %561, 0(s0)
	sw %386, %385
	addi %407, %560, 72
	LoadLocalAddr %560, 0(s0)
	sw %559, %421
	LoadImmReg %559, 87
	addi %373, %558, 4
	LoadLocalAddr %558, 0(s0)
	sw %557, %381
	LoadImmReg %557, 254
	addi %395, %556, 48
	LoadLocalAddr %556, 0(s0)
	sw %555, %415
	LoadImmReg %555, 452
	addi %433, %554, 124
	LoadLocalAddr %554, 0(s0)
	sw %553, %431
	LoadImmReg %553, 1
	addi %403, %552, 64
	LoadLocalAddr %552, 0(s0)
	sw %551, %425
	LoadImmReg %551, 36
	addi %385, %550, 28
	LoadLocalAddr %550, 0(s0)
	sw %549, %413
	LoadImmReg %549, 756
	LoadGlobalAddr %371, .G.n
	sw %548, %387
	LoadImmReg %548, 83
	addi %421, %547, 100
	LoadLocalAddr %547, 0(s0)
	sw %424, %423
	addi %381, %546, 20
	LoadLocalAddr %546, 0(s0)
	sw %545, %411
	LoadImmReg %545, 929
	addi %415, %544, 88
	LoadLocalAddr %544, 0(s0)
	sw %543, %375
	LoadImmReg %543, 89
	addi %431, %542, 120
	LoadLocalAddr %542, 0(s0)
	#MarkDead %541
	LoadImmReg %541, 31
	addi %425, %540, 108
	LoadLocalAddr %540, 0(s0)
	sw %538, %539
	ld %539, 0(s0)
	LoadImmReg %538, 26
	addi %413, %537, 84
	LoadLocalAddr %537, 0(s0)
	sw %402, %401
	addi %387, %536, 32
	LoadLocalAddr %536, 0(s0)
	sw %535, %379
	LoadImmReg %535, 282
	addi %423, %534, 104
	LoadLocalAddr %534, 0(s0)
	sw %410, %533
	ld %533, 0(s0)
	addi %411, %532, 80
	LoadLocalAddr %532, 0(s0)
	LoadImmReg %384, 27
	addi %375, %531, 8
	LoadLocalAddr %531, 0(s0)
	#MarkDead %577
	LoadImmReg %577, 58
	sd %529, 0(s0)
	addi %529, %530, 12
	LoadLocalAddr %530, 0(s0)
	LoadImmReg %400, 935
	addi %401, %528, 60
	LoadLocalAddr %528, 0(s0)
	#MarkDead %576
	LoadImmReg %576, 279
	addi %379, %527, 16
	LoadLocalAddr %527, 0(s0)
	LoadImmReg %398, 657
	sd %525, 0(s0)
	addi %525, %526, 76
	LoadLocalAddr %526, 0(s0)
	LoadImmReg %394, 905
	#MarkDead %524
	LoadLocalAddr %524, 0(s0)
	LoadImmReg %430, 28
	LoadImmReg %392, 574
	LoadImmReg %406, 459
	LoadImmReg %372, 7
	LoadImmReg %428, 39
	#MarkDead %523
	LoadImmReg %523, 273
	LoadImmReg %408, 29
	LoadImmReg %374, 23
	LoadImmReg %396, 354
	LoadImmReg %434, 290
	#MarkDead %522
	LoadImmReg %522, 639
	LoadImmReg %386, 5
	LoadImmReg %370, 32
	#MarkDead %521
	LoadImmReg %521, 87
	#MarkDead %520
	LoadImmReg %520, 254
	#MarkDead %519
	LoadImmReg %519, 452
	#MarkDead %518
	LoadImmReg %518, 1
	#MarkDead %517
	LoadImmReg %517, 36
	#MarkDead %516
	LoadImmReg %516, 756
	#MarkDead %515
	LoadImmReg %515, 83
	LoadImmReg %424, 96
	#MarkDead %514
	LoadImmReg %514, 929
	#MarkDead %513
	LoadImmReg %513, 89
	#MarkDead %512
	LoadImmReg %512, 26
	LoadImmReg %402, 264
	#MarkDead %511
	LoadImmReg %511, 282
	LoadImmReg %410, 68
	j .LBB87
	blt %437, 32, .LBB86
	lw %437, 0(s0)
	sw zero, 0(s0)
	sw %438, 0(s0)
	mv %438, a0
	call bubblesort
	mv a0, %368
	j .LBB90
	blt %439, 32, .LBB89
	lw %439, 0(s0)
	sw zero, 0(s0)
	sw %445, 0(s0)
	mv %445, a0
	call bubblesort
	mv a0, %368
	call arrCopy
	mv a1, %368
	mv a0, %369
	call putint
	mv a0, %443
	sw %442, 0(s0)
	lw %443, 0(s0)
	mv %442, a0
	call getMost
	mv a0, %368
	call putint
	mv a0, %441
	sw %440, 0(s0)
	lw %441, 0(s0)
	mv %440, a0
	call getMid
	mv a0, %368
	j .LBB93
	blt %446, 32, .LBB92
	lw %446, 0(s0)
	sw zero, 0(s0)
	sw %448, 0(s0)
	mv %448, a0
	call insertsort
	mv a0, %368
	call arrCopy
	mv a1, %368
	mv a0, %369
	j .LBB96
	blt %449, 32, .LBB95
	lw %449, 0(s0)
	sw %454, 0(s0)
	mv %454, a0
	call QuickSort
	mv a2, %453
	mv a1, %452
	sw %451, 0(s0)
	sw zero, 0(s0)
	sw %450, 0(s0)
	lw %453, 0(s0)
	lw %452, 0(s0)
	mv a0, %368
	mv %450, a0
	call arrCopy
	mv a1, %368
	mv a0, %369
	j .LBB99
	blt %455, 32, .LBB98
	lw %455, 0(s0)
	sw zero, 0(s0)
	sw %457, 0(s0)
	mv %457, a0
	call calSum
	li a1, 4
	sw %456, 0(s0)
	mv %456, a0
	mv a0, %368
	call arrCopy
	mv a1, %368
	mv a0, %369
	j .LBB102
	blt %458, 32, .LBB101
	lw %458, 0(s0)
	sw zero, 0(s0)
	sw %460, 0(s0)
	mv %460, a0
	call avgPooling
	li a1, 3
	sw %459, 0(s0)
	mv %459, a0
	mv a0, %368
	call arrCopy
	mv a1, %368
	mv a0, %369
	j .LBB105
	blt %461, 32, .LBB104
	lw %461, 0(s0)
	ret 
	li a0, 0
	sw %468, 0(s0)
	addiw %468, %467, 1
	lw %467, 0(s0)
	call putint
	mv a0, %466
	sw %465, 0(s0)
	lw %466, 0(s0)
	lw %465, %464
	add %464, %368, %463
	slli %463, %462, 2
	lw %462, 0(s0)
	sw %475, 0(s0)
	addiw %475, %474, 1
	lw %474, 0(s0)
	call putint
	mv a0, %473
	sw %472, 0(s0)
	lw %473, 0(s0)
	lw %472, %471
	add %471, %368, %470
	slli %470, %469, 2
	lw %469, 0(s0)
	sw %482, 0(s0)
	addiw %482, %481, 1
	lw %481, 0(s0)
	call putint
	mv a0, %480
	sw %479, 0(s0)
	lw %480, 0(s0)
	lw %479, %478
	add %478, %368, %477
	slli %477, %476, 2
	lw %476, 0(s0)
	sw %489, 0(s0)
	addiw %489, %488, 1
	lw %488, 0(s0)
	call putint
	mv a0, %487
	sw %486, 0(s0)
	lw %487, 0(s0)
	lw %486, %485
	add %485, %368, %484
	slli %484, %483, 2
	lw %483, 0(s0)
	sw %496, 0(s0)
	addiw %496, %495, 1
	lw %495, 0(s0)
	call putint
	mv a0, %494
	sw %493, 0(s0)
	lw %494, 0(s0)
	lw %493, %492
	add %492, %368, %491
	slli %491, %490, 2
	lw %490, 0(s0)
	sw %503, 0(s0)
	addiw %503, %502, 1
	lw %502, 0(s0)
	call putint
	mv a0, %501
	sw %500, 0(s0)
	lw %501, 0(s0)
	lw %500, %499
	add %499, %368, %498
	slli %498, %497, 2
	lw %497, 0(s0)
	sw %510, 0(s0)
	addiw %510, %509, 1
	lw %509, 0(s0)
	call putint
	mv a0, %508
	sw %507, 0(s0)
	lw %508, 0(s0)
	lw %507, %506
	add %506, %368, %505
	slli %505, %504, 2
	lw %504, 0(s0)
