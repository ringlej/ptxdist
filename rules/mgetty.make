# -*-makefile-*-
# $Id: mgetty.make,v 1.5 2004/03/25 15:53:07 bbu Exp $
#
# Copyright (C) 2003 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_MGETTY
PACKAGES += mgetty
endif

#
# Paths and names
#
MGETTY_VERSION	= 1.1.30
MGETTY_DATE	= Dec16
MGETTY		= mgetty$(MGETTY_VERSION)
MGETTY_SUFFIX	= tar.gz
MGETTY_URL	= ftp://ftp.leo.org/pub/comp/os/unix/networking/mgetty/$(MGETTY)-$(MGETTY_DATE).$(MGETTY_SUFFIX)
MGETTY_SOURCE	= $(SRCDIR)/$(MGETTY)-$(MGETTY_DATE).$(MGETTY_SUFFIX)
MGETTY_DIR	= $(BUILDDIR)/mgetty-$(MGETTY_VERSION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mgetty_get: $(STATEDIR)/mgetty.get

mgetty_get_deps = $(MGETTY_SOURCE)

$(STATEDIR)/mgetty.get: $(mgetty_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(MGETTY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MGETTY_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mgetty_extract: $(STATEDIR)/mgetty.extract

mgetty_extract_deps = $(STATEDIR)/mgetty.get

$(STATEDIR)/mgetty.extract: $(mgetty_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MGETTY_DIR))
	@$(call extract, $(MGETTY_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mgetty_prepare: $(STATEDIR)/mgetty.prepare

#
# dependencies
#
mgetty_prepare_deps = \
	$(STATEDIR)/mgetty.extract \
	$(STATEDIR)/virtual-xchain.install

MGETTY_PATH	=  PATH=$(CROSS_PATH)
MGETTY_ENV 	=  $(CROSS_ENV)
#MGETTY_ENV	+=

$(STATEDIR)/mgetty.prepare: $(mgetty_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MGETTY_DIR)/config.cache)
	cp $(PTXCONF_MGETTY_CONFIG) $(MGETTY_DIR)/policy.h
	find $(MGETTY_DIR) -name Makefile \
		-exec perl -i -p -e 's/^CFLAGS.*=.*/CFLAGS+=-DAUTO_PPP/ ;\
			s/^CC.*=.*// ;\
			s/^LDFLAGS.*=.*// ;\
			s/^LIBS.*=.*// ;\
			s/^prefix.*=.*/prefix=/' {} \;
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mgetty_compile: $(STATEDIR)/mgetty.compile

mgetty_compile_deps = $(STATEDIR)/mgetty.prepare

$(STATEDIR)/mgetty.compile: $(mgetty_compile_deps)
	@$(call targetinfo, $@)
	$(MGETTY_PATH) $(MGETTY_ENV) make -C $(MGETTY_DIR) \
		bin-all mgetty.config login.config sendfax.config
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mgetty_install: $(STATEDIR)/mgetty.install

$(STATEDIR)/mgetty.install: $(STATEDIR)/mgetty.compile
	@$(call targetinfo, $@)
	$(MGETTY_PATH) make -C $(MGETTY_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mgetty_targetinstall: $(STATEDIR)/mgetty.targetinstall

mgetty_targetinstall_deps = $(STATEDIR)/mgetty.compile

$(STATEDIR)/mgetty.targetinstall: $(mgetty_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/usr/bin
	mkdir -p $(ROOTDIR)/usr/sbin
	mkdir -p $(ROOTDIR)/usr/lib/mgetty+sendfax
	mkdir -p $(ROOTDIR)/etc/mgetty+sendfax
	
	$(INSTALL) -m 600 $(MGETTY_DIR)/login.config $(ROOTDIR)/etc/mgetty+sendfax
	$(INSTALL) -m 600 $(MGETTY_DIR)/mgetty.config $(ROOTDIR)/etc/mgetty+sendfax
	$(INSTALL) -m 600 $(MGETTY_DIR)/dialin.config $(ROOTDIR)/etc/mgetty+sendfax
	$(INSTALL) -m 644 $(MGETTY_DIR)/sendfax.config $(ROOTDIR)/etc/mgetty+sendfax
	$(INSTALL) -m 644 $(MGETTY_DIR)/faxrunq.config $(ROOTDIR)/etc/mgetty+sendfax
	$(INSTALL) -s -m 700 $(MGETTY_DIR)/mgetty $(ROOTDIR)/usr/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/mgetty
	$(INSTALL) -s -m 755 $(MGETTY_DIR)/sendfax $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/sendfax
	$(INSTALL) -s -m 755 $(MGETTY_DIR)/g3/pbm2g3 $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/pbm2g3
	$(INSTALL) -s -m 755 $(MGETTY_DIR)/g3/g3cat $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/g3cat
	$(INSTALL) -s -m 755 $(MGETTY_DIR)/g3/g32pbm $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/g32pbm
	$(INSTALL) -m 755 $(MGETTY_DIR)/fax/faxspool $(ROOTDIR)/usr/bin
	$(INSTALL) -m 755 $(MGETTY_DIR)/fax/faxrunq $(ROOTDIR)/usr/bin
	$(INSTALL) -m 755 $(MGETTY_DIR)/fax/faxq $(ROOTDIR)/usr/bin
	$(INSTALL) -m 755 $(MGETTY_DIR)/fax/faxrm $(ROOTDIR)/usr/bin
	$(INSTALL) -m 755 $(MGETTY_DIR)/fax/faxrunqd $(ROOTDIR)/usr/bin
	$(INSTALL) -s -m 755 $(MGETTY_DIR)/fax/faxq-helper $(ROOTDIR)/usr/lib/mgetty+sendfax
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/lib/mgetty+sendfax/faxq-helper
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mgetty_clean:
	rm -rf $(STATEDIR)/mgetty.*
	rm -rf $(MGETTY_DIR)

# vim: syntax=make
