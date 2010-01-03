# -*-makefile-*-
# $Id: template-make 8785 2008-08-26 07:48:06Z wsa $
#
# Copyright (C) 2008 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMICROHTTPD) += libmicrohttpd

#
# Paths and names
#
LIBMICROHTTPD_VERSION	:= 0.4.0pre0
LIBMICROHTTPD		:= libmicrohttpd-$(LIBMICROHTTPD_VERSION)
LIBMICROHTTPD_SUFFIX	:= tar.gz
LIBMICROHTTPD_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/libmicrohttpd/$(LIBMICROHTTPD).$(LIBMICROHTTPD_SUFFIX)
LIBMICROHTTPD_SOURCE	:= $(SRCDIR)/$(LIBMICROHTTPD).$(LIBMICROHTTPD_SUFFIX)
LIBMICROHTTPD_DIR	:= $(BUILDDIR)/$(LIBMICROHTTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBMICROHTTPD_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBMICROHTTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMICROHTTPD_PATH	:= PATH=$(CROSS_PATH)
LIBMICROHTTPD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBMICROHTTPD_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmicrohttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmicrohttpd)
	@$(call install_fixup, libmicrohttpd,PACKAGE,libmicrohttpd)
	@$(call install_fixup, libmicrohttpd,PRIORITY,optional)
	@$(call install_fixup, libmicrohttpd,VERSION,$(LIBMICROHTTPD_VERSION))
	@$(call install_fixup, libmicrohttpd,SECTION,base)
	@$(call install_fixup, libmicrohttpd,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, libmicrohttpd,DEPENDS,)
	@$(call install_fixup, libmicrohttpd,DESCRIPTION,missing)

	@$(call install_copy, libmicrohttpd, 0, 0, 0644, -, \
		/usr/lib/libmicrohttpd.so.4.0.3)
	@$(call install_link, libmicrohttpd, libmicrohttpd.so.4.0.3, \
		/usr/lib/libmicrohttpd.so.4)
	@$(call install_link, libmicrohttpd, libmicrohttpd.so.4.0.3, \
		/usr/lib/libmicrohttpd.so)


	@$(call install_finish, libmicrohttpd)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libmicrohttpd_clean:
	rm -rf $(STATEDIR)/libmicrohttpd.*
	rm -rf $(PKGDIR)/libmicrohttpd_*
	rm -rf $(LIBMICROHTTPD_DIR)

# vim: syntax=make
