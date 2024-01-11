%option outfile="scanner.cpp" header-file="scanner.hpp"

%{
#define YY_DECL yy::parser::symbol_type yylex(void)
#include "parser.hpp"
#include <iostream>
%}
T_int int
T_float float
T_void void
T_const const
T_break break
T_while while
T_if if
T_else else
T_return return
T_continue continue

identifier ([a-zA-Z]|_)([a-zA-Z]|[0-9]|_)*

HEXPREFIX (0x)|(0X)
OCTALPREFIX 0

HEX_FLOAT_TAIL [pP][+-]?{HEXNUM}
DEC_FLOAT_TAIL [eE][+-]?{DECIMALNUM}

OCTALNUM [0-7]
HEXNUM [0-9a-fA-F]
DECIMALNUM [0-9]

HEX {HEXPREFIX}{HEXNUM}*
OCTAL {OCTALPREFIX}{OCTALNUM}*
DECIMAL [1-9]{DECIMALNUM}*

HEX_FLOAT_FORM1 {HEXPREFIX}{HEXNUM}*\.{HEXNUM}+{HEX_FLOAT_TAIL}?
HEX_FLOAT_FORM2 {HEXPREFIX}{HEXNUM}+\.?{HEX_FLOAT_TAIL}

DEC_FLOAT_FORM1 {DECIMALNUM}*\.{DECIMALNUM}+{DEC_FLOAT_TAIL}?
DEC_FLOAT_FORM2 {DECIMALNUM}+\.?{DEC_FLOAT_TAIL}

HEX_FLOAT {HEX_FLOAT_FORM1}|{HEX_FLOAT_FORM2}
DEC_FLOAT {DEC_FLOAT_FORM1}|{DEC_FLOAT_FORM2}

FLOAT {DEC_FLOAT}|{HEX_FLOAT}

ADD "+"
DEL "-"
MUL "*"
DIV "/"
MOD "%"
BIG ">"
BIG_Equ ">="
SMALL "<"
SMALL_Equ "<="
EquEqu "=="
Equ "="
NotEqu "!="
NOT "!"
AND "&&"
OR "||"


L_brace "{"
R_brace "}"
L_paren "["
R_paren "]"
L_brack "("
R_brack ")"
Colon ";"
Comma ","
Single_Quote "\'"
Double_Quote "\""
Sharp "#"

%x COMMENT

%%
{T_int} {std::cout<<"T_int\n";return yy::parser::make_Y_INT();}
{T_float} {std::cout<<"T_float\n";return yy::parser::make_Y_FLOAT();}
{T_void} {std::cout<<"T_void\n";return yy::parser::make_Y_VOID();}
{T_const} {std::cout<<"T_const\n";return yy::parser::make_Y_CONST();}
{T_break} {std::cout<<"T_break\n";return yy::parser::make_Y_BREAK();}
{T_while} {std::cout<<"T_while\n";return yy::parser::make_Y_WHILE();}
{T_if} {std::cout<<"T_if\n";return yy::parser::make_Y_IF();}
{T_else} {std::cout<<"T_else\n";return yy::parser::make_Y_ELSE();}
{T_return} {std::cout<<"T_return\n";return yy::parser::make_Y_RETURN();}
{T_continue} {std::cout<<"T_continue\n";return yy::parser::make_Y_CONTINUE();}

{identifier} {std::cout<<"Identifier: "<<yytext<<"\n";return yy::parser::make_Y_ID(yytext);} 

{FLOAT} {std::cout<<"ConstValue: "<<yytext<<"\n";return yy::parser::make_num_FLOAT(std::stof(yytext));}
{HEX} {std::cout<<"ConstValue: "<<yytext<<"\n";return yy::parser::make_num_INT(std::stoi(yytext,nullptr,16));}
{OCTAL} {std::cout<<"ConstValue: "<<yytext<<"\n";return yy::parser::make_num_INT(std::stoi(yytext,nullptr,8));}
{DECIMAL} {std::cout<<"ConstValue: "<<yytext<<"\n";return yy::parser::make_num_INT(std::stoi(yytext));}

{ADD} {std::cout<<"ADD"<<"\n";return yy::parser::make_Y_ADD();}
{DEL} {std::cout<<"DEL"<<"\n";return yy::parser::make_Y_SUB();}
{MUL} {std::cout<<"MUL"<<"\n";return yy::parser::make_Y_MUL();}
{MOD} {std::cout<<"MOD"<<"\n";return yy::parser::make_Y_MODULO();}
{DIV} {std::cout<<"DIV"<<"\n";return yy::parser::make_Y_DIV();}
{BIG} {std::cout<<"BIG"<<"\n";return yy::parser::make_Y_GREAT();}
{BIG_Equ} {std::cout<<"BIG_Equ"<<"\n";return yy::parser::make_Y_GREATEQ();}
{SMALL} {std::cout<<"SMALL"<<"\n";return yy::parser::make_Y_LESS();}
{SMALL_Equ} {std::cout<<"SMALL_Equ"<<"\n";return yy::parser::make_Y_LESSEQ();}
{EquEqu} {std::cout<<"EquEqu"<<"\n";return yy::parser::make_Y_EQ();}
{Equ} {std::cout<<"Equ"<<"\n";return yy::parser::make_Y_ASSIGN();}
{NotEqu} {std::cout<<"NotEqu"<<"\n";return yy::parser::make_Y_NOTEQ();}
{NOT} {std::cout<<"NOT"<<"\n";return yy::parser::make_Y_NOT();}
{AND} {std::cout<<"AND"<<"\n";return yy::parser::make_Y_AND();}
{OR} {std::cout<<"OR"<<"\n";return yy::parser::make_Y_OR();}
"(" {std::cout<<yytext<<"\n";return yy::parser::make_Y_LPAR();}
")"	{std::cout<<yytext<<"\n";return yy::parser::make_Y_RPAR();}
"["	{std::cout<<yytext<<"\n";return yy::parser::make_Y_LSQUARE();}
"]"	{std::cout<<yytext<<"\n";return yy::parser::make_Y_RSQUARE();}
"{"	{std::cout<<yytext<<"\n";return yy::parser::make_Y_LBRACKET();}
"}"	{std::cout<<yytext<<"\n";return yy::parser::make_Y_RBRACKET();}
{Colon} {std::cout<<yytext<<"\n";return yy::parser::make_Y_SEMICOLON();}
{Comma} {std::cout<<yytext<<"\n";return yy::parser::make_Y_COMMA();}

<<EOF>>  {return yy::parser::make_YYEOF();}

"//".*        {}
"/*" {BEGIN COMMENT;}
<COMMENT>"*/" {BEGIN INITIAL;}
<COMMENT>.|\n {}
.|\n {}
%%

int yywrap(){
	return 1;//terminate
}