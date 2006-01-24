# -*-makefile-*-
# $Id: template 3502 2005-12-11 12:46:17Z rsc $
#
# Copyright (C) 2006 by Bjoern Buerger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBLOCKFILE) += liblockfile

#
# Paths and names
#
LIBLOCKFILE_VERSION	= 1.06
LIBLOCKFILE		= liblockfile_$(LIBLOCKFILE_VERSION)
LIBLOCKFILE_SUFFIX	= tar.gz
LIBLOCKFILE_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/libl/liblockfile/$(LIBLOCKFILE).$(LIBLOCKFILE_SUFFIX)
LIBLOCKFILE_SOURCE	= $(SRCDIR)/$(LIBLOCKFILE).$(LIBLOCKFILE_SUFFIX)
LIBLOCKFILE_DIR		= $(BUILDDIR)/liblockfile-$(LIBLOCKFILE_VERSION)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

liblockfile_get: $(STATEDIR)/liblockfile.get

$(STATEDIR)/liblockfile.get: $(liblockfile_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBLOCKFILE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBLOCKFILE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

liblockfile_extract: $(STATEDIR)/liblockfile.extract

$(STATEDIR)/liblockfile.extract: $(liblockfile_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBLOCKFILE_DIR))
	@$(call extract, $(LIBLOCKFILE_SOURCE))
	@$(call patchin, $(LIBLOCKFILE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

liblockfile_prepare: $(STATEDIR)/liblockfile.prepare

LIBLOCKFILE_PATH	=  PATH=$(CROSS_PATH)
LIBLOCKFILE_ENV 	=  $(CROSS_ENV)
LIBLOCKFILE_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
LIBLOCKFILE_AUTOCONF =  $(CROSS_AUTOCONF)
LIBLOCKFILE_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/liblockfile.prepare: $(liblockfile_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBLOCKFILE_DIR)/config.cache)
	cd $(LIBLOCKFILE_DIR) && \
		$(LIBLOCKFILE_PATH) $(LIBLOCKFILE_ENV) \
		./configure $(LIBLOCKFILE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

liblockfile_compile: $(STATEDIR)/liblockfile.compile

$(STATEDIR)/liblockfile.compile: $(liblockfile_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBLOCKFILE_DIR) && $(LIBLOCKFILE_ENV) $(LIBLOCKFILE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

liblockfile_install: $(STATEDIR)/liblockfile.install

$(STATEDIR)/liblockfile.install: $(liblockfile_install_deps)
	@$(call targetinfo, $@)
	@$(call install, LIBLOCKFILE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

liblockfile_targetinstall: $(STATEDIR)/liblockfile.targetinstall

$(STATEDIR)/liblockfile.targetinstall: $(liblockfile_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,liblockfile)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBLOCKFILE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Bjoern Buerger <b.buerger\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(LIBLOCKFILE_DIR)/dotlockfile, /bin/dotlockfile)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liblockfile_clean:
	rm -rf $(STATEDIR)/liblockfile.*
	rm -rf $(IMAGEDIR)/liblockfile_*
	rm -rf $(LIBLOCKFILE_DIR)

# vim: syntax=make
