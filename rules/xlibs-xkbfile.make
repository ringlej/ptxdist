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
ifdef PTXCONF_XLIBS_XKBFILE
PACKAGES += xlibs-xkbfile
endif

#
# Paths and names
#
XLIBS_XKBFILE_VERSION	= 0.99.0
XLIBS_XKBFILE		= libxkbfile-$(XLIBS_XKBFILE_VERSION)
XLIBS_XKBFILE_SUFFIX	= tar.bz2
XLIBS_XKBFILE_URL	= http://xorg.freedesktop.org/X11R7.0-RC0/lib/$(XLIBS_XKBFILE).$(XLIBS_XKBFILE_SUFFIX)
XLIBS_XKBFILE_SOURCE	= $(SRCDIR)/$(XLIBS_XKBFILE).$(XLIBS_XKBFILE_SUFFIX)
XLIBS_XKBFILE_DIR	= $(BUILDDIR)/$(XLIBS_XKBFILE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xkbfile_get: $(STATEDIR)/xlibs-xkbfile.get

xlibs-xkbfile_get_deps = $(XLIBS_XKBFILE_SOURCE)

$(STATEDIR)/xlibs-xkbfile.get: $(xlibs-xkbfile_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS_XKBFILE))
	$(call touch, $@)

$(XLIBS_XKBFILE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS_XKBFILE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xkbfile_extract: $(STATEDIR)/xlibs-xkbfile.extract

xlibs-xkbfile_extract_deps = $(STATEDIR)/xlibs-xkbfile.get

$(STATEDIR)/xlibs-xkbfile.extract: $(xlibs-xkbfile_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XKBFILE_DIR))
	@$(call extract, $(XLIBS_XKBFILE_SOURCE))
	@$(call patchin, $(XLIBS_XKBFILE))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xkbfile_prepare: $(STATEDIR)/xlibs-xkbfile.prepare

#
# dependencies
#
xlibs-xkbfile_prepare_deps = \
	$(STATEDIR)/xlibs-xkbfile.extract \
	$(STATEDIR)/virtual-xchain.install

XLIBS_XKBFILE_PATH	=  PATH=$(CROSS_PATH)
XLIBS_XKBFILE_ENV 	=  $(CROSS_ENV)
XLIBS_XKBFILE_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS_XKBFILE_AUTOCONF =  $(CROSS_AUTOCONF)
XLIBS_XKBFILE_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xkbfile.prepare: $(xlibs-xkbfile_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS_XKBFILE_DIR)/config.cache)
	cd $(XLIBS_XKBFILE_DIR) && \
		$(XLIBS_XKBFILE_PATH) $(XLIBS_XKBFILE_ENV) \
		./configure $(XLIBS_XKBFILE_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xkbfile_compile: $(STATEDIR)/xlibs-xkbfile.compile

xlibs-xkbfile_compile_deps = $(STATEDIR)/xlibs-xkbfile.prepare

$(STATEDIR)/xlibs-xkbfile.compile: $(xlibs-xkbfile_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS_XKBFILE_DIR) && $(XLIBS_XKBFILE_ENV) $(XLIBS_XKBFILE_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xkbfile_install: $(STATEDIR)/xlibs-xkbfile.install

$(STATEDIR)/xlibs-xkbfile.install: $(STATEDIR)/xlibs-xkbfile.compile
	@$(call targetinfo, $@)
	cd $(XLIBS_XKBFILE_DIR) && $(XLIBS_XKBFILE_ENV) $(XLIBS_XKBFILE_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xkbfile_targetinstall: $(STATEDIR)/xlibs-xkbfile.targetinstall

xlibs-xkbfile_targetinstall_deps = $(STATEDIR)/xlibs-xkbfile.compile

$(STATEDIR)/xlibs-xkbfile.targetinstall: $(xlibs-xkbfile_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-xkbfile)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS_XKBFILE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XLIBS_XKBFILE_DIR)/src/.libs/libxkbfile.so.1.0.0, /usr/X11R6/lib/libxkbfile.so.1.0.0)
	@$(call install_link, libxkbfile.so.1.0.0, /usr/X11R6/lib/libxkbfile.so.1)
	@$(call install_link, libxkbfile.so.1.0.0, /usr/X11R6/lib/libxkbfile.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xkbfile_clean:
	rm -rf $(STATEDIR)/xlibs-xkbfile.*
	rm -rf $(IMAGEDIR)/xlibs-xkbfile_*
	rm -rf $(XLIBS_XKBFILE_DIR)

# vim: syntax=make
