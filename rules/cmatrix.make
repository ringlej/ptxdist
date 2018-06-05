# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CMATRIX) += cmatrix

#
# Paths and names
#
CMATRIX_VERSION	:= 1.2a
CMATRIX_MD5	:= ebfb5733104a258173a9ccf2669968a1
CMATRIX		:= cmatrix-$(CMATRIX_VERSION)
CMATRIX_SUFFIX	:= tar.gz
CMATRIX_URL	:= http://www.asty.org/cmatrix/dist/$(CMATRIX).$(CMATRIX_SUFFIX)
CMATRIX_SOURCE	:= $(SRCDIR)/$(CMATRIX).$(CMATRIX_SUFFIX)
CMATRIX_DIR	:= $(BUILDDIR)/$(CMATRIX)
CMATRIX_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CMATRIX_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_file__usr_lib_kbd_consolefonts=no \
	ac_cv_file__usr_share_consolefonts=yes \
	ac_cv_file__usr_lib_X11_fonts_misc=no \
	ac_cv_file__usr_X11R6_lib_X11_fonts_misc=no

#
# autoconf
#
CMATRIX_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cmatrix.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cmatrix)
	@$(call install_fixup, cmatrix,PRIORITY,optional)
	@$(call install_fixup, cmatrix,SECTION,base)
	@$(call install_fixup, cmatrix,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, cmatrix,DESCRIPTION,missing)

	@$(call install_copy, cmatrix, 0, 0, 0755, -, /usr/bin/cmatrix)

	@$(call install_copy, cmatrix, 0, 0, 0644, -, /usr/share/consolefonts/matrix.fnt)
	@$(call install_copy, cmatrix, 0, 0, 0644, -, /usr/share/consolefonts/matrix.psf.gz)

	@$(call install_finish, cmatrix)

	@$(call touch)

# vim: syntax=make
