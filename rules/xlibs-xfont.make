#
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_XLIBS-XFONT
PACKAGES += xlibs-xfont
endif

#
# Paths and names
#
XLIBS-XFONT_VERSION	= 20041103-1
XLIBS-XFONT		= Xfont-$(XLIBS-XFONT_VERSION)
XLIBS-XFONT_SUFFIX	= tar.bz2
XLIBS-XFONT_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-XFONT).$(XLIBS-XFONT_SUFFIX)
XLIBS-XFONT_SOURCE	= $(SRCDIR)/$(XLIBS-XFONT).$(XLIBS-XFONT_SUFFIX)
XLIBS-XFONT_DIR		= $(BUILDDIR)/$(XLIBS-XFONT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xfont_get: $(STATEDIR)/xlibs-xfont.get

xlibs-xfont_get_deps = $(XLIBS-XFONT_SOURCE)

$(STATEDIR)/xlibs-xfont.get: $(xlibs-xfont_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-XFONT))
	touch $@

$(XLIBS-XFONT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-XFONT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xfont_extract: $(STATEDIR)/xlibs-xfont.extract

xlibs-xfont_extract_deps = $(STATEDIR)/xlibs-xfont.get

$(STATEDIR)/xlibs-xfont.extract: $(xlibs-xfont_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XFONT_DIR))
	@$(call extract, $(XLIBS-XFONT_SOURCE))
	@$(call patchin, $(XLIBS-XFONT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xfont_prepare: $(STATEDIR)/xlibs-xfont.prepare

#
# dependencies
#
xlibs-xfont_prepare_deps =  $(STATEDIR)/xlibs-xfont.extract
xlibs-xfont_prepare_deps += $(STATEDIR)/virtual-xchain.install
xlibs-xfont_prepare_deps += $(STATEDIR)/zlib.install

XLIBS-XFONT_PATH	=  PATH=$(CROSS_PATH)
XLIBS-XFONT_ENV 	=  $(CROSS_ENV)
XLIBS-XFONT_ENV		+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-XFONT_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xfont.prepare: $(xlibs-xfont_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XFONT_DIR)/config.cache)
	chmod a+x $(XLIBS-XFONT_DIR)/configure
	cd $(XLIBS-XFONT_DIR) && \
		$(XLIBS-XFONT_PATH) $(XLIBS-XFONT_ENV) \
		./configure $(XLIBS-XFONT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xfont_compile: $(STATEDIR)/xlibs-xfont.compile

xlibs-xfont_compile_deps = $(STATEDIR)/xlibs-xfont.prepare

$(STATEDIR)/xlibs-xfont.compile: $(xlibs-xfont_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-XFONT_DIR) && $(XLIBS-XFONT_ENV) $(XLIBS-XFONT_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xfont_install: $(STATEDIR)/xlibs-xfont.install

$(STATEDIR)/xlibs-xfont.install: $(STATEDIR)/xlibs-xfont.compile
	@$(call targetinfo, $@)
	cd $(XLIBS-XFONT_DIR) && $(XLIBS-XFONT_ENV) $(XLIBS-XFONT_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xfont_targetinstall: $(STATEDIR)/xlibs-xfont.targetinstall

xlibs-xfont_targetinstall_deps = $(STATEDIR)/xlibs-xfont.compile

$(STATEDIR)/xlibs-xfont.targetinstall: $(xlibs-xfont_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call copy_root, 0, 0, 0644, $(XLIBS-XFONT_DIR)/.libs/libXfont.0.0.0,  /usr/X11R6/lib/libXfont.so.0.0.0)
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/X11R6/lib/libXfont.so.0.0.0
	$(call link_root, /usr/X11R6/lib/libXfont.so.0.0.0, /usr/X11R6/lib/libXfont.so.0)
	$(call link_root, /usr/X11R6/lib/libXfont.so.0.0.0, /usr/X11R6/lib/libXfont.0)
	$(call link_root, /usr/X11R6/lib/libXfont.so.0.0.0, /usr/X11R6/lib/libXfont.so)
	$(call copy_root, 0, 0, 0644, $(XLIBS-XFONT_DIR)/fontcache/.libs/libfontcache.0.0.0,  /usr/X11R6/lib/libfontcache.so.0.0.0)
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/X11R6/lib/libfontcache.so.0.0.0
	$(call link_root, /usr/X11R6/lib/libfontcache.so.0.0.0, /usr/X11R6/lib/libfontcache.so.0)
	$(call link_root, /usr/X11R6/lib/libfontcache.so.0.0.0, /usr/X11R6/lib/libfontcache.0)
	$(call link_root, /usr/X11R6/lib/libfontcache.so.0.0.0, /usr/X11R6/lib/libfontcache.so)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xfont_clean:
	rm -rf $(STATEDIR)/xlibs-xfont.*
	rm -rf $(XLIBS-XFONT_DIR)

# vim: syntax=make
