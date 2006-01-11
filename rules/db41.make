# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Werner Schmitt mail2ws@gmx.de
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DB41) += db41

#
# Paths and names
#
DB41_VERSION	= 4.1.25.NC
DB41		= db-$(DB41_VERSION)
DB41_SUFFIX	= tar.gz
DB41_URL	= http://www.sleepycat.com/update/snapshot/$(DB41).$(DB41_SUFFIX)
DB41_SOURCE	= $(SRCDIR)/$(DB41).$(DB41_SUFFIX)
DB41_DIR	= $(BUILDDIR)/$(DB41)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

db41_get: $(STATEDIR)/db41.get

db41_get_deps	=  $(DB41_SOURCE)

$(STATEDIR)/db41.get: $(db41_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DB41_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(DB41_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

db41_extract: $(STATEDIR)/db41.extract

$(STATEDIR)/db41.extract: $(db41_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DB41_DIR))
	@$(call extract, $(DB41_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

db41_prepare: $(STATEDIR)/db41.prepare

DB41_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
DB41_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
DB41_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
DB41_AUTOCONF	+= --enable-cxx 

$(STATEDIR)/db41.prepare: $(db41_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DB41_BUILDDIR))
	cd $(DB41_DIR)/dist && \
		$(DB41_PATH) $(DB41_ENV) \
		./configure $(DB41_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

db41_compile: $(STATEDIR)/db41.compile

$(STATEDIR)/db41.compile: $(db41_compile_deps_default)
	@$(call targetinfo, $@)
	$(DB41_PATH) $(DB41_ENV) make -C $(DB41_DIR)/dist
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

db41_install: $(STATEDIR)/db41.install

$(STATEDIR)/db41.install: $(db41_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	# @$(call install, DB41)
	$(DB41_PATH) $(DB41_ENV) make -C $(DB41_DIR)/dist install
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

db41_targetinstall: $(STATEDIR)/db41.targetinstall

$(STATEDIR)/db41.targetinstall: $(db41_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,db41)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(DB41_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	# FIXME: RSC: the wildcard will probably break; fix when needed :-) 
	# FIXME: RSC: use correct paths from the build directories
	@$(call install_copy, 0, 0, 0755, $(CROSS_LIB_DIR)/bin/db_*, /usr/bin/)
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/lib/libdb*.so*, /usr/lib/)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

db41_clean:
	rm -rf $(STATEDIR)/db41.*
	rm -rf $(IMAGEDIR)/db41_*
	rm -rf $(DB41_DIR)

# vim: syntax=make
