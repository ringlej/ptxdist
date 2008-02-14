# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBELF) += libelf

#
# Paths and names
#
LIBELF_VERSION	:= 0.8.9
LIBELF		:= libelf-$(LIBELF_VERSION)
LIBELF_SUFFIX	:= tar.gz
LIBELF_URL	:= http://www.mr511.de/software/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_SOURCE	:= $(SRCDIR)/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_DIR	:= $(BUILDDIR)/$(LIBELF)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libelf_get: $(STATEDIR)/libelf.get

$(STATEDIR)/libelf.get: $(libelf_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBELF_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBELF)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libelf_extract: $(STATEDIR)/libelf.extract

$(STATEDIR)/libelf.extract: $(libelf_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBELF_DIR))
	@$(call extract, LIBELF)
	@$(call patchin, LIBELF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libelf_prepare: $(STATEDIR)/libelf.prepare

LIBELF_PATH	:= PATH=$(CROSS_PATH)
LIBELF_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBELF_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-nls

$(STATEDIR)/libelf.prepare: $(libelf_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBELF_DIR)/config.cache)
	cd $(LIBELF_DIR) && \
		$(LIBELF_PATH) $(LIBELF_ENV) \
		./configure $(LIBELF_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libelf_compile: $(STATEDIR)/libelf.compile

$(STATEDIR)/libelf.compile: $(libelf_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBELF_DIR) && $(LIBELF_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libelf_install: $(STATEDIR)/libelf.install

$(STATEDIR)/libelf.install: $(libelf_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBELF,,,instroot=$(SYSROOT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libelf_targetinstall: $(STATEDIR)/libelf.targetinstall

$(STATEDIR)/libelf.targetinstall: $(libelf_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libelf_clean:
	rm -rf $(STATEDIR)/libelf.*
	rm -rf $(IMAGEDIR)/libelf_*
	rm -rf $(LIBELF_DIR)

# vim: syntax=make
