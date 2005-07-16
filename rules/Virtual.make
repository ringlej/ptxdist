# -*-makefile-*-
# $Id$
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

ifdef PTXCONF_CROSSTOOL
virtual-xchain_install_deps	= $(STATEDIR)/crosstool.install
endif 

ifdef PTXCONF_IMAGE_IPKG
virtual-xchain_install_deps	=  $(STATEDIR)/hosttool-ipkg-utils.install
virtual-xchain_install_deps	+= $(STATEDIR)/hosttool-fakeroot.install
endif

ifdef PTXCONF_IMAGE_JFFS2                                                                                                                 
virtual-xchain_install_deps	+=  $(STATEDIR)/hosttool-mtd.install
endif

$(STATEDIR)/virtual-xchain.install: $(virtual-xchain_install_deps)
	@$(call targetinfo, $@)
	touch $@
