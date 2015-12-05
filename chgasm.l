%{

#include "parser.tab.h"

%}

%option noyywrap
%option pointer

CT       "//"[^\n]*
WS       [ \n\r\t]+
ID       [_a-zA-Z][_a-zA-Z0-9]*
NUM      [0-9]+

%%

{CT}     {}
{WS}     {}

"mov"    { return INSTR_MOV; }
"add"    { return INSTR_ADD; }

"r1"    { return REG_R1; }
"r2"    { return REG_R2; }
"acc"   { return REG_ACC; }

{NUM}    { return NUMBER; }

","      { return COMMA; }
";"      { return SEMICOLON; }

.        { yyerror("syntax error"); }

