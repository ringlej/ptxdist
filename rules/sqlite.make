# -*-makefile-*-
#
# Copyright (C) 2004 by Ladislav Michl
#               2009 by Juergen Beisert <j.beisert@pengtronix.de>
#               2009 by Erwin Rol <erwin@erwinrol.com>
#               2010, 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Markus Rathgeb <rathgeb.markus@googlemail.com>
#               2016 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SQLITE) += sqlite

#
# Paths and names
#
SQLITE_VERSION	:= 3140100
SQLITE_MD5	:= 3634a90a3f49541462bcaed3474b2684
SQLITE		:= sqlite-autoconf-$(SQLITE_VERSION)
SQLITE_SUFFIX	:= tar.gz
SQLITE_URL	:= https://www.sqlite.org/2016/$(SQLITE).$(SQLITE_SUFFIX)
SQLITE_SOURCE	:= $(SRCDIR)/$(SQLITE).$(SQLITE_SUFFIX)
SQLITE_DIR	:= $(BUILDDIR)/$(SQLITE)
SQLITE_LICENSE	:= public_domain

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SQLITE_CONF_ENV := \
	$(CROSS_ENV) \
	CPPFLAGS=" \
	-DSQLITE_ENABLE_COLUMN_METADATA \
	-DSQLITE_ENABLE_FTS4 \
	-DSQLITE_ENABLE_JSON1 \
	-DSQLITE_ENABLE_RTREE=1 \
	-DSQLITE_ENABLE_UNLOCK_NOTIFY \
	-DSQLITE_SOUNDEX=1 \
	"

SQLITE_CONF_TOOL	:= autoconf
SQLITE_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--$(call ptx/endis,PTXCONF_SQLITE_READLINE)-readline \
	--$(call ptx/endis,PTXCONF_SQLITE_THREADSAFE)-threadsafe \
	--$(call ptx/endis,PTXCONF_SQLITE_LOAD_EXTENTION)-dynamic-extensions

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sqlite.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sqlite)
	@$(call install_fixup, sqlite,PRIORITY,optional)
	@$(call install_fixup, sqlite,SECTION,base)
	@$(call install_fixup, sqlite,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, sqlite,DESCRIPTION,missing)

	@$(call install_lib, sqlite, 0, 0, 0644, libsqlite3)

ifdef PTXCONF_SQLITE_TOOL
	@$(call install_copy, sqlite, 0, 0, 0755, -, /usr/bin/sqlite3)
endif

	@$(call install_finish, sqlite)

	@$(call touch)

# vim: syntax=make
