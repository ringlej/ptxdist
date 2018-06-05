# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BONNIEXX) += bonniexx

#
# Paths and names
#
BONNIEXX_VERSION	:= 1.97.3
BONNIEXX_MD5		:= e4be8977e8f7e6d4375a8d1dadda8d9e
BONNIEXX		:= bonnie++-$(BONNIEXX_VERSION)
BONNIEXX_SUFFIX		:= tgz
BONNIEXX_URL		:= http://www.coker.com.au/bonnie++/$(BONNIEXX).$(BONNIEXX_SUFFIX)
BONNIEXX_SOURCE		:= $(SRCDIR)/$(BONNIEXX).$(BONNIEXX_SUFFIX)
BONNIEXX_DIR		:= $(BUILDDIR)/$(BONNIEXX)
BONNIEXX_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BONNIEXX_ENV	:= \
	$(CROSS_ENV) \
	bonnie_cv_sys_largefile=$(call ptx/yesno, PTXCONF_GLOBAL_LARGE_FILE)

#
# autoconf
#
BONNIEXX_CONF_TOOL	:= autoconf
BONNIEXX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-stripping

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bonniexx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bonniexx)
	@$(call install_fixup, bonniexx,PRIORITY,optional)
	@$(call install_fixup, bonniexx,SECTION,base)
	@$(call install_fixup, bonniexx,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bonniexx,DESCRIPTION,missing)

	@$(call install_copy, bonniexx, 0, 0, 0755, -, /usr/sbin/bonnie++)

	@$(call install_finish, bonniexx)

	@$(call touch)

# vim: syntax=make
