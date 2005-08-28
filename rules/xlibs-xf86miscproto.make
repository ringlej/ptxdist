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
ifdef PTXCONF_XLIBS_PROTO_XF86MISCPROTO
PACKAGES += xlibs-xf86miscproto
endif

#
# Paths and names
#
XLIBS_XF86MISCPROTO_VERSION	= 0.9
XLIBS_XF86MISCPROTO		= xf86miscproto-$(XLIBS_XF86MISCPROTO_VERSION)
XLIBS_XF86MISCPROTO_SUFFIX	= tar.bz2
XLIBS_XF86MISCPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_XF86MISCPROTO).$(XLIBS_XF86MISCPROTO_SUFFIX)
XLIBS_XF86MISCPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_XF86MISCPROTO).$(XLIBS_XF86MISCPROTO_SUFFIX)
XLIBS_XF86MISCPROTO_DIR		= $(BUILDDIR)/$(XLIBS_XF86MISCPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xf86miscproto_get: $(STATEDIR)/xlibs-xf86miscproto.get

xlibs-xf86miscproto_get_deps = $(XLIBS_XF86MISCPROTO_SOURCE)

$(STATEDIR)/xlibs-xf86miscproto.get: $(xlibs-xf86miscproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XF86MISCPROTO))
	$(call touch, $@)

$(XLIBS_XF86MISCPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XF86MISCPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xf86miscproto_extract: $(STATEDIR)/xlibs-xf86miscproto.extract

xlibs-xf86miscproto_extract_deps = $(STATEDIR)/xlibs-xf86miscproto.get

$(STATEDIR)/xlibs-xf86miscproto.extract: $(xlibs-xf86miscproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86MISCPROTO_DIR))
	@$(call extract, $(XLIBS_XF86MISCPROTO_SOURCE))
	@$(call patchin, $(XLIBS_XF86MISCPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xf86miscproto_prepare: $(STATEDIR)/xlibs-xf86miscproto.prepare

#
# dependencies
#
xlibs-xf86miscproto_prepare_deps = \
	$(STATEDIR)/xlibs-xf86miscproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XF86MISCPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XF86MISCPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_XF86MISCPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XF86MISCPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XF86MISCPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xf86miscproto.prepare: $(xlibs-xf86miscproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86MISCPROTO_DIR)/config.cache)
	cd $(XLIBS_XF86MISCPROTO_DIR) && \
		$(XLIBS_XF86MISCPROTO_PATH) $(XLIBS_XF86MISCPROTO_ENV) \
		./configure $(XLIBS_XF86MISCPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xf86miscproto_compile: $(STATEDIR)/xlibs-xf86miscproto.compile

xlibs-xf86miscproto_compile_deps = $(STATEDIR)/xlibs-xf86miscproto.prepare

$(STATEDIR)/xlibs-xf86miscproto.compile: $(xlibs-xf86miscproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86MISCPROTO_DIR) && $(XLIBS_XF86MISCPROTO_ENV) $(XLIBS_XF86MISCPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xf86miscproto_install: $(STATEDIR)/xlibs-xf86miscproto.install

$(STATEDIR)/xlibs-xf86miscproto.install: $(STATEDIR)/xlibs-xf86miscproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86MISCPROTO_DIR) && $(XLIBS_XF86MISCPROTO_ENV) $(XLIBS_XF86MISCPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xf86miscproto_targetinstall: $(STATEDIR)/xlibs-xf86miscproto.targetinstall

xlibs-xf86miscproto_targetinstall_deps = $(STATEDIR)/xlibs-xf86miscproto.compile

$(STATEDIR)/xlibs-xf86miscproto.targetinstall: $(xlibs-xf86miscproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-xf86miscproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_XF86MISCPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_XF86MISCPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xf86miscproto_clean:
	rm -rf $(STATEDIR)/xlibs-xf86miscproto.*
	rm -rf $(IMAGEDIR)/xlibs-xf86miscproto_*
	rm -rf $(XLIBS_XF86MISCPROTO_DIR)

# vim: syntax=make
