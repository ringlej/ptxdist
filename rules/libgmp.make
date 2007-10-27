# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGMP) += libgmp

#
# Paths and names
#
LIBGMP_VERSION	:= 4.2.1
LIBGMP		:= gmp-$(LIBGMP_VERSION)
LIBGMP_SUFFIX	:= tar.bz2
LIBGMP_URL	:= ftp://ftp.gnu.org/gnu/gmp/$(LIBGMP).$(LIBGMP_SUFFIX)
LIBGMP_SOURCE	:= $(SRCDIR)/$(LIBGMP).$(LIBGMP_SUFFIX)
LIBGMP_DIR	:= $(BUILDDIR)/$(LIBGMP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libgmp_get: $(STATEDIR)/libgmp.get

$(STATEDIR)/libgmp.get: $(libgmp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBGMP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBGMP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libgmp_extract: $(STATEDIR)/libgmp.extract

$(STATEDIR)/libgmp.extract: $(libgmp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGMP_DIR))
	@$(call extract, LIBGMP)
	@$(call patchin, LIBGMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libgmp_prepare: $(STATEDIR)/libgmp.prepare

LIBGMP_PATH	:= PATH=$(CROSS_PATH)
LIBGMP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGMP_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBGMP_SHARED
LIBGMP_AUTOCONF += --enable-shared
else
LIBGMP_AUTOCONF += --disable-shared
endif

ifdef PTXCONF_LIBGMP_STATIC
LIBGMP_AUTOCONF += --enable-static
else
LIBGMP_AUTOCONF += --disable-static
endif

$(STATEDIR)/libgmp.prepare: $(libgmp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBGMP_DIR)/config.cache)
	cd $(LIBGMP_DIR) && \
		$(LIBGMP_PATH) $(LIBGMP_ENV) \
		./configure $(LIBGMP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libgmp_compile: $(STATEDIR)/libgmp.compile

$(STATEDIR)/libgmp.compile: $(libgmp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBGMP_DIR) && $(LIBGMP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libgmp_install: $(STATEDIR)/libgmp.install

$(STATEDIR)/libgmp.install: $(libgmp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBGMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libgmp_targetinstall: $(STATEDIR)/libgmp.targetinstall

$(STATEDIR)/libgmp.targetinstall: $(libgmp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libgmp)
	@$(call install_fixup, libgmp,PACKAGE,libgmp)
	@$(call install_fixup, libgmp,PRIORITY,optional)
	@$(call install_fixup, libgmp,VERSION,$(LIBGMP_VERSION))
	@$(call install_fixup, libgmp,SECTION,base)
	@$(call install_fixup, libgmp,AUTHOR,"Carsten Schlote <c.schlote\@konzeptpark.de>")
	@$(call install_fixup, libgmp,DEPENDS,)
	@$(call install_fixup, libgmp,DESCRIPTION,missing)

ifdef PTXCONF_LIBGMP_SHARED
	@$(call install_copy, libgmp, 0, 0, 0644, $(LIBGMP_DIR)/.libs/libgmp.so.3.4.1, /usr/lib/libgmp.so.3.4.1)
	@$(call install_link, libgmp, libgmp.so.3.4.1, /usr/lib/libgmp.so.3)
	@$(call install_link, libgmp, libgmp.so.3.4.1, /usr/lib/libgmp.so)
endif

ifdef PTXCONF_LIBGMP_STATIC
	@$(call install_copy, libgmp, 0, 0, 0644, $(LIBGMP_DIR)/libgmp.la, /usr/lib/libgmp.la)
endif

	@$(call install_finish, libgmp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libgmp_clean:
	rm -rf $(STATEDIR)/libgmp.*
	rm -rf $(IMAGEDIR)/libgmp_*
	rm -rf $(LIBGMP_DIR)

# vim: syntax=make
