# -*-makefile-*-
#
# Copyright (C) 2005 by Alessio Igor Bogani
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCGICC) += libcgicc

#
# Paths and names
#
LIBCGICC_VERSION	:= 3.2.9
LIBCGICC_MD5		:= 9c62692a2f08e2ee48c3ccc401047e80
LIBCGICC		:= cgicc-$(LIBCGICC_VERSION)
LIBCGICC_SUFFIX		:= tar.gz
LIBCGICC_URL		:= $(call ptx/mirror, GNU, cgicc/$(LIBCGICC).$(LIBCGICC_SUFFIX))
LIBCGICC_SOURCE		:= $(SRCDIR)/$(LIBCGICC).$(LIBCGICC_SUFFIX)
LIBCGICC_DIR		:= $(BUILDDIR)/$(LIBCGICC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBCGICC_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBCGICC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCGICC_PATH	:= PATH=$(CROSS_PATH)
LIBCGICC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBCGICC_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcgicc.targetinstall:

	@$(call targetinfo)
	@$(call install_init, libcgicc)
	@$(call install_fixup, libcgicc,PRIORITY,optional)
	@$(call install_fixup, libcgicc,SECTION,base)
	@$(call install_fixup, libcgicc,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libcgicc,DESCRIPTION,missing)

	@$(call install_lib, libcgicc, 0,0, 644, libcgicc)

	@$(call install_finish, libcgicc)

	@$(call touch)

# vim: syntax=make
