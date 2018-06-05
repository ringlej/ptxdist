# -*-makefile-*-
#
# Copyright (C) 2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POPPLER_DATA) += poppler-data

#
# Paths and names
#
POPPLER_DATA_VERSION	:= 0.4.8
POPPLER_DATA_MD5	:= 00f8989c804de84af0ba2ea629949980
POPPLER_DATA		:= poppler-data-$(POPPLER_DATA_VERSION)
POPPLER_DATA_SUFFIX	:= tar.gz
POPPLER_DATA_URL	:= https://poppler.freedesktop.org/$(POPPLER_DATA).$(POPPLER_DATA_SUFFIX)
POPPLER_DATA_SOURCE	:= $(SRCDIR)/$(POPPLER_DATA).$(POPPLER_DATA_SUFFIX)
POPPLER_DATA_DIR	:= $(BUILDDIR)/$(POPPLER_DATA)
POPPLER_DATA_LICENSE	:= GPL-2.0-only AND MIT AND BSD-3-Clause
POPPLER_DATA_LICENSE_FILES	:= \
	file://COPYING;md5=4870b98343f0bbb25fa43b9d2ba59448 \
	file://COPYING.adobe;md5=63c6a8a9df204c00461fa5f163d8a663 \
	file://COPYING.gpl2;md5=751419260aa954499f7abaabaa882bbe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
POPPLER_DATA_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

POPPLER_DATA_INSTALL_OPT := prefix=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/poppler-data.targetinstall:
	@$(call targetinfo)

	@$(call install_init, poppler-data)
	@$(call install_fixup, poppler-data,PRIORITY,optional)
	@$(call install_fixup, poppler-data,SECTION,base)
	@$(call install_fixup, poppler-data,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup, poppler-data,DESCRIPTION,missing)

	@$(call install_tree, poppler-data, 0, 0, -, /usr/share/poppler)

	@$(call install_finish, poppler-data)

	@$(call touch)

# vim: ft=make ts=8 tw=80
