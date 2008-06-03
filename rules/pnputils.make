#
# Copyright (C) 2007 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PNPUTILS) += pnputils

#
# Paths and names
#
PNPUTILS_VERSION	:= 0.1
PNPUTILS		:= pnputils-$(PNPUTILS_VERSION)
PNPUTILS_SUFFIX		:= tar.bz2
PNPUTILS_URL		:= http://www.vi.kernel.org/pub/linux/kernel/people/helgaas//$(PNPUTILS).$(PNPUTILS_SUFFIX)
PNPUTILS_SOURCE		:= $(SRCDIR)/$(PNPUTILS).$(PNPUTILS_SUFFIX)
PNPUTILS_DIR		:= $(BUILDDIR)/$(PNPUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pnputils_get: $(STATEDIR)/pnputils.get

$(STATEDIR)/pnputils.get: $(pnputils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PNPUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PNPUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pnputils_extract: $(STATEDIR)/pnputils.extract

$(STATEDIR)/pnputils.extract: $(pnputils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PNPUTILS_DIR))
	@$(call extract, PNPUTILS)
	@$(call patchin, PNPUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pnputils_prepare: $(STATEDIR)/pnputils.prepare

PNPUTILS_PATH	:= PATH=$(CROSS_PATH)
PNPUTILS_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/pnputils.prepare: $(pnputils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pnputils_compile: $(STATEDIR)/pnputils.compile

$(STATEDIR)/pnputils.compile: $(pnputils_compile_deps_default)
	@$(call targetinfo, $@)
	@cd $(PNPUTILS_DIR) && $(PNPUTILS_PATH) $(PNPUTILS_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pnputils_install: $(STATEDIR)/pnputils.install

$(STATEDIR)/pnputils.install: $(pnputils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pnputils_targetinstall: $(STATEDIR)/pnputils.targetinstall

$(STATEDIR)/pnputils.targetinstall: $(pnputils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pnputils)
	@$(call install_fixup, pnputils,PACKAGE,pnputils)
	@$(call install_fixup, pnputils,PRIORITY,optional)
	@$(call install_fixup, pnputils,VERSION,$(PNPUTILS_VERSION))
	@$(call install_fixup, pnputils,SECTION,base)
	@$(call install_fixup, pnputils,AUTHOR,"Juergen Beisert <juergen\@kreuzholzen.de>")
	@$(call install_fixup, pnputils,DEPENDS,)
	@$(call install_fixup, pnputils,DESCRIPTION,missing)

ifdef PTXCONF_PNPUTILS_SETPNP
	@$(call install_copy, pnputils, 0, 0, 0755, \
		$(PNPUTILS_DIR)/setpnp, /sbin/setpnp)
endif
ifdef PTXCONF_PNPUTILS_LSPNP
	@$(call install_copy, pnputils, 0, 0, 0755, \
		$(PNPUTILS_DIR)/lspnp, /sbin/lspnp)
endif

	@$(call install_finish, pnputils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pnputils_clean:
	rm -rf $(STATEDIR)/pnputils.*
	rm -rf $(PKGDIR)/pnputils_*
	rm -rf $(PNPUTILS_DIR)

# vim: syntax=make
