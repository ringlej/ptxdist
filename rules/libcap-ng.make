# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCAP_NG) += libcap-ng

#
# Paths and names
#
LIBCAP_NG_VERSION	:= 0.7.8
LIBCAP_NG_MD5		:= 0dece96644bd798020e170fbf7663802
LIBCAP_NG		:= libcap-ng-$(LIBCAP_NG_VERSION)
LIBCAP_NG_SUFFIX	:= tar.gz
LIBCAP_NG_URL		:= http://people.redhat.com/sgrubb/libcap-ng/$(LIBCAP_NG).$(LIBCAP_NG_SUFFIX)
LIBCAP_NG_SOURCE	:= $(SRCDIR)/$(LIBCAP_NG).$(LIBCAP_NG_SUFFIX)
LIBCAP_NG_DIR		:= $(BUILDDIR)/$(LIBCAP_NG)
LIBCAP_NG_LICENSE	:= LGPL-2.1-or-later AND GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBCAP_NG_CONF_TOOL := autoconf

LIBCAP_NG_CONF_ENV := \
	ac_cv_prog_swig_found=no

LIBCAP_NG_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--without-debug \
	--without-warn \
	--without-python \
	--without-python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcap-ng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcap-ng)
	@$(call install_fixup, libcap-ng,PRIORITY,optional)
	@$(call install_fixup, libcap-ng,SECTION,base)
	@$(call install_fixup, libcap-ng,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libcap-ng,DESCRIPTION,missing)

	@$(call install_lib, libcap-ng, 0, 0, 0644, libcap-ng)

	@$(call install_finish, libcap-ng)

	@$(call touch)

# vim: syntax=make
