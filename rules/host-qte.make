# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_QTE) += host-qte

#
# Paths and names
#
HOST_QTE_VERSION	= 3.3.4
HOST_QTE		= qt-embedded-free-$(HOST_QTE_VERSION)
HOST_QTE_SUFFIX		= tar.gz
HOST_QTE_URL		= ftp://ftp.trolltech.com/qt/source/$(HOST_QTE).$(HOST_QTE_SUFFIX)
HOST_QTE_SOURCE		= $(SRCDIR)/$(HOST_QTE).$(HOST_QTE_SUFFIX)
HOST_QTE_DIR		= $(HOST_BUILDDIR)/$(HOST_QTE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-qte_get: $(STATEDIR)/host-qte.get

$(STATEDIR)/host-qte.get: $(host-qte_get_deps_default_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-qte_extract: $(STATEDIR)/host-qte.extract

$(STATEDIR)/host-qte.extract: $(host-qte_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_QTE_DIR))
	@$(call extract, HOST_QTE, $(HOST_BUILDDIR))
	@$(call patchin, $(HOST_QTE), $(HOST_QTE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-qte_prepare: $(STATEDIR)/host-qte.prepare

HOST_QTE_PATH	=  PATH=$(HOST_PATH)
HOST_QTE_ENV 	=  $(HOSTCC_ENV)

#
# qte does not use autoconf, but something that looks similar
#
# disable all we can - we need only uic
HOST_QTE_CONF := -prefix=$(PTXCONF_PREFIX) \
	-platform=$(GNU_HOST) \
	-disable styles \
	-disable tools \
	-disable kernel \
	-disable widgets \
	-disable dialogs \
	-disable iconview \
	-disable workspace \
	-disable network \
	-disable canvas \
	-disable table \
	-disable xml \
	-disable opengl \
	-disable sql \
	-embedded x86 \
	-no-gif \
	-qt-libpng \
	-no-libjpeg \
	-no-thread \
	-no-cups \
	-no-stl \
	-no-qvfb 

$(STATEDIR)/host-qte.prepare: $(host-qte_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_QTE_DIR)/config.cache)
	cd $(HOST_QTE_DIR) && \
		echo yes | $(HOST_QTE_PATH) $(HOST_QTE_ENV) \
		./configure $(HOST_QTE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-qte_compile: $(STATEDIR)/host-qte.compile

$(STATEDIR)/host-qte.compile: $(host-qte_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_QTE_DIR) && $(HOST_QTE_ENV) $(HOST_QTE_PATH) make sub-src
	cd $(HOST_QTE_DIR)/tools/designer/uic && $(HOST_QTE_ENV) $(HOST_QTE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-qte_install: $(STATEDIR)/host-qte.install

$(STATEDIR)/host-qte.install: $(host-qte_install_deps_default)
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/bin
	cp $(HOST_QTE_DIR)/bin/uic $(PTXCONF_PREFIX)/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Tagetinstall
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-qte_clean:
	rm -rf $(STATEDIR)/host-qte.*
	rm -rf $(HOST_QTE_DIR)

# vim: syntax=make
