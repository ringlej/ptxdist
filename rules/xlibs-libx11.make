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
ifdef PTXCONF_XLIBS_LIBX11
PACKAGES += xlibs-libx11
endif

#
# Paths and names
#
XLIBS-LIBX11_VERSION		= 0.99.0
XLIBS-LIBX11_REAL_VERSION	= 6.2.1
XLIBS-LIBX11			= libX11-$(XLIBS-LIBX11_VERSION)
XLIBS-LIBX11_SUFFIX		= tar.bz2
XLIBS-LIBX11_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS-LIBX11).$(XLIBS-LIBX11_SUFFIX)
XLIBS-LIBX11_SOURCE		= $(SRCDIR)/$(XLIBS-LIBX11).$(XLIBS-LIBX11_SUFFIX)
XLIBS-LIBX11_DIR		= $(BUILDDIR)/$(XLIBS-LIBX11)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-libx11_get: $(STATEDIR)/xlibs-libx11.get

xlibs-libx11_get_deps = $(XLIBS-LIBX11_SOURCE)

$(STATEDIR)/xlibs-libx11.get: $(xlibs-libx11_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-LIBX11))
	$(call touch, $@)

$(XLIBS-LIBX11_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-LIBX11_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-libx11_extract: $(STATEDIR)/xlibs-libx11.extract

xlibs-libx11_extract_deps = $(STATEDIR)/xlibs-libx11.get

$(STATEDIR)/xlibs-libx11.extract: $(xlibs-libx11_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-LIBX11_DIR))
	@$(call extract, $(XLIBS-LIBX11_SOURCE))
	@$(call patchin, $(XLIBS-LIBX11))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-libx11_prepare: $(STATEDIR)/xlibs-libx11.prepare

#
# dependencies
#
xlibs-libx11_prepare_deps =  $(STATEDIR)/xlibs-libx11.extract
xlibs-libx11_prepare_deps += $(STATEDIR)/virtual-xchain.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-bigreqsproto.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xproto.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xextproto.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xtrans.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xau.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xcmiscproto.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xdmcp.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-kbproto.install
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-inputproto.install

XLIBS-LIBX11_PATH	=  PATH=$(CROSS_PATH)
XLIBS-LIBX11_ENV 	=  $(CROSS_ENV)
XLIBS-LIBX11_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-LIBX11_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-libx11.prepare: $(xlibs-libx11_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-LIBX11_DIR)/config.cache)
	chmod a+x $(XLIBS-LIBX11_DIR)/configure
	cd $(XLIBS-LIBX11_DIR) && \
		$(XLIBS-LIBX11_PATH) $(XLIBS-LIBX11_ENV) \
		./configure $(XLIBS-LIBX11_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-libx11_compile: $(STATEDIR)/xlibs-libx11.compile

xlibs-libx11_compile_deps = $(STATEDIR)/xlibs-libx11.prepare

$(STATEDIR)/xlibs-libx11.compile: $(xlibs-libx11_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-LIBX11_DIR) && $(XLIBS-LIBX11_ENV) $(XLIBS-LIBX11_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-libx11_install: $(STATEDIR)/xlibs-libx11.install

$(STATEDIR)/xlibs-libx11.install: $(STATEDIR)/xlibs-libx11.compile
	@$(call targetinfo, $@)
	cd $(XLIBS-LIBX11_DIR) && $(XLIBS-LIBX11_ENV) $(XLIBS-LIBX11_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-libx11_targetinstall: $(STATEDIR)/xlibs-libx11.targetinstall

xlibs-libx11_targetinstall_deps = $(STATEDIR)/xlibs-libx11.compile
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-bigreqsproto.targetinstall
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xproto.targetinstall
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xextproto.targetinstall
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xtrans.targetinstall
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xau.targetinstall
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xcmiscproto.targetinstall
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-xdmcp.targetinstall
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-kbproto.targetinstall
xlibs-libx11_prepare_deps += $(STATEDIR)/xlibs-inputproto.targetinstall

$(STATEDIR)/xlibs-libx11.targetinstall: $(xlibs-libx11_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-libx11)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS-LIBX11_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, 					\
		$(XLIBS-LIBX11_DIR)/src/.libs/libX11.so.$(XLIBS-LIBX11_REAL_VERSION), \
		/usr/X11R6/lib/libX11.so.$(XLIBS-LIBX11_REAL_VERSION)		\
	)
	@$(call install_link, /usr/X11R6/lib/libX11.so.$(XLIBS-LIBX11_REAL_VERSION), /usr/X11R6/lib/libX11.so.6)
	@$(call install_link, /usr/X11R6/lib/libX11.so.$(XLIBS-LIBX11_REAL_VERSION), /usr/X11R6/lib/libX11.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-libx11_clean:
	rm -rf $(STATEDIR)/xlibs-libx11.*
	rm -rf $(IMAGEDIR)/xlibs-libx11_*
	rm -rf $(XLIBS-LIBX11_DIR)

# vim: syntax=make
