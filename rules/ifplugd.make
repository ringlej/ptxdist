# -*-makefile-*-
# $Id: ifplugd.make,v 1.1 2007-07-15 19:14:38 michl Exp $
#
# Copyright (C) 2007 by Ladislav Michl
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IFPLUGD) += ifplugd

#
# Paths and names
#
IFPLUGD_VERSION	:= 0.28
IFPLUGD		:= ifplugd-$(IFPLUGD_VERSION)
IFPLUGD_SUFFIX	:= tar.gz
IFPLUGD_URL	:= http://0pointer.de/lennart/projects/ifplugd//$(IFPLUGD).$(IFPLUGD_SUFFIX)
IFPLUGD_SOURCE	:= $(SRCDIR)/$(IFPLUGD).$(IFPLUGD_SUFFIX)
IFPLUGD_DIR	:= $(BUILDDIR)/$(IFPLUGD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ifplugd_get: $(STATEDIR)/ifplugd.get

$(STATEDIR)/ifplugd.get: $(ifplugd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(IFPLUGD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, IFPLUGD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ifplugd_extract: $(STATEDIR)/ifplugd.extract

$(STATEDIR)/ifplugd.extract: $(ifplugd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IFPLUGD_DIR))
	@$(call extract, IFPLUGD)
	@$(call patchin, IFPLUGD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifplugd_prepare: $(STATEDIR)/ifplugd.prepare

IFPLUGD_PATH	:= PATH=$(CROSS_PATH)
IFPLUGD_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_func_malloc_0_nonnull=yes

#
# autoconf
#
IFPLUGD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-lynx

$(STATEDIR)/ifplugd.prepare: $(ifplugd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IFPLUGD_DIR)/config.cache)
	cd $(IFPLUGD_DIR) && \
		$(IFPLUGD_PATH) $(IFPLUGD_ENV) \
		./configure $(IFPLUGD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ifplugd_compile: $(STATEDIR)/ifplugd.compile

$(STATEDIR)/ifplugd.compile: $(ifplugd_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(IFPLUGD_DIR) && $(IFPLUGD_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ifplugd_install: $(STATEDIR)/ifplugd.install

$(STATEDIR)/ifplugd.install: $(ifplugd_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, IFPLUGD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ifplugd_targetinstall: $(STATEDIR)/ifplugd.targetinstall

$(STATEDIR)/ifplugd.targetinstall: $(ifplugd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ifplugd)
	@$(call install_fixup, ifplugd,PACKAGE,ifplugd)
	@$(call install_fixup, ifplugd,PRIORITY,optional)
	@$(call install_fixup, ifplugd,VERSION,$(IFPLUGD_VERSION))
	@$(call install_fixup, ifplugd,SECTION,base)
	@$(call install_fixup, ifplugd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ifplugd,DEPENDS,)
	@$(call install_fixup, ifplugd,DESCRIPTION,missing)

	@$(call install_copy, ifplugd, 0, 0, 0755, $(IFPLUGD_DIR)/src/ifplugd, /usr/sbin/ifplugd)
	@$(call install_copy, ifplugd, 0, 0, 0755, $(IFPLUGD_DIR)/conf/ifplugd.action, /etc/ifplugd/ifplugd.action, n)

ifdef PTXCONF_IFPLUGD_STATUS
	@$(call install_copy, ifplugd, 0, 0, 0755, $(IFPLUGD_DIR)/src/ifplugstatus, /usr/sbin/ifplugstatus)
endif

	@$(call install_finish, ifplugd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ifplugd_clean:
	rm -rf $(STATEDIR)/ifplugd.*
	rm -rf $(IMAGEDIR)/ifplugd_*
	rm -rf $(IFPLUGD_DIR)

# vim: syntax=make
