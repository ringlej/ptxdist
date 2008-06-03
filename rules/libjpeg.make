# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2006 by Erwin Rol
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBJPEG) += libjpeg

#
# Paths and names
#
LIBJPEG_VERSION	:= 6b-ptx1
LIBJPEG		:= libjpeg-$(LIBJPEG_VERSION)
LIBJPEG_SUFFIX	:= tar.bz2
LIBJPEG_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LIBJPEG).$(LIBJPEG_SUFFIX)
LIBJPEG_SOURCE	:= $(SRCDIR)/$(LIBJPEG).$(LIBJPEG_SUFFIX)
LIBJPEG_DIR	:= $(BUILDDIR)/$(LIBJPEG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libjpeg_get: $(STATEDIR)/libjpeg.get

$(STATEDIR)/libjpeg.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBJPEG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBJPEG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libjpeg_extract: $(STATEDIR)/libjpeg.extract

$(STATEDIR)/libjpeg.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBJPEG_DIR))
	@$(call extract, LIBJPEG)
	@$(call patchin, LIBJPEG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libjpeg_prepare: $(STATEDIR)/libjpeg.prepare

LIBJPEG_PATH	:= PATH=$(CROSS_PATH)
LIBJPEG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBJPEG_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libjpeg.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBJPEG_DIR)/config.cache)
	cd $(LIBJPEG_DIR) && \
		$(LIBJPEG_PATH) $(LIBJPEG_ENV) \
		./configure $(LIBJPEG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libjpeg_compile: $(STATEDIR)/libjpeg.compile

$(STATEDIR)/libjpeg.compile:
	@$(call targetinfo, $@)
	cd $(LIBJPEG_DIR) && $(LIBJPEG_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libjpeg_install: $(STATEDIR)/libjpeg.install

$(STATEDIR)/libjpeg.install:
	@$(call targetinfo, $@)
	@$(call install, LIBJPEG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libjpeg_targetinstall: $(STATEDIR)/libjpeg.targetinstall

$(STATEDIR)/libjpeg.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, libjpeg)
	@$(call install_fixup, libjpeg,PACKAGE,libjpeg)
	@$(call install_fixup, libjpeg,PRIORITY,optional)
	@$(call install_fixup, libjpeg,VERSION,$(LIBJPEG_VERSION))
	@$(call install_fixup, libjpeg,SECTION,base)
	@$(call install_fixup, libjpeg,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libjpeg,DEPENDS,)
	@$(call install_fixup, libjpeg,DESCRIPTION,missing)

	@$(call install_copy, libjpeg, 0, 0, 0755, $(LIBJPEG_DIR)/.libs/libjpeg.so.62.0.0, /usr/lib/libjpeg.so.62.0.0)
	@$(call install_link, libjpeg, libjpeg.so.62.0.0, /usr/lib/libjpeg.so.62)
	@$(call install_link, libjpeg, libjpeg.so.62.0.0, /usr/lib/libjpeg.so)

	@$(call install_finish, libjpeg)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libjpeg_clean:
	rm -rf $(STATEDIR)/libjpeg.*
	rm -rf $(PKGDIR)/libjpeg_*
	rm -rf $(LIBJPEG_DIR)

# vim: syntax=make
