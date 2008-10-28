# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Sascha Hauer <sascha.hauer@gyro-net.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SETMIXER) += setmixer

#
# Paths and names
#
SETMIXER_VERSION	:= 27DEC94ds1
SETMIXER		:= setmixer_$(SETMIXER_VERSION).orig
SETMIXER_SUFFIX		:= tar.gz
SETMIXER_URL		:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/s/setmixer/$(SETMIXER).$(SETMIXER_SUFFIX)
SETMIXER_SOURCE		:= $(SRCDIR)/$(SETMIXER).$(SETMIXER_SUFFIX)
SETMIXER_DIR		:= $(BUILDDIR)/setmixer-27DEC94ds1.orig


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SETMIXER_SOURCE):
	@$(call targetinfo)
	@$(call get, SETMIXER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SETMIXER_PATH		:= PATH=$(CROSS_PATH)
SETMIXER_ENV 		:= $(CROSS_ENV)
SETMIXER_MAKEVARS	:= CC=$(COMPILER_PREFIX)gcc

$(STATEDIR)/setmixer.prepare:
	@$(call targetinfo)
	@$(call clean, $(SETMIXER_DIR)/config.cache)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/setmixer.compile:
	@$(call targetinfo)
	cd $(SETMIXER_DIR) && \
		$(SETMIXER_ENV) $(SETMIXER_PATH) $(MAKE) $(SETMIXER_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/setmixer.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/setmixer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, setmixer)
	@$(call install_fixup, setmixer,PACKAGE,setmixer)
	@$(call install_fixup, setmixer,PRIORITY,optional)
	@$(call install_fixup, setmixer,VERSION,$(SETMIXER_VERSION))
	@$(call install_fixup, setmixer,SECTION,base)
	@$(call install_fixup, setmixer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, setmixer,DEPENDS,)
	@$(call install_fixup, setmixer,DESCRIPTION,missing)

	@$(call install_copy, setmixer, 0, 0, 0755, $(SETMIXER_DIR)/setmixer, /usr/bin/setmixer)

	@$(call install_finish, setmixer)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

setmixer_clean:
	rm -rf $(STATEDIR)/setmixer.*
	rm -rf $(PKGDIR)/setmixer_*
	rm -rf $(SETMIXER_DIR)

# vim: syntax=make
