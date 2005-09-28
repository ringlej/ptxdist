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
ifdef PTXCONF_TROLL-FTPD
PACKAGES += troll-ftpd
endif

#
# Paths and names
#
TROLL-FTPD_VERSION	= 1.28
TROLL-FTPD		= troll-ftpd-$(TROLL-FTPD_VERSION)
TROLL-FTPD_SUFFIX	= tar.gz
TROLL-FTPD_URL		= ftp://ftp.trolltech.com/freebies/ftpd/$(TROLL-FTPD).$(TROLL-FTPD_SUFFIX)
TROLL-FTPD_SOURCE	= $(SRCDIR)/$(TROLL-FTPD).$(TROLL-FTPD_SUFFIX)
TROLL-FTPD_DIR		= $(BUILDDIR)/$(TROLL-FTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

troll-ftpd_get: $(STATEDIR)/troll-ftpd.get

troll-ftpd_get_deps = $(TROLL-FTPD_SOURCE)

$(STATEDIR)/troll-ftpd.get: $(troll-ftpd_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(TROLL-FTPD))
	$(call touch, $@)

$(TROLL-FTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(TROLL-FTPD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

troll-ftpd_extract: $(STATEDIR)/troll-ftpd.extract

troll-ftpd_extract_deps = $(STATEDIR)/troll-ftpd.get

$(STATEDIR)/troll-ftpd.extract: $(troll-ftpd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TROLL-FTPD_DIR))
	@$(call extract, $(TROLL-FTPD_SOURCE))
	@$(call patchin, $(TROLL-FTPD))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

troll-ftpd_prepare: $(STATEDIR)/troll-ftpd.prepare

#
# dependencies
#
troll-ftpd_prepare_deps = \
	$(STATEDIR)/troll-ftpd.extract \
	$(STATEDIR)/virtual-xchain.install

TROLL-FTPD_PATH	=  PATH=$(CROSS_PATH)
TROLL-FTPD_ENV 	=  $(CROSS_ENV)
#TROLL-FTPD_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#TROLL-FTPD_ENV	+=

$(STATEDIR)/troll-ftpd.prepare: $(troll-ftpd_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(TROLL-FTPD_DIR)/config.cache)
	perl -p -i -e 's/CC = /CC ?= /'         $(TROLL-FTPD_DIR)/Makefile
	perl -p -i -e 's/CFLAGS = /CFLAGS ?= /' $(TROLL-FTPD_DIR)/Makefile
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

troll-ftpd_compile: $(STATEDIR)/troll-ftpd.compile

troll-ftpd_compile_deps = $(STATEDIR)/troll-ftpd.prepare

$(STATEDIR)/troll-ftpd.compile: $(troll-ftpd_compile_deps)
	@$(call targetinfo, $@)
	cd $(TROLL-FTPD_DIR) && $(TROLL-FTPD_ENV) $(TROLL-FTPD_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

troll-ftpd_install: $(STATEDIR)/troll-ftpd.install

$(STATEDIR)/troll-ftpd.install: $(STATEDIR)/troll-ftpd.compile
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

troll-ftpd_targetinstall: $(STATEDIR)/troll-ftpd.targetinstall

troll-ftpd_targetinstall_deps = $(STATEDIR)/troll-ftpd.compile

$(STATEDIR)/troll-ftpd.targetinstall: $(troll-ftpd_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,trollftpd)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(TROLL-FTPD_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(TROLL-FTPD_DIR)/ftpd, /sbin/ftpd)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

troll-ftpd_clean:
	rm -rf $(STATEDIR)/troll-ftpd.*
	rm -rf $(IMAGEDIR)/troll-ftpd_*
	rm -rf $(TROLL-FTPD_DIR)

# vim: syntax=make
