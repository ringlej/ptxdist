# -*-makefile-*-
#
# Copyright (C) 2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BSDIFF) += bsdiff

#
# Paths and names
#
BSDIFF_VERSION	:= 4.3
BSDIFF_MD5	:= e6d812394f0e0ecc8d5df255aa1db22a
BSDIFF		:= bsdiff-$(BSDIFF_VERSION)
BSDIFF_SUFFIX	:= tar.gz
BSDIFF_URL	:= http://www.daemonology.net/bsdiff/$(BSDIFF).$(BSDIFF_SUFFIX)
BSDIFF_SOURCE	:= $(SRCDIR)/$(BSDIFF).$(BSDIFF_SUFFIX)
BSDIFF_DIR	:= $(BUILDDIR)/$(BSDIFF)
BSDIFF_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
BSDIFF_AUTOCONF_CONF_TOOL := NO
BSDIFF_MAKE_ENV := $(CROSS_ENV) PREFIX=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bsdiff.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bsdiff)
	@$(call install_fixup, bsdiff,PRIORITY,optional)
	@$(call install_fixup, bsdiff,SECTION,base)
	@$(call install_fixup, bsdiff,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, bsdiff,DESCRIPTION,missing)

	@$(call install_copy, bsdiff, 0, 0, 0755, -, /usr/bin/bsdiff)
	@$(call install_copy, bsdiff, 0, 0, 0755, -, /usr/bin/bspatch)

	@$(call install_finish, bsdiff)
	@$(call touch)

# vim: syntax=make
