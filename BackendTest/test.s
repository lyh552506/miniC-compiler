	mv %0, a0

	lw %5, %4

	lw %12, %11

	add %19, %0, %18

	sw %24, %26

	sw %30, %32

	mv a1, %37

	mv a1, %37

	sw %30, %32

	sw %24, %26

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	sw %30, %32

	sw %24, %26

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	sw %30, %32

	sw %24, %26

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	sw %30, %32

	sw %24, %26

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	sw %30, %32

	sw %24, %26

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	sw %30, %32

	sw %24, %26

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

QuickSort:
.LBB0:
	LoadImmReg %14, 1
	mv %0, a0
	mv %1, a1
	mv %2, a2
	j .LBB1
.LBB1:
	blt %1, %2, .LBB2
	j .LBB3
.LBB3:
	li a0, 0
	ret 
.LBB2:
	slli %3, %1, 2
	add %4, %0, %3
	lw %5, %4
	mv %7, %2
	mv %6, %1
	j .LBB4
.LBB4:
	blt %6, %7, .LBB18
	j .LBB6
.LBB5:
	slt %8, %6, %9
	bne %8, zero, .LBB7
	j .LBB8
.LBB7:
	slli %10, %9, 2
	add %11, %0, %10
	lw %12, %11
	subw %13, %5, %14
	bgt %12, %13, .LBB9
	j .LBB8
.LBB9:
	subw %15, %9, %14
	mv %9, %15
	j .LBB5
.LBB8:
	bne %8, zero, .LBB10
	j .LBB19
.LBB11:
	mv %17, %39
	j .LBB12
.LBB12:
	slt %16, %17, %9
	bne %16, zero, .LBB13
	j .LBB14
.LBB13:
	slli %18, %17, 2
	add %19, %0, %18
	lw %20, %19
	blt %20, %5, .LBB15
	j .LBB14
.LBB15:
	addiw %21, %17, 1
	mv %17, %21
	j .LBB12
.LBB14:
	bne %16, zero, .LBB16
	j .LBB20
.LBB17:
	mv %7, %38
	mv %6, %17
	j .LBB4
.LBB16:
	slli %22, %17, 2
	add %23, %0, %22
	slli %25, %9, 2
	lw %24, %23
	add %26, %0, %25
	subw %27, %9, %14
	sw %24, %26
	mv %38, %27
	j .LBB17
.LBB10:
	slli %28, %9, 2
	add %29, %0, %28
	slli %31, %6, 2
	lw %30, %29
	add %32, %0, %31
	addiw %33, %6, 1
	sw %30, %32
	mv %39, %33
	j .LBB11
.LBB6:
	slli %34, %6, 2
	add %35, %0, %34
	sw %5, %35
	subw %36, %6, %14
	mv a0, %0
	mv a1, %1
	mv a2, %36
	call QuickSort
	addiw %37, %6, 1
	mv a0, %0
	mv a1, %37
	mv a2, %2
	call QuickSort
	j .LBB3
.LBB18:
	mv %9, %7
	j .LBB5
.LBB19:
	mv %39, %6
	j .LBB11
.LBB20:
	mv %38, %9
	j .LBB17

	mv %0, a0

	lw %5, %4

	lw %12, %11

	add %19, %0, %18

	subw %27, %9, %14

	addiw %33, %6, 1

	mv a1, %37

	mv a1, %37

	addiw %33, %6, 1

	subw %27, %9, %14

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	addiw %33, %6, 1

	subw %27, %9, %14

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	addiw %33, %6, 1

	subw %27, %9, %14

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	addiw %33, %6, 1

	subw %27, %9, %14

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	addiw %33, %6, 1

	subw %27, %9, %14

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

	mv a1, %37

	addiw %33, %6, 1

	subw %27, %9, %14

	add %19, %0, %18

	lw %12, %11

	lw %5, %4

	mv %0, a0

