# -*-makefile-*-
# $Id: Virtual.make,v 1.4 2003/10/23 15:08:11 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# ----------------------------------------------------------------------------
# xchain
# ----------------------------------------------------------------------------

virtual-xchain_install: $(STATEDIR)/virtual-xchain.install

ifdef PTXCONF_BUILD_CROSSCHAIN
virtual-xchain_install_deps	= $(STATEDIR)/xchain-gccstage2.install
endif 

$(STATEDIR)/virtual-xchain.install: $(virtual-xchain_install_deps)
	@$(call targetinfo, $@)
	touch $@