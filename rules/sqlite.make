# -*-makefile-*-
#
# Copyright (C) 2004 by Ladislav Michl
#               2009 by Juergen Beisert <j.beisert@pengtronix.de>
#               2009 by Erwin Rol <erwin@erwinrol.com>
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
PACKAGES-$(PTXCONF_SQLITE) += sqlite

#
# Paths and names
#
SQLITE_VERSION	:= 3.6.22
SQLITE		:= sqlite-$(SQLITE_VERSION)
SQLITE_SUFFIX	:= tar.gz
SQLITE_URL	:= http://www.sqlite.org/$(SQLITE).$(SQLITE_SUFFIX)
SQLITE_SOURCE	:= $(SRCDIR)/$(SQLITE).$(SQLITE_SUFFIX)
SQLITE_DIR	:= $(BUILDDIR)/$(SQLITE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SQLITE_SOURCE):
	@$(call targetinfo)
	@$(call get, SQLITE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SQLITE_PATH	:= PATH=$(CROSS_PATH)

# don't use := here!
SQLITE_ENV 	= \
	$(CROSS_ENV) \
	TCLLIBDIR=/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/sqlite3

SQLITE_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-releasemode \
	--disable-amalgamation

ifdef PTXCONF_SQLITE_TEMPSTORE_NEVER
SQLITE_AUTOCONF += --enable-tempstore=never
endif

ifdef PTXCONF_SQLITE_TEMPSTORE_NO
SQLITE_AUTOCONF += --enable-tempstore=no
endif

ifdef PTXCONF_SQLITE_TEMPSTORE_YES
SQLITE_AUTOCONF += --enable-tempstore=yes
endif

ifdef PTXCONF_SQLITE_TEMPSTORE_ALWAYS
SQLITE_AUTOCONF += --enable-tempstore=always
endif

ifdef PTXCONF_SQLITE_THREADSAFE
SQLITE_AUTOCONF += --enable-threadsafe
else
SQLITE_AUTOCONF += --disable-threadsafe
endif

ifdef PTXCONF_SQLITE_CROSS_THREAD_CONNECTIONS
SQLITE_AUTOCONF += --enable-cross-thread-connections
else
SQLITE_AUTOCONF += --disable-cross-thread-connections
endif

ifdef PTXCONF_SQLITE_THREAD_OVERRIDE_LOCKS
SQLITE_AUTOCONF += --enable-threads-override-locks
else
SQLITE_AUTOCONF += --disable-threads-override-locks
endif

ifdef PTXCONF_SQLITE_LOAD_EXTENTION
SQLITE_AUTOCONF += --enable-load-extension
else
SQLITE_AUTOCONF += --disable-load-extension
endif

ifdef PTXCONF_SQLITE_TCL
SQLITE_AUTOCONF += \
	--enable-tcl \
	--with-tcl="$(SYSROOT)/usr/lib"
else
SQLITE_AUTOCONF += --disable-tcl
endif

ifdef PTXCONF_SQLITE_READLINE
SQLITE_AUTOCONF += \
	--enable-readline \
	--with-readline-inc="-I$(SYSROOT)/include/readline"
else
SQLITE_AUTOCONF += --disable-readline
endif

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

	@$(call install_lib, sqlite, 0, 0, 0644, libsqlite3-$(SQLITE_VERSION))

ifdef PTXCONF_SQLITE_TOOL
	@$(call install_copy, sqlite, 0, 0, 0755, -, /usr/bin/sqlite3)
endif

ifdef PTXCONF_SQLITE_TCL
	@$(call install_copy, sqlite, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/sqlite3/libtclsqlite3.so)
	@$(call install_copy, sqlite, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/sqlite3/pkgIndex.tcl)
endif
	@$(call install_finish, sqlite)

	@$(call touch)

# vim: syntax=make
