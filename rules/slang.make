# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
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
PACKAGES-$(PTXCONF_SLANG) += slang

#
# Paths and names
#
SLANG_MAJORV	:= 2
SLANG_VERSION	:= $(SLANG_MAJORV).1.2
SLANG		:= slang-$(SLANG_VERSION)
SLANG_SUFFIX	:= tar.bz2
SLANG_URL	:= ftp://space.mit.edu/pub/davis/slang/v2.1/$(SLANG).$(SLANG_SUFFIX)
SLANG_SOURCE	:= $(SRCDIR)/$(SLANG).$(SLANG_SUFFIX)
SLANG_DIR	:= $(BUILDDIR)/$(SLANG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

slang_get: $(STATEDIR)/slang.get

$(STATEDIR)/slang.get: $(slang_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SLANG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SLANG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

slang_extract: $(STATEDIR)/slang.extract

$(STATEDIR)/slang.extract: $(slang_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SLANG_DIR))
	@$(call extract, SLANG)
	@$(call patchin, SLANG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

slang_prepare: $(STATEDIR)/slang.prepare

SLANG_PATH	:= PATH=$(CROSS_PATH)
SLANG_ENV 	:= $(CROSS_ENV)
SLANG_MAKEVARS	:= SLANG_INST_LIB=

#
# autoconf
#
SLANG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-png=$(SYSROOT)/usr \
	--with-iconv=$(SYSROOT)/usr

$(STATEDIR)/slang.prepare: $(slang_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SLANG_DIR)/config.cache)
	cd $(SLANG_DIR) && \
		$(SLANG_PATH) $(SLANG_ENV) \
		./configure $(SLANG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

slang_compile: $(STATEDIR)/slang.compile

$(STATEDIR)/slang.compile: $(slang_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SLANG_DIR) && $(SLANG_PATH) $(MAKE) elf $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

slang_install: $(STATEDIR)/slang.install

$(STATEDIR)/slang.install: $(slang_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SLANG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

slang_targetinstall: $(STATEDIR)/slang.targetinstall

$(STATEDIR)/slang.targetinstall: $(slang_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  slang)
	@$(call install_fixup, slang,PACKAGE,slang)
	@$(call install_fixup, slang,PRIORITY,optional)
	@$(call install_fixup, slang,VERSION,$(SLANG_VERSION))
	@$(call install_fixup, slang,SECTION,base)
	@$(call install_fixup, slang,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, slang,DEPENDS,)
	@$(call install_fixup, slang,DESCRIPTION,missing)

	@$(call install_copy, slang, 0, 0, 0644, \
		$(SLANG_DIR)/src/elfobjs/libslang.so.$(SLANG_VERSION), \
		/usr/lib/libslang.so.$(SLANG_VERSION))
	@$(call install_link, slang, libslang.so.$(SLANG_VERSION), /usr/lib/libslang.so.$(SLANG_MAJORV))
	@$(call install_link, slang, libslang.so.$(SLANG_VERSION), /usr/lib/libslang.so)

	@$(call install_finish, slang)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

slang_clean:
	rm -rf $(STATEDIR)/slang.*
	rm -rf $(PKGDIR)/slang_*
	rm -rf $(SLANG_DIR)

# vim: syntax=make

