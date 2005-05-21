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
ifdef PTXCONF_XLIBS-XEXT
PACKAGES += xlibs-xext
endif

#
# Paths and names
#
XLIBS-XEXT_VERSION	= 20041103-1
XLIBS-XEXT_REAL_VERSION	= 6.4.1
XLIBS-XEXT		= Xext-$(XLIBS-XEXT_VERSION)
XLIBS-XEXT_SUFFIX	= tar.bz2
XLIBS-XEXT_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XLIBS-XEXT).$(XLIBS-XEXT_SUFFIX)
XLIBS-XEXT_SOURCE	= $(SRCDIR)/$(XLIBS-XEXT).$(XLIBS-XEXT_SUFFIX)
XLIBS-XEXT_DIR		= $(BUILDDIR)/$(XLIBS-XEXT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xlibs-xext_get: $(STATEDIR)/xlibs-xext.get

xlibs-xext_get_deps = $(XLIBS-XEXT_SOURCE)

$(STATEDIR)/xlibs-xext.get: $(xlibs-xext_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XLIBS-XEXT))
	touch $@

$(XLIBS-XEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XLIBS-XEXT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xlibs-xext_extract: $(STATEDIR)/xlibs-xext.extract

xlibs-xext_extract_deps = $(STATEDIR)/xlibs-xext.get

$(STATEDIR)/xlibs-xext.extract: $(xlibs-xext_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XEXT_DIR))
	@$(call extract, $(XLIBS-XEXT_SOURCE))
	@$(call patchin, $(XLIBS-XEXT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xlibs-xext_prepare: $(STATEDIR)/xlibs-xext.prepare

#
# dependencies
#
xlibs-xext_prepare_deps =  $(STATEDIR)/xlibs-xext.extract
xlibs-xext_prepare_deps += $(STATEDIR)/virtual-xchain.install
xlibs-xext_prepare_deps += $(STATEDIR)/virtual-libc.install
xlibs-xext_prepare_deps += $(STATEDIR)/xlibs-xproto.install
xlibs-xext_prepare_deps += $(STATEDIR)/xlibs-x11.install

XLIBS-XEXT_PATH	=  PATH=$(CROSS_PATH)
XLIBS-XEXT_ENV 	=  $(CROSS_ENV)
XLIBS-XEXT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XLIBS-XEXT_AUTOCONF =  --build=$(GNU_HOST)
XLIBS-XEXT_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
XLIBS-XEXT_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/xlibs-xext.prepare: $(xlibs-xext_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XLIBS-XEXT_DIR)/config.cache)
	chmod a+x $(XLIBS-XEXT_DIR)/configure
	cd $(XLIBS-XEXT_DIR) && \
		$(XLIBS-XEXT_PATH) $(XLIBS-XEXT_ENV) \
		./configure $(XLIBS-XEXT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xlibs-xext_compile: $(STATEDIR)/xlibs-xext.compile

xlibs-xext_compile_deps = $(STATEDIR)/xlibs-xext.prepare

$(STATEDIR)/xlibs-xext.compile: $(xlibs-xext_compile_deps)
	@$(call targetinfo, $@)
	cd $(XLIBS-XEXT_DIR) && $(XLIBS-XEXT_ENV) $(XLIBS-XEXT_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xlibs-xext_install: $(STATEDIR)/xlibs-xext.install

$(STATEDIR)/xlibs-xext.install: $(STATEDIR)/xlibs-xext.compile
	@$(call targetinfo, $@)
	cd $(XLIBS-XEXT_DIR) && $(XLIBS-XEXT_ENV) $(XLIBS-XEXT_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xlibs-xext_targetinstall: $(STATEDIR)/xlibs-xext.targetinstall

xlibs-xext_targetinstall_deps = $(STATEDIR)/xlibs-xext.compile

$(STATEDIR)/xlibs-xext.targetinstall: $(xlibs-xext_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,coreutils)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(COREUTILS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_root, 0, 0, 0644, \
		$(XLIBS-XEXT_DIR)/.libs/libXext.so.$(XLIBS-XEXT_REAL_VERSION),  \
		/usr/X11R6/lib/libXext.so.$(XLIBS-XEXT_REAL_VERSION))
		
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/X11R6/lib/libXext.so.$(XLIBS-XEXT_REAL_VERSION)
	@$(call install_link, /usr/X11R6/lib/libXext.so.$(XLIBS-XEXT_REAL_VERSION), /usr/X11R6/lib/libXext.so.6)
	@$(call install_link, /usr/X11R6/lib/libXext.so.$(XLIBS-XEXT_REAL_VERSION), /usr/X11R6/lib/libXext.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xlibs-xext_clean:
	rm -rf $(STATEDIR)/xlibs-xext.*
	rm -rf $(IMAGEDIR)/xlibs-xext_*
	rm -rf $(XLIBS-XEXT_DIR)

# vim: syntax=make
