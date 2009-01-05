# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Werner Schmitt mail2ws@gmx.de
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DB41) += db41

#
# Paths and names
#
DB41_VERSION	:= 4.1.25.NC
DB41		:= db-$(DB41_VERSION)
DB41_SUFFIX	:= tar.gz
DB41_URL	:= http://download.oracle.com/berkeley-db/$(DB41).$(DB41_SUFFIX)
DB41_SOURCE	:= $(SRCDIR)/$(DB41).$(DB41_SUFFIX)
DB41_DIR	:= $(BUILDDIR)/$(DB41)
DB41_PKGDIR	:= $(PKGDIR)/$(DB41)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DB41_SOURCE):
	@$(call targetinfo)
	@$(call get, DB41)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DB41_PATH	:= PATH=$(CROSS_PATH)
DB41_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DB41_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-cxx 

$(STATEDIR)/db41.prepare:
	@$(call targetinfo)
	@$(call clean, $(DB41_BUILDDIR))
	cd $(DB41_DIR)/dist && \
		$(DB41_PATH) $(DB41_ENV) \
		./configure $(DB41_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/db41.compile:
	@$(call targetinfo)
	$(DB41_PATH) $(MAKE) -C $(DB41_DIR)/dist $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/db41.install:
	@$(call targetinfo)
	$(DB41_PATH) $(MAKE) -C $(DB41_DIR)/dist install DESTDIR=$(SYSROOT)
	$(DB41_PATH) $(MAKE) -C $(DB41_DIR)/dist install DESTDIR=$(DB41_PKGDIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/db41.targetinstall:
	@$(call targetinfo)

	@$(call install_init, db41)
	@$(call install_fixup, db41,PACKAGE,db41)
	@$(call install_fixup, db41,PRIORITY,optional)
	@$(call install_fixup, db41,VERSION,$(DB41_VERSION))
	@$(call install_fixup, db41,SECTION,base)
	@$(call install_fixup, db41,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, db41,DEPENDS,)
	@$(call install_fixup, db41,DESCRIPTION,missing)

	cd $(DB41_PKGDIR)/usr/bin && for file in db_*; do \
		$(call install_copy, db41, 0, 0, 0755, $(DB41_PKGDIR)/usr/bin/$$file, /usr/bin/$$file); \
	done

	@$(call install_copy, db41, 0, 0, 0644, $(DB41_PKGDIR)/usr/lib/libdb-4.1.so, /usr/lib/libdb-4.1.so)
	@$(call install_link, db41, libdb-4.1.so, /usr/lib/libdb-4.so)
	@$(call install_link, db41, libdb-4.1.so, /usr/lib/libdb.so)

	@$(call install_copy, db41, 0, 0, 0644, $(DB41_PKGDIR)/usr/lib/libdb_cxx-4.1.so, /usr/lib/libdb_cxx-4.1.so)
	@$(call install_link, db41, libdb_cxx-4.1.so, /usr/lib/libdb_cxx-4.so)
	@$(call install_link, db41, libdb_cxx-4.1.so, /usr/lib/libdb_cxx.so)

	@$(call install_finish, db41)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

db41_clean:
	rm -rf $(STATEDIR)/db41.*
	rm -rf $(PKGDIR)/db41_*
	rm -rf $(DB41_DIR)

# vim: syntax=make
