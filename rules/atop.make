# -*-makefile-*-
#
# Copyright (C) 2008 by Remy Bohmer, Netherlands
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
PACKAGES-$(PTXCONF_ATOP) += atop

#
# Paths and names
#
ATOP_VERSION		:= 2.3.0
ATOP_MD5		:= 48e1dbef8c7d826e68829a8d5fc920fc
ATOP			:= atop-$(ATOP_VERSION)
ATOP_URL		:= http://www.atoptool.nl/download/$(ATOP).tar.gz
ATOP_SOURCE		:= $(SRCDIR)/$(ATOP).tar.gz
ATOP_DIR		:= $(BUILDDIR)/$(ATOP)
ATOP_LICENSE		:= GPL-2.0-or-later
ATOP_LICENSE_FILES	:= file://COPYING;md5=393a5ca445f6965873eca0259a17f833

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ATOP_CONF_TOOL		:= NO
ATOP_MAKE_OPT		:= $(CROSS_ENV)
ATOP_INSTALL_OPT	:= \
        $(ATOP_MAKE_OPT) \
        DESTDIR=$(ATOP_PKGDIR) \
        genericinstall

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/atop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, atop)
	@$(call install_fixup, atop,PRIORITY,optional)
	@$(call install_fixup, atop,SECTION,base)
	@$(call install_fixup, atop,AUTHOR,"Remy Bohmer <linux@bohmer.net>")
	@$(call install_fixup, atop,DESCRIPTION,missing)

	@$(call install_copy, atop, 0, 0, 0755, -, /usr/bin/atop)

	@$(call install_finish, atop)

	@$(call touch)

# vim: syntax=make
