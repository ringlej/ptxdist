# -*-makefile-*-
#
# Copyright (C) 2007 by Tom St
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SJINN) += sjinn

#
# Paths and names
#
SJINN_VERSION	:= 1.01
SJINN		:= sjinn-$(SJINN_VERSION)
SJINN_SUFFIX	:= tar.gz
SJINN_URL	:= http://downloads.sourceforge.net/sjinn/$(SJINN).$(SJINN_SUFFIX)
SJINN_SOURCE	:= $(SRCDIR)/$(SJINN).$(SJINN_SUFFIX)
SJINN_DIR	:= $(BUILDDIR)/$(SJINN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SJINN_SOURCE):
	@$(call targetinfo)
	@$(call get, SJINN)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/sjinn.extract:
	@$(call targetinfo)
	@$(call clean, $(SJINN_DIR))
	@$(call extract, SJINN)
	mv $(BUILDDIR)/sjinn $(BUILDDIR)/$(SJINN)
	@$(call patchin, SJINN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SJINN_PATH	:= PATH=$(CROSS_PATH)
SJINN_ENV 	:= $(CROSS_ENV)

SJINN_MAKE_OPT := \
	CC=$(CROSS_CC) \
	prefix=/usr

SJINN_INSTALL_OPT := \
	install \
	prefix=$(SJINN_PKGDIR)/usr

$(STATEDIR)/sjinn.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sjinn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sjinn)
	@$(call install_fixup, sjinn,PRIORITY,optional)
	@$(call install_fixup, sjinn,SECTION,base)
	@$(call install_fixup, sjinn,AUTHOR,"Tom St")
	@$(call install_fixup, sjinn,DESCRIPTION,missing)

	@$(call install_copy, sjinn, 0, 0, 0755, -, /usr/bin/rs232)

	@$(call install_finish, sjinn)

	@$(call touch)

# vim: syntax=make
