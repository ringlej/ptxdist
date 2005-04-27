# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBPNG125
PACKAGES += libpng125
endif

#
# Paths and names
#
LIBPNG125_VERSION	= 1.2.5
LIBPNG125		= libpng-$(LIBPNG125_VERSION)
LIBPNG125_SUFFIX	= tar.gz
LIBPNG125_URL		= $(PTXCONF_SETUP_SFMIRROR)/libpng/$(LIBPNG125).$(LIBPNG125_SUFFIX)
LIBPNG125_SOURCE	= $(SRCDIR)/$(LIBPNG125).$(LIBPNG125_SUFFIX)
LIBPNG125_DIR		= $(BUILDDIR)/$(LIBPNG125)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libpng125_get: $(STATEDIR)/libpng125.get

libpng125_get_deps	=  $(LIBPNG125_SOURCE)


$(STATEDIR)/libpng125.get: $(libpng125_get_deps) $(STATEDIR)/libpng125-patches.get
	@$(call targetinfo, $@)
	touch $@

$(STATEDIR)/libpng125-patches.get:
	@$(call targetinfo, $@)
	@$(call get_patches, $(LIBPNG125))
	touch $@

$(LIBPNG125_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBPNG125_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libpng125_extract: $(STATEDIR)/libpng125.extract

libpng125_extract_deps	=  $(STATEDIR)/libpng125.get

$(STATEDIR)/libpng125.extract: $(libpng125_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPNG125_DIR))
	@$(call extract, $(LIBPNG125_SOURCE))
	@$(call patchin, $(LIBPNG125))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libpng125_prepare: $(STATEDIR)/libpng125.prepare

#
# dependencies
#
libpng125_prepare_deps =  \
	$(STATEDIR)/libpng125.extract \
	$(STATEDIR)/virtual-xchain.install

LIBPNG125_PATH	=  PATH=$(CROSS_PATH)
LIBPNG125_ENV 	=  $(CROSS_ENV)
LIBPNG125_ENV   += prefix=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)
LIBPNG125_ENV	+= ZLIBLIB=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
LIBPNG125_ENV	+= ZLIBINC=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include

$(STATEDIR)/libpng125.prepare: $(libpng125_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPNG125_BUILDDIR))
	cp $(LIBPNG125_DIR)/scripts/makefile.linux $(LIBPNG125_DIR)/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libpng125_compile: $(STATEDIR)/libpng125.compile

libpng125_compile_deps =  $(STATEDIR)/libpng125.prepare
libpng125_compile_deps += $(STATEDIR)/zlib.install

$(STATEDIR)/libpng125.compile: $(libpng125_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBPNG125_DIR) && $(LIBPNG125_PATH) $(LIBPNG125_ENV) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libpng125_install: $(STATEDIR)/libpng125.install

$(STATEDIR)/libpng125.install: $(STATEDIR)/libpng125.compile
	@$(call targetinfo, $@)
	cd $(LIBPNG125_DIR) && $(LIBPNG125_PATH) $(LIBPNG125_ENV) make install
	# and now the ugly part
	cd $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/libpng12 && \
		ln -s ../zlib.h .
	cd $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/libpng12 && \
		ln -s ../zconf.h .
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libpng125_targetinstall: $(STATEDIR)/libpng125.targetinstall

libpng125_targetinstall_deps	=  $(STATEDIR)/libpng125.compile

$(STATEDIR)/libpng125.targetinstall: $(libpng125_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libpng125)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBPNG125_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0644, \
		$(LIBPNG125_DIR)/libpng12.so.0.1.2.5, \
		/usr/lib/libpng12.so.0.1.2.5)
	@$(call install_link, libpng12.so.0.1.2.5, /usr/lib/libpng12.so.0)
	@$(call install_link, libpng12.so.0.1.2.5, /usr/lib/libpng12.so)
	
	@$(call install_finish)
	
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpng125_clean:
	rm -rf $(STATEDIR)/libpng125.*
	rm -rf $(IMAGEDIR)/libpng125_*
	rm -rf $(LIBPNG125_DIR)

# vim: syntax=make
