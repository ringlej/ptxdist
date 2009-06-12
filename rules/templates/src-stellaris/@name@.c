#include <inc/lm3s3748.h>

int main(void)
{
	volatile unsigned long loop;

	/* enable gpio port for the demo kit LED */
	SYSCTL_RCGC2_R = SYSCTL_RCGC2_GPIOF;

	/* do a dummy read to insert a few cycles after enabling the peripheral */
	loop = SYSCTL_RCGC2_R;

	/*
	 * Enable the GPIO pin for the LED (PF0). Set the direction as output, and
	 * enable the GPIO pin for digital function.
	 */
	GPIO_PORTF_DIR_R = 0x01;
	GPIO_PORTF_DEN_R = 0x01;

	/* loop forever */
	while(1) {

		/* LED=on */
		GPIO_PORTF_DATA_R |= 0x01;

		/* delay for some time */
		for(loop = 0; loop < 200000; loop++);

		/* LED=off */
		GPIO_PORTF_DATA_R &= ~(0x01);

		/* delay for some time */
		for(loop = 0; loop < 200000; loop++);
        }
}