QuickSort:
.LBB0:
	LoadImmReg %14, 1
	mv %0, a0
	mv %1, a1
	mv %2, a2
	j .LBB1
.LBB1:
	blt %1, %2, .LBB2
	j .LBB3
.LBB3:
	li a0, 0
	ret 
.LBB2:
	slli %3, %1, 2
	add %4, %0, %3
	lw %5, %4
	mv %7, %2
	mv %6, %1
	j .LBB4
.LBB4:
	blt %6, %7, .LBB18
	j .LBB6
.LBB5:
	slt %8, %6, %9
	bne %8, zero, .LBB7
	j .LBB8
.LBB7:
	slli %10, %9, 2
	add %11, %0, %10
	lw %12, %11
	subw %13, %5, %14
	bgt %12, %13, .LBB9
	j .LBB8
.LBB9:
	subw %15, %9, %14
	mv %9, %15
	j .LBB5
.LBB8:
	bne %8, zero, .LBB10
	j .LBB19
.LBB11:
	mv %17, %39
	j .LBB12
.LBB12:
	slt %16, %17, %9
	bne %16, zero, .LBB13
	j .LBB14
.LBB13:
	slli %18, %17, 2
	add %19, %0, %18
	lw %20, %19
	blt %20, %5, .LBB15
	j .LBB14
.LBB15:
	addiw %21, %17, 1
	mv %17, %21
	j .LBB12
.LBB14:
	bne %16, zero, .LBB16
	j .LBB20
.LBB17:
	mv %7, %38
	mv %6, %17
	j .LBB4
.LBB16:
	slli %22, %17, 2
	add %23, %0, %22
	slli %25, %9, 2
	lw %24, %23
	add %26, %0, %25
	subw %27, %9, %14
	sw %24, %26
	mv %38, %27
	j .LBB17
.LBB10:
	slli %28, %9, 2
	add %29, %0, %28
	slli %31, %6, 2
	lw %30, %29
	add %32, %0, %31
	addiw %33, %6, 1
	sw %30, %32
	mv %39, %33
	j .LBB11
.LBB6:
	slli %34, %6, 2
	add %35, %0, %34
	sw %5, %35
	subw %36, %6, %14
	mv a0, %0
	mv a1, %1
	mv a2, %36
	call QuickSort
	addiw %37, %6, 1
	mv a0, %0
	mv a1, %37
	mv a2, %2
	call QuickSort
	j .LBB3
.LBB18:
	mv %9, %7
	j .LBB5
.LBB19:
	mv %39, %6
	j .LBB11
.LBB20:
	mv %38, %9
	j .LBB17

	addi %104, %42, 124

	srliw %117, %117, 31

	mv a0, %117

	mv a0, %120

	li a2, 31

	call putint

	sw zero, %141

	mv %148, %290

	sw %157, %155

	sw %159, %41

	addw %163, %148, %162

	sw %166, %168

	call putint

	addw %177, %178, %176

	addiw %181, %130, 1

	sw %184, %186

	call putint

	sw %194, %196

	call putint

	lw %204, %203

	add %208, %41, %207

	sw %209, %210

	sw %204, %214

	sw %218, %220

	call putint

	subw %226, 32, %122

	addi %234, %231, 4

	sw %232, %234

	sw %238, %240

	addiw %248, %247, 1

	mv %249, %287

	lw %251, %246

	sw zero, %253

	call putint

	subw %259, 32, %110

	addi %267, %264, 4

	sw %265, %267

	call putint

	subw %280, %108, %103

	sw %283, %285

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

	sw %283, %285

	subw %280, %108, %103

	call putint

	sw %265, %267

	addi %267, %264, 4

	subw %259, 32, %110

	call putint

	sw zero, %253

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	sw %238, %240

	sw %232, %234

	addi %234, %231, 4

	subw %226, 32, %122

	call putint

	sw %218, %220

	sw %204, %214

	sw %209, %210

	add %208, %41, %207

	lw %204, %203

	call putint

	sw %194, %196

	call putint

	sw %184, %186

	addiw %181, %130, 1

	addw %177, %178, %176

	call putint

	sw %166, %168

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	sw zero, %141

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	addi %104, %42, 124

