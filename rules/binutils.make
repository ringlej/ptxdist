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
BINUTILS_VERSION	:= 2.16.1
BINUTILS		:= binutils-$(BINUTILS_VERSION)
BINUTILS_SUFFIX		:= tar.bz2
BINUTILS_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/binutils/$(BINUTILS).tar.gz
BINUTILS_SOURCE		:= $(SRCDIR)/$(BINUTILS).$(BINUTILS_SUFFIX)
BINUTILS_DIR		:= $(BUILDDIR)/$(BINUTILS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

binutils_get: $(STATEDIR)/binutils.get

$(STATEDIR)/binutils.get: $(binutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BINUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BINUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

binutils_extract: $(STATEDIR)/binutils.extract

$(STATEDIR)/binutils.extract: $(binutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(BINUTILS_DIR))
	@$(call extract, $(BINUTILS_SOURCE))
	@$(call patchin, $(BINUTILS))
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
BINUTILS_AUTOCONF =  $(CROSS_AUTOCONF_USR)
BINUTILS_AUTOCONF += \
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
	# the libiberty part is compiled for the host system
	# don't pass target CFLAGS to it, so override them and call the configure script
	$(BINUTILS_PATH) make -C $(BINUTILS_DIR) CFLAGS='' CXXFLAGS='' configure-build-libiberty

	# the chew tool is needed later during installation, compile it now
	# else it will fail cause it gets target CFLAGS
	$(BINUTILS_PATH) make -C $(BINUTILS_DIR)/bfd/doc CFLAGS='' CXXFLAGS='' chew

	# now do the _real_ compiling :-)
	$(BINUTILS_PATH) make -C $(BINUTILS_DIR)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

binutils_install: $(STATEDIR)/binutils.install

$(STATEDIR)/binutils.install: $(binutils_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME: do we have to set prefix='' (makevar)? 
	@$(call install, BINUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

binutils_targetinstall: $(STATEDIR)/binutils.targetinstall

$(STATEDIR)/binutils.targetinstall: $(binutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

# 	@$(call install_init, binutils)
# 	@$(call install_fixup,binutils,PACKAGE,binutils)
# 	@$(call install_fixup,binutils,PRIORITY,optional)
# 	@$(call install_fixup,binutils,VERSION,$(BINUTILS_VERSION))
# 	@$(call install_fixup,binutils,SECTION,base)
# 	@$(call install_fixup,binutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
# 	@$(call install_fixup,binutils,DEPENDS,)
# 	@$(call install_fixup,binutils,DESCRIPTION,missing)
# 
# 	@$(call install_copy, binutils, 0, 0, 0755, $(BINUTILS_DIR)/foobar, /dev/null)
# 
# 	@$(call install_finish,binutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

binutils_clean:
	rm -rf $(STATEDIR)/binutils.*
	rm -rf $(IMAGEDIR)/binutils_*
	rm -rf $(BINUTILS_DIR)

# vim: syntax=make

