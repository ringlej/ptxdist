# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
# Copyright (C) 2005 by Ladislav Michl <ladis@linux-mips.org>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LRZSZ) += lrzsz

#
# Paths and names
#
LRZSZ_VERSION	= 0.12.20
LRZSZ		= lrzsz-$(LRZSZ_VERSION)
LRZSZ_SUFFIX	= tar.gz
LRZSZ_URL	= http://www.ohse.de/uwe/releases/$(LRZSZ).$(LRZSZ_SUFFIX)
LRZSZ_SOURCE	= $(SRCDIR)/$(LRZSZ).$(LRZSZ_SUFFIX)
LRZSZ_DIR	= $(BUILDDIR)/$(LRZSZ)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lrzsz_get: $(STATEDIR)/lrzsz.get

$(STATEDIR)/lrzsz.get: $(lrzsz_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LRZSZ_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LRZSZ)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lrzsz_extract: $(STATEDIR)/lrzsz.extract

$(STATEDIR)/lrzsz.extract: $(lrzsz_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LRZSZ_DIR))
	@$(call extract, LRZSZ)
	@$(call patchin, LRZSZ)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lrzsz_prepare: $(STATEDIR)/lrzsz.prepare

LRZSZ_PATH	=  PATH=$(CROSS_PATH)
LRZSZ_ENV 	=  $(CROSS_ENV)
LRZSZ_ENV	+= CFLAGS=-Wstrict-prototypes

#
# autoconf
#
LRZSZ_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/lrzsz.prepare: $(lrzsz_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(LRZSZ_DIR) && \
		$(LRZSZ_PATH) $(LRZSZ_ENV) \
		./configure $(LRZSZ_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lrzsz_compile: $(STATEDIR)/lrzsz.compile

$(STATEDIR)/lrzsz.compile: $(lrzsz_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LRZSZ_DIR) && $(LRZSZ_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lrzsz_install: $(STATEDIR)/lrzsz.install

$(STATEDIR)/lrzsz.install: $(lrzsz_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lrzsz_targetinstall: $(STATEDIR)/lrzsz.targetinstall

$(STATEDIR)/lrzsz.targetinstall: $(lrzsz_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, lrzsz)
	@$(call install_fixup, lrzsz,PACKAGE,lrzsz)
	@$(call install_fixup, lrzsz,PRIORITY,optional)
	@$(call install_fixup, lrzsz,VERSION,$(LRZSZ_VERSION))
	@$(call install_fixup, lrzsz,SECTION,base)
	@$(call install_fixup, lrzsz,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, lrzsz,DEPENDS,)
	@$(call install_fixup, lrzsz,DESCRIPTION,missing)

	@$(call install_copy, lrzsz, 0, 0, 0755, $(LRZSZ_DIR)/src/lrz, /usr/sbin/lrz)
	@$(call install_copy, lrzsz, 0, 0, 0755, $(LRZSZ_DIR)/src/lsz, /usr/sbin/lsz)

	@$(call install_finish, lrzsz)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lrzsz_clean:
	rm -rf $(STATEDIR)/lrzsz.*
	rm -rf $(PKGDIR)/lrzsz_*
	rm -rf $(LRZSZ_DIR)

# vim: syntax=make
