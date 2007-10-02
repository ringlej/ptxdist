# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGLADE) += libglade

#
# Paths and names
#
LIBGLADE_VERSION	:= 2.6.2
LIBGLADE		:= libglade-$(LIBGLADE_VERSION)
LIBGLADE_SUFFIX		:= tar.bz2
LIBGLADE_URL		:= http://ftp.gnome.org/pub/GNOME/sources/libglade/2.6/$(LIBGLADE).$(LIBGLADE_SUFFIX)
LIBGLADE_SOURCE		:= $(SRCDIR)/$(LIBGLADE).$(LIBGLADE_SUFFIX)
LIBGLADE_DIR		:= $(BUILDDIR)/$(LIBGLADE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libglade_get: $(STATEDIR)/libglade.get

$(STATEDIR)/libglade.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBGLADE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBGLADE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libglade_extract: $(STATEDIR)/libglade.extract

$(STATEDIR)/libglade.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGLADE_DIR))
	@$(call extract, LIBGLADE)
	@$(call patchin, LIBGLADE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libglade_prepare: $(STATEDIR)/libglade.prepare

LIBGLADE_PATH	:= PATH=$(CROSS_PATH)
LIBGLADE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGLADE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static

$(STATEDIR)/libglade.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGLADE_DIR)/config.cache)
	cd $(LIBGLADE_DIR) && \
		$(LIBGLADE_PATH) $(LIBGLADE_ENV) \
		./configure $(LIBGLADE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libglade_compile: $(STATEDIR)/libglade.compile

$(STATEDIR)/libglade.compile:
	@$(call targetinfo, $@)
	cd $(LIBGLADE_DIR) && $(LIBGLADE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libglade_install: $(STATEDIR)/libglade.install

$(STATEDIR)/libglade.install:
	@$(call targetinfo, $@)
	@$(call install, LIBGLADE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libglade_targetinstall: $(STATEDIR)/libglade.targetinstall

$(STATEDIR)/libglade.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, libglade)
	@$(call install_fixup, libglade,PACKAGE,libglade)
	@$(call install_fixup, libglade,PRIORITY,optional)
	@$(call install_fixup, libglade,VERSION,$(LIBGLADE_VERSION))
	@$(call install_fixup, libglade,SECTION,base)
	@$(call install_fixup, libglade,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libglade,DEPENDS,)
	@$(call install_fixup, libglade,DESCRIPTION,missing)

	@$(call install_copy, libglade, 0, 0, 0644, \
		$(LIBGLADE_DIR)/glade/.libs/libglade-2.0.so.0.0.7, \
		/usr/lib/libglade-2.0.so.0.0.7)
	@$(call install_link, libglade, libglade-2.0.so.0.0.7, /usr/lib/libglade-2.0.so.0)
	@$(call install_link, libglade, libglade-2.0.so.0.0.7, /usr/lib/libglade-2.0.so)

	@$(call install_finish, libglade)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libglade_clean:
	rm -rf $(STATEDIR)/libglade.*
	rm -rf $(IMAGEDIR)/libglade_*
	rm -rf $(LIBGLADE_DIR)

# vim: syntax=make
