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
ifdef PTXCONF_XLIBS_PROTO_INPUTPROTO
PACKAGES += xlibs-inputproto
endif

#
# Paths and names
#
XLIBS_INPUTPROTO_VERSION	= 1.3
XLIBS_INPUTPROTO		= inputproto-$(XLIBS_INPUTPROTO_VERSION)
XLIBS_INPUTPROTO_SUFFIX		= tar.bz2
XLIBS_INPUTPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_INPUTPROTO).$(XLIBS_INPUTPROTO_SUFFIX)
XLIBS_INPUTPROTO_SOURCE		= $(SRCDIR)/$(XLIBS_INPUTPROTO).$(XLIBS_INPUTPROTO_SUFFIX)
XLIBS_INPUTPROTO_DIR		= $(BUILDDIR)/$(XLIBS_INPUTPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-inputproto_get: $(STATEDIR)/xlibs-inputproto.get

xlibs-inputproto_get_deps = $(XLIBS_INPUTPROTO_SOURCE)

$(STATEDIR)/xlibs-inputproto.get: $(xlibs-inputproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_INPUTPROTO))
	touch $@

$(XLIBS_INPUTPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_INPUTPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-inputproto_extract: $(STATEDIR)/xlibs-inputproto.extract

xlibs-inputproto_extract_deps = $(STATEDIR)/xlibs-inputproto.get

$(STATEDIR)/xlibs-inputproto.extract: $(xlibs-inputproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_INPUTPROTO_DIR))
	@$(call extract, $(XLIBS_INPUTPROTO_SOURCE))
	@$(call patchin, $(XLIBS_INPUTPROTO))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-inputproto_prepare: $(STATEDIR)/xlibs-inputproto.prepare

#
# dependencies
#
xlibs-inputproto_prepare_deps = \
	$(STATEDIR)/xlibs-inputproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_INPUTPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_INPUTPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_INPUTPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_INPUTPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_INPUTPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-inputproto.prepare: $(xlibs-inputproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_INPUTPROTO_DIR)/config.cache)
	cd $(XLIBS_INPUTPROTO_DIR) && \
		$(XLIBS_INPUTPROTO_PATH) $(XLIBS_INPUTPROTO_ENV) \
		./configure $(XLIBS_INPUTPROTO_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-inputproto_compile: $(STATEDIR)/xlibs-inputproto.compile

xlibs-inputproto_compile_deps = $(STATEDIR)/xlibs-inputproto.prepare

$(STATEDIR)/xlibs-inputproto.compile: $(xlibs-inputproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_INPUTPROTO_DIR) && $(XLIBS_INPUTPROTO_ENV) $(XLIBS_INPUTPROTO_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-inputproto_install: $(STATEDIR)/xlibs-inputproto.install

$(STATEDIR)/xlibs-inputproto.install: $(STATEDIR)/xlibs-inputproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_INPUTPROTO_DIR) && $(XLIBS_INPUTPROTO_ENV) $(XLIBS_INPUTPROTO_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-inputproto_targetinstall: $(STATEDIR)/xlibs-inputproto.targetinstall

xlibs-inputproto_targetinstall_deps = $(STATEDIR)/xlibs-inputproto.compile

$(STATEDIR)/xlibs-inputproto.targetinstall: $(xlibs-inputproto_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-inputproto)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_INPUTPROTO_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_INPUTPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-inputproto_clean:
	rm -rf $(STATEDIR)/xlibs-inputproto.*
	rm -rf $(IMAGEDIR)/xlibs-inputproto_*
	rm -rf $(XLIBS_INPUTPROTO_DIR)

# vim: syntax=make
