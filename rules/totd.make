# -*-makefile-*-
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
PACKAGES-$(PTXCONF_TOTD) += totd

#
# Paths and names
#
TOTD_VERSION	:= 1.5
TOTD		:= totd-$(TOTD_VERSION)
TOTD_SUFFIX		:= tar.gz
TOTD_URL		:= ftp://ftp.pasta.cs.uit.no/pub/Vermicelli//$(TOTD).$(TOTD_SUFFIX)
TOTD_SOURCE		:= $(SRCDIR)/$(TOTD).$(TOTD_SUFFIX)
TOTD_DIR		:= $(BUILDDIR)/$(TOTD)
PTRTD_LICENSE      	:= multiple, BSD Style

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TOTD_SOURCE):
	@$(call targetinfo)
	@$(call get, TOTD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TOTD_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/totd.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  totd)
	@$(call install_fixup, totd,PACKAGE,totd)
	@$(call install_fixup, totd,PRIORITY,optional)
	@$(call install_fixup, totd,VERSION,$(TOTD_VERSION))
	@$(call install_fixup, totd,SECTION,base)
	@$(call install_fixup, totd,AUTHOR,"Bjoern Buerger <b.buerger@pengutronix.de>")
	@$(call install_fixup, totd,DEPENDS,)
	@$(call install_fixup, totd,DESCRIPTION,missing)

	@$(call install_copy, totd, 0, 0, 0755, $(TOTD_DIR)/foobar, /dev/null)

	@$(call install_finish, totd)

	@$(call touch)

# vim: syntax=make
