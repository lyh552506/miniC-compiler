%option outfile="scanner.cpp" header-file="scanner.hpp"
%option yylineno

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
HEX_FLOAT_FORM3 {HEXPREFIX}{HEXNUM}+\.

DEC_FLOAT_FORM1 {DECIMALNUM}*\.{DECIMALNUM}+{DEC_FLOAT_TAIL}?
DEC_FLOAT_FORM2 {DECIMALNUM}+\.?{DEC_FLOAT_TAIL}
DEC_FLOAT_FORM3 {DECIMALNUM}+\.

HEX_FLOAT {HEX_FLOAT_FORM1}|{HEX_FLOAT_FORM2}|{HEX_FLOAT_FORM3}
DEC_FLOAT {DEC_FLOAT_FORM1}|{DEC_FLOAT_FORM2}|{DEC_FLOAT_FORM3}

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
{T_int} {return yy::parser::make_Y_INT(LocType(yylineno));}
{T_float} {return yy::parser::make_Y_FLOAT(LocType(yylineno));}
{T_void} {return yy::parser::make_Y_VOID(LocType(yylineno));}
{T_const} {return yy::parser::make_Y_CONST(LocType(yylineno));}
{T_break} {return yy::parser::make_Y_BREAK(LocType(yylineno));}
{T_while} {return yy::parser::make_Y_WHILE(LocType(yylineno));}
{T_if} {return yy::parser::make_Y_IF(LocType(yylineno));}
{T_else} {return yy::parser::make_Y_ELSE(LocType(yylineno));}
{T_return} {return yy::parser::make_Y_RETURN(LocType(yylineno));}
{T_continue} {return yy::parser::make_Y_CONTINUE(LocType(yylineno));}

{identifier} {return yy::parser::make_Y_ID(yytext,LocType(yylineno));} 

{FLOAT} {return yy::parser::make_num_FLOAT(std::stof(yytext),LocType(yylineno));}
{HEX} {return yy::parser::make_num_INT(std::stoi(yytext,nullptr,16),LocType(yylineno));}
{OCTAL} {return yy::parser::make_num_INT(std::stoi(yytext,nullptr,8),LocType(yylineno));}
{DECIMAL} {return yy::parser::make_num_INT(std::stoi(yytext),LocType(yylineno));}

{ADD} {return yy::parser::make_Y_ADD(LocType(yylineno));}
{DEL} {return yy::parser::make_Y_SUB(LocType(yylineno));}
{MUL} {return yy::parser::make_Y_MUL(LocType(yylineno));}
{MOD} {return yy::parser::make_Y_MODULO(LocType(yylineno));}
{DIV} {return yy::parser::make_Y_DIV(LocType(yylineno));}
{BIG} {return yy::parser::make_Y_GREAT(LocType(yylineno));}
{BIG_Equ} {return yy::parser::make_Y_GREATEQ(LocType(yylineno));}
{SMALL} {return yy::parser::make_Y_LESS(LocType(yylineno));}
{SMALL_Equ} {return yy::parser::make_Y_LESSEQ(LocType(yylineno));}
{EquEqu} {return yy::parser::make_Y_EQ(LocType(yylineno));}
{Equ} {return yy::parser::make_Y_ASSIGN(LocType(yylineno));}
{NotEqu} {return yy::parser::make_Y_NOTEQ(LocType(yylineno));}
{NOT} {return yy::parser::make_Y_NOT(LocType(yylineno));}
{AND} {return yy::parser::make_Y_AND(LocType(yylineno));}
{OR} {return yy::parser::make_Y_OR(LocType(yylineno));}
"(" {return yy::parser::make_Y_LPAR(LocType(yylineno));}
")"	{return yy::parser::make_Y_RPAR(LocType(yylineno));}
"["	{return yy::parser::make_Y_LSQUARE(LocType(yylineno));}
"]"	{return yy::parser::make_Y_RSQUARE(LocType(yylineno));}
"{"	{return yy::parser::make_Y_LBRACKET(LocType(yylineno));}
"}"	{return yy::parser::make_Y_RBRACKET(LocType(yylineno));}
{Colon} {return yy::parser::make_Y_SEMICOLON(LocType(yylineno));}
{Comma} {return yy::parser::make_Y_COMMA(LocType(yylineno));}

<<EOF>>  {return yy::parser::make_YYEOF(LocType(yylineno));}

"//".*        {}
"/*" {BEGIN COMMENT;}
<COMMENT>"*/" {BEGIN INITIAL;}
<COMMENT>.|\n {}
.|\n {}
%%

int yywrap(){
	return 1;//terminate
}