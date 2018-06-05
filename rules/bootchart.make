# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BOOTCHART) += bootchart

#
# Paths and names
#
BOOTCHART_VERSION	:= 0.90.1
BOOTCHART_MD5		:= dd8b06d0a31c2ee92178c5355502eea7
BOOTCHART_SUFFIX	:= tar.gz
BOOTCHART		:= bootchart-$(BOOTCHART_VERSION)
BOOTCHART_TARBALL	:= bootchart_$(BOOTCHART_VERSION)-3.$(BOOTCHART_SUFFIX)
BOOTCHART_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(BOOTCHART_TARBALL)
BOOTCHART_SOURCE	:= $(SRCDIR)/$(BOOTCHART_TARBALL)
BOOTCHART_DIR		:= $(BUILDDIR)/$(BOOTCHART)
BOOTCHART_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BOOTCHART_CONF_TOOL	:= NO
BOOTCHART_MAKE_OPT	:= \
	$(CROSS_ENV_CC)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bootchart.install:
	@$(call targetinfo)
	@install -vD -m755 $(BOOTCHART_DIR)/bootchart-collector \
		$(BOOTCHART_PKGDIR)/usr/lib/bootchart/collector
	@install -vD -m755 $(BOOTCHART_DIR)/bootchart-gather.sh \
		$(BOOTCHART_PKGDIR)/usr/lib/bootchart/gather
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bootchart.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bootchart)
	@$(call install_fixup, bootchart,PRIORITY,optional)
	@$(call install_fixup, bootchart,SECTION,base)
	@$(call install_fixup, bootchart,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, bootchart,DESCRIPTION,missing)

#	# we mount a tmpfs into this dir
	@$(call install_copy, bootchart, 0, 0, 0755, /bc)

	@$(call install_alternative, bootchart, 0, 0, 0755, /usr/sbin/bootchartd)

	@$(call install_copy, bootchart, 0, 0, 0755, -, \
		/usr/lib/bootchart/collector)
	@$(call install_copy, bootchart, 0, 0, 0755, -, \
		/usr/lib/bootchart/gather)

	@$(call install_finish, bootchart)

	@$(call touch)

# vim: syntax=make
