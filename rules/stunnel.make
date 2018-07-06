# -*-makefile-*-
#
# Copyright (C) 2014 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STUNNEL) += stunnel

#
# Paths and names
#
STUNNEL_VERSION	:= 5.46
STUNNEL_MD5	:= 2836e0740d4a16fa489445d969ec0b7d
STUNNEL		:= stunnel-$(STUNNEL_VERSION)
STUNNEL_SUFFIX	:= tar.gz
STUNNEL_URL	:= \
	http://ftp.nluug.nl/pub/networking/stunnel/$(STUNNEL).$(STUNNEL_SUFFIX) \
	http://ftp.nluug.nl/pub/networking/stunnel/archive/5.x/$(STUNNEL).$(STUNNEL_SUFFIX)
STUNNEL_SOURCE	:= $(SRCDIR)/$(STUNNEL).$(STUNNEL_SUFFIX)
STUNNEL_DIR	:= $(BUILDDIR)/$(STUNNEL)
STUNNEL_LICENSE	:= stunnel (GPL2 or later with openssl exception)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
STUNNEL_CONF_TOOL	:= autoconf
STUNNEL_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	$(GLOBAL_IPV6_OPTION) \
	--disable-fips \
	--disable-systemd \
	--disable-libwrap \
	--with-threads=pthread \
	--with-ssl=$(PTXDIST_SYSROOT_TARGET)/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/stunnel.targetinstall:
	@$(call targetinfo)

	@$(call install_init, stunnel)
	@$(call install_fixup, stunnel,PRIORITY,optional)
	@$(call install_fixup, stunnel,SECTION,base)
	@$(call install_fixup, stunnel,AUTHOR,"Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, stunnel,DESCRIPTION,missing)

	@$(call install_copy, stunnel, 0, 0, 0755, -, /usr/bin/stunnel)

	@$(call install_finish, stunnel)

	@$(call touch)

# vim: syntax=make
