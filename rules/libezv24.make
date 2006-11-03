# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
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
PACKAGES-$(PTXCONF_LIBEZV24) += libezv24

#
# Paths and names
#
LIBEZV24_VERSION	:= 0.1.1-ptx2
LIBEZV24		:= libezv24-$(LIBEZV24_VERSION)
LIBEZV24_SUFFIX		:= tar.bz2
LIBEZV24_URL		:= http://www.pengutronix.de/software/misc/download/$(LIBEZV24).$(LIBEZV24_SUFFIX)
LIBEZV24_SOURCE		:= $(SRCDIR)/$(LIBEZV24).$(LIBEZV24_SUFFIX)
LIBEZV24_DIR		:= $(BUILDDIR)/$(LIBEZV24)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libezv24_get: $(STATEDIR)/libezv24.get

$(STATEDIR)/libezv24.get: $(libezv24_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBEZV24_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBEZV24)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libezv24_extract: $(STATEDIR)/libezv24.extract

$(STATEDIR)/libezv24.extract: $(libezv24_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBEZV24_DIR))
	@$(call extract, LIBEZV24)
	@$(call patchin, LIBEZV24)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libezv24_prepare: $(STATEDIR)/libezv24.prepare

LIBEZV24_PATH	:=  PATH=$(CROSS_PATH)
LIBEZV24_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
LIBEZV24_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libezv24.prepare: $(libezv24_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBEZV24_DIR)/config.cache)
	cd $(LIBEZV24_DIR) && \
		$(LIBEZV24_PATH) $(LIBEZV24_ENV) \
		./configure $(LIBEZV24_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libezv24_compile: $(STATEDIR)/libezv24.compile

$(STATEDIR)/libezv24.compile: $(libezv24_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBEZV24_DIR) && $(LIBEZV24_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libezv24_install: $(STATEDIR)/libezv24.install

$(STATEDIR)/libezv24.install: $(libezv24_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBEZV24)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libezv24_targetinstall: $(STATEDIR)/libezv24.targetinstall

$(STATEDIR)/libezv24.targetinstall: $(libezv24_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libezv24)
	@$(call install_fixup,libezv24,PACKAGE,libezv24)
	@$(call install_fixup,libezv24,PRIORITY,optional)
	@$(call install_fixup,libezv24,VERSION,$(LIBEZV24_VERSION))
	@$(call install_fixup,libezv24,SECTION,base)
	@$(call install_fixup,libezv24,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,libezv24,DEPENDS,)
	@$(call install_fixup,libezv24,DESCRIPTION,missing)

	@$(call install_copy, libezv24, 0, 0, 0755, \
		$(LIBEZV24_DIR)/src/.libs/libezV24.so.0.0.0, \
		/usr/lib/libezV24.so.0.0.0)

	@$(call install_link, libezv24, \
		libezV24.so.0.0.0, /usr/lib/libezV24.so.0)

	@$(call install_link, libezv24, \
		libezV24.so.0.0.0, /usr/lib/libezV24.so)

	@$(call install_finish,libezv24)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libezv24_clean:
	rm -rf $(STATEDIR)/libezv24.*
	rm -rf $(IMAGEDIR)/libezv24_*
	rm -rf $(LIBEZV24_DIR)

# vim: syntax=make
