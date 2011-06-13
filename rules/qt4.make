# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#               2009 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QT4) += qt4

#
# Paths and names
#
QT4_VERSION	:= 4.7.3
QT4_MD5		:= 49b96eefb1224cc529af6fe5608654fe
QT4		:= qt-everywhere-opensource-src-$(QT4_VERSION)
QT4_SUFFIX	:= tar.gz
QT4_URL		:= http://get.qt.nokia.com/qt/source/$(QT4).$(QT4_SUFFIX)
QT4_SOURCE	:= $(SRCDIR)/$(QT4).$(QT4_SUFFIX)
QT4_DIR		:= $(BUILDDIR)/$(QT4)
QT4_BUILD_OOT	:= YES
QT4_LICENSE	:= GPL3, LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(QT4_SOURCE):
	@$(call targetinfo)
	@$(call get, QT4)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/qt4.extract:
	@$(call targetinfo)
	@$(call clean, $(QT4_DIR))
	@$(call extract, QT4)
	@$(call patchin, QT4)
	@for file in \
			$(QT4_DIR)/mkspecs/qws/linux-ptx-g++/*.in \
			$(QT4_DIR)/mkspecs/linux-ptx-g++/*.in; do \
		sed -e "s,@COMPILER_PREFIX@,$(COMPILER_PREFIX),g" \
		    -e "s,@INCDIR@,$(SYSROOT)/include $(SYSROOT)/usr/include,g" \
		    -e "s,@LIBDIR@,$(SYSROOT)/lib $(SYSROOT)/usr/lib,g" \
		    -e "s#@LDFLAGS@#$(strip $(CROSS_LDFLAGS))#g" \
		    -e "s#@QMAKE_LIBS_OPENGL_ES1@#$(strip $(QT4_QMAKE_LIBS_OPENGL_ES1))#g" \
		    -e "s#@QMAKE_LIBS_OPENGL_ES1CL@#$(strip $(QT4_QMAKE_LIBS_OPENGL_ES1CL))#g" \
		    -e "s#@QMAKE_LIBS_OPENGL_ES2@#$(strip $(QT4_QMAKE_LIBS_OPENGL_ES2))#g" \
		    $$file > $${file%%.in}; \
	done
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# don't use CROSS_ENV. Qt uses mkspecs for instead.
QT4_ENV		:= $(CROSS_ENV_PKG_CONFIG)
QT4_PATH	:= PATH=$(CROSS_PATH)
QT4_INSTALL_OPT	:= INSTALL_ROOT=$(QT4_PKGDIR)

ifdef PTXCONF_ARCH_ARM_V6
QT4_ARCH = armv6
else
QT4_ARCH = $(call remove_quotes, $(PTXCONF_ARCH_STRING))
endif
ifeq ($(QT4_ARCH),ppc)
QT4_ARCH = powerpc
endif

#
# autoconf
#
# Important: Use "-no-fast" here. Otherwise qmake will be called during
# the compile stage when the environment is not properly set!
QT4_AUTOCONF := \
	-opensource \
	-confirm-license \
	-release \
	-no-rpath \
	-no-fast \
	-no-accessibility \
	-no-sql-ibase \
	-no-sql-mysql \
	-no-sql-odbc \
	-no-sql-psql \
	-no-sql-sqlite2 \
	-no-qt3support \
	-no-mmx \
	-no-3dnow \
	-no-sse \
	-no-sse2 \
	-no-neon \
	-no-optimized-qmake \
	-no-nis \
	-no-cups \
	-pch \
	-reduce-relocations \
	-force-pkg-config \
	-prefix /usr \
	-no-armfpa \
	-make libs \
	-nomake docs

ifdef PTXCONF_ICONV
QT4_AUTOCONF += -iconv
else
QT4_AUTOCONF += -no-iconv
endif

ifdef PTXCONF_GLOBAL_LARGE_FILE
QT4_AUTOCONF += -largefile
else
QT4_AUTOCONF += -no-largefile
endif

ifdef PTXCONF_QT4_PLATFORM_EMBEDDED
QT4_AUTOCONF += \
	-embedded $(QT4_ARCH) \
	-qt-decoration-styled \
	-depths all \
	-xplatform qws/linux-ptx-g++
endif

ifdef PTXCONF_QT4_PLATFORM_X11
QT4_AUTOCONF += \
	-x11 \
	-arch $(QT4_ARCH) \
	-xplatform linux-ptx-g++ \
	-no-gtkstyle \
	-no-nas-sound \
	-no-openvg
endif

# -make libs tools examples demos docs translations

# maybe later:
#
# -iwmmxt

QT4_INSTALL_OPT += install_mkspecs install_qmake

ifdef PTXCONF_QT4_PREPARE_EXAMPLES
QT4_AUTOCONF += -make examples -make demos
ifneq ($(strip $(PTXCONF_QT4_EXAMPLES_INSTALL_DIR)),)
QT4_AUTOCONF += -examplesdir $(strip $(PTXCONF_QT4_EXAMPLES_INSTALL_DIR))
endif
else
QT4_AUTOCONF += -nomake examples -nomake demos
endif

ifdef PTXCONF_QT4_PLATFORM_EMBEDDED

# ahi graphics driver
ifdef PTXCONF_QT4_GFX_AHI_PLUGIN
QT4_AUTOCONF += -plugin-gfx-ahi
endif

# directfb graphics driver
ifdef PTXCONF_QT4_GFX_DIRECTFB_PLUGIN
QT4_AUTOCONF += -plugin-gfx-directfb
endif

# linuxfb graphics driver
ifdef PTXCONF_QT4_GFX_LINUXFB_NONE
QT4_AUTOCONF += -no-gfx-linuxfb
endif
ifdef PTXCONF_QT4_GFX_LINUXFB_BUILTIN
QT4_AUTOCONF += -qt-gfx-linuxfb
endif
ifdef PTXCONF_QT4_GFX_LINUXFB_PLUGIN
QT4_AUTOCONF += -plugin-gfx-linuxfb
endif

# powervr graphics driver
ifdef PTXCONF_QT4_GFX_POWERVR_PLUGIN
QT4_AUTOCONF += -plugin-gfx-powervr
endif

# svga graphics driver
ifdef PTXCONF_QT4_GFX_SVGA_PLUGIN
QT4_AUTOCONF += -plugin-gfx-svgalib
endif

# transformed graphics driver
ifdef PTXCONF_QT4_GFX_TRANSFORMED_NONE
QT4_AUTOCONF += -no-gfx-transformed
endif
ifdef PTXCONF_QT4_GFX_TRANSFORMED_BUILTIN
QT4_AUTOCONF += -qt-gfx-transformed
endif
ifdef PTXCONF_QT4_GFX_TRANSFORMED_PLUGIN
QT4_AUTOCONF += -plugin-gfx-transformed
endif

# qvfb graphics driver
ifdef PTXCONF_QT4_GFX_QVFB_NONE
QT4_AUTOCONF += -no-gfx-qvfb
endif
ifdef PTXCONF_QT4_GFX_QVFB_BUILTIN
QT4_AUTOCONF += -qt-gfx-qvfb
endif
ifdef PTXCONF_QT4_GFX_QVFB_PLUGIN
QT4_AUTOCONF += -plugin-gfx-qvfb
endif

# vnc graphics driver
ifdef PTXCONF_QT4_GFX_VNC_NONE
QT4_AUTOCONF += -no-gfx-vnc
endif
ifdef PTXCONF_QT4_GFX_VNC_BUILTIN
QT4_AUTOCONF += -qt-gfx-vnc
endif
ifdef PTXCONF_QT4_GFX_VNC_PLUGIN
QT4_AUTOCONF += -plugin-gfx-vnc
endif

# multiscreen graphics driver
ifdef PTXCONF_QT4_GFX_MULTISCREEN_NONE
QT4_AUTOCONF += -no-gfx-multiscreen
endif
ifdef PTXCONF_QT4_GFX_MULTISCREEN_BUILTIN
QT4_AUTOCONF += -qt-gfx-multiscreen
endif

# hybrid graphics driver
ifdef PTXCONF_QT4_GFX_HYBRID_PLUGIN
QT4_AUTOCONF += -plugin-gfx-hybrid
endif

# tty keyboard driver
ifdef PTXCONF_QT4_KBD_TTY
QT4_AUTOCONF += -qt-kbd-tty
else
QT4_AUTOCONF += -no-kbd-tty
endif

# input keyboard driver
ifdef PTXCONF_QT4_KBD_INPUT
QT4_AUTOCONF += -qt-kbd-linuxinput
else
QT4_AUTOCONF += -no-kbd-linuxinput
endif

# qvfb keyboard driver
ifdef PTXCONF_QT4_KBD_QVFB
QT4_AUTOCONF += -qt-kbd-qvfb
else
QT4_AUTOCONF += -no-kbd-qvfb
endif

# pc mouse driver
ifdef PTXCONF_QT4_MOUSE_PC
QT4_AUTOCONF += -qt-mouse-pc
else
QT4_AUTOCONF += -no-mouse-pc
endif

# pc mouse driver
ifdef PTXCONF_QT4_MOUSE_INPUT
QT4_AUTOCONF += -qt-mouse-linuxinput
else
QT4_AUTOCONF += -no-mouse-linuxinput
endif

# linuxtp mouse driver
ifdef PTXCONF_QT4_MOUSE_LINUXTP
QT4_AUTOCONF += -qt-mouse-linuxtp
else
QT4_AUTOCONF += -no-mouse-linuxtp
endif

# tslib mouse driver
ifdef PTXCONF_QT4_MOUSE_TSLIB
QT4_AUTOCONF += -qt-mouse-tslib
else
QT4_AUTOCONF += -no-mouse-tslib
endif

# qvfb mouse driver
ifdef PTXCONF_QT4_MOUSE_QVFB
QT4_AUTOCONF += -qt-mouse-qvfb
else
QT4_AUTOCONF += -no-mouse-qvfb
endif

endif # PTXCONF_QT4_PLATFORM_EMBEDDED

ifdef PTXCONF_QT4_PLATFORM_X11

ifdef PTXCONF_QT4_X11_SM
QT4_AUTOCONF += -sm
else
QT4_AUTOCONF += -no-sm
endif

ifdef PTXCONF_QT4_X11_XSHAPE
QT4_AUTOCONF += -xshape
else
QT4_AUTOCONF += -no-xshape
endif

ifdef PTXCONF_QT4_X11_XSYNC
QT4_AUTOCONF += -xsync
else
QT4_AUTOCONF += -no-xsync
endif

ifdef PTXCONF_QT4_X11_XINERAMA
QT4_AUTOCONF += -xinerama
else
QT4_AUTOCONF += -no-xinerama
endif

ifdef PTXCONF_QT4_X11_XCURSOR
QT4_AUTOCONF += -xcursor
else
QT4_AUTOCONF += -no-xcursor
endif

ifdef PTXCONF_QT4_X11_XFIXES
QT4_AUTOCONF += -xfixes
else
QT4_AUTOCONF += -no-xfixes
endif

ifdef PTXCONF_QT4_X11_XRANDR
QT4_AUTOCONF += -xrandr
else
QT4_AUTOCONF += -no-xrandr
endif

ifdef PTXCONF_QT4_X11_XRENDER
QT4_AUTOCONF += -xrender
else
QT4_AUTOCONF += -no-xrender
endif

ifdef PTXCONF_QT4_X11_MITSHM
QT4_AUTOCONF += -mitshm
else
QT4_AUTOCONF += -no-mitshm
endif

ifdef PTXCONF_QT4_X11_FONTCONFIG
QT4_AUTOCONF += -fontconfig
else
QT4_AUTOCONF += -no-fontconfig
endif

ifdef PTXCONF_QT4_X11_XINPUT
QT4_AUTOCONF += -xinput
else
QT4_AUTOCONF += -no-xinput
endif

ifdef PTXCONF_QT4_X11_XKB
QT4_AUTOCONF += -xkb
else
QT4_AUTOCONF += -no-xkb
endif

endif # PTXCONF_QT4_PLATFORM_X11

# PNG support
ifdef PTXCONF_QT4_PNG_NONE
QT4_AUTOCONF += -no-libpng
endif
ifdef PTXCONF_QT4_PNG_INTERNAL
QT4_AUTOCONF += -qt-libpng
endif
ifdef PTXCONF_QT4_PNG_SYSTEM
QT4_AUTOCONF += -system-libpng
endif

# MNG support
ifdef PTXCONF_QT4_MNG_NONE
QT4_AUTOCONF += -no-libmng
endif
ifdef PTXCONF_QT4_MNG_INTERNAL
QT4_AUTOCONF += -qt-libmng
endif
ifdef PTXCONF_QT4_MNG_SYSTEM
QT4_AUTOCONF += -system-libmng
endif

# TIFF support
ifdef PTXCONF_QT4_TIFF_NONE
QT4_AUTOCONF += -no-libtiff
endif
ifdef PTXCONF_QT4_TIFF_INTERNAL
QT4_AUTOCONF += -qt-libtiff
endif
ifdef PTXCONF_QT4_TIFF_SYSTEM
QT4_AUTOCONF += -system-libtiff
endif

# GIF support
ifdef PTXCONF_QT4_GIF_NONE
QT4_AUTOCONF += -no-gif
endif
ifdef PTXCONF_QT4_GIF_INTERNAL
QT4_AUTOCONF += -qt-gif
endif

# JPG support
ifdef PTXCONF_QT4_JPG_NONE
QT4_AUTOCONF += -no-libjpeg
endif
ifdef PTXCONF_QT4_JPG_INTERNAL
QT4_AUTOCONF += -qt-libjpeg
endif
ifdef PTXCONF_QT4_JPG_SYSTEM
QT4_AUTOCONF += -system-libjpeg
endif

ifdef PTXCONF_QT4_ZLIB_INTERNAL
QT4_AUTOCONF += -qt-zlib
endif
ifdef PTXCONF_QT4_ZLIB_SYSTEM
QT4_AUTOCONF += -system-zlib
endif

ifdef PTXCONF_QT4_FREETYPE_NONE
QT4_AUTOCONF += -no-freetype
endif
ifdef PTXCONF_QT4_FREETYPE_INTERNAL
QT4_AUTOCONF += -qt-freetype
endif
ifdef PTXCONF_QT4_FREETYPE_SYSTEM
QT4_AUTOCONF += -system-freetype -I$(SYSROOT)/usr/include/freetype2
endif

ifdef PTXCONF_ENDIAN_LITTLE
QT4_AUTOCONF += -little-endian
else
QT4_AUTOCONF += -big-endian
endif

ifdef PTXCONF_QT4_STL
QT4_AUTOCONF += -stl
else
QT4_AUTOCONF += -no-stl
endif

ifdef PTXCONF_QT4_GLIB
QT4_AUTOCONF += -glib
else
QT4_AUTOCONF += -no-glib
endif

ifdef PTXCONF_QT4_OPENSSL
QT4_AUTOCONF += -openssl
else
QT4_AUTOCONF += -no-openssl
endif

ifdef PTXCONF_QT4_DBUS_LOAD
QT4_AUTOCONF += -dbus
endif
ifdef PTXCONF_QT4_DBUS_LINK
QT4_AUTOCONF += -dbus-linked
endif
ifndef PTXCONF_QT4_DBUS
QT4_AUTOCONF += -no-qdbus
endif

ifdef PTXCONF_QT4_OPENGL_DESKTOP
QT4_AUTOCONF += -opengl
endif
ifdef PTXCONF_QT4_OPENGL_ES1
QT4_AUTOCONF += -opengl es1
endif
ifdef PTXCONF_QT4_OPENGL_ES1CL
QT4_AUTOCONF += -opengl es1cl
endif
ifdef PTXCONF_QT4_OPENGL_ES2
QT4_AUTOCONF += -opengl es2
endif
ifdef PTXCONF_QT4_OPENGL_NONE
QT4_AUTOCONF += -no-opengl
endif

ifdef PTXCONF_QT4_OPENGL_EGL
QT4_AUTOCONF += -egl
else
QT4_AUTOCONF += -no-egl
endif


ifdef PTXCONF_QT4_SHARED
QT4_AUTOCONF += -shared
QT4_PLUGIN_EXT := so
else
QT4_AUTOCONF += -static
QT4_PLUGIN_EXT := a
endif

ifdef PTXCONF_QT4_BUILD_QTXMLPATTERNS
QT4_AUTOCONF += -xmlpatterns -exceptions
QT4_BUILD_TARGETS += sub-xmlpatterns
QT4_INSTALL_OPT += sub-xmlpatterns-install_subtargets
else
QT4_AUTOCONF += -no-xmlpatterns -no-exceptions
endif
ifdef PTXCONF_QT4_BUILD_MULTIMEDIA
QT4_AUTOCONF += -multimedia -audio-backend
QT4_BUILD_TARGETS += sub-multimedia
QT4_INSTALL_OPT += sub-multimedia-install_subtargets
else
QT4_AUTOCONF += -no-multimedia -no-audio-backend
endif
ifdef PTXCONF_QT4_BUILD_PHONON
QT4_AUTOCONF += -phonon -phonon-backend
QT4_BUILD_TARGETS += sub-phonon
QT4_INSTALL_OPT += sub-phonon-install_subtargets
else
QT4_AUTOCONF += -no-phonon -no-phonon-backend
endif
ifdef PTXCONF_QT4_BUILD_WEBKIT
QT4_AUTOCONF += -webkit
QT4_BUILD_TARGETS += sub-webkit
QT4_INSTALL_OPT += sub-webkit-install_subtargets
ifdef PTXCONF_QT4_BUILD_DECLARATIVE
QT4_BUILD_TARGETS += sub-webkitdeclarative
QT4_INSTALL_OPT += sub-webkitdeclarative-install_subtargets
endif
else
QT4_AUTOCONF += -no-webkit
endif
ifdef PTXCONF_QT4_BUILD_SCRIPTTOOLS
QT4_AUTOCONF += -scripttools
QT4_BUILD_TARGETS += sub-scripttools
QT4_INSTALL_OPT += sub-scripttools-install_subtargets
else
QT4_AUTOCONF += -no-scripttools
endif

# SQL: SQLITE support
# if QtSql is deactivated QT4_SQLITE_NONE is also deactivated -- but
# is the option used if no Sql support is build?
# this should be checked. As workaround use ifeq
#ifdef PTXCONF_QT4_SQLITE_NONE
ifeq ($(PTXCONF_QT4_SQLITE_BUILTIN)$(PTXCONF_QT4_SQLITE_PLUGIN),)
QT4_AUTOCONF += -no-sql-sqlite
endif
ifdef PTXCONF_QT4_SQLITE_BUILTIN
QT4_AUTOCONF += -qt-sql-sqlite
endif
ifdef PTXCONF_QT4_SQLITE_PLUGIN
QT4_AUTOCONF += -plugin-sql-sqlite
endif

ifneq ($(PTXCONF_QT4_BUILD_DESIGNERLIBS)$(PTXCONF_QT4_BUILD_ASSISTANTLIB)$(PTXCONF_QT4_INSTALL_QMLVIEWER),)
QT4_AUTOCONF += -make tools
QT4_BUILD_TOOLS_TARGETS = sub-tools
QT4_INSTALL_OPT += sub-tools-install_subtargets
# qmlviewer does not need xml but we cannot built sub-tools without it
QT4_BUILD_TARGETS += sub-xml
else
QT4_AUTOCONF += -nomake tools
endif

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

# these are always built:

# moc
QT4_BUILD_TARGETS += sub-moc
QT4_INSTALL_OPT += sub-moc-install_subtargets
# rcc
QT4_BUILD_TARGETS += sub-rcc
QT4_INSTALL_OPT += sub-rcc-install_subtargets
# QtCore
QT4_BUILD_TARGETS += sub-corelib
QT4_INSTALL_OPT += sub-corelib-install_subtargets
# plugins (any selected plugins, gfx, image, mouse...)
QT4_BUILD_TARGETS += sub-plugins
QT4_INSTALL_OPT += sub-plugins-install_subtargets

ifdef PTXCONF_QT4_BUILD_XML
QT4_BUILD_TARGETS += sub-xml
QT4_INSTALL_OPT += sub-xml-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_GUI
QT4_BUILD_TARGETS += sub-gui
QT4_INSTALL_OPT += sub-gui-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_SQL
QT4_BUILD_TARGETS += sub-sql
QT4_INSTALL_OPT += sub-sql-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_NETWORK
QT4_BUILD_TARGETS += sub-network
QT4_INSTALL_OPT += sub-network-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_SVG
QT4_AUTOCONF += -svg
QT4_BUILD_TARGETS += sub-svg
QT4_INSTALL_OPT += sub-svg-install_subtargets
else
QT4_AUTOCONF += -no-svg
endif
ifdef PTXCONF_QT4_BUILD_SCRIPT
QT4_AUTOCONF += -script
QT4_BUILD_TARGETS += sub-script
QT4_INSTALL_OPT += sub-script-install_subtargets
else
QT4_AUTOCONF += -no-script
endif
ifdef PTXCONF_QT4_BUILD_QTESTLIB
QT4_BUILD_TARGETS += sub-testlib
QT4_INSTALL_OPT += sub-testlib-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_DECLARATIVE
QT4_AUTOCONF += -declarative
QT4_BUILD_TARGETS += sub-declarative sub-imports
QT4_INSTALL_OPT += sub-declarative-install_subtargets sub-imports-install_subtargets
else
QT4_AUTOCONF += -no-declarative
endif

$(STATEDIR)/qt4.compile:
	@$(call targetinfo)
ifneq ($(strip $(QT4_BUILD_TARGETS)), )
	$(call compile, QT4, $(QT4_BUILD_TARGETS))
endif

#	# These targets don't have the correct dependencies.
#	# We have to build them later
ifneq ($(strip $(QT4_BUILD_TOOLS_TARGETS)), )
	@$(call compile, QT4, $(QT4_BUILD_TOOLS_TARGETS))
endif
ifdef PTXCONF_QT4_PREPARE_EXAMPLES
#	# FIXME: use "-k" and " || true" for now.
#	# some examples will may fail to build because of missing libraries
#	# these cannot be installed but all are built
	@$(call compile, QT4, -k sub-examples) || true
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qt4.install:
	@$(call targetinfo)
	@$(call install, QT4)
	@find "$(QT4_PKGDIR)" -name "*.la" -print0 | xargs -r -0 -- \
		sed -i -e "/^dependency_libs/s:\( \|-L\|-R\)$(QT4_PKGDIR)\(/lib\|/usr/lib\):\1$(SYSROOT)\2:g"
	@find "$(QT4_PKGDIR)" -name "*.prl" -print0 | xargs -r -0 -- \
		sed -i -e "/^QMAKE_PRL_LIBS/s:\( \|-L\|-R\)$(QT4_PKGDIR)\(/lib\|/usr/lib\):\1$(SYSROOT)\2:g"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qt4.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qt4)
	@$(call install_fixup, qt4,PRIORITY,optional)
	@$(call install_fixup, qt4,SECTION,base)
	@$(call install_fixup, qt4,AUTHOR,"Juergen Beisertl <j.beisert@pengutronix.de>")
	@$(call install_fixup, qt4,DESCRIPTION,missing)

ifdef PTXCONF_QT4_SHARED
# always install QtCore
	@$(call install_lib, qt4, 0, 0, 0644, libQtCore)
ifdef PTXCONF_QT4_BUILD_XML
	@$(call install_lib, qt4, 0, 0, 0644, libQtXml)
endif
ifdef PTXCONF_QT4_BUILD_GUI
	@$(call install_lib, qt4, 0, 0, 0644, libQtGui)
endif
ifdef PTXCONF_QT4_BUILD_SQL
	@$(call install_lib, qt4, 0, 0, 0644, libQtSql)
endif
ifdef PTXCONF_QT4_SQLITE_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/sqldrivers/libqsqlite.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_BUILD_NETWORK
	@$(call install_lib, qt4, 0, 0, 0644, libQtNetwork)
endif
ifdef PTXCONF_QT4_BUILD_SVG
	@$(call install_lib, qt4, 0, 0, 0644, libQtSvg)
endif
ifdef PTXCONF_QT4_BUILD_SCRIPT
	@$(call install_lib, qt4, 0, 0, 0644, libQtScript)
endif
ifdef PTXCONF_QT4_BUILD_QTESTLIB
	@$(call install_lib, qt4, 0, 0, 0644, libQtTest)
endif
ifdef PTXCONF_QT4_BUILD_ASSISTANTLIB
	@$(call install_lib, qt4, 0, 0, 0644, libQtCLucene)
	@$(call install_lib, qt4, 0, 0, 0644, libQtHelp)
endif
ifdef PTXCONF_QT4_DBUS
	@$(call install_lib, qt4, 0, 0, 0644, libQtDBus)
endif
ifdef PTXCONF_QT4_BUILD_DESIGNERLIBS
	@$(call install_lib, qt4, 0, 0, 0644, libQtDesigner)
endif
ifdef PTXCONF_QT4_BUILD_WEBKIT
	@$(call install_lib, qt4, 0, 0, 0644, libQtWebKit)
ifdef PTXCONF_QT4_BUILD_DECLARATIVE
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/imports/QtWebKit/qmldir)
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/imports/QtWebKit/libqmlwebkitplugin.so)
endif
endif
ifdef PTXCONF_QT4_BUILD_SCRIPTTOOLS
	@$(call install_lib, qt4, 0, 0, 0644, libQtScriptTools)
endif
ifdef PTXCONF_QT4_BUILD_QTXMLPATTERNS
	@$(call install_lib, qt4, 0, 0, 0644, libQtXmlPatterns)
endif
ifdef PTXCONF_QT4_BUILD_DECLARATIVE
	@$(call install_lib, qt4, 0, 0, 0644, libQtDeclarative)

	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/imports/Qt/labs/folderlistmodel/qmldir)
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/imports/Qt/labs/folderlistmodel/libqmlfolderlistmodelplugin.so)

	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/imports/Qt/labs/gestures/qmldir)
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/imports/Qt/labs/gestures/libqmlgesturesplugin.so)

	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/imports/Qt/labs/particles/qmldir)
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/imports/Qt/labs/particles/libqmlparticlesplugin.so)
endif
ifdef PTXCONF_QT4_BUILD_OPENGL
	@$(call install_lib, qt4, 0, 0, 0644, libQtOpenGL)
endif
ifdef PTXCONF_QT4_BUILD_PHONON
	@$(call install_lib, qt4, 0, 0, 0644, libphonon)
endif
endif #PTXCONF_QT4_SHARED
ifdef PTXCONF_QT4_GFX_LINUXFB_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/gfxdrivers/libqscreenlinuxfb.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_DIRECTFB_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/gfxdrivers/libqdirectfbscreen.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_TRANSFORMED_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/gfxdrivers/libqgfxtransformed.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_VNC_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/gfxdrivers/libqgfxvnc.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_QVFB_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/gfxdrivers/libqscreenvfb.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_POWERVR_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/gfxdrivers/libqgfxpvregl.$(QT4_PLUGIN_EXT))
	@$(call install_lib, qt4, 0, 0, 0644, libpvrQWSWSEGL)
endif
ifdef PTXCONF_QT4_DBUS
ifdef PTXCONF_QT4_BUILD_SCRIPT
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/script/libqtscriptdbus.$(QT4_PLUGIN_EXT))
endif
endif
ifdef PTXCONF_QT4_GIF_INTERNAL
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/imageformats/libqgif.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_JPG_NONE
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/imageformats/libqjpeg.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_MNG_NONE
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/imageformats/libqmng.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_TIFF_NONE
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/imageformats/libqtiff.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_ICO_NONE
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/imageformats/libqico.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_BUILD_SVG
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/imageformats/libqsvg.$(QT4_PLUGIN_EXT))
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/iconengines/libqsvgicon.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_BUILD_NETWORK
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/bearer/libqgenericbearer.$(QT4_PLUGIN_EXT))
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/bearer/libqnmbearer.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_BUILD_PHONON
	@$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/plugins/phonon_backend/libphonon_gstreamer.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_INSTALL_QMLVIEWER
	@$(call install_copy, qt4, 0, 0, 0755, -, \
		/usr/bin/qmlviewer)
endif

ifdef PTXCONF_QT4_FONT_DEJAVU
	@for i in \
		DejaVuSans-Bold.ttf \
		DejaVuSans-BoldOblique.ttf \
		DejaVuSans-Oblique.ttf \
		DejaVuSans.ttf \
		DejaVuSansMono-Bold.ttf \
		DejaVuSansMono-BoldOblique.ttf \
		DejaVuSansMono-Oblique.ttf \
		DejaVuSansMono.ttf \
		DejaVuSerif-Bold.ttf \
		DejaVuSerif-BoldOblique.ttf \
		DejaVuSerif-Oblique.ttf \
		DejaVuSerif.ttf; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_UT
	@for i in \
		'UTBI____.pfa' \
		'UTB_____.pfa' \
		'UTI_____.pfa' \
		'UTRG____.pfa'; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_VERA
	@for i in \
		Vera.ttf \
		VeraBI.ttf \
		VeraBd.ttf \
		VeraIt.ttf \
		VeraMoBI.ttf \
		VeraMoBd.ttf \
		VeraMoIt.ttf \
		VeraMono.ttf \
		VeraSe.ttf \
		VeraSeBd.ttf; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_C0
	@for i in \
		c0419bt_.pfb \
		c0582bt_.pfb \
		c0583bt_.pfb \
		c0611bt_.pfb \
		c0632bt_.pfb \
		c0633bt_.pfb \
		c0648bt_.pfb \
		c0649bt_.pfb; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_COUR
	@for i in \
		cour.pfa \
		courb.pfa \
		courbi.pfa \
		couri.pfa; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_CURSOR
	@for i in \
		cursor.pfa; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_FIXED
	@for i in \
		fixed_120_50.qpf \
		fixed_70_50.qpf; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_HELVETICA
	@for i in \
		helvetica_100_50.qpf \
		helvetica_100_50i.qpf \
		helvetica_100_75.qpf \
		helvetica_100_75i.qpf \
		helvetica_120_50.qpf \
		helvetica_120_50i.qpf \
		helvetica_120_75.qpf \
		helvetica_120_75i.qpf \
		helvetica_140_50.qpf \
		helvetica_140_50i.qpf \
		helvetica_140_75.qpf \
		helvetica_140_75i.qpf \
		helvetica_180_50.qpf \
		helvetica_180_50i.qpf \
		helvetica_180_75.qpf \
		helvetica_180_75i.qpf \
		helvetica_240_50.qpf \
		helvetica_240_50i.qpf \
		helvetica_240_75.qpf \
		helvetica_240_75i.qpf \
		helvetica_80_50.qpf \
		helvetica_80_50i.qpf \
		helvetica_80_75.qpf \
		helvetica_80_75i.qpf; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i,n); \
	done
endif

ifdef PTXCONF_QT4_FONT_JAPANESE
	@for i in \
		japanese_230_50.qpf; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_L04
	@for i in \
		l047013t.pfa \
		l047016t.pfa \
		l047033t.pfa \
		l047036t.pfa \
		l048013t.pfa \
		l048016t.pfa \
		l048033t.pfa \
		l048036t.pfa \
		l049013t.pfa \
		l049016t.pfa \
		l049033t.pfa \
		l049036t.pfa; do \
	$(call install_copy, qt4, 0, 0, 0644, -, \
		/usr/lib/fonts/$$i, n); \
	done
endif
ifdef PTXCONF_PRELINK
	@$(call install_alternative, qt4, 0, 0, 0644, \
		/etc/prelink.conf.d/qt4)
endif


	@$(call install_finish, qt4)

	@$(call touch)

# vim: syntax=make
