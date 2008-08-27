# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMD) += libmd

#
# Paths and names
#
LIBMD_VERSION	:= 0.3
LIBMD		:= libmd-$(LIBMD_VERSION)
LIBMD_SUFFIX	:= tar.bz2
LIBMD_URL	:= ftp://ftp.penguin.cz/pub/users/mhi/libmd/$(LIBMD).$(LIBMD_SUFFIX)
LIBMD_SOURCE	:= $(SRCDIR)/$(LIBMD).$(LIBMD_SUFFIX)
LIBMD_DIR	:= $(BUILDDIR)/$(LIBMD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBMD_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBMD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libmd.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBMD_DIR))
	@$(call extract, LIBMD)
	@$(call patchin, LIBMD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMD_PATH	:= PATH=$(CROSS_PATH)
LIBMD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBMD_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libmd.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBMD_DIR)/config.cache)
	cd $(LIBMD_DIR) && \
		$(LIBMD_PATH) $(LIBMD_ENV) \
		./configure $(LIBMD_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# some fixes are required as this package uses its own makefile style
# ----------------------------------------------------------------------------
LIBMD_COMPILECONF :=

ifndef PTXCONF_LIBMD_STATIC
LIBMD_COMPILECONF += BUILD_DYN=1
endif

ifdef PTXCONF_LIBMD_DOC
LIBMD_COMPILECONF += BUILD_DOC=1
endif

$(STATEDIR)/libmd.compile:
	@$(call targetinfo)
	cd $(LIBMD_DIR) && $(LIBMD_PATH) $(MAKE) $(LIBMD_COMPILECONF) \
		$(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmd.install:
	@$(call targetinfo)
	cd $(LIBMD_DIR) && \
		$(LIBMD_PATH) $(LIBMD_ENV) \
		$(FAKEROOT) make BUILDROOT=$(PTXCONF_SYSROOT_TARGET) $(LIBMD_COMPILECONF) \
		install
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmd.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_LIBMD_STATIC
	@$(call install_init, libmd)
	@$(call install_fixup, libmd,PACKAGE,libmd)
	@$(call install_fixup, libmd,PRIORITY,optional)
	@$(call install_fixup, libmd,VERSION,$(LIBMD_VERSION))
	@$(call install_fixup, libmd,SECTION,base)
	@$(call install_fixup, libmd,AUTHOR,"Juergen Beisert <juergen\@kreuzholzen.de>")
	@$(call install_fixup, libmd,DEPENDS,)
	@$(call install_fixup, libmd,DESCRIPTION,missing)

	@$(call install_copy, libmd, 0, 0, 0644, \
		$(LIBMD_DIR)/libmd.so.1.0, /usr/lib/libmd.so.1.0)
	@$(call install_link, libmd, libmd.so.1.0, /usr/lib/libmd.so.1)
	@$(call install_link, libmd, libmd.so.1.0, /usr/lib/libmd.so)

	@$(call install_finish, libmd)
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libmd_clean:
	rm -rf $(STATEDIR)/libmd.*
	rm -rf $(PKGDIR)/libmd_*
	rm -rf $(LIBMD_DIR)

# vim: syntax=make
