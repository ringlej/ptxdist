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
# Prepare
# ----------------------------------------------------------------------------

HOST_NCURSES_PATH	:= PATH=$(HOST_PATH)
HOST_NCURSES_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_NCURSES_AUTOCONF	= \
	$(HOST_AUTOCONF) \
	$(NCURSES_AUTOCONF_SHARED)

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
	install -D -m 755 $(HOST_NCURSES_DIR)/ncurses/make_keys \
		$(HOST_NCURSES_PKGDIR)/bin/make_keys
	install -D -m 755 $(HOST_NCURSES_DIR)/ncurses/make_hash \
		$(HOST_NCURSES_PKGDIR)/bin/make_hash
	@$(call touch)

# vim: syntax=make
