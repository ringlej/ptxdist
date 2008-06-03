# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Steven Scholz <steven.scholz@imc-berlin.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TROLL_FTPD) += troll-ftpd

#
# Paths and names
#
TROLL_FTPD_VERSION	= 1.28
TROLL_FTPD		= troll-ftpd-$(TROLL_FTPD_VERSION)
TROLL_FTPD_SUFFIX	= tar.gz
TROLL_FTPD_URL		= ftp://ftp.trolltech.com/freebies/ftpd/$(TROLL_FTPD).$(TROLL_FTPD_SUFFIX)
TROLL_FTPD_SOURCE	= $(SRCDIR)/$(TROLL_FTPD).$(TROLL_FTPD_SUFFIX)
TROLL_FTPD_DIR		= $(BUILDDIR)/$(TROLL_FTPD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

troll-ftpd_get: $(STATEDIR)/troll-ftpd.get

$(STATEDIR)/troll-ftpd.get: $(troll-ftpd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TROLL_FTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TROLL_FTPD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

troll-ftpd_extract: $(STATEDIR)/troll-ftpd.extract

$(STATEDIR)/troll-ftpd.extract: $(troll-ftpd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TROLL_FTPD_DIR))
	@$(call extract, TROLL_FTPD)
	@$(call patchin, TROLL_FTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

troll-ftpd_prepare: $(STATEDIR)/troll-ftpd.prepare

TROLL_FTPD_PATH	=  PATH=$(CROSS_PATH)
TROLL_FTPD_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/troll-ftpd.prepare: $(troll-ftpd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TROLL_FTPD_DIR)/config.cache)
	perl -p -i -e 's/CC = /CC ?= /'         $(TROLL_FTPD_DIR)/Makefile
	perl -p -i -e 's/CFLAGS = /CFLAGS ?= /' $(TROLL_FTPD_DIR)/Makefile
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

troll-ftpd_compile: $(STATEDIR)/troll-ftpd.compile

$(STATEDIR)/troll-ftpd.compile: $(troll-ftpd_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(TROLL_FTPD_DIR) && $(TROLL_FTPD_ENV) $(TROLL_FTPD_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

troll-ftpd_install: $(STATEDIR)/troll-ftpd.install

$(STATEDIR)/troll-ftpd.install: $(troll-ftpd_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

troll-ftpd_targetinstall: $(STATEDIR)/troll-ftpd.targetinstall

$(STATEDIR)/troll-ftpd.targetinstall: $(troll-ftpd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, troll-ftpd)
	@$(call install_fixup, troll-ftpd,PACKAGE,trollftpd)
	@$(call install_fixup, troll-ftpd,PRIORITY,optional)
	@$(call install_fixup, troll-ftpd,VERSION,$(TROLL_FTPD_VERSION))
	@$(call install_fixup, troll-ftpd,SECTION,base)
	@$(call install_fixup, troll-ftpd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, troll-ftpd,DEPENDS,)
	@$(call install_fixup, troll-ftpd,DESCRIPTION,missing)

	@$(call install_copy, troll-ftpd, 0, 0, 0755, $(TROLL_FTPD_DIR)/ftpd, /sbin/ftpd)

	@$(call install_finish, troll-ftpd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

troll-ftpd_clean:
	rm -rf $(STATEDIR)/troll-ftpd.*
	rm -rf $(PKGDIR)/troll-ftpd_*
	rm -rf $(TROLL_FTPD_DIR)

# vim: syntax=make
