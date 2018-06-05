# -*-makefile-*-
#
# Copyright (C) 2016 by Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMNL) += libmnl

#
# Paths and names
#
LIBMNL_VERSION	:= 1.0.4
LIBMNL_MD5	:= be9b4b5328c6da1bda565ac5dffadb2d
LIBMNL		:= libmnl-$(LIBMNL_VERSION)
LIBMNL_SUFFIX	:= tar.bz2
LIBMNL_URL		:= http://ftp.netfilter.org/pub/libmnl/$(LIBMNL).$(LIBMNL_SUFFIX)
LIBMNL_SOURCE	:= $(SRCDIR)/$(LIBMNL).$(LIBMNL_SUFFIX)
LIBMNL_DIR		:= $(BUILDDIR)/$(LIBMNL)
LIBMNL_LICENSE	:= GPL-2.0-only

#
# autoconf
#
LIBMNL_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmnl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmnl)
	@$(call install_fixup, libmnl,PRIORITY,optional)
	@$(call install_fixup, libmnl,SECTION,base)
	@$(call install_fixup, libmnl,AUTHOR,"Andreas Geisenhainer <andreas.geisenhainer@atsonline.de>")
	@$(call install_fixup, libmnl,DESCRIPTION,missing)

	@$(call install_lib, libmnl, 0, 0, 0644, libmnl)

	@$(call install_finish, libmnl)

	@$(call touch)

# vim: syntax=make
