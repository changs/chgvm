%{
#include <stdio.h>
#include <stdint.h>

int    yylex(void);
void   yyerror(const char *);
FILE * yyin;
FILE * yyout;
void out(uint8_t);

%}

%union {
  uint8_t x;
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
   : INSTR_MOV register_name COMMA register_name { out($1); out($3); out($4); }
   | INSTR_MOV register_name COMMA NUMBER { out($1); out($3); out($4); }
   ;

instruction_add
   : INSTR_ADD register_name { out($1); out($2); }
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

void out(uint8_t optcode)
{
    printf("%02X \n", optcode);
    fwrite(&optcode, sizeof(optcode), 1, yyout);
}

int main(int argc, char **argv)
{
   if(argc == 2)
   {
      if((yyin = fopen(argv[1], "rb")) != NULL)
      {
         yyout = fopen("out.bin", "wb");
         yyparse();
         fclose(yyin);
         fclose(yyout);
      }
   }

   return 0;
}  
