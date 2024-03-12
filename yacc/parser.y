//parser.y token的定义交给bison来做了

//prologue
%code requires{
#include "AST_NODE.hpp"
#include "Singleton.hpp"
};

%code{
extern yy::parser::symbol_type yylex();
namespace yy
{
  // Report an error to the user.
  auto parser::error (location_type const& loc,const std::string& msg) -> void
  {
    std::cerr <<loc.begin <<" "<< msg << '\n';
  }
}
}


//bison 版本
%require "3.2"
//语言
%language "c++" 
//语义值存储的方式(C++中Union不是很方便)
%define api.value.type variant
//要求Bison生成make_NUMBER这种函数(如果没有这个,在flex中构造函数错误写错了可能可以过编译)
%define api.token.constructor
//生成header,flex需要用Bison++自动定义的类
%header "parser.hpp"
%output "parser.cpp"
%locations
%define api.location.type {LocType}
// %no-lines
//token的enum前缀

//token定义
//语法:
//%token <C++ typename> TOKEN的enum名字 ;
%token Y_INT
%token Y_FLOAT
%token Y_VOID
%token Y_CONST
%token Y_BREAK
%token Y_WHILE
%token Y_IF
%token Y_ELSE
%token Y_RETURN
%token Y_CONTINUE
%token <std::string> Y_ID
%token <float> num_FLOAT
%token <int> num_INT
%token Y_ADD
%token Y_SUB
%token Y_MUL
%token Y_MODULO
%token Y_DIV
%token Y_GREAT
%token Y_GREATEQ
%token Y_LESS
%token Y_LESSEQ
%token Y_EQ
%token Y_ASSIGN
%token Y_NOTEQ
%token Y_NOT
%token Y_AND
%token Y_OR
%token Y_LPAR
%token Y_RPAR
%token Y_LSQUARE
%token Y_RSQUARE
%token Y_LBRACKET
%token Y_RBRACKET
%token Y_SEMICOLON
%token Y_COMMA

///none terminator定义
%nterm <CompUnit*> CompUnit
%nterm <Stmt*> Decl
%nterm <ConstDecl*> ConstDecl
%nterm <ConstDefs*> ConstDefs
%nterm <ConstDef*> ConstDef
%nterm <Exps*> ConstExps
%nterm <InitVal*> ConstInitVal
%nterm <InitVals*> ConstInitVals
%nterm <InitVal*> InitVal
%nterm <InitVals*> InitVals
%nterm <VarDecl*> VarDecl
%nterm <VarDefs*> VarDefs
%nterm <VarDef*> VarDef
%nterm <FuncDef*> FuncDef
%nterm <FuncParams*> FuncParams
%nterm <FuncParam*> FuncParam
%nterm <Block*> Block
%nterm <BlockItems*> BlockItems
%nterm <Stmt*> BlockItem
%nterm <Stmt*> Stmt
%nterm <LVal*> LVal
%nterm <HasOperand*> PrimaryExp
%nterm <CallParams*> CallParams
%nterm <UnaryExp*> UnaryExp
%nterm <MulExp*> MulExp
%nterm <AddExp*> AddExp
%nterm <RelExp*> RelExp
%nterm <EqExp*> EqExp
%nterm <LAndExp*> LAndExp
%nterm <LOrExp*> LOrExp
%nterm <AST_Type> Type
%nterm <Exps*> ArraySubscripts

%start GrammarEntrance

//ACTION部分
%%

GrammarEntrance: CompUnit {Singleton<CompUnit*>()=$1;}

CompUnit: Decl CompUnit {$$=$2;$$->push_front((AST_NODE*)$1);$$->SET(@1);}
        | FuncDef CompUnit {$$=$2;$$->push_front((AST_NODE*)$1);$$->SET(@1);}
        | Decl {$$=new CompUnit((AST_NODE*)$1);$$->SET(@1);}
        | FuncDef {$$=new CompUnit((AST_NODE*)$1);$$->SET(@1);}
        ;

Decl: ConstDecl {$$=(Stmt*)$1;$$->SET(@1);}
    | VarDecl {$$=(Stmt*)$1;$$->SET(@1);}
    ;

ConstDecl: Y_CONST Type ConstDefs Y_SEMICOLON {$$=new ConstDecl($2,$3);$$->SET(@1);}
         ;

ConstDefs: ConstDefs Y_COMMA ConstDef {$$=$1;$1->push_back($3);$$->SET(@1);}
         | ConstDef {$$=new ConstDefs($1);$$->SET(@1);}
         ;

ConstDef: Y_ID Y_ASSIGN ConstInitVal {$$=new ConstDef($1,nullptr,$3);$$->SET(@1);}
        | Y_ID ConstExps Y_ASSIGN ConstInitVal {$$=new ConstDef($1,$2,$4);$$->SET(@1);}
        ;

