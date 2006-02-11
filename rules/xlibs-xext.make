# -*-makefile-*-
#
# $Id$
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
PACKAGES-$(PTXCONF_XLIBS-XEXT) += xlibs-xext

#
# Paths and names
#
XLIBS-XEXT_VERSION	= 20041103-1
XLIBS-XEXT_REAL_VERSION	= 6.4.1
XLIBS-XEXT		= Xext-$(XLIBS-XEXT_VERSION)
XLIBS-XEXT_SUFFIX	= tar.bz2
XLIBS-XEXT_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-XEXT).$(XLIBS-XEXT_SUFFIX)
XLIBS-XEXT_SOURCE	= $(SRCDIR)/$(XLIBS-XEXT).$(XLIBS-XEXT_SUFFIX)
XLIBS-XEXT_DIR		= $(BUILDDIR)/$(XLIBS-XEXT)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xext_get: $(STATEDIR)/xlibs-xext.get

$(STATEDIR)/xlibs-xext.get: $(xlibs-xext_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XLIBS-XEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-XEXT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xext_extract: $(STATEDIR)/xlibs-xext.extract

$(STATEDIR)/xlibs-xext.extract: $(xlibs-xext_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XEXT_DIR))
	@$(call extract, $(XLIBS-XEXT_SOURCE))
	@$(call patchin, $(XLIBS-XEXT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xext_prepare: $(STATEDIR)/xlibs-xext.prepare

XLIBS-XEXT_PATH	=  PATH=$(CROSS_PATH)
XLIBS-XEXT_ENV 	=  $(CROSS_ENV)
XLIBS-XEXT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-XEXT_AUTOCONF =  --build=$(GNU_HOST)
XLIBS-XEXT_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/xlibs-xext.prepare: $(xlibs-xext_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XEXT_DIR)/config.cache)
	chmod a+x $(XLIBS-XEXT_DIR)/configure
	cd $(XLIBS-XEXT_DIR) && \
		$(XLIBS-XEXT_PATH) $(XLIBS-XEXT_ENV) \
		./configure $(XLIBS-XEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xext_compile: $(STATEDIR)/xlibs-xext.compile

$(STATEDIR)/xlibs-xext.compile: $(xlibs-xext_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XLIBS-XEXT_DIR) && $(XLIBS-XEXT_ENV) $(XLIBS-XEXT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xext_install: $(STATEDIR)/xlibs-xext.install

$(STATEDIR)/xlibs-xext.install: $(xlibs-xext_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XLIBS-XEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xext_targetinstall: $(STATEDIR)/xlibs-xext.targetinstall

$(STATEDIR)/xlibs-xext.targetinstall: $(xlibs-xext_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,coreutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(COREUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_root, 0, 0, 0644, \
		$(XLIBS-XEXT_DIR)/.libs/libXext.so.$(XLIBS-XEXT_REAL_VERSION),  \
		/usr/X11R6/lib/libXext.so.$(XLIBS-XEXT_REAL_VERSION))

	@$(call install_link, /usr/X11R6/lib/libXext.so.$(XLIBS-XEXT_REAL_VERSION), /usr/X11R6/lib/libXext.so.6)
	@$(call install_link, /usr/X11R6/lib/libXext.so.$(XLIBS-XEXT_REAL_VERSION), /usr/X11R6/lib/libXext.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xext_clean:
	rm -rf $(STATEDIR)/xlibs-xext.*
	rm -rf $(IMAGEDIR)/xlibs-xext_*
	rm -rf $(XLIBS-XEXT_DIR)

# vim: syntax=make
