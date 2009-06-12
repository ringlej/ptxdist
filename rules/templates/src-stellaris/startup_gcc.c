/*
 * GCC startup code
 */

void        stellaris_reset(void);
static void stellaris_nmi(void);
static void stellaris_fault(void);
static void stellaris_default_int(void);

extern int main(void);

static unsigned long stack[64];

/*
 * Reset Vector Table
 */

__attribute__ ((section(".isr_vector")))
void (* const g_pfnVectors[])(void) =
{
    (void (*)(void))((unsigned long)stack + sizeof(stack)),
                                            // The initial stack pointer
    stellaris_reset,                        // The reset handler
    stellaris_nmi,                          // The NMI handler
    stellaris_fault,                        // The hard fault handler
    stellaris_default_int,                  // The MPU fault handler
    stellaris_default_int,                  // The bus fault handler
    stellaris_default_int,                  // The usage fault handler
    0,                                      // Reserved
    0,                                      // Reserved
    0,                                      // Reserved
    0,                                      // Reserved
    stellaris_default_int,                  // SVCall handler
    stellaris_default_int,                  // Debug monitor handler
    0,                                      // Reserved
    stellaris_default_int,                  // The PendSV handler
    stellaris_default_int,                  // The SysTick handler
    stellaris_default_int,                  // GPIO Port A
    stellaris_default_int,                  // GPIO Port B
    stellaris_default_int,                  // GPIO Port C
    stellaris_default_int,                  // GPIO Port D
    stellaris_default_int,                  // GPIO Port E
    stellaris_default_int,                  // UART0 Rx and Tx
    stellaris_default_int,                  // UART1 Rx and Tx
    stellaris_default_int,                  // SSI0 Rx and Tx
    stellaris_default_int,                  // I2C0 Master and Slave
    stellaris_default_int,                  // PWM Fault
    stellaris_default_int,                  // PWM Generator 0
    stellaris_default_int,                  // PWM Generator 1
    stellaris_default_int,                  // PWM Generator 2
    stellaris_default_int,                  // Quadrature Encoder 0
    stellaris_default_int,                  // ADC Sequence 0
    stellaris_default_int,                  // ADC Sequence 1
    stellaris_default_int,                  // ADC Sequence 2
    stellaris_default_int,                  // ADC Sequence 3
    stellaris_default_int,                  // Watchdog timer
    stellaris_default_int,                  // Timer 0 subtimer A
    stellaris_default_int,                  // Timer 0 subtimer B
    stellaris_default_int,                  // Timer 1 subtimer A
    stellaris_default_int,                  // Timer 1 subtimer B
    stellaris_default_int,                  // Timer 2 subtimer A
    stellaris_default_int,                  // Timer 2 subtimer B
    stellaris_default_int,                  // Analog Comparator 0
    stellaris_default_int,                  // Analog Comparator 1
    stellaris_default_int,                  // Analog Comparator 2
    stellaris_default_int,                  // System Control (PLL, OSC, BO)
    stellaris_default_int,                  // FLASH Control
    stellaris_default_int,                  // GPIO Port F
    stellaris_default_int,                  // GPIO Port G
    stellaris_default_int,                  // GPIO Port H
    stellaris_default_int,                  // UART2 Rx and Tx
    stellaris_default_int,                  // SSI1 Rx and Tx
    stellaris_default_int,                  // Timer 3 subtimer A
    stellaris_default_int,                  // Timer 3 subtimer B
    stellaris_default_int,                  // I2C1 Master and Slave
    stellaris_default_int,                  // Quadrature Encoder 1
    stellaris_default_int,                  // CAN0
    stellaris_default_int,                  // CAN1
    stellaris_default_int,                  // CAN2
    stellaris_default_int,                  // Ethernet
    stellaris_default_int,                  // Hibernate
    stellaris_default_int,                  // USB0
    stellaris_default_int,                  // PWM Generator 3
    stellaris_default_int,                  // uDMA Software Transfer
    stellaris_default_int                   // uDMA Error
};

/*
 * The following are constructs created by the linker, indicating where the
 * the "data" and "bss" segments reside in memory. The initializers for the
 * for the "data" segment resides immediately following the "text" segment.
 */
extern unsigned long _etext;
extern unsigned long _data;
extern unsigned long _edata;
extern unsigned long _bss;
extern unsigned long _ebss;

/*
 * This is the code that gets called when the processor first starts execution
 * following a reset event.  Only the absolutely necessary set is performed,
 * after which the application supplied entry() routine is called.  Any fancy
 * actions (such as making decisions based on the reset cause register, and
 * resetting the bits in that register) are left solely in the hands of the
 * application.
 */
void stellaris_reset(void)
{
    unsigned long *src, *dest;

    /* copy the data segment initializers from flash to SRAM */
    src = &_etext;
    for(dest = &_data; dest < &_edata; )
    {
        *dest++ = *src++;
    }

    /*
     * Zero fill the bss segment.  This is done with inline assembly since this
     * will clear the value of dest if it is not kept in a register.
     */
    __asm("    ldr     r0, =_bss\n"
          "    ldr     r1, =_ebss\n"
          "    mov     r2, #0\n"
          "    .thumb_func\n"
          "zero_loop:\n"
          "        cmp     r0, r1\n"
          "        it      lt\n"
          "        strlt   r2, [r0], #4\n"
          "        blt     zero_loop");
    main();
}

static void stellaris_nmi(void)
{
    while(1);
}

static void stellaris_fault(void)
{
    while(1);
}

static void stellaris_default_int(void)
{
    while(1);
}

