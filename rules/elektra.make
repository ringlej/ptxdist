# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ELEKTRA) += elektra

#
# Paths and names
#
ELEKTRA_VERSION	:= 0.7.0-r1618
ELEKTRA		:= elektra-$(ELEKTRA_VERSION)
ELEKTRA_SUFFIX	:= tar.gz
ELEKTRA_URL	:= http://www.markus-raab.org/ftp/$(ELEKTRA).$(ELEKTRA_SUFFIX) \
		   http://www.pengutronix.de/software/ptxdist/temporary-src/$(ELEKTRA).$(ELEKTRA_SUFFIX)
ELEKTRA_SOURCE	:= $(SRCDIR)/$(ELEKTRA).$(ELEKTRA_SUFFIX)
ELEKTRA_DIR	:= $(BUILDDIR)/$(ELEKTRA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ELEKTRA_SOURCE):
	@$(call targetinfo)
	@$(call get, ELEKTRA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ELEKTRA_ENV 	:= \
	$(CROSS_ENV)

#
# FIXME:
#
# elektra does not try to link against libltdl if not built with
# --enable-ltdl-install. The right solution is probably to build an external
# libltdl and select it from kconfig.
#
# We install libltdl here, although it may collide with other packages.
#

#
# autoconf
#
ELEKTRA_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-experimental \
	--disable-valgrind-tests \
	--disable-gcov \
	--enable-shared \
	--disable-static \
	--disable-fast-install \
	--without-libiconv-prefix \
	--disable-rpath \
	--disable-xmltest \
	--disable-gconf \
	--disable-python \
	--enable-ltdl-install

ifdef PTXCONF_ELEKTRA__DEBUG
ELEKTRA_AUTOCONF += --enable-debug
else
#ELEKTRA_AUTOCONF += --disable-debug
endif

ifdef PTXCONF_ICONV
ELEKTRA_AUTOCONF += --enable-iconv
else
ELEKTRA_AUTOCONF += --disable-iconv
endif

#
# backends
#

ifdef PTXCONF_ELEKTRA__FILESYS
ELEKTRA_AUTOCONF += --enable-filesys
else
ELEKTRA_AUTOCONF += --disable-filesys
endif
ifdef PTXCONF_ELEKTRA__HOSTS
ELEKTRA_AUTOCONF += --enable-hosts
else
ELEKTRA_AUTOCONF += --disable-hosts
endif
ifdef PTXCONF_ELEKTRA__INI
ELEKTRA_AUTOCONF += --enable-ini
else
ELEKTRA_AUTOCONF += --disable-ini
endif
ifdef PTXCONF_ELEKTRA__BERKELEYDB
ELEKTRA_AUTOCONF += --enable-berkeleydb
else
ELEKTRA_AUTOCONF += --disable-berkeleydb
endif
ifdef PTXCONF_ELEKTRA__FSTAB
ELEKTRA_AUTOCONF += --enable-fstab
else
ELEKTRA_AUTOCONF += --disable-fstab
endif
ifdef PTXCONF_ELEKTRA__PASSWD
ELEKTRA_AUTOCONF += --enable-passwd
else
ELEKTRA_AUTOCONF += --disable-passwd
endif
ifdef PTXCONF_ELEKTRA__DAEMON
ELEKTRA_AUTOCONF += --enable-daemon
else
ELEKTRA_AUTOCONF += --disable-daemon
endif
ifdef PTXCONF_ELEKTRA__CPP
ELEKTRA_AUTOCONF += --enable-cpp
else
ELEKTRA_AUTOCONF += --disable-cpp
endif

#  --with-ulibdir=ULIBDIR> Set the path for usr lib.
#  --with-backenddir=<path where backend libraries are>
#                          Set the path for backend libraries.
#                          [LIBDIR/elektra@]
#  --with-hlvl-backenddir=<path where high level backend libraries are>
#                          Set the path for high level backend libraries.
#                          [ULIBDIR/elektra]
#  --with-docdir=<path where doc will be installed>
#                          Set the path for documentation.
#                          [DATADIR/doc/elektra]
#  --with-develdocdir=<path where elektra-api doc will be installed>
#                          Set the path for elektra api documentation.
#                          [DATADIR/doc/elektra-devel]
#  --with-docbook=<path to docbook.xsl>
#                          Set path to docbook.xsl used for generate manpage.
#                          [/usr/share/sgml/docbook/xsl-stylesheets]
#  --with-kdbschemadir=<relative path to kdb schema>
#                          Set the path for elektra.xsd. DATADIR will be
#                          prefixed. [/sgml/elektra-$PACKAGE_VERSION]
#  --with-default-backend=<backend>
#                          Set backend elektra will be linked to. [filesys]
#  --with-default-dbackend=<daemon backend>
#                          Set the default backend for the kdbd daemon to use.
#                          [berkeleydb]
#  --with-xml-prefix=PFX   Prefix where libxml is installed (optional)
#  --with-xml-exec-prefix=PFX Exec prefix where libxml is installed (optional)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/elektra.compile:
	@$(call targetinfo)
	cd $(ELEKTRA_DIR) && \
		$(ELEKTRA_PATH) $(MAKE) $(PARALLELMFLAGS)
	cd $(ELEKTRA_DIR)/examples && \
		$(ELEKTRA_PATH) $(MAKE) check $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/elektra.targetinstall:
	@$(call targetinfo)

	@$(call install_init, elektra)
	@$(call install_fixup, elektra,PACKAGE,elektra)
	@$(call install_fixup, elektra,PRIORITY,optional)
	@$(call install_fixup, elektra,VERSION,$(ELEKTRA_VERSION))
	@$(call install_fixup, elektra,SECTION,base)
	@$(call install_fixup, elektra,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de> <your@email.please>")
	@$(call install_fixup, elektra,DEPENDS,)
	@$(call install_fixup, elektra,DESCRIPTION,missing)

	@$(call install_copy, elektra, 0, 0, 0755, $(ELEKTRA_DIR)/src/kdb/kdb, /usr/bin/kdb)
	@$(call install_copy, elektra, 0, 0, 0755, $(ELEKTRA_DIR)/src/preload/preload, /usr/bin/preload)

	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/libelektra/.libs/libelektra.so.3.0.0, \
		/usr/lib/libelektra.so.3.0.0)
	@$(call install_link, elektra, libelektra.so.3.0.0, /usr/lib/libelektra.so.3)
	@$(call install_link, elektra, libelektra.so.3.0.0, /usr/lib/libelektra.so)

#	FIXME: libelektratools is only available if we have xml support
#
#	@$(call install_copy, elektra, 0, 0, 0644, \
#		$(ELEKTRA_DIR)/src/libelektratools/.libs/libelektratools.so.2.0.0, \
#		/usr/lib/elektra/libelektratools.so.2.0.0)
#	@$(call install_link, elektra, libelektratools.so.2.0.0, /usr/lib/elektra/libelektratools.so.2)
#	@$(call install_link, elektra, libelektratools.so.2.0.0, /usr/lib/elektra/libelektratools.so)

ifdef PTXCONF_ELEKTRA__CPP
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/bindings/cpp/.libs/libelektra-cpp.so.0.0.0, \
		/usr/lib/libelektra-cpp.so.0.0.0)
	@$(call install_link, elektra, libelektra-cpp.so.0.0.0, /usr/lib/libelektra-cpp.so.0)
	@$(call install_link, elektra, libelektra-cpp.so.0.0.0, /usr/lib/libelektra-cpp.so)
