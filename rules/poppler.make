# -*-makefile-*-
#
# Copyright (C) 2007 by Luotao Fu <l.fu@pengutronix.de>
#               2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POPPLER) += poppler

#
# Paths and names
#
POPPLER_VERSION	:= 0.18.0
POPPLER_MD5	:= 4cd3bf2a0a13fa8eaf00d31368915f77
POPPLER		:= poppler-$(POPPLER_VERSION)
POPPLER_SUFFIX	:= tar.gz
POPPLER_URL	:= http://poppler.freedesktop.org/$(POPPLER).$(POPPLER_SUFFIX)
POPPLER_SOURCE	:= $(SRCDIR)/$(POPPLER).$(POPPLER_SUFFIX)
POPPLER_DIR	:= $(BUILDDIR)/$(POPPLER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(POPPLER_SOURCE):
	@$(call targetinfo)
	@$(call get, POPPLER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POPPLER_PATH	:= PATH=$(CROSS_PATH)
POPPLER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
POPPLER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-xpdf-headers \
	--$(call ptx/disen, PTXCONF_HAS_HARDFLOAT)-single-precision \
	--disable-fixedpoint \
	--disable-libopenjpeg \
	--disable-libtiff \
	--$(call ptx/endis, PTXCONF_POPPLER_ZLIB)-zlib \
	--$(call ptx/endis, PTXCONF_POPPLER_LIB)-libcurl \
	--$(call ptx/endis, PTXCONF_POPPLER_JPEG)-libjpeg \
	--$(call ptx/endis, PTXCONF_POPPLER_PNG)-libpng \
	--$(call ptx/endis, PTXCONF_POPPLER_SPLASH)-splash-output \
	--$(call ptx/endis, PTXCONF_POPPLER_CAIRO)-cairo-output \
	--$(call ptx/endis, PTXCONF_POPPLER_GLIB)-poppler-glib \
	--disable-introspection \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--$(call ptx/endis, PTXCONF_POPPLER_QT4)-poppler-qt4 \
	--disable-poppler-cpp \
	--disable-gtk-test \
	--$(call ptx/endis, PTXCONF_POPPLER_BIN)-utils \
	--disable-compile-warnings \
	--$(call ptx/endis, PTXCONF_POPPLER_CMS)-cms \
	--without-x \
	--with-font-configuration=fontconfig \
	--without-libiconv-prefix

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/poppler.targetinstall:
	@$(call targetinfo)

	@$(call install_init, poppler)
	@$(call install_fixup, poppler, PRIORITY, optional)
	@$(call install_fixup, poppler, SECTION, base)
	@$(call install_fixup, poppler, AUTHOR, "r.schwebel@pengutronix.de")
	@$(call install_fixup, poppler, DESCRIPTION, missing)

	@$(call install_lib, poppler, 0, 0, 0644, libpoppler)

ifdef PTXCONF_POPPLER_BIN
	@cd $(PKGDIR)/$(POPPLER)/usr/bin/ && \
	for i in *; do\
		$(call install_copy, poppler, 0, 0, 0755, -, /usr/bin/$$i); \
	done
endif
ifdef PTXCONF_POPPLER_GLIB
	@$(call install_lib, poppler, 0, 0, 0644, libpoppler-glib)
endif
ifdef PTXCONF_POPPLER_QT4
	@$(call install_lib, poppler, 0, 0, 0644, libpoppler-qt4)
endif
	@$(call install_finish, poppler)

	@$(call touch)

# vim: syntax=make
