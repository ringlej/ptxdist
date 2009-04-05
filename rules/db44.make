# -*-makefile-*-
#
# Copyright (C) 2003 by Werner Schmitt <mail2ws@gmx.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DB44) += db44

#
# Paths and names
#
DB44_VERSION	:= 4.4.20.NC
DB44		:= db-$(DB44_VERSION)
DB44_SUFFIX	:= tar.gz
DB44_URL	:= http://download.oracle.com/berkeley-db/$(DB44).$(DB44_SUFFIX)
DB44_SOURCE	:= $(SRCDIR)/$(DB44).$(DB44_SUFFIX)
DB44_DIR	:= $(BUILDDIR)/$(DB44)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DB44_SOURCE):
	@$(call targetinfo)
	@$(call get, DB44)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DB44_PATH	:=  PATH=$(CROSS_PATH)
DB44_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
#FIXME add menuconfig options for these
DB44_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-cryptography \
	--enable-hash \
	--enable-queue \
	--disable-replication \
	--disable-statistics \
	--disable-verify \
	--enable-compat185 \
	--enable-cxx \
	--disable-debug \
	--disable-debug_rop \
	--disable-debug_wop \
	--disable-diagnostic \
	--disable-dump185 \
	--disable-java \
	--disable-mingw \
	--enable-o_direct \
	--enable-posixmutexes \
	--enable-pthread_self \
	--disable-rpc \
	--enable-smallbuild \
	--disable-tcl \
	--disable-test \
	--disable-uimutexes \
	--disable-umrw \
	--enable-shared \
	--disable-static \
	--enable-largefile

$(STATEDIR)/db44.prepare:
	@$(call targetinfo)
	@$(call clean, $(DB44_BUILDDIR))
	cd $(DB44_DIR)/build_unix && \
		$(DB44_PATH) $(DB44_ENV) \
		../dist/configure $(DB44_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/db44.compile:
	@$(call targetinfo)
	cd $(DB44_DIR)/build_unix && \
		$(DB44_PATH) $(MAKE) $(PARALLALMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/db44.install:
	@$(call targetinfo)
	@$(call install, DB44, $(DB44_DIR)/build_unix)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/db44.targetinstall:
	@$(call targetinfo)

	@$(call install_init, db44)
	@$(call install_fixup, db44,PACKAGE,db44)
	@$(call install_fixup, db44,PRIORITY,optional)
	@$(call install_fixup, db44,VERSION,$(DB44_VERSION))
	@$(call install_fixup, db44,SECTION,base)
	@$(call install_fixup, db44,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, db44,DEPENDS,)
	@$(call install_fixup, db44,DESCRIPTION,missing)

	@for file in \
		db_archive \
		db_checkpoint \
		db_deadlock \
		db_dump \
		db_hotbackup \
		db_load \
		db_printlog \
		db_recover \
		db_stat \
		db_upgrade \
		db_verify \
		;do \
		$(call install_copy, db41, 0, 0, 0755, -, /usr/bin/$$file); \
	done

	@$(call install_copy, db44, 0, 0, 0644, -, /usr/lib/libdb-4.4.so)
	@$(call install_link, db44, libdb-4.4.so, /usr/lib/libdb-4.so)
	@$(call install_link, db44, libdb-4.4.so, /usr/lib/libdb.so)

	@$(call install_copy, db44, 0, 0, 0644, -, /usr/lib/libdb_cxx-4.4.so)
	@$(call install_link, db44, libdb_cxx-4.4.so, /usr/lib/libdb_cxx-4.so)
	@$(call install_link, db44, libdb_cxx-4.4.so, /usr/lib/libdb_cxx.so)

	@$(call install_finish, db44)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

db44_clean:
	rm -rf $(STATEDIR)/db44.*
	rm -rf $(PKGDIR)/db44_*
	rm -rf $(DB44_DIR)

# vim: syntax=make
