# -*-makefile-*-
# $Id: virtual-libc.make,v 1.2 2003/11/17 03:53:42 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
VIRTUAL += virtual-libc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

virtual-libc_targetinstall: $(STATEDIR)/virtual-libc.targetinstall

ifdef PTXCONF_GLIBC
virtual-libc_targetinstall_deps = $(STATEDIR)/glibc.targetinstall
endif 
ifdef PTXCONF_UCLIBC
virtual-libc_targetinstall_deps = $(STATEDIR)/uclibc.targetinstall
endif 

$(STATEDIR)/virtual-libc.targetinstall: $(virtual-libc_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@