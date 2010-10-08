# -*-makefile-*-
#
# Copyright (C) 2006 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FAM) += fam

#
# Paths and names
#
FAM_VERSION	:= 2.7.0
FAM_MD5		:= 1bf3ae6c0c58d3201afc97c6a4834e39
FAM		:= fam-$(FAM_VERSION)
FAM_SUFFIX	:= tar.gz
FAM_URL		:= ftp://oss.sgi.com/projects/fam/download/stable/$(FAM).$(FAM_SUFFIX)
FAM_SOURCE	:= $(SRCDIR)/$(FAM).$(FAM_SUFFIX)
FAM_DIR		:= $(BUILDDIR)/$(FAM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------
$(FAM_SOURCE):
	@$(call targetinfo)
	@$(call get, FAM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/fam.extract:
	@$(call targetinfo)
	@$(call clean, $(FAM_DIR))
	@$(call extract, FAM, $(FAM_BUILDDIR))
	# configure has incorrect permissions
	chmod 755 $(FAM_DIR)/configure
	@$(call patchin, FAM, $(FAM_SRCDIR))
	mkdir -p $(FAM_DIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FAM_PATH	:= PATH=$(CROSS_PATH)
FAM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FAM_AUTOCONF	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fam.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fam)
	@$(call install_fixup, fam,PRIORITY,optional)
	@$(call install_fixup, fam,SECTION,base)
	@$(call install_fixup, fam,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, fam,DESCRIPTION,missing)

	@$(call install_copy, fam, 0, 0, 0755, -, /usr/sbin/famd)
ifdef PTXCONF_FAM_DEFAULT_CONF
	@$(call install_copy, fam, 0, 0, 0755, -, /etc/fam.conf, n)
endif
ifdef PTXCONF_FAM_LIBRARY
	@$(call install_lib, fam, 0, 0, 0644, libfam)
endif

ifdef PTXCONF_FAM_STARTUP_TYPE_STANDALONE
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_FAM_STARTSCRIPT
	@$(call install_alternative, fam, 0, 0, 0755, /etc/init.d/famd)
endif
endif
endif

ifdef PTXCONF_FAM_INETD_SERVER
	@$(call install_alternative, fam, 0, 0, 0644, /etc/inetd.conf.d/fam)
endif

	@$(call install_finish, fam)

	@$(call touch)

# vim: syntax=make
