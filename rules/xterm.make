# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XTERM) += xterm

#
# Paths and names
#
XTERM_VERSION	:= 284
XTERM_MD5	:= fa6bd90b91365f41c6bb895bee054c12
XTERM		:= xterm-$(XTERM_VERSION)
XTERM_SUFFIX	:= tgz
XTERM_URL	:= https://invisible-mirror.net/archives/xterm/$(XTERM).$(XTERM_SUFFIX)
XTERM_SOURCE	:= $(SRCDIR)/$(XTERM).$(XTERM_SUFFIX)
XTERM_DIR	:= $(BUILDDIR)/$(XTERM)
XTERM_LICENSE	:= MIT
XTERM_LICENSE_FILES := \
	file://xterm.h;startline=4;endline=30;md5=1abc86c2506fe2c8138eb8d3bdb785e3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XTERM_PATH	:= PATH=$(CROSS_PATH)
XTERM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XTERM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-freetype \
	--disable-rpath-hack \
	--without-x

#
# "--without-x" is no typo, it means don't look for X using pre
# defined --paths like /usr or /usr/X11, xterm will find X via
# pkg-config then.
#

XTERM_MAKE_OPT := EXTRA_LOADFLAGS=-lICE

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xterm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xterm)
	@$(call install_fixup, xterm,PRIORITY,optional)
	@$(call install_fixup, xterm,SECTION,base)
	@$(call install_fixup, xterm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xterm,DESCRIPTION,missing)

	@$(call install_copy, xterm, 0, 0, 0755, -, $(XORG_BINDIR)/xterm)

	@$(call install_finish, xterm)

	@$(call touch)

# vim: syntax=make
