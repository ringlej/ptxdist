# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IOZONE) += iozone

#
# Paths and names
#
IOZONE_VERSION	:= 321
IOZONE		:= iozone3_$(IOZONE_VERSION)
IOZONE_SUFFIX		:= tar
IOZONE_URL		:= http://www.iozone.org/src/current/$(IOZONE).$(IOZONE_SUFFIX)
IOZONE_SOURCE		:= $(SRCDIR)/$(IOZONE).$(IOZONE_SUFFIX)
IOZONE_DIR		:= $(BUILDDIR)/$(IOZONE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(IOZONE_SOURCE):
	@$(call targetinfo)
	@$(call get, IOZONE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/iozone.extract:
	@$(call targetinfo)
	@$(call clean, $(IOZONE_DIR))
	@$(call extract, IOZONE)
	@$(call patchin, IOZONE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IOZONE_PATH	:= PATH=$(CROSS_PATH)
IOZONE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
IOZONE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
			--disable-debug

$(STATEDIR)/iozone.prepare:
	@$(call targetinfo)
	@$(call clean, $(IOZONE_DIR)/config.cache)
	@chmod +x $(IOZONE_DIR)/configure
	cd $(IOZONE_DIR) && \
		$(IOZONE_PATH) $(IOZONE_ENV) \
		./configure $(IOZONE_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/iozone.compile:
	@$(call targetinfo)
	cd $(IOZONE_DIR) && $(IOZONE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iozone.install:
	@$(call targetinfo)
	@$(call install, IOZONE)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iozone.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iozone)
	@$(call install_fixup, iozone,PACKAGE,iozone)
	@$(call install_fixup, iozone,PRIORITY,optional)
	@$(call install_fixup, iozone,VERSION,$(IOZONE_VERSION))
	@$(call install_fixup, iozone,SECTION,base)
	@$(call install_fixup, iozone,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, iozone,DEPENDS,)
	@$(call install_fixup, iozone,DESCRIPTION,missing)

	@$(call install_copy, iozone, 0, 0, 0755, $(IOZONE_DIR)/src/current/iozone, /usr/bin/iozone)
	@$(call install_copy, iozone, 0, 0, 0755, $(IOZONE_DIR)/src/current/fileop, /usr/bin/fileop)

	@$(call install_finish, iozone)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

iozone_clean:
	rm -rf $(STATEDIR)/iozone.*
	rm -rf $(PKGDIR)/iozone_*
	rm -rf $(IOZONE_DIR)

# vim: syntax=make
