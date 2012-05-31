# -*-makefile-*-
#
# Copyright (C) 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCGIC) += libcgic

#
# Paths and names
#
LIBCGIC_VERSION	:= 205
LIBCGIC_MD5	:= 49c2120d92c53cd673fac19b1596d31d
LIBCGIC		:= cgic$(LIBCGIC_VERSION)
LIBCGIC_SUFFIX	:= tar.gz
LIBCGIC_URL	:= http://www.boutell.com/cgic/$(LIBCGIC).$(LIBCGIC_SUFFIX)
LIBCGIC_SOURCE	:= $(SRCDIR)/$(LIBCGIC).$(LIBCGIC_SUFFIX)
LIBCGIC_DIR	:= $(BUILDDIR)/$(LIBCGIC)
LIBCGIC_LICENSE	:= LIBCGIC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCGIC_CONF_TOOL := NO
LIBCGIC_MAKE_ENV := $(CROSS_ENV)
LIBCGIC_MAKE_OPT := PREFIX=/usr $(CROSS_ENV_AR) $(CROSS_ENV_RANLIB)
LIBCGIC_MAKE_PAR := NO
LIBCGIC_INSTALL_OPT := $(LIBCGIC_MAKE_OPT) install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcgic.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcgic)
	@$(call install_fixup, libcgic,PRIORITY,optional)
	@$(call install_fixup, libcgic,SECTION,base)
	@$(call install_fixup, libcgic,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libcgic,DESCRIPTION,missing)

	@$(call install_lib, libcgic, 0, 0, 0644, libcgic)

	@$(call install_finish, libcgic)

	@$(call touch)

# vim: syntax=make
