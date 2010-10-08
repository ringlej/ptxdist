# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLEX) += flex

#
# Paths and names
#
FLEX_VERSION	:= 2.5.35
FLEX_MD5	:= 10714e50cea54dc7a227e3eddcd44d57
FLEX		:= flex-$(FLEX_VERSION)
FLEX_SUFFIX	:= tar.bz2
FLEX_URL	:= $(PTXCONF_SETUP_SFMIRROR)/flex/$(FLEX).$(FLEX_SUFFIX)
FLEX_SOURCE	:= $(SRCDIR)/$(FLEX).$(FLEX_SUFFIX)
FLEX_DIR	:= $(BUILDDIR)/$(FLEX)
FLEX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FLEX_SOURCE):
	@$(call targetinfo)
	@$(call get, FLEX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FLEX_PATH	:= PATH=$(CROSS_PATH)
FLEX_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FLEX_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flex.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  flex)
	@$(call install_fixup, flex,PRIORITY,optional)
	@$(call install_fixup, flex,SECTION,base)
	@$(call install_fixup, flex,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, flex,DESCRIPTION,missing)

#
# HACK:
#
# we need a ipkg, because some packages may depend on us, e.g.:
# "at"
#
# because we don't provide any shared libraries,
# we just put an existing dir into the package
#
	@$(call install_copy, flex, 0, 0, 0755, /usr/sbin)

	@$(call install_finish, flex)

	@$(call touch)

# vim: syntax=make
