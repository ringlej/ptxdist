# -*-makefile-*-
#
# Copyright (C) 2007 by Luotao Fu <l.fu@pengutronix.de>
#               2009 by Robert Schwebel
#               2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
# TODOs for improvement:
# - package libnss for signature support in PDFs
# - package libtiff for additional TIFF support
# - runtime-test the Qt5 backend
# - package libopenjpeg and build with --enable-libopenjpeg
#
# We provide this package
#
PACKAGES-$(PTXCONF_POPPLER) += poppler

#
# Paths and names
#
POPPLER_VERSION	:= 0.61.1
POPPLER_MD5	:= 2d3dcea88d6a814317fac74d2a16c3cd
POPPLER		:= poppler-$(POPPLER_VERSION)
POPPLER_SUFFIX	:= tar.xz
POPPLER_URL	:= http://poppler.freedesktop.org/$(POPPLER).$(POPPLER_SUFFIX)
POPPLER_SOURCE	:= $(SRCDIR)/$(POPPLER).$(POPPLER_SUFFIX)
POPPLER_DIR	:= $(BUILDDIR)/$(POPPLER)
POPPLER_LICENSE	:= GPL-2.0-only OR GPL-3.0-only
POPPLER_LICENSE_FILES	:= \
	file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
	file://COPYING3;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POPPLER_PATH	:= PATH=$(CROSS_PATH)
POPPLER_ENV 	:= $(CROSS_ENV)

#
# CMake
#
# FindThreads.cmake tries to determine if our compiler understands -pthread by
# compiling a file and running the binary. We set -DTHREADS_PTHREAD_ARG=2 to
# tell CMake that this binary returns 2, which means -pthread. is understood.
#
POPPLER_CONF_TOOL	:= cmake
POPPLER_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=ON \
	-DEXTRA_WARN=NO \
	-DTHREADS_PTHREAD_ARG=2 \
	-DFONT_CONFIGURATION=fontconfig \
	-DENABLE_UTILS=$(call ptx/onoff,PTXCONF_POPPLER_BIN) \
	-DENABLE_XPDF_HEADERS=$(call ptx/onoff,PTXCONF_POPPLER_XPDF) \
	-DENABLE_CPP=$(call ptx/onoff,PTXCONF_POPPLER_CPP) \
	-DWITH_Iconv=ON \
	-DBUILD_CPP_TESTS=NO \
	-DENABLE_GLIB=$(call ptx/onoff,PTXCONF_POPPLER_GLIB) \
	-DWITH_GLIB=$(call ptx/onoff,PTXCONF_POPPLER_GLIB) \
	-DWITH_GObjectIntrospection=$(call ptx/onoff,PTXCONF_POPPLER_INTROSPECTION) \
	-DENABLE_QT4=$(call ptx/onoff,PTXCONF_POPPLER_QT4) \
	-DWITH_Qt4=$(call ptx/onoff,PTXCONF_POPPLER_QT4) \
	-DBUILD_QT4_TESTS=NO \
	-DENABLE_QT5=$(call ptx/onoff,PTXCONF_POPPLER_QT5) \
	-DBUILD_QT5_TESTS=NO \
	-DWITH_Cairo=$(call ptx/onoff,PTXCONF_POPPLER_CAIRO) \
	-DWITH_GTK=NO \
	-DBUILD_GTK_TESTS=NO \
	-DENABLE_GTK_DOC=NO \
	-DENABLE_SPLASH=$(call ptx/onoff,PTXCONF_POPPLER_SPLASH) \
	-DSPLASH_CMYK=$(call ptx/onoff,PTXCONF_POPPLER_SPLASH_CMYK) \
	-DUSE_FLOAT=$(call ptx/onoff,PTXCONF_POPPLER_SPLASH_SINGLE) \
	-DUSE_FIXEDPOINT=$(call ptx/onoff,PTXCONF_POPPLER_SPLASH_FIXED) \
	-DWITH_PNG=$(call ptx/onoff,PTXCONF_POPPLER_PNG) \
	-DWITH_JPEG=$(call ptx/onoff,PTXCONF_POPPLER_JPEG) \
	-DENABLE_DCTDECODER=$(call ptx/ifdef,PTXCONF_POPPLER_JPEG,libjpeg,none) \
	-DENABLE_LIBOPENJPEG=$(call ptx/ifdef,PTXCONF_POPPLER_OPENJPEG,openjpeg2,none) \
	-DWITH_TIFF=$(call ptx/onoff,PTXCONF_POPPLER_TIFF) \
	-DWITH_NSS3=$(call ptx/onoff,PTXCONF_POPPLER_NSS) \
	-DENABLE_ZLIB=$(call ptx/onoff,PTXCONF_POPPLER_ZLIB) \
	-DENABLE_ZLIB_UNCOMPRESS=NO \
	-DENABLE_LIBCURL=$(call ptx/onoff,PTXCONF_POPPLER_CURL) \
	-DENABLE_CMS=$(call ptx/ifdef,PTXCONF_POPPLER_CMS,lcms2,)

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
ifdef PTXCONF_POPPLER_CPP
	@$(call install_lib, poppler, 0, 0, 0644, libpoppler-cpp)
endif
ifdef PTXCONF_POPPLER_GLIB
	@$(call install_lib, poppler, 0, 0, 0644, libpoppler-glib)
endif
ifdef PTXCONF_POPPLER_QT4
	@$(call install_lib, poppler, 0, 0, 0644, libpoppler-qt4)
endif
ifdef PTXCONF_POPPLER_QT5
	@$(call install_lib, poppler, 0, 0, 0644, libpoppler-qt5)
endif
ifdef PTXCONF_POPPLER_INTROSPECTION
	@$(call install_copy, poppler, 0, 0, 0644, -, \
		/usr/share/gir-1.0/Poppler-0.18.gir)
	@$(call install_copy, poppler, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Poppler-0.18.typelib)
endif
	@$(call install_finish, poppler)

	@$(call touch)

# vim: syntax=make
