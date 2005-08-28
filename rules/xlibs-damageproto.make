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
ifdef PTXCONF_XLIBS_PROTO_DAMAGEPROTO
PACKAGES += xlibs-damageproto
endif

#
# Paths and names
#
XLIBS_DAMAGEPROTO_VERSION	= 1.0
XLIBS_DAMAGEPROTO		= damageproto-$(XLIBS_DAMAGEPROTO_VERSION)
XLIBS_DAMAGEPROTO_SUFFIX	= tar.bz2
XLIBS_DAMAGEPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_DAMAGEPROTO).$(XLIBS_DAMAGEPROTO_SUFFIX)
XLIBS_DAMAGEPROTO_SOURCE	= $(SRCDIR)/$(XLIBS_DAMAGEPROTO).$(XLIBS_DAMAGEPROTO_SUFFIX)
XLIBS_DAMAGEPROTO_DIR		= $(BUILDDIR)/$(XLIBS_DAMAGEPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-damageproto_get: $(STATEDIR)/xlibs-damageproto.get

xlibs-damageproto_get_deps = $(XLIBS_DAMAGEPROTO_SOURCE)

$(STATEDIR)/xlibs-damageproto.get: $(xlibs-damageproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_DAMAGEPROTO))
	$(call touch, $@)

$(XLIBS_DAMAGEPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_DAMAGEPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-damageproto_extract: $(STATEDIR)/xlibs-damageproto.extract

xlibs-damageproto_extract_deps = $(STATEDIR)/xlibs-damageproto.get

$(STATEDIR)/xlibs-damageproto.extract: $(xlibs-damageproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_DAMAGEPROTO_DIR))
	@$(call extract, $(XLIBS_DAMAGEPROTO_SOURCE))
	@$(call patchin, $(XLIBS_DAMAGEPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-damageproto_prepare: $(STATEDIR)/xlibs-damageproto.prepare

#
# dependencies
#
xlibs-damageproto_prepare_deps = \
	$(STATEDIR)/xlibs-damageproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_DAMAGEPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_DAMAGEPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_DAMAGEPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_DAMAGEPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_DAMAGEPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-damageproto.prepare: $(xlibs-damageproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_DAMAGEPROTO_DIR)/config.cache)
	cd $(XLIBS_DAMAGEPROTO_DIR) && \
		$(XLIBS_DAMAGEPROTO_PATH) $(XLIBS_DAMAGEPROTO_ENV) \
		./configure $(XLIBS_DAMAGEPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-damageproto_compile: $(STATEDIR)/xlibs-damageproto.compile

xlibs-damageproto_compile_deps = $(STATEDIR)/xlibs-damageproto.prepare

$(STATEDIR)/xlibs-damageproto.compile: $(xlibs-damageproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_DAMAGEPROTO_DIR) && $(XLIBS_DAMAGEPROTO_ENV) $(XLIBS_DAMAGEPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-damageproto_install: $(STATEDIR)/xlibs-damageproto.install

$(STATEDIR)/xlibs-damageproto.install: $(STATEDIR)/xlibs-damageproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_DAMAGEPROTO_DIR) && $(XLIBS_DAMAGEPROTO_ENV) $(XLIBS_DAMAGEPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-damageproto_targetinstall: $(STATEDIR)/xlibs-damageproto.targetinstall

xlibs-damageproto_targetinstall_deps = $(STATEDIR)/xlibs-damageproto.compile

$(STATEDIR)/xlibs-damageproto.targetinstall: $(xlibs-damageproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-damageproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_DAMAGEPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_DAMAGEPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-damageproto_clean:
	rm -rf $(STATEDIR)/xlibs-damageproto.*
	rm -rf $(IMAGEDIR)/xlibs-damageproto_*
	rm -rf $(XLIBS_DAMAGEPROTO_DIR)

# vim: syntax=make
