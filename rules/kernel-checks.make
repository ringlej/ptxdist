# -*-makefile-*-
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_KERNEL

ifdef PTXCONF_KERNEL_LOCAL_FLAG
ifeq ($(PTXCONF_SETUP_KERNELDIR_PREFIX),)
    $(warning ***)
    $(warning *** PTXCONF_KERNEL_LOCAL_FLAG feature activated, but)
    $(warning *** PTXCONF_SETUP_KERNELDIR_PREFIX is unset!)
    $(warning ***)
    $(warning *** This feature is mainly for developers, who to want have their kernel sources)
    $(warning *** outside of ptxdist. You can turn it off by deselecting "Local kernel tree":)
    $(warning *** "ptxdist platformconfig" -> "Linux kernel" -> "Local kernel tree")
    $(warning ***)
    $(warning *** If you want to use the feature, please enter a proper prefix)
    $(warning *** to your kernel tree)
    $(warning *** "ptxdist setup" -> "Source Directories")
    $(warning ***                 -> "Prefix for kernel trees")
    $(warning *** and specify where to look for your kernel tree)
    $(warning ***)
    $(error )
endif
endif


ifeq ($(PTXCONF_KERNEL_VERSION),)
    $(warning *** PTXCONF_KERNEL_VERSION is empty)
    $(warning *** please run 'ptxdist platformconfig' and activate the kernel)
    $(error )
endif

endif	# PTXCONF_KERNEL

# vim: syntax=make
