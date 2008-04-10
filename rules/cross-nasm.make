# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Dan Kegel http://kegel.com
#               2006 by Marc Kleine-Bude <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_NASM) += cross-nasm

#
# Paths and names
#
CROSS_NASM_VERSION	:= 0.98.39
CROSS_NASM		:= nasm-$(CROSS_NASM_VERSION)
CROSS_NASM_SUFFIX	:= tar.bz2
CROSS_NASM_URL		:= $(PTXCONF_SETUP_SFMIRROR)/nasm/$(CROSS_NASM).$(CROSS_NASM_SUFFIX)
CROSS_NASM_SOURCE	:= $(SRCDIR)/$(CROSS_NASM).$(CROSS_NASM_SUFFIX)
CROSS_NASM_DIR		:= $(CROSS_BUILDDIR)/$(CROSS_NASM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cross-nasm_get: $(STATEDIR)/cross-nasm.get

$(STATEDIR)/cross-nasm.get: $(cross-nasm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CROSS_NASM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CROSS_NASM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cross-nasm_extract: $(STATEDIR)/cross-nasm.extract

$(STATEDIR)/cross-nasm.extract: $(cross-nasm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_NASM_DIR))
	@$(call extract, CROSS_NASM, $(CROSS_BUILDDIR))
	@$(call patchin, CROSS_NASM, $(CROSS_NASM_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cross-nasm_prepare: $(STATEDIR)/cross-nasm.prepare

CROSS_NASM_PATH	:= PATH=$(CROSS_PATH)
CROSS_NASM_ENV 	:= $(HOSTCC_ENV)

#
# autoconf
#
CROSS_NASM_AUTOCONF := \
	--prefix=$(PTXCONF_SYSROOT_CROSS) \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST)

$(STATEDIR)/cross-nasm.prepare: $(cross-nasm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_NASM_DIR)/config.cache)
	cd $(CROSS_NASM_DIR) && \
		$(CROSS_NASM_PATH) $(CROSS_NASM_ENV) \
		./configure $(CROSS_NASM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cross-nasm_compile: $(STATEDIR)/cross-nasm.compile

$(STATEDIR)/cross-nasm.compile: $(cross-nasm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CROSS_NASM_DIR) && $(CROSS_NASM_ENV) $(CROSS_NASM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cross-nasm_install: $(STATEDIR)/cross-nasm.install

cross-nasm_install_deps = $(cross-nasm_install_deps_default)

$(STATEDIR)/cross-nasm.install: $(cross-nasm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CROSS_NASM,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cross-nasm_clean:
	rm -rf $(STATEDIR)/cross-nasm.*
	rm -rf $(CROSS_NASM_DIR)

# vim: syntax=make
