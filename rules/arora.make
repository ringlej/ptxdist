# -*-makefile-*-
#
# Copyright (C) 2006 by Michael Olbrich <m.olbrich@pengutronix.de>
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
PACKAGES-$(PTXCONF_ARORA) += arora

#
# Paths and names
#
ARORA_VERSION	:= 0.11.0
ARORA_MD5	:= 64334ce4198861471cad9316d841f0cb
ARORA		:= arora-$(ARORA_VERSION)
ARORA_SUFFIX	:= tar.gz
ARORA_URL	:= http://arora.googlecode.com/files/$(ARORA).$(ARORA_SUFFIX)
ARORA_SOURCE	:= $(SRCDIR)/$(ARORA).$(ARORA_SUFFIX)
ARORA_DIR	:= $(BUILDDIR)/$(ARORA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ARORA_CONF_OPT	:= $(CROSS_QMAKE_OPT) PREFIX=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/arora.targetinstall:
	@$(call targetinfo)

	@$(call install_init, arora)
	@$(call install_fixup, arora,PRIORITY,optional)
	@$(call install_fixup, arora,SECTION,base)
	@$(call install_fixup, arora,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, arora,DESCRIPTION,missing)

	@$(call install_copy, arora, 0, 0, 0755, -, /usr/bin/arora)

	@$(call install_finish, arora)

	@$(call touch)

# vim: syntax=make
