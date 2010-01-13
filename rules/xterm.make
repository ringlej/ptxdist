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
XTERM_VERSION	:= 253
XTERM		:= xterm-$(XTERM_VERSION)
XTERM_SUFFIX	:= tgz
XTERM_URL	:= ftp://invisible-island.net/xterm/$(XTERM).$(XTERM_SUFFIX)
XTERM_SOURCE	:= $(SRCDIR)/$(XTERM).$(XTERM_SUFFIX)
XTERM_DIR	:= $(BUILDDIR)/$(XTERM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XTERM_SOURCE):
	@$(call targetinfo)
	@$(call get, XTERM)

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
	--disable-freetype

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xterm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xterm)
	@$(call install_fixup,xterm,PACKAGE,xterm)
	@$(call install_fixup,xterm,PRIORITY,optional)
	@$(call install_fixup,xterm,VERSION,$(XTERM_VERSION))
	@$(call install_fixup,xterm,SECTION,base)
	@$(call install_fixup,xterm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,xterm,DEPENDS,)
	@$(call install_fixup,xterm,DESCRIPTION,missing)

	@$(call install_copy, xterm, 0, 0, 0755, -, $(XORG_BINDIR)/xterm)

	@$(call install_finish,xterm)

	@$(call touch)

# vim: syntax=make
