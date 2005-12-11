# -*-makefile-*-
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
PACKAGES-$(PTXCONF_XLIBS-XFONT) += xlibs-xfont

#
# Paths and names
#
XLIBS-XFONT_VERSION	= 20041103-1
XLIBS-XFONT_REAL_VERSION= 1.4.1
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
	@$(call touch, $@)

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
	@$(call touch, $@)

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
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xfont_compile: $(STATEDIR)/xlibs-xfont.compile

xlibs-xfont_compile_deps = $(STATEDIR)/xlibs-xfont.prepare

$(STATEDIR)/xlibs-xfont.compile: $(xlibs-xfont_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-XFONT_DIR) && $(XLIBS-XFONT_ENV) $(XLIBS-XFONT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xfont_install: $(STATEDIR)/xlibs-xfont.install

$(STATEDIR)/xlibs-xfont.install: $(STATEDIR)/xlibs-xfont.compile
	@$(call targetinfo, $@)
	@$(call install, XLIBS-XFONT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xfont_targetinstall: $(STATEDIR)/xlibs-xfont.targetinstall

xlibs-xfont_targetinstall_deps = $(STATEDIR)/xlibs-xfont.compile

$(STATEDIR)/xlibs-xfont.targetinstall: $(xlibs-xfont_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xlibs-xfont)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XLIBS-XFONT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0644, 						\
		$(XLIBS-XFONT_DIR)/.libs/libXfont.so.$(XLIBS-XFONT_REAL_VERSION),  	\
		/usr/X11R6/lib/libXfont.so.$(XLIBS-XFONT_REAL_VERSION)			\
	)
	@$(call install_link, 								\
		/usr/X11R6/lib/libXfont.so.$(XLIBS-XFONT_REAL_VERSION), 		\
		/usr/X11R6/lib/libXfont.so.0						\
	)
	@$(call install_link, /usr/X11R6/lib/libXfont.so.$(XLIBS-XFONT_REAL_VERSION), /usr/X11R6/lib/libXfont.so)
	@$(call install_copy, 0, 0, 0644, $(XLIBS-XFONT_DIR)/fontcache/.libs/libfontcache.so.0.0.0,  /usr/X11R6/lib/libfontcache.so.0.0.0)
	@$(call install_link, /usr/X11R6/lib/libfontcache.so.$(XLIBS-XFONT_REAL_VERSION), /usr/X11R6/lib/libfontcache.so.0)
	@$(call install_link, /usr/X11R6/lib/libfontcache.so.$(XLIBS-XFONT_REAL_VERSION), /usr/X11R6/lib/libfontcache.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xfont_clean:
	rm -rf $(STATEDIR)/xlibs-xfont.*
	rm -rf $(IMAGEDIR)/xlibs-xfont_*
	rm -rf $(XLIBS-XFONT_DIR)

# vim: syntax=make
