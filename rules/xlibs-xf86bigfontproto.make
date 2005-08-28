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
ifdef PTXCONF_XLIBS_PROTO_XF86BIGFONTPROTO
PACKAGES += xlibs-xf86bigfontproto
endif

#
# Paths and names
#
XLIBS_XF86BIGFONTPROTO_VERSION	= 1.1
XLIBS_XF86BIGFONTPROTO		= xf86bigfontproto-$(XLIBS_XF86BIGFONTPROTO_VERSION)
XLIBS_XF86BIGFONTPROTO_SUFFIX	= tar.bz2
XLIBS_XF86BIGFONTPROTO_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_XF86BIGFONTPROTO).$(XLIBS_XF86BIGFONTPROTO_SUFFIX)
XLIBS_XF86BIGFONTPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_XF86BIGFONTPROTO).$(XLIBS_XF86BIGFONTPROTO_SUFFIX)
XLIBS_XF86BIGFONTPROTO_DIR	= $(BUILDDIR)/$(XLIBS_XF86BIGFONTPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xf86bigfontproto_get: $(STATEDIR)/xlibs-xf86bigfontproto.get

xlibs-xf86bigfontproto_get_deps = $(XLIBS_XF86BIGFONTPROTO_SOURCE)

$(STATEDIR)/xlibs-xf86bigfontproto.get: $(xlibs-xf86bigfontproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XF86BIGFONTPROTO))
	$(call touch, $@)

$(XLIBS_XF86BIGFONTPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XF86BIGFONTPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xf86bigfontproto_extract: $(STATEDIR)/xlibs-xf86bigfontproto.extract

xlibs-xf86bigfontproto_extract_deps = $(STATEDIR)/xlibs-xf86bigfontproto.get

$(STATEDIR)/xlibs-xf86bigfontproto.extract: $(xlibs-xf86bigfontproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86BIGFONTPROTO_DIR))
	@$(call extract, $(XLIBS_XF86BIGFONTPROTO_SOURCE))
	@$(call patchin, $(XLIBS_XF86BIGFONTPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xf86bigfontproto_prepare: $(STATEDIR)/xlibs-xf86bigfontproto.prepare

#
# dependencies
#
xlibs-xf86bigfontproto_prepare_deps = \
	$(STATEDIR)/xlibs-xf86bigfontproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XF86BIGFONTPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XF86BIGFONTPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_XF86BIGFONTPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XF86BIGFONTPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XF86BIGFONTPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xf86bigfontproto.prepare: $(xlibs-xf86bigfontproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XF86BIGFONTPROTO_DIR)/config.cache)
	cd $(XLIBS_XF86BIGFONTPROTO_DIR) && \
		$(XLIBS_XF86BIGFONTPROTO_PATH) $(XLIBS_XF86BIGFONTPROTO_ENV) \
		./configure $(XLIBS_XF86BIGFONTPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xf86bigfontproto_compile: $(STATEDIR)/xlibs-xf86bigfontproto.compile

xlibs-xf86bigfontproto_compile_deps = $(STATEDIR)/xlibs-xf86bigfontproto.prepare

$(STATEDIR)/xlibs-xf86bigfontproto.compile: $(xlibs-xf86bigfontproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86BIGFONTPROTO_DIR) && $(XLIBS_XF86BIGFONTPROTO_ENV) $(XLIBS_XF86BIGFONTPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xf86bigfontproto_install: $(STATEDIR)/xlibs-xf86bigfontproto.install

$(STATEDIR)/xlibs-xf86bigfontproto.install: $(STATEDIR)/xlibs-xf86bigfontproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XF86BIGFONTPROTO_DIR) && $(XLIBS_XF86BIGFONTPROTO_ENV) $(XLIBS_XF86BIGFONTPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xf86bigfontproto_targetinstall: $(STATEDIR)/xlibs-xf86bigfontproto.targetinstall

xlibs-xf86bigfontproto_targetinstall_deps = $(STATEDIR)/xlibs-xf86bigfontproto.compile

$(STATEDIR)/xlibs-xf86bigfontproto.targetinstall: $(xlibs-xf86bigfontproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-xf86bigfontproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_XF86BIGFONTPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_XF86BIGFONTPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xf86bigfontproto_clean:
	rm -rf $(STATEDIR)/xlibs-xf86bigfontproto.*
	rm -rf $(IMAGEDIR)/xlibs-xf86bigfontproto_*
	rm -rf $(XLIBS_XF86BIGFONTPROTO_DIR)

# vim: syntax=make
