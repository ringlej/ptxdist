# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HTOP) += htop

#
# Paths and names
#
HTOP_VERSION	:= 1.0.1
HTOP_MD5	:= d3b80d905a6bff03f13896870787f901
HTOP		:= htop-$(HTOP_VERSION)
HTOP_SUFFIX	:= tar.gz
HTOP_URL	:= $(call ptx/mirror, SF, htop/$(HTOP).$(HTOP_SUFFIX))
HTOP_SOURCE	:= $(SRCDIR)/$(HTOP).$(HTOP_SUFFIX)
HTOP_DIR	:= $(BUILDDIR)/$(HTOP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HTOP_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_file__proc_stat=yes \
	ac_cv_file__proc_meminfo=yes

#
# autoconf
#
HTOP_CONF_TOOL	:= autoconf
HTOP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-unicode

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/htop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, htop)
	@$(call install_fixup, htop,PRIORITY,optional)
	@$(call install_fixup, htop,SECTION,base)
	@$(call install_fixup, htop,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, htop,DESCRIPTION,missing)

	@$(call install_copy, htop, 0, 0, 0755, -, /usr/bin/htop)

	@$(call install_finish, htop)

	@$(call touch)

# vim: syntax=make