QuickSort:
.LBB0:
	LoadImmReg a3, 1
	mv s2, a0
	mv s3, a2
	j .LBB1
.LBB1:
	blt a1, s3, .LBB2
	j .LBB3
.LBB3:
	li a0, 0
	ret 
.LBB2:
	slli t2, a1, 2
	add t2, s2, t2
	lw a0, t2
	mv a4, s3
	mv s4, a1
	j .LBB4
.LBB4:
	blt s4, a4, .LBB18
	j .LBB6
.LBB5:
	slt s1, s4, a4
	bne s1, zero, .LBB7
	j .LBB8
.LBB7:
	slli t2, a4, 2
	add t2, s2, t2
	lw t2, t2
	subw a2, a0, a3
	bgt t2, a2, .LBB9
	j .LBB8
.LBB9:
	subw a4, a4, a3
	j .LBB5
.LBB8:
	bne s1, zero, .LBB10
	j .LBB19
.LBB11:
	mv a2, s4
	j .LBB12
.LBB12:
	slt s1, a2, a4
	bne s1, zero, .LBB13
	j .LBB14
.LBB13:
	slli t2, a2, 2
	add t2, s2, t2
	lw t2, t2
	blt t2, a0, .LBB15
	j .LBB14
.LBB15:
	addiw a2, a2, 1
	j .LBB12
.LBB14:
	bne s1, zero, .LBB16
	j .LBB20
.LBB17:
	mv s4, a2
	j .LBB4
.LBB16:
	slli t2, a2, 2
	add s1, s2, t2
	slli t2, a4, 2
	lw s1, s1
	add t2, s2, t2
	subw a4, a4, a3
	sw s1, t2
	j .LBB17
.LBB10:
	slli t2, a4, 2
	add s1, s2, t2
	slli t2, s4, 2
	lw s1, s1
	add t2, s2, t2
	addiw a2, s4, 1
	sw s1, t2
	mv s4, a2
	j .LBB11
.LBB6:
	slli t2, s4, 2
	add t2, s2, t2
	sw a0, t2
	subw a2, s4, a3
	mv a0, s2
	call QuickSort
	addiw a1, s4, 1
	mv a0, s2
	mv a2, s3
	call QuickSort
	j .LBB3
.LBB18:
	j .LBB5
.LBB19:
	j .LBB11
.LBB20:
	j .LBB17
