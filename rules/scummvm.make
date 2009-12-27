# -*-makefile-*-
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
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
SCUMMVM_VERSION	:= 0.11.1
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

SCUMMVM_PATH	:= PATH=$(CROSS_PATH)
SCUMMVM_ENV 	:= $(CROSS_ENV)

SCUMMVM_MAKEVARS := AS=$(CROSS_AS)

#
# autoconf
#
SCUMMVM_AUTOCONF := \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=/usr

$(STATEDIR)/scummvm.prepare:
	@$(call targetinfo)
	cd $(SCUMMVM_DIR) && \
		$(SCUMMVM_PATH) $(SCUMMVM_ENV) \
		./configure $(SCUMMVM_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/scummvm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, scummvm)
	@$(call install_fixup, scummvm,PACKAGE,scummvm)
	@$(call install_fixup, scummvm,PRIORITY,optional)
	@$(call install_fixup, scummvm,VERSION,$(SCUMMVM_VERSION))
	@$(call install_fixup, scummvm,SECTION,base)
	@$(call install_fixup, scummvm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, scummvm,DEPENDS,)
	@$(call install_fixup, scummvm,DESCRIPTION,missing)

	@$(call install_copy, scummvm, 0, 0, 0755, -, /usr/bin/scummvm)

	@$(call install_copy, scummvm, 0, 0, 0644, -, /usr/share/scummvm/classic080.ini)
	@$(call install_copy, scummvm, 0, 0, 0644, -, /usr/share/scummvm/modern.ini)
	@$(call install_copy, scummvm, 0, 0, 0644, -, /usr/share/scummvm/modern.zip)

	@$(call install_finish, scummvm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

scummvm_clean:
	rm -rf $(STATEDIR)/scummvm.*
	rm -rf $(PKGDIR)/scummvm_*
	rm -rf $(SCUMMVM_DIR)

# vim: syntax=make
