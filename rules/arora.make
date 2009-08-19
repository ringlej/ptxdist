# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARORA) += arora

#
# Paths and names
#
ARORA_VERSION	:= 0.8.0
ARORA		:= arora-$(ARORA_VERSION)
ARORA_SUFFIX	:= tar.gz
ARORA_URL	:= http://arora.googlecode.com/files/$(ARORA).$(ARORA_SUFFIX)
ARORA_SOURCE	:= $(SRCDIR)/$(ARORA).$(ARORA_SUFFIX)
ARORA_DIR	:= $(BUILDDIR)/$(ARORA)
ARORA_PKGDIR	:= $(PKGDIR)/$(ARORA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ARORA_SOURCE):
	@$(call targetinfo)
	@$(call get, ARORA)


# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/arora.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(ARORA_DIR))
	@$(call extract, ARORA)
	@$(call patchin, ARORA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ARORA_PATH	:=  PATH=$(CROSS_PATH)
ARORA_ENV	:=  \
	$(CROSS_ENV) \
	INSTALL_ROOT=$(ARORA_PKGDIR) \
	QMAKESPEC=$(SYSROOT)/usr/mkspecs/qws/linux-ptx-g++

$(STATEDIR)/arora.prepare:
	@$(call targetinfo)
	cd $(ARORA_DIR) && \
		$(ARORA_PATH) $(ARORA_ENV) qmake -recursive
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/arora.compile:
	@$(call targetinfo)
	cd $(ARORA_DIR) && $(ARORA_PATH) make
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/arora.targetinstall: $(arora_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, arora)
	@$(call install_fixup, arora,PACKAGE,arora)
	@$(call install_fixup, arora,PRIORITY,optional)
	@$(call install_fixup, arora,VERSION,$(ARORA_VERSION))
	@$(call install_fixup, arora,SECTION,base)
	@$(call install_fixup, arora,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, arora,DEPENDS,)
	@$(call install_fixup, arora,DESCRIPTION,missing)

	@$(call install_copy, arora, 0, 0, 0755, -, /usr/bin/arora)

	@$(call install_finish, arora)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

arora_clean:
	rm -rf $(STATEDIR)/arora.*
	rm -rf $(PKGDIR)/arora_*
	rm -rf $(ARORA_DIR)

# vim: syntax=make
