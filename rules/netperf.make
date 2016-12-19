# -*-makefile-*-
#
# Copyright (C) 2016 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETPERF) += netperf

#
# Paths and names
#
NETPERF_VERSION	:= 2.7.0
NETPERF_MD5	:= ad1c5342d61f297c417a93133aeba65a
NETPERF		:= netperf-$(NETPERF_VERSION)
NETPERF_SUFFIX	:= tar.bz2
NETPERF_URL	:= ftp://ftp.netperf.org/netperf/$(NETPERF).$(NETPERF_SUFFIX)
NETPERF_SOURCE	:= $(SRCDIR)/$(NETPERF).$(NETPERF_SUFFIX)
NETPERF_DIR	:= $(BUILDDIR)/$(NETPERF)
NETPERF_LICENSE	:= HP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NETPERF_CONF_TOOL	:= autoconf
NETPERF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-histogram \
	--disable-dirty \
	--enable-demo \
	--disable-unixdomain \
	--disable-dlpi \
	--disable-dccp \
	--enable-omni \
	--disable-xti \
	--disable-sdp \
	--disable-exs \
	--disable-sctp \
	--disable-intervals \
	--disable-spin \
	--enable-burst \
	--enable-cpuutil=procstat

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/netperf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, netperf)
	@$(call install_fixup, netperf, PRIORITY, optional)
	@$(call install_fixup, netperf, SECTION, base)
	@$(call install_fixup, netperf, AUTHOR, "Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, netperf, DESCRIPTION, missing)

	@$(call install_alternative, netperf, 0, 0, 0755, /usr/bin/netperf)
	@$(call install_alternative, netperf, 0, 0, 0755, /usr/bin/netserver)

	@$(call install_finish, netperf)

	@$(call touch)

# vim: syntax=make
