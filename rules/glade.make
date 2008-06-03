# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Marc Kleine-Buddde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLADE) += glade

#
# Paths and names
#
GLADE_VERSION	:= 3.4.0
GLADE		:= glade3-$(GLADE_VERSION)
GLADE_SUFFIX	:= tar.bz2
GLADE_URL	:= http://ftp.gnome.org/pub/GNOME/sources/glade3/3.4/$(GLADE).$(GLADE_SUFFIX)
GLADE_SOURCE	:= $(SRCDIR)/$(GLADE).$(GLADE_SUFFIX)
GLADE_DIR	:= $(BUILDDIR)/$(GLADE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glade_get: $(STATEDIR)/glade.get

$(STATEDIR)/glade.get: $(glade_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GLADE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GLADE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glade_extract: $(STATEDIR)/glade.extract

$(STATEDIR)/glade.extract: $(glade_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLADE_DIR))
	@$(call extract, GLADE)
	@$(call patchin, GLADE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glade_prepare: $(STATEDIR)/glade.prepare

GLADE_PATH	:= PATH=$(CROSS_PATH)
GLADE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GLADE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gnome \
	--disable-scrollkeeper \
	--disable-python

$(STATEDIR)/glade.prepare: $(glade_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLADE_DIR)/config.cache)
	cd $(GLADE_DIR) && \
		$(GLADE_PATH) $(GLADE_ENV) \
		./configure $(GLADE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glade_compile: $(STATEDIR)/glade.compile

$(STATEDIR)/glade.compile: $(glade_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GLADE_DIR) && $(GLADE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glade_install: $(STATEDIR)/glade.install

$(STATEDIR)/glade.install: $(glade_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GLADE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glade_targetinstall: $(STATEDIR)/glade.targetinstall

$(STATEDIR)/glade.targetinstall: $(glade_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, glade)
	@$(call install_fixup, glade,PACKAGE,glade)
	@$(call install_fixup, glade,PRIORITY,optional)
	@$(call install_fixup, glade,VERSION,$(GLADE_VERSION))
	@$(call install_fixup, glade,SECTION,base)
	@$(call install_fixup, glade,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, glade,DEPENDS,)
	@$(call install_fixup, glade,DESCRIPTION,missing)

	@$(call install_copy, glade, 0, 0, 0755, $(GLADE_DIR)/src/.libs/glade-3, /usr/bin/glade-3)

	@$(call install_finish, glade)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glade_clean:
	rm -rf $(STATEDIR)/glade.*
	rm -rf $(PKGDIR)/glade_*
	rm -rf $(GLADE_DIR)

# vim: syntax=make
