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
ifdef PTXCONF_XLIBS_PROTO_KBPROTO
PACKAGES += xlibs-kbproto
endif

#
# Paths and names
#
XLIBS_KBPROTO_VERSION	= 1.0
XLIBS_KBPROTO		= kbproto-$(XLIBS_KBPROTO_VERSION)
XLIBS_KBPROTO_SUFFIX	= tar.bz2
XLIBS_KBPROTO_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_KBPROTO).$(XLIBS_KBPROTO_SUFFIX)
XLIBS_KBPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_KBPROTO).$(XLIBS_KBPROTO_SUFFIX)
XLIBS_KBPROTO_DIR	= $(BUILDDIR)/$(XLIBS_KBPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-kbproto_get: $(STATEDIR)/xlibs-kbproto.get

xlibs-kbproto_get_deps = $(XLIBS_KBPROTO_SOURCE)

$(STATEDIR)/xlibs-kbproto.get: $(xlibs-kbproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_KBPROTO))
	touch $@

$(XLIBS_KBPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_KBPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-kbproto_extract: $(STATEDIR)/xlibs-kbproto.extract

xlibs-kbproto_extract_deps = $(STATEDIR)/xlibs-kbproto.get

$(STATEDIR)/xlibs-kbproto.extract: $(xlibs-kbproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_KBPROTO_DIR))
	@$(call extract, $(XLIBS_KBPROTO_SOURCE))
	@$(call patchin, $(XLIBS_KBPROTO))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-kbproto_prepare: $(STATEDIR)/xlibs-kbproto.prepare

#
# dependencies
#
xlibs-kbproto_prepare_deps = \
	$(STATEDIR)/xlibs-kbproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_KBPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_KBPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_KBPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_KBPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_KBPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-kbproto.prepare: $(xlibs-kbproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_KBPROTO_DIR)/config.cache)
	cd $(XLIBS_KBPROTO_DIR) && \
		$(XLIBS_KBPROTO_PATH) $(XLIBS_KBPROTO_ENV) \
		./configure $(XLIBS_KBPROTO_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-kbproto_compile: $(STATEDIR)/xlibs-kbproto.compile

xlibs-kbproto_compile_deps = $(STATEDIR)/xlibs-kbproto.prepare

$(STATEDIR)/xlibs-kbproto.compile: $(xlibs-kbproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_KBPROTO_DIR) && $(XLIBS_KBPROTO_ENV) $(XLIBS_KBPROTO_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-kbproto_install: $(STATEDIR)/xlibs-kbproto.install

$(STATEDIR)/xlibs-kbproto.install: $(STATEDIR)/xlibs-kbproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_KBPROTO_DIR) && $(XLIBS_KBPROTO_ENV) $(XLIBS_KBPROTO_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-kbproto_targetinstall: $(STATEDIR)/xlibs-kbproto.targetinstall

xlibs-kbproto_targetinstall_deps = $(STATEDIR)/xlibs-kbproto.compile

$(STATEDIR)/xlibs-kbproto.targetinstall: $(xlibs-kbproto_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-kbproto)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_KBPROTO_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_KBPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-kbproto_clean:
	rm -rf $(STATEDIR)/xlibs-kbproto.*
	rm -rf $(IMAGEDIR)/xlibs-kbproto_*
	rm -rf $(XLIBS_KBPROTO_DIR)

# vim: syntax=make
