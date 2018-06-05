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
PACKAGES-$(PTXCONF_CUPS_FILTERS) += cups-filters

#
# Paths and names
#
CUPS_FILTERS_VERSION	:= 1.17.9
CUPS_FILTERS_MD5	:= 2ef5f2b902bcdcb963c5ef5858976bbc
CUPS_FILTERS		:= cups-filters-$(CUPS_FILTERS_VERSION)
CUPS_FILTERS_SUFFIX	:= tar.xz
CUPS_FILTERS_URL	:= http://openprinting.org/download/cups-filters/$(CUPS_FILTERS).$(CUPS_FILTERS_SUFFIX)
CUPS_FILTERS_SOURCE	:= $(SRCDIR)/$(CUPS_FILTERS).$(CUPS_FILTERS_SUFFIX)
CUPS_FILTERS_DIR	:= $(BUILDDIR)/$(CUPS_FILTERS)
CUPS_FILTERS_LICENSE	:= GPL-2.0-only AND GPL-2.0-or-later AND GPL-3.0-only AND GPL-3.0-or-later AND LGPL-2 AND LGPL-2.1-or-later AND MIT AND BSD-4-Clause
CUPS_FILTERS_LICENSE_FILES	:= file://COPYING;md5=794bc12f02f100806cd5f19304d03f7b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CUPS_FILTERS_CONF_TOOL	:= autoconf
CUPS_FILTERS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-silent-rules \
	--disable-driverless \
	--disable-auto-setup-driverless \
	--$(call ptx/endis,PTXCONF_CUPS_FILTERS_IMAGEFILTERS)-imagefilters \
	--disable-avahi \
	--disable-ldap \
	--$(call ptx/endis,PTXCONF_CUPS_FILTERS_PCLM)-pclm \
	--$(call ptx/endis,PTXCONF_CUPS_FILTERS_POPPLER)-poppler \
	--disable-dbus \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-mutool \
	--disable-ghostscript \
	--disable-ijs \
	--disable-gs-ps2write \
	--disable-foomatic \
	--disable-werror \
	--disable-braille \
	--with-gnu-ld \
	--with-cups-config=$(PTXDIST_SYSROOT_CROSS)/bin/cups-config \
	--with-apple-raster-filter=rastertopdf \
	--with-cups-rundir=/run \
	--with-cups-domainsocket=/run/cups.sock \
	--$(call ptx/wwo,PTXCONF_CUPS_FILTERS_JPEG)-jpeg \
	--$(call ptx/wwo,PTXCONF_CUPS_FILTERS_PNG)-png \
	--without-tiff \
	--with-browseremoteprotocols="dnssd cups" \
	--with-pdftops=pdftops

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cups-filters.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cups-filters)
	@$(call install_fixup, cups-filters,PRIORITY,optional)
	@$(call install_fixup, cups-filters,SECTION,base)
	@$(call install_fixup, cups-filters,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup, cups-filters,DESCRIPTION,missing)

	@$(call install_lib, cups-filters, 0, 0, 0644, libcupsfilters)
	@$(call install_lib, cups-filters, 0, 0, 0644, libfontembed)
	@$(call install_tree, cups-filters, 0, 0, -, /usr/lib/cups/filter)
	@$(call install_tree, cups-filters, 0, 0, -, /usr/lib/cups/backend)
	@$(call install_tree, cups-filters, 0, 0, -, /usr/share/cups)
	@$(call install_tree, cups-filters, 0, 0, -, /usr/share/ppd)

	@$(call install_finish, cups-filters)

	@$(call touch)

# vim: ft=make ts=8 tw=80
