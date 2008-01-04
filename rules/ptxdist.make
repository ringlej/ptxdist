# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PTXDIST) += ptxdist

#
# Paths and names
#
PTXDIST_VERSION	:= 1.99.1
PTXDIST		:= ptxdist-$(PTXDIST_VERSION)
PTXDIST_SUFFIX	:= tgz
PTXDIST_URL	:= http://www.pengutronix.de/software/ptxdist/download/v1.99/$(PTXDIST).$(PTXDIST_SUFFIX)
PTXDIST_P_URL	:= http://www.pengutronix.de/software/ptxdist/download/v1.99/$(PTXDIST)-patches.$(PTXDIST_SUFFIX)
PTXDIST_SOURCE	:= $(SRCDIR)/$(PTXDIST).$(PTXDIST_SUFFIX)
PTXDIST_P_SOURCE:= $(SRCDIR)/$(PTXDIST)-patches.$(PTXDIST_SUFFIX)
PTXDIST_DIR	:= $(BUILDDIR)/$(PTXDIST)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ptxdist_get: $(STATEDIR)/ptxdist.get

$(STATEDIR)/ptxdist.get: $(ptxdist_get_deps_default) $(PTXDIST_P_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PTXDIST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PTXDIST)

$(PTXDIST_P_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PTXDIST_P)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ptxdist_extract: $(STATEDIR)/ptxdist.extract

$(STATEDIR)/ptxdist.extract: $(ptxdist_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PTXDIST_DIR))
	@$(call extract, PTXDIST)
	cd $(BUILDDIR) && tar xf $(PTXDIST_P_SOURCE)
	@$(call patchin, PTXDIST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ptxdist_prepare: $(STATEDIR)/ptxdist.prepare

PTXDIST_PATH	:= PATH=$(CROSS_PATH)
PTXDIST_ENV 	:= $(CROSS_ENV) CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX)

#
# autoconf
#
PTXDIST_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/ptxdist.prepare: $(ptxdist_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PTXDIST_DIR)/config.cache)
	cd $(PTXDIST_DIR) && \
		$(PTXDIST_PATH) $(PTXDIST_ENV) \
		./configure $(PTXDIST_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ptxdist_compile: $(STATEDIR)/ptxdist.compile

$(STATEDIR)/ptxdist.compile: $(ptxdist_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PTXDIST_DIR) && $(PTXDIST_PATH) $(PTXDIST_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ptxdist_install: $(STATEDIR)/ptxdist.install

$(STATEDIR)/ptxdist.install: $(ptxdist_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PTXDIST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ptxdist_targetinstall: $(STATEDIR)/ptxdist.targetinstall

$(STATEDIR)/ptxdist.targetinstall: $(ptxdist_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ptxdist)
	@$(call install_fixup, ptxdist,PACKAGE,ptxdist)
	@$(call install_fixup, ptxdist,PRIORITY,optional)
	@$(call install_fixup, ptxdist,VERSION,$(PTXDIST_VERSION))
	@$(call install_fixup, ptxdist,SECTION,base)
	@$(call install_fixup, ptxdist,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ptxdist,DEPENDS,)
	@$(call install_fixup, ptxdist,DESCRIPTION,missing)

	for i in `cd $(PKGDIR)/$(PTXDIST); find . -type f`; do \
		$(call install_copy, ptxdist, 0, 0, 0755, $(PKGDIR)/$(PTXDIST)/$$i, /$$i); \
	done

	@$(call install_finish, ptxdist)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ptxdist_clean:
	rm -rf $(STATEDIR)/ptxdist.*
	rm -rf $(IMAGEDIR)/ptxdist_*
	rm -rf $(PTXDIST_DIR)

# vim: syntax=make
