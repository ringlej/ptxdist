# $Id: zlib.make,v 1.2 2003/04/24 16:07:09 jst Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_ZLIB))
PACKAGES += zlib
PACKAGES += xchain-zlib
endif

#
# Paths and names 
#
ZLIB			= zlib-1.1.4
ZLIB_URL 		= ftp://ftp.info-zip.org/pub/infozip/zlib/$(ZLIB).tar.gz
ZLIB_SOURCE		= $(SRCDIR)/$(ZLIB).tar.gz
ZLIB_DIR 		= $(BUILDDIR)/$(ZLIB)
ZLIB_EXTRACT		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

zlib_get: $(STATEDIR)/zlib.get

$(STATEDIR)/zlib.get: $(ZLIB_SOURCE)
	touch $@

xchain-zlib_get: $(STATEDIR)/xchain-zlib.get

$(STATEDIR)/xchain-zlib.get: $(ZLIB_SOURCE)
	touch $@

$(ZLIB_SOURCE):
	@echo
	@echo ----------------
	@echo target: zlib.get
	@echo ----------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(ZLIB_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

zlib_extract: $(STATEDIR)/zlib.extract

$(STATEDIR)/zlib.extract: $(STATEDIR)/zlib.get
	@echo
	@echo --------------------
	@echo target: zlib.extract
	@echo --------------------
	@echo
	$(ZLIB_EXTRACT) $(ZLIB_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

xchain-zlib_extract: $(STATEDIR)/xchain-zlib.extract

$(STATEDIR)/xchain-zlib.extract: $(STATEDIR)/xchain-zlib.get
	@echo
	@echo ---------------------------
	@echo target: xchain-zlib.extract
	@echo ---------------------------
	@echo
	rm -fr $(BUILDDIR)/xchain-zlib
	mkdir -p $(BUILDDIR)/xchain-zlib
	$(ZLIB_EXTRACT) $(ZLIB_SOURCE) | $(TAR) -C $(BUILDDIR)/xchain-zlib -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

zlib_prepare: $(STATEDIR)/zlib.prepare

ZLIB_AUTOCONF =
ZLIB_AUTOCONF += --shared
ZLIB_AUTOCONF += --prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/zlib.prepare: $(STATEDIR)/zlib.extract
	@echo
	@echo --------------------
	@echo target: zlib.prepare
	@echo --------------------
	@echo
	# FIXME: this does currently not work with the local toolchain
	cd $(ZLIB_DIR) && 						\
	./configure $(ZLIB_AUTOCONF)
	perl -i -p -e 's/gcc/$(PTXCONF_GNU_TARGET)-gcc/g' $(ZLIB_DIR)/Makefile
	touch $@

xchain-zlib_prepare: $(STATEDIR)/xchain-zlib.prepare

XCHAIN_ZLIB_AUTOCONF =
XCHAIN_ZLIB_AUTOCONF += --shared
XCHAIN_ZLIB_AUTOCONF += --prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/xchain-zlib.prepare: $(STATEDIR)/xchain-zlib.extract
	@echo
	@echo ---------------------------
	@echo target: xchain-zlib.prepare
	@echo ---------------------------
	@echo
	cd $(BUILDDIR)/xchain-zlib/$(ZLIB) && 						\
	./configure $(XCHAIN_ZLIB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

zlib_compile: $(STATEDIR)/zlib.compile

$(STATEDIR)/zlib.compile: $(STATEDIR)/zlib.prepare 
	@echo
	@echo -------------------- 
	@echo target: zlib.compile
	@echo --------------------
	@echo
	cd $(ZLIB_DIR) && PATH=$(PTXCONF_PREFIX)/bin:$$PATH make CC=$(PTXCONF_GNU_TARGET)-gcc
	touch $@

xchain-zlib_compile: $(STATEDIR)/xchain-zlib.compile

$(STATEDIR)/xchain-zlib.compile: $(STATEDIR)/xchain-zlib.prepare 
	@echo
	@echo --------------------------- 
	@echo target: xchain-zlib.compile
	@echo ---------------------------
	@echo
	cd $(BUILDDIR)/xchain-zlib/$(ZLIB) && make CC=$(HOSTCC)
	touch $@
	
# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

zlib_install: $(STATEDIR)/zlib.install

$(STATEDIR)/zlib.install: $(STATEDIR)/zlib.compile
	@echo
	@echo -------------------- 
	@echo target: zlib.install
	@echo --------------------
	@echo
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(BUILDDIR)/$(ZLIB) install PREFIX=$(PTXCONF_PREFIX)
	touch $@

xchain-zlib_install: $(STATEDIR)/xchain-zlib.install

$(STATEDIR)/xchain-zlib.install: $(STATEDIR)/xchain-zlib.compile
	@echo
	@echo --------------------------- 
	@echo target: xchain-zlib.install
	@echo ---------------------------
	@echo
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(BUILDDIR)/xchain-zlib/$(ZLIB) install PREFIX=$(PTXCONF_PREFIX)
	touch $@
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

zlib_targetinstall: $(STATEDIR)/zlib.targetinstall

$(STATEDIR)/zlib.targetinstall: $(STATEDIR)/zlib.install
	@echo
	@echo -------------------------- 
	@echo target: zlib.targetinstall
	@echo --------------------------
	@echo
	mkdir -p $(ROOTDIR)/lib
	cp -d $(ZLIB_DIR)/libz.so* $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libz.so*
	touch $@

xchain-zlib_targetinstall: $(STATEDIR)/xchain-zlib.targetinstall

$(STATEDIR)/xchain-zlib.targetinstall: $(STATEDIR)/xchain-zlib.install
	@echo
	@echo --------------------------------- 
	@echo target: xchain-zlib.targetinstall
	@echo ---------------------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

zlib_clean: 
	rm -rf $(STATEDIR)/zlib.* $(ZLIB_DIR)

xchain-zlib_clean:
	rm -rf $(STATEDIR)/xchain-zlib.* $(BUILDDIR)/xchain-zlib

# vim: syntax=make