endif
ifdef PTXCONF_ELEKTRA__FILESYS
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/backends/filesys/.libs/libelektra-filesys.so, \
		/usr/lib/elektra/libelektra-filesys.so)
endif
ifdef PTXCONF_ELEKTRA__HOSTS
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/backends/hosts/.libs/libelektra-hosts.so, \
		/usr/lib/elektra/libelektra-hosts.so)
endif
ifdef PTXCONF_ELEKTRA__INI
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/backends/ini/.libs/libelektra-ini.so, \
		/usr/lib/elektra/libelektra-ini.so)
endif
ifdef PTXCONF_ELEKTRA__BERKELEYDB
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/backends/berkeleydb/.libs/libelektra-berkeleydb.so, \
		/usr/lib/elektra/libelektra-berkeleydb.so)
endif
ifdef PTXCONF_ELEKTRA__FSTAB
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/backends/fstab/.libs/libelektra-fstab.so, \
		/usr/lib/elektra/libelektra-fstab.so)
endif
ifdef PTXCONF_ELEKTRA__PASSWD
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/backends/passwd/.libs/libelektra-passwd.so, \
		/usr/lib/elektra/libelektra-passwd.so)
endif
ifdef PTXCONF_ELEKTRA__DAEMON
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/src/backends/daemon/.libs/libelektra-daemon.so, \
		/usr/lib/elektra/libelektra-daemon.so)
	@$(call install_copy, elektra, 0, 0, 0755, $(ELEKTRA_DIR)/src/backends/daemon/kdbd, /usr/sbin/kdbd)
endif

	# make link for default backend
ifdef PTXCONF_ELEKTRA__DEFAULT_BACKEND_FILESYS
	@$(call install_link, elektra, \
		libelektra-filesys.so, \
		/usr/lib/elektra/libelektra-default.so)
endif
ifdef PTXCONF_ELEKTRA__DEFAULT_BACKEND_HOSTS
	@$(call install_link, elektra, \
		libelektra-hosts.so, \
		/usr/lib/elektra/libelektra-default.so)
endif
ifdef PTXCONF_ELEKTRA__DEFAULT_BACKEND_INI
	@$(call install_link, elektra, \
		libelektra-ini.so, \
		/usr/lib/elektra/libelektra-default.so)
endif
ifdef PTXCONF_ELEKTRA__DEFAULT_BACKEND_BERKELEYDB
	@$(call install_link, elektra, \
		libelektra-berkeleydb.so, \
		/usr/lib/elektra/libelektra-default.so)
endif
ifdef PTXCONF_ELEKTRA__DEFAULT_BACKEND_FSTAB
	@$(call install_link, elektra, \
		libelektra-fstab.so, \
		/usr/lib/elektra/libelektra-default.so)
endif
ifdef PTXCONF_ELEKTRA__DEFAULT_BACKEND_PASSWD
	@$(call install_link, elektra, \
		libelektra-passwd.so, \
		/usr/lib/elektra/libelektra-default.so)
endif
ifdef PTXCONF_ELEKTRA__DEFAULT_BACKEND_DAEMON
	@$(call install_link, elektra, \
		libelektra-daemon.so, \
		/usr/lib/elektra/libelektra-default.so)
endif

	# FIXME: see note above
	@$(call install_copy, elektra, 0, 0, 0644, \
		$(ELEKTRA_DIR)/libltdl/.libs/libltdl.so.7.2.0, \
		/usr/lib/libltdl.so.7.2.0)
	@$(call install_link, elektra, libltdl.so.7.2.0, /usr/lib/libltdl.so.7)
	@$(call install_link, elektra, libltdl.so.7.2.0, /usr/lib/libltdl.so)

	@$(call install_finish, elektra)

	@$(call touch)

# vim: syntax=make
