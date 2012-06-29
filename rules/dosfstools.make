# -*-makefile-*-
#
# Copyright (C) 2005 by Steven Scholz <steven.scholz@imc-berlin.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
DOSFSTOOLS_VERSION	:= 3.0.9
DOSFSTOOLS_MD5		:= 7f159ec44d3b9c502904bab0236050e4
DOSFSTOOLS		:= dosfstools-$(DOSFSTOOLS_VERSION)
DOSFSTOOLS_SUFFIX	:= tar.bz2
DOSFSTOOLS_SRC		:= $(DOSFSTOOLS).$(DOSFSTOOLS_SUFFIX)
DOSFSTOOLS_URL		:= http://www.daniel-baumann.ch/software/dosfstools/$(DOSFSTOOLS_SRC)
DOSFSTOOLS_SOURCE	:= $(SRCDIR)/$(DOSFSTOOLS_SRC)
DOSFSTOOLS_DIR		:= $(BUILDDIR)/$(DOSFSTOOLS)

# ----------------------------------------------------------------------------
# Prepare (nothing to be done here)
# ----------------------------------------------------------------------------

DOSFSTOOLS_CONF_TOOL := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

DOSFSTOOLS_MAKE_ENV := $(CROSS_ENV)
DOSFSTOOLS_MAKE_OPT := \
	OPTFLAGS='-O2 -fomit-frame-pointer -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64' \
	PREFIX=/usr \
	SBINDIR=/sbin

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

DOSFSTOOLS_INSTALL_OPT := \
	$(DOSFSTOOLS_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dosfstools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dosfstools)
	@$(call install_fixup, dosfstools,PRIORITY,optional)
	@$(call install_fixup, dosfstools,SECTION,base)
	@$(call install_fixup, dosfstools,AUTHOR,"Steven Scholz <steven.scholz@imc-berlin.de>")
	@$(call install_fixup, dosfstools,DESCRIPTION,missing)

ifdef PTXCONF_DOSFSTOOLS_MKDOSFS
	@$(call install_copy, dosfstools, 0, 0, 0755, -, \
		/sbin/mkdosfs)
endif
ifdef PTXCONF_DOSFSTOOLS_MKDOSFS_MSDOS
	@$(call install_link, dosfstools, mkdosfs, /sbin/mkfs.msdos)
endif
ifdef PTXCONF_DOSFSTOOLS_MKDOSFS_VFAT
	@$(call install_link, dosfstools, mkdosfs, /sbin/mkfs.vfat)
endif


ifdef PTXCONF_DOSFSTOOLS_DOSFSCK
	@$(call install_copy, dosfstools, 0, 0, 0755, -, \
		/sbin/dosfsck)
endif
ifdef PTXCONF_DOSFSTOOLS_DOSFSCK_MSDOS
	@$(call install_link, dosfstools, dosfsck, /sbin/fsck.msdos)
endif
ifdef PTXCONF_DOSFSTOOLS_DOSFSCK_VFAT
	@$(call install_link, dosfstools, dosfsck, /sbin/fsck.vfat)
endif

ifdef PTXCONF_DOSFSTOOLS_DOSFSLABEL
	@$(call install_copy, dosfstools, 0, 0, 0755, -, \
		/sbin/dosfslabel)
endif

	@$(call install_finish, dosfstools)

	@$(call touch)

# vim: syntax=make
