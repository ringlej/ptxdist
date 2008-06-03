# -*-makefile-*-
# $Id: template 3345 2005-11-14 17:14:19Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HRTIMERS_SUPPORT) += hrtimers-support

#
# Paths and names
#
HRTIMERS_SUPPORT_VERSION	:= 3.1.1
HRTIMERS_SUPPORT		:= hrtimers-support-$(HRTIMERS_SUPPORT_VERSION)
HRTIMERS_SUPPORT_SUFFIX		:= tar.bz2
HRTIMERS_SUPPORT_URL		:= $(PTXCONF_SETUP_SFMIRROR)/high-res-timers/$(HRTIMERS_SUPPORT).$(HRTIMERS_SUPPORT_SUFFIX)
HRTIMERS_SUPPORT_SOURCE		:= $(SRCDIR)/$(HRTIMERS_SUPPORT).$(HRTIMERS_SUPPORT_SUFFIX)
HRTIMERS_SUPPORT_DIR		:= $(BUILDDIR)/$(HRTIMERS_SUPPORT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hrtimers-support_get: $(STATEDIR)/hrtimers-support.get

$(STATEDIR)/hrtimers-support.get: $(hrtimers-support_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HRTIMERS_SUPPORT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HRTIMERS_SUPPORT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hrtimers-support_extract: $(STATEDIR)/hrtimers-support.extract

$(STATEDIR)/hrtimers-support.extract: $(hrtimers-support_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HRTIMERS_SUPPORT_DIR))
	@$(call extract, HRTIMERS_SUPPORT)
	@$(call patchin, HRTIMERS_SUPPORT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hrtimers-support_prepare: $(STATEDIR)/hrtimers-support.prepare

HRTIMERS_SUPPORT_PATH	:=  PATH=$(CROSS_PATH)
HRTIMERS_SUPPORT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
HRTIMERS_SUPPORT_AUTOCONF :=  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/hrtimers-support.prepare: $(hrtimers-support_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HRTIMERS_SUPPORT_DIR)/config.cache)
	cd $(HRTIMERS_SUPPORT_DIR) && \
		$(HRTIMERS_SUPPORT_PATH) $(HRTIMERS_SUPPORT_ENV) \
		./configure $(HRTIMERS_SUPPORT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hrtimers-support_compile: $(STATEDIR)/hrtimers-support.compile

$(STATEDIR)/hrtimers-support.compile: $(hrtimers-support_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HRTIMERS_SUPPORT_DIR) && $(HRTIMERS_SUPPORT_ENV) $(HRTIMERS_SUPPORT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hrtimers-support_install: $(STATEDIR)/hrtimers-support.install

$(STATEDIR)/hrtimers-support.install: $(hrtimers-support_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HRTIMERS_SUPPORT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hrtimers-support_targetinstall: $(STATEDIR)/hrtimers-support.targetinstall

$(STATEDIR)/hrtimers-support.targetinstall: $(hrtimers-support_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, hrtimers-support)
	@$(call install_fixup, hrtimers-support,PACKAGE,hrtimers-support)
	@$(call install_fixup, hrtimers-support,PRIORITY,optional)
	@$(call install_fixup, hrtimers-support,VERSION,$(HRTIMERS_SUPPORT_VERSION))
	@$(call install_fixup, hrtimers-support,SECTION,base)
	@$(call install_fixup, hrtimers-support,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, hrtimers-support,DEPENDS,)
	@$(call install_fixup, hrtimers-support,DESCRIPTION,missing)

	@$(call install_copy, hrtimers-support, 0, 0, 0644, \
		$(HRTIMERS_SUPPORT_DIR)/lib/.libs/libposix-time.so.1.0.0, \
		/usr/lib/libposix-time.so.1.0.0)

	@$(call install_link, hrtimers-support, \
		libposix-time.so.1.0.0, \
		/usr/lib/libposix-time.so.1)

	@$(call install_link, hrtimers-support, \
		libposix-time.so.1.0.0, \
		/usr/lib/libposix-time.so)

	@$(call install_finish, hrtimers-support)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hrtimers-support_clean:
	rm -rf $(STATEDIR)/hrtimers-support.*
	rm -rf $(PKGDIR)/hrtimers-support_*
	rm -rf $(HRTIMERS_SUPPORT_DIR)

# vim: syntax=make
