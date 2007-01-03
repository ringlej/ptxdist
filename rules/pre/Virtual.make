# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2007 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

virtual-cross-tools_install: $(STATEDIR)/virtual-cross-tools.install


ifdef PTXCONF_IMAGE_HOST_DEB
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/host-checkinstall.install
endif

ifdef PTXCONF_IMAGE_JFFS2
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/host-mtd-utils.install
endif


ifdef PTXCONF_HOST_FAKEROOT
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/host-fakeroot.install
endif

ifdef PTXCONF_HOST_IPKG_UTILS
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/host-ipkg-utils.install
endif

ifdef PTXCONF_CROSS_PKG_CONFIG_WRAPPER
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/cross-pkg-config-wrapper.install
endif

$(STATEDIR)/virtual-cross-tools.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)


virtual-host-tools_install: $(STATEDIR)/virtual-host-tools.install

ifdef PTXCONF_HOST_PKG_CONFIG
$(STATEDIR)/virtual-host-tools.install: $(STATEDIR)/host-pkg-config.install
endif

$(STATEDIR)/virtual-host-tools.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)
