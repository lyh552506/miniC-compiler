%option outfile="scanner.cc" header-file="scanner.hh"

%{
#define YY_DECL yy::parser::symbol_type yylex(void)
#include "parser.tab.hh"
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
{T_int} {return yy::parser::make_Y_INT();}
{T_float} {return yy::parser::make_Y_FLOAT();}
{T_void} {return yy::parser::make_Y_VOID();}
{T_const} {return yy::parser::make_Y_CONST();}
{T_break} {return yy::parser::make_Y_BREAK();}
{T_while} {return yy::parser::make_Y_WHILE();}
{T_if} {return yy::parser::make_Y_IF();}
{T_else} {return yy::parser::make_Y_ELSE();}
{T_return} {return yy::parser::make_Y_RETURN();}
{T_continue} {return yy::parser::make_Y_CONTINUE();}

{identifier} {return yy::parser::make_Y_ID(yytext);} 

{FLOAT} {return yy::parser::make_num_FLOAT(std::stof(yytext));}
{HEX} {return yy::parser::make_num_INT(std::stoi(yytext,nullptr,16));}
{OCTAL} {return yy::parser::make_num_INT(std::stoi(yytext,nullptr,8));}
{DECIMAL} {return yy::parser::make_num_INT(std::stoi(yytext));}

{ADD} {return yy::parser::make_Y_ADD();}
{DEL} {return yy::parser::make_Y_SUB();}
{MUL} {return yy::parser::make_Y_MUL();}
{MOD} {return yy::parser::make_Y_MODULO();}
{DIV} {return yy::parser::make_Y_DIV();}
{BIG} {return yy::parser::make_Y_GREAT();}
{BIG_Equ} {return yy::parser::make_Y_GREATEQ();}
{SMALL} {return yy::parser::make_Y_LESS();}
{SMALL_Equ} {return yy::parser::make_Y_LESSEQ();}
{EquEqu} {return yy::parser::make_Y_EQ();}
{Equ} {return yy::parser::make_Y_ASSIGN();}
{NotEqu} {return yy::parser::make_Y_NOTEQ();}
{NOT} {return yy::parser::make_Y_NOT();}
{AND} {return yy::parser::make_Y_AND();}
{OR} {return yy::parser::make_Y_OR();}
"(" {return yy::parser::make_Y_LPAR();}
")"	{return yy::parser::make_Y_RPAR();}
"["	{return yy::parser::make_Y_LSQUARE();}
"]"	{return yy::parser::make_Y_RSQUARE();}
"{"	{return yy::parser::make_Y_LBRACKET();}
"}"	{return yy::parser::make_Y_RBRACKET();}
{Colon} {return yy::parser::make_Y_SEMICOLON();}
{Comma} {return yy::parser::make_Y_COMMA();}

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