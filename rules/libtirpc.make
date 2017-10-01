# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTIRPC) += libtirpc

#
# Paths and names
#
LIBTIRPC_VERSION	:= 1.0.2
LIBTIRPC_MD5		:= d5a37f1dccec484f9cabe2b97e54e9a6
LIBTIRPC		:= libtirpc-$(LIBTIRPC_VERSION)
LIBTIRPC_SUFFIX		:= tar.bz2
LIBTIRPC_URL		:= $(call ptx/mirror, SF, libtirpc/$(LIBTIRPC).$(LIBTIRPC_SUFFIX))
LIBTIRPC_SOURCE		:= $(SRCDIR)/$(LIBTIRPC).$(LIBTIRPC_SUFFIX)
LIBTIRPC_DIR		:= $(BUILDDIR)/$(LIBTIRPC)
LIBTIRPC_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBTIRPC_CONF_TOOL	:= autoconf
LIBTIRPC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gssapi \
	$(GLOBAL_IPV6_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtirpc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtirpc)
	@$(call install_fixup, libtirpc,PRIORITY,optional)
	@$(call install_fixup, libtirpc,SECTION,base)
	@$(call install_fixup, libtirpc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libtirpc,DESCRIPTION,missing)

	@$(call install_lib, libtirpc, 0, 0, 0644, libtirpc)
	@$(call install_alternative, libtirpc, 0, 0, 0644, \
		/etc/netconfig)

	@$(call install_finish, libtirpc)

	@$(call touch)

# vim: syntax=make
