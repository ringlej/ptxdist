# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ELFKICKERS) += host-elfkickers

#
# Paths and names
#
HOST_ELFKICKERS_VERSION	:= 2.0a
HOST_ELFKICKERS_SUFFIX	:= tar.gz
HOST_ELFKICKERS		:= elfkickers-$(HOST_ELFKICKERS_VERSION).orig
HOST_ELFKICKERS_TARBALL	:= elfkickers_$(HOST_ELFKICKERS_VERSION).orig.$(HOST_ELFKICKERS_SUFFIX)
HOST_ELFKICKERS_URL	:= http://archive.ubuntu.com/ubuntu/pool/universe/e/elfkickers/$(HOST_ELFKICKERS_TARBALL)
HOST_ELFKICKERS_SOURCE	:= $(SRCDIR)/$(HOST_ELFKICKERS_TARBALL)
HOST_ELFKICKERS_DIR	:= $(HOST_BUILDDIR)/$(HOST_ELFKICKERS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_ELFKICKERS_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_ELFKICKERS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ELFKICKERS_MAKE_ENV := $(HOST_ENV_CC)
HOST_ELFKICKERS_CONF_TOOL := NO

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-elfkickers.install:
	@$(call targetinfo)
	cp "$(HOST_ELFKICKERS_DIR)/sstrip/sstrip" "$(PTXDIST_SYSROOT_HOST)/bin"
	@$(call touch)

# vim: syntax=make
