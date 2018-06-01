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
PACKAGES-$(PTXCONF_MICROCOM) += microcom

#
# Paths and names
#
MICROCOM_VERSION	:= 2017.03.0
MICROCOM_MD5		:= 801d99dcb4b2ef7e8b77b51bba193066
MICROCOM		:= microcom-$(MICROCOM_VERSION)
MICROCOM_SUFFIX		:= tar.xz
MICROCOM_URL		:= http://www.pengutronix.de/software/microcom/download/$(MICROCOM).$(MICROCOM_SUFFIX)
MICROCOM_SOURCE		:= $(SRCDIR)/$(MICROCOM).$(MICROCOM_SUFFIX)
MICROCOM_DIR		:= $(BUILDDIR)/$(MICROCOM)
MICROCOM_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MICROCOM_CONF_TOOL := autoconf
MICROCOM_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-can \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/microcom.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  microcom)
	@$(call install_fixup, microcom,PRIORITY,optional)
	@$(call install_fixup, microcom,SECTION,base)
	@$(call install_fixup, microcom,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, microcom,DESCRIPTION,missing)

	@$(call install_copy, microcom, 0, 0, 0755, -, /usr/bin/microcom)

	@$(call install_finish, microcom)
	@$(call touch)

# vim: syntax=make
