# -*-makefile-*-
# $Id: cfgsh.make,v 1.1.1.1 2004/09/22 13:17:02 gby Exp $
#
# Copyright (C) 2005 by Gilad Ben-Yossef <gilad@codefidence.com>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CFGSH) += cfgsh

#
# Paths and names
#
CFGSH_VERSION		= 1.1.2
CFGSH			= cfgsh-$(CFGSH_VERSION)
CFGSH_SUFFIX		= tar.bz2
CFGSH_URL		= $(PTXCONF_SETUP_SFMIRROR)/cfgsh/$(CFGSH).$(CFGSH_SUFFIX)
CFGSH_SOURCE		= $(SRCDIR)/$(CFGSH).$(CFGSH_SUFFIX)
CFGSH_DIR		= $(BUILDDIR)/$(CFGSH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cfgsh_get: $(STATEDIR)/cfgsh.get

cfgsh_get_deps = $(CFGSH_SOURCE)

$(STATEDIR)/cfgsh.get: $(cfgsh_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CFGSH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CFGSH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cfgsh_extract: $(STATEDIR)/cfgsh.extract

cfgsh_extract_deps = $(STATEDIR)/cfgsh.get

$(STATEDIR)/cfgsh.extract: $(cfgsh_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CFGSH_DIR))
	@$(call extract, $(CFGSH_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cfgsh_prepare: $(STATEDIR)/cfgsh.prepare

#
# dependencies
#
cfgsh_prepare_deps = \
	$(STATEDIR)/cfgsh.extract \
	$(STATEDIR)/readline.install \
	$(STATEDIR)/ncurses.install \
	$(STATEDIR)/virtual-xchain.install
			

CFGSH_PATH	=  PATH=$(CROSS_PATH)
CFGSH_ENV 	=  $(CROSS_ENV)
#CFGSH_ENV	+= 

#
# autoconf
#
CFGSH_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \

$(STATEDIR)/cfgsh.prepare: $(cfgsh_prepare_deps)
	@$(call targetinfo, $@)
#	@$(call clean, $(CFGSH_DIR)/config.cache)
#	cd $(CFGSH_DIR) && \
#		$(CFGSH_PATH) $(CFGSH_ENV) \
#		./configure $(CFGSH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cfgsh_compile: $(STATEDIR)/cfgsh.compile

cfgsh_compile_deps = $(STATEDIR)/cfgsh.prepare

$(STATEDIR)/cfgsh.compile: $(cfgsh_compile_deps)
	@$(call targetinfo, $@)
	$(CFGSH_ENV) $(CFGSH_PATH) make -C $(CFGSH_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cfgsh_install: $(STATEDIR)/cfgsh.install

$(STATEDIR)/cfgsh.install: $(STATEDIR)/cfgsh.compile
	@$(call targetinfo, $@)
	# FIXME:
	# @$(call install, CFGSH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cfgsh_targetinstall: $(STATEDIR)/cfgsh.targetinstall

cfgsh_targetinstall_deps = $(STATEDIR)/cfgsh.compile

$(STATEDIR)/cfgsh.targetinstall: $(cfgsh_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,cfgsh)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(CFGSH_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Gilad Ben-Yossef <gilad\@codefidence.com>")
	@$(call install_fixup,DEPENDS, readline)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(CFGSH_DIR)/cfgsh, /bin/cfgsh)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cfgsh_clean:
	rm -rf $(STATEDIR)/cfgsh.*
	rm -rf $(CFGSH_DIR)

# vim: syntax=make
