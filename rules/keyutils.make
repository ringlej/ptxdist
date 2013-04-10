# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Grzeschik <mgr@pengutronix.de>
#

PACKAGES-$(PTXCONF_KEYUTILS) += keyutils

#
# Paths and names
#
KEYUTILS_VERSION	:= 1.5.5
KEYUTILS_MD5		:= d759680b2f23c99af95938f5026f25fb
KEYUTILS		:= keyutils-$(KEYUTILS_VERSION)
KEYUTILS_SUFFIX		:= tar.bz2
KEYUTILS_URL		:= http://people.redhat.com/~dhowells/keyutils/$(KEYUTILS).$(KEYUTILS_SUFFIX)
KEYUTILS_SOURCE		:= $(SRCDIR)/$(KEYUTILS).$(KEYUTILS_SUFFIX)
KEYUTILS_DIR		:= $(BUILDDIR)/$(KEYUTILS)
KEYUTILS_LICENSE	:= GPLv2+, LGPLv2.1+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KEYUTILS_CONF_TOOL := NO
KEYUTILS_MAKE_OPT := \
	$(CROSS_ENV_CC) \
	BUILDFOR=""

KEYUTILS_INSTALL_OPT := \
	$(KEYUTILS_MAKE_OPT) \
	LIBDIR=/lib \
	USRLIBDIR=/usr/lib \
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
	@$(call install_copy, keyutils, 0, 0, 0755, -, /sbin/key.dns_resolver)
	@$(call install_copy, keyutils, 0, 0, 0755, -, /sbin/request-key)
	@$(call install_copy, keyutils, 0, 0, 0755, -, /bin/keyctl)

	@$(call install_finish, keyutils)

	@$(call touch)

# vim: syntax=make
