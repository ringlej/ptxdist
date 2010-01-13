# -*-makefile-*-
#
# Copyright (C) 2009 by 
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
QWT_VERSION	:= 5.2.0
QWT		:= qwt-$(QWT_VERSION)
QWT_SUFFIX	:= tar.bz2
QWT_URL		:= $(PTXCONF_SETUP_SFMIRROR)/qwt/$(QWT).$(QWT_SUFFIX)
QWT_SOURCE	:= $(SRCDIR)/$(QWT).$(QWT_SUFFIX)
QWT_DIR		:= $(BUILDDIR)/$(QWT)
QWT_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(QWT_SOURCE):
	@$(call targetinfo)
	@$(call get, QWT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

QWT_PATH	:= PATH=$(CROSS_PATH)
QWT_CONF_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qwt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qwt)
	@$(call install_fixup, qwt,PACKAGE,qwt)
	@$(call install_fixup, qwt,PRIORITY,optional)
	@$(call install_fixup, qwt,VERSION,$(QWT_VERSION))
	@$(call install_fixup, qwt,SECTION,base)
	@$(call install_fixup, qwt,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, qwt,DEPENDS,)
	@$(call install_fixup, qwt,DESCRIPTION,missing)

	@$(call install_copy, qwt, 0, 0, 0644, -, \
		/usr/lib/libqwt.so.5.2.0)
	@$(call install_link, qwt, libqwt.so.5.2.0, \
		/usr/lib/libqwt.so.5.2)
	@$(call install_link, qwt, libqwt.so.5.2.0, \
		/usr/lib/libqwt.so.5)

	@$(call install_finish, qwt)

	@$(call touch)

# vim: syntax=make
