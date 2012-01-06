# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMSTAT) += memstat

#
# Paths and names
#
MEMSTAT_VERSION	:= 0.8
MEMSTAT_MD5	:= 8ba8c468a414dc1e7d38ea1eb832cf8c
MEMSTAT		:= memstat_$(MEMSTAT_VERSION)
MEMSTAT_SUFFIX	:= tar.gz
MEMSTAT_URL	:= $(call ptx/mirror, DEB, pool/main/m/memstat/memstat_$(MEMSTAT_VERSION).$(MEMSTAT_SUFFIX))
MEMSTAT_SOURCE	:= $(SRCDIR)/memstat_$(MEMSTAT_VERSION).$(MEMSTAT_SUFFIX)
MEMSTAT_DIR	:= $(BUILDDIR)/memstat-$(MEMSTAT_VERSION)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MEMSTAT_SOURCE):
	@$(call targetinfo)
	@$(call get, MEMSTAT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MEMSTAT_PATH	:= PATH=$(CROSS_PATH)
MEMSTAT_ENV	:= $(CROSS_ENV)

MEMSTAT_MAKEVARS := $(CROSS_ENV_CC) DEB_BUILD_OPTIONS=debug,nostrip

$(STATEDIR)/memstat.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memstat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memstat)
	@$(call install_fixup, memstat,PRIORITY,optional)
	@$(call install_fixup, memstat,SECTION,base)
	@$(call install_fixup, memstat,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, memstat,DESCRIPTION,missing)

	@$(call install_copy, memstat, 0, 0, 0644, -, /etc/memstat.conf, n)
	@$(call install_copy, memstat, 0, 0, 0755, -, /usr/bin/memstat)

	@$(call install_finish, memstat)

	@$(call touch)

# vim: syntax=make
