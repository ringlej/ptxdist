# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_COREUTILS
PACKAGES += coreutils
endif

#
# Paths and names 
#
COREUTILS		= coreutils-5.0
COREUTILS_URL		= http://ftp.gnu.org/pub/gnu/coreutils/$(COREUTILS).tar.bz2 
COREUTILS_SOURCE	= $(SRCDIR)/$(COREUTILS).tar.bz2
COREUTILS_DIR		= $(BUILDDIR)/$(COREUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

coreutils_get: $(STATEDIR)/coreutils.get

$(STATEDIR)/coreutils.get: $(COREUTILS_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(COREUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(COREUTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

coreutils_extract: $(STATEDIR)/coreutils.extract

$(STATEDIR)/coreutils.extract: $(STATEDIR)/coreutils.get
	@$(call targetinfo, $@)
	@$(call clean, $(COREUTILS_DIR))
	@$(call extract, $(COREUTILS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

coreutils_prepare: $(STATEDIR)/coreutils.prepare

COREUTILS_AUTOCONF	=  $(CROSS_AUTOCONF)
COREUTILS_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)

COREUTILS_PATH		=  PATH=$(CROSS_PATH)
COREUTILS_ENV		=  $(CROSS_ENV)

#ifdef PTXCONF_COREUTILS_SHLIKE
#COREUTILS_AUTOCONF	+= --enable-shell=sh
#else
#COREUTILS_AUTOCONF	+= --enable-shell=ksh
#endif

#
# dependencies
#
coreutils_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/coreutils.extract \

$(STATEDIR)/coreutils.prepare: $(coreutils_prepare_deps)
	@$(call targetinfo, $@)
	cd $(COREUTILS_DIR) && \
		$(COREUTILS_PATH) $(COREUTILS_ENV) \
		./configure $(COREUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

coreutils_compile_deps = $(STATEDIR)/coreutils.prepare

coreutils_compile: $(STATEDIR)/coreutils.compile

$(STATEDIR)/coreutils.compile: $(STATEDIR)/coreutils.prepare 
	@$(call targetinfo, $@)
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/lib libfetish.a
ifdef PTXCONF_COREUTILS_CP
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/src cp
endif
ifdef PTXCONF_COREUTILS_MD5SUM
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/src md5sum
endif
ifdef PTXCONF_COREUTILS_SEQ
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/src seq
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

coreutils_install: $(STATEDIR)/coreutils.install

$(STATEDIR)/coreutils.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

coreutils_targetinstall: $(STATEDIR)/coreutils.targetinstall

$(STATEDIR)/coreutils.targetinstall: $(STATEDIR)/coreutils.compile
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/bin
ifdef PTXCONF_COREUTILS_CP
	install $(COREUTILS_DIR)/src/cp $(ROOTDIR)/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/bin/cp
endif
ifdef PTXCONF_COREUTILS_MD5SUM
	install $(COREUTILS_DIR)/src/md5sum $(ROOTDIR)/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/bin/md5sum
endif
ifdef PTXCONF_COREUTILS_SEQ
	install $(COREUTILS_DIR)/src/seq $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/seq
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

coreutils_clean: 
	rm -rf $(STATEDIR)/coreutils.* $(COREUTILS_DIR)

# vim: syntax=make
