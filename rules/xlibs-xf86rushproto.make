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
ifdef PTXCONF_XLIBS_PROTO_XF86RUSHPROTO
PACKAGES += xlibs-xf86rushproto
endif

#
# Paths and names
#
XLIBS_XF86RUSHPROTO_VERSION	= 1.1
XLIBS_XF86RUSHPROTO		= xf86rushproto-$(XLIBS_XF86RUSHPROTO_VERSION)
XLIBS_XF86RUSHPROTO_SUFFIX	= tar.bz2
XLIBS_XF86RUSHPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_XF86RUSHPROTO).$(XLIBS_XF86RUSHPROTO_SUFFIX)
XLIBS_XF86RUSHPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_XF86RUSHPROTO).$(XLIBS_XF86RUSHPROTO_SUFFIX)
XLIBS_XF86RUSHPROTO_DIR		= $(BUILDDIR)/$(XLIBS_XF86RUSHPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xf86rushproto_get: $(STATEDIR)/xlibs-xf86rushproto.get

xlibs-xf86rushproto_get_deps = $(XLIBS_XF86RUSHPROTO_SOURCE)

$(STATEDIR)/xlibs-xf86rushproto.get: $(xlibs-xf86rushproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XF86RUSHPROTO))
	$(call touch, $@)

$(XLIBS_XF86RUSHPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XF86RUSHPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xf86rushproto_extract: $(STATEDIR)/xlibs-xf86rushproto.extract

xlibs-xf86rushproto_extract_deps = $(STATEDIR)/xlibs-xf86rushproto.get

$(STATEDIR)/xlibs-xf86rushproto.extract: $(xlibs-xf86rushproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86RUSHPROTO_DIR))
	@$(call extract, $(XLIBS_XF86RUSHPROTO_SOURCE))
	@$(call patchin, $(XLIBS_XF86RUSHPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xf86rushproto_prepare: $(STATEDIR)/xlibs-xf86rushproto.prepare

#
# dependencies
#
xlibs-xf86rushproto_prepare_deps = \
	$(STATEDIR)/xlibs-xf86rushproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XF86RUSHPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XF86RUSHPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_XF86RUSHPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XF86RUSHPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XF86RUSHPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xf86rushproto.prepare: $(xlibs-xf86rushproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86RUSHPROTO_DIR)/config.cache)
	cd $(XLIBS_XF86RUSHPROTO_DIR) && \
		$(XLIBS_XF86RUSHPROTO_PATH) $(XLIBS_XF86RUSHPROTO_ENV) \
		./configure $(XLIBS_XF86RUSHPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xf86rushproto_compile: $(STATEDIR)/xlibs-xf86rushproto.compile

xlibs-xf86rushproto_compile_deps = $(STATEDIR)/xlibs-xf86rushproto.prepare

$(STATEDIR)/xlibs-xf86rushproto.compile: $(xlibs-xf86rushproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86RUSHPROTO_DIR) && $(XLIBS_XF86RUSHPROTO_ENV) $(XLIBS_XF86RUSHPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xf86rushproto_install: $(STATEDIR)/xlibs-xf86rushproto.install

$(STATEDIR)/xlibs-xf86rushproto.install: $(STATEDIR)/xlibs-xf86rushproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86RUSHPROTO_DIR) && $(XLIBS_XF86RUSHPROTO_ENV) $(XLIBS_XF86RUSHPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xf86rushproto_targetinstall: $(STATEDIR)/xlibs-xf86rushproto.targetinstall

xlibs-xf86rushproto_targetinstall_deps = $(STATEDIR)/xlibs-xf86rushproto.compile

$(STATEDIR)/xlibs-xf86rushproto.targetinstall: $(xlibs-xf86rushproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-xf86rushproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_XF86RUSHPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_XF86RUSHPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xf86rushproto_clean:
	rm -rf $(STATEDIR)/xlibs-xf86rushproto.*
	rm -rf $(IMAGEDIR)/xlibs-xf86rushproto_*
	rm -rf $(XLIBS_XF86RUSHPROTO_DIR)

# vim: syntax=make
