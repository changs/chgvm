#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

uint8_t registers[3];
#define ACC registers[0]

void show_registers();
void check_instruction(uint8_t * instruction, FILE * pBin) {
  uint8_t arguments[2];
  switch(*instruction) {
    case 1: // MOV
      fread(arguments, 2, 1, pBin);
      registers[arguments[0]] = arguments[1];
      break;
    case 2: // ADD
      fread(arguments, 1, 1, pBin);
      ACC = ACC + registers[arguments[0]];
      break;
  }
}

int main(int argc, char **argv) {
  uint8_t instruction[1];

  for(unsigned int i = 0; i < sizeof(registers); ++i) {
    registers[i] = 0;
  }

  FILE * pBin;
  pBin = fopen(argv[1], "rb");
  if(pBin != NULL) {
    while(fread(instruction, 1, 1, pBin) == 1) {
      check_instruction(instruction, pBin);
    }
    fclose(pBin);
  }

  show_registers();
  return 0;
}

void show_registers() {
  for(unsigned int i = 0; i < sizeof(registers); ++i) {
    printf("0x%02X\n", registers[i]);
  }
}
