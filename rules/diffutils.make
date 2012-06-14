# -*-makefile-*-
#
# Copyright (C) 2005 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIFFUTILS) += diffutils

#
# Paths and names
#
DIFFUTILS_VERSION	:= 2.8.1
DIFFUTILS_MD5		:= 71f9c5ae19b60608f6c7f162da86a428
DIFFUTILS		:= diffutils-$(DIFFUTILS_VERSION)
DIFFUTILS_SUFFIX	:= tar.gz
DIFFUTILS_URL		:= $(call ptx/mirror, GNU, diffutils/$(DIFFUTILS).$(DIFFUTILS_SUFFIX))
DIFFUTILS_SOURCE	:= $(SRCDIR)/$(DIFFUTILS).$(DIFFUTILS_SUFFIX)
DIFFUTILS_DIR		:= $(BUILDDIR)/$(DIFFUTILS)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DIFFUTILS_PATH	:= PATH=$(CROSS_PATH)
DIFFUTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DIFFUTILS_AUTOCONF :=  $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/diffutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, diffutils)
	@$(call install_fixup, diffutils,PRIORITY,optional)
	@$(call install_fixup, diffutils,SECTION,base)
	@$(call install_fixup, diffutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, diffutils,DESCRIPTION,missing)

ifdef PTXCONF_DIFFUTILS_DIFF
	@$(call install_copy, diffutils, 0, 0, 0755, -, /usr/bin/diff)
endif
ifdef PTXCONF_DIFFUTILS_DIFF3
	@$(call install_copy, diffutils, 0, 0, 0755, -, /usr/bin/diff3)
endif
ifdef PTXCONF_DIFFUTILS_SDIFF
	@$(call install_copy, diffutils, 0, 0, 0755, -, /usr/bin/sdiff)
endif
ifdef PTXCONF_DIFFUTILS_CMP
	@$(call install_copy, diffutils, 0, 0, 0755, -, /usr/bin/cmp)
endif

	@$(call install_finish, diffutils)

	@$(call touch)

# vim: syntax=make
