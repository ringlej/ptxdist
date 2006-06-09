# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CAIRO) += cairo

#
# Paths and names
#
CAIRO_VERSION	:= 1.0.4
CAIRO		:= cairo-$(CAIRO_VERSION)
CAIRO_SUFFIX	:= tar.gz
CAIRO_URL	:= http://cairographics.org/releases/$(CAIRO).$(CAIRO_SUFFIX)
CAIRO_SOURCE	:= $(SRCDIR)/$(CAIRO).$(CAIRO_SUFFIX)
CAIRO_DIR	:= $(BUILDDIR)/$(CAIRO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cairo_get: $(STATEDIR)/cairo.get

$(STATEDIR)/cairo.get: $(cairo_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CAIRO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CAIRO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cairo_extract: $(STATEDIR)/cairo.extract

$(STATEDIR)/cairo.extract: $(cairo_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CAIRO_DIR))
	@$(call extract, CAIRO)
	@$(call patchin, CAIRO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cairo_prepare: $(STATEDIR)/cairo.prepare

CAIRO_PATH	:= PATH=$(CROSS_PATH)
CAIRO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CAIRO_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/cairo.prepare: $(cairo_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CAIRO_DIR)/config.cache)
	cd $(CAIRO_DIR) && \
		$(CAIRO_PATH) $(CAIRO_ENV) \
		./configure $(CAIRO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cairo_compile: $(STATEDIR)/cairo.compile

$(STATEDIR)/cairo.compile: $(cairo_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CAIRO_DIR) && $(CAIRO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cairo_install: $(STATEDIR)/cairo.install

$(STATEDIR)/cairo.install: $(cairo_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CAIRO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cairo_targetinstall: $(STATEDIR)/cairo.targetinstall

$(STATEDIR)/cairo.targetinstall: $(cairo_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, cairo)
	@$(call install_fixup,cairo,PACKAGE,cairo)
	@$(call install_fixup,cairo,PRIORITY,optional)
	@$(call install_fixup,cairo,VERSION,$(CAIRO_VERSION))
	@$(call install_fixup,cairo,SECTION,base)
	@$(call install_fixup,cairo,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,cairo,DEPENDS,)
	@$(call install_fixup,cairo,DESCRIPTION,missing)

	@$(call install_copy, cairo, 0, 0, 0644, $(CAIRO_DIR)/src/.libs/libcairo.so.2.2.4, /usr/lib/libcairo.so.2.2.4)
	@$(call install_link, cairo, libcairo.so.2.2.4, /usr/lib/libcairo.so.2)
	@$(call install_link, cairo, libcairo.so.2.2.4, /usr/lib/libcairo.so)

	@$(call install_finish,cairo)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cairo_clean:
	rm -rf $(STATEDIR)/cairo.*
	rm -rf $(IMAGEDIR)/cairo_*
	rm -rf $(CAIRO_DIR)

# vim: syntax=make
