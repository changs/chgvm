%{

#include <stdio.h>

int    yylex(void);
void   yyerror(const char *);
FILE * yyin;

%}

%union {
  int x;
}

%token<x> INSTR_MOV INSTR_ADD
%token<x> REG_R1 REG_R2 REG_ACC
%token<x> IDENTIFIER NUMBER COMMA COLON SEMICOLON

%type<x> instruction_mov
%type<x> register_name
%type<x> instruction_add

%start program

%%

register_name
   : REG_R1
   | REG_R2
   | REG_ACC
   ;

instruction_mov
   : INSTR_MOV register_name COMMA register_name { printf("%02X %02X %02X\n", $1, $3, $4);}
   | INSTR_MOV register_name COMMA NUMBER { printf("%02X %02X %02X\n", $1, $3, $4);}
   ;

instruction_add
   : INSTR_ADD NUMBER { printf("%02X %02X\n", $1, $2); }
   | INSTR_ADD register_name { printf("%02X %02X\n", $1, $2); }
   ;


instruction
   : instruction_mov SEMICOLON
   | instruction_add SEMICOLON
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
