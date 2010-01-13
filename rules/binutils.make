# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BINUTILS) += binutils

#
# Paths and names
#
ifeq ($(shell which $(CROSS_LD) 2>/dev/null),)
BINUTILS_VERSION	:= unknown
else
BINUTILS_VERSION	:= $(shell $(CROSS_LD) -v | sed -e 's/.* \(.*\)$$/\1/g')
endif
BINUTILS		:= binutils-$(BINUTILS_VERSION)
BINUTILS_SUFFIX		:= tar.bz2
BINUTILS_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/binutils/$(BINUTILS).$(BINUTILS_SUFFIX)
BINUTILS_SOURCE		:= $(SRCDIR)/$(BINUTILS).$(BINUTILS_SUFFIX)
BINUTILS_DIR		:= $(BUILDDIR)/$(BINUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BINUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, BINUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BINUTILS_PATH	:= PATH=$(CROSS_PATH)
BINUTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BINUTILS_AUTOCONF :=  $(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--enable-targets=$(PTXCONF_GNU_TARGET) \
	--disable-nls \
	--enable-commonbfdlib \
	--enable-install-libiberty \
	--disable-multilib

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/binutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  binutils)
	@$(call install_fixup, binutils,PACKAGE,binutils)
	@$(call install_fixup, binutils,PRIORITY,optional)
	@$(call install_fixup, binutils,VERSION,$(BINUTILS_VERSION))
	@$(call install_fixup, binutils,SECTION,base)
	@$(call install_fixup, binutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, binutils,DEPENDS,)
	@$(call install_fixup, binutils,DESCRIPTION,missing)

ifdef PTXCONF_BINUTILS_READELF
	@$(call install_copy, binutils, 0, 0, 0755, -, \
		/usr/bin/readelf \
	)
endif
ifdef PTXCONF_BINUTILS_OBJDUMP
	@$(call install_copy, binutils, 0, 0, 0755, -, \
		/usr/bin/objdump \
	)
endif
	@$(call install_finish, binutils)


	@$(call touch)

# vim: syntax=make

