# -*-makefile-*-
# $Id: libpng125.make,v 1.3 2004/08/18 19:18:33 rsc Exp $
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
LIBPNG125_URL		= http://download.sourceforge.net/libpng/$(LIBPNG125).$(LIBPNG125_SUFFIX)
LIBPNG125_SOURCE	= $(SRCDIR)/$(LIBPNG125).$(LIBPNG125_SUFFIX)
LIBPNG125_DIR		= $(BUILDDIR)/$(LIBPNG125)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libpng125_get: $(STATEDIR)/libpng125.get

libpng125_get_deps	=  $(LIBPNG125_SOURCE)

$(STATEDIR)/libpng125.get: $(libpng125_get_deps)
	@$(call targetinfo, $@)
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

ifdef PTXCONF_LIBPNG125_FOO
LIBPNG125_AUTOCONF	+= --enable-foo
endif

$(STATEDIR)/libpng125.prepare: $(libpng125_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPNG125_BUILDDIR))
	cp $(LIBPNG125_DIR)/scripts/makefile.linux $(LIBPNG125_DIR)/Makefile
	# Fix some cross unfriendly mess
	perl -i -p -e "s/CC=/CC?=/g" $(LIBPNG125_DIR)/Makefile
	perl -i -p -e "s/^prefix=/prefix?=/g" $(LIBPNG125_DIR)/Makefile
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
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	install $(LIBPNG125_DIR)/libpng12.so.0.1.2.5 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib
	ln -sf libpng12.so.0.1.2.5 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpng12.so.0
	ln -sf libpng12.so.0.1.2.5 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpng12.so
	ln -sf libpng12.so.0.1.2.5 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpng.so.0
	ln -sf libpng12.so.0.1.2.5 $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib/libpng.so
	install $(LIBPNG125_DIR)/*.h $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libpng125_targetinstall: $(STATEDIR)/libpng125.targetinstall

libpng125_targetinstall_deps	=  $(STATEDIR)/libpng125.compile

$(STATEDIR)/libpng125.targetinstall: $(libpng125_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/lib
	install $(LIBPNG125_DIR)/libpng12.so.0.1.2.5 $(ROOTDIR)/lib
	ln -sf libpng12.so.0.1.2.5 $(ROOTDIR)/lib/libpng12.so.0
	ln -sf libpng12.so.0.1.2.5 $(ROOTDIR)/lib/libpng12.so
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpng125_clean:
	rm -rf $(STATEDIR)/libpng125.*
	rm -rf $(LIBPNG125_DIR)

# vim: syntax=make
