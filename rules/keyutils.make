# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Grzeschik <mgr@pengutronix.de>
#

PACKAGES-$(PTXCONF_KEYUTILS) += keyutils

#
# Paths and names
#
KEYUTILS_VERSION	:= 1.5.10
KEYUTILS_MD5		:= 3771676319bc7b84b1549b5c63ff5243
KEYUTILS		:= keyutils-$(KEYUTILS_VERSION)
KEYUTILS_SUFFIX		:= tar.bz2
KEYUTILS_URL		:= http://people.redhat.com/~dhowells/keyutils/$(KEYUTILS).$(KEYUTILS_SUFFIX)
KEYUTILS_SOURCE		:= $(SRCDIR)/$(KEYUTILS).$(KEYUTILS_SUFFIX)
KEYUTILS_DIR		:= $(BUILDDIR)/$(KEYUTILS)
KEYUTILS_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KEYUTILS_CONF_TOOL := NO
KEYUTILS_MAKE_OPT := \
	$(CROSS_ENV_CC) \
	CFLAGS="-O2 -g3 -Wall" \
	BUILDFOR="" \
	BINDIR=/usr/bin \
	SBINDIR=/usr/sbin \
	LIBDIR=/usr/lib \
	USRLIBDIR=/usr/lib

KEYUTILS_INSTALL_OPT := \
	$(KEYUTILS_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/keyutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, keyutils)
	@$(call install_fixup, keyutils,PRIORITY,optional)
	@$(call install_fixup, keyutils,SECTION,base)
	@$(call install_fixup, keyutils,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, keyutils,DESCRIPTION,missing)

	@$(call install_lib, keyutils, 0, 0, 0644, libkeyutils)

	@$(call install_alternative, keyutils, 0, 0, 0644, /etc/request-key.conf)
	@$(call install_copy, keyutils, 0, 0, 0755, -, /usr/sbin/key.dns_resolver)
	@$(call install_copy, keyutils, 0, 0, 0755, -, /usr/sbin/request-key)
	@$(call install_copy, keyutils, 0, 0, 0755, -, /usr/bin/keyctl)

	@$(call install_finish, keyutils)

	@$(call touch)

# vim: syntax=make
