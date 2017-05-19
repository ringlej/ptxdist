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
KEXEC_TOOLS_VERSION	:= 2.0.14
KEXEC_TOOLS_MD5		:= 4164abff8ed21e9f94d57f535c2f77bf
KEXEC_TOOLS		:= kexec-tools-$(KEXEC_TOOLS_VERSION)
KEXEC_TOOLS_SUFFIX	:= tar.xz
KEXEC_TOOLS_URL		:= $(call ptx/mirror, KERNEL, utils/kernel/kexec/$(KEXEC_TOOLS).$(KEXEC_TOOLS_SUFFIX))
KEXEC_TOOLS_SOURCE	:= $(SRCDIR)/$(KEXEC_TOOLS).$(KEXEC_TOOLS_SUFFIX)
KEXEC_TOOLS_DIR		:= $(BUILDDIR)/$(KEXEC_TOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KEXEC_TOOLS_PATH	:= PATH=$(CROSS_PATH)
KEXEC_TOOLS_ENV 	:= $(CROSS_ENV)

ifdef PTXCONF_ARCH_ARM64
KEXEC_TOOLS_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_PIE
endif

#
# autoconf
#
KEXEC_TOOLS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/wwo, PTXCONF_KEXEC_TOOLS_ZLIB)-zlib \
	--$(call ptx/wwo, PTXCONF_KEXEC_TOOLS_XEN)-xen
	
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
	@$(call install_copy, kexec-tools, 0, 0, 0755, -, /usr/sbin/kexec)
endif

ifdef PTXCONF_KEXEC_TOOLS_KDUMP
	@$(call install_copy, kexec-tools, 0, 0, 0755, -, /usr/sbin/kdump)
endif

	@$(call install_finish, kexec-tools)

	@$(call touch)

# vim: syntax=make
