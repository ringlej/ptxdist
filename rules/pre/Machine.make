# -*-makefile-*-
#
# This file contains global machine/cpu dependent definitions.
#
# Copyright (C) 2011 by Stephan Linz <linz@li-pro.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# ----------------------------------------------------------------------------
# Machine & CPU Defines (mainly SoftCPU)
# ----------------------------------------------------------------------------

#
# Xilinx MicroBlaze, SoftCPU inside a FPGA
#
ifdef PTXCONF_ARCH_MICROBLAZE

  # Use defines by Xilinx BSP (borrowed from Linux kernel)
  ifdef PTXCONF_ARCH_MICROBLAZE_HAVE_XLBSP

    # What CPU vesion are we building for, and crack it open
    # as major.minor.rev
    CPU_VER   := $(shell echo $(PTXCONF_XILINX_MICROBLAZE0_HW_VER))
    CPU_MAJOR := $(shell echo $(CPU_VER) | cut -d '.' -f 1)
    CPU_MINOR := $(shell echo $(CPU_VER) | cut -d '.' -f 2)
    CPU_REV   := $(shell echo $(CPU_VER) | cut -d '.' -f 3)

    export CPU_VER CPU_MAJOR CPU_MINOR CPU_REV

    # Use cpu-related PTXCONF_ vars to set compile options.
    # The various PTXCONF_XILINX cpu features options are integers 0/1/2...
    # rather than bools y/n

    # Work out HW multiplier support.  This is icky.
    # 1. Spartan2 has no HW multipliers.
    # 2. MicroBlaze v3.x always uses them, except in Spartan 2
    # 3. All other FPGa/CPU ver combos, we can trust the PTXCONF_ settings
    ifeq (,$(findstring spartan2,$(PTXCONF_XILINX_MICROBLAZE0_FAMILY)))
      ifeq ($(CPU_MAJOR),3)
        CPUFLAGS-1 += -mno-xl-soft-mul
      else
        # USE_HW_MUL can be 0, 1, or 2, defining a heirarchy of HW Mul support.
        CPUFLAGS-$(subst 1,,$(PTXCONF_XILINX_MICROBLAZE0_USE_HW_MUL)) += -mxl-multiply-high
        CPUFLAGS-$(PTXCONF_XILINX_MICROBLAZE0_USE_HW_MUL) += -mno-xl-soft-mul
      endif
    endif
    CPUFLAGS-$(PTXCONF_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
    CPUFLAGS-$(PTXCONF_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
    CPUFLAGS-$(PTXCONF_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare

    ifdef PTXCONF_HAS_HARDFLOAT
       # XILINX_MICROBLAZE0_USE_FPU can be 0 (NONE), 1 (BASIC), or 2 (EXTENDED)
      CPUFLAGS-$(PTXCONF_XILINX_MICROBLAZE0_USE_FPU) += -mhard-float
      CPUFLAGS-$(subst 1,,$(PTXCONF_XILINX_MICROBLAZE0_USE_FPU)) += -mxl-float-convert
      CPUFLAGS-$(subst 1,,$(PTXCONF_XILINX_MICROBLAZE0_USE_FPU)) += -mxl-float-sqrt
    endif

    CPUFLAGS-1 += -mcpu=v$(CPU_VER)

    CPUFLAGS := $(CPUFLAGS-1) $(CPUFLAGS-2)

    PTXCONF_TARGET_EXTRA_CFLAGS += $(CPUFLAGS)
    PTXCONF_TARGET_EXTRA_CXXFLAGS += $(CPUFLAGS)

  endif # PTXCONF_ARCH_MICROBLAZE_HAVE_XLBSP

endif # PTXCONF_ARCH_MICROBLAZE

