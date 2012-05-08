# -*-makefile-*-
#
# Copyright (C) 2012 by Jan Luebbe <jlu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GNUTLS) += gnutls

#
# Paths and names
#
GNUTLS_VERSION	:= 2.12.19
GNUTLS_MD5	:= 14228b34e3d8ed176a617df40693b441
GNUTLS		:= gnutls-$(GNUTLS_VERSION)
GNUTLS_SUFFIX	:= tar.bz2
GNUTLS_URL	:= http://ftp.gnu.org/gnu/gnutls/$(GNUTLS).$(GNUTLS_SUFFIX)
GNUTLS_SOURCE	:= $(SRCDIR)/$(GNUTLS).$(GNUTLS_SUFFIX)
GNUTLS_DIR	:= $(BUILDDIR)/$(GNUTLS)
GNUTLS_LICENSE	:= LGPLv3+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GNUTLS_CONF_TOOL	:= autoconf
GNUTLS_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--with-libgcrypt \
	--with-libgcrypt-prefix=$(PTXDIST_SYSROOT_TARGET)/usr \
	--without-p11-kit \
	--disable-guile

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gnutls.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gnutls)
	@$(call install_fixup, gnutls,PRIORITY,optional)
	@$(call install_fixup, gnutls,SECTION,base)
	@$(call install_fixup, gnutls,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, gnutls,DESCRIPTION,missing)

	@$(call install_lib, gnutls, 0, 0, 0644, libgnutls)

	@$(call install_finish, gnutls)

	@$(call touch)

# vim: syntax=make
