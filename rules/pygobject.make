# -*-makefile-*-
#
# Copyright (C) 2010 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYGOBJECT) += pygobject

#
# Paths and names
#
PYGOBJECT_VERSION	:= 2.21.5
PYGOBJECT_MD5		:= ef1ef7def7faa407c07b4bbd6d068ff2
PYGOBJECT		:= pygobject-$(PYGOBJECT_VERSION)
PYGOBJECT_SUFFIX	:= tar.gz
PYGOBJECT_URL		:= http://ftp.gnome.org/pub/GNOME/sources/pygobject/$(basename $(PYGOBJECT_VERSION))/$(PYGOBJECT).$(PYGOBJECT_SUFFIX)
PYGOBJECT_SOURCE	:= $(SRCDIR)/$(PYGOBJECT).$(PYGOBJECT_SUFFIX)
PYGOBJECT_DIR		:= $(BUILDDIR)/$(PYGOBJECT)
PYGOBJECT_LICENSE	:= LGPLv2.1+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYGOBJECT_CONF_TOOL := autoconf
PYGOBJECT_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	--disable-introspection \
	--disable-silent-rules \
	--enable-thread \
	--with-ffi

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pygobject.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pygobject)
	@$(call install_fixup, pygobject,PRIORITY,optional)
	@$(call install_fixup, pygobject,VERSION,$(PYGOBJECT_VERSION))
	@$(call install_fixup, pygobject,SECTION,base)
	@$(call install_fixup, pygobject,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, pygobject,DESCRIPTION,missing)

	@$(call install_lib, pygobject, 0, 0, 0644, libpyglib-2.0-python)

	@$(call install_copy, pygobject, 0, 0, 0644, -, $(PYTHON_SITEPACKAGES)/pygtk.pth)

	@$(foreach pyc, \
		pygtk.pyc \
		gtk-2.0/glib/option.pyc \
		gtk-2.0/glib/__init__.pyc \
		gtk-2.0/gobject/__init__.pyc \
		gtk-2.0/gobject/constants.pyc \
		gtk-2.0/gobject/propertyhelper.pyc \
		gtk-2.0/dsextras.pyc \
		gtk-2.0/gio/__init__.pyc, \
	$(call install_copy, pygobject, 0, 0, 0644, -, $(PYTHON_SITEPACKAGES)/$(pyc)); \
	)

	@$(foreach pyso, \
		gtk-2.0/glib/_glib.so \
		gtk-2.0/gobject/_gobject.so \
		gtk-2.0/gio/_gio.so \
		gtk-2.0/gio/unix.so, \
	$(call install_copy, pygobject, 0, 0, 0644, -, $(PYTHON_SITEPACKAGES)/$(pyso)); \
	)

	@$(call install_finish, pygobject)
	@$(call touch)

# vim: syntax=make
