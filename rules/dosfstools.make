# -*-makefile-*-
# $Id: template 2606 2005-05-10 21:49:41Z rsc $
#
# Copyright (C) 2005 by Steven Scholz <steven.scholz@imc-berlin.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DOSFSTOOLS) += dosfstools

#
# Paths and names
#
DOSFSTOOLS_VERSION	= 2.11
DOSFSTOOLS		= dosfstools-$(DOSFSTOOLS_VERSION)
DOSFSTOOLS_SUFFIX	= tar.gz
DOSFSTOOLS_SRC		= $(DOSFSTOOLS).src.$(DOSFSTOOLS_SUFFIX)
DOSFSTOOLS_URL		= ftp://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/$(DOSFSTOOLS_SRC)
DOSFSTOOLS_SOURCE	= $(SRCDIR)/$(DOSFSTOOLS_SRC)
DOSFSTOOLS_DIR		= $(BUILDDIR)/$(DOSFSTOOLS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dosfstools_get: $(STATEDIR)/dosfstools.get

$(STATEDIR)/dosfstools.get: $(dosfstools_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DOSFSTOOLS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DOSFSTOOLS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dosfstools_extract: $(STATEDIR)/dosfstools.extract

$(STATEDIR)/dosfstools.extract: $(dosfstools_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DOSFSTOOLS_DIR))
	@$(call extract, DOSFSTOOLS)
	@$(call patchin, DOSFSTOOLS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dosfstools_prepare: $(STATEDIR)/dosfstools.prepare

DOSFSTOOLS_PATH	=  PATH=$(CROSS_PATH)
DOSFSTOOLS_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/dosfstools.prepare: $(dosfstools_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dosfstools_compile: $(STATEDIR)/dosfstools.compile

$(STATEDIR)/dosfstools.compile: $(dosfstools_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DOSFSTOOLS_DIR) && $(DOSFSTOOLS_ENV) $(DOSFSTOOLS_PATH) \
		make CC=$(COMPILER_PREFIX)gcc
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dosfstools_install: $(STATEDIR)/dosfstools.install

$(STATEDIR)/dosfstools.install: $(dosfstools_install_deps_default)
	@$(call targetinfo, $@)
	# @$(call install, DOSFSTOOLS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dosfstools_targetinstall: $(STATEDIR)/dosfstools.targetinstall

$(STATEDIR)/dosfstools.targetinstall: $(dosfstools_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, dosfstools)
	@$(call install_fixup, dosfstools,PACKAGE,dosfstools)
	@$(call install_fixup, dosfstools,PRIORITY,optional)
	@$(call install_fixup, dosfstools,VERSION,$(DOSFSTOOLS_VERSION))
	@$(call install_fixup, dosfstools,SECTION,base)
	@$(call install_fixup, dosfstools,AUTHOR,"Steven Scholz <steven.scholz\@imc-berlin.de>")
	@$(call install_fixup, dosfstools,DEPENDS,)
	@$(call install_fixup, dosfstools,DESCRIPTION,missing)

ifdef PTXCONF_DOSFSTOOLS_MKDOSFS
	@$(call install_copy, dosfstools, 0, 0, 0755, $(DOSFSTOOLS_DIR)/mkdosfs/mkdosfs, /sbin/mkdosfs)
ifdef PTXCONF_DOSFSTOOLS_MKDOSFS_MSDOS
	@$(call install_link, dosfstools, /sbin/mkdosfs, /sbin/mkfs.msdos)
endif
ifdef PTXCONF_DOSFSTOOLS_MKDOSFS_VFAT
	@$(call install_link, dosfstools, /sbin/mkdosfs, /sbin/mkfs.vfat)
endif
endif
ifdef PTXCONF_DOSFSTOOLS_DOSFSCK
	@$(call install_copy, dosfstools, 0, 0, 0755, $(DOSFSTOOLS_DIR)/dosfsck/dosfsck, /sbin/dosfsck)
ifdef PTXCONF_DOSFSTOOLS_DOSFSCK_MSDOS
	@$(call install_link, dosfstools, /sbin/dosfsck, /sbin/fsck.msdos)
endif
ifdef PTXCONF_DOSFSTOOLS_DOSFSCK_VFAT
	@$(call install_link, dosfstools, /sbin/dosfsck, /sbin/fsck.vfat)
endif
endif

	@$(call install_finish, dosfstools)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dosfstools_clean:
	rm -rf $(STATEDIR)/dosfstools.*
	rm -rf $(PKGDIR)/dosfstools_*
	rm -rf $(DOSFSTOOLS_DIR)

# vim: syntax=make
