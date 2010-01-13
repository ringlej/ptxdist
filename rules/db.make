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
PACKAGES-$(PTXCONF_DB) += db

#
# Paths and names
#

ifdef PTXCONF_DB_41
DB_VERSION	:= 4.1.25.NC
endif
ifdef PTXCONF_DB_44
DB_VERSION	:= 4.4.20.NC
endif
DB_MINOR	:= $(word 2,$(subst ., ,$(DB_VERSION)))
DB		:= db-$(DB_VERSION)
DB_SUFFIX	:= tar.gz
DB_URL		:= http://download.oracle.com/berkeley-db/$(DB).$(DB_SUFFIX)
DB_SOURCE	:= $(SRCDIR)/$(DB).$(DB_SUFFIX)
DB_DIR		:= $(BUILDDIR)/$(DB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DB_SOURCE):
	@$(call targetinfo)
	@$(call get, DB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DB_PATH	:= PATH=$(CROSS_PATH)
DB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-cryptography \
	--disable-debug \
	--disable-debug_rop \
	--disable-debug_wop \
	--disable-diagnostic \
	--disable-dump185 \
	--disable-java \
	--disable-mingw \
	--disable-queue \
	--disable-replication \
	--disable-rpc \
	--disable-static \
	--disable-statistics \
	--disable-tcl \
	--disable-test \
	--disable-uimutexes \
	--disable-umrw \
	--disable-verify \
	--enable-compat185 \
	--enable-cxx \
	--enable-hash \
	--enable-largefile \
	--enable-o_direct \
	--enable-pthread_self \
	--enable-shared

ifdef PTXCONF_ARCH_ARM
DB_AUTOCONF += \
	--with-mutex=ARM/gcc-assembly
endif


$(STATEDIR)/db.prepare:
	@$(call targetinfo)
	@$(call clean, $(DB_DIR)/config.cache)
	cd $(DB_DIR)/build_unix && \
		$(DB_PATH) $(DB_ENV) \
		../dist/configure $(DB_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/db.compile:
	@$(call targetinfo)
	cd $(DB_DIR)/build_unix && $(DB_PATH) $(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/db.install:
	@$(call targetinfo)
	@$(call install, DB, $(DB_DIR)/build_unix)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/db.targetinstall:
	@$(call targetinfo)

	@$(call install_init, db)
	@$(call install_fixup, db,PACKAGE,db)
	@$(call install_fixup, db,PRIORITY,optional)
	@$(call install_fixup, db,VERSION,$(DB_VERSION))
	@$(call install_fixup, db,SECTION,base)
	@$(call install_fixup, db,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, db,DEPENDS,)
	@$(call install_fixup, db,DESCRIPTION,missing)

	@$(call install_copy, db, 0, 0, 0644, -, \
		/usr/lib/libdb-4.$(DB_MINOR).so)
	@$(call install_link, db, libdb-4.$(DB_MINOR).so, /usr/lib/libdb-4.so)
	@$(call install_link, db, libdb-4.$(DB_MINOR).so, /usr/lib/libdb.so)

ifdef PTXCONF_DB_UTIL
	@cd "$(PKGDIR)/$(DB)" && \
		find ./usr/bin -type f | \
		 while read file; do \
		$(call install_copy, db, 0, 0, 0755, -, $${file##.}); \
	done
endif

	@$(call install_finish, db)

	@$(call touch)

# vim: syntax=make
