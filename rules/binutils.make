# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_BINUTILS) += binutils

#
# Paths and names
#
BINUTILS_VERSION	:= 2.17
BINUTILS		:= binutils-$(BINUTILS_VERSION)
BINUTILS_SUFFIX		:= tar.bz2
BINUTILS_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/binutils/$(BINUTILS).$(BINUTILS_SUFFIX)
BINUTILS_SOURCE		:= $(SRCDIR)/$(BINUTILS).$(BINUTILS_SUFFIX)
BINUTILS_DIR		:= $(BUILDDIR)/$(BINUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

binutils_get: $(STATEDIR)/binutils.get

$(STATEDIR)/binutils.get: $(binutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BINUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BINUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

binutils_extract: $(STATEDIR)/binutils.extract

$(STATEDIR)/binutils.extract: $(binutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BINUTILS_DIR))
	@$(call extract, BINUTILS)
	@$(call patchin, BINUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

binutils_prepare: $(STATEDIR)/binutils.prepare

BINUTILS_PATH	:=  PATH=$(CROSS_PATH)
BINUTILS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
BINUTILS_AUTOCONF :=  $(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--enable-targets=$(PTXCONF_GNU_TARGET) \
	--disable-nls \
	--enable-shared \
	--enable-commonbfdlib \
	--enable-install-libiberty \
	--disable-multilib

$(STATEDIR)/binutils.prepare: $(binutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BINUTILS_DIR)/config.cache)
	cd $(BINUTILS_DIR) && \
		$(BINUTILS_PATH) $(BINUTILS_ENV) \
		./configure $(BINUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

binutils_compile: $(STATEDIR)/binutils.compile

$(STATEDIR)/binutils.compile: $(binutils_compile_deps_default)
	@$(call targetinfo, $@)

	$(BINUTILS_PATH) make -C $(BINUTILS_DIR)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

binutils_install: $(STATEDIR)/binutils.install

$(STATEDIR)/binutils.install: $(binutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, BINUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

binutils_targetinstall: $(STATEDIR)/binutils.targetinstall

$(STATEDIR)/binutils.targetinstall: $(binutils_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call install_init, binutils)
	@$(call install_fixup, binutils,PACKAGE,binutils)
	@$(call install_fixup, binutils,PRIORITY,optional)
	@$(call install_fixup, binutils,VERSION,$(BINUTILS_VERSION))
	@$(call install_fixup, binutils,SECTION,base)
	@$(call install_fixup, binutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, binutils,DEPENDS,)
	@$(call install_fixup, binutils,DESCRIPTION,missing)

	@$(call install_copy, binutils, 0, 0, 0755, $(BINUTILS_DIR)/binutils/.libs/objdump, \
		/usr/bin/objdump)

	@$(call install_copy, binutils, 0, 0, 0755, $(BINUTILS_DIR)/opcodes/.libs/libopcodes-2.17.so, /usr/lib/libopcodes-2.17.so )
	@$(call install_link, binutils, libopcodes-2.17.so, /usr/lib/libopcodes.so)
	@$(call install_copy, binutils, 0, 0, 0755, $(BINUTILS_DIR)/bfd/.libs/libbfd-2.17.so, /usr/lib/libbfd-2.17.so )
	@$(call install_link, binutils, libbfd-2.17.so, /usr/lib/libbfd.so)

	@$(call install_finish, binutils)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

binutils_clean:
	rm -rf $(STATEDIR)/binutils.*
	rm -rf $(IMAGEDIR)/binutils_*
	rm -rf $(BINUTILS_DIR)

# vim: syntax=make

