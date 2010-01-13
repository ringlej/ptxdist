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
PACKAGES-$(PTXCONF_LSOF) += lsof

#
# Paths and names
#
LSOF_VERSION	:= 4.81.dfsg.1
LSOF_SUFFIX	:= tar.gz
LSOF		:= lsof-$(LSOF_VERSION)
LSOF_TARBALL	:= lsof_$(LSOF_VERSION).orig.$(LSOF_SUFFIX)
LSOF_URL	:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/l/lsof/$(LSOF_TARBALL)
LSOF_SOURCE	:= $(SRCDIR)/$(LSOF_TARBALL)
LSOF_DIR	:= $(BUILDDIR)/$(LSOF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LSOF_SOURCE):
	@$(call targetinfo)
	@$(call get, LSOF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LSOF_PATH	:= PATH=$(CROSS_PATH)

LSOF_ENV 	:= \
	$(CROSS_ENV) \
	LINUX_HASSELINUX=N

LSOF_MAKEVARS	:= \
	$(CROSS_ENV_CC) \
	DEBUG=-O2

#
# autoconf
#
LSOF_AUTOCONF := -n linux

$(STATEDIR)/lsof.prepare:
	@$(call targetinfo)
	cd $(LSOF_DIR) && \
		$(LSOF_PATH) $(LSOF_ENV) \
		./Configure $(LSOF_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lsof.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lsof.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lsof)
	@$(call install_fixup, lsof,PACKAGE,lsof)
	@$(call install_fixup, lsof,PRIORITY,optional)
	@$(call install_fixup, lsof,VERSION,$(LSOF_VERSION))
	@$(call install_fixup, lsof,SECTION,base)
	@$(call install_fixup, lsof,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, lsof,DEPENDS,)
	@$(call install_fixup, lsof,DESCRIPTION,missing)

	@$(call install_copy, lsof, 0, 0, 0755, $(LSOF_DIR)/lsof, /usr/bin/lsof)

	@$(call install_finish, lsof)

	@$(call touch)

# vim: syntax=make
