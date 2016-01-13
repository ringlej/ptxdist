# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QT5) += qt5

#
# Paths and names
#
QT5_VERSION	:= 5.4.2
QT5_MD5		:= c23bd0f14d66e7901d24906a1edce9b0
QT5		:= qt-everywhere-opensource-src-$(QT5_VERSION)
QT5_SUFFIX	:= tar.xz
QT5_URL		:= \
	http://download.qt-project.org/official_releases/qt/$(basename $(QT5_VERSION))/$(QT5_VERSION)/single/$(QT5).$(QT5_SUFFIX) \
	http://download.qt-project.org/development_releases/qt/$(basename $(QT5_VERSION))/$(shell echo $(QT5_VERSION) | tr 'A-Z' 'a-z')/single/$(QT5).$(QT5_SUFFIX)
QT5_SOURCE	:= $(SRCDIR)/$(QT5).$(QT5_SUFFIX)
QT5_DIR		:= $(BUILDDIR)/$(QT5)
QT5_BUILD_OOT	:= YES
QT5_LICENSE	:= LGPL-2.1, Nokia-Qt-exception-1.1, LGPL-3.0, GFDL-1.3
QT5_LICENSE_FILES := \
	file://LICENSE.LGPLv21;md5=cff17b12416c896e10ae2c17a64252e7 \
	file://LGPL_EXCEPTION.txt;md5=0145c4d1b6f96a661c2c139dfb268fb6 \
	file://LICENSE.LGPLv3;md5=c1939be5579666be947371bc8120425f \
	file://LICENSE.FDL;md5=6d9f2a9af4c8b8c3c769f6cc1b6aaf7e
QT5_MKSPECS	:= $(shell ptxd_get_alternative config/qt5 linux-ptx-g++ && echo $$ptxd_reply)

ifdef PTXCONF_QT5
ifeq ($(strip $(QT5_MKSPECS)),)
$(error Qt5 mkspecs are missing)
endif
endif

# broken on PPC
ifdef PTXCONF_ARCH_PPC
PTXCONF_QT5_MODULE_QTCONNECTIVITY :=
PTXCONF_QT5_MODULE_QTCONNECTIVITY_QUICK :=
PTXCONF_QT5_MODULE_QTQUICK1 :=
PTXCONF_QT5_MODULE_QTQUICK1_DEBUG :=
PTXCONF_QT5_MODULE_QTQUICK1_WEBKIT :=
PTXCONF_QT5_MODULE_QTSCRIPT :=
PTXCONF_QT5_MODULE_QTSCRIPT_WIDGETS :=
PTXCONF_QT5_MODULE_QTWEBENGINE :=
PTXCONF_QT5_MODULE_QTWEBENGINE_WIDGETS :=
PTXCONF_QT5_MODULE_QTWEBKIT :=
PTXCONF_QT5_MODULE_QTWEBKIT_EXAMPLES :=
PTXCONF_QT5_MODULE_QTWEBKIT_QUICK :=
PTXCONF_QT5_MODULE_QTWEBKIT_WIDGETS :=
endif
# QtWebEngine needs at least ARMv6
ifdef PTXCONF_ARCH_ARM
ifndef PTXCONF_ARCH_ARM_V6
PTXCONF_QT5_MODULE_QTWEBENGINE :=
PTXCONF_QT5_MODULE_QTWEBENGINE_WIDGETS :=
endif
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# the extra section seems to confuse the Webkit JIT code
QT5_WRAPPER_BLACKLIST := \
	TARGET_COMPILER_RECORD_SWITCHES

# target options are provided via mkspecs
QT5_CONF_ENV	:= \
	$(CROSS_ENV_PKG_CONFIG) \
	MAKEFLAGS="$(PARALLELMFLAGS)" \
	COMPILER_PREFIX=$(COMPILER_PREFIX)

define ptx/qt5-system
$(call ptx/ifdef, PTXCONF_$(strip $(1)),-system,-no)
endef

