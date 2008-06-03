# -*-makefile-*-
# $Id: template 4761 2006-02-24 17:35:57Z sha $
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PEKWM) += pekwm

#
# Paths and names
#
PEKWM_VERSION	:= 0.1.4
PEKWM		:= pekwm-$(PEKWM_VERSION)
PEKWM_SUFFIX	:= tar.bz2
PEKWM_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(PEKWM).$(PEKWM_SUFFIX)
PEKWM_SOURCE	:= $(SRCDIR)/$(PEKWM).$(PEKWM_SUFFIX)
PEKWM_DIR	:= $(BUILDDIR)/$(PEKWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pekwm_get: $(STATEDIR)/pekwm.get

$(STATEDIR)/pekwm.get: $(pekwm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PEKWM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PEKWM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pekwm_extract: $(STATEDIR)/pekwm.extract

$(STATEDIR)/pekwm.extract: $(pekwm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PEKWM_DIR))
	@$(call extract, PEKWM)
	@$(call patchin, PEKWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pekwm_prepare: $(STATEDIR)/pekwm.prepare

PEKWM_PATH	:=  PATH=$(CROSS_PATH)
PEKWM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
PEKWM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--x-includes=$(SYSROOT)/usr/include \
	--x-libraries=$(SYSROOT)/usr/lib \
	--disable-xft

$(STATEDIR)/pekwm.prepare: $(pekwm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PEKWM_DIR)/config.cache)
	cd $(PEKWM_DIR) && \
		$(PEKWM_PATH) $(PEKWM_ENV) \
		./configure $(PEKWM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pekwm_compile: $(STATEDIR)/pekwm.compile

$(STATEDIR)/pekwm.compile: $(pekwm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PEKWM_DIR) && $(PEKWM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pekwm_install: $(STATEDIR)/pekwm.install

$(STATEDIR)/pekwm.install: $(pekwm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PEKWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pekwm_targetinstall: $(STATEDIR)/pekwm.targetinstall

$(STATEDIR)/pekwm.targetinstall: $(pekwm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pekwm)
	@$(call install_fixup,pekwm,PACKAGE,pekwm)
	@$(call install_fixup,pekwm,PRIORITY,optional)
	@$(call install_fixup,pekwm,VERSION,$(PEKWM_VERSION))
	@$(call install_fixup,pekwm,SECTION,base)
	@$(call install_fixup,pekwm,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,pekwm,DEPENDS,)
	@$(call install_fixup,pekwm,DESCRIPTION,missing)

	@$(call install_copy, pekwm, 0, 0, 0755, $(PEKWM_DIR)/src/pekwm, $(XORG_BINDIR)/pekwm)

	@$(call install_finish,pekwm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pekwm_clean:
	rm -rf $(STATEDIR)/pekwm.*
	rm -rf $(PKGDIR)/pekwm_*
	rm -rf $(PEKWM_DIR)

# vim: syntax=make
