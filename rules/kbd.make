# -*-makefile-*-
#
# Copyright (C) 2010 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KBD) += kbd

#
# Paths and names
#
KBD_VERSION	:= 1.15.2
KBD		:= kbd-$(KBD_VERSION)
KBD_SUFFIX	:= tar.bz2
KBD_URL		:= http://ftp.kernel.org/pub/linux/utils/kbd/$(KBD).$(KBD_SUFFIX)
KBD_SOURCE	:= $(SRCDIR)/$(KBD).$(KBD_SUFFIX)
KBD_DIR		:= $(BUILDDIR)/$(KBD)
KBD_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(KBD_SOURCE):
	@$(call targetinfo)
	@$(call get, KBD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
KBD_CONF_TOOL	:= autoconf
KBD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--disable-klibc \
	--disable-klibc-layout \
	--without-libiconv-prefix \
	--without-libintl-prefix

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kbd.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  kbd)
	@$(call install_fixup, kbd,PRIORITY,optional)
	@$(call install_fixup, kbd,SECTION,base)
	@$(call install_fixup, kbd,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, kbd,DESCRIPTION,missing)

ifdef PTXCONF_KBD_DUMPKEYS
	@$(call install_copy, kbd, 0, 0, 0755, -, /usr/bin/dumpkeys)
endif

ifdef PTXCONF_KBD_LOADKEYS
	@$(call install_copy, kbd, 0, 0, 0755, -, /usr/bin/loadkeys)
endif

ifdef PTXCONF_KBD_GETKEYCODES
	@$(call install_copy, kbd, 0, 0, 0755, -, /usr/bin/getkeycodes)
endif

ifdef PTXCONF_KBD_SETKEYCODES
	@$(call install_copy, kbd, 0, 0, 0755, -, /usr/bin/setkeycodes)
endif

ifdef PTXCONF_KBD_SHOWKEY
	@$(call install_copy, kbd, 0, 0, 0755, -, /usr/bin/showkey)
endif

ifdef PTXCONF_KBD_CHVT
	@$(call install_copy, kbd, 0, 0, 0755, -, /usr/bin/chvt)
endif

ifdef PTXCONF_KBD_DEALLOCVT
	@$(call install_copy, kbd, 0, 0, 0755, -, /usr/bin/deallocvt)
endif

	@$(call install_finish, kbd)

	@$(call touch)

# vim: syntax=make
