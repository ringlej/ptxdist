# -*-makefile-*-
# $Id: gmp4.make 3574 2005-12-27 11:46:41Z rsc $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this packet
#
PACKAGES-$(PTXCONF_GMP4) += gmp4

#
# Paths and names 
#
GMP4_VERSION	= 4.1.4
GMP4		= gmp-$(GMP4_VERSION)
GMP4_SUFFIX	= tar.gz
GMP4_URL	= $(PTXCONF_SETUP_GNUMIRROR)/gmp/$(GMP4).$(GMP4_SUFFIX)
GMP4_SOURCE	= $(SRCDIR)/$(GMP4).$(GMP4_SUFFIX)
GMP4_DIR 	= $(BUILDDIR)/$(GMP4)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gmp4_get: $(STATEDIR)/gmp4.get

$(STATEDIR)/gmp4.get: $(gmp4_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GMP4_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GMP4_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gmp4_extract: $(STATEDIR)/gmp4.extract

$(STATEDIR)/gmp4.extract: $(gmp4_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GMP4_DIR))
	@$(call extract, $(GMP4_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gmp4_prepare: $(STATEDIR)/gmp4.prepare

GMP4_PATH	= PATH=$(CROSS_PATH)
GMP4_ENV	= $(CROSS_ENV)

GMP4_AUTOCONF =  $(CROSS_AUTOCONF_USR)
GMP4_AUTOCONF += --enable-shared
GMP4_AUTOCONF += --enable-static

$(STATEDIR)/gmp4.prepare: $(gmp4_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(GMP4_DIR) && \
		$(GMP4_PATH) $(GMP4_ENV) \
		./configure $(GMP4_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gmp4_compile: $(STATEDIR)/gmp4.compile

$(STATEDIR)/gmp4.compile: $(gmp4_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(GMP4_DIR) && $(GMP4_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gmp4_install: $(STATEDIR)/gmp4.install

$(STATEDIR)/gmp4.install: $(gmp4_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, GMP4)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gmp4_targetinstall: $(STATEDIR)/gmp4.targetinstall

$(STATEDIR)/gmp4.targetinstall: $(gmp4_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gmp4)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GMP4_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(GMP4_DIR)/.libs/libgmp.so.3.3.3, \
		/usr/lib/libgmp.so.3.3.3)

	@$(call install_link, libgmp.so.3.3.3, /usr/lib/libgmp.so.3)
	@$(call install_link, libgmp.so.3.3.3, /usr/lib/libgmp.so)

	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gmp4_clean: 
	rm -rf $(STATEDIR)/gmp4.* 
	rm -rf $(IMAGEDIR)/gmp4_* 
	rm -rf $(GMP4_DIR)

# vim: syntax=make
