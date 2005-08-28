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
ifdef PTXCONF_XLIBS_PROTO_XF86DGAPROTO
PACKAGES += xlibs-xf86dgaproto
endif

#
# Paths and names
#
XLIBS_XF86DGAPROTO_VERSION	= 2.0
XLIBS_XF86DGAPROTO		= xf86dgaproto-$(XLIBS_XF86DGAPROTO_VERSION)
XLIBS_XF86DGAPROTO_SUFFIX	= tar.bz2
XLIBS_XF86DGAPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_XF86DGAPROTO).$(XLIBS_XF86DGAPROTO_SUFFIX)
XLIBS_XF86DGAPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_XF86DGAPROTO).$(XLIBS_XF86DGAPROTO_SUFFIX)
XLIBS_XF86DGAPROTO_DIR		= $(BUILDDIR)/$(XLIBS_XF86DGAPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xf86dgaproto_get: $(STATEDIR)/xlibs-xf86dgaproto.get

xlibs-xf86dgaproto_get_deps = $(XLIBS_XF86DGAPROTO_SOURCE)

$(STATEDIR)/xlibs-xf86dgaproto.get: $(xlibs-xf86dgaproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XF86DGAPROTO))
	$(call touch, $@)

$(XLIBS_XF86DGAPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XF86DGAPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xf86dgaproto_extract: $(STATEDIR)/xlibs-xf86dgaproto.extract

xlibs-xf86dgaproto_extract_deps = $(STATEDIR)/xlibs-xf86dgaproto.get

$(STATEDIR)/xlibs-xf86dgaproto.extract: $(xlibs-xf86dgaproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86DGAPROTO_DIR))
	@$(call extract, $(XLIBS_XF86DGAPROTO_SOURCE))
	@$(call patchin, $(XLIBS_XF86DGAPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xf86dgaproto_prepare: $(STATEDIR)/xlibs-xf86dgaproto.prepare

#
# dependencies
#
xlibs-xf86dgaproto_prepare_deps = \
	$(STATEDIR)/xlibs-xf86dgaproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XF86DGAPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XF86DGAPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_XF86DGAPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XF86DGAPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XF86DGAPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xf86dgaproto.prepare: $(xlibs-xf86dgaproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86DGAPROTO_DIR)/config.cache)
	cd $(XLIBS_XF86DGAPROTO_DIR) && \
		$(XLIBS_XF86DGAPROTO_PATH) $(XLIBS_XF86DGAPROTO_ENV) \
		./configure $(XLIBS_XF86DGAPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xf86dgaproto_compile: $(STATEDIR)/xlibs-xf86dgaproto.compile

xlibs-xf86dgaproto_compile_deps = $(STATEDIR)/xlibs-xf86dgaproto.prepare

$(STATEDIR)/xlibs-xf86dgaproto.compile: $(xlibs-xf86dgaproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86DGAPROTO_DIR) && $(XLIBS_XF86DGAPROTO_ENV) $(XLIBS_XF86DGAPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xf86dgaproto_install: $(STATEDIR)/xlibs-xf86dgaproto.install

$(STATEDIR)/xlibs-xf86dgaproto.install: $(STATEDIR)/xlibs-xf86dgaproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86DGAPROTO_DIR) && $(XLIBS_XF86DGAPROTO_ENV) $(XLIBS_XF86DGAPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xf86dgaproto_targetinstall: $(STATEDIR)/xlibs-xf86dgaproto.targetinstall

xlibs-xf86dgaproto_targetinstall_deps = $(STATEDIR)/xlibs-xf86dgaproto.compile

$(STATEDIR)/xlibs-xf86dgaproto.targetinstall: $(xlibs-xf86dgaproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-xf86dgaproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_XF86DGAPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_XF86DGAPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xf86dgaproto_clean:
	rm -rf $(STATEDIR)/xlibs-xf86dgaproto.*
	rm -rf $(IMAGEDIR)/xlibs-xf86dgaproto_*
	rm -rf $(XLIBS_XF86DGAPROTO_DIR)

# vim: syntax=make
