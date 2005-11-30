# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by BSP
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SETSERIAL) += setserial

#
# Paths and names
#
SETSERIAL_VERSION	= 2.17
SETSERIAL		= setserial-$(SETSERIAL_VERSION)
SETSERIAL_SUFFIX	= tar.gz
SETSERIAL_URL		= $(PTXCONF_SETUP_SFMIRROR)/setserial/$(SETSERIAL).$(SETSERIAL_SUFFIX)
SETSERIAL_SOURCE	= $(SRCDIR)/$(SETSERIAL).$(SETSERIAL_SUFFIX)
SETSERIAL_DIR		= $(BUILDDIR)/$(SETSERIAL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

setserial_get: $(STATEDIR)/setserial.get

setserial_get_deps = $(SETSERIAL_SOURCE)

$(STATEDIR)/setserial.get: $(setserial_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SETSERIAL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SETSERIAL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

setserial_extract: $(STATEDIR)/setserial.extract

setserial_extract_deps = $(STATEDIR)/setserial.get

$(STATEDIR)/setserial.extract: $(setserial_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SETSERIAL_DIR))
	@$(call extract, $(SETSERIAL_SOURCE))
	@$(call patchin, $(SETSERIAL))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

setserial_prepare: $(STATEDIR)/setserial.prepare

#
# dependencies
#
setserial_prepare_deps = \
	$(STATEDIR)/setserial.extract \
	$(STATEDIR)/virtual-xchain.install

SETSERIAL_PATH	=  PATH=$(CROSS_PATH)
SETSERIAL_ENV 	=  $(CROSS_ENV)
SETSERIAL_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
SETSERIAL_AUTOCONF =  $(CROSS_AUTOCONF)
SETSERIAL_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/setserial.prepare: $(setserial_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SETSERIAL_DIR)/config.cache)
	cd $(SETSERIAL_DIR) && \
		$(SETSERIAL_PATH) $(SETSERIAL_ENV) \
		./configure $(SETSERIAL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

setserial_compile: $(STATEDIR)/setserial.compile

setserial_compile_deps = $(STATEDIR)/setserial.prepare

$(STATEDIR)/setserial.compile: $(setserial_compile_deps)
	@$(call targetinfo, $@)
	cd $(SETSERIAL_DIR) && $(SETSERIAL_ENV) $(SETSERIAL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

setserial_install: $(STATEDIR)/setserial.install

$(STATEDIR)/setserial.install: $(STATEDIR)/setserial.compile
	@$(call targetinfo, $@)
	mkdir -p $(CROSS_LIB_DIR)/usr/man/man8
	cd $(SETSERIAL_DIR) && $(SETSERIAL_ENV) $(SETSERIAL_PATH) make DESTDIR=$(CROSS_LIB_DIR) install
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

setserial_targetinstall: $(STATEDIR)/setserial.targetinstall

setserial_targetinstall_deps = $(STATEDIR)/setserial.compile

$(STATEDIR)/setserial.targetinstall: $(setserial_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,setserial)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SETSERIAL_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Benedikt Spranger <b.spranger\@linutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(SETSERIAL_DIR)/setserial, /bin/setserial)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

setserial_clean:
	rm -rf $(STATEDIR)/setserial.*
	rm -rf $(IMAGEDIR)/setserial_*
	rm -rf $(SETSERIAL_DIR)

# vim: syntax=make
