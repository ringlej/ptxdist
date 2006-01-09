# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_GMP3) += gmp3

#
# Paths and names 
#
GMP3_VERSION	= 3.1.1
GMP3		= gmp-$(GMP3_VERSION)
GMP3_SUFFIX	= tar.gz
GMP3_URL	= $(PTXCONF_SETUP_GNUMIRROR)/gmp/$(GMP3).$(GMP3_SUFFIX)
GMP3_SOURCE	= $(SRCDIR)/$(GMP3).$(GMP3_SUFFIX)
GMP3_DIR 	= $(BUILDDIR)/$(GMP3)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gmp3_get: $(STATEDIR)/gmp3.get

$(STATEDIR)/gmp3.get: $(GMP3_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(GMP3_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GMP3_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gmp3_extract: $(STATEDIR)/gmp3.extract

$(STATEDIR)/gmp3.extract: $(STATEDIR)/gmp3.get
	@$(call targetinfo, $@)
	@$(call clean, $(GMP3_DIR))
	@$(call extract, $(GMP3_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gmp3_prepare: $(STATEDIR)/gmp3.prepare

gmp3_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/gmp3.extract

GMP3_PATH	= PATH=$(CROSS_PATH)
GMP3_ENV	= $(CROSS_ENV)

GMP3_AUTOCONF =  $(CROSS_AUTOCONF_USR)
GMP3_AUTOCONF += --enable-shared
GMP3_AUTOCONF += --enable-static

$(STATEDIR)/gmp3.prepare: $(gmp3_prepare_deps)
	@$(call targetinfo, $@)
	cd $(GMP3_DIR) && \
		$(GMP3_PATH) $(GMP3_ENV) \
		./configure $(GMP3_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gmp3_compile: $(STATEDIR)/gmp3.compile

$(STATEDIR)/gmp3.compile: $(STATEDIR)/gmp3.prepare 
	@$(call targetinfo, $@)
	$(GMP3_PATH) make -C $(GMP3_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gmp3_install: $(STATEDIR)/gmp3.install

$(STATEDIR)/gmp3.install: $(STATEDIR)/gmp3.compile
	@$(call targetinfo, $@)
	@$(call install, GMP3)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gmp3_targetinstall: $(STATEDIR)/gmp3.targetinstall

$(STATEDIR)/gmp3.targetinstall: $(STATEDIR)/gmp3.install
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gmp3)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GMP3_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	# FIXME: RSC: check if wildcard copy works
	@$(call install_copy, 0, 0, 0644, $(CROSS_LIB_DIR)/lib/libgmp.so*, /usr/lib/)

	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gmp3_clean: 
	rm -rf $(STATEDIR)/gmp3.* 
	rm -rf $(IMAGEDIR)/gmp3_* 
	rm -rf $(GMP3_DIR)

# vim: syntax=make