define ptx/qt5-module
$(call ptx/ifdef, PTXCONF_QT5_MODULE_$(strip $(1)),,-skip $(2))
endef

#
# autoconf
#
QT5_CONF_TOOL	:= autoconf

#
# Note: autoconf style options are not shown in '--help' but they can be used
# This also avoid the problem where e.g. '-largefile' also matches '-l<library>'
#
QT5_CONF_OPT	:= \
	$(if $(filter 1,$(PTXDIST_VERBOSE)),-v) \
	$(if $(filter 0,$(PTXDIST_VERBOSE)),-silent) \
	-prefix /usr \
	-headerdir /usr/include/qt5 \
	-archdatadir /usr/lib/qt5 \
	-datadir /usr/share/qt5 \
	-examplesdir /usr/lib/qt5/examples \
	-hostbindir /usr/bin/qt5 \
	-release \
	-opensource \
	-confirm-license \
	--$(call ptx/endis, PTXCONF_QT5_CXX11)-c++11 \
	--enable-shared \
	--$(call ptx/endis, PTXCONF_GLOBAL_LARGE_FILE)-largefile \
	--$(call ptx/endis, PTXCONF_QT5_ACCESSIBILITY)-accessibility \
	--disable-sql-db2 \
	--disable-sql-ibase \
	--disable-sql-mysql \
	--disable-sql-oci \
	--disable-sql-odbc \
	--disable-sql-psql \
	--disable-sql-sqlite2 \
	--disable-sql-tds \
	--$(call ptx/endis, PTXCONF_QT5_MODULE_QTBASE_SQL_SQLITE)-sql-sqlite \
	-system-sqlite \
	--$(call ptx/endis, PTXCONF_QT5_MODULE_QTDECLARATIVE_DEBUG)-qml-debug \
	-pkg-config \
	-force-pkg-config \
	\
	-system-zlib \
	--disable-journald \
	$(call ptx/ifdef, PTXCONF_QT5_GIF,,-no-gif) \
	$(call ptx/qt5-system, QT5_LIBPNG)-libpng \
	$(call ptx/qt5-system, QT5_LIBJPEG)-libjpeg \
	$(call ptx/qt5-system, QT5_GUI)-freetype \
	-qt-harfbuzz \
	--$(call ptx/endis, PTXCONF_QT5_OPENSSL)-openssl \
	-qt-pcre \
	-system-xcb \
	\
	-make libs \
	-make tools \
	$(call ptx/ifdef, PTXCONF_QT5_PREPARE_EXAMPLES,-make examples) \
	-skip qtactiveqt \
	-skip qtandroidextras \
	$(call ptx/qt5-module, QTCONNECTIVITY, qtconnectivity) \
	$(call ptx/qt5-module, QTDECLARATIVE, qtdeclarative) \
	$(call ptx/qt5-module, QTENGINIO, qtenginio) \
	-skip qtdoc \
	$(call ptx/qt5-module, QTGRAPHICALEFFECTS, qtgraphicaleffects) \
	$(call ptx/qt5-module, QTIMAGEFORMATS, qtimageformats) \
	$(call ptx/qt5-module, QTLOCATION, qtlocation) \
	-skip qtmacextras \
	$(call ptx/qt5-module, QTMULTIMEDIA, qtmultimedia) \
	$(call ptx/qt5-module, QTQUICK1, qtquick1) \
	$(call ptx/qt5-module, QTQUICKCONTROLS, qtquickcontrols) \
	$(call ptx/qt5-module, QTSCRIPT, qtscript) \
	$(call ptx/qt5-module, QTSENSORS, qtsensors) \
	$(call ptx/qt5-module, QTSERIALPORT, qtserialport) \
	$(call ptx/qt5-module, QTSVG, qtsvg) \
	$(call ptx/qt5-module, QTTOOLS, qttools) \
	$(call ptx/qt5-module, QTTRANSLATIONS, qttranslations) \
	$(call ptx/qt5-module, QTWAYLAND, qtwayland) \
	$(call ptx/qt5-module, QTWEBCHANNEL, qtwebchannel) \
	$(call ptx/qt5-module, QTWEBENGINE, qtwebengine) \
	$(call ptx/qt5-module, QTWEBKIT, qtwebkit) \
	$(call ptx/qt5-module, QTWEBKIT_EXAMPLES, qtwebkit-examples) \
	$(call ptx/qt5-module, QTWEBSOCKETS, qtwebsockets) \
	-skip qtwinextras \
	$(call ptx/qt5-module, QTX11EXTRAS, qtx11extras) \
	$(call ptx/qt5-module, QTXMLPATTERNS, qtxmlpatterns) \
	--$(call ptx/endis, PTXCONF_QT5_PREPARE_EXAMPLES)-compile-examples \
	--$(call ptx/endis, PTXCONF_QT5_GUI)-gui \
	--$(call ptx/endis, PTXCONF_QT5_WIDGETS)-widgets \
	--disable-rpath \
	--disable-optimized-qmake \
	--disable-nis \
	--disable-cups \
	--$(call ptx/endis, PTXCONF_ICONV)-iconv \
	--$(call ptx/endis, PTXCONF_QT5_ICU)-icu \
	--$(call ptx/endis, PTXCONF_QT5_GUI)-fontconfig \
	--disable-strip \
	--disable-pch \
	--$(call ptx/endis, PTXCONF_QT5_DBUS)-dbus$(call ptx/ifdef, PTXCONF_QT5_DBUS,-linked,) \
	--disable-separate-debug-info \
	--$(call ptx/endis, PTXCONF_QT5_PLATFORM_XCB)-xcb \
	--$(call ptx/endis, PTXCONF_QT5_PLATFORM_EGLFS)-eglfs \
	--$(call ptx/endis, PTXCONF_QT5_PLATFORM_DIRECTFB)-directfb \
	--$(call ptx/endis, PTXCONF_QT5_PLATFORM_LINUXFB)-linuxfb \
	--$(call ptx/endis, PTXCONF_QT5_PLATFORM_KMS)-kms \
	$(call ptx/ifdef, PTXCONF_QT5_GUI,-qpa $(PTXCONF_QT5_PLATFORM_DEFAULT)) \
	-xplatform linux-ptx-g++ \
	--opengl=$(call ptx/ifdef, PTXCONF_QT5_OPENGL,$(PTXCONF_QT5_OPENGL_API),no) \
	--disable-system-proxies \
	--$(call ptx/endis, PTXCONF_QT5_GLIB)-glib \
	--no-android-style-assets

