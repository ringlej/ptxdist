# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by 
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QWT) += qwt

#
# Paths and names
#
QWT_VERSION	:= 5.2.0
QWT		:= qwt-$(QWT_VERSION)
QWT_SUFFIX	:= tar.bz2
QWT_URL		:= $(PTXCONF_SETUP_SFMIRROR)/qwt/$(QWT).$(QWT_SUFFIX)
QWT_SOURCE	:= $(SRCDIR)/$(QWT).$(QWT_SUFFIX)
QWT_DIR		:= $(BUILDDIR)/$(QWT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(QWT_SOURCE):
	@$(call targetinfo)
	@$(call get, QWT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/qwt.extract:
	@$(call targetinfo)
	@$(call clean, $(QWT_DIR))
	@$(call extract, QWT)
	@$(call patchin, QWT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

QWT_PATH	:= PATH=$(CROSS_PATH)

QWT_ENV = \
	$(CROSS_ENV) \
	INSTALL_ROOT=$(SYSROOT) \
	QMAKESPEC=$(QT4_DIR)/mkspecs/qws/linux-ptx-g++

#
# autoconf
#
QWT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/qwt.prepare:
	@$(call targetinfo)
	cd $(QWT_DIR) && \
		$(QWT_PATH) $(QWT_ENV) qmake -recursive
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/qwt.compile:
	@$(call targetinfo)
	cd $(QWT_DIR) && $(QWT_PATH) $(QWT_ENV) $(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qwt.install:
	@$(call targetinfo)
	cd $(QWT_DIR) && $(QWT_PATH) $(QWT_ENV) $(MAKE) install
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qwt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qwt)
	@$(call install_fixup, qwt,PACKAGE,qwt)
	@$(call install_fixup, qwt,PRIORITY,optional)
	@$(call install_fixup, qwt,VERSION,$(QWT_VERSION))
	@$(call install_fixup, qwt,SECTION,base)
	@$(call install_fixup, qwt,AUTHOR,"Michael Olbrich <m.olbrich\@pengutronix.de>")
	@$(call install_fixup, qwt,DEPENDS,)
	@$(call install_fixup, qwt,DESCRIPTION,missing)

	@$(call install_copy, qwt, 0, 0, 0644, \
		$(QWT_DIR)/lib/libqwt.so.5.2.0, \
		/usr/lib/libqwt.so.5.2.0)
	@$(call install_link, qwt, libqwt.so.5.2.0, \
		/usr/lib/libqwt.so.5.2)
	@$(call install_link, qwt, libqwt.so.5.2.0, \
		/usr/lib/libqwt.so.5)

	@$(call install_finish, qwt)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

qwt_clean:
	rm -rf $(STATEDIR)/qwt.*
	rm -rf $(PKGDIR)/qwt_*
	rm -rf $(QWT_DIR)

# vim: syntax=make
