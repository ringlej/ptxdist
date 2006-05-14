# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#                         Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PANGO) += pango

#
# Paths and names
#
PANGO_VERSION	:= 1.10.4
PANGO		:= pango-$(PANGO_VERSION)
PANGO_SUFFIX	:= tar.bz2
PANGO_URL	:= ftp://ftp.gtk.org/pub/gtk/v2.8/$(PANGO).$(PANGO_SUFFIX)
PANGO_SOURCE	:= $(SRCDIR)/$(PANGO).$(PANGO_SUFFIX)
PANGO_DIR	:= $(BUILDDIR)/$(PANGO)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pango_get: $(STATEDIR)/pango.get

$(STATEDIR)/pango.get: $(pango_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PANGO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PANGO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pango_extract: $(STATEDIR)/pango.extract

$(STATEDIR)/pango.extract: $(pango_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PANGO_DIR))
	@$(call extract, PANGO)
	@$(call patchin, $(PANGO))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pango_prepare: $(STATEDIR)/pango.prepare

PANGO_PATH	:= PATH=$(CROSS_PATH)
PANGO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PANGO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-explicit-deps=yes

$(STATEDIR)/pango.prepare: $(pango_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PANGO_DIR)/config.cache)
	cd $(PANGO_DIR) && \
		$(PANGO_PATH) $(PANGO_ENV) \
		./configure $(PANGO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pango_compile: $(STATEDIR)/pango.compile

$(STATEDIR)/pango.compile: $(pango_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PANGO_DIR) && $(PANGO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pango_install: $(STATEDIR)/pango.install

$(STATEDIR)/pango.install: $(pango_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PANGO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pango_targetinstall: $(STATEDIR)/pango.targetinstall

$(STATEDIR)/pango.targetinstall: $(pango_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pango)
	@$(call install_fixup,pango,PACKAGE,pango)
	@$(call install_fixup,pango,PRIORITY,optional)
	@$(call install_fixup,pango,VERSION,$(PANGO_VERSION))
	@$(call install_fixup,pango,SECTION,base)
	@$(call install_fixup,pango,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,pango,DEPENDS,)
	@$(call install_fixup,pango,DESCRIPTION,missing)

#***
#*** Warning: pango.modules not created
#***
#*** Generate this file on the target system
#*** system using pango-querymodules
#***

#	@$(call install_copy, pango, 0, 0, 0755, $(PANGO_DIR)/foobar, /dev/null)

	@$(call install_finish,pango)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pango_clean:
	rm -rf $(STATEDIR)/pango.*
	rm -rf $(IMAGEDIR)/pango_*
	rm -rf $(PANGO_DIR)

# vim: syntax=make
