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
ifdef PTXCONF_QT
PACKAGES += qt
endif

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

qt_get_deps	=  $(QT_SOURCE)

$(STATEDIR)/qt.get: $(qt_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(QT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(QT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

qt_extract: $(STATEDIR)/qt.extract

qt_extract_deps	=  $(STATEDIR)/qt.get

$(STATEDIR)/qt.extract: $(qt_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(QT_DIR))
	@$(call extract, $(QT_SOURCE))
	@$(call patchin, $(QT_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

qt_prepare: $(STATEDIR)/qt.prepare

#
# dependencies
#
qt_prepare_deps =  \
	$(STATEDIR)/qt.extract \
	$(STATEDIR)/virtual-xchain.install

QT_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
QT_ENV 	=  $(CROSS_ENV)
QT_ENV	+= QTDIR=$(QT_DIR)

#
# autoconf
#
#QT_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
#QT_AUTOCONF	+= --build=$(GNU_HOST)
#QT_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)

QT_AUTOCONF	+= -gif
QT_AUTOCONF	+= -qt-libpng
QT_AUTOCONF	+= -no-jpeg 
QT_AUTOCONF	+= -no-mng 
QT_AUTOCONF	+= -no-thread 
QT_AUTOCONF	+= -no-opengl 
QT_AUTOCONF	+= -release
QT_AUTOCONF	+= -shared 
QT_AUTOCONF	+= -no-g++-exceptions 
QT_AUTOCONF	+= -I$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
QT_AUTOCONF	+= -R$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
QT_AUTOCONF	+= -L/usr/X11R6/lib
QT_AUTOCONF	+= -depths 16
#QT_AUTOCONF	+= -qconfig local 
QT_AUTOCONF	+= -no-qvfb 
QT_AUTOCONF	+= -xplatform linux-g++

$(STATEDIR)/qt.prepare: $(qt_prepare_deps)
	@$(call targetinfo, $@)
	cd $(QT_DIR) && \
		echo "yes" | $(QT_PATH) $(QT_ENV) \
		./configure $(QT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

qt_compile: $(STATEDIR)/qt.compile

qt_compile_deps =  $(STATEDIR)/qt.prepare

$(STATEDIR)/qt.compile: $(qt_compile_deps)
	@$(call targetinfo, $@)
	$(QT_PATH) $(QT_ENV) make -C $(QT_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

qt_install: $(STATEDIR)/qt.install

$(STATEDIR)/qt.install: $(STATEDIR)/qt.compile
	@$(call targetinfo, $@)
	$(QT_PATH) $(QT_ENV) make -C $(QT_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

qt_targetinstall: $(STATEDIR)/qt.targetinstall

qt_targetinstall_deps	=  $(STATEDIR)/qt.compile

$(STATEDIR)/qt.targetinstall: $(qt_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qt_clean:
	rm -rf $(STATEDIR)/qt.*
	rm -rf $(IMAGEDIR)/qt.*
	rm -rf $(QT_DIR)

# vim: syntax=make
