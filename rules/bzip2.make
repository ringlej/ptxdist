# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BZIP2) += bzip2

#
# Paths and names
#
BZIP2_VERSION	:= 1.0.5
BZIP2		:= bzip2-$(BZIP2_VERSION)
BZIP2_SUFFIX	:= tar.gz
BZIP2_URL	:= http://www.bzip.org/1.0.5/$(BZIP2).$(BZIP2_SUFFIX)
BZIP2_SOURCE	:= $(SRCDIR)/$(BZIP2).$(BZIP2_SUFFIX)
BZIP2_DIR	:= $(BUILDDIR)/$(BZIP2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BZIP2_SOURCE):
	@$(call targetinfo)
	@$(call get, BZIP2)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/bzip2.extract:
	@$(call targetinfo)
	@$(call clean, $(BZIP2_DIR))
	@$(call extract, BZIP2)
	@$(call patchin, BZIP2)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BZIP2_PATH	:= PATH=$(CROSS_PATH)
BZIP2_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BZIP2_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/bzip2.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/bzip2.compile:
	@$(call targetinfo)
	cd $(BZIP2_DIR) && $(BZIP2_PATH) $(MAKE) $(PARALLELMFLAGS) $(CROSS_ENV_CC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bzip2.install:
	@$(call targetinfo)
	cp $(BZIP2_DIR)/libbz2.a $(SYSROOT)/lib/libbz2.a
	cp $(BZIP2_DIR)/bzlib.h $(SYSROOT)/usr/include/bzlib.h
	cp $(BZIP2_DIR)/libbz2.so.1.0.4 $(SYSROOT)/lib/libbz2.so.1.0.4
	ln -sf libbz2.so.1.0.4 $(SYSROOT)/usr/libbz2.so.1.0
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bzip2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bzip2)
	@$(call install_fixup, bzip2,PACKAGE,bzip2)
	@$(call install_fixup, bzip2,PRIORITY,optional)
	@$(call install_fixup, bzip2,VERSION,$(BZIP2_VERSION))
	@$(call install_fixup, bzip2,SECTION,base)
	@$(call install_fixup, bzip2,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, bzip2,DEPENDS,)
	@$(call install_fixup, bzip2,DESCRIPTION,missing)

ifdef PTXCONF_BZIP2__LIBBZ2
	@$(call install_copy, bzip2, 0, 0, 0755, $(BZIP2_DIR)/libbz2.so.1.0.4, /lib/libbz2.so.1.0.4)
	@$(call install_link, bzip2, libbz2.so.1.0.4, /lib/libbz2.so.1.0)
endif

ifdef PTXCONF_BZIP2__BZIP2
	@$(call install_copy, bzip2, 0, 0, 0755, $(BZIP2_DIR)/bzip2, /usr/bin/bzip2)
endif

ifdef PTXCONF_BZIP2__BZIP2RECOVER
	@$(call install_copy, bzip2, 0, 0, 0755, $(BZIP2_DIR)/bzip2recover, /usr/bin/bzip2recover)
endif

	@$(call install_finish, bzip2)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bzip2_clean:
	rm -rf $(STATEDIR)/bzip2.*
	rm -rf $(PKGDIR)/bzip2_*
	rm -rf $(BZIP2_DIR)

# vim: syntax=make
