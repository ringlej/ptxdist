# -*-makefile-*-
# $id$
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
ifeq (y, $(PTXCONF_ZLIB))
PACKAGES += zlib
endif

#
# Paths and names 
#
ZLIB			= zlib-1.1.4
ZLIB_URL 		= ftp://ftp.info-zip.org/pub/infozip/zlib/$(ZLIB).tar.gz
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

ZLIB_PATH	=  PATH=$(CROSS_PATH)
ZLIB_AUTOCONF 	=  --shared
ZLIB_AUTOCONF 	+= --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/zlib.prepare: $(zlib_prepare_deps)
	@$(call targetinfo, $@)
	cd $(ZLIB_DIR) && \
		$(ZLIB_PATH) \
		./configure $(ZLIB_AUTOCONF)
	perl -i -p -e 's/=gcc/=$(PTXCONF_GNU_TARGET)-gcc/g' $(ZLIB_DIR)/Makefile
	perl -i -p -e 's/=ar/=$(PTXCONF_GNU_TARGET)-ar/g' $(ZLIB_DIR)/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

zlib_compile: $(STATEDIR)/zlib.compile

$(STATEDIR)/zlib.compile: $(STATEDIR)/zlib.prepare 
	@$(call targetinfo, $@)
	$(ZLIB_PATH) make -C $(ZLIB_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

zlib_install: $(STATEDIR)/zlib.install

$(STATEDIR)/zlib.install: $(STATEDIR)/zlib.compile
	@$(call targetinfo, $@)
	$(ZLIB_PATH) make -C $(ZLIB_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

zlib_targetinstall: $(STATEDIR)/zlib.targetinstall

$(STATEDIR)/zlib.targetinstall: $(STATEDIR)/zlib.install
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/lib
	cp -d $(ZLIB_DIR)/libz.so* $(ROOTDIR)/lib
	$(CROSSSTRIP) -S -R .note -R .comment $(ROOTDIR)/lib/libz.so*
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

zlib_clean: 
	rm -rf $(STATEDIR)/zlib.* $(ZLIB_DIR)

# vim: syntax=make
