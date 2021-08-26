#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include <string.h>
#include "plic/plic_driver.h"
#include "encoding.h"
#include <unistd.h>
#include "stdatomic.h"


int main(void)
{
    
   
    set_csr(mie, MIE_MEIE);

    printf("START Interrupt TEST!""\n");

    
    volatile uint32_t* source8_priority = 0x0C000020UL;
    printf("source8 priority is : %x \n", *source8_priority);
    *source8_priority = 0x1;
    printf("source8 priority's new value is : %x \n", *source8_priority);


    volatile uint32_t* target0_en = 0x0C002000UL;
    printf("target0_en is : %x \n", *target0_en);
    *target0_en = 0x100;
    printf("target0_en's new value is : %x \n", *target0_en);

    volatile uint32_t*  target0_priority_threshold = 0x0C200000UL;
    printf("target0_priority_threshold is : %x \n",*target0_priority_threshold);
    *target0_priority_threshold = 0x0;
    printf("target0_priority_threshold's new value is : %x \n",*target0_priority_threshold);

    volatile uint32_t*  target0_claim_complete = 0x0C200004UL;
    printf("target0_claim_complete is : %x \n",*target0_claim_complete);
    *target0_claim_complete = 0x100;
    printf("target0_claim_complete's new value is : %x \n",*target0_claim_complete);



    __asm volatile("wfi");

    printf("End Interrupt TEST!""\n");

    return 0;
}
