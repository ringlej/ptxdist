# -*-makefile-*-
# $Id: valgrind.make $
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
PACKAGES-$(PTXCONF_VALGRIND) += valgrind

#
# Paths and names
#
VALGRIND_VERSION	= 2.4.0
VALGRIND		= valgrind-$(VALGRIND_VERSION)
VALGRIND_SUFFIX		= tar.bz2
VALGRIND_URL		= http://valgrind.org/downloads/$(VALGRIND).$(VALGRIND_SUFFIX)
VALGRIND_SOURCE		= $(SRCDIR)/$(VALGRIND).$(VALGRIND_SUFFIX)
VALGRIND_DIR		= $(BUILDDIR)/$(VALGRIND)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

valgrind_get: $(STATEDIR)/valgrind.get

valgrind_get_deps = $(VALGRIND_SOURCE)

$(STATEDIR)/valgrind.get: $(valgrind_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(VALGRIND))
	@$(call touch, $@)

$(VALGRIND_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(VALGRIND_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

valgrind_extract: $(STATEDIR)/valgrind.extract

valgrind_extract_deps = $(STATEDIR)/valgrind.get

$(STATEDIR)/valgrind.extract: $(valgrind_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(VALGRIND_DIR))
	@$(call extract, $(VALGRIND_SOURCE))
	@$(call patchin, $(VALGRIND))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

valgrind_prepare: $(STATEDIR)/valgrind.prepare

#
# dependencies
#
valgrind_prepare_deps = \
	$(STATEDIR)/valgrind.extract 
			

VALGRIND_PATH	=  PATH=$(CROSS_PATH)
VALGRIND_ENV 	=  $(CROSS_ENV)
#VALGRIND_ENV	+= 

#
# autoconf
#
VALGRIND_AUTOCONF =  $(CROSS_AUTOCONF_USR)

# If --enable-tls is not set, test for TLS fails in cross compiling 
# environment

VALGRIND_AUTOCONF += --enable-tls

$(STATEDIR)/valgrind.prepare: $(valgrind_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(VALGRIND_DIR)/config.cache)
	cd $(VALGRIND_DIR) && \
		$(VALGRIND_PATH) $(VALGRIND_ENV) \
		./configure $(VALGRIND_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

valgrind_compile: $(STATEDIR)/valgrind.compile

valgrind_compile_deps = $(STATEDIR)/valgrind.prepare

$(STATEDIR)/valgrind.compile: $(valgrind_compile_deps)
	@$(call targetinfo, $@)
	cd $(VALGRIND_DIR) && $(VALGRIND_ENV) $(VALGRIND_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

valgrind_install: $(STATEDIR)/valgrind.install

$(STATEDIR)/valgrind.install: $(STATEDIR)/valgrind.compile
	@$(call targetinfo, $@)

	# FIXME: rsc: if --prefix=/, doesn't this install to / on the 
	#             development host? 
	# cd $(VALGRIND_DIR) && $(VALGRIND_PATH) $(MAKE_INSTALL)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

valgrind_targetinstall: $(STATEDIR)/valgrind.targetinstall

valgrind_targetinstall_deps = $(STATEDIR)/valgrind.compile

$(STATEDIR)/valgrind.targetinstall: $(valgrind_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,valgrind)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(VALGRIND_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Shahar Livne <shahar\@livnex.com>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(VALGRIND_DIR)/coregrind/valgrind, /bin/valgrind)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/coregrind/stage2, /lib/valgrind/stage2)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/corecheck/vgskin_corecheck.so, /lib/valgrind/vgskin_corecheck.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/massif/vgskin_massif.so, /lib/valgrind/vgskin_massif.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/massif/vgpreload_massif.so, /lib/valgrind/vgpreload_massif.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/cachegrind/vgskin_cachegrind.so, /lib/valgrind/vgskin_cachegrind.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/none/vgskin_none.so, /lib/valgrind/vgskin_none.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/addrcheck/vgpreload_addrcheck.so, /lib/valgrind/vgpreload_addrcheck.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/addrcheck/vgskin_addrcheck.so, /lib/valgrind/vgskin_addrcheck.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/memcheck/vgpreload_memcheck.so, /lib/valgrind/vgpreload_memcheck.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/memcheck/vgskin_memcheck.so, /lib/valgrind/vgskin_memcheck.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/lackey/vgskin_lackey.so, /lib/valgrind/vgskin_lackey.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/coregrind/vg_inject.so, /lib/valgrind/vg_inject.so)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/default.supp, /lib/valgrind/default.supp)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/glibc-2.3.supp, /lib/valgrind/glibc-2.3.supp)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/glibc-2.2.supp, /lib/valgrind/glibc-2.2.supp)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/glibc-2.1.supp, /lib/valgrind/glibc-2.1.supp)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/xfree-4.supp, /lib/valgrind/xfree-4.supp)
	@$(call install_copy, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/xfree-3.supp, /lib/valgrind/xfree-3.supp)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

valgrind_clean:
	rm -rf $(STATEDIR)/valgrind.*
	rm -rf $(IMAGEDIR)/valgrind_*
	rm -rf $(VALGRIND_DIR)

# vim: syntax=make
