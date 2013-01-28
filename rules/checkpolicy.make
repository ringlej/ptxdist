# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CHECKPOLICY) += checkpolicy

#
# Paths and names
#
CHECKPOLICY_VERSION	:= 2.1.11
CHECKPOLICY_MD5		:= 046b590de004f8a6cee655c4e95a7970
CHECKPOLICY		:= checkpolicy-$(CHECKPOLICY_VERSION)
CHECKPOLICY_SUFFIX	:= tar.gz
CHECKPOLICY_URL		:= http://userspace.selinuxproject.org/releases/20120924/$(CHECKPOLICY).$(CHECKPOLICY_SUFFIX)
CHECKPOLICY_SOURCE	:= $(SRCDIR)/$(CHECKPOLICY).$(CHECKPOLICY_SUFFIX)
CHECKPOLICY_DIR		:= $(BUILDDIR)/$(CHECKPOLICY)
CHECKPOLICY_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CHECKPOLICY_CONF_TOOL := NO
CHECKPOLICY_MAKE_ENV := $(CROSS_ENV)
CHECKPOLICY_MAKE_OPT := LIBDIR=$(PTXDIST_SYSROOT_TARGET)/usr/lib
CHECKPOLICY_INSTALL_OPT = \
	PREFIX=$(CHECKPOLICY_PKGDIR) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/checkpolicy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, checkpolicy)
	@$(call install_fixup, checkpolicy,PRIORITY,optional)
	@$(call install_fixup, checkpolicy,SECTION,base)
	@$(call install_fixup, checkpolicy,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, checkpolicy,DESCRIPTION,missing)

	@$(call install_copy, checkpolicy, 0, 0, 0755, $(CHECKPOLICY_DIR)/foobar, /dev/null)

	@$(call install_finish, checkpolicy)

	@$(call touch)

# vim: syntax=make
