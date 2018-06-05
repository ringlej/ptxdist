# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutroinx.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CANUTILS) += canutils

#
# Paths and names
#
CANUTILS_VERSION	:= 4.0.6
CANUTILS_MD5		:= e9af32bc41da85517b7bfe7de3bb9481
CANUTILS		:= canutils-$(CANUTILS_VERSION)
CANUTILS_SUFFIX		:= tar.bz2
CANUTILS_URL		:= http://www.pengutronix.de/software/socket-can/download/canutils/v4.0/$(CANUTILS).$(CANUTILS_SUFFIX)
CANUTILS_SOURCE		:= $(SRCDIR)/$(CANUTILS).$(CANUTILS_SUFFIX)
CANUTILS_DIR		:= $(BUILDDIR)/$(CANUTILS)
CANUTILS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CANUTILS_CONF_ENV := \
	$(CROSS_ENV) \
	CPPFLAGS="-isystem $(KERNEL_HEADERS_INCLUDE_DIR) $(CROSS_CPPFLAGS)"

#
# autoconf
#
CANUTILS_CONF_TOOL	:= autoconf
CANUTILS_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/canutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, canutils)
	@$(call install_fixup, canutils,PRIORITY,optional)
	@$(call install_fixup, canutils,SECTION,base)
	@$(call install_fixup, canutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, canutils,DESCRIPTION,missing)

ifdef PTXCONF_CANUTILS_CANCONFIG
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/usr/sbin/canconfig)
endif
ifdef PTXCONF_CANUTILS_CANECHO
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/usr/bin/canecho)
endif
ifdef PTXCONF_CANUTILS_CANDUMP
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/usr/bin/candump)
endif
ifdef PTXCONF_CANUTILS_CANSEND
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/usr/bin/cansend)
endif
ifdef PTXCONF_CANUTILS_CANSEQUENCE
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/usr/bin/cansequence)
endif
	@$(call install_finish, canutils)
	@$(call touch)

# vim: syntax=make
