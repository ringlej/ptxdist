#
# For a description of the syntax of this configuration file,
# see extra/config/Kconfig-language.txt
#

config UC_TARGET_ARCH
	default "sh" if UC_CONFIG_SH2 || UC_CONFIG_SH3 || UC_CONFIG_SH4
	default "sh64" if UC_CONFIG_SH5

config UC_HAVE_ELF
	bool
	default y

config UC_ARCH_CFLAGS
	string

config UC_ARCH_LDFLAGS
	string

config UC_LIBGCC_CFLAGS
	string

config UC_HAVE_DOT_HIDDEN
        bool
	default y

config UC_ARCH_SUPPORTS_BIG_ENDIAN
	bool
	default y

config UC_ARCH_SUPPORTS_LITTLE_ENDIAN
	bool
	default y

choice
	prompt "Target Processor Type"
	default UC_CONFIG_SH4
	help
	  This is the processor type of your CPU. This information is used for
	  optimizing purposes, as well as to determine if your CPU has an MMU,
	  an FPU, etc.  If you pick the wrong CPU type, there is no guarantee
	  that uClibc will work at all....

	  Here are the available choices:
	  - "SH2" SuperH SH-2
	  - "SH3" SuperH SH-3
	  - "SH4" SuperH SH-4
	  - "SH5" SuperH SH-5 101, 103

config UC_CONFIG_SH2
	select UC_ARCH_HAS_NO_MMU
	select UC_ARCH_HAS_NO_LDSO
	bool "SH2"

config UC_CONFIG_SH3
	select UC_ARCH_HAS_MMU
	bool "SH3"

config UC_CONFIG_SH4
	select UC_ARCH_HAS_MMU
	select UC_FORCE_SHAREABLE_TEXT_SEGMENTS
	bool "SH4"

config UC_CONFIG_SH5
	select UC_ARCH_HAS_MMU
	select UC_UCLIBC_HAS_LFS
	bool "SH5"

endchoice


