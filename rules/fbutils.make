# -*-makefile-*-
#
# Copyright (C) 2004 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBUTILS) += fbutils

#
# Paths and names
#
FBUTILS_VERSION	:= 20041102-1
FBUTILS_MD5	:= 5a1e431eee0673a07a4f72c751d7a8eb
FBUTILS		:= fbutils-$(FBUTILS_VERSION)
FBUTILS_SUFFIX	:= tar.gz
FBUTILS_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FBUTILS).$(FBUTILS_SUFFIX)
FBUTILS_SOURCE	:= $(SRCDIR)/$(FBUTILS).$(FBUTILS_SUFFIX)
FBUTILS_DIR	:= $(BUILDDIR)/$(FBUTILS)
FBUTILS_LICENSE := GPL-3.0-only

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

FBUTILS_PATH		:= PATH=$(CROSS_PATH)
FBUTILS_MAKE_ENV	:= $(CROSS_ENV)
FBUTILS_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbutils)
	@$(call install_fixup, fbutils,PRIORITY,optional)
	@$(call install_fixup, fbutils,SECTION,base)
	@$(call install_fixup, fbutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fbutils,DESCRIPTION,missing)

ifdef PTXCONF_FBUTILS_FBSET
	@$(call install_copy, fbutils, 0, 0, 0755, -, /usr/sbin/fbset)
endif
ifdef PTXCONF_FBUTILS_FBCMAP
	@$(call install_copy, fbutils, 0, 0, 0755, -, /usr/sbin/fbcmap)
endif
ifdef PTXCONF_FBUTILS_FBCONVERT
	@$(call install_copy, fbutils, 0, 0, 0755, -, /usr/sbin/fbconvert)
endif
ifdef PTXCONF_FBUTILS_CON2FBMAP
	@$(call install_copy, fbutils, 0, 0, 0755, -, /usr/sbin/con2fbmap)
endif
	@$(call install_finish, fbutils)

	@$(call touch)

# vim: syntax=make
