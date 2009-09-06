# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Bjoern Buerger <b.buerger@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PTRTD) += ptrtd

#
# Paths and names
#
# We use the updated version from http://jk.fr.eu.org/debian/
# rather than the original from http://www.litech.org/ptrtd/
# although the archive is badly packaged (extracts to a 
# different directory name).
#

PTRTD_VERSION		:= 0.5.2
PTRTD_VERSION_SUFFIX    := -1~14
PTRTD			:= ptrtd-$(PTRTD_VERSION)
PTRTD_SUFFIX		:= tar.gz
PTRTD_URL		:= http://jk.fr.eu.org/debian/unstable/ptrtd_$(PTRTD_VERSION)$(PTRTD_VERSION_SUFFIX).$(PTRTD_SUFFIX)
PTRTD_SOURCE		:= $(SRCDIR)/ptrtd_$(PTRTD_VERSION)$(PTRTD_VERSION_SUFFIX).$(PTRTD_SUFFIX)
PTRTD_DIR		:= $(BUILDDIR)/$(PTRTD)
PTRTD_LICENSE      	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PTRTD_SOURCE):
	@$(call targetinfo)
	@$(call get, PTRTD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ptrtd.extract:
	@$(call targetinfo)
	@$(call clean, $(PTRTD_DIR))
	@$(call extract, PTRTD)
	@$(call patchin, PTRTD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PTRTD_PATH	:= PATH=$(CROSS_PATH)
PTRTD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PTRTD_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/ptrtd.prepare:
	@$(call targetinfo)
	@$(call clean, $(PTRTD_DIR)/config.cache)
	cd $(PTRTD_DIR) && \
		$(PTRTD_PATH) $(PTRTD_ENV) \
		./configure $(PTRTD_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ptrtd.compile:
	@$(call targetinfo)
	cd $(PTRTD_DIR) && $(PTRTD_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ptrtd.install:
	@$(call targetinfo)
	@$(call install, PTRTD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ptrtd.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  ptrtd)
	@$(call install_fixup, ptrtd,PACKAGE,ptrtd)
	@$(call install_fixup, ptrtd,PRIORITY,optional)
	@$(call install_fixup, ptrtd,VERSION,$(PTRTD_VERSION))
	@$(call install_fixup, ptrtd,SECTION,base)
	@$(call install_fixup, ptrtd,AUTHOR,"Bjoern Buerger <b.buerger@pengutronix.de>")
	@$(call install_fixup, ptrtd,DEPENDS,)
	@$(call install_fixup, ptrtd,DESCRIPTION,Portable Transport Relay Translator Daemon)

	# FIXME: currently, only the daemon is installed,
	#	 add init script, etc.
	@$(call install_copy, ptrtd, 0, 0, 0755, -, /usr/sbin/ptrtd)
	@$(call install_copy, ptrtd, 0, 0, 0755, -, /etc/ptrtd.tsetup)
	@$(call install_replace, ptrtd, /etc/ptrtd.tsetup, /sbin/ip, "/bin/ip")

	@$(call install_finish, ptrtd)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ptrtd_clean:
	rm -rf $(STATEDIR)/ptrtd.*
	rm -rf $(PKGDIR)/ptrtd_*
	rm -rf $(PTRTD_DIR)

# vim: syntax=make
