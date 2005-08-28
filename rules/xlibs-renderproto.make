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
ifdef PTXCONF_XLIBS_PROTO_RENDERPROTO
PACKAGES += xlibs-renderproto
endif

#
# Paths and names
#
XLIBS_RENDERPROTO_VERSION	= 0.9
XLIBS_RENDERPROTO		= renderproto-$(XLIBS_RENDERPROTO_VERSION)
XLIBS_RENDERPROTO_SUFFIX	= tar.bz2
XLIBS_RENDERPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_RENDERPROTO).$(XLIBS_RENDERPROTO_SUFFIX)
XLIBS_RENDERPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_RENDERPROTO).$(XLIBS_RENDERPROTO_SUFFIX)
XLIBS_RENDERPROTO_DIR		= $(BUILDDIR)/$(XLIBS_RENDERPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-renderproto_get: $(STATEDIR)/xlibs-renderproto.get

xlibs-renderproto_get_deps = $(XLIBS_RENDERPROTO_SOURCE)

$(STATEDIR)/xlibs-renderproto.get: $(xlibs-renderproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_RENDERPROTO))
	$(call touch, $@)

$(XLIBS_RENDERPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_RENDERPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-renderproto_extract: $(STATEDIR)/xlibs-renderproto.extract

xlibs-renderproto_extract_deps = $(STATEDIR)/xlibs-renderproto.get

$(STATEDIR)/xlibs-renderproto.extract: $(xlibs-renderproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_RENDERPROTO_DIR))
	@$(call extract, $(XLIBS_RENDERPROTO_SOURCE))
	@$(call patchin, $(XLIBS_RENDERPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-renderproto_prepare: $(STATEDIR)/xlibs-renderproto.prepare

#
# dependencies
#
xlibs-renderproto_prepare_deps = \
	$(STATEDIR)/xlibs-renderproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_RENDERPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_RENDERPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_RENDERPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_RENDERPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_RENDERPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-renderproto.prepare: $(xlibs-renderproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_RENDERPROTO_DIR)/config.cache)
	cd $(XLIBS_RENDERPROTO_DIR) && \
		$(XLIBS_RENDERPROTO_PATH) $(XLIBS_RENDERPROTO_ENV) \
		./configure $(XLIBS_RENDERPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-renderproto_compile: $(STATEDIR)/xlibs-renderproto.compile

xlibs-renderproto_compile_deps = $(STATEDIR)/xlibs-renderproto.prepare

$(STATEDIR)/xlibs-renderproto.compile: $(xlibs-renderproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_RENDERPROTO_DIR) && $(XLIBS_RENDERPROTO_ENV) $(XLIBS_RENDERPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-renderproto_install: $(STATEDIR)/xlibs-renderproto.install

$(STATEDIR)/xlibs-renderproto.install: $(STATEDIR)/xlibs-renderproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_RENDERPROTO_DIR) && $(XLIBS_RENDERPROTO_ENV) $(XLIBS_RENDERPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-renderproto_targetinstall: $(STATEDIR)/xlibs-renderproto.targetinstall

xlibs-renderproto_targetinstall_deps = $(STATEDIR)/xlibs-renderproto.compile

$(STATEDIR)/xlibs-renderproto.targetinstall: $(xlibs-renderproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-renderproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_RENDERPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_RENDERPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-renderproto_clean:
	rm -rf $(STATEDIR)/xlibs-renderproto.*
	rm -rf $(IMAGEDIR)/xlibs-renderproto_*
	rm -rf $(XLIBS_RENDERPROTO_DIR)

# vim: syntax=make
