# -*-makefile-*-
#
# Copyright (C) 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_APR_UTIL) += apr-util

#
# Paths and names
#
APR_UTIL_VERSION	:= 0.9.19
APR_UTIL_MD5		:= 927a200513018a579cc9936c05d35206
APR_UTIL		:= apr-util-$(APR_UTIL_VERSION)
APR_UTIL_SUFFIX		:= tar.bz2
APR_UTIL_URL		:= http://archive.apache.org/dist/apr/$(APR_UTIL).$(APR_UTIL_SUFFIX)
APR_UTIL_SOURCE		:= $(SRCDIR)/$(APR_UTIL).$(APR_UTIL_SUFFIX)
APR_UTIL_DIR		:= $(BUILDDIR)/$(APR_UTIL)
APR_UTIL_LICENSE	:= APLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
APR_UTIL_CONF_TOOL := autoconf
APR_UTIL_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-apr=$(PTXDIST_SYSROOT_CROSS)/bin/apr-config \
	--with-expat=$(PTXDIST_SYSROOT_TARGET)/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apr-util.targetinstall:
	@$(call targetinfo)

	@$(call install_init, apr-util)
	@$(call install_fixup, apr-util,PRIORITY,optional)
	@$(call install_fixup, apr-util,SECTION,base)
	@$(call install_fixup, apr-util,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, apr-util,DESCRIPTION,missing)

	@$(call install_lib, apr-util, 0, 0, 0644, libaprutil-0)

	@$(call install_finish, apr-util)

	@$(call touch)

# vim: syntax=make
