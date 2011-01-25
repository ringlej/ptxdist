# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_QT4) += host-qt4

#
# Paths and names
#
HOST_QT4_DIR		= $(HOST_BUILDDIR)/$(QT4)
HOST_QT4_BUILDDIR	= $(HOST_BUILDDIR)/$(QT4)-build
HOST_QT4_BUILD_OOT	:= YES

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_QT4_PATH		:= PATH=$(HOST_PATH)
HOST_QT4_ENV		:= $(HOST_ENV)

#
# autoconf
#
#
# autoconf
#
# Important: Use "-no-fast" here. Otherwise qmake will be called during
# the compile stage when the environment is not properly set!
HOST_QT4_AUTOCONF := \
	-prefix / \
	-shared \
	-opensource \
	-confirm-license \
	-release \
	-embedded \
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
	-optimized-qmake \
	-no-nis \
	-no-cups \
	-no-iconv \
	-pch \
	-force-pkg-config \
	-depths all \
	-make libs \
	-make tools \
	-nomake examples \
	-nomake demos \
	-nomake docs \
	-no-libpng \
	-no-libmng \
	-no-libtiff \
	-no-gif \
	-no-libjpeg \
	-qt-zlib \
	-no-freetype \
	-stl \
	-no-glib \
	-dbus \
	-no-phonon \
	-no-phonon-backend \
	-no-webkit \
	-no-script \
	-no-scripttools \
	-no-gfx-linuxfb \
	-no-gfx-transformed \
	-no-gfx-qvfb \
	-no-gfx-vnc \
	-no-gfx-multiscreen \
	-no-kbd-tty \
	-no-kbd-linuxinput \
	-no-kbd-qnx \
	-no-kbd-qvfb \
	-no-mouse-pc \
	-no-mouse-linuxtp \
	-no-mouse-linuxinput \
	-no-mouse-tslib \
	-no-mouse-qvfb \
	-no-mouse-qnx

ifdef PTXCONF_HOST_QT4_XMLPATTERNS
HOST_QT4_AUTOCONF += -xmlpatterns -exceptions
else
HOST_QT4_AUTOCONF += -no-xmlpatterns -no-exceptions
endif

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-qt4.compile:
	@$(call targetinfo)
	@cd $(HOST_QT4_BUILDDIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-tools-bootstrap
	@cd $(HOST_QT4_BUILDDIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-xml sub-dbus sub-moc sub-rcc sub-uic
	@cd $(HOST_QT4_BUILDDIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-network
ifdef PTXCONF_HOST_QT4_XMLPATTERNS
	@cd $(HOST_QT4_BUILDDIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-xmlpatterns
endif
	@cd $(HOST_QT4_BUILDDIR)/tools/linguist/lrelease && $(HOST_QT4_PATH) \
		$(MAKE) $(PARALLELMFLAGS)
	@cd $(HOST_QT4_BUILDDIR)/tools/qdbus && $(HOST_QT4_PATH) \
		$(MAKE) $(PARALLELMFLAGS) sub-qdbusxml2cpp sub-qdbuscpp2xml
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_QT4_INSTALL_TARGETS := \
	install_qmake \
	install_mkspecs \
	sub-xml-install_subtargets \
	sub-dbus-install_subtargets \
	sub-network-install_subtargets \
	sub-moc-install_subtargets \
	sub-rcc-install_subtargets \
	sub-uic-install_subtargets

ifdef PTXCONF_HOST_QT4_XMLPATTERNS
HOST_QT4_INSTALL_TARGETS += sub-xmlpatterns-install_subtargets
endif

HOST_QT4_INSTALL_OPT	= INSTALL_ROOT=$(HOST_QT4_PKGDIR)

$(STATEDIR)/host-qt4.install:
	@$(call targetinfo)
	@cd $(HOST_QT4_BUILDDIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		$(HOST_QT4_INSTALL_TARGETS) $(HOST_QT4_INSTALL_OPT)
	@cd $(HOST_QT4_BUILDDIR)/tools/linguist/lrelease && $(HOST_QT4_PATH) \
		$(MAKE) $(PARALLELMFLAGS) install $(HOST_QT4_INSTALL_OPT)
	@cd $(HOST_QT4_BUILDDIR)/tools/qdbus && $(HOST_QT4_PATH) \
		$(MAKE) $(PARALLELMFLAGS) $(HOST_QT4_INSTALL_OPT) \
		sub-qdbusxml2cpp-install_subtargets \
		sub-qdbuscpp2xml-install_subtargets
	@$(call touch)

$(STATEDIR)/host-qt4.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_QT4)
#	create a cross qmake:
#	copy host qmake and add a qt.conf (these must be in the same dir)
#	add wrapper script that sets the correct QMAKESPEC
	@rm -f $(PTXDIST_SYSROOT_CROSS)/bin/qmake $(PTXDIST_SYSROOT_CROSS)/bin/qmake-cross
	@cp $(HOST_QT4_PKGDIR)/bin/qmake $(PTXDIST_SYSROOT_CROSS)/bin/qmake-cross
ifdef PTXCONF_QT4_PLATFORM_EMBEDDED
	@echo -e '#!/bin/sh\nexport QMAKESPEC=qws/linux-ptx-g++\nexec $(PTXDIST_SYSROOT_CROSS)/bin/qmake-cross "$$@"\n' > $(PTXDIST_SYSROOT_CROSS)/bin/qmake
else
	@echo -e '#!/bin/sh\nexport QMAKESPEC=linux-ptx-g++\nexec $(PTXDIST_SYSROOT_CROSS)/bin/qmake-cross "$$@"\n' > $(PTXDIST_SYSROOT_CROSS)/bin/qmake
endif
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/bin/qmake
	@echo -e "[Paths]\nPrefix=$(SYSROOT)/usr\nBinaries=$(PTXCONF_SYSROOT_HOST)/bin" > $(PTXDIST_SYSROOT_CROSS)/bin/qt.conf
	@echo -e "[Paths]\nPrefix=$(PTXCONF_SYSROOT_HOST)" > $(PTXDIST_SYSROOT_HOST)/bin/qt.conf
	@$(call touch)

# vim: syntax=make
