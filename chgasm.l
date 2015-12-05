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

"mov"    { yylval.x=0x01; return INSTR_MOV; }

"r1"    { yylval.x=0x01; return REG_R1; }
"r2"    { yylval.x=0x02; return REG_R2; }
"acc"   { yylval.x=0x03; return REG_ACC; }

{NUM}    { yylval.x=atoi(yytext); return NUMBER; }

","      { return COMMA; }
";"      { return SEMICOLON; }

.        { yyerror("syntax error"); }

