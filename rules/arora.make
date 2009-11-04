# -*-makefile-*-
#
# Copyright (C) 2006 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
ARORA_VERSION	:= 0.10.1
ARORA		:= arora-$(ARORA_VERSION)
ARORA_SUFFIX	:= tar.gz
ARORA_URL	:= http://arora.googlecode.com/files/$(ARORA).$(ARORA_SUFFIX)
ARORA_SOURCE	:= $(SRCDIR)/$(ARORA).$(ARORA_SUFFIX)
ARORA_DIR	:= $(BUILDDIR)/$(ARORA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ARORA_SOURCE):
	@$(call targetinfo)
	@$(call get, ARORA)

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
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/arora.targetinstall:
	@$(call targetinfo)

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

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

arora_clean:
	rm -rf $(STATEDIR)/arora.*
	rm -rf $(PKGDIR)/arora_*
	rm -rf $(ARORA_DIR)

# vim: syntax=make
