# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTASN1) += libtasn1

#
# Paths and names
#
LIBTASN1_VERSION	:= 3.2
LIBTASN1_MD5		:= 1b07629163025b9693aae9b8957842b2
LIBTASN1		:= libtasn1-$(LIBTASN1_VERSION)
LIBTASN1_SUFFIX		:= tar.gz
LIBTASN1_URL		:= $(call ptx/mirror, GNU, libtasn1/$(LIBTASN1).$(LIBTASN1_SUFFIX))
LIBTASN1_SOURCE		:= $(SRCDIR)/$(LIBTASN1).$(LIBTASN1_SUFFIX)
LIBTASN1_DIR		:= $(BUILDDIR)/$(LIBTASN1)
LIBTASN1_LICENSE	:= LGPLv2.1,GPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTASN1_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtasn1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtasn1)
	@$(call install_fixup, libtasn1,PRIORITY,optional)
	@$(call install_fixup, libtasn1,SECTION,base)
	@$(call install_fixup, libtasn1,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libtasn1,DESCRIPTION,missing)

	@$(call install_lib, libtasn1, 0, 0, 0644, libtasn1)

	@$(call install_finish, libtasn1)

	@$(call touch)

# vim: syntax=make
