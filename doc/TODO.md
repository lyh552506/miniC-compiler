# TODO List

# Build

- [ ] 来个会写 CMake 或者 Makefile 的

# AST

- [√] AST结构设计
- [√] 数据结构设计
- [Running] 粗略实现
- [ ] 细节补全

# LEXER部分

- [ ] 需要更改成 C++形式

# Parser部分

- [ ] 改编parser.y部分语法方便实现
- [ ] 使用bison和设计好的AST实现（在AST设计好的基础上大概率只需要写个bison文件，具体见飞书文档或者代码注释）

# CFG部分

- [ ] CFG存储方式的讨论和实现（十字链表存储图）
- [ ] 在完成基本块划分之后使用->中端优化

# codegen部分

- [ ] 重写codegen函数
- [ ] （在codegen基础上或者同时）完成基本块划分和CFG存储（MemorySSA）