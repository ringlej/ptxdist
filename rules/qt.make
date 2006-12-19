# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: do something on targetinstall

#
# We provide this package
#
PACKAGES-$(PTXCONF_QT) += qt

#
# Paths and names
#
QT_VERSION	= 2.3.2
QT		= qt-x11-$(QT_VERSION)
QT_SUFFIX	= tar.gz
QT_URL		= ftp://ftp.trolltech.com/qt/source/$(QT).$(QT_SUFFIX)
QT_SOURCE	= $(SRCDIR)/$(QT).$(QT_SUFFIX)
QT_DIR		= $(BUILDDIR)/qt-$(QT_VERSION)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

qt_get: $(STATEDIR)/qt.get

$(STATEDIR)/qt.get: $(qt_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(QT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, QT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

qt_extract: $(STATEDIR)/qt.extract

$(STATEDIR)/qt.extract: $(qt_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(QT_DIR))
	@$(call extract, QT)
	@$(call patchin, QT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

qt_prepare: $(STATEDIR)/qt.prepare

QT_PATH	=  PATH=$(CROSS_PATH)
QT_ENV 	=  $(CROSS_ENV)
QT_ENV	+= QTDIR=$(QT_DIR)

#
# autoconf
#
#QT_AUTOCONF	+= --build=$(GNU_HOST)
#QT_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

QT_AUTOCONF = -gif \
	-qt-libpng \
	-no-jpeg \
	-no-mng \
	-no-thread \
	-no-opengl \
	-release \
	-shared \
	-no-g++-exceptions \
	-I$(SYSROOT)/include \
	-R$(SYSROOT)/usr/lib \
	-L/usr/X11R6/lib \
	-depths 16 \
	-no-qvfb \
	-xplatform linux-g++

$(STATEDIR)/qt.prepare: $(qt_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(QT_DIR) && \
		echo "yes" | $(QT_PATH) $(QT_ENV) \
		./configure $(QT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

qt_compile: $(STATEDIR)/qt.compile

$(STATEDIR)/qt.compile: $(qt_compile_deps_default)
	@$(call targetinfo, $@)
	$(QT_PATH) $(QT_ENV) make -C $(QT_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

qt_install: $(STATEDIR)/qt.install

$(STATEDIR)/qt.install: $(qt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, QT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

qt_targetinstall: $(STATEDIR)/qt.targetinstall

$(STATEDIR)/qt.targetinstall: $(qt_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qt_clean:
	rm -rf $(STATEDIR)/qt.*
	rm -rf $(IMAGEDIR)/qt.*
	rm -rf $(QT_DIR)

# vim: syntax=make
