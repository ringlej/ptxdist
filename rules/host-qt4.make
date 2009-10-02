# -*-makefile-*-
# $Id$
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
HOST_QT4_DIR	= $(HOST_BUILDDIR)/$(QT4)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-qt4.get: $(STATEDIR)/qt4.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-qt4.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_QT4_DIR))
	@$(call extract, QT4, $(HOST_BUILDDIR))
	@$(call patchin, QT4, $(HOST_QT4_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_QT4_PATH		:= PATH=$(HOST_PATH)
HOST_QT4_ENV		:= $(HOST_ENV)
HOST_QT4_MAKEVARS	:= INSTALL_ROOT=$(PTXCONF_SYSROOT_HOST)

#
# autoconf
#
#
# autoconf
#
# Important: Use "-no-fast" here. Otherwise qmake will be called during
# the compile stage when the environment is not properly set!
HOST_QT4_AUTOCONF := \
	$(HOST_AUTOCONF) \
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
	-depths all \
	-prefix / \
	-make libs \
	-make tools \
	-nomake examples \
	-nomake demos \
	-no-libpng \
	-no-libmng \
	-no-libtiff \
	-no-gif \
	-no-libjpeg \
	-qt-zlib \
	-no-freetype \
	-no-stl \
	-no-glib \
	-dbus \
	-no-xmlpatterns \
	-no-exceptions \
	-no-phonon \
	-no-phonon-backend \
	-no-webkit \
	-no-scripttools \
	-no-gfx-linuxfb \
	-no-gfx-transformed \
	-no-gfx-qvfb \
	-no-gfx-vnc \
	-no-gfx-multiscreen \
	-no-kbd-tty \
	-no-kbd-usb \
	-no-kbd-sl5000 \
	-no-kbd-yopy \
	-no-kbd-vr41xx \
	-no-kbd-qvfb \
	-no-mouse-pc \
	-no-mouse-bus \
	-no-mouse-linuxtp \
	-no-mouse-yopy \
	-no-mouse-vr41xx \
	-no-mouse-tslib \
	-no-mouse-qvfb


$(STATEDIR)/host-qt4.prepare:
	@$(call targetinfo)
	@$(call clean, $(HOST_QT4_DIR)/config.cache)

	@cd $(HOST_QT4_DIR) && $(HOST_QT4_PATH) $(HOST_QT4_ENV) $(MAKE) \
		confclean || true

	@cd $(HOST_QT4_DIR) && \
		$(HOST_QT4_PATH) $(HOST_QT4_ENV) \
		./configure $(HOST_QT4_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------


$(STATEDIR)/host-qt4.compile:
	@$(call targetinfo)
	@cd $(HOST_QT4_DIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-tools-bootstrap
	@cd $(HOST_QT4_DIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-xml sub-dbus sub-moc sub-rcc sub-uic
	@cd $(HOST_QT4_DIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		sub-network
	@cd $(HOST_QT4_DIR)/tools/linguist/lrelease && $(HOST_QT4_PATH) \
		$(MAKE) $(PARALLELMFLAGS)
	@cd $(HOST_QT4_DIR)/tools/qdbus && $(HOST_QT4_PATH) \
		$(MAKE) $(PARALLELMFLAGS) sub-qdbusxml2cpp sub-qdbuscpp2xml
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_QT4_INSTALL_TARGETS := \
	sub-moc-install_subtargets \
	sub-rcc-install_subtargets \
	sub-uic-install_subtargets

$(STATEDIR)/host-qt4.install:
	@$(call targetinfo)
	@cd $(HOST_QT4_DIR) && $(HOST_QT4_PATH) $(MAKE) $(PARALLELMFLAGS) \
		$(HOST_QT4_INSTALL_TARGETS) $(HOST_QT4_MAKEVARS)
	@cd $(HOST_QT4_DIR)/tools/linguist/lrelease && $(HOST_QT4_PATH) \
		$(MAKE) $(PARALLELMFLAGS) install $(HOST_QT4_MAKEVARS)
	@cd $(HOST_QT4_DIR)/tools/qdbus && $(HOST_QT4_PATH) \
		$(MAKE) $(PARALLELMFLAGS) $(HOST_QT4_MAKEVARS) \
		sub-qdbusxml2cpp-install_subtargets \
		sub-qdbuscpp2xml-install_subtargets
	@$(call touch)
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-qt4_clean:
	rm -rf $(STATEDIR)/host-qt4.*
	rm -rf $(HOST_QT4_DIR)

# vim: syntax=make
