# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EFAX) += efax

#
# Paths and names
#
EFAX_VERSION	:= 0.9
EFAX		:= efax-$(EFAX_VERSION)
EFAX_SUFFIX	:= tar.gz
EFAX_URL	:= ftp://ftp.metalab.unc.edu/pub/Linux/apps/serialcomm/fax/$(EFAX).$(EFAX_SUFFIX)
EFAX_SOURCE	:= $(SRCDIR)/$(EFAX).$(EFAX_SUFFIX)
EFAX_DIR	:= $(BUILDDIR)/$(EFAX)
EFAX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(EFAX_SOURCE):
	@$(call targetinfo)
	@$(call get, EFAX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EFAX_PATH	:= PATH=$(CROSS_PATH)
EFAX_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
EFAX_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/efax.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#$(STATEDIR)/efax.compile:
	@$(call targetinfo)
	cd $(EFAX_DIR) && $(EFAX_ENV) $(EFAX_PATH) make all CC=$(CROSS_CC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/efax.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/efax.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  efax)
	@$(call install_fixup, efax,PACKAGE,efax)
	@$(call install_fixup, efax,PRIORITY,optional)
	@$(call install_fixup, efax,VERSION,$(EFAX_VERSION))
	@$(call install_fixup, efax,SECTION,base)
	@$(call install_fixup, efax,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, efax,DEPENDS,)
	@$(call install_fixup, efax,DESCRIPTION,missing)

	@$(call install_copy, efax, 0, 0, 0755, $(EFAX_DIR)/efax, /usr/bin/efax)
	@$(call install_copy, efax, 0, 0, 0755, $(EFAX_DIR)/efix, /usr/bin/efix)

	@$(call install_finish, efax)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

efax_clean:
	rm -rf $(STATEDIR)/efax.*
	rm -rf $(PKGDIR)/efax_*
	rm -rf $(EFAX_DIR)

# vim: syntax=make
