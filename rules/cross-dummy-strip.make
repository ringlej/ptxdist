# -*-makefile-*-
#
# Copyright (C) 2009 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_DUMMY_STRIP) += cross-dummy-strip

$(STATEDIR)/cross-dummy-strip.extract:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/cross-dummy-strip.prepare:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/cross-dummy-strip.compile:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/cross-dummy-strip.install:
	@$(call targetinfo)
	install -D -m 755 $(PTXDIST_TOPDIR)/scripts/dummy-strip.sh $(PTXCONF_SYSROOT_CROSS)/bin/strip
	@$(call touch)

# vim: syntax=make
