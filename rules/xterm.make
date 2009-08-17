# -*-makefile-*-
# $Id: template 4761 2006-02-24 17:35:57Z sha $
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
XTERM_VERSION	:= 250
XTERM		:= xterm-$(XTERM_VERSION)
XTERM_SUFFIX	:= tgz
XTERM_URL	:= ftp://invisible-island.net/xterm/$(XTERM).$(XTERM_SUFFIX)
XTERM_SOURCE	:= $(SRCDIR)/$(XTERM).$(XTERM_SUFFIX)
XTERM_DIR	:= $(BUILDDIR)/$(XTERM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xterm_get: $(STATEDIR)/xterm.get

$(STATEDIR)/xterm.get: $(xterm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XTERM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XTERM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xterm_extract: $(STATEDIR)/xterm.extract

$(STATEDIR)/xterm.extract: $(xterm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XTERM_DIR))
	@$(call extract, XTERM)
	@$(call patchin, XTERM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xterm_prepare: $(STATEDIR)/xterm.prepare

XTERM_PATH	:= PATH=$(CROSS_PATH)
XTERM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XTERM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-freetype

$(STATEDIR)/xterm.prepare: $(xterm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XTERM_DIR)/config.cache)
	cd $(XTERM_DIR) && \
		$(XTERM_PATH) $(XTERM_ENV) \
		./configure $(XTERM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xterm_compile: $(STATEDIR)/xterm.compile

$(STATEDIR)/xterm.compile: $(xterm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XTERM_DIR) && $(XTERM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xterm_install: $(STATEDIR)/xterm.install

$(STATEDIR)/xterm.install: $(xterm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XTERM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xterm_targetinstall: $(STATEDIR)/xterm.targetinstall

$(STATEDIR)/xterm.targetinstall: $(xterm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xterm)
	@$(call install_fixup,xterm,PACKAGE,xterm)
	@$(call install_fixup,xterm,PRIORITY,optional)
	@$(call install_fixup,xterm,VERSION,$(XTERM_VERSION))
	@$(call install_fixup,xterm,SECTION,base)
	@$(call install_fixup,xterm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xterm,DEPENDS,)
	@$(call install_fixup,xterm,DESCRIPTION,missing)

	@$(call install_copy, xterm, 0, 0, 0755, $(XTERM_DIR)/xterm, $(XORG_BINDIR)/xterm)

	@$(call install_finish,xterm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xterm_clean:
	rm -rf $(STATEDIR)/xterm.*
	rm -rf $(PKGDIR)/xterm_*
	rm -rf $(XTERM_DIR)

# vim: syntax=make
