# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Erwin Rol
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
LIBMICROHTTPD_VERSION	:= 0.4.4
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
LIBMICROHTTPD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-curl \
	--disable-coverage

ifdef PTXCONF_LIBMICROHTTPD_HTTPS
LIBMICROHTTPD_AUTOCONF += --enable-https
else
LIBMICROHTTPD_AUTOCONF += --disable-https
endif

ifdef PTXCONF_LIBMICROHTTPD_CLIENT_SIDE
LIBMICROHTTPD_AUTOCONF += --enable-client-side
else
LIBMICROHTTPD_AUTOCONF += --disable-client-side
endif

ifdef PTXCONF_LIBMICROHTTPD_MESSAGES
LIBMICROHTTPD_AUTOCONF += --enable-messages
else
LIBMICROHTTPD_AUTOCONF += --disable-messages
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmicrohttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmicrohttpd)
	@$(call install_fixup, libmicrohttpd,PRIORITY,optional)
	@$(call install_fixup, libmicrohttpd,SECTION,base)
	@$(call install_fixup, libmicrohttpd,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, libmicrohttpd,DESCRIPTION,missing)

	@$(call install_copy, libmicrohttpd, 0, 0, 0644, -, \
		/usr/lib/libmicrohttpd.so.5.2.0)
	@$(call install_link, libmicrohttpd, libmicrohttpd.so.5.2.0, \
		/usr/lib/libmicrohttpd.so.5)
	@$(call install_link, libmicrohttpd, libmicrohttpd.so.5.2.0, \
		/usr/lib/libmicrohttpd.so)

	@$(call install_finish, libmicrohttpd)

	@$(call touch)

# vim: syntax=make
