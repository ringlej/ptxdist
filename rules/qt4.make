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
QT4_VERSION	:= 4.5.3
QT4		:= qt-embedded-linux-opensource-src-$(QT4_VERSION)
QT4_SUFFIX	:= tar.gz
QT4_URL		:= http://get.qt.nokia.com/qt/source/$(QT4).$(QT4_SUFFIX)
QT4_SOURCE	:= $(SRCDIR)/$(QT4).$(QT4_SUFFIX)
QT4_DIR		:= $(BUILDDIR)/$(QT4)
QT4_PKGDIR	:= $(PKGDIR)/$(QT4)
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
	@$(call extract, QT4)
	@$(call patchin, QT4)
	@for file in $(QT4_DIR)/mkspecs/qws/linux-ptx-g++/*.in; do \
		sed -e "s,@COMPILER_PREFIX@,$(COMPILER_PREFIX),g" \
		    -e "s,@INCDIR@,$(SYSROOT)/include $(SYSROOT)/usr/include,g" \
		    -e "s,@LIBDIR@,$(SYSROOT)/lib $(SYSROOT)/usr/lib,g" \
		    -e "s#@LDFLAGS@#$(strip $(CROSS_LDFLAGS))#g" \
		    $$file > $${file%%.in}; \
	done
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# don't use CROSS_ENV. Qt uses mkspecs for instead.
QT4_ENV		:= $(CROSS_ENV_FLAGS) $(CROSS_ENV_PKG_CONFIG)
QT4_PATH	:= PATH=$(CROSS_PATH)
QT4_MAKEVARS	:= INSTALL_ROOT=$(QT4_PKGDIR)

# With the introduction of platformconfigs PTXCONF_ARCH was
# renamed to PTXCONF_ARCH_STRING.
ifdef PTXCONF_ARCH
QT4_ARCH = $(call remove_quotes, $(PTXCONF_ARCH))
else
QT4_ARCH = $(call remove_quotes, $(PTXCONF_ARCH_STRING))
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
	-no-fast \
	-no-largefile \
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
	-no-optimized-qmake \
	-no-nis \
	-no-cups \
	-no-iconv \
	-pch \
	-force-pkg-config \
	-embedded $(QT4_ARCH) \
	-qt-decoration-styled \
	-depths all \
	-prefix /usr \
	-no-armfpa \
	-xplatform qws/linux-ptx-g++ \
	-make libs \
	-make tools

# -make libs tools examples demos docs translations

# maybe later:
#
# -iwmmxt

QT4_INSTALL_TARGETS = install_mkspecs install_qmake

ifdef PTXCONF_QT4_PREPARE_EXAMPLES
QT4_AUTOCONF += -make examples -make demos
else
QT4_AUTOCONF += -nomake examples -nomake demos
endif

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
QT4_AUTOCONF += -plugin-powervr-ahi
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

# usb keyboard driver
ifdef PTXCONF_QT4_KBD_USB
QT4_AUTOCONF += -qt-kbd-usb
else
QT4_AUTOCONF += -no-kbd-usb
endif

# sl5000 keyboard driver
ifdef PTXCONF_QT4_KBD_SL5000
QT4_AUTOCONF += -qt-kbd-sl5000
else
QT4_AUTOCONF += -no-kbd-sl5000
endif

# yopy keyboard driver
ifdef PTXCONF_QT4_KBD_YOPY
QT4_AUTOCONF += -qt-kbd-yopy
else
QT4_AUTOCONF += -no-kbd-yopy
endif

# vr41xx keyboard driver
ifdef PTXCONF_QT4_KBD_VR41XX
QT4_AUTOCONF += -qt-kbd-vr41xx
else
QT4_AUTOCONF += -no-kbd-vr41xx
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

# bus mouse driver
ifdef PTXCONF_QT4_MOUSE_BUS
QT4_AUTOCONF += -qt-mouse-bus
else
QT4_AUTOCONF += -no-mouse-bus
endif

# linuxtp mouse driver
ifdef PTXCONF_QT4_MOUSE_LINUXTP
QT4_AUTOCONF += -qt-mouse-linuxtp
else
QT4_AUTOCONF += -no-mouse-linuxtp
endif

# yopy mouse driver
ifdef PTXCONF_QT4_MOUSE_YOPY
QT4_AUTOCONF += -qt-mouse-yopy
else
QT4_AUTOCONF += -no-mouse-yopy
endif

# vr41xx mouse driver
ifdef PTXCONF_QT4_MOUSE_VR41XX
QT4_AUTOCONF += -qt-mouse-vr41xx
else
QT4_AUTOCONF += -no-mouse-vr41xx
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
ifdef PTXCONF_QT4_DBUS_NONE
QT4_AUTOCONF += -no-qdbus
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
QT4_INSTALL_TARGETS += sub-xmlpatterns-install_subtargets
else
QT4_AUTOCONF += -no-xmlpatterns -no-exceptions
endif
ifdef PTXCONF_QT4_BUILD_PHONON
QT4_AUTOCONF += -phonon -phonon-backend
QT4_BUILD_TARGETS += sub-phonon
QT4_INSTALL_TARGETS += sub-phonon-install_subtargets
else
QT4_AUTOCONF += -no-phonon -no-phonon-backend
endif
ifdef PTXCONF_QT4_BUILD_WEBKIT
QT4_AUTOCONF += -webkit
QT4_BUILD_TARGETS += sub-webkit
QT4_INSTALL_TARGETS += sub-webkit-install_subtargets
else
QT4_AUTOCONF += -no-webkit
endif
ifdef PTXCONF_QT4_BUILD_SCRIPTTOOLS
QT4_AUTOCONF += -scripttools
QT4_BUILD_TARGETS += sub-scripttools
QT4_INSTALL_TARGETS += sub-scripttools-install_subtargets
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

ifneq ($(PTXCONF_QT4_DBUS_LOAD)$(PTXCONF_QT4_DBUS_LINK)$(PTXCONF_QT4_BUILD_DESIGNERLIBS)$(PTXCONF_QT4_BUILD_ASSISTANTLIB),)
QT4_BUILD_TOOLS_TARGETS = sub-tools
endif

$(STATEDIR)/qt4.prepare:
	@$(call targetinfo)
	@$(call clean, $(QT4_DIR)/config.cache)

	@rm -f $(QT4_DIR)/bin/qt.conf
	@cd $(QT4_DIR) && $(QT4_PATH) $(QT4_ENV) $(MAKE) \
		confclean || true

	@cd $(QT4_DIR) && \
		$(QT4_PATH) $(QT4_ENV) \
		./configure $(QT4_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

# these are always built:

# moc
QT4_BUILD_TARGETS += sub-moc
QT4_INSTALL_TARGETS += sub-moc-install_subtargets
# rcc
QT4_BUILD_TARGETS += sub-rcc
QT4_INSTALL_TARGETS += sub-rcc-install_subtargets
# QtCore
QT4_BUILD_TARGETS += sub-corelib
QT4_INSTALL_TARGETS += sub-corelib-install_subtargets
# plugins (any selected plugins, gfx, image, mouse...)
QT4_BUILD_TARGETS += sub-plugins
QT4_INSTALL_TARGETS += sub-plugins-install_subtargets

ifdef PTXCONF_QT4_BUILD_UIC
QT4_BUILD_TARGETS += sub-uic
QT4_INSTALL_TARGETS += sub-uic-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_XML
QT4_BUILD_TARGETS += sub-xml
QT4_INSTALL_TARGETS += sub-xml-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_GUI
QT4_BUILD_TARGETS += sub-gui
QT4_INSTALL_TARGETS += sub-gui-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_SQL
QT4_BUILD_TARGETS += sub-sql
QT4_INSTALL_TARGETS += sub-sql-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_NETWORK
QT4_BUILD_TARGETS += sub-network
QT4_INSTALL_TARGETS += sub-network-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_SVG
QT4_BUILD_TARGETS += sub-svg
QT4_INSTALL_TARGETS += sub-svg-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_SCRIPT
QT4_BUILD_TARGETS += sub-script
QT4_INSTALL_TARGETS += sub-script-install_subtargets
endif
ifdef PTXCONF_QT4_BUILD_QTESTLIB
QT4_BUILD_TARGETS += sub-testlib
QT4_INSTALL_TARGETS += sub-testlib-install_subtargets
endif

$(STATEDIR)/qt4.compile:
	@$(call targetinfo)
ifneq ($(strip $(QT4_BUILD_TARGETS)), )
	cd $(QT4_DIR) && $(QT4_PATH) $(QT4_ENV) $(MAKE) \
		$(PARALLELMFLAGS) $(QT4_BUILD_TARGETS)
endif

#	# These targets don't have the correct dependencies.
#	# We have to build them later
	echo $(QT4_BUILD_TOOLS_TARGETS)
ifneq ($(strip $(QT4_BUILD_TOOLS_TARGETS)), )
	cd $(QT4_DIR) && $(QT4_PATH) $(QT4_ENV) $(MAKE) \
		$(PARALLELMFLAGS) $(QT4_BUILD_TOOLS_TARGETS)
endif
ifdef PTXCONF_QT4_PREPARE_EXAMPLES
#	# FIXME: use "-k" and " || true" for now.
#	# some examples will may fail to build because of missing libraries
#	# these cannot be installed but all are built
	cd $(QT4_DIR) && $(QT4_PATH) $(QT4_ENV) $(MAKE) \
		$(PARALLELMFLAGS) -k sub-examples || true
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qt4.install:
	@$(call targetinfo)
	@cd $(QT4_DIR)/lib/pkgconfig && sed -i 's,prefix=/usr,prefix=$${pcfiledir}/../..,' *.pc
	@cd $(QT4_DIR) && $(QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		$(QT4_INSTALL_TARGETS) $(QT4_MAKEVARS)

###
### from ptxd_make_world_install_target:
###

	find "$(QT4_PKGDIR)" -name "*.la" -print0 | xargs -r -0 -- \
		sed -i \
		-e "/^dependency_libs/s:\( \)\(/lib\|/usr/lib\):\1$(SYSROOT)\2:g" \
		-e "/^libdir=/s:\(libdir='\)\(/lib\|/usr/lib\):\1$(SYSROOT)\2:g" && \
	check_pipe_status && \
	find "$(QT4_PKGDIR)" -name "*.pc" -print0 | \
		xargs -r -0 gawk -f "$(PTXDIST_LIB_DIR)/ptxd_make_world_install_mangle_pc.awk" && \
	check_pipe_status && \
	cp -dprf -- "$(QT4_PKGDIR)"/* "$(SYSROOT)"

#	# put a link for qmake where other packages can find it
	@ln -sf $(QT4_DIR)/bin/qmake $(PTXDIST_SYSROOT_CROSS)/bin/qmake
#	# qmake needs this to build other packages
	@echo -e "[Paths]\nPrefix=/usr\nHeaders=$(SYSROOT)/usr/include\nBinaries=$(PTXDIST_SYSROOT_HOST)/bin\nLibraries=$(SYSROOT)/usr/lib" > $(QT4_DIR)/bin/qt.conf

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

QT_VERSION_L3 := 4.5.3
QT_VERSION_L2 := 4.5
QT_VERSION_L1 := 4

$(STATEDIR)/qt4.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qt4)
	@$(call install_fixup,qt4,PACKAGE,qt4)
	@$(call install_fixup,qt4,PRIORITY,optional)
	@$(call install_fixup,qt4,VERSION,$(QT4_VERSION))
	@$(call install_fixup,qt4,SECTION,base)
	@$(call install_fixup,qt4,AUTHOR,"Juergen Beisertl <j.beisert@pengutronix.de>")
	@$(call install_fixup,qt4,DEPENDS,)
	@$(call install_fixup,qt4,DESCRIPTION,missing)

ifdef PTXCONF_QT4_SHARED
# always install QtCore
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtCore.so.$(QT_VERSION_L3), \
		/usr/lib/libQtCore.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtCore.so.$(QT_VERSION_L3), \
		/usr/lib/libQtCore.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtCore.so.$(QT_VERSION_L3), \
		/usr/lib/libQtCore.so.$(QT_VERSION_L1))
ifdef PTXCONF_QT4_BUILD_XML
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtXml.so.$(QT_VERSION_L3), \
		/usr/lib/libQtXml.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtXml.so.$(QT_VERSION_L3), \
		/usr/lib/libQtXml.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtXml.so.$(QT_VERSION_L3), \
		/usr/lib/libQtXml.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_GUI
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtGui.so.$(QT_VERSION_L3), \
		/usr/lib/libQtGui.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtGui.so.$(QT_VERSION_L3), \
		/usr/lib/libQtGui.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtGui.so.$(QT_VERSION_L3), \
		/usr/lib/libQtGui.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_SQL
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtSql.so.$(QT_VERSION_L3), \
		/usr/lib/libQtSql.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtSql.so.$(QT_VERSION_L3), \
		/usr/lib/libQtSql.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtSql.so.$(QT_VERSION_L3), \
		/usr/lib/libQtSql.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_SQLITE_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/sqldrivers/libqsqlite.$(QT4_PLUGIN_EXT), \
		/usr/plugins/sqldrivers/libqsqlite.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_BUILD_NETWORK
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtNetwork.so.$(QT_VERSION_L3), \
		/usr/lib/libQtNetwork.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtNetwork.so.$(QT_VERSION_L3), \
		/usr/lib/libQtNetwork.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtNetwork.so.$(QT_VERSION_L3), \
		/usr/lib/libQtNetwork.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_SVG
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtSvg.so.$(QT_VERSION_L3), \
		/usr/lib/libQtSvg.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtSvg.so.$(QT_VERSION_L3), \
		/usr/lib/libQtSvg.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtSvg.so.$(QT_VERSION_L3), \
		/usr/lib/libQtSvg.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_SCRIPT
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtScript.so.$(QT_VERSION_L3), \
		/usr/lib/libQtScript.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtScript.so.$(QT_VERSION_L3), \
		/usr/lib/libQtScript.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtScript.so.$(QT_VERSION_L3), \
		/usr/lib/libQtScript.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_QTESTLIB
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtTest.so.$(QT_VERSION_L3), \
		/usr/lib/libQtTest.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtTest.so.$(QT_VERSION_L3), \
		/usr/lib/libQtTest.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtTest.so.$(QT_VERSION_L3), \
		/usr/lib/libQtTest.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_ASSISTANTLIB
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtAssistantClient.so.$(QT_VERSION_L3), \
		/usr/lib/libQtAssistantClient.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtAssistantClient.so.$(QT_VERSION_L3), \
		/usr/lib/libQtAssistantClient.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtAssistantClient.so.$(QT_VERSION_L3), \
		/usr/lib/libQtAssistantClient.so.$(QT_VERSION_L1))
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtCLucene.so.$(QT_VERSION_L3), \
		/usr/lib/libQtCLucene.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtCLucene.so.$(QT_VERSION_L3), \
		/usr/lib/libQtCLucene.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtCLucene.so.$(QT_VERSION_L3), \
		/usr/lib/libQtCLucene.so.$(QT_VERSION_L1))
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtHelp.so.$(QT_VERSION_L3), \
		/usr/lib/libQtHelp.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtHelp.so.$(QT_VERSION_L3), \
		/usr/lib/libQtHelp.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtHelp.so.$(QT_VERSION_L3), \
		/usr/lib/libQtHelp.so.$(QT_VERSION_L1))
endif
ifneq ($(PTXCONF_QT4_DBUS_LOAD)$(PTXCONF_QT4_DBUS_LINK),)
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtDBus.so.$(QT_VERSION_L3), \
		/usr/lib/libQtDBus.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtDBus.so.$(QT_VERSION_L3), \
		/usr/lib/libQtDBus.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtDBus.so.$(QT_VERSION_L3), \
		/usr/lib/libQtDBus.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_DESIGNERLIBS
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtDesigner.so.$(QT_VERSION_L3), \
		/usr/lib/libQtDesigner.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtDesigner.so.$(QT_VERSION_L3), \
		/usr/lib/libQtDesigner.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtDesigner.so.$(QT_VERSION_L3), \
		/usr/lib/libQtDesigner.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_WEBKIT
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtWebKit.so.$(QT_VERSION_L3), \
		/usr/lib/libQtWebKit.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtWebKit.so.$(QT_VERSION_L3), \
		/usr/lib/libQtWebKit.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtWebKit.so.$(QT_VERSION_L3), \
		/usr/lib/libQtWebKit.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_SCRIPTTOOLS
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtScriptTools.so.$(QT_VERSION_L3), \
		/usr/lib/libQtScriptTools.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtScriptTools.so.$(QT_VERSION_L3), \
		/usr/lib/libQtScriptTools.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtScriptTools.so.$(QT_VERSION_L3), \
		/usr/lib/libQtScriptTools.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_QTXMLPATTERNS
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libQtXmlPatterns.so.$(QT_VERSION_L3), \
		/usr/lib/libQtXmlPatterns.so.$(QT_VERSION_L3))
	@$(call install_link, qt4, libQtXmlPatterns.so.$(QT_VERSION_L3), \
		/usr/lib/libQtXmlPatterns.so.$(QT_VERSION_L2))
	@$(call install_link, qt4, libQtXmlPatterns.so.$(QT_VERSION_L3), \
		/usr/lib/libQtXmlPatterns.so.$(QT_VERSION_L1))
endif
ifdef PTXCONF_QT4_BUILD_PHONON
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/libphonon.so.4.3.1, \
		/usr/lib/libphonon.so.4.3.1)
	@$(call install_link, qt4, libphonon.so.4.3.1, \
		/usr/lib/libphonon.so.4.3)
	@$(call install_link, qt4, libphonon.so.4.3.1, \
		/usr/lib/libphonon.so.4)
	@$(call install_link, qt4, libphonon.so.4.3.1, \
		/usr/lib/libphonon.so)
endif
endif #PTXCONF_QT4_SHARED
ifdef PTXCONF_QT4_GFX_LINUXFB_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/gfxdrivers/libqscreenlinuxfb.$(QT4_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqscreenlinuxfb.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_DIRECTFB_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/gfxdrivers/libqdirectfbscreen.$(QT4_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqdirectfbscreen.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_TRANSFORMED_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/gfxdrivers/libqgfxtransformed.$(QT4_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqgfxtransformed.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_VNC_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/gfxdrivers/libqgfxvnc.$(QT4_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqgfxvnc.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GFX_QVFB_PLUGIN
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/gfxdrivers/libqscreenvfb.$(QT4_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqscreenvfb.$(QT4_PLUGIN_EXT))
endif
ifneq ($(PTXCONF_QT4_DBUS_LOAD)$(PTXCONF_QT4_DBUS_LINK),)
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/script/libqtscriptdbus.$(QT4_PLUGIN_EXT), \
		/usr/plugins/script/libqtscriptdbus.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_GIF_INTERNAL
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/imageformats/libqgif.$(QT4_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqgif.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_JPG_NONE
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/imageformats/libqjpeg.$(QT4_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqjpeg.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_MNG_NONE
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/imageformats/libqmng.$(QT4_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqmng.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_TIFF_NONE
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/imageformats/libqtiff.$(QT4_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqtiff.$(QT4_PLUGIN_EXT))
endif
ifndef PTXCONF_QT4_ICO_NONE
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/imageformats/libqico.$(QT4_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqico.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_BUILD_SVG
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/imageformats/libqsvg.$(QT4_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqsvg.$(QT4_PLUGIN_EXT))
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/iconengines/libqsvgicon.$(QT4_PLUGIN_EXT), \
		/usr/plugins/iconengines/libqsvgicon.$(QT4_PLUGIN_EXT))
endif
ifdef PTXCONF_QT4_BUILD_PHONON
	@$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/plugins/phonon_backend/libphonon_gstreamer.$(QT4_PLUGIN_EXT), \
		/usr/plugins/phonon_backend/libphonon_gstreamer.$(QT4_PLUGIN_EXT))
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
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_UT
	@for i in \
		'UTBI____.pfa' \
		'UTB_____.pfa' \
		'UTI_____.pfa' \
		'UTRG____.pfa'; do \
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
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
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
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
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_COUR
	@for i in \
		cour.pfa \
		courb.pfa \
		courbi.pfa \
		couri.pfa; do \
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_CURSOR
	@for i in \
		cursor.pfa; do \
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QT4_FONT_FIXED
	@for i in \
		fixed_120_50.qpf \
		fixed_70_50.qpf; do \
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
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
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i,n); \
	done
endif

ifdef PTXCONF_QT4_FONT_JAPANESE
	@for i in \
		japanese_230_50.qpf; do \
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
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
	$(call install_copy, qt4, 0, 0, 0644, \
		$(QT4_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

	@$(call install_finish,qt4)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qt4_clean:
	rm -rf $(STATEDIR)/qt4.*
	rm -rf $(IMAGEDIR)/qt4_*
	rm -rf $(QT4_DIR)

# vim: syntax=make
