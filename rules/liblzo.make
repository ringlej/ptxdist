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
PACKAGES-$(PTXCONF_LIBLZO) += liblzo

#
# Paths and names
#
LIBLZO_VERSION	:= 2.03
LIBLZO_MD5	:= 0c3d078c2e8ea5a88971089a2f02a726
LIBLZO		:= lzo-$(LIBLZO_VERSION)
LIBLZO_SUFFIX	:= tar.gz
LIBLZO_URL	:= http://www.oberhumer.com/opensource/lzo/download/$(LIBLZO).$(LIBLZO_SUFFIX)
LIBLZO_SOURCE	:= $(SRCDIR)/$(LIBLZO).$(LIBLZO_SUFFIX)
LIBLZO_DIR	:= $(BUILDDIR)/$(LIBLZO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBLZO_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBLZO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBLZO_PATH	:= PATH=$(CROSS_PATH)
LIBLZO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBLZO_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBLZO_SHARED
LIBLZO_AUTOCONF += --enable-shared
else
LIBLZO_AUTOCONF += --disable-shared
endif

ifdef PTXCONF_LIBLZO_STATIC
LIBLZO_AUTOCONF += --enable-static
else
LIBLZO_AUTOCONF += --disable-static
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liblzo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liblzo)
	@$(call install_fixup, liblzo,PRIORITY,optional)
	@$(call install_fixup, liblzo,SECTION,base)
	@$(call install_fixup, liblzo,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, liblzo,DESCRIPTION,missing)

ifdef PTXCONF_LIBLZO_SHARED
	@$(call install_lib, liblzo, 0, 0, 0644, liblzo2)
endif
	@$(call install_finish, liblzo)

	@$(call touch)

# vim: syntax=make