ConstExps: Y_LSQUARE AddExp Y_RSQUARE {$$=new Exps($2);$$->SET(@1);}
         | Y_LSQUARE AddExp Y_RSQUARE ConstExps {$$=$4;$$->push_front($2);$$->SET(@1);}
         ;

ConstInitVal: AddExp {$$=new InitVal((AST_NODE*)$1);$$->SET(@1);}
            | Y_LBRACKET Y_RBRACKET {$$=new InitVal();$$->SET(@1);}
            | Y_LBRACKET ConstInitVals Y_RBRACKET {$$=new InitVal((AST_NODE*)$2);$$->SET(@1);}
            ;

ConstInitVals: ConstInitVal {$$=new InitVals($1);$$->SET(@1);}
             | ConstInitVals Y_COMMA ConstInitVal {$$=$1;$$->push_back($3);$$->SET(@1);}
             ;

VarDecl: Type VarDefs Y_SEMICOLON {$$=new VarDecl($1,$2);$$->SET(@1);}
       ;

VarDefs: VarDef {$$=new VarDefs($1);$$->SET(@1);}
       | VarDefs Y_COMMA VarDef {$$=$1;$$->push_back($3);$$->SET(@1);}
       ;

VarDef: Y_ID {$$=new VarDef($1);$$->SET(@1);}
      | Y_ID Y_ASSIGN InitVal {$$=new VarDef($1,nullptr,$3);$$->SET(@1);}
      | Y_ID ConstExps {$$=new VarDef($1,$2,nullptr);$$->SET(@1);}
      | Y_ID ConstExps Y_ASSIGN InitVal {$$=new VarDef($1,$2,$4);$$->SET(@1);}
      ;

InitVal: AddExp {$$=new InitVal((AST_NODE*)$1);$$->SET(@1);}
       | Y_LBRACKET Y_RBRACKET {$$=new InitVal(nullptr);$$->SET(@1);}
       | Y_LBRACKET InitVals Y_RBRACKET {$$=new InitVal((AST_NODE*)$2);$$->SET(@1);}
       ;

InitVals: InitVal {$$=new InitVals($1);$$->SET(@1);}
        | InitVals Y_COMMA InitVal {$$=$1;$$->push_back($3);$$->SET(@1);}
        ;

FuncDef: Type Y_ID Y_LPAR Y_RPAR Block {$$=new FuncDef($1,$2,nullptr,$5);$$->SET(@1);}
       | Type Y_ID Y_LPAR FuncParams Y_RPAR Block {$$=new FuncDef($1,$2,$4,$6);$$->SET(@1);}
       ; 

FuncParams: FuncParam {$$=new FuncParams($1);$$->SET(@1);}
          | FuncParams Y_COMMA FuncParam {$$=$1;$$->push_back($3);$$->SET(@1);}
          ;

FuncParam: Type Y_ID {$$=new FuncParam($1,$2);$$->SET(@1);}
         | Type Y_ID Y_LSQUARE Y_RSQUARE {$$=new FuncParam($1,$2,true);$$->SET(@1);}
         | Type Y_ID ArraySubscripts {$$=new FuncParam($1,$2,false,$3);$$->SET(@1);}
         | Type Y_ID Y_LSQUARE Y_RSQUARE ArraySubscripts {$$=new FuncParam($1,$2,true,$5);$$->SET(@1);}
         ;

Block: Y_LBRACKET BlockItems Y_RBRACKET {$$=new Block($2);$$->SET(@1);}
     | Y_LBRACKET Y_RBRACKET {$$=new Block(nullptr);$$->SET(@1);}
     ;

BlockItems: BlockItem {$$=new BlockItems($1);$$->SET(@1);}
          | BlockItems BlockItem {$$=$1;$$->push_back($2);$$->SET(@1);}
          ;

BlockItem: Decl {$$=(Stmt*)$1;$$->SET(@1);}
         | Stmt {$$=(Stmt*)$1;$$->SET(@1);}
         ;

Stmt: LVal Y_ASSIGN AddExp Y_SEMICOLON {$$=new AssignStmt($1,$3);$$->SET(@1);}
    | Y_SEMICOLON {$$=new ExpStmt(nullptr);$$->SET(@1);}
    | AddExp Y_SEMICOLON {$$=new ExpStmt($1);$$->SET(@1);}
    | Block {$$=$1;$$->SET(@1);}
    | Y_WHILE Y_LPAR LOrExp Y_RPAR Stmt {$$=new WhileStmt($3,$5);$$->SET(@1);}
    | Y_IF Y_LPAR LOrExp Y_RPAR Stmt Y_ELSE Stmt {$$=new IfStmt($3,$5,$7);$$->SET(@1);}
    | Y_IF Y_LPAR LOrExp Y_RPAR Stmt {$$=new IfStmt($3,$5);$$->SET(@1);}
    | Y_BREAK Y_SEMICOLON {$$=new BreakStmt();$$->SET(@1);}
    | Y_CONTINUE Y_SEMICOLON {$$=new ContinueStmt();$$->SET(@1);}
    | Y_RETURN AddExp Y_SEMICOLON {$$=new ReturnStmt($2);$$->SET(@1);}
    | Y_RETURN Y_SEMICOLON {$$=new ReturnStmt();$$->SET(@1);}
    ;

