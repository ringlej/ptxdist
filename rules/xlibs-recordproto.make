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
ifdef PTXCONF_XLIBS_PROTO_RECORDPROTO
PACKAGES += xlibs-recordproto
endif

#
# Paths and names
#
XLIBS_RECORDPROTO_VERSION	= 1.13
XLIBS_RECORDPROTO		= recordproto-$(XLIBS_RECORDPROTO_VERSION)
XLIBS_RECORDPROTO_SUFFIX	= tar.bz2
XLIBS_RECORDPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_RECORDPROTO).$(XLIBS_RECORDPROTO_SUFFIX)
XLIBS_RECORDPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_RECORDPROTO).$(XLIBS_RECORDPROTO_SUFFIX)
XLIBS_RECORDPROTO_DIR		= $(BUILDDIR)/$(XLIBS_RECORDPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-recordproto_get: $(STATEDIR)/xlibs-recordproto.get

xlibs-recordproto_get_deps = $(XLIBS_RECORDPROTO_SOURCE)

$(STATEDIR)/xlibs-recordproto.get: $(xlibs-recordproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_RECORDPROTO))
	$(call touch, $@)

$(XLIBS_RECORDPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_RECORDPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-recordproto_extract: $(STATEDIR)/xlibs-recordproto.extract

xlibs-recordproto_extract_deps = $(STATEDIR)/xlibs-recordproto.get

$(STATEDIR)/xlibs-recordproto.extract: $(xlibs-recordproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_RECORDPROTO_DIR))
	@$(call extract, $(XLIBS_RECORDPROTO_SOURCE))
	@$(call patchin, $(XLIBS_RECORDPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-recordproto_prepare: $(STATEDIR)/xlibs-recordproto.prepare

#
# dependencies
#
xlibs-recordproto_prepare_deps = \
	$(STATEDIR)/xlibs-recordproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_RECORDPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_RECORDPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_RECORDPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_RECORDPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_RECORDPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-recordproto.prepare: $(xlibs-recordproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_RECORDPROTO_DIR)/config.cache)
	cd $(XLIBS_RECORDPROTO_DIR) && \
		$(XLIBS_RECORDPROTO_PATH) $(XLIBS_RECORDPROTO_ENV) \
		./configure $(XLIBS_RECORDPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-recordproto_compile: $(STATEDIR)/xlibs-recordproto.compile

xlibs-recordproto_compile_deps = $(STATEDIR)/xlibs-recordproto.prepare

$(STATEDIR)/xlibs-recordproto.compile: $(xlibs-recordproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_RECORDPROTO_DIR) && $(XLIBS_RECORDPROTO_ENV) $(XLIBS_RECORDPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-recordproto_install: $(STATEDIR)/xlibs-recordproto.install

$(STATEDIR)/xlibs-recordproto.install: $(STATEDIR)/xlibs-recordproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_RECORDPROTO_DIR) && $(XLIBS_RECORDPROTO_ENV) $(XLIBS_RECORDPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-recordproto_targetinstall: $(STATEDIR)/xlibs-recordproto.targetinstall

xlibs-recordproto_targetinstall_deps = $(STATEDIR)/xlibs-recordproto.compile

$(STATEDIR)/xlibs-recordproto.targetinstall: $(xlibs-recordproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-recordproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_RECORDPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_RECORDPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-recordproto_clean:
	rm -rf $(STATEDIR)/xlibs-recordproto.*
	rm -rf $(IMAGEDIR)/xlibs-recordproto_*
	rm -rf $(XLIBS_RECORDPROTO_DIR)

# vim: syntax=make
