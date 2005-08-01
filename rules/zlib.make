# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_ZLIB
PACKAGES += zlib
endif

#
# Paths and names 
#
ZLIB_VERSION		= 1.2.3
ZLIB			= zlib-$(ZLIB_VERSION)
ZLIB_URL 		= http://www.zlib.net/$(ZLIB).tar.gz
ZLIB_SOURCE		= $(SRCDIR)/$(ZLIB).tar.gz
ZLIB_DIR		= $(BUILDDIR)/$(ZLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

zlib_get: $(STATEDIR)/zlib.get

$(STATEDIR)/zlib.get: $(ZLIB_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(ZLIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(ZLIB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

zlib_extract: $(STATEDIR)/zlib.extract

$(STATEDIR)/zlib.extract: $(STATEDIR)/zlib.get
	@$(call targetinfo, $@)
	@$(call clean, $(ZLIB_DIR))
	@$(call extract, $(ZLIB_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

zlib_prepare: $(STATEDIR)/zlib.prepare

zlib_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zlib.extract

ZLIB_PATH	= PATH=$(CROSS_PATH)
ZLIB_ENV	= $(CROSS_ENV)
ZLIB_AUTOCONF 	= --shared --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/zlib.prepare: $(zlib_prepare_deps)
	@$(call targetinfo, $@)
	cd $(ZLIB_DIR) && $(ZLIB_ENV) $(ZLIB_PATH) ./configure $(ZLIB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

zlib_compile: $(STATEDIR)/zlib.compile

$(STATEDIR)/zlib.compile: $(STATEDIR)/zlib.prepare 
	@$(call targetinfo, $@)
	$(ZLIB_ENV) $(ZLIB_PATH) cd $(ZLIB_DIR) && make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

zlib_install: $(STATEDIR)/zlib.install

$(STATEDIR)/zlib.install: $(STATEDIR)/zlib.compile
	@$(call targetinfo, $@)
	install -d $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include
	cd $(ZLIB_DIR) && $(ZLIB_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

zlib_targetinstall: $(STATEDIR)/zlib.targetinstall

$(STATEDIR)/zlib.targetinstall: $(STATEDIR)/zlib.install
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,zlib)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(ZLIB_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(ZLIB_DIR)/libz.so.1.2.3, /usr/lib/libz.so.1.2.3)
	@$(call install_link, libz.so.1.2.3, /usr/lib/libz.so.1)
	@$(call install_link, libz.so.1.2.3, /usr/lib/libz.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

zlib_clean: 
	rm -rf $(STATEDIR)/zlib.* $(ZLIB_DIR)

# vim: syntax=make
