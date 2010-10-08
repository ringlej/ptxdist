# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MYODBC) += myodbc

#
# Paths and names
#
MYODBC_VERSION	:= 3.51.27r695
MYODBC_MD5	:= bb3df0778a7dc99d88ce1146ea709cbe
MYODBC		:= mysql-connector-odbc-$(MYODBC_VERSION)
MYODBC_SUFFIX	:= tar.gz
MYODBC_URL	:= http://mysql.cbn.net.id/Downloads/Connector-ODBC/3.51/$(MYODBC).$(MYODBC_SUFFIX)
MYODBC_SOURCE	:= $(SRCDIR)/$(MYODBC).$(MYODBC_SUFFIX)
MYODBC_DIR	:= $(BUILDDIR)/$(MYODBC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MYODBC_SOURCE):
	@$(call targetinfo)
	@$(call get, MYODBC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MYODBC_PATH	:= PATH=$(CROSS_PATH)
MYODBC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
MYODBC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-mysql-path=$(SYSROOT)/usr \
	--with-iODBC=$(SYSROOT)/usr \
	--enable-myodbc3i \
	--disable-gui \
	--with-ltdl-path=$(SYSROOT)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/myodbc.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  myodbc)
	@$(call install_fixup, myodbc,PRIORITY,optional)
	@$(call install_fixup, myodbc,SECTION,base)
	@$(call install_fixup, myodbc,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, myodbc,DESCRIPTION,missing)

	@$(call install_copy, myodbc, 0, 0, 0644, -, /usr/lib/libmyodbc3_r-3.51.27.so)
	@$(call install_link, myodbc, libmyodbc3_r-3.51.27.so, /usr/lib/libmyodbc3_r.so)

	@$(call install_copy, myodbc, 0, 0, 0644, -, /usr/lib/libmyodbc3-3.51.27.so)
	@$(call install_link, myodbc, libmyodbc3-3.51.27.so, /usr/lib/libmyodbc3.so)

	@$(call install_copy, myodbc, 0, 0, 0775, -, /usr/bin/myodbc3i)
	@$(call install_copy, myodbc, 0, 0, 0775, -, /usr/bin/myodbc3m)

	@$(call install_finish, myodbc)

	@$(call touch)

# vim: syntax=make