main:
.LBB21:
	LoadImmReg %81, 68
	LoadImmReg %83, 929
	LoadImmReg %69, 657
	LoadImmReg %91, 58
	LoadImmReg %47, 89
	LoadImmReg %55, 27
	LoadImmReg %87, 452
	LoadImmReg %59, 83
	LoadImmReg %49, 26
	LoadImmReg %73, 264
	LoadImmReg %57, 5
	LoadImmReg %85, 756
	LoadImmReg %89, 279
	LoadImmReg %101, 28
	LoadImmReg %103, 1
	LoadImmReg %75, 639
	LoadImmReg %67, 354
	LoadImmReg %93, 87
	LoadImmReg %45, 23
	LoadImmReg %79, 29
	LoadImmReg %61, 273
	LoadImmReg %95, 96
	LoadImmReg %43, 7
	LoadImmReg %77, 459
	LoadImmReg %63, 574
	LoadImmReg %97, 36
	LoadLocalAddr %42, 0(s0)
	LoadImmReg %99, 39
	addi %80, %42, 76
	LoadImmReg %65, 905
	addi %82, %42, 80
	LoadImmReg %71, 935
	addi %68, %42, 52
	LoadImmReg %105, 290
	addi %90, %42, 96
	LoadImmReg %53, 254
	addi %46, %42, 8
	LoadImmReg %51, 282
	addi %54, %42, 24
	sw %81, %80
	addi %86, %42, 88
	sw %83, %82
	addi %58, %42, 32
	sw %69, %68
	sw %91, %90
	addi %48, %42, 12
	sw %47, %46
	addi %72, %42, 60
	sw %55, %54
	addi %56, %42, 28
	sw %87, %86
	addi %84, %42, 84
	sw %59, %58
	addi %88, %42, 92
	LoadImmReg %180, 4
	addi %100, %42, 116
	sw %49, %48
	addi %102, %42, 120
	sw %73, %72
	addi %74, %42, 64
	sw %57, %56
	addi %66, %42, 48
	sw %85, %84
	addi %92, %42, 100
	sw %89, %88
	addi %44, %42, 4
	sw %101, %100
	addi %78, %42, 72
	sw %103, %102
	addi %60, %42, 36
	sw %75, %74
	addi %94, %42, 104
	sw %67, %66
	sw %93, %92
	addi %76, %42, 68
	sw %45, %44
	addi %62, %42, 40
	sw %79, %78
	addi %96, %42, 108
	sw %61, %60
	sw %95, %94
	addi %98, %42, 112
	sw %43, %42
	addi %64, %42, 44
	sw %77, %76
	addi %70, %42, 56
	sw %63, %62
	addi %104, %42, 124
	sw %97, %96
	addi %52, %42, 20
	LoadImmReg %152, 3
	sw %99, %98
	addi %50, %42, 16
	sw %65, %64
	sw %71, %70
	sw %105, %104
	sw %53, %52
	LoadLocalAddr %41, 0(s0)
	li %106, 0
	LoadLocalAddr %40, 0(s0)
	sw %51, %50
	j .LBB22
.LBB22:
	blt %106, 32, .LBB23
	j .LBB92
.LBB24:
	blt %107, %108, .LBB25
	j .LBB93
.LBB26:
	blt %109, 32, .LBB27
	j .LBB94
.LBB28:
	blt %110, 31, .LBB96
	j .LBB97
.LBB30:
	blt %111, 32, .LBB31
	j .LBB32
.LBB32:
	addi %112, %41, 64
	addi %114, %41, 60
	lw %113, %112
	lw %115, %114
	addw %116, %113, %115
	sraiw %117, %116, 31
	srliw %117, %117, 31
	addw %117, %117, %116
	sraiw %117, %117, 1
	j .LBB33
.LBB33:
	mv a0, %117
	call putint
	li %118, 0
	j .LBB34
.LBB34:
	blt %118, 1000, .LBB35
	j .LBB98
.LBB36:
	blt %119, 32, .LBB37
	j .LBB38
.LBB38:
	mv a0, %120
	call putint
	li %121, 0
	j .LBB39
.LBB39:
	blt %121, 32, .LBB40
	j .LBB100
.LBB41:
	blt %122, 31, .LBB101
	j .LBB103
.LBB43:
	blt %123, 32, .LBB44
	j .LBB104
.LBB45:
	blt %124, 32, .LBB46
	j .LBB105
.LBB47:
	blt %125, 32, .LBB48
	j .LBB106
.LBB49:
	blt %126, 32, .LBB50
	j .LBB107
.LBB51:
	blt %127, 32, .LBB52
	j .LBB53
.LBB53:
	mv a0, %41
	li a1, 0
	li a2, 31
	call QuickSort
	li %128, 0
	j .LBB54
.LBB54:
	blt %128, 32, .LBB55
	j .LBB108
.LBB56:
	blt %129, 32, .LBB57
	j .LBB109
.LBB58:
	blt %130, 32, .LBB59
	j .LBB110
.LBB60:
	blt %131, 32, .LBB61
	j .LBB111
