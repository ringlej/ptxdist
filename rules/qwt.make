# -*-makefile-*-
#
# Copyright (C) 2009,2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QWT) += qwt

#
# Paths and names
#
QWT_VERSION	:= 6.0.1
QWT_MD5		:= ace68558eab873e2da7e641179c4ef0c
QWT		:= qwt-$(QWT_VERSION)
QWT_SUFFIX	:= tar.bz2
QWT_URL		:= $(PTXCONF_SETUP_SFMIRROR)/qwt/$(QWT).$(QWT_SUFFIX)
QWT_SOURCE	:= $(SRCDIR)/$(QWT).$(QWT_SUFFIX)
QWT_DIR		:= $(BUILDDIR)/$(QWT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

QWT_CONF_OPT	:= $(CROSS_QMAKE_OPT)

ifdef PTXCONF_QWT_SVG
QWT_CONF_OPT += QWT_CONFIG+=QwtSvg
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qwt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qwt)
	@$(call install_fixup, qwt,PRIORITY,optional)
	@$(call install_fixup, qwt,SECTION,base)
	@$(call install_fixup, qwt,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, qwt,DESCRIPTION,missing)

	@$(call install_lib, qwt, 0, 0, 0644, libqwt)

	@$(call install_finish, qwt)

	@$(call touch)

# vim: syntax=make
