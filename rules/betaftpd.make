# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation, by Milan Bobde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BETAFTPD) += betaftpd

#
# Paths and names
#
BETAFTPD_VERSION	= 0.0.8pre17
BETAFTPD		= betaftpd-$(BETAFTPD_VERSION)
BETAFTPD_SUFFIX		= tar.gz
BETAFTPD_URL		= $(PTXCONF_SETUP_SFMIRROR)/betaftpd/$(BETAFTPD).$(BETAFTPD_SUFFIX)
BETAFTPD_SOURCE		= $(SRCDIR)/$(BETAFTPD).$(BETAFTPD_SUFFIX)
BETAFTPD_DIR		= $(BUILDDIR)/$(BETAFTPD)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

betaftpd_get: $(STATEDIR)/betaftpd.get

$(STATEDIR)/betaftpd.get: $(betaftpd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BETAFTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BETAFTPD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

betaftpd_extract: $(STATEDIR)/betaftpd.extract

$(STATEDIR)/betaftpd.extract: $(betaftpd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BETAFTPD_DIR))
	@$(call extract, BETAFTPD)
	@$(call patchin, $(BETAFTPD))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

betaftpd_prepare: $(STATEDIR)/betaftpd.prepare

BETAFTPD_PATH	=  PATH=$(CROSS_PATH)
BETAFTPD_ENV 	=  $(CROSS_ENV)
# FIXME: rewrite make system with autoconf or throw away packet at all
BETAFTPD_ENV	+= CFLAGS='$(CROSS_CPPFLAGS) $(CROSS_CFLAGS) -L$(SYSROOT)/usr/lib'

#
# autoconf
#
BETAFTPD_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/betaftpd.prepare: $(betaftpd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BETAFTPD_DIR)/config.cache)
	cd $(BETAFTPD_DIR) && \
		$(BETAFTPD_PATH) $(BETAFTPD_ENV) \
		./configure $(BETAFTPD_AUTOCONF)

	# Tweak, Tweak ...
	# betaftpd expects some uninstalled librn flags, so fake them
	cp $(LIBRN_DIR)/include/rn_*.h $(BETAFTPD_DIR)/

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

betaftpd_compile: $(STATEDIR)/betaftpd.compile

$(STATEDIR)/betaftpd.compile: $(betaftpd_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(BETAFTPD_DIR) && \
		$(BETAFTPD_ENV) $(BETAFTPD_PATH) make $(BETAFTPD_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

betaftpd_install: $(STATEDIR)/betaftpd.install

$(STATEDIR)/betaftpd.install: $(betaftpd_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

betaftpd_targetinstall: $(STATEDIR)/betaftpd.targetinstall

$(STATEDIR)/betaftpd.targetinstall: $(betaftpd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  betaftpd)
	@$(call install_fixup, betaftpd,PACKAGE,betaftpd)
	@$(call install_fixup, betaftpd,PRIORITY,optional)
	@$(call install_fixup, betaftpd,VERSION,$(BETAFTPD_VERSION))
	@$(call install_fixup, betaftpd,SECTION,base)
	@$(call install_fixup, betaftpd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, betaftpd,DEPENDS,)
	@$(call install_fixup, betaftpd,DESCRIPTION,missing)

	@$(call install_copy,  betaftpd, 0, 0, 0755, \
		$(BETAFTPD_DIR)/betaftpd, \
		/usr/bin/betaftpd)

	@$(call install_finish, betaftpd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

betaftpd_clean:
	rm -rf $(STATEDIR)/betaftpd.*
	rm -rf $(BETAFTPD_DIR)

# vim: syntax=make