.LBB62:
	blt %132, 32, .LBB63
	j .LBB112
.LBB64:
	blt %133, 32, .LBB65
	j .LBB113
.LBB66:
	blt %134, 32, .LBB67
	j .LBB114
.LBB68:
	blt %135, 32, .LBB69
	j .LBB70
.LBB70:
	li a0, 0
	ret 
.LBB69:
	slli %136, %135, 2
	add %137, %41, %136
	lw %138, %137
	mv a0, %138
	call putint
	addiw %139, %135, 1
	mv %135, %139
	j .LBB68
.LBB67:
	slli %140, %134, 2
	add %141, %41, %140
	addiw %142, %134, 1
	sw zero, %141
	mv %134, %142
	j .LBB66
.LBB65:
	blt %133, 2, .LBB71
	j .LBB72
.LBB73:
	addiw %143, %133, 1
	mv %148, %290
	mv %133, %143
	mv %150, %291
	j .LBB64
.LBB72:
	beq %133, 2, .LBB74
	j .LBB75
.LBB76:
	mv %290, %292
	mv %291, %293
	j .LBB73
.LBB75:
	slli %144, %133, 2
	add %145, %41, %144
	lw %146, %145
	subw %151, %133, %152
	addw %147, %148, %146
	addiw %153, %151, 1
	subw %149, %147, %150
	slli %154, %153, 2
	divw %157, %149, %152
	add %155, %41, %154
	lw %156, %155
	sw %157, %155
	mv %292, %149
	mv %293, %156
	j .LBB76
.LBB74:
	divw %159, %148, %152
	lw %158, %41
	sw %159, %41
	mv %292, %148
	mv %293, %158
	j .LBB76
.LBB71:
	slli %160, %133, 2
	add %161, %41, %160
	lw %162, %161
	addw %163, %148, %162
	mv %290, %163
	mv %291, %150
	j .LBB73
.LBB63:
	slli %164, %132, 2
	add %165, %42, %164
	slli %167, %132, 2
	lw %166, %165
	add %168, %41, %167
	addiw %169, %132, 1
	sw %166, %168
	mv %132, %169
	j .LBB62
.LBB61:
	slli %170, %131, 2
	add %171, %41, %170
	lw %172, %171
	mv a0, %172
	call putint
	addiw %173, %131, 1
	mv %131, %173
	j .LBB60
.LBB59:
	slli %174, %130, 2
	add %175, %41, %174
	lw %176, %175
	remw %179, %130, %180
	addw %177, %178, %176
	bne %179, 3, .LBB77
	j .LBB78
.LBB79:
	addiw %181, %130, 1
	mv %178, %289
	mv %130, %181
	j .LBB58
.LBB78:
	sw %177, %175
	li %289, 0
	j .LBB79
.LBB77:
	sw zero, %175
	mv %289, %177
	j .LBB79
.LBB57:
	slli %182, %129, 2
	add %183, %42, %182
	slli %185, %129, 2
	lw %184, %183
	add %186, %41, %185
	addiw %187, %129, 1
	sw %184, %186
	mv %129, %187
	j .LBB56
.LBB55:
	slli %188, %128, 2
	add %189, %41, %188
	lw %190, %189
	mv a0, %190
	call putint
	addiw %191, %128, 1
	mv %128, %191
	j .LBB54
.LBB52:
	slli %192, %127, 2
	add %193, %42, %192
	slli %195, %127, 2
	lw %194, %193
	add %196, %41, %195
	addiw %197, %127, 1
	sw %194, %196
	mv %127, %197
	j .LBB51
.LBB50:
	slli %198, %126, 2
	add %199, %41, %198
	lw %200, %199
	mv a0, %200
	call putint
	addiw %201, %126, 1
	mv %126, %201
	j .LBB49
.LBB48:
	slli %202, %125, 2
	add %203, %41, %202
	subw %205, %125, %103
	lw %204, %203
	mv %206, %205
	j .LBB80
