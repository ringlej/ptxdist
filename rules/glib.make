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
ifdef PTXCONF_GLIB_EXPERIMENTAL
GLIB_VERSION	:= 2.25.7
else
GLIB_VERSION	:= 2.22.2
endif

GLIB		:= glib-$(GLIB_VERSION)
GLIB_SUFFIX	:= tar.bz2
GLIB_SOURCE	:= $(SRCDIR)/$(GLIB).$(GLIB_SUFFIX)
GLIB_DIR	:= $(BUILDDIR)/$(GLIB)

ifdef PTXCONF_GLIB_EXPERIMENTAL
GLIB_URL	:= http://ftp.gtk.org/pub/glib/2.25/glib-$(GLIB_VERSION).$(GLIB_SUFFIX)
else
GLIB_URL	:= http://ftp.gtk.org/pub/glib/2.22/glib-$(GLIB_VERSION).$(GLIB_SUFFIX)
endif

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

ifdef PTXCONF_GLIB_EXPERIMENTAL
GLIB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-silent-rules \
	--enable-debug=minimum \
	--disable-gc-friendly \
	--enable-mem-pools \
	--enable-threads \
	--with-threads=posix \
	--disable-rebuilds \
	--disable-included-printf \
	--disable-selinux \
	--disable-fam \
	--disable-xattr \
	--disable-gtk-doc \
	--disable-man \
	--with-pcre=internal \
	--enable-static \
	--enable-shared \
	--with-libiconv=no
else
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
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ifdef PTXCONF_GLIB_EXPERIMENTAL
GLIB_LIB_VERSION := 0.2507.0
else
GLIB_LIB_VERSION := 0.2200.2
endif

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
