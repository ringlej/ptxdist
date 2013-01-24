# -*-makefile-*-
#
# Copyright (C) 2012 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNL3) += libnl3

#
# Paths and names
#
LIBNL3_VERSION	:= 3.2.21
LIBNL3_MD5	:= 6fe7136558a9071e70673dcda38545b3
LIBNL3		:= libnl-$(LIBNL3_VERSION)
LIBNL3_SUFFIX	:= tar.gz
LIBNL3_URL	:= http://www.infradead.org/~tgr/libnl/files/$(LIBNL3).$(LIBNL3_SUFFIX)
LIBNL3_SOURCE	:= $(SRCDIR)/$(LIBNL3).$(LIBNL3_SUFFIX)
LIBNL3_DIR	:= $(BUILDDIR)/$(LIBNL3)
LIBNL3_LICENSE	:= GPLv2

#
# autoconf
#
LIBNL3_CONF_TOOL    := autoconf
LIBNL3_CONF_OPT	    := \
	$(CROSS_AUTOCONF_USR) \
	--disable-manpages \
	--enable-shared \
	--disable-static \
	--$(call ptx/endis, PTXCONF_LIBNL3_ENABLE_CLI)-cli \
	--enable-pthreads

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIBNL3_INSTALL_FILES-y =
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=genl-ctrl-list
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-class-add
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-class-delete
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-classid-lookup
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-class-list
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-cls-add
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-cls-delete
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-cls-list
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-link-list
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-pktloc-lookup
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-qdisc-add
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-qdisc-delete
LIBNL3_INSTALL_FILES-$(PTXCONF_LIBNL3_ENABLE_CLI)   +=nl-qdisc-list

$(STATEDIR)/libnl3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnl3)
	@$(call install_fixup, libnl3,PRIORITY,optional)
	@$(call install_fixup, libnl3,SECTION,base)
	@$(call install_fixup, libnl3,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, libnl3,DESCRIPTION,missing)

	@$(call install_lib, libnl3, 0, 0, 0644, libnl-3)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl-genl-3)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl-nf-3)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl-route-3)

ifdef PTXCONF_LIBNL3_ENABLE_CLI
	@$(call install_lib, libnl3, 0, 0, 0644, libnl-cli-3)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl/cli/cls/basic)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl/cli/cls/cgroup)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl/cli/qdisc/bfifo)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl/cli/qdisc/blackhole)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl/cli/qdisc/htb)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl/cli/qdisc/pfifo)
	@$(call install_lib, libnl3, 0, 0, 0644, libnl/cli/qdisc/plug)
endif

	@$(foreach tool,$(LIBNL3_INSTALL_FILES-y), \
		$(call install_copy, libnl3, 0, 0, 0755, -, /usr/sbin/$(tool));)

	@$(call install_alternative, libnl3, 0, 0, 0644, /etc/libnl/classid)
	@$(call install_alternative, libnl3, 0, 0, 0644, /etc/libnl/pktloc)

	@$(call install_finish, libnl3)

	@$(call touch)

# vim: syntax=make
