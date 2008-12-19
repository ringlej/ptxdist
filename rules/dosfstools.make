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
DOSFSTOOLS_VERSION	:= 3.0.1
DOSFSTOOLS		:= dosfstools-$(DOSFSTOOLS_VERSION)
DOSFSTOOLS_SUFFIX	:= tar.bz2
DOSFSTOOLS_SRC		:= $(DOSFSTOOLS).$(DOSFSTOOLS_SUFFIX)
DOSFSTOOLS_URL		:= http://www.daniel-baumann.ch/software/dosfstools/$(DOSFSTOOLS_SRC)
DOSFSTOOLS_SOURCE	:= $(SRCDIR)/$(DOSFSTOOLS_SRC)
DOSFSTOOLS_DIR		:= $(BUILDDIR)/$(DOSFSTOOLS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DOSFSTOOLS_SOURCE):
	@$(call targetinfo)
	@$(call get, DOSFSTOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DOSFSTOOLS_PATH	:= PATH=$(CROSS_PATH)
DOSFSTOOLS_ENV 	:= $(CROSS_ENV)
DOSFSTOOLS_MAKEVARS := PREFIX=/

$(STATEDIR)/dosfstools.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/dosfstools.compile:
	@$(call targetinfo)
	cd $(DOSFSTOOLS_DIR) && $(DOSFSTOOLS_ENV) $(DOSFSTOOLS_PATH) \
		make CC=$(COMPILER_PREFIX)gcc
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dosfstools.install:
	@$(call targetinfo)
	@$(call install, DOSFSTOOLS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dosfstools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dosfstools)
	@$(call install_fixup, dosfstools,PACKAGE,dosfstools)
	@$(call install_fixup, dosfstools,PRIORITY,optional)
	@$(call install_fixup, dosfstools,VERSION,$(DOSFSTOOLS_VERSION))
	@$(call install_fixup, dosfstools,SECTION,base)
	@$(call install_fixup, dosfstools,AUTHOR,"Steven Scholz <steven.scholz\@imc-berlin.de>")
	@$(call install_fixup, dosfstools,DEPENDS,)
	@$(call install_fixup, dosfstools,DESCRIPTION,missing)

ifdef PTXCONF_DOSFSTOOLS_MKDOSFS
	@$(call install_copy, dosfstools, 0, 0, 0755, $(DOSFSTOOLS_DIR)/mkdosfs, /sbin/mkdosfs)
endif
ifdef PTXCONF_DOSFSTOOLS_MKDOSFS_MSDOS
	@$(call install_link, dosfstools, /sbin/mkdosfs, /sbin/mkfs.msdos)
endif
ifdef PTXCONF_DOSFSTOOLS_MKDOSFS_VFAT
	@$(call install_link, dosfstools, /sbin/mkdosfs, /sbin/mkfs.vfat)
endif


ifdef PTXCONF_DOSFSTOOLS_DOSFSCK
	@$(call install_copy, dosfstools, 0, 0, 0755, $(DOSFSTOOLS_DIR)/dosfsck, /sbin/dosfsck)
endif
ifdef PTXCONF_DOSFSTOOLS_DOSFSCK_MSDOS
	@$(call install_link, dosfstools, /sbin/dosfsck, /sbin/fsck.msdos)
endif
ifdef PTXCONF_DOSFSTOOLS_DOSFSCK_VFAT
	@$(call install_link, dosfstools, /sbin/dosfsck, /sbin/fsck.vfat)
endif

	@$(call install_finish, dosfstools)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dosfstools_clean:
	rm -rf $(STATEDIR)/dosfstools.*
	rm -rf $(PKGDIR)/dosfstools_*
	rm -rf $(DOSFSTOOLS_DIR)

# vim: syntax=make
