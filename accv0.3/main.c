#include <stdio.h>
#include <stdint.h>
int main(void)
{
  //****************** floatpoint test ********************//
  printf("start floatpoint test ...\n");
    volatile uint32_t* mul_a = 0x11002000UL;
    volatile uint32_t* mul_b = 0x11002004UL;
    volatile uint32_t* res = 0x11002008UL;

    *mul_a = 0x4234851F;
    *mul_b = 0x427c851F;
  printf("result is : %x \n", *res);

  //   *mul_a = 0x4049999a;
  //   *mul_b = 0xc1663d71;
  // printf("result is : %x \n", *res);
  
  printf("calculate finished!\n");


  //****************** encryption test ********************//
  // printf("start encryption test ...\n");
  //   volatile uint32_t* state1 = 0x11000000UL;
  //   volatile uint32_t* state2 = 0x11000004UL;
  //   volatile uint32_t* state3 = 0x11000008UL;
  //   volatile uint32_t* state4 = 0x1100000cUL;
  //   volatile uint32_t* key1 = 0x11000010UL;
  //   volatile uint32_t* key2 = 0x11000014UL;
  //   volatile uint32_t* key3 = 0x11000018UL;
  //   volatile uint32_t* key4 = 0x1100001cUL;
  //   volatile uint32_t* out1 = 0x11000020UL;
  //   volatile uint32_t* out2 = 0x11000024UL;
  //   volatile uint32_t* out3 = 0x11000028UL;
  //   volatile uint32_t* out4 = 0x1100002cUL;

  //   *state1 = 0x11000000;
  //   *state2 = 0x00110000;
  //   *state3 = 0x00001100;
  //   *state4 = 0x00000011;
  //   *key1 = 0x10000000;
  //   *key2 = 0x01000000;
  //   *key3 = 0x00100000;
  //   *key4 = 0x00010000;

  // printf("out1 is : %x \n", *out1);
  // printf("out2 is : %x \n", *out2);
  // printf("out3 is : %x \n", *out3);
  // printf("out4 is : %x \n", *out4);
  // printf("encryption finished!\n");



  //*********************** RRAM test ************************//  
  // printf("start RRAM test ...\n");
  // volatile uint32_t* rram_ptr = 0x50000000UL;
  // for(int i = 0; i < 5; i++){
  //   *(rram_ptr + i) = 0x12345670 + i; 
  // }
  // for(int i = 0; i < 5; i++){
  //   printf("read data %d = %x\n", i, *(rram_ptr+i));
  // }
  // printf("RRAM test finished!\n");

  //*********************** trng test ************************//  
  // printf("start trng test ...\n");
  // volatile uint32_t* trng_ptr = 0x11001000UL;
  // const uint TRNG_CTEN = 14;
  // const uint TRNG_TAP_MASK = 5184; // 32'b1_0100_0100_0000;
  // *trng_ptr = (1<<TRNG_CTEN)|(TRNG_TAP_MASK);
  // for(int i = 0; i < 100; i++){
  //   printf("trng [%d]: %x \n", i, *trng_ptr);
  // }
  // printf("trng test finished!\n");

  return 0;
}