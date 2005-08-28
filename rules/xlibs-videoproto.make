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
ifdef PTXCONF_XLIBS_PROTO_VIDEOPROTO
PACKAGES += xlibs-videoproto
endif

#
# Paths and names
#
XLIBS_VIDEOPROTO_VERSION	= 2.2
XLIBS_VIDEOPROTO		= videoproto-$(XLIBS_VIDEOPROTO_VERSION)
XLIBS_VIDEOPROTO_SUFFIX		= tar.bz2
XLIBS_VIDEOPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_VIDEOPROTO).$(XLIBS_VIDEOPROTO_SUFFIX)
XLIBS_VIDEOPROTO_SOURCE		= $(SRCDIR)/$(XLIBS_VIDEOPROTO).$(XLIBS_VIDEOPROTO_SUFFIX)
XLIBS_VIDEOPROTO_DIR		= $(BUILDDIR)/$(XLIBS_VIDEOPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-videoproto_get: $(STATEDIR)/xlibs-videoproto.get

xlibs-videoproto_get_deps = $(XLIBS_VIDEOPROTO_SOURCE)

$(STATEDIR)/xlibs-videoproto.get: $(xlibs-videoproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_VIDEOPROTO))
	$(call touch, $@)

$(XLIBS_VIDEOPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_VIDEOPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-videoproto_extract: $(STATEDIR)/xlibs-videoproto.extract

xlibs-videoproto_extract_deps = $(STATEDIR)/xlibs-videoproto.get

$(STATEDIR)/xlibs-videoproto.extract: $(xlibs-videoproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_VIDEOPROTO_DIR))
	@$(call extract, $(XLIBS_VIDEOPROTO_SOURCE))
	@$(call patchin, $(XLIBS_VIDEOPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-videoproto_prepare: $(STATEDIR)/xlibs-videoproto.prepare

#
# dependencies
#
xlibs-videoproto_prepare_deps = \
	$(STATEDIR)/xlibs-videoproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_VIDEOPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_VIDEOPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_VIDEOPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_VIDEOPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_VIDEOPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-videoproto.prepare: $(xlibs-videoproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_VIDEOPROTO_DIR)/config.cache)
	cd $(XLIBS_VIDEOPROTO_DIR) && \
		$(XLIBS_VIDEOPROTO_PATH) $(XLIBS_VIDEOPROTO_ENV) \
		./configure $(XLIBS_VIDEOPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-videoproto_compile: $(STATEDIR)/xlibs-videoproto.compile

xlibs-videoproto_compile_deps = $(STATEDIR)/xlibs-videoproto.prepare

$(STATEDIR)/xlibs-videoproto.compile: $(xlibs-videoproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_VIDEOPROTO_DIR) && $(XLIBS_VIDEOPROTO_ENV) $(XLIBS_VIDEOPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-videoproto_install: $(STATEDIR)/xlibs-videoproto.install

$(STATEDIR)/xlibs-videoproto.install: $(STATEDIR)/xlibs-videoproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_VIDEOPROTO_DIR) && $(XLIBS_VIDEOPROTO_ENV) $(XLIBS_VIDEOPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-videoproto_targetinstall: $(STATEDIR)/xlibs-videoproto.targetinstall

xlibs-videoproto_targetinstall_deps = $(STATEDIR)/xlibs-videoproto.compile

$(STATEDIR)/xlibs-videoproto.targetinstall: $(xlibs-videoproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-videoproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_VIDEOPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_VIDEOPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-videoproto_clean:
	rm -rf $(STATEDIR)/xlibs-videoproto.*
	rm -rf $(IMAGEDIR)/xlibs-videoproto_*
	rm -rf $(XLIBS_VIDEOPROTO_DIR)

# vim: syntax=make
