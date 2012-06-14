# -*-makefile-*-
#
# Copyright (C) 2008 by Erwin Rol
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
PACKAGES-$(PTXCONF_KEXEC_TOOLS) += kexec-tools

#
# Paths and names
#
KEXEC_TOOLS_VERSION	:= 2.0.3
KEXEC_TOOLS_MD5		:= b3ced2097ce3981abba38ceedc84f939
KEXEC_TOOLS		:= kexec-tools-$(KEXEC_TOOLS_VERSION)
KEXEC_TOOLS_SUFFIX	:= tar.bz2
KEXEC_TOOLS_URL		:= $(call ptx/mirror, KERNEL, utils/kernel/kexec/$(KEXEC_TOOLS).$(KEXEC_TOOLS_SUFFIX))
KEXEC_TOOLS_SOURCE	:= $(SRCDIR)/$(KEXEC_TOOLS).$(KEXEC_TOOLS_SUFFIX)
KEXEC_TOOLS_DIR		:= $(BUILDDIR)/$(KEXEC_TOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KEXEC_TOOLS_PATH	:= PATH=$(CROSS_PATH)
KEXEC_TOOLS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
KEXEC_TOOLS_AUTOCONF := $(CROSS_AUTOCONF_ROOT)

ifdef PTXCONF_KEXEC_TOOLS_GAMECUBE
KEXEC_TOOLS_AUTOCONF += --with-gamecube
else
KEXEC_TOOLS_AUTOCONF += --without-gamecube
endif

ifdef PTXCONF_KEXEC_TOOLS_ZLIB
KEXEC_TOOLS_AUTOCONF += --with-zlib
else
KEXEC_TOOLS_AUTOCONF += --without-zlib
endif

ifdef PTXCONF_KEXEC_TOOLS_XEN
KEXEC_TOOLS_AUTOCONF += --with-xen
else
KEXEC_TOOLS_AUTOCONF += --without-xen
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kexec-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  kexec-tools)
	@$(call install_fixup, kexec-tools,PRIORITY,optional)
	@$(call install_fixup, kexec-tools,SECTION,base)
	@$(call install_fixup, kexec-tools,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, kexec-tools,DESCRIPTION,missing)

ifdef PTXCONF_KEXEC_TOOLS_KEXEC
	@$(call install_copy, kexec-tools, 0, 0, 0755, -, /sbin/kexec)
endif

ifdef PTXCONF_KEXEC_TOOLS_KDUMP
	@$(call install_copy, kexec-tools, 0, 0, 0755, -, /sbin/kdump)
endif

	@$(call install_finish, kexec-tools)

	@$(call touch)

# vim: syntax=make
