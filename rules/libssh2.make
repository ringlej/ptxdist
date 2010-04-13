# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSSH2) += libssh2

#
# Paths and names
#
LIBSSH2_VERSION	:= 1.2.4
LIBSSH2		:= libssh2-$(LIBSSH2_VERSION)
LIBSSH2_SUFFIX	:= tar.gz
LIBSSH2_URL	:= http://www.libssh2.org/download/$(LIBSSH2).$(LIBSSH2_SUFFIX)
LIBSSH2_SOURCE	:= $(SRCDIR)/$(LIBSSH2).$(LIBSSH2_SUFFIX)
LIBSSH2_DIR	:= $(BUILDDIR)/$(LIBSSH2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBSSH2_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBSSH2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSSH2_PATH	:= PATH=$(CROSS_PATH)
LIBSSH2_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBSSH2_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-libz-prefix=$(SYSROOT)/usr \
	--with-libssl-prefix=$(SYSROOT)/usr \
	--with-openssl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libssh2.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libssh2)
	@$(call install_fixup, libssh2,PACKAGE,libssh2)
	@$(call install_fixup, libssh2,PRIORITY,optional)
	@$(call install_fixup, libssh2,VERSION,$(LIBSSH2_VERSION))
	@$(call install_fixup, libssh2,SECTION,base)
	@$(call install_fixup, libssh2,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libssh2,DEPENDS,)
	@$(call install_fixup, libssh2,DESCRIPTION,missing)

	@$(call install_copy, libssh2, 0, 0, 0644, -, \
		/usr/lib/libssh2.so.1.0.1)

	@$(call install_link, libssh2, libssh2.so.1.0.1, \
		/usr/lib/libssh2.so.1)
	@$(call install_link, libssh2, libssh2.so.1.0.1, \
		/usr/lib/libssh2.so)

	@$(call install_finish, libssh2)

	@$(call touch)

# vim: syntax=make
