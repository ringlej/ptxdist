# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Erwin Rol
# Copyright (C) 2016 by Juergen Borleis
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
LIBMICROHTTPD_VERSION	:= 0.9.50
LIBMICROHTTPD_MD5	:= 4a3f793d59f663a2b0fc62d44668fb66
LIBMICROHTTPD		:= libmicrohttpd-$(LIBMICROHTTPD_VERSION)
LIBMICROHTTPD_SUFFIX	:= tar.gz
LIBMICROHTTPD_URL	:= $(call ptx/mirror, GNU, libmicrohttpd/$(LIBMICROHTTPD).$(LIBMICROHTTPD_SUFFIX))
LIBMICROHTTPD_SOURCE	:= $(SRCDIR)/$(LIBMICROHTTPD).$(LIBMICROHTTPD_SUFFIX)
LIBMICROHTTPD_DIR	:= $(BUILDDIR)/$(LIBMICROHTTPD)
LIBMICROHTTPD_LICENSE	:= LGPL-2.1-only OR GPL-2.0-only WITH eCos-exception-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMICROHTTPD_PATH	:= PATH=$(CROSS_PATH)
LIBMICROHTTPD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBMICROHTTPD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-curl \
	--$(call ptx/endis, PTXCONF_LIBMICROHTTPD_MESSAGES)-messages \
	--$(call ptx/endis, PTXCONF_LIBMICROHTTPD_HTTPS)-https \
	--disable-bauth \
	--disable-dauth \
	--disable-coverage

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmicrohttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmicrohttpd)
	@$(call install_fixup, libmicrohttpd,PRIORITY,optional)
	@$(call install_fixup, libmicrohttpd,SECTION,base)
	@$(call install_fixup, libmicrohttpd,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, libmicrohttpd,DESCRIPTION,"embedded HTTP server functionality")

	@$(call install_lib, libmicrohttpd, 0, 0, 0644, libmicrohttpd)

	@$(call install_finish, libmicrohttpd)

	@$(call touch)

# vim: syntax=make
