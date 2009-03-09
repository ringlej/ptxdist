# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
# Copyright (C) 2009 by Wolfram Sang, Pengutronix
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HAS_PCI)-$(PTXCONF_PCIUTILS) += pciutils

#
# Paths and names
#
PCIUTILS_VERSION	:= 3.1.2
PCIUTILS		:= pciutils-$(PCIUTILS_VERSION)
PCIUTILS_SUFFIX		:= tar.bz2
PCIUTILS_URL		:= http://ftp.kernel.org/pub/software/utils/pciutils/$(PCIUTILS).$(PCIUTILS_SUFFIX)
PCIUTILS_SOURCE		:= $(SRCDIR)/$(PCIUTILS).$(PCIUTILS_SUFFIX)
PCIUTILS_DIR		:= $(BUILDDIR)/$(PCIUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pciutils_get: $(STATEDIR)/pciutils.get

$(STATEDIR)/pciutils.get: $(pciutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PCIUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PCIUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pciutils_extract: $(STATEDIR)/pciutils.extract

$(STATEDIR)/pciutils.extract: $(pciutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PCIUTILS_DIR))
	@$(call extract, PCIUTILS)
	@$(call patchin, PCIUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pciutils_prepare: $(STATEDIR)/pciutils.prepare

PCIUTILS_PATH	:=  PATH=$(CROSS_PATH)
PCIUTILS_ENV 	:=  $(CROSS_ENV)

PCIUTILS_ENV += PREFIX=/usr
PCIUTILS_ENV += HOST=$(PTXCONF_ARCH_STRING)--linux
PCIUTILS_ENV += RELEASE=$(PTXCONF_KERNEL_VERSION)
# FIXME: Could be an option depending on libresolv
PCIUTILS_ENV += DNS=no
ifdef PTXCONF_PCIUTILS_COMPRESS
PCIUTILS_ENV += ZLIB=yes
else
PCIUTILS_ENV += ZLIB=no
endif
#
# autoconf
#
PCIUTILS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/pciutils.prepare: $(pciutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pciutils_compile: $(STATEDIR)/pciutils.compile

$(STATEDIR)/pciutils.compile: $(pciutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PCIUTILS_DIR) && $(PCIUTILS_PATH) $(MAKE) $(PCIUTILS_ENV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pciutils_install: $(STATEDIR)/pciutils.install

$(STATEDIR)/pciutils.install: $(pciutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pciutils_targetinstall: $(STATEDIR)/pciutils.targetinstall

$(STATEDIR)/pciutils.targetinstall: $(pciutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pciutils)
	@$(call install_fixup,pciutils,PACKAGE,pciutils)
	@$(call install_fixup,pciutils,PRIORITY,optional)
	@$(call install_fixup,pciutils,VERSION,$(PCIUTILS_VERSION))
	@$(call install_fixup,pciutils,SECTION,base)
	@$(call install_fixup,pciutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,pciutils,DEPENDS,)
	@$(call install_fixup,pciutils,DESCRIPTION,missing)

	@$(call install_copy, pciutils, 0, 0, 0755, $(PCIUTILS_DIR)/lspci, /usr/bin/lspci)
	@$(call install_copy, pciutils, 0, 0, 0755, $(PCIUTILS_DIR)/setpci, /usr/bin/setpci)
ifdef PTXCONF_PCIUTILS_COMPRESS
	[ -f $(PCIUTILS_DIR)/pci.ids.gz ] || gzip --best -c $(PCIUTILS_DIR)/pci.ids > $(PCIUTILS_DIR)/pci.ids.gz
	@$(call install_copy, pciutils, 0, 0, 0644, $(PCIUTILS_DIR)/pci.ids.gz, /usr/share/pci.ids.gz, n)
else
	@$(call install_copy, pciutils, 0, 0, 0644, $(PCIUTILS_DIR)/pci.ids, /usr/share/pci.ids, n)
endif

	@$(call install_finish,pciutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pciutils_clean:
	rm -rf $(STATEDIR)/pciutils.*
	rm -rf $(PKGDIR)/pciutils_*
	rm -rf $(PCIUTILS_DIR)

# vim: syntax=make
