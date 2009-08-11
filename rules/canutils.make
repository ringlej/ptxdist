# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutroinx.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CANUTILS) += canutils

#
# Paths and names
#
CANUTILS_VERSION	:= $(call remove_quotes, $(PTXCONF_CANUTILS_VERSION))
CANUTILS		:= canutils-$(CANUTILS_VERSION)
CANUTILS_SUFFIX		:= tar.bz2
CANUTILS_URL		= http://www.pengutronix.de/software/socket-can/download/canutils/v$(shell echo $(PTXCONF_CANUTILS_VERSION)|sed "s/\([0-9]*\).\([0-9]*\).\([0-9]*\)/\1.\2/")/$(CANUTILS).$(CANUTILS_SUFFIX)
CANUTILS_SOURCE		:= $(SRCDIR)/$(CANUTILS).$(CANUTILS_SUFFIX)
CANUTILS_DIR		:= $(BUILDDIR)/$(CANUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CANUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, CANUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CANUTILS_PATH	:= PATH=$(CROSS_PATH)
CANUTILS_ENV 	:= $(CROSS_ENV)

ifdef PTXCONF_CANUTILS_BSP_KERNEL
CANUTILS_CPPFLAGS := CPPFLAGS="-I${KERNEL_HEADERS_INCLUDE_DIR} $${CPPFLAGS}"
endif

#
# autoconf
#
CANUTILS_AUTOCONF := $(CROSS_AUTOCONF_ROOT)

$(STATEDIR)/canutils.prepare:
	@$(call targetinfo)
	@$(call clean, $(CANUTILS_DIR)/config.cache)
	cd $(CANUTILS_DIR) && \
		$(CANUTILS_PATH) $(CANUTILS_ENV) $(CANUTILS_CPPFLAGS) \
		./configure $(CANUTILS_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/canutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, canutils)
	@$(call install_fixup, canutils,PACKAGE,canutils)
	@$(call install_fixup, canutils,PRIORITY,optional)
	@$(call install_fixup, canutils,VERSION,$(CANUTILS_VERSION))
	@$(call install_fixup, canutils,SECTION,base)
	@$(call install_fixup, canutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, canutils,DEPENDS,)
	@$(call install_fixup, canutils,DESCRIPTION,missing)

ifdef PTXCONF_CANUTILS_CANCONFIG
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/sbin/canconfig)
endif
ifdef PTXCONF_CANUTILS_CANECHO
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/bin/canecho)
endif
ifdef PTXCONF_CANUTILS_CANDUMP
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/bin/candump)
endif
ifdef PTXCONF_CANUTILS_CANSEND
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/bin/cansend)
endif
ifdef PTXCONF_CANUTILS_CANSEQUENCE
	@$(call install_copy, canutils, 0, 0, 0755, -, \
		/bin/cansequence)
endif
	@$(call install_finish, canutils)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

canutils_clean:
	rm -rf $(STATEDIR)/canutils.*
	rm -rf $(PKGDIR)/canutils_*
	rm -rf $(CANUTILS_DIR)

# vim: syntax=make
