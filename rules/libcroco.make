# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
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
LIBCROCO		:= libcroco-$(LIBCROCO_VERSION)
LIBCROCO_SUFFIX		:= tar.bz2
LIBCROCO_URL		:= http://ftp.gnome.org/pub/GNOME/sources/libcroco/0.6/$(LIBCROCO).$(LIBCROCO_SUFFIX)
LIBCROCO_SOURCE		:= $(SRCDIR)/$(LIBCROCO).$(LIBCROCO_SUFFIX)
LIBCROCO_DIR		:= $(BUILDDIR)/$(LIBCROCO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBCROCO_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBCROCO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCROCO_PATH	:= PATH=$(CROSS_PATH)
LIBCROCO_ENV 	:= $(CROSS_ENV)

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

	@$(call install_init,  libcroco)
	@$(call install_fixup, libcroco,PACKAGE,libcroco)
	@$(call install_fixup, libcroco,PRIORITY,optional)
	@$(call install_fixup, libcroco,VERSION,$(LIBCROCO_VERSION))
	@$(call install_fixup, libcroco,SECTION,base)
	@$(call install_fixup, libcroco,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libcroco,DEPENDS,)
	@$(call install_fixup, libcroco,DESCRIPTION,missing)

	@$(call install_copy, libcroco, 0, 0, 0755, -, \
		 /usr/lib/libcroco-0.6.so.3.0.1)
	@$(call install_link, libcroco, libcroco-0.6.so.3.0.1, \
		/usr/lib/libcroco-0.6.so.3)
	@$(call install_link, libcroco, libcroco-0.6.so.3.0.1, \
		/usr/lib/libcroco-0.6.so)

	@$(call install_finish, libcroco)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libcroco_clean:
	rm -rf $(STATEDIR)/libcroco.*
	rm -rf $(PKGDIR)/libcroco_*
	rm -rf $(LIBCROCO_DIR)

# vim: syntax=make
