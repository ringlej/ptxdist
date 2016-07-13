# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NINJA) += host-ninja

#
# Paths and names
#
HOST_NINJA_VERSION	:= 1.5.1
HOST_NINJA_MD5		:= 59f4f1cf5d9bb0d7877a6d5a5afd770a
HOST_NINJA		:= ninja-$(HOST_NINJA_VERSION)
HOST_NINJA_SUFFIX	:= tar.gz
HOST_NINJA_URL		:= https://github.com/martine/ninja/archive/v$(HOST_NINJA_VERSION).$(HOST_NINJA_SUFFIX)
HOST_NINJA_SOURCE	:= $(SRCDIR)/$(HOST_NINJA).$(HOST_NINJA_SUFFIX)
HOST_NINJA_DIR		:= $(HOST_BUILDDIR)/$(HOST_NINJA)
HOST_NINJA_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_NINJA_PATH		:= PATH=$(HOST_PATH)

$(STATEDIR)/host-ninja.compile:
	@$(call targetinfo)
	cd $(HOST_NINJA_DIR) && \
		$(HOST_NINJA_PATH) \
		python bootstrap.py
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ninja.install:
	@$(call targetinfo)
	install -D -m755 $(HOST_NINJA_DIR)/ninja $(HOST_NINJA_PKGDIR)/bin/ninja
	@$(call touch)

# vim: syntax=make
