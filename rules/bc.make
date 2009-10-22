# -*-makefile-*-
# $Id: template-make 8785 2008-08-26 07:48:06Z wsa $
#
# Copyright (C) 2008 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BC) += bc

#
# Paths and names
#
BC_VERSION	:= 1.06
BC		:= bc-$(BC_VERSION)
BC_SUFFIX	:= tar.gz
BC_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/bc/$(BC).$(BC_SUFFIX)
BC_SOURCE	:= $(SRCDIR)/$(BC).$(BC_SUFFIX)
BC_DIR		:= $(BUILDDIR)/$(BC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BC_SOURCE):
	@$(call targetinfo)
	@$(call get, BC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/bc.extract:
	@$(call targetinfo)
	@$(call clean, $(BC_DIR))
	@$(call extract, BC)
	@$(call patchin, BC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BC_PATH	:= PATH=$(CROSS_PATH)
BC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/bc.prepare:
	@$(call targetinfo)
	@$(call clean, $(BC_DIR)/config.cache)
	cd $(BC_DIR) && \
		$(BC_PATH) $(BC_ENV) \
		./configure $(BC_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/bc.compile:
	@$(call targetinfo)
	cd $(BC_DIR) && $(BC_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bc.install:
	@$(call targetinfo)
	@$(call install, BC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bc)
	@$(call install_fixup, bc,PACKAGE,bc)
	@$(call install_fixup, bc,PRIORITY,optional)
	@$(call install_fixup, bc,VERSION,$(BC_VERSION))
	@$(call install_fixup, bc,SECTION,base)
	@$(call install_fixup, bc,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, bc,DEPENDS,)
	@$(call install_fixup, bc,DESCRIPTION,missing)

	@$(call install_copy, bc, 0, 0, 0755, $(BC_DIR)/bc/bc, /usr/bin/bc)

	@$(call install_finish, bc)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bc_clean:
	rm -rf $(STATEDIR)/bc.*
	rm -rf $(PKGDIR)/bc_*
	rm -rf $(BC_DIR)

# vim: syntax=make
