#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include <string.h>
#include "plic/plic_driver.h"
#include "encoding.h"
#include <unistd.h>
#include "stdatomic.h"


#define DATA_SIZE 20
int8_t uxrt_tx_data[DATA_SIZE];

#define GPIO_UART1_RX 24
#define GPIO_UART1_TX 25

/**
 * 串口1 波特率115200 用于发送数据
 */

static void uart_init1(int8_t a[DATA_SIZE])
{
		int i=0;
		//IOF0:设置GPIO_UART1_RX和GPIO_UART1_TX的GPIO引脚为IOF0模式
		GPIO_REG(GPIO_IOF_SEL)  &= ~(0x1 << GPIO_UART1_RX) ;
		GPIO_REG(GPIO_IOF_SEL)  &= ~(0x1 << GPIO_UART1_TX) ;

		//IOF0使能:设置GPIO_UART1_RX和GPIO_UART1_TX的GPIO引脚为IOF0模式使能
		GPIO_REG(GPIO_IOF_EN)  |= (0x1 << GPIO_UART1_RX) ;
		GPIO_REG(GPIO_IOF_EN)  |= (0x1 << GPIO_UART1_TX) ;

		//使能UART1 TX发送
		UART1_REG(UART_REG_TXCTRL)  |=   (0x1 << 0) ;
		//UART1 的stop为1bit
		UART1_REG(UART_REG_TXCTRL)  &=   ~(0x1 << 1) ;

		//波特率设置：先将div寄存器清零，再进行赋值操作
		UART1_REG(UART_REG_DIV)  = 0;
		//波特率设置：设置波特率为 115200 时钟频率16M，div=(16M/115200)-1=138
		UART1_REG(UART_REG_DIV) = 138;

		for(i=0;i<DATA_SIZE;i=i+1){
			//当发送缓冲队列不满的时候进行发送数据
			while(UART1_REG(UART_REG_TXFIFO) & 0x80000000);
			UART1_REG(UART_REG_TXFIFO)  = a[i] ;
		}
}
void main(){

	int i=0;
	for(i=0;i<DATA_SIZE;i=i+1){
		uxrt_tx_data[i]=i;
	}
	printf("uart is start");
	uart_init1(uxrt_tx_data);
}
