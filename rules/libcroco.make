# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCROCO) += libcroco

#
# Paths and names
#
LIBCROCO_VERSION	:= 0.6.2
LIBCROCO_MD5		:= 1429c597aa4b75fc610ab3a542c99209
LIBCROCO		:= libcroco-$(LIBCROCO_VERSION)
LIBCROCO_SUFFIX		:= tar.bz2
LIBCROCO_URL		:= http://ftp.gnome.org/pub/GNOME/sources/libcroco/0.6/$(LIBCROCO).$(LIBCROCO_SUFFIX)
LIBCROCO_SOURCE		:= $(SRCDIR)/$(LIBCROCO).$(LIBCROCO_SUFFIX)
LIBCROCO_DIR		:= $(BUILDDIR)/$(LIBCROCO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBCROCO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc

ifdef PTXCONF_LIBCROCO_CHECKS
LIBCROCO_AUTOCONF += --enable-checks=yes
else
LIBCROCO_AUTOCONF += --enable-checks=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcroco.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcroco)
	@$(call install_fixup, libcroco,PRIORITY,optional)
	@$(call install_fixup, libcroco,SECTION,base)
	@$(call install_fixup, libcroco,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libcroco,DESCRIPTION,missing)

	@$(call install_lib, libcroco, 0, 0, 0644, libcroco-0.6)

	@$(call install_finish, libcroco)

	@$(call touch)

# vim: syntax=make