ifdef PTXCONF_QT5_GUI
ifndef PTXCONF_QT5_PLATFORM_DEFAULT
$(error Qt5: select at least one GUI platform!)
endif
endif

# Note: these options are not listed in '--help' but they exist
QT5_CONF_OPT += \
	--disable-sm \
	--disable-openvg \
	--$(call ptx/endis, PTXCONF_QT5_GUI)-libudev \
	--$(call ptx/endis, PTXCONF_QT5_OPENGL)-egl \
	--$(call ptx/endis, PTXCONF_QT5_PLATFORM_XCB)-xkb \
	$(call ptx/qt5-system, QT5_PLATFORM_XCB)-xkbcommon \
	--$(call ptx/endis, PTXCONF_QT5_XI)-xinput2 \
	--$(call ptx/endis, PTXCONF_QT5_XRENDER)-xrender \
	--$(call ptx/endis, PTXCONF_QT5_XV)-xvideo \
	--$(call ptx/endis, PTXCONF_QT5_INPUT_EVDEV)-evdev \
	--$(call ptx/endis, PTXCONF_QT5_INPUT_TSLIB)-tslib

QT5_QMAKE_OPT := CONFIG+=release CONFIG-=debug

ifndef PTXCONF_QT5_MODULE_QTWEBKIT_VIDEO
# explicitly disable gstreamer use
QT5_QMAKE_OPT += "WEBKIT_CONFIG-=video use_gstreamer use_native_fullscreen_video glib"
endif
ifdef PTXCONF_QT5_MODULE_QTWEBENGINE
QT5_QMAKE_OPT += "PTX_QMAKE_CFLAGS=$(shell ptxd_cross_cc_v | sed -n "s/^COLLECT_GCC_OPTIONS=\(.*\)/\1/p" | tail -n1)"
endif

