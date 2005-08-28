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
ifdef PTXCONF_XLIBS_PROTO_XCMISCPROTO
PACKAGES += xlibs-xcmiscproto
endif

#
# Paths and names
#
XLIBS_XCMISCPROTO_VERSION	= 1.1
XLIBS_XCMISCPROTO		= xcmiscproto-$(XLIBS_XCMISCPROTO_VERSION)
XLIBS_XCMISCPROTO_SUFFIX	= tar.bz2
XLIBS_XCMISCPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_XCMISCPROTO).$(XLIBS_XCMISCPROTO_SUFFIX)
XLIBS_XCMISCPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_XCMISCPROTO).$(XLIBS_XCMISCPROTO_SUFFIX)
XLIBS_XCMISCPROTO_DIR		= $(BUILDDIR)/$(XLIBS_XCMISCPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xcmiscproto_get: $(STATEDIR)/xlibs-xcmiscproto.get

xlibs-xcmiscproto_get_deps = $(XLIBS_XCMISCPROTO_SOURCE)

$(STATEDIR)/xlibs-xcmiscproto.get: $(xlibs-xcmiscproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XCMISCPROTO))
	touch $@

$(XLIBS_XCMISCPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XCMISCPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xcmiscproto_extract: $(STATEDIR)/xlibs-xcmiscproto.extract

xlibs-xcmiscproto_extract_deps = $(STATEDIR)/xlibs-xcmiscproto.get

$(STATEDIR)/xlibs-xcmiscproto.extract: $(xlibs-xcmiscproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XCMISCPROTO_DIR))
	@$(call extract, $(XLIBS_XCMISCPROTO_SOURCE))
	@$(call patchin, $(XLIBS_XCMISCPROTO))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xcmiscproto_prepare: $(STATEDIR)/xlibs-xcmiscproto.prepare

#
# dependencies
#
xlibs-xcmiscproto_prepare_deps = \
	$(STATEDIR)/xlibs-xcmiscproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XCMISCPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XCMISCPROTO_ENV 	=  $(CROSS_ENV)
#XLIBS_XCMISCPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#XLIBS_XCMISCPROTO_ENV	+=

#
# autoconf
#
XLIBS_XCMISCPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XCMISCPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xcmiscproto.prepare: $(xlibs-xcmiscproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XCMISCPROTO_DIR)/config.cache)
	cd $(XLIBS_XCMISCPROTO_DIR) && \
		$(XLIBS_XCMISCPROTO_PATH) $(XLIBS_XCMISCPROTO_ENV) \
		./configure $(XLIBS_XCMISCPROTO_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xcmiscproto_compile: $(STATEDIR)/xlibs-xcmiscproto.compile

xlibs-xcmiscproto_compile_deps = $(STATEDIR)/xlibs-xcmiscproto.prepare

$(STATEDIR)/xlibs-xcmiscproto.compile: $(xlibs-xcmiscproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XCMISCPROTO_DIR) && $(XLIBS_XCMISCPROTO_ENV) $(XLIBS_XCMISCPROTO_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xcmiscproto_install: $(STATEDIR)/xlibs-xcmiscproto.install

$(STATEDIR)/xlibs-xcmiscproto.install: $(STATEDIR)/xlibs-xcmiscproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XCMISCPROTO_DIR) && $(XLIBS_XCMISCPROTO_ENV) $(XLIBS_XCMISCPROTO_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xcmiscproto_targetinstall: $(STATEDIR)/xlibs-xcmiscproto.targetinstall

xlibs-xcmiscproto_targetinstall_deps = $(STATEDIR)/xlibs-xcmiscproto.compile

$(STATEDIR)/xlibs-xcmiscproto.targetinstall: $(xlibs-xcmiscproto_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-xcmiscproto)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_XCMISCPROTO_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_XCMISCPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xcmiscproto_clean:
	rm -rf $(STATEDIR)/xlibs-xcmiscproto.*
	rm -rf $(IMAGEDIR)/xlibs-xcmiscproto_*
	rm -rf $(XLIBS_XCMISCPROTO_DIR)

# vim: syntax=make
