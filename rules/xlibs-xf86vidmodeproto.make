# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_XLIBS_PROTO_XF86VIDMODEPROTO
PACKAGES += xlibs-xf86vidmodeproto
endif

#
# Paths and names
#
XLIBS_XF86VIDMODEPROTO_VERSION	= 2.2
XLIBS_XF86VIDMODEPROTO		= xf86vidmodeproto-$(XLIBS_XF86VIDMODEPROTO_VERSION)
XLIBS_XF86VIDMODEPROTO_SUFFIX	= tar.bz2
XLIBS_XF86VIDMODEPROTO_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_XF86VIDMODEPROTO).$(XLIBS_XF86VIDMODEPROTO_SUFFIX)
XLIBS_XF86VIDMODEPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_XF86VIDMODEPROTO).$(XLIBS_XF86VIDMODEPROTO_SUFFIX)
XLIBS_XF86VIDMODEPROTO_DIR	= $(BUILDDIR)/$(XLIBS_XF86VIDMODEPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xf86vidmodeproto_get: $(STATEDIR)/xlibs-xf86vidmodeproto.get

xlibs-xf86vidmodeproto_get_deps = $(XLIBS_XF86VIDMODEPROTO_SOURCE)

$(STATEDIR)/xlibs-xf86vidmodeproto.get: $(xlibs-xf86vidmodeproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XF86VIDMODEPROTO))
	$(call touch, $@)

$(XLIBS_XF86VIDMODEPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XF86VIDMODEPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xf86vidmodeproto_extract: $(STATEDIR)/xlibs-xf86vidmodeproto.extract

xlibs-xf86vidmodeproto_extract_deps = $(STATEDIR)/xlibs-xf86vidmodeproto.get

$(STATEDIR)/xlibs-xf86vidmodeproto.extract: $(xlibs-xf86vidmodeproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86VIDMODEPROTO_DIR))
	@$(call extract, $(XLIBS_XF86VIDMODEPROTO_SOURCE))
	@$(call patchin, $(XLIBS_XF86VIDMODEPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xf86vidmodeproto_prepare: $(STATEDIR)/xlibs-xf86vidmodeproto.prepare

#
# dependencies
#
xlibs-xf86vidmodeproto_prepare_deps = \
	$(STATEDIR)/xlibs-xf86vidmodeproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XF86VIDMODEPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XF86VIDMODEPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_XF86VIDMODEPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XF86VIDMODEPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XF86VIDMODEPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xf86vidmodeproto.prepare: $(xlibs-xf86vidmodeproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86VIDMODEPROTO_DIR)/config.cache)
	cd $(XLIBS_XF86VIDMODEPROTO_DIR) && \
		$(XLIBS_XF86VIDMODEPROTO_PATH) $(XLIBS_XF86VIDMODEPROTO_ENV) \
		./configure $(XLIBS_XF86VIDMODEPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xf86vidmodeproto_compile: $(STATEDIR)/xlibs-xf86vidmodeproto.compile

xlibs-xf86vidmodeproto_compile_deps = $(STATEDIR)/xlibs-xf86vidmodeproto.prepare

$(STATEDIR)/xlibs-xf86vidmodeproto.compile: $(xlibs-xf86vidmodeproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86VIDMODEPROTO_DIR) && $(XLIBS_XF86VIDMODEPROTO_ENV) $(XLIBS_XF86VIDMODEPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xf86vidmodeproto_install: $(STATEDIR)/xlibs-xf86vidmodeproto.install

$(STATEDIR)/xlibs-xf86vidmodeproto.install: $(STATEDIR)/xlibs-xf86vidmodeproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86VIDMODEPROTO_DIR) && $(XLIBS_XF86VIDMODEPROTO_ENV) $(XLIBS_XF86VIDMODEPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xf86vidmodeproto_targetinstall: $(STATEDIR)/xlibs-xf86vidmodeproto.targetinstall

xlibs-xf86vidmodeproto_targetinstall_deps = $(STATEDIR)/xlibs-xf86vidmodeproto.compile

$(STATEDIR)/xlibs-xf86vidmodeproto.targetinstall: $(xlibs-xf86vidmodeproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-xf86vidmodeproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_XF86VIDMODEPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_XF86VIDMODEPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xf86vidmodeproto_clean:
	rm -rf $(STATEDIR)/xlibs-xf86vidmodeproto.*
	rm -rf $(IMAGEDIR)/xlibs-xf86vidmodeproto_*
	rm -rf $(XLIBS_XF86VIDMODEPROTO_DIR)

# vim: syntax=make
