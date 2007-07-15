# -*-makefile-*-
# $Id: libdaemon.make,v 1.7 2007-07-15 19:14:38 michl Exp $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDAEMON) += libdaemon

#
# Paths and names
#
LIBDAEMON_VERSION	:= 0.12
LIBDAEMON		:= libdaemon-$(LIBDAEMON_VERSION)
LIBDAEMON_SUFFIX	:= tar.gz
LIBDAEMON_URL		:= http://0pointer.de/lennart/projects/libdaemon/$(LIBDAEMON).$(LIBDAEMON_SUFFIX)
LIBDAEMON_SOURCE	:= $(SRCDIR)/$(LIBDAEMON).$(LIBDAEMON_SUFFIX)
LIBDAEMON_DIR		:= $(BUILDDIR)/$(LIBDAEMON)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libdaemon_get: $(STATEDIR)/libdaemon.get

$(STATEDIR)/libdaemon.get: $(libdaemon_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBDAEMON_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBDAEMON)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libdaemon_extract: $(STATEDIR)/libdaemon.extract

$(STATEDIR)/libdaemon.extract: $(libdaemon_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBDAEMON_DIR))
	@$(call extract, LIBDAEMON)
	@$(call patchin, LIBDAEMON)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libdaemon_prepare: $(STATEDIR)/libdaemon.prepare

LIBDAEMON_PATH	:=  PATH=$(CROSS_PATH)
LIBDAEMON_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
LIBDAEMON_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-lynx

$(STATEDIR)/libdaemon.prepare: $(libdaemon_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBDAEMON_DIR)/config.cache)
	cd $(LIBDAEMON_DIR) && \
		$(LIBDAEMON_PATH) $(LIBDAEMON_ENV) \
		./configure $(LIBDAEMON_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libdaemon_compile: $(STATEDIR)/libdaemon.compile

$(STATEDIR)/libdaemon.compile: $(libdaemon_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBDAEMON_DIR) && $(LIBDAEMON_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libdaemon_install: $(STATEDIR)/libdaemon.install

$(STATEDIR)/libdaemon.install: $(libdaemon_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBDAEMON)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libdaemon_targetinstall: $(STATEDIR)/libdaemon.targetinstall

$(STATEDIR)/libdaemon.targetinstall: $(libdaemon_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libdaemon)
	@$(call install_fixup,libdaemon,PACKAGE,libdaemon)
	@$(call install_fixup,libdaemon,PRIORITY,optional)
	@$(call install_fixup,libdaemon,VERSION,$(LIBDAEMON_VERSION))
	@$(call install_fixup,libdaemon,SECTION,base)
	@$(call install_fixup,libdaemon,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,libdaemon,DEPENDS,)
	@$(call install_fixup,libdaemon,DESCRIPTION,missing)

	@$(call install_copy, libdaemon, 0, 0, 0644, \
		$(LIBDAEMON_DIR)/libdaemon/.libs/libdaemon.so.0.3.1, \
		/usr/lib/libdaemon.so.0.3.1)

	@$(call install_link, libdaemon, \
		libdaemon.so.0.3.1, \
		/usr/lib/libdaemon.so.0)

	@$(call install_link, libdaemon, \
		libdaemon.so.0.3.1, \
		/usr/lib/libdaemon.so)

	@$(call install_finish,libdaemon)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libdaemon_clean:
	rm -rf $(STATEDIR)/libdaemon.*
	rm -rf $(IMAGEDIR)/libdaemon_*
	rm -rf $(LIBDAEMON_DIR)

# vim: syntax=make
