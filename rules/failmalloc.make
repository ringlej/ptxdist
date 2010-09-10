# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FAILMALLOC) += failmalloc

#
# Paths and names
#
FAILMALLOC_VERSION	:= 1.0
FAILMALLOC		:= failmalloc-$(FAILMALLOC_VERSION)
FAILMALLOC_SUFFIX	:= tar.gz
FAILMALLOC_URL		:= http://download.savannah.nongnu.org/releases/failmalloc/$(FAILMALLOC).$(FAILMALLOC_SUFFIX)
FAILMALLOC_SOURCE	:= $(SRCDIR)/$(FAILMALLOC).$(FAILMALLOC_SUFFIX)
FAILMALLOC_DIR		:= $(BUILDDIR)/$(FAILMALLOC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FAILMALLOC_SOURCE):
	@$(call targetinfo)
	@$(call get, FAILMALLOC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FAILMALLOC_PATH	:= PATH=$(CROSS_PATH)
FAILMALLOC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FAILMALLOC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-static=no

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/failmalloc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, failmalloc)
	@$(call install_fixup, failmalloc,PRIORITY,optional)
	@$(call install_fixup, failmalloc,SECTION,base)
	@$(call install_fixup, failmalloc,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, failmalloc,DESCRIPTION,missing)

	@$(call install_lib, failmalloc, 0, 0, 0644, libfailmalloc)

	@$(call install_finish, failmalloc)

	@$(call touch)

# vim: syntax=make
