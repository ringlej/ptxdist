# -*-makefile-*-
#
# Copyright (C) 2003-2010 by Marc Kleine-Budde <mkl@pengutronix.de>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_CROSS_DUMMY_STRIP
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/cross-dummy-strip.install.post
endif

ifdef PTXCONF_HOST_FAKEROOT
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/host-fakeroot.install.post
endif

ifdef PTXCONF_HOST_IPKG_UTILS
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/host-ipkg-utils.install.post
endif

ifdef PTXCONF_CROSS_PKG_CONFIG_WRAPPER
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/cross-pkg-config-wrapper.install.post
endif

$(STATEDIR)/virtual-cross-tools.install:
	@$(call targetinfo)
	@$(call touch)


ifdef PTXCONF_HOST_PKG_CONFIG
$(STATEDIR)/virtual-host-tools.install: $(STATEDIR)/host-pkg-config.install.post
endif

ifdef PTXCONF_HOST_CHRPATH
$(STATEDIR)/virtual-host-tools.install: $(STATEDIR)/host-chrpath.install.post
endif

$(STATEDIR)/virtual-host-tools.install:
	@$(call targetinfo)
	@$(call touch)
