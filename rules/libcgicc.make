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
LIBCGICC		:= cgicc-$(LIBCGICC_VERSION)
LIBCGICC_SUFFIX		:= tar.gz
LIBCGICC_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/cgicc/$(LIBCGICC).$(LIBCGICC_SUFFIX)
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
	@$(call install_fixup, libcgicc,PACKAGE,libcgicc)
	@$(call install_fixup, libcgicc,PRIORITY,optional)
	@$(call install_fixup, libcgicc,VERSION,$(LIBCGICC_VERSION))
	@$(call install_fixup, libcgicc,SECTION,base)
	@$(call install_fixup, libcgicc,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libcgicc,DEPENDS,)
	@$(call install_fixup, libcgicc,DESCRIPTION,missing)

	@$(call install_copy, libcgicc, 0,0, 644, -, /usr/lib/libcgicc.so.5.0.2)
	@$(call install_link, libcgicc, libcgicc.so.5.0.2, /usr/lib/libcgicc.so.5)
	@$(call install_link, libcgicc, libcgicc.so.5.0.2, /usr/lib/libcgicc.so)

	@$(call install_finish, libcgicc)

	@$(call touch)

# vim: syntax=make
