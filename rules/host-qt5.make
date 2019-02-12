# -*-makefile-*-
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_QT5) += host-qt5

HOST_QT5_BUILD_OOT	:= YES

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# to build qmake in parallel
HOST_QT5_CONF_ENV := \
	$(HOST_ENV) \
	MAKEFLAGS="$(PARALLELMFLAGS)"

#
# autoconf
#
HOST_QT5_CONF_TOOL	:= autoconf
HOST_QT5_CONF_OPT	:= \
	$(if $(filter 1,$(PTXDIST_VERBOSE)),-v) \
	$(if $(filter 0,$(PTXDIST_VERBOSE)),-silent) \
	-prefix / \
	-bindir /bin/qt5 \
	-headerdir /include/qt5 \
	-archdatadir /lib/qt5 \
	-datadir /share/qt5 \
	-hostbindir /bin/qt5 \
	-release \
	--disable-optimized-tools \
	-opensource \
	-confirm-license \
	--enable-shared \
	--disable-accessibility \
	--disable-sql-db2 \
	--disable-sql-ibase \
	--disable-sql-mysql \
	--disable-sql-oci \
	--disable-sql-odbc \
	--disable-sql-psql \
	--disable-sql-sqlite2 \
	--disable-sql-tds \
	--disable-sql-sqlite \
	--disable-qml-debug \
	-pkg-config \
	-force-pkg-config \
	\
	-system-zlib \
	--disable-mtdev \
	--disable-journald \
	--disable-syslog \
	-no-gif \
	-no-libpng \
	-no-libjpeg \
	-no-freetype \
	-qt-harfbuzz \
	--disable-openssl \
	--disable-libproxy \
	-qt-pcre \
	-system-xcb \
	-no-xkbcommon-x11 \
	--disable-xkbcommon-evdev \
	--disable-xinput2 \
	--disable-xcb-xlib \
	--disable-glib \
	--disable-pulseaudio \
	--disable-alsa \
	--disable-gtkstyle \
	\
	-make libs \
	-make tools \
	-skip qt3d \
	-skip qtactiveqt \
	-skip qtandroidextras \
	-skip qtcanvas3d \
	-skip qtconnectivity \
	-skip qtdeclarative \
	-skip qtdoc \
	-skip qtenginio \
	-skip qtgraphicaleffects \
	-skip qtimageformats \
	-skip qtlocation \
	-skip qtmacextras \
	-skip qtmultimedia \
	-skip qtquickcontrols \
	-skip qtquickcontrols2 \
	-skip qtscript \
	-skip qtsensors \
	-skip qtserialbus \
	-skip qtserialport \
	-skip qtsvg \
	-skip qttools \
	-skip qttranslations \
	-skip qtwayland \
	-skip qtwebchannel \
	-skip qtwebengine \
	-skip qtwebsockets \
	-skip qtwebview \
	-skip qtwinextras \
	-skip qtx11extras \
	-skip qtxmlpatterns \
	--disable-compile-examples \
	--disable-gui \
	--disable-widgets \
	--disable-rpath \
	--disable-cups \
	--disable-iconv \
	--disable-evdev \
	--disable-tslib \
	--disable-icu \
	--disable-fontconfig \
	--disable-strip \
	--disable-pch \
	--disable-ltcg \
	--disable-dbus \
	--disable-separate-debug-info \
	--disable-xcb \
	--disable-eglfs \
	--disable-kms \
	--disable-gbm \
	--disable-directfb \
	--disable-linuxfb \
	--disable-mirclient \
	--opengl=no \
	--opengles3=no \
	--disable-libinput \
	-no-gstreamer \
	--disable-system-proxies

# Note: these options are not listed in '--help' but they exist
HOST_QT5_CONF_OPT += \
	--disable-sm \
	--disable-openvg \
	--disable-libudev \
	--disable-egl \
	--disable-xkb \
	--disable-xrender \
	--disable-xvideo

HOST_QT5_QT_CONF := $(PTXDIST_SYSROOT_HOST)/bin/qt5/qt.conf

HOST_QT5_COMPILE_ENV := \
	ICECC_REMOTE_CPP=0

$(STATEDIR)/host-qt5.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_QT5)
	@echo "[Paths]"						>  $(HOST_QT5_QT_CONF)
	@echo "HostPrefix=$(PTXDIST_SYSROOT_HOST)"		>> $(HOST_QT5_QT_CONF)
	@echo "HostData=$(PTXDIST_SYSROOT_HOST)/lib/qt5"	>> $(HOST_QT5_QT_CONF)
	@echo "HostBinaries=$(PTXDIST_SYSROOT_HOST)/bin/qt5"	>> $(HOST_QT5_QT_CONF)
	@echo "Prefix=$(PTXDIST_SYSROOT_HOST)"			>> $(HOST_QT5_QT_CONF)
	@echo "Headers=$(PTXDIST_SYSROOT_HOST)/include/qt5"	>> $(HOST_QT5_QT_CONF)
	@echo "Data=$(PTXDIST_SYSROOT_HOST)/share/qt5"		>> $(HOST_QT5_QT_CONF)
	@echo "Binaries=$(PTXDIST_SYSROOT_HOST)/bin/qt5"	>> $(HOST_QT5_QT_CONF)
	@echo ""						>> $(HOST_QT5_QT_CONF)
	@$(call touch)

# vim: syntax=make
