%{

#include <stdio.h>

int    yylex(void);
void   yyerror(const char *);
FILE * yyin;

%}

%union {
  int x;
}

%token<x> INSTR_MOV
%token<x> REG_R1 REG_R2 REG_ACC
%token<x> IDENTIFIER NUMBER COMMA COLON SEMICOLON

%type<x> instruction_mov

%start program

%%

register_name
   : REG_R1
   | REG_R2
   | REG_ACC
   ;

instruction_mov
   : INSTR_MOV register_name COMMA register_name { printf("%d %d %d",$1, $1, $3);}
   | INSTR_MOV register_name COMMA NUMBER { printf("%02X %02X %02X\n",$1, $3, $4);}
   ;


instruction
   : instruction_mov SEMICOLON
   ;

program
   : instruction
   | program instruction 
   ;


%%

void yyerror(const char * message)
{
   printf(message);
}

int main(int argc, char **argv)
{
   if(argc == 2)
   {
      if((yyin = fopen(argv[1], "rb")) != NULL)
      {
         yyparse();
         fclose(yyin);
      }
   }

   return 0;
}  
