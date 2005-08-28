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
ifdef PTXCONF_XLIBS_PROTO_SCRNSAVERPROTO
PACKAGES += xlibs-scrnsaverproto
endif

#
# Paths and names
#
XLIBS_SCRNSAVERPROTO_VERSION	= 1.0
XLIBS_SCRNSAVERPROTO		= scrnsaverproto-$(XLIBS_SCRNSAVERPROTO_VERSION)
XLIBS_SCRNSAVERPROTO_SUFFIX	= tar.bz2
XLIBS_SCRNSAVERPROTO_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_SCRNSAVERPROTO).$(XLIBS_SCRNSAVERPROTO_SUFFIX)
XLIBS_SCRNSAVERPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_SCRNSAVERPROTO).$(XLIBS_SCRNSAVERPROTO_SUFFIX)
XLIBS_SCRNSAVERPROTO_DIR	= $(BUILDDIR)/$(XLIBS_SCRNSAVERPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-scrnsaverproto_get: $(STATEDIR)/xlibs-scrnsaverproto.get

xlibs-scrnsaverproto_get_deps = $(XLIBS_SCRNSAVERPROTO_SOURCE)

$(STATEDIR)/xlibs-scrnsaverproto.get: $(xlibs-scrnsaverproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_SCRNSAVERPROTO))
	$(call touch, $@)

$(XLIBS_SCRNSAVERPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_SCRNSAVERPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-scrnsaverproto_extract: $(STATEDIR)/xlibs-scrnsaverproto.extract

xlibs-scrnsaverproto_extract_deps = $(STATEDIR)/xlibs-scrnsaverproto.get

$(STATEDIR)/xlibs-scrnsaverproto.extract: $(xlibs-scrnsaverproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_SCRNSAVERPROTO_DIR))
	@$(call extract, $(XLIBS_SCRNSAVERPROTO_SOURCE))
	@$(call patchin, $(XLIBS_SCRNSAVERPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-scrnsaverproto_prepare: $(STATEDIR)/xlibs-scrnsaverproto.prepare

#
# dependencies
#
xlibs-scrnsaverproto_prepare_deps = \
	$(STATEDIR)/xlibs-scrnsaverproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_SCRNSAVERPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_SCRNSAVERPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_SCRNSAVERPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_SCRNSAVERPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_SCRNSAVERPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-scrnsaverproto.prepare: $(xlibs-scrnsaverproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_SCRNSAVERPROTO_DIR)/config.cache)
	cd $(XLIBS_SCRNSAVERPROTO_DIR) && \
		$(XLIBS_SCRNSAVERPROTO_PATH) $(XLIBS_SCRNSAVERPROTO_ENV) \
		./configure $(XLIBS_SCRNSAVERPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-scrnsaverproto_compile: $(STATEDIR)/xlibs-scrnsaverproto.compile

xlibs-scrnsaverproto_compile_deps = $(STATEDIR)/xlibs-scrnsaverproto.prepare

$(STATEDIR)/xlibs-scrnsaverproto.compile: $(xlibs-scrnsaverproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_SCRNSAVERPROTO_DIR) && $(XLIBS_SCRNSAVERPROTO_ENV) $(XLIBS_SCRNSAVERPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-scrnsaverproto_install: $(STATEDIR)/xlibs-scrnsaverproto.install

$(STATEDIR)/xlibs-scrnsaverproto.install: $(STATEDIR)/xlibs-scrnsaverproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_SCRNSAVERPROTO_DIR) && $(XLIBS_SCRNSAVERPROTO_ENV) $(XLIBS_SCRNSAVERPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-scrnsaverproto_targetinstall: $(STATEDIR)/xlibs-scrnsaverproto.targetinstall

xlibs-scrnsaverproto_targetinstall_deps = $(STATEDIR)/xlibs-scrnsaverproto.compile

$(STATEDIR)/xlibs-scrnsaverproto.targetinstall: $(xlibs-scrnsaverproto_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-scrnsaverproto)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_SCRNSAVERPROTO_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_SCRNSAVERPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-scrnsaverproto_clean:
	rm -rf $(STATEDIR)/xlibs-scrnsaverproto.*
	rm -rf $(IMAGEDIR)/xlibs-scrnsaverproto_*
	rm -rf $(XLIBS_SCRNSAVERPROTO_DIR)

# vim: syntax=make
