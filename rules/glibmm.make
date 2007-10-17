# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIBMM) += glibmm

#
# Paths and names
#
GLIBMM_VERSION	:= 2.14.1
GLIBMM		:= glibmm-$(GLIBMM_VERSION)
GLIBMM_SUFFIX	:= tar.bz2
GLIBMM_URL	:= http://ftp.gnome.org/pub/GNOME/sources/glibmm/2.14/$(GLIBMM).$(GLIBMM_SUFFIX)
GLIBMM_SOURCE	:= $(SRCDIR)/$(GLIBMM).$(GLIBMM_SUFFIX)
GLIBMM_DIR	:= $(BUILDDIR)/$(GLIBMM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

glibmm_get: $(STATEDIR)/glibmm.get

$(STATEDIR)/glibmm.get: $(glibmm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GLIBMM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, GLIBMM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

glibmm_extract: $(STATEDIR)/glibmm.extract

$(STATEDIR)/glibmm.extract: $(glibmm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIBMM_DIR))
	@$(call extract, GLIBMM)
	@$(call patchin, GLIBMM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

glibmm_prepare: $(STATEDIR)/glibmm.prepare

GLIBMM_PATH	:= PATH=$(CROSS_PATH)
GLIBMM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GLIBMM_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/glibmm.prepare: $(glibmm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GLIBMM_DIR)/config.cache)
	cd $(GLIBMM_DIR) && \
		$(GLIBMM_PATH) $(GLIBMM_ENV) \
		./configure $(GLIBMM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

glibmm_compile: $(STATEDIR)/glibmm.compile

$(STATEDIR)/glibmm.compile: $(glibmm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GLIBMM_DIR) && $(GLIBMM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

glibmm_install: $(STATEDIR)/glibmm.install

$(STATEDIR)/glibmm.install: $(glibmm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GLIBMM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

glibmm_targetinstall: $(STATEDIR)/glibmm.targetinstall

$(STATEDIR)/glibmm.targetinstall: $(glibmm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, glibmm)
	@$(call install_fixup, glibmm,PACKAGE,glibmm)
	@$(call install_fixup, glibmm,PRIORITY,optional)
	@$(call install_fixup, glibmm,VERSION,$(GLIBMM_VERSION))
	@$(call install_fixup, glibmm,SECTION,base)
	@$(call install_fixup, glibmm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, glibmm,DEPENDS,)
	@$(call install_fixup, glibmm,DESCRIPTION,missing)

	@$(call install_copy, glibmm, 0, 0, 0644, \
		$(GLIBMM_DIR)/glib/glibmm/.libs/libglibmm-2.4.so.1.0.24, \
		/usr/lib/libglibmm-2.4.so.1.0.24)

	@$(call install_link, glibmm, \
		libglibmm-2.4.so.1.0.24, /usr/lib/libglibmm-2.4.so.1)

	@$(call install_link, glibmm, \
		libglibmm-2.4.so.1.0.24, /usr/lib/libglibmm-2.4.so)

	@$(call install_finish, glibmm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

glibmm_clean:
	rm -rf $(STATEDIR)/glibmm.*
	rm -rf $(IMAGEDIR)/glibmm_*
	rm -rf $(GLIBMM_DIR)

# vim: syntax=make
