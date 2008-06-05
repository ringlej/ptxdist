# -*-makefile-*-
# $Id: template-make 8008 2008-04-15 07:39:46Z mkl $
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

#
# autoconf
#
SCUMMVM_AUTOCONF := \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=/usr

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
	@$(call install_fixup, scummvm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, scummvm,DEPENDS,)
	@$(call install_fixup, scummvm,DESCRIPTION,missing)

	@$(call install_copy, scummvm, 0, 0, 0755, $(SCUMMVM_DIR)/scummvm, /usr/bin/scummvm)

	@$(call install_finish, scummvm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

scummvm_clean:
	rm -rf $(STATEDIR)/scummvm.*
	rm -rf $(IMAGEDIR)/scummvm_*
	rm -rf $(SCUMMVM_DIR)

# vim: syntax=make
