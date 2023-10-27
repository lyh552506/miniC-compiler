%{
#include "token_type.h"
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

HEXPREFIX 0x
OCTALPREFIX 0

HEX_FLOAT_TAIL [pP][+-]?{HEXNUM}
DEC_FLOAT_TAIL [eE][+-]?{DECIMALNUM}

OCTALNUM [0-7]
HEXNUM [0-9a-fA-F]
DECIMALNUM [0-9]

HEX {HEXPREFIX}[1-9a-fA-F]{HEXNUM}*
OCTAL {OCTALPREFIX}[1-7]{OCTALNUM}*

INT {HEX}|{OCTAL}|([1-9][0-9]*)|0
INTEGER {INT}(u|U)?(l|L|(ll)|(LL))?


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
{T_int} {return Y_INT;}
{T_float} {return Y_FLOAT;}
{T_void} {return Y_VOID;}
{T_const} {return Y_CONST;}
{T_break} {return Y_BREAK;}
{T_while} {return Y_WHILE;}
{T_if} {return Y_IF;}
{T_else} {return Y_ELSE;}
{T_return} {return Y_RETURN;}
{T_continue} {return Y_CONTINUE;}

{identifier} {return Y_ID;} 

{FLOAT} {return num_FLOAT;}
{INTEGER} {return num_INT;}

{ADD} {return Y_ADD;}
{DEL} {return Y_SUB;}
{MUL} {return Y_MUL;}
{MOD} {return Y_MODULO;}
{DIV} {return Y_DIV;}
{BIG} {return Y_GREAT;}
{BIG_Equ} {return Y_GREATEQ;}
{SMALL} {return Y_LESS;}
{SMALL_Equ} {return Y_LESSEQ;}
{EquEqu} {return Y_EQ;}
{Equ} {return Y_ASSIGN;}
{NotEqu} {return Y_NOTEQ;}
{NOT} {return Y_NOT;}
{AND} {return Y_AND;}
{OR} {return Y_OR;}
"(" {return Y_LPAR;}
")"	{return Y_RPAR;}
"["	{return Y_LSQUARE;}
"]"	{return Y_RSQUARE;}
"{"	{return Y_LBRACKET;}
"}"	{return Y_RBRACKET;}
{Colon} {return Y_SEMICOLON;}
{Comma} {return Y_COMMA;}

"//".*        {}
"/*" {BEGIN COMMENT;}
<COMMENT>"*/" {BEGIN INITIAL;}
<COMMENT>.|\n {}
.|\n {}
%%

int yywrap(){
	return 1;//terminate
}