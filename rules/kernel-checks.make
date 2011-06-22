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

ifeq ($(PTXCONF_KERNEL_VERSION),)
    $(warning *** PTXCONF_KERNEL_VERSION is empty)
    $(warning *** please run 'ptxdist platformconfig' and activate the kernel)
    $(error )
endif

endif	# PTXCONF_KERNEL

# vim: syntax=make
