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
CPUFREQUTILS_VERSION	:= 007
CPUFREQUTILS		:= cpufrequtils-$(CPUFREQUTILS_VERSION)
CPUFREQUTILS_SUFFIX	:= tar.bz2
CPUFREQUTILS_URL	:= http://www.kernel.org/pub/linux/utils/kernel/cpufreq/$(CPUFREQUTILS).$(CPUFREQUTILS_SUFFIX)
CPUFREQUTILS_SOURCE	:= $(SRCDIR)/$(CPUFREQUTILS).$(CPUFREQUTILS_SUFFIX)
CPUFREQUTILS_DIR	:= $(BUILDDIR)/$(CPUFREQUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CPUFREQUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, CPUFREQUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CPUFREQUTILS_PATH := PATH=$(CROSS_PATH)
CPUFREQUTILS_COMPILE_ENV := $(CROSS_ENV)
CPUFREQUTILS_MAKEVARS := \
	NLS=false \
	V=true \
	STRIPCMD=/bin/true

$(STATEDIR)/cpufrequtils.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cpufrequtils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cpufrequtils)
	@$(call install_fixup, cpufrequtils,PRIORITY,optional)
	@$(call install_fixup, cpufrequtils,SECTION,base)
	@$(call install_fixup, cpufrequtils,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, cpufrequtils,DESCRIPTION,missing)

	@$(call install_copy, cpufrequtils, 0, 0, 0644, -, \
		/usr/lib/libcpufreq.so.0.0.0)
	@$(call install_link, cpufrequtils, \
		libcpufreq.so.0.0.0, \
		/usr/lib/libcpufreq.so.0)
	@$(call install_link, cpufrequtils, \
		libcpufreq.so.0.0.0, \
		/usr/lib/libcpufreq.so)

ifdef PTXCONF_CPUFREQUTILS_FREQ_INFO
	@$(call install_copy, cpufrequtils, 0, 0, 0755, -, /usr/bin/cpufreq-info)
endif
ifdef PTXCONF_CPUFREQUTILS_FREQ_SET
	@$(call install_copy, cpufrequtils, 0, 0, 0755, -, /usr/bin/cpufreq-set)
endif

	@$(call install_finish, cpufrequtils)

	@$(call touch)

# vim: syntax=make
