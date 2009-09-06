# -*-makefile-*-
# $Id$
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
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/totd.extract:
	@$(call targetinfo)
	@$(call clean, $(TOTD_DIR))
	@$(call extract, TOTD)
	@$(call patchin, TOTD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TOTD_PATH	:= PATH=$(CROSS_PATH)
TOTD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
TOTD_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/totd.prepare:
	@$(call targetinfo)
	@$(call clean, $(TOTD_DIR)/config.cache)
	cd $(TOTD_DIR) && \
		$(TOTD_PATH) $(TOTD_ENV) \
		./configure $(TOTD_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/totd.compile:
	@$(call targetinfo)
	cd $(TOTD_DIR) && $(TOTD_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/totd.install:
	@$(call targetinfo)
	@$(call install, TOTD)
	@$(call touch)

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

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

totd_clean:
	rm -rf $(STATEDIR)/totd.*
	rm -rf $(PKGDIR)/totd_*
	rm -rf $(TOTD_DIR)

# vim: syntax=make
