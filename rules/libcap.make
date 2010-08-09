# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCAP) += libcap

#
# Paths and names
#
LIBCAP_VERSION	:= 2.20
LIBCAP		:= libcap-$(LIBCAP_VERSION)
LIBCAP_SUFFIX	:= tar.bz2
LIBCAP_URL	:= http://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2/$(LIBCAP).$(LIBCAP_SUFFIX)
LIBCAP_SOURCE	:= $(SRCDIR)/$(LIBCAP).$(LIBCAP_SUFFIX)
LIBCAP_DIR	:= $(BUILDDIR)/$(LIBCAP)
LIBCAP_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCAP_MAKE_OPT	:= \
	prefix= PAM_CAP=no LIBATTR=no lib=lib \
	CC=$(CROSS_CC) \
	BUILD_CC=$(HOSTCC)

LIBCAP_INSTALL_OPT := $(LIBCAP_MAKE_OPT) install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcap.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libcap)
	@$(call install_fixup, libcap,PRIORITY,optional)
	@$(call install_fixup, libcap,SECTION,base)
	@$(call install_fixup, libcap,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libcap,DESCRIPTION,missing)

	@$(call install_copy, libcap, 0, 0, 0755, -, /sbin/getpcaps)
	@$(call install_copy, libcap, 0, 0, 0755, -, /sbin/capsh)
	@$(call install_lib,  libcap, 0, 0, 0644, libcap)

	@$(call install_finish, libcap)

	@$(call touch)

# vim: syntax=make
