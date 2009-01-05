# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by BSP
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ETHERWAKE) += etherwake

#
# Paths and names
#
ETHERWAKE_VERSION	:= 1.09.orig
ETHERWAKE_SUFFIX	:= tar.gz
ETHERWAKE		:= etherwake-$(ETHERWAKE_VERSION)
ETHERWAKE_TARBALL	:= etherwake_$(ETHERWAKE_VERSION).$(ETHERWAKE_SUFFIX)
ETHERWAKE_SOURCE	:= $(SRCDIR)/$(ETHERWAKE_TARBALL)
ETHERWAKE_DIR		:= $(BUILDDIR)/$(ETHERWAKE)

ETHERWAKE_URL := \
	$(PTXCONF_SETUP_DEBMIRROR)/pool/main/e/etherwake/$(ETHERWAKE_TARBALL) \
	http://www.pengutronix.de/software/ptxdist/temporary-src/$(ETHERWAKE_TARBALL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ETHERWAKE_SOURCE):
	@$(call targetinfo)
	@$(call get, ETHERWAKE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ETHERWAKE_PATH	:= PATH=$(CROSS_PATH)
ETHERWAKE_ENV 	:= $(CROSS_ENV)

ETHERWAKE_MAKEVARS := CC=$(CROSS_CC)

$(STATEDIR)/etherwake.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/etherwake.targetinstall:
	@$(call targetinfo)

	@$(call install_init, etherwake)
	@$(call install_fixup, etherwake,PACKAGE,etherwake)
	@$(call install_fixup, etherwake,PRIORITY,optional)
	@$(call install_fixup, etherwake,VERSION,$(ETHERWAKE_VERSION))
	@$(call install_fixup, etherwake,SECTION,base)
	@$(call install_fixup, etherwake,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, etherwake,DEPENDS,)
	@$(call install_fixup, etherwake,DESCRIPTION,missing)

	@$(call install_copy, etherwake, 0, 0, 0755, $(ETHERWAKE_DIR)/etherwake, /usr/sbin/etherwake)

	@$(call install_finish, etherwake)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

etherwake_clean:
	rm -rf $(STATEDIR)/etherwake.*
	rm -rf $(PKGDIR)/etherwake_*
	rm -rf $(ETHERWAKE_DIR)

# vim: syntax=make
