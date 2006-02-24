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
PACKAGES-$(PTXCONF_E2FSPROGS) += e2fsprogs

#
# Paths and names 
#
E2FSPROGS_VERSION		= 1.38
E2FSPROGS			= e2fsprogs-$(E2FSPROGS_VERSION)
E2FSPROGS_SUFFIX		= tar.gz
E2FSPROGS_URL			= $(PTXCONF_SETUP_SFMIRROR)/e2fsprogs/$(E2FSPROGS).$(E2FSPROGS_SUFFIX)
E2FSPROGS_SOURCE		= $(SRCDIR)/$(E2FSPROGS).$(E2FSPROGS_SUFFIX)
E2FSPROGS_DIR			= $(BUILDDIR)/$(E2FSPROGS)
E2FSPROGS_BUILD_DIR		= $(BUILDDIR)/$(E2FSPROGS)-build

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

e2fsprogs_get: $(STATEDIR)/e2fsprogs.get

$(STATEDIR)/e2fsprogs.get: $(e2fsprogs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(E2FSPROGS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(E2FSPROGS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

e2fsprogs_extract: $(STATEDIR)/e2fsprogs.extract

$(STATEDIR)/e2fsprogs.extract: $(e2fsprogs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(E2FSPROGS_DIR))
	@$(call extract, $(E2FSPROGS_SOURCE))
	@$(call patchin, $(E2FSPROGS))
	chmod +w $(E2FSPROGS_DIR)/po/*.po
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

e2fsprogs_prepare: $(STATEDIR)/e2fsprogs.prepare

E2FSPROGS_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
E2FSPROGS_AUTOCONF	+= --enable-fsck
ifndef NATIVE
E2FSPROGS_AUTOCONF	+= --with-cc=$(COMPILER_PREFIX)gcc
E2FSPROGS_AUTOCONF	+= --with-linker=$(COMPILER_PREFIX)ld
endif
E2FSPROGS_PATH		=  PATH=$(CROSS_PATH)
E2FSPROGS_ENV		=  $(CROSS_ENV) 
E2FSPROGS_ENV		+= BUILD_CC=$(HOSTCC)

$(STATEDIR)/e2fsprogs.prepare: $(e2fsprogs_prepare_deps_default)
	@$(call targetinfo, $@)
	mkdir -p $(E2FSPROGS_BUILD_DIR) && \
	cd $(E2FSPROGS_BUILD_DIR) && \
		$(E2FSPROGS_PATH) $(E2FSPROGS_ENV) \
		$(E2FSPROGS_DIR)/configure $(E2FSPROGS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

e2fsprogs_compile: $(STATEDIR)/e2fsprogs.compile

$(STATEDIR)/e2fsprogs.compile: $(e2fsprogs_compile_deps_default) 
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
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

e2fsprogs_install: $(STATEDIR)/e2fsprogs.install

$(STATEDIR)/e2fsprogs.install: $(e2fsprogs_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, E2FSPROGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

e2fsprogs_targetinstall: $(STATEDIR)/e2fsprogs.targetinstall

$(STATEDIR)/e2fsprogs.targetinstall: $(e2fsprogs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, e2fsprogs)
	@$(call install_fixup, e2fsprogs,PACKAGE,e2fsprogs)
	@$(call install_fixup, e2fsprogs,PRIORITY,optional)
	@$(call install_fixup, e2fsprogs,VERSION,$(E2FSPROGS_VERSION))
	@$(call install_fixup, e2fsprogs,SECTION,base)
	@$(call install_fixup, e2fsprogs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, e2fsprogs,DEPENDS,)
	@$(call install_fixup, e2fsprogs,DESCRIPTION,missing)

ifdef PTXCONF_E2FSPROGS_MKFS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, $(E2FSPROGS_BUILD_DIR)/misc/mke2fs, /sbin/mke2fs)
endif
ifdef PTXCONF_E2FSPROGS_E2FSCK
	@$(call install_copy, e2fsprogs, 0, 0, 0755, $(E2FSPROGS_BUILD_DIR)/e2fsck/e2fsck.shared, /sbin/e2fsck)
endif
ifdef PTXCONF_E2FSPROGS_TUNE2FS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, $(E2FSPROGS_BUILD_DIR)/misc/tune2fs, /sbin/tune2fs)
	@$(call install_link, e2fsprogs, /sbin/tune2fs, /sbin/findfs)
	@$(call install_link, e2fsprogs, /sbin/tune2fs, /sbin/e2label)
endif

	@$(call install_finish, e2fsprogs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

e2fsprogs_clean: 
	rm -rf $(STATEDIR)/e2fsprogs.* $(E2FSPROGS_DIR) $(E2FSPROGS_BUILD_DIR)
	rm -rf $(IMAGEDIR)/e2fsprogs_*

# vim: syntax=make
