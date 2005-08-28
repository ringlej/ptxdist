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
ifdef PTXCONF_XLIBS_PROTO_RANDRPROTO
PACKAGES += xlibs-randrproto
endif

#
# Paths and names
#
XLIBS_RANDRPROTO_VERSION	= 1.1
XLIBS_RANDRPROTO		= randrproto-$(XLIBS_RANDRPROTO_VERSION)
XLIBS_RANDRPROTO_SUFFIX		= tar.bz2
XLIBS_RANDRPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_RANDRPROTO).$(XLIBS_RANDRPROTO_SUFFIX)
XLIBS_RANDRPROTO_SOURCE		= $(SRCDIR)/$(XLIBS_RANDRPROTO).$(XLIBS_RANDRPROTO_SUFFIX)
XLIBS_RANDRPROTO_DIR		= $(BUILDDIR)/$(XLIBS_RANDRPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-randrproto_get: $(STATEDIR)/xlibs-randrproto.get

xlibs-randrproto_get_deps = $(XLIBS_RANDRPROTO_SOURCE)

$(STATEDIR)/xlibs-randrproto.get: $(xlibs-randrproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_RANDRPROTO))
	$(call touch, $@)

$(XLIBS_RANDRPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_RANDRPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-randrproto_extract: $(STATEDIR)/xlibs-randrproto.extract

xlibs-randrproto_extract_deps = $(STATEDIR)/xlibs-randrproto.get

$(STATEDIR)/xlibs-randrproto.extract: $(xlibs-randrproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_RANDRPROTO_DIR))
	@$(call extract, $(XLIBS_RANDRPROTO_SOURCE))
	@$(call patchin, $(XLIBS_RANDRPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-randrproto_prepare: $(STATEDIR)/xlibs-randrproto.prepare

#
# dependencies
#
xlibs-randrproto_prepare_deps = \
	$(STATEDIR)/xlibs-randrproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_RANDRPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_RANDRPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_RANDRPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_RANDRPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_RANDRPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-randrproto.prepare: $(xlibs-randrproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_RANDRPROTO_DIR)/config.cache)
	cd $(XLIBS_RANDRPROTO_DIR) && \
		$(XLIBS_RANDRPROTO_PATH) $(XLIBS_RANDRPROTO_ENV) \
		./configure $(XLIBS_RANDRPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-randrproto_compile: $(STATEDIR)/xlibs-randrproto.compile

xlibs-randrproto_compile_deps = $(STATEDIR)/xlibs-randrproto.prepare

$(STATEDIR)/xlibs-randrproto.compile: $(xlibs-randrproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_RANDRPROTO_DIR) && $(XLIBS_RANDRPROTO_ENV) $(XLIBS_RANDRPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-randrproto_install: $(STATEDIR)/xlibs-randrproto.install

$(STATEDIR)/xlibs-randrproto.install: $(STATEDIR)/xlibs-randrproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_RANDRPROTO_DIR) && $(XLIBS_RANDRPROTO_ENV) $(XLIBS_RANDRPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-randrproto_targetinstall: $(STATEDIR)/xlibs-randrproto.targetinstall

xlibs-randrproto_targetinstall_deps = $(STATEDIR)/xlibs-randrproto.compile

$(STATEDIR)/xlibs-randrproto.targetinstall: $(xlibs-randrproto_targetinstall_deps)
	@$(call targetinfo, $@)
#
#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-randrproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_RANDRPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_RANDRPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-randrproto_clean:
	rm -rf $(STATEDIR)/xlibs-randrproto.*
	rm -rf $(IMAGEDIR)/xlibs-randrproto_*
	rm -rf $(XLIBS_RANDRPROTO_DIR)

# vim: syntax=make
