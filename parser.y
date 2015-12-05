%{

#include <stdio.h>

int    yylex(void);
void   yyerror(const char *);
FILE * yyin;

%}

%token INSTR_MOV INSTR_ADD
%token REG_R1 REG_R2 REG_ACC
%token IDENTIFIER NUMBER COMMA COLON SEMICOLON

%start program

%%

register_name
   : REG_R1
   | REG_R2
   | REG_ACC
   ;

instruction_mov
   : INSTR_MOV register_name COMMA register_name
   | INSTR_MOV register_name COMMA NUMBER
   ;

instruction_add
   : INSTR_ADD register_name COMMA register_name COMMA register_name
   | INSTR_ADD register_name COMMA register_name COMMA NUMBER
   ;


instruction
   : instruction_mov
   | instruction_add
   ;

program: instruction SEMICOLON

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