.LBB80:
	bgt %206, -1, .LBB81
	j .LBB82
.LBB81:
	slli %207, %206, 2
	add %208, %41, %207
	lw %209, %208
	blt %204, %209, .LBB83
	j .LBB82
.LBB83:
	addi %210, %208, 4
	subw %211, %206, %103
	sw %209, %210
	mv %206, %211
	j .LBB80
.LBB82:
	addiw %212, %206, 1
	slli %213, %212, 2
	add %214, %41, %213
	addiw %215, %125, 1
	sw %204, %214
	mv %125, %215
	j .LBB47
.LBB46:
	slli %216, %124, 2
	add %217, %42, %216
	slli %219, %124, 2
	lw %218, %217
	add %220, %41, %219
	addiw %221, %124, 1
	sw %218, %220
	mv %124, %221
	j .LBB45
.LBB44:
	slli %222, %123, 2
	add %223, %41, %222
	lw %224, %223
	mv a0, %224
	call putint
	addiw %225, %123, 1
	mv %123, %225
	j .LBB43
.LBB42:
	subw %226, 32, %122
	subw %227, %226, %103
	blt %228, %227, .LBB84
	j .LBB85
.LBB85:
	addiw %229, %122, 1
	mv %122, %229
	j .LBB41
.LBB84:
	slli %230, %228, 2
	add %231, %41, %230
	addi %234, %231, 4
	lw %232, %231
	addiw %233, %228, 1
	lw %235, %234
	bgt %232, %235, .LBB86
	j .LBB102
.LBB86:
	sw %232, %234
	sw %235, %231
	mv %228, %233
	j .LBB42
.LBB40:
	slli %236, %121, 2
	add %237, %42, %236
	slli %239, %121, 2
	lw %238, %237
	add %240, %41, %239
	addiw %241, %121, 1
	sw %238, %240
	mv %121, %241
	j .LBB39
.LBB37:
	slli %242, %119, 2
	add %243, %41, %242
	lw %244, %243
	slli %245, %244, 2
	add %246, %40, %245
	lw %247, %246
	addiw %248, %247, 1
	sw %248, %246
	bgt %248, %249, .LBB87
	j .LBB99
.LBB88:
	addiw %250, %119, 1
	mv %249, %287
	mv %120, %288
	mv %119, %250
	j .LBB36
.LBB87:
	lw %251, %246
	mv %287, %251
	mv %288, %244
	j .LBB88
.LBB35:
	slli %252, %118, 2
	add %253, %40, %252
	addiw %254, %118, 1
	sw zero, %253
	mv %118, %254
	j .LBB34
.LBB31:
	slli %255, %111, 2
	add %256, %41, %255
	lw %257, %256
	mv a0, %257
	call putint
	addiw %258, %111, 1
	mv %111, %258
	j .LBB30
.LBB29:
	subw %259, 32, %110
	subw %260, %259, %103
	blt %261, %260, .LBB89
	j .LBB90
.LBB90:
	addiw %262, %110, 1
	mv %110, %262
	j .LBB28
.LBB89:
	slli %263, %261, 2
	add %264, %41, %263
	addi %267, %264, 4
	lw %265, %264
	addiw %266, %261, 1
	lw %268, %267
	bgt %265, %268, .LBB91
	j .LBB95
.LBB91:
	sw %265, %267
	sw %268, %264
	mv %261, %266
	j .LBB29
.LBB27:
	slli %269, %109, 2
	add %270, %41, %269
	lw %271, %270
	mv a0, %271
	call putint
	addiw %272, %109, 1
	mv %109, %272
	j .LBB26
.LBB25:
	slli %276, %108, 2
	add %277, %41, %276
	slli %273, %107, 2
	lw %278, %277
	add %274, %41, %273
	lw %275, %274
	subw %280, %108, %103
	sw %278, %274
	addiw %279, %107, 1
	sw %275, %277
	mv %107, %279
	mv %108, %280
	j .LBB24
