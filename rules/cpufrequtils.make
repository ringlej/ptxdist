# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CPUFREQUTILS) += cpufrequtils

#
# Paths and names
#
CPUFREQUTILS_VERSION	:= 002
CPUFREQUTILS		:= cpufrequtils-$(CPUFREQUTILS_VERSION)
CPUFREQUTILS_SUFFIX	:= tar.bz2
CPUFREQUTILS_URL	:= http://www.kernel.org/pub/linux/utils/kernel/cpufreq/$(CPUFREQUTILS).$(CPUFREQUTILS_SUFFIX)
CPUFREQUTILS_SOURCE	:= $(SRCDIR)/$(CPUFREQUTILS).$(CPUFREQUTILS_SUFFIX)
CPUFREQUTILS_DIR	:= $(BUILDDIR)/$(CPUFREQUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/cpufrequtils.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CPUFREQUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CPUFREQUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/cpufrequtils.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(CPUFREQUTILS_DIR))
	@$(call extract, CPUFREQUTILS)
	@$(call patchin, CPUFREQUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CPUFREQUTILS_PATH	:= PATH=$(CROSS_PATH)
CPUFREQUTILS_ENV 	:= \
	$(CROSS_ENV) \
	NLS=false \
	V=true

$(STATEDIR)/cpufrequtils.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

# FIXME: Uses /usr/bin/libtool
# FIXME: Uses /usr/bin/install

$(STATEDIR)/cpufrequtils.compile:
	@$(call targetinfo, $@)
	cd $(CPUFREQUTILS_DIR) && $(CPUFREQUTILS_PATH) $(CPUFREQUTILS_ENV) \
		$(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cpufrequtils.install:
	@$(call targetinfo, $@)
	@$(call install, CPUFREQUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cpufrequtils.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, cpufrequtils)
	@$(call install_fixup, cpufrequtils,PACKAGE,cpufrequtils)
	@$(call install_fixup, cpufrequtils,PRIORITY,optional)
	@$(call install_fixup, cpufrequtils,VERSION,$(CPUFREQUTILS_VERSION))
	@$(call install_fixup, cpufrequtils,SECTION,base)
	@$(call install_fixup, cpufrequtils,AUTHOR,"Juergen Beisert <j.beisert\@pengutronix.de>")
	@$(call install_fixup, cpufrequtils,DEPENDS,)
	@$(call install_fixup, cpufrequtils,DESCRIPTION,missing)

	@$(call install_copy, cpufrequtils, 0, 0, 0755, \
		$(CPUFREQUTILS_DIR)/.libs/libcpufreq.so.0.0.0, \
		/usr/lib/libcpufreq.so.0.0.0)
	@$(call install_link, cpufrequtils, \
		libcpufreq.so.0.0.0, \
		/usr/lib/libcpufreq.so.0)
	@$(call install_link, cpufrequtils, \
		libconfuse.so.0, \
		/usr/lib/libconfuse.so)

ifdef PTXCONF_CPUFREQUTILS_FREQ_INFO
	@$(call install_copy, cpufrequtils, 0, 0, 0755, \
		$(CPUFREQUTILS_DIR)/cpufreq-info, /usr/bin/cpufreq-info)
endif
ifdef PTXCONF_CPUFREQUTILS_FREQ_SET
	@$(call install_copy, cpufrequtils, 0, 0, 0755, \
		$(CPUFREQUTILS_DIR)/cpufreq-set, /usr/bin/cpufreq-set)
endif

	@$(call install_finish, cpufrequtils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cpufrequtils_clean:
	rm -rf $(STATEDIR)/cpufrequtils.*
	rm -rf $(PKGDIR)/cpufrequtils_*
	rm -rf $(CPUFREQUTILS_DIR)

# vim: syntax=make
