# -*-makefile-*-
#
# Copyright (C) 2006-2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#                            Pengutronix <info@pengutronix.de>, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIB) += glib

#
# Paths and names
#
GLIB_VERSION	:= 2.22.2

GLIB		:= glib-$(GLIB_VERSION)
GLIB_SUFFIX	:= tar.bz2
GLIB_SOURCE	:= $(SRCDIR)/$(GLIB).$(GLIB_SUFFIX)
GLIB_DIR	:= $(BUILDDIR)/$(GLIB)

GLIB_URL	:= http://ftp.gtk.org/pub/glib/2.22/glib-$(GLIB_VERSION).$(GLIB_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GLIB_SOURCE):
	@$(call targetinfo)
	@$(call get, GLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLIB_PATH	:= PATH=$(CROSS_PATH)

GLIB_ENV 	:= \
	$(CROSS_ENV) \
	glib_cv_uscore=no \
	glib_cv_stack_grows=no

#
# autoconf
#
# --with-libiconv=no does also find the libc iconv implementation! So it
# is the right choice for no locales and locales-via-libc
#

GLIB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-threads \
	--with-threads=posix \
	--enable-static \
	--enable-shared \
	--disable-selinux \
	--disable-gtk-doc \
	--disable-man \
	--disable-gc-friendly \
	--disable-fast-install \
	--disable-libtool-lock \
	--disable-included-printf \
	--disable-fam \
	--disable-xattr \
	--with-gnu-ld \
	--with-pcre=internal \
	--with-libiconv=no

#  --enable-debug=[no/minimum/yes]
#                          turn on debugging [default=minimum]
#  --disable-mem-pools     disable all glib memory pools
#  --disable-rebuilds      disable all source autogeneration rules
#  --disable-visibility    don't use ELF visibility attributes
#  --disable-largefile     omit support for large files
#  --enable-iconv-cache=[yes/no/auto]
#                          cache iconv descriptors [default=auto]
#  --disable-regex         disable the compilation of GRegex
#
#  --with-pic              try to use only PIC/non-PIC objects [default=use
#                          both]
#  --with-gio-module-dir=PATH
#                          Load gio modules from this directory
#                          [LIBDIR/gio/modules]

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

GLIB_LIB_VERSION := 0.2200.2

$(STATEDIR)/glib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glib)
	@$(call install_fixup,glib,PACKAGE,glib)
	@$(call install_fixup,glib,PRIORITY,optional)
	@$(call install_fixup,glib,VERSION,$(GLIB_VERSION))
	@$(call install_fixup,glib,SECTION,base)
	@$(call install_fixup,glib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,glib,DEPENDS,)
	@$(call install_fixup,glib,DESCRIPTION,missing)

#	# /usr/bin/gtester-report
#	# /usr/bin/glib-genmarshal
#	# /usr/bin/glib-gettextize
#	# /usr/bin/gobject-query
#	# /usr/bin/glib-mkenums
#	# /usr/bin/gtester

	@$(call install_copy, glib, 0, 0, 0755, /usr/lib/gio/modules)

	@for i in libgio libglib libgmodule libgobject libgthread; do \
		$(call install_copy, glib, 0, 0, 0644, -, /usr/lib/$$i-2.0.so.$(GLIB_LIB_VERSION)); \
		$(call install_link, glib, $$i-2.0.so.$(GLIB_LIB_VERSION), /usr/lib/$$i-2.0.so.0); \
		$(call install_link, glib, $$i-2.0.so.$(GLIB_LIB_VERSION), /usr/lib/$$i-2.0.so); \
	done

	@$(call install_finish,glib)

	@$(call touch)

# vim: syntax=make
