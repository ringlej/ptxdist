# -*-makefile-*-
# $Id: virtual-libcxx.make,v 1.1 2003/11/13 19:28:24 mkl Exp $
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
ifdef PTXCONF_CXX
VIRTUAL += virtual-libcxx
endif 

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

virtual-libcxx_targetinstall: $(STATEDIR)/virtual-libcxx.targetinstall

ifdef PTXCONF_LIBSTDCXX
virtual-libcxx_targetinstall_deps = $(STATEDIR)/xchain-gccstage2.targetinstall
endif 

$(STATEDIR)/virtual-libcxx.targetinstall: $(virtual-libcxx_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@