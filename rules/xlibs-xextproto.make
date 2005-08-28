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
ifdef PTXCONF_XLIBS_PROTO_XEXTPROTO
PACKAGES += xlibs-xextproto
endif

#
# Paths and names
#
XLIBS_XEXTPROTO_VERSION	= 7.0
XLIBS_XEXTPROTO		= xextproto-$(XLIBS_XEXTPROTO_VERSION)
XLIBS_XEXTPROTO_SUFFIX	= tar.bz2
XLIBS_XEXTPROTO_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_XEXTPROTO).$(XLIBS_XEXTPROTO_SUFFIX)
XLIBS_XEXTPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_XEXTPROTO).$(XLIBS_XEXTPROTO_SUFFIX)
XLIBS_XEXTPROTO_DIR	= $(BUILDDIR)/$(XLIBS_XEXTPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xextproto_get: $(STATEDIR)/xlibs-xextproto.get

xlibs-xextproto_get_deps = $(XLIBS_XEXTPROTO_SOURCE)

$(STATEDIR)/xlibs-xextproto.get: $(xlibs-xextproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XEXTPROTO))
	touch $@

$(XLIBS_XEXTPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XEXTPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xextproto_extract: $(STATEDIR)/xlibs-xextproto.extract

xlibs-xextproto_extract_deps = $(STATEDIR)/xlibs-xextproto.get

$(STATEDIR)/xlibs-xextproto.extract: $(xlibs-xextproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XEXTPROTO_DIR))
	@$(call extract, $(XLIBS_XEXTPROTO_SOURCE))
	@$(call patchin, $(XLIBS_XEXTPROTO))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xextproto_prepare: $(STATEDIR)/xlibs-xextproto.prepare

#
# dependencies
#
xlibs-xextproto_prepare_deps = \
	$(STATEDIR)/xlibs-xextproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XEXTPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XEXTPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_XEXTPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XEXTPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XEXTPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xextproto.prepare: $(xlibs-xextproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XEXTPROTO_DIR)/config.cache)
	cd $(XLIBS_XEXTPROTO_DIR) && \
		$(XLIBS_XEXTPROTO_PATH) $(XLIBS_XEXTPROTO_ENV) \
		./configure $(XLIBS_XEXTPROTO_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xextproto_compile: $(STATEDIR)/xlibs-xextproto.compile

xlibs-xextproto_compile_deps = $(STATEDIR)/xlibs-xextproto.prepare

$(STATEDIR)/xlibs-xextproto.compile: $(xlibs-xextproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XEXTPROTO_DIR) && $(XLIBS_XEXTPROTO_ENV) $(XLIBS_XEXTPROTO_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xextproto_install: $(STATEDIR)/xlibs-xextproto.install

$(STATEDIR)/xlibs-xextproto.install: $(STATEDIR)/xlibs-xextproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XEXTPROTO_DIR) && $(XLIBS_XEXTPROTO_ENV) $(XLIBS_XEXTPROTO_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xextproto_targetinstall: $(STATEDIR)/xlibs-xextproto.targetinstall

xlibs-xextproto_targetinstall_deps = $(STATEDIR)/xlibs-xextproto.compile

$(STATEDIR)/xlibs-xextproto.targetinstall: $(xlibs-xextproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-xextproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_XEXTPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_XEXTPROTO_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xextproto_clean:
	rm -rf $(STATEDIR)/xlibs-xextproto.*
	rm -rf $(IMAGEDIR)/xlibs-xextproto_*
	rm -rf $(XLIBS_XEXTPROTO_DIR)

# vim: syntax=make
