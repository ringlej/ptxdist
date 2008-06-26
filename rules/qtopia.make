# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QTOPIA) += qtopia

#
# Paths and names
#
QTOPIA_VERSION		:= 4.4.0
QTOPIA			:= qt-embedded-linux-opensource-src-$(QTOPIA_VERSION)
QTOPIA_SUFFIX		:= tar.bz2
QTOPIA_URL		:= ftp://ftp.trolltech.com/qt/source/$(QTOPIA).$(QTOPIA_SUFFIX)
QTOPIA_SOURCE		:= $(SRCDIR)/$(QTOPIA).$(QTOPIA_SUFFIX)
QTOPIA_DIR		:= $(BUILDDIR)/$(QTOPIA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

qtopia_get: $(STATEDIR)/qtopia.get

$(STATEDIR)/qtopia.get: $(qtopia_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(QTOPIA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, QTOPIA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

qtopia_extract: $(STATEDIR)/qtopia.extract

$(STATEDIR)/qtopia.extract: $(qtopia_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(QTOPIA_DIR))
	@$(call extract, QTOPIA)
	@$(call patchin, QTOPIA)
	@for file in $(QTOPIA_DIR)/mkspecs/qws/linux-ptx-g++/*.in; do \
		sed -e "s,@COMPILER_PREFIX@,$(COMPILER_PREFIX),g" \
		    -e "s,@INCDIR@,$(SYSROOT)/include $(SYSROOT)/usr/include,g" \
		    -e "s,@LIBDIR@,$(SYSROOT)/lib $(SYSROOT)/usr/lib,g" \
		    $$file > $${file%%.in}; \
	done
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

qtopia_prepare: $(STATEDIR)/qtopia.prepare

# don't use CROSS_ENV. Qt uses mkspecs for instead.
QTOPIA_ENV	:= $(CROSS_ENV_PKG_CONFIG)
QTOPIA_PATH	:= PATH=$(CROSS_PATH)
QTOPIA_MAKEVARS	:= INSTALL_ROOT=$(SYSROOT)

# With the introduction of platformconfigs PTXCONF_ARCH was 
# renamed to PTXCONF_ARCH_STRING.
ifdef PTXCONF_ARCH
QTOPIA_ARCH = $(call remove_quotes, $(PTXCONF_ARCH))
else
QTOPIA_ARCH = $(call remove_quotes, $(PTXCONF_ARCH_STRING))
endif

#
# autoconf
#
# Important: Use "-no-fast" here. Otherwise qmake will be called during
# the compile stage when the environment is not properly set!
QTOPIA_AUTOCONF := \
	-release \
	-no-fast \
	-no-largefile \
	-no-accessibility \
	-no-sql-ibase \
	-no-sql-mysql \
	-no-sql-odbc \
	-no-sql-psql \
	-no-sql-sqlite \
	-no-sql-sqlite2 \
	-no-qt3support \
	-no-mmx \
	-no-3dnow \
	-no-sse \
	-no-sse2 \
	-no-openssl \
	-no-optimized-qmake \
	-no-nis \
	-no-cups \
	-no-iconv \
	-pch \
	-force-pkg-config \
	-embedded $(QTOPIA_ARCH) \
	-no-glib \
	-qt-decoration-styled \
	-depths 8,16 \
	-prefix /usr \
	-no-armfpa \
	-xplatform qws/linux-ptx-g++ \
	-make libs \
	-make tools

# maybe later:
#
# -iwmmxt

ifdef PTXCONF_QTOPIA_PREPARE_EXAMPLES
QTOPIA_AUTOCONF += -make examples -make demos
else
QTOPIA_AUTOCONF += -nomake examples -nomake demos
endif


# ahi graphics driver
ifdef PTXCONF_QTOPIA_GFX_AHI_PLUGIN
QTOPIA_AUTOCONF += -plugin-gfx-ahi
endif

# directfb graphics driver
ifdef PTXCONF_QTOPIA_GFX_DIRECTFB_PLUGIN
QTOPIA_AUTOCONF += -plugin-gfx-directfb
endif

# linuxfb graphics driver
ifdef PTXCONF_QTOPIA_GFX_LINUXFB_NONE
QTOPIA_AUTOCONF += -no-gfx-linuxfb
endif
ifdef PTXCONF_QTOPIA_GFX_LINUXFB_BUILTIN
QTOPIA_AUTOCONF += -qt-gfx-linuxfb
endif
ifdef PTXCONF_QTOPIA_GFX_LINUXFB_PLUGIN
QTOPIA_AUTOCONF += -plugin-gfx-linuxfb
endif

# svga graphics driver
ifdef PTXCONF_QTOPIA_GFX_SVGA_PLUGIN
QTOPIA_AUTOCONF += -plugin-gfx-svgalib
endif

# transformed graphics driver
ifdef PTXCONF_QTOPIA_GFX_TRANSFORMED_NONE
QTOPIA_AUTOCONF += -no-gfx-transformed
endif
ifdef PTXCONF_QTOPIA_GFX_TRANSFORMED_BUILTIN
QTOPIA_AUTOCONF += -qt-gfx-transformed
endif
ifdef PTXCONF_QTOPIA_GFX_TRANSFORMED_PLUGIN
QTOPIA_AUTOCONF += -plugin-gfx-transformed
endif

# qvfb graphics driver
ifdef PTXCONF_QTOPIA_GFX_QVFB_NONE
QTOPIA_AUTOCONF += -no-gfx-qvfb
endif
ifdef PTXCONF_QTOPIA_GFX_QVFB_BUILTIN
QTOPIA_AUTOCONF += -qt-gfx-qvfb
endif
ifdef PTXCONF_QTOPIA_GFX_QVFB_PLUGIN
QTOPIA_AUTOCONF += -plugin-gfx-qvfb
endif

# vnc graphics driver
ifdef PTXCONF_QTOPIA_GFX_VNC_NONE
QTOPIA_AUTOCONF += -no-gfx-vnc
endif
ifdef PTXCONF_QTOPIA_GFX_VNC_BUILTIN
QTOPIA_AUTOCONF += -qt-gfx-vnc
endif
ifdef PTXCONF_QTOPIA_GFX_VNC_PLUGIN
QTOPIA_AUTOCONF += -plugin-gfx-vnc
endif

# multiscreen graphics driver
ifdef PTXCONF_QTOPIA_GFX_MULTISCREEN_NONE
QTOPIA_AUTOCONF += -no-gfx-multiscreen
endif
ifdef PTXCONF_QTOPIA_GFX_MULTISCREEN_BUILTIN
QTOPIA_AUTOCONF += -qt-gfx-multiscreen
endif

# hybrid graphics driver
ifdef PTXCONF_QTOPIA_GFX_HYBRID_PLUGIN
QTOPIA_AUTOCONF += -plugin-gfx-hybrid
endif


# tty keyboard driver
ifdef PTXCONF_QTOPIA_KBD_TTY
QTOPIA_AUTOCONF += -qt-kbd-tty
else
QTOPIA_AUTOCONF += -no-kbd-tty
endif

# usb keyboard driver
ifdef PTXCONF_QTOPIA_KBD_USB
QTOPIA_AUTOCONF += -qt-kbd-usb
else
QTOPIA_AUTOCONF += -no-kbd-usb
endif

# sl5000 keyboard driver
ifdef PTXCONF_QTOPIA_KBD_SL5000
QTOPIA_AUTOCONF += -qt-kbd-sl5000
else
QTOPIA_AUTOCONF += -no-kbd-sl5000
endif

# yopy keyboard driver
ifdef PTXCONF_QTOPIA_KBD_YOPY
QTOPIA_AUTOCONF += -qt-kbd-yopy
else
QTOPIA_AUTOCONF += -no-kbd-yopy
endif

# vr41xx keyboard driver
ifdef PTXCONF_QTOPIA_KBD_VR41XX
QTOPIA_AUTOCONF += -qt-kbd-vr41xx
else
QTOPIA_AUTOCONF += -no-kbd-vr41xx
endif

# qvfb keyboard driver
ifdef PTXCONF_QTOPIA_KBD_QVFB
QTOPIA_AUTOCONF += -qt-kbd-qvfb
else
QTOPIA_AUTOCONF += -no-kbd-qvfb
endif


# pc mouse driver
ifdef PTXCONF_QTOPIA_MOUSE_PC
QTOPIA_AUTOCONF += -qt-mouse-pc
else
QTOPIA_AUTOCONF += -no-mouse-pc
endif

# bus mouse driver
ifdef PTXCONF_QTOPIA_MOUSE_BUS
QTOPIA_AUTOCONF += -qt-mouse-bus
else
QTOPIA_AUTOCONF += -no-mouse-bus
endif

# linuxtp mouse driver
ifdef PTXCONF_QTOPIA_MOUSE_LINUXTP
QTOPIA_AUTOCONF += -qt-mouse-linuxtp
else
QTOPIA_AUTOCONF += -no-mouse-linuxtp
endif

# yopy mouse driver
ifdef PTXCONF_QTOPIA_MOUSE_YOPY
QTOPIA_AUTOCONF += -qt-mouse-yopy
else
QTOPIA_AUTOCONF += -no-mouse-yopy
endif

# vr41xx mouse driver
ifdef PTXCONF_QTOPIA_MOUSE_VR41XX
QTOPIA_AUTOCONF += -qt-mouse-vr41xx
else
QTOPIA_AUTOCONF += -no-mouse-vr41xx
endif

# tslib mouse driver
ifdef PTXCONF_QTOPIA_MOUSE_TSLIB
QTOPIA_AUTOCONF += -qt-mouse-tslib
else
QTOPIA_AUTOCONF += -no-mouse-tslib
endif

# qvfb mouse driver
ifdef PTXCONF_QTOPIA_MOUSE_QVFB
QTOPIA_AUTOCONF += -qt-mouse-qvfb
else
QTOPIA_AUTOCONF += -no-mouse-qvfb
endif


# PNG support
ifdef PTXCONF_QTOPIA_PNG_NONE
QTOPIA_AUTOCONF += -no-libpng
endif
ifdef PTXCONF_QTOPIA_PNG_INTERNAL
QTOPIA_AUTOCONF += -qt-libpng
endif
ifdef PTXCONF_QTOPIA_PNG_SYSTEM
QTOPIA_AUTOCONF += -system-libpng
endif

# MNG support
ifdef PTXCONF_QTOPIA_MNG_NONE
QTOPIA_AUTOCONF += -no-libmng
endif
ifdef PTXCONF_QTOPIA_MNG_INTERNAL
QTOPIA_AUTOCONF += -qt-libmng
endif
ifdef PTXCONF_QTOPIA_MNG_SYSTEM
QTOPIA_AUTOCONF += -system-libmng
endif

# TIFF support
ifdef PTXCONF_QTOPIA_TIFF_NONE
QTOPIA_AUTOCONF += -no-libtiff
endif
ifdef PTXCONF_QTOPIA_TIFF_INTERNAL
QTOPIA_AUTOCONF += -qt-libtiff
endif
ifdef PTXCONF_QTOPIA_TIFF_SYSTEM
QTOPIA_AUTOCONF += -system-libtiff
endif

# GIF support
ifdef PTXCONF_QTOPIA_GIF_NONE
QTOPIA_AUTOCONF += -no-gif
endif
ifdef PTXCONF_QTOPIA_GIF_INTERNAL
QTOPIA_AUTOCONF += -qt-gif
endif

# JPG support
ifdef PTXCONF_QTOPIA_JPG_NONE
QTOPIA_AUTOCONF += -no-libjpeg
endif
ifdef PTXCONF_QTOPIA_JPG_INTERNAL
QTOPIA_AUTOCONF += -qt-libjpeg
endif
ifdef PTXCONF_QTOPIA_JPG_SYSTEM
QTOPIA_AUTOCONF += -system-libjpeg
endif

ifdef PTXCONF_QTOPIA_ZLIB_INTERNAL
QTOPIA_AUTOCONF += -qt-zlib
endif
ifdef PTXCONF_QTOPIA_ZLIB_SYSTEM
QTOPIA_AUTOCONF += -system-zlib
endif

ifdef PTXCONF_QTOPIA_FREETYPE_NONE
QTOPIA_AUTOCONF += -no-freetype
endif
ifdef PTXCONF_QTOPIA_FREETYPE_INTERNAL
QTOPIA_AUTOCONF += -qt-freetype
endif
ifdef PTXCONF_QTOPIA_FREETYPE_SYSTEM
QTOPIA_AUTOCONF += -system-freetype -I$(SYSROOT)/usr/include/freetype2
endif

ifdef PTXCONF_ENDIAN_LITTLE
QTOPIA_AUTOCONF += -little-endian
else
QTOPIA_AUTOCONF += -big-endian
endif

ifdef PTXCONF_QTOPIA_STL
QTOPIA_AUTOCONF	+= -stl
else
QTOPIA_AUTOCONF	+= -no-stl
endif

ifdef PTXCONF_QTOPIA_DBUS_LOAD
QTOPIA_AUTOCONF += -dbus
QTOPIA_BUILD_TOOLS_TARGETS += sub-tools-qdbus
QTOPIA_INSTALL_TARGETS += sub-tools-qdbus-install_subtargets
endif
ifdef PTXCONF_QTOPIA_DBUS_LINK
QTOPIA_AUTOCONF += -dbus-linked
QTOPIA_BUILD_TOOLS_TARGETS += sub-tools-qdbus
QTOPIA_INSTALL_TARGETS += sub-tools-qdbus-install_subtargets
endif
ifdef PTXCONF_QTOPIA_DBUS_NONE
QTOPIA_AUTOCONF += -no-qdbus
endif

ifdef PTXCONF_QTOPIA_SHARED
QTOPIA_AUTOCONF += -shared
QTOPIA_PLUGIN_EXT := so
else
QTOPIA_AUTOCONF += -static
QTOPIA_PLUGIN_EXT := a
endif

ifdef PTXCONF_QTOPIA_BUILD_QTXMLPATTERNS
QTOPIA_AUTOCONF += -xmlpatterns -exceptions
QTOPIA_BUILD_TARGETS += sub-xmlpatterns
QTOPIA_INSTALL_TARGETS += sub-xmlpatterns-install_subtargets
else
QTOPIA_AUTOCONF += -no-xmlpatterns -no-exceptions
endif
ifdef PTXCONF_QTOPIA_BUILD_PHONON
QTOPIA_AUTOCONF += -phonon
else
QTOPIA_AUTOCONF += -no-phonon
endif
ifdef PTXCONF_QTOPIA_BUILD_WEBKIT
QTOPIA_AUTOCONF += -webkit
QTOPIA_BUILD_TARGETS += sub-webkit
QTOPIA_INSTALL_TARGETS += sub-webkit-install_subtargets
else
QTOPIA_AUTOCONF += -no-webkit
endif

ifdef PTXCONF_QTOPIA_BUILD_DESIGNERLIBS
QTOPIA_BUILD_TOOLS_TARGETS += \
	sub-tools-designer-src-uitools \
	sub-tools-designer-src-lib
QTOPIA_INSTALL_TARGETS += \
	sub-tools-designer-src-uitools-install_subtargets \
	sub-tools-designer-src-lib-install_subtargets
endif

ifdef PTXCONF_QTOPIA_BUILD_ASSISTANTLIB
QTOPIA_BUILD_TOOLS_TARGETS += sub-tools-assistant
QTOPIA_INSTALL_TARGETS += sub-tools-assistant-install_subtargets
endif

$(STATEDIR)/qtopia.prepare: $(qtopia_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(QTOPIA_DIR)/config.cache)
	cd $(QTOPIA_DIR) && \
		echo "yes" | $(QTOPIA_PATH) $(QTOPIA_ENV) \
		./configure $(QTOPIA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

### These are always built
# moc
QTOPIA_BUILD_TARGETS += sub-moc
QTOPIA_INSTALL_TARGETS += sub-moc-install_subtargets
# rcc
QTOPIA_BUILD_TARGETS += sub-rcc
QTOPIA_INSTALL_TARGETS += sub-rcc-install_subtargets
# QtCore
QTOPIA_BUILD_TARGETS += sub-corelib
QTOPIA_INSTALL_TARGETS += sub-corelib-install_subtargets
# plugins (any selected plugins, gfx, image, mouse...)
QTOPIA_BUILD_TARGETS += sub-plugins
QTOPIA_INSTALL_TARGETS += sub-plugins-install_subtargets

ifdef PTXCONF_QTOPIA_BUILD_UIC
QTOPIA_BUILD_TARGETS += sub-uic
QTOPIA_INSTALL_TARGETS += sub-uic-install_subtargets
endif
ifdef PTXCONF_QTOPIA_BUILD_XML
QTOPIA_BUILD_TARGETS += sub-xml
QTOPIA_INSTALL_TARGETS += sub-xml-install_subtargets
endif
ifdef PTXCONF_QTOPIA_BUILD_GUI
QTOPIA_BUILD_TARGETS += sub-gui
QTOPIA_INSTALL_TARGETS += sub-gui-install_subtargets
endif
ifdef PTXCONF_QTOPIA_BUILD_SQL
QTOPIA_BUILD_TARGETS += sub-sql
QTOPIA_INSTALL_TARGETS += sub-sql-install_subtargets
endif
ifdef PTXCONF_QTOPIA_BUILD_NETWORK
QTOPIA_BUILD_TARGETS += sub-network
QTOPIA_INSTALL_TARGETS += sub-network-install_subtargets
endif
ifdef PTXCONF_QTOPIA_BUILD_SVG
QTOPIA_BUILD_TARGETS += sub-svg
QTOPIA_INSTALL_TARGETS += sub-svg-install_subtargets
endif
ifdef PTXCONF_QTOPIA_BUILD_SCRIPT
QTOPIA_BUILD_TARGETS += sub-script
QTOPIA_INSTALL_TARGETS += sub-script-install_subtargets
endif
ifdef PTXCONF_QTOPIA_BUILD_QTESTLIB
QTOPIA_BUILD_TARGETS += sub-testlib
QTOPIA_INSTALL_TARGETS += sub-testlib-install_subtargets
endif

qtopia_compile: $(STATEDIR)/qtopia.compile

$(STATEDIR)/qtopia.compile: $(qtopia_compile_deps_default)
	@$(call targetinfo, $@)
ifneq ($(strip $(QTOPIA_BUILD_TARGETS)), )
	cd $(QTOPIA_DIR) && $(QTOPIA_PATH) $(QTOPIA_ENV) $(MAKE) \
		$(PARALLELMFLAGS) $(QTOPIA_BUILD_TARGETS)
endif
# These targets don't have the correct dependencies.
# We have to build them later
	echo $(QTOPIA_BUILD_TOOLS_TARGETS)
ifneq ($(strip $(QTOPIA_BUILD_TOOLS_TARGETS)), )
	cd $(QTOPIA_DIR) && $(QTOPIA_PATH) $(QTOPIA_ENV) $(MAKE) \
		$(PARALLELMFLAGS) $(QTOPIA_BUILD_TOOLS_TARGETS)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

qtopia_install: $(STATEDIR)/qtopia.install

$(STATEDIR)/qtopia.install: $(qtopia_install_deps_default)
	@$(call targetinfo, $@)
	@cd $(QTOPIA_DIR) && $(QTOPIA_PATH) $(MAKE) \
		$(QTOPIA_INSTALL_TARGETS) $(QTOPIA_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

qtopia_targetinstall: $(STATEDIR)/qtopia.targetinstall

$(STATEDIR)/qtopia.targetinstall: $(qtopia_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, qtopia)
	@$(call install_fixup,qtopia,PACKAGE,qtopia)
	@$(call install_fixup,qtopia,PRIORITY,optional)
	@$(call install_fixup,qtopia,VERSION,$(QTOPIA_VERSION))
	@$(call install_fixup,qtopia,SECTION,base)
	@$(call install_fixup,qtopia,AUTHOR,"Juergen Beisertl <j.beisert\@pengutronix.de>")
	@$(call install_fixup,qtopia,DEPENDS,)
	@$(call install_fixup,qtopia,DESCRIPTION,missing)

ifdef PTXCONF_QTOPIA_SHARED
# always install QtCore
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtCore.so.4.4.0, \
		/usr/lib/libQtCore.so.4.4.0)
	@$(call install_link, qtopia, libQtCore.so.4.4.0, \
		/usr/lib/libQtCore.so.4.4)
	@$(call install_link, qtopia, libQtCore.so.4.4.0, \
		/usr/lib/libQtCore.so.4)
ifdef PTXCONF_QTOPIA_BUILD_XML
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtXml.so.4.4.0, \
		/usr/lib/libQtXml.so.4.4.0)
	@$(call install_link, qtopia, libQtXml.so.4.4.0, \
		/usr/lib/libQtXml.so.4.4)
	@$(call install_link, qtopia, libQtXml.so.4.4.0, \
		/usr/lib/libQtXml.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_GUI
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtGui.so.4.4.0, \
		/usr/lib/libQtGui.so.4.4.0)
	@$(call install_link, qtopia, libQtGui.so.4.4.0, \
		/usr/lib/libQtGui.so.4.4)
	@$(call install_link, qtopia, libQtGui.so.4.4.0, \
		/usr/lib/libQtGui.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_SQL
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtSql.so.4.4.0, \
		/usr/lib/libQtSql.so.4.4.0)
	@$(call install_link, qtopia, libQtSql.so.4.4.0, \
		/usr/lib/libQtSql.so.4.4)
	@$(call install_link, qtopia, libQtSql.so.4.4.0, \
		/usr/lib/libQtSql.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_NETWORK
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtNetwork.so.4.4.0, \
		/usr/lib/libQtNetwork.so.4.4.0)
	@$(call install_link, qtopia, libQtNetwork.so.4.4.0, \
		/usr/lib/libQtNetwork.so.4.4)
	@$(call install_link, qtopia, libQtNetwork.so.4.4.0, \
		/usr/lib/libQtNetwork.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_SVG
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtSvg.so.4.4.0, \
		/usr/lib/libQtSvg.so.4.4.0)
	@$(call install_link, qtopia, libQtSvg.so.4.4.0, \
		/usr/lib/libQtSvg.so.4.4)
	@$(call install_link, qtopia, libQtSvg.so.4.4.0, \
		/usr/lib/libQtSvg.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_SCRIPT
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtScript.so.4.4.0, \
		/usr/lib/libQtScript.so.4.4.0)
	@$(call install_link, qtopia, libQtScript.so.4.4.0, \
		/usr/lib/libQtScript.so.4.4)
	@$(call install_link, qtopia, libQtScript.so.4.4.0, \
		/usr/lib/libQtScript.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_QTESTLIB
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtTest.so.4.4.0, \
		/usr/lib/libQtTest.so.4.4.0)
	@$(call install_link, qtopia, libQtTest.so.4.4.0, \
		/usr/lib/libQtTest.so.4.4)
	@$(call install_link, qtopia, libQtTest.so.4.4.0, \
		/usr/lib/libQtTest.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_ASSISTANTLIB
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtAssistantClient.so.4.4.0, \
		/usr/lib/libQtAssistantClient.so.4.4.0)
	@$(call install_link, qtopia, libQtAssistantClient.so.4.4.0, \
		/usr/lib/libQtAssistantClient.so.4.4)
	@$(call install_link, qtopia, libQtAssistantClient.so.4.4.0, \
		/usr/lib/libQtAssistantClient.so.4)
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtCLucene.so.4.4.0, \
		/usr/lib/libQtCLucene.so.4.4.0)
	@$(call install_link, qtopia, libQtCLucene.so.4.4.0, \
		/usr/lib/libQtCLucene.so.4.4)
	@$(call install_link, qtopia, libQtCLucene.so.4.4.0, \
		/usr/lib/libQtCLucene.so.4)
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtHelp.so.4.4.0, \
		/usr/lib/libQtHelp.so.4.4.0)
	@$(call install_link, qtopia, libQtHelp.so.4.4.0, \
		/usr/lib/libQtHelp.so.4.4)
	@$(call install_link, qtopia, libQtHelp.so.4.4.0, \
		/usr/lib/libQtHelp.so.4)
endif
ifdef PTXCONF_QTOPIA_DBUS_LOAD
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtDBus.so.4.4.0, \
		/usr/lib/libQtDBus.so.4.4.0)
	@$(call install_link, qtopia, libQtDBus.so.4.4.0, \
		/usr/lib/libQtDBus.so.4.4)
	@$(call install_link, qtopia, libQtDBus.so.4.4.0, \
		/usr/lib/libQtDBus.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_DESIGNERLIBS
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtDesigner.so.4.4.0, \
		/usr/lib/libQtDesigner.so.4.4.0)
	@$(call install_link, qtopia, libQtDesigner.so.4.4.0, \
		/usr/lib/libQtDesigner.so.4.4)
	@$(call install_link, qtopia, libQtDesigner.so.4.4.0, \
		/usr/lib/libQtDesigner.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_WEBKIT
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtWebKit.so.4.4.0, \
		/usr/lib/libQtWebKit.so.4.4.0)
	@$(call install_link, qtopia, libQtWebKit.so.4.4.0, \
		/usr/lib/libQtWebKit.so.4.4)
	@$(call install_link, qtopia, libQtWebKit.so.4.4.0, \
		/usr/lib/libQtWebKit.so.4)
endif
ifdef PTXCONF_QTOPIA_BUILD_QTXMLPATTERNS
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/libQtXmlPatterns.so.4.4.0, \
		/usr/lib/libQtXmlPatterns.so.4.4.0)
	@$(call install_link, qtopia, libQtXmlPatterns.so.4.4.0, \
		/usr/lib/libQtXmlPatterns.so.4.4)
	@$(call install_link, qtopia, libQtXmlPatterns.so.4.4.0, \
		/usr/lib/libQtXmlPatterns.so.4)
endif
endif #PTXCONF_QTOPIA_SHARED
ifdef PTXCONF_QTOPIA_GFX_LINUXFB_PLUGIN
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/gfxdrivers/libqscreenlinuxfb.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqscreenlinuxfb.$(QTOPIA_PLUGIN_EXT))
endif
ifdef PTXCONF_QTOPIA_GFX_DIRECTFB_PLUGIN
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/gfxdrivers/libqdirectfbscreen.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqdirectfbscreen.$(QTOPIA_PLUGIN_EXT))
endif
ifdef PTXCONF_QTOPIA_GFX_TRANSFORMED_PLUGIN
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/gfxdrivers/libqgfxtransformed.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqgfxtransformed.$(QTOPIA_PLUGIN_EXT))
endif
ifdef PTXCONF_QTOPIA_GFX_VNC_PLUGIN
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/gfxdrivers/libqgfxvnc.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqgfxvnc.$(QTOPIA_PLUGIN_EXT))
endif
ifdef PTXCONF_QTOPIA_GFX_QVFB_PLUGIN
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/gfxdrivers/libqscreenvfb.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/gfxdrivers/libqscreenvfb.$(QTOPIA_PLUGIN_EXT))
endif
ifdef PTXCONF_QTOPIA_DBUS_LOAD
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/script/libqtscriptdbus.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/script/libqtscriptdbus.$(QTOPIA_PLUGIN_EXT))
endif
ifdef PTXCONF_QTOPIA_GIF_INTERNAL
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/imageformats/libqgif.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqgif.$(QTOPIA_PLUGIN_EXT))
endif
ifndef PTXCONF_QTOPIA_JPG_NONE
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/imageformats/libqjpeg.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqjpeg.$(QTOPIA_PLUGIN_EXT))
endif
ifndef PTXCONF_QTOPIA_MNG_NONE
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/imageformats/libqmng.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqmng.$(QTOPIA_PLUGIN_EXT))
endif
ifndef PTXCONF_QTOPIA_TIFF_NONE
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/imageformats/libqtiff.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqtiff.$(QTOPIA_PLUGIN_EXT))
endif
ifndef PTXCONF_QTOPIA_ICO_NONE
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/imageformats/libqico.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqico.$(QTOPIA_PLUGIN_EXT))
endif
ifdef PTXCONF_QTOPIA_BUILD_SVG
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/imageformats/libqsvg.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/imageformats/libqsvg.$(QTOPIA_PLUGIN_EXT))
	@$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/plugins/iconengines/libqsvgicon.$(QTOPIA_PLUGIN_EXT), \
		/usr/plugins/iconengines/libqsvgicon.$(QTOPIA_PLUGIN_EXT))
endif

ifdef PTXCONF_QTOPIA_FONT_DEJAVU
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
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_UT
	@for i in \
		'UTBI____.pfa' \
		'UTB_____.pfa' \
		'UTI_____.pfa' \
		'UTRG____.pfa'; do \
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_VERA
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
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_C0
	@for i in \
		c0419bt_.pfb \
		c0582bt_.pfb \
		c0583bt_.pfb \
		c0611bt_.pfb \
		c0632bt_.pfb \
		c0633bt_.pfb \
		c0648bt_.pfb \
		c0649bt_.pfb; do \
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_COUR
	@for i in \
		cour.pfa \
		courb.pfa \
		courbi.pfa \
		couri.pfa; do \
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_CURSOR
	@for i in \
		cursor.pfa; do \
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_FIXED
	@for i in \
		fixed_120_50.qpf \
		fixed_70_50.qpf; do \
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_HELVETICA
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
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i,n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_JAPANESE
	@for i in \
		japanese_230_50.qpf; do \
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

ifdef PTXCONF_QTOPIA_FONT_L04
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
	$(call install_copy, qtopia, 0, 0, 0644, \
		$(QTOPIA_DIR)/lib/fonts/$$i, \
		/usr/lib/fonts/$$i, n); \
	done
endif

	@$(call install_finish,qtopia)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qtopia_clean:
	rm -rf $(STATEDIR)/qtopia.*
	rm -rf $(IMAGEDIR)/qtopia_*
	rm -rf $(QTOPIA_DIR)

# vim: syntax=make
