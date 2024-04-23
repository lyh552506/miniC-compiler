// #include "Global2Local.hpp"

// void Global2Local::RunOnModule()
// {
//     for(auto& GlobalVarPtr : module.GetGlobalVariable())
//     {
//         Variable* Global = GlobalVarPtr.get();
        
        
//     }
// }
// bool processModule(Module& module) {
//     bool foundEntry = false;
//     bool foundGlobal = false;

//     // Traverse all global variables
//     for (GlobalVariable& global : module.getGlobalList()) {
//         if (global.isFunction()) {
//             // Process function
//             // ...
//         } else {
//             // Process global variable
//             // ...
//         }
//     }

//     if (!foundEntry || !foundGlobal) {
//         return false;
//     }

//     IRBuilder<> builder(module.getContext());
//     builder.SetInsertPoint(&module.getEntryBlock());

//     // Traverse all global variables again
//     for (GlobalVariable& global : module.getGlobalList()) {
//         if (global.isFunction()) {
//             continue;
//         }

//         // Create allocation instruction for global variable
//         // ...

//         // Initialize global variable
//         // ...

//         // Modify function signatures
//         // ...

//         // Modify call instructions
//         // ...

//         // Replace uses of global variables
//         // ...

//         // Delete global variables
//         // ...
//     }

//     return true;
// }

// void initializeArray(IRBuilder<>& builder, Value* storage, ArrayType* arrayType, Value* initialValue, Value* zeroScalar) {
//     Type* elementType = arrayType->getElementType();
//     uint64_t numElements = arrayType->getNumElements();

//     ConstantArray* constantArray = dyn_cast<ConstantArray>(initialValue);
//     if (!constantArray) {
//         // Handle non-constant array initialization
//         // ...
//     }

//     for (uint64_t i = 0; i < numElements; ++i) {
//         // Create GetElementPtrInst instruction to get element address
//         // ...

//         Value* elementValue;
//         if (constantArray) {
//             elementValue = constantArray->getOperand(i);
//         } else {
//             elementValue = zeroScalar;
//         }

//         if (ArrayType* nestedArrayType = dyn_cast<ArrayType>(elementType)) {
//             // Recursively initialize nested array
//             initializeArray(builder, elementAddress, nestedArrayType, elementValue, zeroScalar);
//         } else {
//             // Create StoreInst instruction to store element value
//             // ...
//         }
//     }
// // }