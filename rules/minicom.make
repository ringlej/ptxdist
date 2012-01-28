# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MINICOM) += minicom

#
# Paths and names
#
MINICOM_VERSION	:= 2.4
MINICOM_MD5	:= 700976a3c2dcc8bbd50ab9bb1c08837b
MINICOM		:= minicom-$(MINICOM_VERSION)
MINICOM_SUFFIX	:= tar.gz
MINICOM_URL	:= http://alioth.debian.org/frs/download.php/3195/$(MINICOM).$(MINICOM_SUFFIX)
MINICOM_SOURCE	:= $(SRCDIR)/$(MINICOM).$(MINICOM_SUFFIX)
MINICOM_DIR	:= $(BUILDDIR)/$(MINICOM)
MINICOM_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MINICOM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--enable-socket \
	--disable-music

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/minicom.targetinstall:
	@$(call targetinfo)

	@$(call install_init, minicom)
	@$(call install_fixup, minicom,PRIORITY,optional)
	@$(call install_fixup, minicom,SECTION,base)
	@$(call install_fixup, minicom,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, minicom,DESCRIPTION,missing)

	@$(call install_copy, minicom, 0, 0, 0755, -, /usr/bin/minicom)
	@$(call install_copy, minicom, 0, 0, 0755, -, /usr/bin/runscript)
	@$(call install_copy, minicom, 0, 0, 0755, -, /usr/bin/ascii-xfr)

ifdef PTXCONF_MINICOM_DEFCONFIG
	@$(call install_alternative, minicom, 0, 0, 0644, /etc/minirc.dfl)
endif
	@$(call install_finish, minicom)

	@$(call touch)

# vim: syntax=make
