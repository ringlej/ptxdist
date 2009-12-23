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
PACKAGES-$(PTXCONF_LIBGSF) += libgsf

#
# Paths and names
#
LIBGSF_VERSION	:= 1.14.16
LIBGSF		:= libgsf-$(LIBGSF_VERSION)
LIBGSF_SUFFIX	:= tar.bz2
LIBGSF_URL	:= http://ftp.acc.umu.se/pub/GNOME/sources/libgsf/1.14/$(LIBGSF).$(LIBGSF_SUFFIX)
LIBGSF_SOURCE	:= $(SRCDIR)/$(LIBGSF).$(LIBGSF_SUFFIX)
LIBGSF_DIR	:= $(BUILDDIR)/$(LIBGSF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBGSF_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBGSF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGSF_PATH	:= PATH=$(CROSS_PATH)
LIBGSF_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_prog_GCONFTOOL=no

#
# autoconf
#
LIBGSF_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-iso-c \
	--disable-gtk-doc \
	--disable-schemas-install \
	--without-bonobo \
	--without-gdk-pixbuf \
	--without-gnome-vfs

ifdef PTXCONF_LIBGSF_LARGEFILE
LIBGSF_AUTOCONF += --enable-largefile
else
LIBGSF_AUTOCONF += --disable-largefile
endif

ifdef PTXCONF_LIBGSF_NLS
LIBGSF_AUTOCONF += --enable-nls
else
LIBGSF_AUTOCONF += --disable-nls
endif

ifdef PTXCONF_LIBGSF_PYTHON
LIBGSF_AUTOCONF += --with-python
else
LIBGSF_AUTOCONF += --without-python
endif

ifdef PTXCONF_LIBGSF_BZ2
LIBGSF_AUTOCONF += --with-bz2
else
LIBGSF_AUTOCONF += --without-bz2
endif

ifdef PTXCONF_LIBGSF_GIO
LIBGSF_AUTOCONF += --with-gio
else
LIBGSF_AUTOCONF += --without-gio
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgsf.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libgsf)
	@$(call install_fixup, libgsf,PACKAGE,libgsf)
	@$(call install_fixup, libgsf,PRIORITY,optional)
	@$(call install_fixup, libgsf,VERSION,$(LIBGSF_VERSION))
	@$(call install_fixup, libgsf,SECTION,base)
	@$(call install_fixup, libgsf,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libgsf,DEPENDS,)
	@$(call install_fixup, libgsf,DESCRIPTION,missing)

	@$(call install_copy, libgsf, 0, 0, 0644, -, \
		/usr/lib/libgsf-1.so.114.0.16)
	@$(call install_link, libgsf, \
		libgsf-1.so.114.0.16, /usr/lib/libgsf-1.so.114)
	@$(call install_link, libgsf, \
		libgsf-1.so.114.0.16, /usr/lib/libgsf-1.so)

	@$(call install_finish, libgsf)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgsf_clean:
	rm -rf $(STATEDIR)/libgsf.*
	rm -rf $(PKGDIR)/libgsf_*
	rm -rf $(LIBGSF_DIR)

# vim: syntax=make
