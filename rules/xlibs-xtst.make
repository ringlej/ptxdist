# -*-makefile-*-
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
ifdef PTXCONF_XLIBS-XTST
PACKAGES += xlibs-xtst
endif

#
# Paths and names
#
XLIBS-XTST_VERSION	= 20041103-1
XLIBS-XTST		= Xtst-$(XLIBS-XTST_VERSION)
XLIBS-XTST_SUFFIX	= tar.bz2
XLIBS-XTST_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-XTST).$(XLIBS-XTST_SUFFIX)
XLIBS-XTST_SOURCE	= $(SRCDIR)/$(XLIBS-XTST).$(XLIBS-XTST_SUFFIX)
XLIBS-XTST_DIR		= $(BUILDDIR)/$(XLIBS-XTST)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xtst_get: $(STATEDIR)/xlibs-xtst.get

xlibs-xtst_get_deps = $(XLIBS-XTST_SOURCE)

$(STATEDIR)/xlibs-xtst.get: $(xlibs-xtst_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-XTST))
	touch $@

$(XLIBS-XTST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-XTST_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xtst_extract: $(STATEDIR)/xlibs-xtst.extract

xlibs-xtst_extract_deps = $(STATEDIR)/xlibs-xtst.get

$(STATEDIR)/xlibs-xtst.extract: $(xlibs-xtst_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XTST_DIR))
	@$(call extract, $(XLIBS-XTST_SOURCE))
	@$(call patchin, $(XLIBS-XTST))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xtst_prepare: $(STATEDIR)/xlibs-xtst.prepare

#
# dependencies
#
xlibs-xtst_prepare_deps =  $(STATEDIR)/xlibs-xtst.extract
xlibs-xtst_prepare_deps += $(STATEDIR)/virtual-xchain.install
xlibs-xtst_prepare_deps += $(STATEDIR)/xlibs-recordext.install

XLIBS-XTST_PATH	=  PATH=$(CROSS_PATH)
XLIBS-XTST_ENV 	=  $(CROSS_ENV)
XLIBS-XTST_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-XTST_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xtst.prepare: $(xlibs-xtst_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XTST_DIR)/config.cache)
	chmod a+x $(XLIBS-XTST_DIR)/configure
	cd $(XLIBS-XTST_DIR) && \
		$(XLIBS-XTST_PATH) $(XLIBS-XTST_ENV) \
		./configure $(XLIBS-XTST_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xtst_compile: $(STATEDIR)/xlibs-xtst.compile

xlibs-xtst_compile_deps = $(STATEDIR)/xlibs-xtst.prepare

$(STATEDIR)/xlibs-xtst.compile: $(xlibs-xtst_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-XTST_DIR) && $(XLIBS-XTST_ENV) $(XLIBS-XTST_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xtst_install: $(STATEDIR)/xlibs-xtst.install

$(STATEDIR)/xlibs-xtst.install: $(STATEDIR)/xlibs-xtst.compile
	@$(call targetinfo, $@)
	cd $(XLIBS-XTST_DIR) && $(XLIBS-XTST_ENV) $(XLIBS-XTST_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xtst_targetinstall: $(STATEDIR)/xlibs-xtst.targetinstall

xlibs-xtst_targetinstall_deps =  $(STATEDIR)/xlibs-xtst.compile
xlibs-xtst_targetinstall_deps += $(STATEDIR)/xlibs-recordext.targetinstall

$(STATEDIR)/xlibs-xtst.targetinstall: $(xlibs-xtst_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-xtst)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS-XTST_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(XLIBS-XTST_DIR)/.libs/libXtst.so.6.2.1,  /usr/X11R6/lib/libXtst.so.6.2.1)
	@$(call install_link, /usr/X11R6/lib/libXtst.so.6.2.1, /usr/X11R6/lib/libXtst.so.6)
	@$(call install_link, /usr/X11R6/lib/libXtst.so.6.2.1, /usr/X11R6/lib/libXtst.6)
	@$(call install_link, /usr/X11R6/lib/libXtst.so.6.2.1, /usr/X11R6/lib/libXtst.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xtst_clean:
	rm -rf $(STATEDIR)/xlibs-xtst.*
	rm -rf $(IMAGEDIR)/xlibs-xtst_*
	rm -rf $(XLIBS-XTST_DIR)

# vim: syntax=make
