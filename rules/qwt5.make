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
PACKAGES-$(PTXCONF_QWT5) += qwt5

#
# Paths and names
#
QWT5_VERSION	:= 6.1.3
QWT5_MD5	:= 19d1f5fa5e22054d22ee3accc37c54ba
QWT5		:= qwt-$(QWT5_VERSION)
QWT5_SUFFIX	:= tar.bz2
QWT5_URL	:= $(call ptx/mirror, SF, qwt/$(QWT5).$(QWT5_SUFFIX))
QWT5_SOURCE	:= $(SRCDIR)/$(QWT5).$(QWT5_SUFFIX)
QWT5_DIR	:= $(BUILDDIR)/$(QWT5)
QWT5_BUILD_OOT	:= YES
QWT5_LICENSE	:= LGPL-2.1-only AND QWT-1.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

QWT5_PATH	:= PATH=$(PTXDIST_SYSROOT_CROSS)/bin/qt5:$(CROSS_PATH)

QWT5_CONF_OPT	:= $(CROSS_QMAKE_OPT) TARGET_TEMPLATE=lib

ifdef PTXCONF_QWT5_SVG
QWT5_CONF_OPT += QWT5_CONFIG+=QwtSvg
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qwt5.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qwt5)
	@$(call install_fixup, qwt5,PRIORITY,optional)
	@$(call install_fixup, qwt5,SECTION,base)
	@$(call install_fixup, qwt5,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, qwt5,DESCRIPTION,"widget set for technical apps")

	@$(call install_lib, qwt5, 0, 0, 0644, libqwt)

	@$(call install_finish, qwt5)

	@$(call touch)

# vim: syntax=make
