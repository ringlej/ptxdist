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
ifdef PTXCONF_XLIBS_PROTO_FIXESPROTO
PACKAGES += xlibs-fixesproto
endif

#
# Paths and names
#
XLIBS_FIXESPROTO_VERSION	= 3.0
XLIBS_FIXESPROTO		= fixesproto-$(XLIBS_FIXESPROTO_VERSION)
XLIBS_FIXESPROTO_SUFFIX		= tar.bz2
XLIBS_FIXESPROTO_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/proto/$(XLIBS_FIXESPROTO).$(XLIBS_FIXESPROTO_SUFFIX)
XLIBS_FIXESPROTO_SOURCE		= $(SRCDIR)/$(XLIBS_FIXESPROTO).$(XLIBS_FIXESPROTO_SUFFIX)
XLIBS_FIXESPROTO_DIR		= $(BUILDDIR)/$(XLIBS_FIXESPROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-fixesproto_get: $(STATEDIR)/xlibs-fixesproto.get

xlibs-fixesproto_get_deps = $(XLIBS_FIXESPROTO_SOURCE)

$(STATEDIR)/xlibs-fixesproto.get: $(xlibs-fixesproto_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_FIXESPROTO))
	$(call touch, $@)

$(XLIBS_FIXESPROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_FIXESPROTO_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-fixesproto_extract: $(STATEDIR)/xlibs-fixesproto.extract

xlibs-fixesproto_extract_deps = $(STATEDIR)/xlibs-fixesproto.get

$(STATEDIR)/xlibs-fixesproto.extract: $(xlibs-fixesproto_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FIXESPROTO_DIR))
	@$(call extract, $(XLIBS_FIXESPROTO_SOURCE))
	@$(call patchin, $(XLIBS_FIXESPROTO))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-fixesproto_prepare: $(STATEDIR)/xlibs-fixesproto.prepare

#
# dependencies
#
xlibs-fixesproto_prepare_deps = \
	$(STATEDIR)/xlibs-fixesproto.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_FIXESPROTO_PATH	=  PATH=$(CROSS_PATH)
XLIBS_FIXESPROTO_ENV 	=  $(CROSS_ENV)
XLIBS_FIXESPROTO_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_FIXESPROTO_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_FIXESPROTO_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-fixesproto.prepare: $(xlibs-fixesproto_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_FIXESPROTO_DIR)/config.cache)
	cd $(XLIBS_FIXESPROTO_DIR) && \
		$(XLIBS_FIXESPROTO_PATH) $(XLIBS_FIXESPROTO_ENV) \
		./configure $(XLIBS_FIXESPROTO_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-fixesproto_compile: $(STATEDIR)/xlibs-fixesproto.compile

xlibs-fixesproto_compile_deps = $(STATEDIR)/xlibs-fixesproto.prepare

$(STATEDIR)/xlibs-fixesproto.compile: $(xlibs-fixesproto_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_FIXESPROTO_DIR) && $(XLIBS_FIXESPROTO_ENV) $(XLIBS_FIXESPROTO_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-fixesproto_install: $(STATEDIR)/xlibs-fixesproto.install

$(STATEDIR)/xlibs-fixesproto.install: $(STATEDIR)/xlibs-fixesproto.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_FIXESPROTO_DIR) && $(XLIBS_FIXESPROTO_ENV) $(XLIBS_FIXESPROTO_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-fixesproto_targetinstall: $(STATEDIR)/xlibs-fixesproto.targetinstall

xlibs-fixesproto_targetinstall_deps = $(STATEDIR)/xlibs-fixesproto.compile

$(STATEDIR)/xlibs-fixesproto.targetinstall: $(xlibs-fixesproto_targetinstall_deps)
	@$(call targetinfo, $@)

#	@$(call install_init,default)
#	@$(call install_fixup,PACKAGE,xlibs-fixesproto)
#	@$(call install_fixup,PRIORITY,optional)
#	@$(call install_fixup,VERSION,$(XLIBS_FIXESPROTO_VERSION))
#	@$(call install_fixup,SECTION,base)
#	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
#	@$(call install_fixup,DEPENDS,)
#	@$(call install_fixup,DESCRIPTION,missing)
#
#	@$(call install_copy, 0, 0, 0755, $(XLIBS_FIXESPROTO_DIR)/foobar, /dev/null)
#
#	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-fixesproto_clean:
	rm -rf $(STATEDIR)/xlibs-fixesproto.*
	rm -rf $(IMAGEDIR)/xlibs-fixesproto_*
	rm -rf $(XLIBS_FIXESPROTO_DIR)

# vim: syntax=make
