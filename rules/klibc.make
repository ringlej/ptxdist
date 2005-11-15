# -*-makefile-*-
# $Id: template 3345 2005-11-14 17:14:19Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KLIBC) += klibc

#
# Paths and names
#
KLIBC_VERSION	= 1.1
KLIBC		= klibc-$(KLIBC_VERSION)
KLIBC_SUFFIX	= tar.bz2
KLIBC_URL	= http://www.kernel.org/pub/linux/libs/klibc/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_SOURCE	= $(SRCDIR)/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_DIR	= $(BUILDDIR)/$(KLIBC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

klibc_get: $(STATEDIR)/klibc.get

klibc_get_deps = $(KLIBC_SOURCE)

$(STATEDIR)/klibc.get: $(klibc_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

$(KLIBC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KLIBC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

klibc_extract: $(STATEDIR)/klibc.extract

klibc_extract_deps = $(STATEDIR)/klibc.get

$(STATEDIR)/klibc.extract: $(klibc_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(KLIBC_DIR))
	@$(call extract, $(KLIBC_SOURCE))
	@$(call patchin, $(KLIBC))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

klibc_prepare: $(STATEDIR)/klibc.prepare

#
# dependencies
#
klibc_prepare_deps = \
	$(STATEDIR)/klibc.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel.prepare

KLIBC_PATH	=  PATH=$(CROSS_PATH)
KLIBC_ENV 	=  $(CROSS_ENV)

KLIBC_MAKEVARS	=  ARCH=$(PTXCONF_ARCH)
KLIBC_MAKEVARS	+= CROSS=$(PTXCONF_COMPILER_PREFIX)
KLIBC_MAKEVARS	+= KCROSS=$(PTXCONF_COMPILER_PREFIX)

#
# autoconf
#
KLIBC_AUTOCONF =  $(CROSS_AUTOCONF)
KLIBC_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/klibc.prepare: $(klibc_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(KLIBC_DIR)/config.cache)
ifdef NATIVE
	ln -sf $(KERNEL_HOST_DIR) $(KLIBC_DIR)/linux
else
	ln -sf $(KERNEL_DIR) $(KLIBC_DIR)/linux
endif
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

klibc_compile: $(STATEDIR)/klibc.compile

klibc_compile_deps = $(STATEDIR)/klibc.prepare

$(STATEDIR)/klibc.compile: $(klibc_compile_deps)
	@$(call targetinfo, $@)
	cd $(KLIBC_DIR) && $(KLIBC_ENV) $(KLIBC_PATH) make $(KLIBC_MAKEVARS)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

klibc_install: $(STATEDIR)/klibc.install

$(STATEDIR)/klibc.install: $(STATEDIR)/klibc.compile
	@$(call targetinfo, $@)
	# cd $(KLIBC_DIR) && $(KLIBC_ENV) $(KLIBC_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

klibc_targetinstall: $(STATEDIR)/klibc.targetinstall

klibc_targetinstall_deps = $(STATEDIR)/klibc.compile

$(STATEDIR)/klibc.targetinstall: $(klibc_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,klibc)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(KLIBC_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# @$(call install_copy, 0, 0, 0755, $(KLIBC_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

klibc_clean:
	rm -rf $(STATEDIR)/klibc.*
	rm -rf $(IMAGEDIR)/klibc_*
	rm -rf $(KLIBC_DIR)

# vim: syntax=make