$(STATEDIR)/qt5.prepare:
	@$(call targetinfo)
	@rm -rf "$(QT5_DIR)/qtbase/mkspecs/linux-ptx-g++"
	@mkdir "$(QT5_DIR)/qtbase/mkspecs/linux-ptx-g++"
	@$(foreach file, $(wildcard $(QT5_MKSPECS)/*), \
		$(QT5_CONF_ENV) ptxd_replace_magic "$(file)" > \
		"$(QT5_DIR)/qtbase/mkspecs/linux-ptx-g++/$(notdir $(file))";)

	@+$(call world/prepare, QT5)
	cd $(QT5_DIR)-build && ./qtbase/bin/qmake $(QT5_QMAKE_OPT) $(QT5_DIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qt5.install:
	@$(call targetinfo)
	@$(call world/install, QT5)
	@find $(QT5_PKGDIR) -name '*.qmltypes' | xargs -r rm
ifdef PTXCONF_QT5_MODULE_QTWEBKIT_QUICK
	@chrpath -d $(QT5_PKGDIR)/usr/lib/qt5/libexec/QtWebProcess
ifdef PTXCONF_QT5_X11
	@chrpath -d $(QT5_PKGDIR)/usr/lib/qt5/libexec/QtWebPluginProcess
endif
endif
	@$(call touch)

QT5_QT_CONF := $(PTXDIST_SYSROOT_CROSS)/bin/qt5/qt.conf

$(STATEDIR)/qt5.install.post:
	@$(call targetinfo)
	@$(call world/install.post, QT5)
	@rm -rf $(PTXDIST_SYSROOT_CROSS)/bin/qt5
	@cp -a $(SYSROOT)/usr/bin/qt5 $(PTXDIST_SYSROOT_CROSS)/bin/qt5
	@echo "[Paths]"						>  $(QT5_QT_CONF)
	@echo "HostPrefix=$(SYSROOT)/usr"			>> $(QT5_QT_CONF)
	@echo "HostData=$(SYSROOT)/usr/lib/qt5"			>> $(QT5_QT_CONF)
	@echo "HostBinaries=$(PTXDIST_SYSROOT_CROSS)/bin/qt5"	>> $(QT5_QT_CONF)
	@echo "Prefix=$(SYSROOT)/usr"				>> $(QT5_QT_CONF)
	@echo "Headers=$(SYSROOT)/usr/include/qt5"		>> $(QT5_QT_CONF)
	@echo "Imports=/usr/lib/qt5/imports"			>> $(QT5_QT_CONF)
	@echo "Qml2Imports=/usr/lib/qt5/qml"			>> $(QT5_QT_CONF)
	@echo ""						>> $(QT5_QT_CONF)
	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

### QtBase ###
QT5_LIBS-y							:= Qt5Core
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE)				+= Qt5Concurrent
QT5_LIBS-$(PTXCONF_QT5_DBUS)					+= Qt5DBus
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE_GUI)			+= Qt5Gui
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE)				+= Qt5Network
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE_OPENGL)			+= Qt5OpenGL
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE_WIDGETS)			+= Qt5PrintSupport
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE_SQL)			+= Qt5Sql
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE)				+= Qt5Test
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE_WIDGETS)			+= Qt5Widgets
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTBASE)				+= Qt5Xml
QT5_PLUGINS-$(PTXCONF_QT5_DBUS)					+= bearer/libqconnmanbearer
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTBASE)			+= bearer/libqgenericbearer
QT5_PLUGINS-$(PTXCONF_QT5_DBUS)					+= bearer/libqnmbearer
QT5_PLUGINS-$(PTXCONF_QT5_INPUT_EVDEV)				+= generic/libqevdevkeyboardplugin
QT5_PLUGINS-$(PTXCONF_QT5_INPUT_EVDEV)				+= generic/libqevdevmouseplugin
QT5_PLUGINS-$(PTXCONF_QT5_INPUT_EVDEV)				+= generic/libqevdevtabletplugin
QT5_PLUGINS-$(PTXCONF_QT5_INPUT_EVDEV)				+= generic/libqevdevtouchplugin
QT5_PLUGINS-$(PTXCONF_QT5_INPUT_TSLIB)				+= generic/libqtslibplugin
QT5_PLUGINS-$(PTXCONF_QT5_GIF)					+= imageformats/libqgif
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTBASE_GUI)			+= imageformats/libqico
QT5_PLUGINS-$(PTXCONF_QT5_LIBJPEG)				+= imageformats/libqjpeg
QT5_PLUGINS-$(PTXCONF_QT5_PLATFORM_XCB)				+= platforminputcontexts/libcomposeplatforminputcontextplugin
ifdef PTXCONF_QT5_MODULE_QTBASE_GUI
QT5_PLUGINS-$(PTXCONF_QT5_DBUS)					+= platforminputcontexts/libibusplatforminputcontextplugin
endif
QT5_PLUGINS-$(PTXCONF_QT5_PLATFORM_XCB)				+= platforms/libqxcb
QT5_PLUGINS-$(PTXCONF_QT5_PLATFORM_DIRECTFB)			+= platforms/libqdirectfb
QT5_PLUGINS-$(PTXCONF_QT5_PLATFORM_EGLFS)			+= platforms/libqeglfs
QT5_PLUGINS-$(PTXCONF_QT5_PLATFORM_LINUXFB)			+= platforms/libqlinuxfb
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTBASE_GUI)			+= platforms/libqminimal
QT5_PLUGINS-$(PTXCONF_QT5_PLATFORM_EGLFS)			+= platforms/libqminimalegl

### QtConnectivity ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTCONNECTIVITY)			+= Qt5Bluetooth
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTCONNECTIVITY)			+= Qt5Nfc
QT5_QML-$(PTXCONF_QT5_MODULE_QTCONNECTIVITY_QUICK)		+= QtBluetooth
QT5_QML-$(PTXCONF_QT5_MODULE_QTCONNECTIVITY_QUICK)		+= QtNfc

### QtDeclarative ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTDECLARATIVE)			+= Qt5Qml
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTDECLARATIVE_QUICK)		+= Qt5Quick
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTDECLARATIVE_QUICK)		+= Qt5QuickParticles
QT5_LIBS-							+= Qt5QuickTest
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_qtquick2
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTDECLARATIVE_DEBUG)		+= qmltooling/libqmldbg_tcp
QT5_QML-$(PTXCONF_QT5_MODULE_QTDECLARATIVE)			+= Qt
QT5_QML-$(PTXCONF_QT5_MODULE_QTDECLARATIVE)			+= QtQuick
QT5_QML-$(PTXCONF_QT5_MODULE_QTDECLARATIVE)			+= QtQuick.2
QT5_QML-$(PTXCONF_QT5_MODULE_QTDECLARATIVE)			+= QtQml
QT5_QML-							+= QtTest

### QtEnginio ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTENGINIO)			+= Enginio
QT5_QML-$(PTXCONF_QT5_MODULE_QTENGINIO)				+= Enginio

### QtGraphicalEffects ###
QT5_QML-$(PTXCONF_QT5_MODULE_QTGRAPHICALEFFECTS)		+= QtGraphicalEffects

### QtImageFormats ###
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTIMAGEFORMATS)		+= imageformats/libqdds
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTIMAGEFORMATS)		+= imageformats/libqicns
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTIMAGEFORMATS)		+= imageformats/libqjp2
QT5_PLUGINS-$(PTXCONF_QT5_LIBMNG)				+= imageformats/libqmng
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTIMAGEFORMATS)		+= imageformats/libqtga
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTIMAGEFORMATS)		+= imageformats/libqtiff
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTIMAGEFORMATS)		+= imageformats/libqwbmp
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTIMAGEFORMATS)		+= imageformats/libqwebp


### QtLocation ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTLOCATION)			+= Qt5Positioning
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTLOCATION)			+= position/libqtposition_positionpoll
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTLOCATION)			+= geoservices/libqtgeoservices_osm
QT5_QML-$(PTXCONF_QT5_MODULE_QTLOCATION_QUICK)			+= QtPositioning

### QtMultimedia ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA)			+= Qt5Multimedia
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_QUICK)		+= Qt5MultimediaQuick_p
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_WIDGETS)		+= Qt5MultimediaWidgets
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_GST)			+= qgsttools_p
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_GST)		+= audio/libqtaudio_alsa
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_GST)		+= mediaservice/libgstaudiodecoder
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_GST)		+= mediaservice/libgstcamerabin
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_GST)		+= mediaservice/libgstmediacapture
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_GST)		+= mediaservice/libgstmediaplayer
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA)			+= playlistformats/libqtmultimedia_m3u
ifdef PTXCONF_QT5_OPENGL_ES2
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_QUICK)		+= video/videonode/libeglvideonode
endif
QT5_QML-$(PTXCONF_QT5_MODULE_QTMULTIMEDIA_QUICK)		+= QtMultimedia

### QtQuick1 ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTQUICK1)				+= Qt5Declarative
QT5_PLUGINS-							+= designer/libqdeclarativeview
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTQUICK1_DEBUG)		+= qml1tooling/libqmldbg_inspector
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTQUICK1_DEBUG)		+= qml1tooling/libqmldbg_tcp_qtdeclarative
QT5_IMPORTS-$(PTXCONF_QT5_MODULE_QTQUICK1)			+= Qt
QT5_IMPORTS-$(PTXCONF_QT5_MODULE_QTQUICK1_WEBKIT)		+= QtWebKit

### QtQuickControls ###
# all in QT5_QML- added by QtDeclarative

### QtScript ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTSCRIPT)				+= Qt5Script
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTSCRIPT_WIDGETS)			+= Qt5ScriptTools

### QtSensors ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTSENSORS)			+= Qt5Sensors
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTSENSORS)			+= sensorgestures/libqtsensorgestures_counterplugin
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTSENSORS)			+= sensorgestures/libqtsensorgestures_plugin
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTSENSORS)			+= sensorgestures/libqtsensorgestures_shakeplugin
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTSENSORS)			+= sensors/libqtsensors_generic
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTSENSORS)			+= sensors/libqtsensors_linuxsys
QT5_QML-$(PTXCONF_QT5_MODULE_QTSENSORS_QUICK)			+= QtSensors

### QtSerialPort ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTSERIALPORT)			+= Qt5SerialPort

### QtSvg ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTSVG)				+= Qt5Svg
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTSVG_WIDGETS)			+= iconengines/libqsvgicon
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTSVG)				+= imageformats/libqsvg

### QtTools ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTTOOLS_WIDGETS)			+= Qt5CLucene
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTTOOLS_WIDGETS)			+= Qt5Designer
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTTOOLS_WIDGETS)			+= Qt5DesignerComponents
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTTOOLS_WIDGETS)			+= Qt5Help

### QtWayland ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTWAYLAND)			+= Qt5WaylandClient
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTWAYLAND)			+= platforms/libqwayland-generic
ifdef PTXCONF_QT5_OPENGL
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTWAYLAND_MESA)		+= platforms/libqwayland-egl
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTWAYLAND_MESA)		+= wayland-graphics-integration-client/libwayland-egl
endif
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTWAYLAND_MESA)		+= wayland-graphics-integration-client/libdrm-egl-server
#QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTWAYLAND)			+= wayland-graphics-integration-client/libxcomposite-glx
QT5_PLUGINS-$(PTXCONF_QT5_MODULE_QTWAYLAND)			+= wayland-decoration-client/libbradient
### QtWebChannel ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTWEBCHANNEL)			+= Qt5WebChannel
QT5_QML-$(PTXCONF_QT5_MODULE_QTWEBCHANNEL)			+= QtWebChannel
### QtWebEngine ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTWEBENGINE)			+= Qt5WebEngine
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTWEBENGINE)			+= Qt5WebEngineCore
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTWEBENGINE_WIDGETS)		+= Qt5WebEngineWidgets
QT5_QML-$(PTXCONF_QT5_MODULE_QTWEBENGINE)			+= QtWebEngine

### QtWebKit ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTWEBKIT)				+= Qt5WebKit
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTWEBKIT_WIDGETS)			+= Qt5WebKitWidgets
QT5_QML-$(PTXCONF_QT5_MODULE_QTWEBKIT_QUICK)			+= QtWebKit

### QtWebSockets ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTWEBSOCKETS)			+= Qt5WebSockets

### QtX11Extras ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTX11EXTRAS)			+= Qt5X11Extras

### QtXmlPatterns ###
QT5_LIBS-$(PTXCONF_QT5_MODULE_QTXMLPATTERNS)			+= Qt5XmlPatterns



$(STATEDIR)/qt5.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qt5)
	@$(call install_fixup, qt5,PRIORITY,optional)
	@$(call install_fixup, qt5,SECTION,base)
	@$(call install_fixup, qt5,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, qt5,DESCRIPTION,missing)

	@$(foreach lib, $(QT5_LIBS-y), \
		$(call install_lib, qt5, 0, 0, 0644, lib$(lib));)

ifdef PTXCONF_QT5_MODULE_QTWEBENGINE
	@$(call install_copy, qt5, 0, 0, 0755, -, \
		/usr/lib/qt5/libexec/QtWebEngineProcess)
	@$(call install_copy, qt5, 0, 0, 0755, -, \
		/usr/share/qt5/qtwebengine_resources.pak)
	@$(call install_link, qt5, ../icu/$(ICU_VERSION)/icudt$(basename $(ICU_VERSION))$(call ptx/ifdef,PTXCONF_ENDIAN_LITTLE,l,b).dat, \
		/usr/share/qt5/icudtl.dat)
endif

ifdef PTXCONF_QT5_MODULE_QTWEBKIT_QUICK
	@$(call install_copy, qt5, 0, 0, 0755, -, \
		/usr/lib/qt5/libexec/QtWebProcess)
ifdef PTXCONF_QT5_X11
	@$(call install_copy, qt5, 0, 0, 0755, -, \
		/usr/lib/qt5/libexec/QtWebPluginProcess)
endif
endif

	@$(foreach plugin, $(QT5_PLUGINS-y), \
		$(call install_copy, qt5, 0, 0, 0644, -, \
			/usr/lib/qt5/plugins/$(plugin).so);)

	@$(foreach import, $(QT5_IMPORTS-y), \
		$(call install_tree, qt5, 0, 0, -, \
		/usr/lib/qt5/imports/$(import));)

	@$(foreach qml, $(QT5_QML-y), \
		$(call install_tree, qt5, 0, 0, -, \
		/usr/lib/qt5/qml/$(qml));)

ifdef PTXCONF_QT5_MODULE_QTDECLARATIVE_QMLSCENE
	@$(call install_copy, qt5, 0, 0, 0755, -, /usr/bin/qmlscene)
endif

	@$(call install_finish, qt5)

	@$(call touch)

# vim: syntax=make
