# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#             Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_FREETYPE214
PACKAGES += freetype214
endif

#
# Paths and names
#
FREETYPE214_VERSION	= 2.1.9
FREETYPE214		= freetype-$(FREETYPE214_VERSION)
FREETYPE214_SUFFIX	= tar.gz
FREETYPE214_URL		= ftp://gd.tuwien.ac.at/publishing/freetype/freetype2/$(FREETYPE214).$(FREETYPE214_SUFFIX)
FREETYPE214_SOURCE	= $(SRCDIR)/$(FREETYPE214).$(FREETYPE214_SUFFIX)
FREETYPE214_DIR		= $(BUILDDIR)/$(FREETYPE214)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

freetype214_get: $(STATEDIR)/freetype214.get

freetype214_get_deps	=  $(FREETYPE214_SOURCE)

$(STATEDIR)/freetype214.get: $(freetype214_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(FREETYPE214_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FREETYPE214_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

freetype214_extract: $(STATEDIR)/freetype214.extract

freetype214_extract_deps	=  $(STATEDIR)/freetype214.get

$(STATEDIR)/freetype214.extract: $(freetype214_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FREETYPE214_DIR))
	@$(call extract, $(FREETYPE214_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

freetype214_prepare: $(STATEDIR)/freetype214.prepare

#
# dependencies
#
freetype214_prepare_deps =  \
	$(STATEDIR)/freetype214.extract \
	$(STATEDIR)/glib22.install \
	$(STATEDIR)/expat.install \
	$(STATEDIR)/virtual-xchain.install

FREETYPE214_PATH	=  PATH=$(CROSS_PATH)
FREETYPE214_ENV 	=  $(CROSS_ENV)
FREETYPE214_ENV		+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
FREETYPE214_AUTOCONF	=  $(CROSS_AUTOCONF)
FREETYPE214_AUTOCONF	+= --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/freetype214.prepare: $(freetype214_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FREETYPE214_BUILDDIR))
	cd $(FREETYPE214_DIR) && \
		$(FREETYPE214_PATH) $(FREETYPE214_ENV) \
		./configure $(FREETYPE214_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

freetype214_compile: $(STATEDIR)/freetype214.compile

freetype214_compile_deps =  $(STATEDIR)/freetype214.prepare

$(STATEDIR)/freetype214.compile: $(freetype214_compile_deps)
	@$(call targetinfo, $@)
	cd $(FREETYPE214_DIR) $(FREETYPE214_PATH) make
	chmod a+x $(FREETYPE214_DIR)/builds/unix/freetype-config
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

freetype214_install: $(STATEDIR)/freetype214.install

$(STATEDIR)/freetype214.install: $(STATEDIR)/freetype214.compile
	@$(call targetinfo, $@)
	cd $(FREETYPE214_DIR) && $(FREETYPE214_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

freetype214_targetinstall: $(STATEDIR)/freetype214.targetinstall

freetype214_targetinstall_deps	=  $(STATEDIR)/freetype214.compile
freetype214_targetinstall_deps	+= $(STATEDIR)/glib22.targetinstall
freetype214_targetinstall_deps	+= $(STATEDIR)/expat.targetinstall

$(STATEDIR)/freetype214.targetinstall: $(freetype214_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)
	rm -f $(ROOTDIR)/lib/libfreetype.so*
	install $(FREETYPE214_DIR)/objs/.libs/libfreetype.so.6.3.5 $(ROOTDIR)/lib/
	ln -sf libfreetype.so.6.3.5 $(ROOTDIR)/lib/libfreetype.so.6
	ln -sf libfreetype.so.6.3.5 $(ROOTDIR)/lib/libfreetype.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

freetype214_clean:
	rm -rf $(STATEDIR)/freetype214.*
	rm -rf $(FREETYPE214_DIR)

# vim: syntax=make
