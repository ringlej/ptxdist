# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#                         Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATK) += atk

#
# Paths and names
#
ATK_VERSION	:= 1.10.3
ATK		:= atk-$(ATK_VERSION)
ATK_SUFFIX	:= tar.bz2
ATK_URL		:= ftp://ftp.gtk.org/pub/gtk/v2.8/$(ATK).$(ATK_SUFFIX)
ATK_SOURCE	:= $(SRCDIR)/$(ATK).$(ATK_SUFFIX)
ATK_DIR		:= $(BUILDDIR)/$(ATK)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

atk_get: $(STATEDIR)/atk.get

$(STATEDIR)/atk.get: $(atk_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ATK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ATK)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

atk_extract: $(STATEDIR)/atk.extract

$(STATEDIR)/atk.extract: $(atk_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ATK_DIR))
	@$(call extract, ATK)
	@$(call patchin, ATK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

atk_prepare: $(STATEDIR)/atk.prepare

ATK_PATH	:= PATH=$(CROSS_PATH)
ATK_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
ATK_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/atk.prepare: $(atk_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ATK_DIR)/config.cache)
	cd $(ATK_DIR) && \
		$(ATK_PATH) $(ATK_ENV) \
		./configure $(ATK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

atk_compile: $(STATEDIR)/atk.compile

$(STATEDIR)/atk.compile: $(atk_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ATK_DIR) && $(ATK_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

atk_install: $(STATEDIR)/atk.install

$(STATEDIR)/atk.install: $(atk_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, ATK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

atk_targetinstall: $(STATEDIR)/atk.targetinstall

$(STATEDIR)/atk.targetinstall: $(atk_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, atk)
	@$(call install_fixup,atk,PACKAGE,atk)
	@$(call install_fixup,atk,PRIORITY,optional)
	@$(call install_fixup,atk,VERSION,$(ATK_VERSION))
	@$(call install_fixup,atk,SECTION,base)
	@$(call install_fixup,atk,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,atk,DEPENDS,)
	@$(call install_fixup,atk,DESCRIPTION,missing)

	@$(call install_copy, atk, 0, 0, 0644, $(ATK_DIR)/atk/.libs/libatk-1.0.so.0.1010.3, /usr/lib/libatk-1.0.so.0.1010.3)
	@$(call install_link, atk, libatk-1.0.so.0.1010.3, /usr/lib/libatk-1.0.so.0)
	@$(call install_link, atk, libatk-1.0.so.0.1010.3, /usr/lib/libatk-1.0.so)

	@$(call install_finish,atk)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

atk_clean:
	rm -rf $(STATEDIR)/atk.*
	rm -rf $(IMAGEDIR)/atk_*
	rm -rf $(ATK_DIR)

# vim: syntax=make
