/*
 * @name@.ld - Linker configuration file
 */

MEMORY
{
	FLASH(rx) : ORIGIN = 0x00001800, LENGTH = 0x0001E800
	SRAM(rwx) : ORIGIN = 0x20000000, LENGTH = 0x00010000
}

SECTIONS
{
	.text :
	{
		_text = .;
		KEEP(*(.isr_vector))
		*(.text*)
		*(.rodata*)
		_etext = .;
	} > FLASH

	.data : AT(ADDR(.text) + SIZEOF(.text))
	{
		_data = .;
		*(vtable)
		*(.data*)
		_edata = .;
	} > SRAM

	.bss :
		{
		_bss = .;
		*(.bss*)
		*(COMMON)
		_ebss = .;
	} > SRAM
}

