# -*-makefile-*-
#
# Copyright (C) 2008, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SCUMMVM) += scummvm

#
# Paths and names
#
SCUMMVM_VERSION	:= 1.0.0
SCUMMVM		:= scummvm-$(SCUMMVM_VERSION)
SCUMMVM_SUFFIX	:= tar.bz2
SCUMMVM_URL	:= $(PTXCONF_SETUP_SFMIRROR)/scummvm/$(SCUMMVM).$(SCUMMVM_SUFFIX)
SCUMMVM_SOURCE	:= $(SRCDIR)/$(SCUMMVM).$(SCUMMVM_SUFFIX)
SCUMMVM_DIR	:= $(BUILDDIR)/$(SCUMMVM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SCUMMVM_SOURCE):
	@$(call targetinfo)
	@$(call get, SCUMMVM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SCUMMVM_CONF_TOOL := autoconf
SCUMMVM_CONF_OPT := \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=/usr

SCUMMVM_MAKE_OPT := $(CROSS_ENV_AS) $(CROSS_ENV_RANLIB) AR="$(CROSS_AR) cru"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/scummvm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, scummvm)
	@$(call install_fixup, scummvm,PRIORITY,optional)
	@$(call install_fixup, scummvm,SECTION,base)
	@$(call install_fixup, scummvm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, scummvm,DESCRIPTION,missing)

	@$(call install_copy, scummvm, 0, 0, 0755, -, /usr/bin/scummvm)

	@cd $(SCUMMVM_PKGDIR) && pwd && find usr/share/scummvm -type f | while read file; do \
		$(call install_copy, scummvm, 0, 0, 0644, -, /$$file); \
	done

	@$(call install_finish, scummvm)

	@$(call touch)

# vim: syntax=make
