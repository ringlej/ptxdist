# -*-makefile-*-
# $Id: template-make 7626 2007-11-26 10:27:03Z mkl $
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGSLOOP) += libgsloop

#
# Paths and names
#
LIBGSLOOP_VERSION	:= 0.0.9
LIBGSLOOP		:= libgsloop-$(LIBGSLOOP_VERSION)
LIBGSLOOP_SUFFIX	:= tar.bz2
LIBGSLOOP_URL		:= http://www.pengutronix.de/software/libgsloop/download/$(LIBGSLOOP).$(LIBGSLOOP_SUFFIX)
LIBGSLOOP_SOURCE	:= $(SRCDIR)/$(LIBGSLOOP).$(LIBGSLOOP_SUFFIX)
LIBGSLOOP_DIR		:= $(BUILDDIR)/$(LIBGSLOOP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libgsloop_get: $(STATEDIR)/libgsloop.get

$(STATEDIR)/libgsloop.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBGSLOOP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBGSLOOP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libgsloop_extract: $(STATEDIR)/libgsloop.extract

$(STATEDIR)/libgsloop.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGSLOOP_DIR))
	@$(call extract, LIBGSLOOP)
	@$(call patchin, LIBGSLOOP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libgsloop_prepare: $(STATEDIR)/libgsloop.prepare

LIBGSLOOP_PATH	:= PATH=$(CROSS_PATH)
LIBGSLOOP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGSLOOP_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libgsloop.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGSLOOP_DIR)/config.cache)
	cd $(LIBGSLOOP_DIR) && \
		$(LIBGSLOOP_PATH) $(LIBGSLOOP_ENV) \
		./configure $(LIBGSLOOP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libgsloop_compile: $(STATEDIR)/libgsloop.compile

$(STATEDIR)/libgsloop.compile:
	@$(call targetinfo, $@)
	cd $(LIBGSLOOP_DIR) && $(LIBGSLOOP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libgsloop_install: $(STATEDIR)/libgsloop.install

$(STATEDIR)/libgsloop.install:
	@$(call targetinfo, $@)
	@$(call install, LIBGSLOOP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libgsloop_targetinstall: $(STATEDIR)/libgsloop.targetinstall

$(STATEDIR)/libgsloop.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, libgsloop)
	@$(call install_fixup, libgsloop,PACKAGE,libgsloop)
	@$(call install_fixup, libgsloop,PRIORITY,optional)
	@$(call install_fixup, libgsloop,VERSION,$(LIBGSLOOP_VERSION))
	@$(call install_fixup, libgsloop,SECTION,base)
	@$(call install_fixup, libgsloop,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libgsloop,DEPENDS,)
	@$(call install_fixup, libgsloop,DESCRIPTION,missing)

	@$(call install_copy, libgsloop, 0, 0, 0644, $(LIBGSLOOP_DIR)/src/.libs/libgsloop.so.4.0.0, /usr/lib/libgsloop.so.4.0.0)
	@$(call install_link, libgsloop, libgsloop.so.4.0.0, /usr/lib/libgsloop.so.4)
	@$(call install_link, libgsloop, libgsloop.so.4.0.0, /usr/lib/libgsloop.so)

	@$(call install_finish, libgsloop)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgsloop_clean:
	rm -rf $(STATEDIR)/libgsloop.*
	rm -rf $(PKGDIR)/libgsloop_*
	rm -rf $(LIBGSLOOP_DIR)

# vim: syntax=make
