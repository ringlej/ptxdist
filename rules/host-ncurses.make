# -*-makefile-*-
#
# Copyright (C) 2008 by mol@pengutronix.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NCURSES) += host-ncurses

#
# Paths and names
#
HOST_NCURSES_DIR	= $(HOST_BUILDDIR)/$(NCURSES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ncurses.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NCURSES_PATH	:= PATH=$(HOST_PATH)
HOST_NCURSES_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_NCURSES_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-ncurses.prepare:
	@$(call targetinfo)
	@$(call clean, $(HOST_NCURSES_DIR)/config.cache)
	cd $(HOST_NCURSES_DIR) && \
		$(HOST_NCURSES_PATH) $(HOST_NCURSES_ENV) \
		./configure $(HOST_NCURSES_AUTOCONF) $(NCURSES_AUTOCONF_SHARED)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ncurses.compile:
	@$(call targetinfo)
	cd $(HOST_NCURSES_DIR)/include && $(HOST_NCURSES_PATH) \
		$(MAKE)
	cd $(HOST_NCURSES_DIR)/ncurses && $(HOST_NCURSES_PATH) \
		$(MAKE) make_keys make_hash
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ncurses.install:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
