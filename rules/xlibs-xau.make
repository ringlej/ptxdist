# -*-makefile-*-
#
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_XLIBS-XAU
PACKAGES += xlibs-xau
endif

#
# Paths and names
#
XLIBS-XAU_VERSION	= 20041103-1
XLIBS-XAU		= Xau-$(XLIBS-XAU_VERSION)
XLIBS-XAU_SUFFIX	= tar.bz2
XLIBS-XAU_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-XAU).$(XLIBS-XAU_SUFFIX)
XLIBS-XAU_SOURCE	= $(SRCDIR)/$(XLIBS-XAU).$(XLIBS-XAU_SUFFIX)
XLIBS-XAU_DIR		= $(BUILDDIR)/$(XLIBS-XAU)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xau_get: $(STATEDIR)/xlibs-xau.get

xlibs-xau_get_deps = $(XLIBS-XAU_SOURCE)

$(STATEDIR)/xlibs-xau.get: $(xlibs-xau_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-XAU))
	$(call touch, $@)

$(XLIBS-XAU_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-XAU_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xau_extract: $(STATEDIR)/xlibs-xau.extract

xlibs-xau_extract_deps = $(STATEDIR)/xlibs-xau.get

$(STATEDIR)/xlibs-xau.extract: $(xlibs-xau_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XAU_DIR))
	@$(call extract, $(XLIBS-XAU_SOURCE))
	@$(call patchin, $(XLIBS-XAU))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xau_prepare: $(STATEDIR)/xlibs-xau.prepare

#
# dependencies
#
xlibs-xau_prepare_deps =  $(STATEDIR)/xlibs-xau.extract
xlibs-xau_prepare_deps += $(STATEDIR)/virtual-xchain.install

XLIBS-XAU_PATH	=  PATH=$(CROSS_PATH)
XLIBS-XAU_ENV 	=  $(CROSS_ENV)
XLIBS-XAU_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-XAU_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xau.prepare: $(xlibs-xau_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XAU_DIR)/config.cache)
	chmod a+x $(XLIBS-XAU_DIR)/configure
	cd $(XLIBS-XAU_DIR) && \
		$(XLIBS-XAU_PATH) $(XLIBS-XAU_ENV) \
		./configure $(XLIBS-XAU_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xau_compile: $(STATEDIR)/xlibs-xau.compile

xlibs-xau_compile_deps = $(STATEDIR)/xlibs-xau.prepare

$(STATEDIR)/xlibs-xau.compile: $(xlibs-xau_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-XAU_DIR) && $(XLIBS-XAU_ENV) $(XLIBS-XAU_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xau_install: $(STATEDIR)/xlibs-xau.install

$(STATEDIR)/xlibs-xau.install: $(STATEDIR)/xlibs-xau.compile
	@$(call targetinfo, $@)
	cd $(XLIBS-XAU_DIR) && $(XLIBS-XAU_ENV) $(XLIBS-XAU_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xau_targetinstall: $(STATEDIR)/xlibs-xau.targetinstall

xlibs-xau_targetinstall_deps = $(STATEDIR)/xlibs-xau.compile

$(STATEDIR)/xlibs-xau.targetinstall: $(xlibs-xau_targetinstall_deps)
	@$(call targetinfo, $@)
	
	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-xau)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_XAU_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0644, $(XLIBS-XAU_DIR)/.libs/libXau.so.0.0.0,  /usr/X11R6/lib/libXau.so.0.0.0)
	@$(call install_link, /usr/X11R6/lib/libXau.so.0.0.0, /usr/X11R6/lib/libXau.so.0)
	@$(call install_link, /usr/X11R6/lib/libXau.so.0.0.0, /usr/X11R6/lib/libXau.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xau_clean:
	rm -rf $(STATEDIR)/xlibs-xau.*
	rm -rf $(IMAGEDIR)/xlibs-xau_*
	rm -rf $(XLIBS-XAU_DIR)

# vim: syntax=make
