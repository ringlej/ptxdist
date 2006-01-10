# -*-makefile-*-
# $Id: cppunit.make $
#
# Copyright (C) 2005 by Shahar Livne <shahar@livnex.com>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CPPUNIT) += cppunit

#
# Paths and names
#
CPPUNIT_VERSION	= 1.10.2
CPPUNIT		= cppunit-$(CPPUNIT_VERSION)
CPPUNIT_SUFFIX	= tar.gz
CPPUNIT_URL	= $(PTXCONF_SETUP_SFMIRROR)/cppunit/$(CPPUNIT).$(CPPUNIT_SUFFIX)
CPPUNIT_SOURCE	= $(SRCDIR)/$(CPPUNIT).$(CPPUNIT_SUFFIX)
CPPUNIT_DIR	= $(BUILDDIR)/$(CPPUNIT)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cppunit_get: $(STATEDIR)/cppunit.get

cppunit_get_deps = $(CPPUNIT_SOURCE)

$(STATEDIR)/cppunit.get: $(cppunit_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(CPPUNIT))
	@$(call touch, $@)

$(CPPUNIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CPPUNIT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cppunit_extract: $(STATEDIR)/cppunit.extract

cppunit_extract_deps = $(STATEDIR)/cppunit.get

$(STATEDIR)/cppunit.extract: $(cppunit_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CPPUNIT_DIR))
	@$(call extract, $(CPPUNIT_SOURCE))
	@$(call patchin, $(CPPUNIT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cppunit_prepare: $(STATEDIR)/cppunit.prepare

#
# dependencies
#
cppunit_prepare_deps = \
	$(STATEDIR)/cppunit.extract 
			

CPPUNIT_PATH	=  PATH=$(CROSS_PATH)
CPPUNIT_ENV 	=  $(CROSS_ENV)
#CPPUNIT_ENV	+= 

#
# autoconf
#
CPPUNIT_AUTOCONF = $(CROSS_AUTOCONF_USR)

$(STATEDIR)/cppunit.prepare: $(cppunit_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CPPUNIT_DIR)/config.cache)
	cd $(CPPUNIT_DIR) && \
		$(CPPUNIT_PATH) $(CPPUNIT_ENV) \
		./configure $(CPPUNIT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cppunit_compile: $(STATEDIR)/cppunit.compile

cppunit_compile_deps = $(STATEDIR)/cppunit.prepare

$(STATEDIR)/cppunit.compile: $(cppunit_compile_deps)
	@$(call targetinfo, $@)
	cd $(CPPUNIT_DIR) && $(CPPUNIT_ENV) $(CPPUNIT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cppunit_install: $(STATEDIR)/cppunit.install

$(STATEDIR)/cppunit.install: $(STATEDIR)/cppunit.compile
	@$(call targetinfo, $@)
	@$(call install, CPPUNIT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cppunit_targetinstall: $(STATEDIR)/cppunit.targetinstall

cppunit_targetinstall_deps = $(STATEDIR)/cppunit.install

$(STATEDIR)/cppunit.targetinstall: $(cppunit_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,$(CPPUNIT))
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(CPPUNIT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Shahar Livne <shahar\@livnex.com>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(CPPUNIT_DIR)/src/cppunit/.libs/libcppunit-1.10.so.2.0.0, \
		/usr/lib/libcppunit-1.10.so.2.0.0)

	@$(call install_link, libcppunit-1.10.so.2.0.0, /usr/lib/libcppunit-1.10.so.2)
	@$(call install_link, libcppunit-1.10.so.2.0.0, /usr/lib/libcppunit.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cppunit_clean:
	rm -rf $(STATEDIR)/cppunit.*
	rm -rf $(IMAGEDIR)/cppunit_*
	rm -rf $(CPPUNIT_DIR)

# vim: syntax=make
