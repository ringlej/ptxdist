# -*-makefile-*-
# $Id: Virtual.make,v 1.3 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# ----------------------------------------------------------------------------
# nchain
# ----------------------------------------------------------------------------

#
# The Nativechain:
#
# Some packets; like glibc-2.3.x  need
# at least gcc-3.2 to build. Simply add a dependency to
# $(STATEDIR)/virtual-nchain.install and the hostchain gets installed.
# 

virtual-nchain_install: $(STATEDIR)/virtual-nchain.install

virtual-nchain_install_deps	= $(addprefix $(STATEDIR)/, $(addsuffix .install, $(NATIVE)))

$(STATEDIR)/virtual-nchain.install: $(virtual-nchain_install_deps)
	@$(call targetinfo, $@)
	touch $@

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