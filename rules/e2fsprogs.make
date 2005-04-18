# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003, 2004, 2005 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_E2FSPROGS
PACKAGES += e2fsprogs
endif

#
# Paths and names 
#
E2FSPROGS_VERSION		= 1.35
E2FSPROGS			= e2fsprogs-$(E2FSPROGS_VERSION)
E2FSPROGS_SUFFIX		= tar.gz
E2FSPROGS_URL			= $(PTXCONF_SETUP_SFMIRROR)/e2fsprogs/$(E2FSPROGS).$(E2FSPROGS_SUFFIX)
E2FSPROGS_SOURCE		= $(SRCDIR)/$(E2FSPROGS).$(E2FSPROGS_SUFFIX)
E2FSPROGS_DIR			= $(BUILDDIR)/$(E2FSPROGS)
E2FSPROGS_BUILD_DIR		= $(BUILDDIR)/$(E2FSPROGS)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

e2fsprogs_get: $(STATEDIR)/e2fsprogs.get

$(STATEDIR)/e2fsprogs.get: $(E2FSPROGS_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(E2FSPROGS))
	touch $@

$(E2FSPROGS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(E2FSPROGS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

e2fsprogs_extract: $(STATEDIR)/e2fsprogs.extract

$(STATEDIR)/e2fsprogs.extract: $(STATEDIR)/e2fsprogs.get
	@$(call targetinfo, $@)
	@$(call clean, $(E2FSPROGS_DIR))
	@$(call extract, $(E2FSPROGS_SOURCE))
	@$(call patchin, $(E2FSPROGS))
	chmod +w $(E2FSPROGS_DIR)/po/*.po
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

e2fsprogs_prepare: $(STATEDIR)/e2fsprogs.prepare

E2FSPROGS_AUTOCONF	=  $(CROSS_AUTOCONF)
E2FSPROGS_AUTOCONF	+= --prefix=/usr
E2FSPROGS_AUTOCONF	+= --enable-fsck
E2FSPROGS_AUTOCONF	+= --with-cc=$(PTXCONF_COMPILER_PREFIX)gcc
E2FSPROGS_AUTOCONF	+= --with-linker=$(PTXCONF_COMPILER_PREFIX)ld
E2FSPROGS_PATH		=  PATH=$(CROSS_PATH)
E2FSPROGS_ENV		=  $(CROSS_ENV) 
E2FSPROGS_ENV		+= BUILD_CC=$(HOSTCC)

e2fsprogs_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/e2fsprogs.extract

$(STATEDIR)/e2fsprogs.prepare: $(e2fsprogs_prepare_deps)
	@$(call targetinfo, $@)
	mkdir -p $(E2FSPROGS_BUILD_DIR) && \
	cd $(E2FSPROGS_BUILD_DIR) && \
		$(E2FSPROGS_PATH) $(E2FSPROGS_ENV) \
		$(E2FSPROGS_DIR)/configure $(E2FSPROGS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

e2fsprogs_compile: $(STATEDIR)/e2fsprogs.compile

e2fsprogs_compile_deps = $(STATEDIR)/e2fsprogs.prepare

$(STATEDIR)/e2fsprogs.compile: $(e2fsprogs_compile_deps) 
	@$(call targetinfo, $@)
#
# in the util dir are tools that are compiled for the host system
# these tools are needed later in the compile progress
#
# it's not good to pass target CFLAGS to the host compiler :)
# so override these
#
	$(E2FSPROGS_PATH) make -C $(E2FSPROGS_BUILD_DIR)/util
	$(E2FSPROGS_PATH) make -C $(E2FSPROGS_BUILD_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

e2fsprogs_install: $(STATEDIR)/e2fsprogs.install

$(STATEDIR)/e2fsprogs.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

e2fsprogs_targetinstall: $(STATEDIR)/e2fsprogs.targetinstall

$(STATEDIR)/e2fsprogs.targetinstall: $(STATEDIR)/e2fsprogs.compile
	@$(call targetinfo, $@)

	mkdir -p $(ROOTDIR)/sbin

	$(call install_init,default)
	$(call install_fixup,PACKAGE,e2fsprogs)
	$(call install_fixup,PRIORITY,optional)
	$(call install_fixup,VERSION,$(E2FSPROGS_VERSION))
	$(call install_fixup,SECTION,base)
	$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	$(call install_fixup,DEPENDS,libc)
	$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_E2FSPROGS_MKFS
	$(call install_copy, 0, 0, 0755, $(E2FSPROGS_BUILD_DIR)/misc/mke2fs, /sbin/mke2fs)
endif
ifdef PTXCONF_E2FSPROGS_E2FSCK
	$(call install_copy, 0, 0, 0755, $(E2FSPROGS_BUILD_DIR)/e2fsck/e2fsck.shared, /sbin/e2fsck)
endif

	$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

e2fsprogs_clean: 
	rm -rf $(STATEDIR)/e2fsprogs.* $(E2FSPROGS_DIR) $(E2FSPROGS_BUILD_DIR)

# vim: syntax=make
