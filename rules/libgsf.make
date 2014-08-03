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
LIBGSF_VERSION	:= 1.14.30
LIBGSF_MD5	:= e7b672ef37ef6a853ce149c03e4d3a63
LIBGSF		:= libgsf-$(LIBGSF_VERSION)
LIBGSF_SUFFIX	:= tar.xz
LIBGSF_URL	:= http://ftp.gnome.org/pub/GNOME/sources/libgsf/1.14/$(LIBGSF).$(LIBGSF_SUFFIX)
LIBGSF_SOURCE	:= $(SRCDIR)/$(LIBGSF).$(LIBGSF_SUFFIX)
LIBGSF_DIR	:= $(BUILDDIR)/$(LIBGSF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGSF_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_prog_GCONFTOOL=no

#
# autoconf
#
LIBGSF_CONF_TOOL	:= autoconf
LIBGSF_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXCONF_LIBGSF_NLS)-nls \
	--disable-introspection \
	--disable-iso-c \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--$(call ptx/wwo, PTXCONF_LIBGSF_BZ2)-bz2 \
	--without-gdk-pixbuf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgsf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgsf)
	@$(call install_fixup, libgsf,PRIORITY,optional)
	@$(call install_fixup, libgsf,SECTION,base)
	@$(call install_fixup, libgsf,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libgsf,DESCRIPTION,missing)

	@$(call install_lib, libgsf, 0, 0, 0644, libgsf-1)

	@$(call install_finish, libgsf)

	@$(call touch)

# vim: syntax=make
