# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGMP) += libgmp

#
# Paths and names
#
LIBGMP_VERSION	:= 4.2.4
LIBGMP_MD5	:= fc1e3b3a2a5038d4d74138d0b9cf8dbe
LIBGMP		:= gmp-$(LIBGMP_VERSION)
LIBGMP_SUFFIX	:= tar.bz2
LIBGMP_URL	:= $(call ptx/mirror, GNU, gmp/$(LIBGMP).$(LIBGMP_SUFFIX))
LIBGMP_SOURCE	:= $(SRCDIR)/$(LIBGMP).$(LIBGMP_SUFFIX)
LIBGMP_DIR	:= $(BUILDDIR)/$(LIBGMP)
LIBGMP_LICENSE	:= GPLv3, LGPLv3

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBGMP_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBGMP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGMP_PATH	:= PATH=$(CROSS_PATH)
LIBGMP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGMP_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBGMP_SHARED
LIBGMP_AUTOCONF += --enable-shared
else
LIBGMP_AUTOCONF += --disable-shared
endif

ifdef PTXCONF_LIBGMP_STATIC
LIBGMP_AUTOCONF += --enable-static
else
LIBGMP_AUTOCONF += --disable-static
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgmp)
	@$(call install_fixup, libgmp,PRIORITY,optional)
	@$(call install_fixup, libgmp,SECTION,base)
	@$(call install_fixup, libgmp,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libgmp,DESCRIPTION,missing)

ifdef PTXCONF_LIBGMP_SHARED
	@$(call install_lib, libgmp, 0, 0, 0644, libgmp)
endif
ifdef PTXCONF_LIBGMP_STATIC
	@$(call install_copy, libgmp, 0, 0, 0644, -, /usr/lib/libgmp.la)
endif
	@$(call install_finish, libgmp)

	@$(call touch)

# vim: syntax=make
