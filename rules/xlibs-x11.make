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
PACKAGES-$(PTXCONF_XLIBS-X11) += xlibs-x11

#
# Paths and names
#
XLIBS-X11_VERSION	= 20041103-1
XLIBS-X11_REAL_VERSION	= 6.2.1
XLIBS-X11		= libX11-$(XLIBS-X11_VERSION)
XLIBS-X11_SUFFIX	= tar.bz2
XLIBS-X11_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-X11).$(XLIBS-X11_SUFFIX)
XLIBS-X11_SOURCE	= $(SRCDIR)/$(XLIBS-X11).$(XLIBS-X11_SUFFIX)
XLIBS-X11_DIR		= $(BUILDDIR)/$(XLIBS-X11)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-x11_get: $(STATEDIR)/xlibs-x11.get

$(STATEDIR)/xlibs-x11.get: $(xlibs-x11_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-X11))
	@$(call touch, $@)

$(XLIBS-X11_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-X11_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-x11_extract: $(STATEDIR)/xlibs-x11.extract

$(STATEDIR)/xlibs-x11.extract: $(xlibs-x11_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-X11_DIR))
	@$(call extract, $(XLIBS-X11_SOURCE))
	@$(call patchin, $(XLIBS-X11))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-x11_prepare: $(STATEDIR)/xlibs-x11.prepare

XLIBS-X11_PATH	=  PATH=$(CROSS_PATH)
XLIBS-X11_ENV 	=  $(CROSS_ENV)
XLIBS-X11_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-X11_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) 

$(STATEDIR)/xlibs-x11.prepare: $(xlibs-x11_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-X11_DIR)/config.cache)
	chmod a+x $(XLIBS-X11_DIR)/configure
	cd $(XLIBS-X11_DIR) && \
		$(XLIBS-X11_PATH) $(XLIBS-X11_ENV) \
		./configure $(XLIBS-X11_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-x11_compile: $(STATEDIR)/xlibs-x11.compile

$(STATEDIR)/xlibs-x11.compile: $(xlibs-x11_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XLIBS-X11_DIR) && $(XLIBS-X11_ENV) $(XLIBS-X11_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-x11_install: $(STATEDIR)/xlibs-x11.install

$(STATEDIR)/xlibs-x11.install: $(xlibs-x11_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XLIBS-X11)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-x11_targetinstall: $(STATEDIR)/xlibs-x11.targetinstall

$(STATEDIR)/xlibs-x11.targetinstall: $(xlibs-x11_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-x11)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS-X11_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, 					\
		$(XLIBS-X11_DIR)/src/.libs/libX11.so.$(XLIBS-X11_REAL_VERSION), \
		/usr/X11R6/lib/libX11.so.$(XLIBS-X11_REAL_VERSION)		\
	)
	@$(call install_link, /usr/X11R6/lib/libX11.so.$(XLIBS-X11_REAL_VERSION), /usr/X11R6/lib/libX11.so.6)
	@$(call install_link, /usr/X11R6/lib/libX11.so.$(XLIBS-X11_REAL_VERSION), /usr/X11R6/lib/libX11.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-x11_clean:
	rm -rf $(STATEDIR)/xlibs-x11.*
	rm -rf $(IMAGEDIR)/xlibs-x11_*
	rm -rf $(XLIBS-X11_DIR)

# vim: syntax=make
