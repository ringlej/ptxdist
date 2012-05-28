# -*-makefile-*-
#
# Copyright (C) 2011 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETFILTER_CONNTRACK) += libnetfilter_conntrack

#
# Paths and names
#
LIBNETFILTER_CONNTRACK_VERSION	:= 0.9.0
LIBNETFILTER_CONNTRACK_MD5	:= 67e6b44c4d9343a8b3d3ba36bb0a4a8b
LIBNETFILTER_CONNTRACK		:= libnetfilter_conntrack-$(LIBNETFILTER_CONNTRACK_VERSION)
LIBNETFILTER_CONNTRACK_SUFFIX	:= tar.bz2
LIBNETFILTER_CONNTRACK_URL	:= http://ftp.netfilter.org/pub/libnetfilter_conntrack/$(LIBNETFILTER_CONNTRACK).$(LIBNETFILTER_CONNTRACK_SUFFIX)
LIBNETFILTER_CONNTRACK_SOURCE	:= $(SRCDIR)/$(LIBNETFILTER_CONNTRACK).$(LIBNETFILTER_CONNTRACK_SUFFIX)
LIBNETFILTER_CONNTRACK_DIR	:= $(BUILDDIR)/$(LIBNETFILTER_CONNTRACK)
LIBNETFILTER_CONNTRACK_LICENSE	:= GPLv2

#
# autoconf
#
LIBNETFILTER_CONNTRACK_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnetfilter_conntrack.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnetfilter_conntrack)
	@$(call install_fixup, libnetfilter_conntrack,PRIORITY,optional)
	@$(call install_fixup, libnetfilter_conntrack,SECTION,base)
	@$(call install_fixup, libnetfilter_conntrack,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, libnetfilter_conntrack,DESCRIPTION,missing)

	@$(call install_lib, libnetfilter_conntrack, 0, 0, 0644, libnetfilter_conntrack)

	@$(call install_finish, libnetfilter_conntrack)
	@$(call touch)