LVal: Y_ID {$$=new LVal($1);$$->SET(@1);}
    | Y_ID ArraySubscripts {$$=new LVal($1,$2);$$->SET(@1);}
    ;

ArraySubscripts: Y_LSQUARE AddExp Y_RSQUARE {$$=new Exps($2);$$->SET(@1);}
               | Y_LSQUARE AddExp Y_RSQUARE ArraySubscripts {$$=$4;$$->push_front($2);$$->SET(@1);}
               ;

PrimaryExp: Y_LPAR AddExp Y_RPAR {$$=(HasOperand*)$2;$$->SET(@1);}
          | LVal {$$=(HasOperand*)$1;$$->SET(@1);}
          | num_INT {$$=(HasOperand*)(new ConstValue<int>($1));$$->SET(@1);}
          | num_FLOAT {$$=(HasOperand*)(new ConstValue<float>($1));$$->SET(@1);}
          | Y_ID Y_LPAR Y_RPAR {$$=(HasOperand*)(new FunctionCall($1));$$->SET(@1);}
          | Y_ID Y_LPAR CallParams Y_RPAR {$$=(HasOperand*)(new FunctionCall($1,$3));$$->SET(@1);}
          ;

UnaryExp: PrimaryExp {$$=new UnaryExp($1);$$->SET(@1);}
        | Y_ADD UnaryExp {$$=$2;$$->push_front(AST_ADD);$$->SET(@1);}
        | Y_SUB UnaryExp {$$=$2;$$->push_front(AST_SUB);$$->SET(@1);}
        | Y_NOT UnaryExp {$$=$2;$$->push_front(AST_NOT);$$->SET(@1);}
        ;

CallParams: AddExp {$$=new CallParams($1);$$->SET(@1);}
          | AddExp Y_COMMA CallParams {$$=$3;$$->push_front($1);$$->SET(@1);}
          ;

MulExp: UnaryExp {$$=new MulExp($1);$$->SET(@1);}
      | MulExp Y_MUL UnaryExp {$$=$1;$$->push_back(AST_MUL);$$->push_back($3);$$->SET(@1);}
      | MulExp Y_DIV UnaryExp {$$=$1;$$->push_back(AST_DIV);$$->push_back($3);$$->SET(@1);}
      | MulExp Y_MODULO UnaryExp {$$=$1;$$->push_back(AST_MODULO);$$->push_back($3);$$->SET(@1);}

AddExp: MulExp {$$=new AddExp($1);$$->SET(@1);}
      | AddExp Y_ADD MulExp {$$=$1;$$->push_back(AST_ADD);$$->push_back($3);$$->SET(@1);}
      | AddExp Y_SUB MulExp {$$=$1;$$->push_back(AST_SUB);$$->push_back($3);$$->SET(@1);}

RelExp: AddExp {$$=new RelExp($1);$$->SET(@1);}
      | AddExp Y_LESS RelExp {$$=$3;$$->push_front(AST_LESS);$$->push_front($1);$$->SET(@1);}
      | AddExp Y_GREAT RelExp {$$=$3;$$->push_front(AST_GREAT);$$->push_front($1);$$->SET(@1);}
      | AddExp Y_LESSEQ RelExp {$$=$3;$$->push_front(AST_LESSEQ);$$->push_front($1);$$->SET(@1);}
      | AddExp Y_GREATEQ RelExp {$$=$3;$$->push_front(AST_GREATEQ);$$->push_front($1);$$->SET(@1);}

EqExp: RelExp {$$=new EqExp($1);$$->SET(@1);}
     | RelExp Y_EQ EqExp {$$=$3;$$->push_front(AST_EQ);$$->push_front($1);$$->SET(@1);}
     | RelExp Y_NOTEQ EqExp {$$=$3;$$->push_front(AST_NOTEQ);$$->push_front($1);$$->SET(@1);}

LAndExp: EqExp {$$=new LAndExp($1);$$->SET(@1);}
       | EqExp Y_AND LAndExp {$$=$3;$$->push_front(AST_AND);$$->push_front($1);$$->SET(@1);}

LOrExp: LAndExp {$$=new LOrExp($1);$$->SET(@1);}
      | LAndExp Y_OR LOrExp {$$=$3;$$->push_front(AST_OR);$$->push_front($1);$$->SET(@1);}

Type: Y_INT {$$=AST_INT;}
    | Y_FLOAT {$$=AST_FLOAT;}
    | Y_VOID {$$=AST_VOID;}

%%