.LBB23:
	slli %281, %106, 2
	add %282, %42, %281
	slli %284, %106, 2
	lw %283, %282
	add %285, %41, %284
	addiw %286, %106, 1
	sw %283, %285
	mv %106, %286
	j .LBB22
.LBB92:
	li %107, 0
	li %108, 0
	j .LBB24
.LBB93:
	li %109, 0
	j .LBB26
.LBB94:
	li %110, 0
	j .LBB28
.LBB95:
	mv %261, %266
	j .LBB29
.LBB96:
	li %261, 0
	j .LBB29
.LBB97:
	li %111, 0
	j .LBB30
.LBB98:
	li %249, 0
	li %119, 0
	j .LBB36
.LBB99:
	mv %287, %249
	mv %288, %120
	j .LBB88
.LBB100:
	li %122, 0
	j .LBB41
.LBB101:
	li %228, 0
	j .LBB42
.LBB102:
	mv %228, %233
	j .LBB42
.LBB103:
	li %123, 0
	j .LBB43
.LBB104:
	li %124, 0
	j .LBB45
.LBB105:
	li %125, 1
	j .LBB47
.LBB106:
	li %126, 0
	j .LBB49
.LBB107:
	li %127, 0
	j .LBB51
.LBB108:
	li %129, 0
	j .LBB56
.LBB109:
	li %178, 0
	li %130, 0
	j .LBB58
.LBB110:
	li %131, 0
	j .LBB60
.LBB111:
	li %132, 0
	j .LBB62
.LBB112:
	li %148, 0
	li %133, 0
	j .LBB64
.LBB113:
	li %134, 30
	j .LBB66
.LBB114:
	li %135, 0
	j .LBB68

	sw %53, %52

	srliw %117, %117, 31

	mv a0, %117

	mv a0, %120

	li a2, 31

	call putint

	addiw %142, %134, 1

	mv %148, %290

	sw %157, %155

	sw %159, %41

	addw %163, %148, %162

	addiw %169, %132, 1

	call putint

	lw %176, %175

	addiw %181, %130, 1

	addiw %187, %129, 1

	call putint

	addiw %197, %127, 1

	call putint

	subw %205, %125, %103

	add %208, %41, %207

	subw %211, %206, %103

	addiw %215, %125, 1

	addiw %221, %124, 1

	call putint

	subw %226, 32, %122

	addiw %233, %228, 1

	sw %232, %234

	addiw %241, %121, 1

	addiw %248, %247, 1

	mv %249, %287

	lw %251, %246

	addiw %254, %118, 1

	call putint

	subw %259, 32, %110

	addiw %266, %261, 1

	sw %265, %267

	call putint

	sw %275, %277

	addiw %286, %106, 1

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

	addiw %286, %106, 1

	sw %275, %277

	call putint

	sw %265, %267

	addiw %266, %261, 1

	subw %259, 32, %110

	call putint

	addiw %254, %118, 1

	lw %251, %246

	mv %249, %287

	addiw %248, %247, 1

	addiw %241, %121, 1

	sw %232, %234

	addiw %233, %228, 1

	subw %226, 32, %122

	call putint

	addiw %221, %124, 1

	addiw %215, %125, 1

	subw %211, %206, %103

	add %208, %41, %207

	subw %205, %125, %103

	call putint

	addiw %197, %127, 1

	call putint

	addiw %187, %129, 1

	addiw %181, %130, 1

	lw %176, %175

	call putint

	addiw %169, %132, 1

	addw %163, %148, %162

	sw %159, %41

	sw %157, %155

	mv %148, %290

	addiw %142, %134, 1

	call putint

	li a2, 31

	mv a0, %120

	mv a0, %117

	srliw %117, %117, 31

	sw %53, %52

