# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
# Copyright (C) 2009 by Juergen Beisert <j.beisert@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBIODBC) += libiodbc

#
# Paths and names
#
LIBIODBC_VERSION	:= 3.52.7
LIBIODBC_MD5		:= ddbd274cb31d65be6a78da58fc09079a
LIBIODBC		:= libiodbc-$(LIBIODBC_VERSION)
LIBIODBC_SUFFIX		:= tar.gz
LIBIODBC_URL		:= $(call ptx/mirror, SF, iodbc/$(LIBIODBC).$(LIBIODBC_SUFFIX))
LIBIODBC_SOURCE		:= $(SRCDIR)/$(LIBIODBC).$(LIBIODBC_SUFFIX)
LIBIODBC_DIR		:= $(BUILDDIR)/$(LIBIODBC)
LIBIODBC_LICENSE	:= LGPL-2.0-only AND BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBIODBC_PATH		:= PATH=$(CROSS_PATH)
LIBIODBC_ENV 		:= $(CROSS_ENV)
LIBIODBC_MAKE_PAR	:= NO

#
# autoconf
#
LIBIODBC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-libodbc \
	--enable-pthreads \
	--disable-gtktest \
	--$(call ptx/endis, PTXCONF_LIBIODBC_GUI)-gui \
	--$(call ptx/endis, PTXCONF_LIBIODBC_DRIVER_VERSION_3)-odbc3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libiodbc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libiodbc)
	@$(call install_fixup, libiodbc,PRIORITY,optional)
	@$(call install_fixup, libiodbc,SECTION,base)
	@$(call install_fixup, libiodbc,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libiodbc,DESCRIPTION,missing)

	@$(call install_lib, libiodbc, 0, 0, 0644, libiodbc)
	@$(call install_lib, libiodbc, 0, 0, 0644, libiodbcinst)

	@$(call install_finish, libiodbc)

	@$(call touch)

# vim: syntax=make
