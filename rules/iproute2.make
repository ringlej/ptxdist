# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
# Copyright (C) 2009 by Robert Schwebel/Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IPROUTE2) += iproute2

#
# Paths and names
#
IPROUTE2_VERSION	:= 4.7.0
IPROUTE2_MD5		:= d4b205830cdc2702f8a0cbd6232129cd
IPROUTE2		:= iproute2-$(IPROUTE2_VERSION)
IPROUTE2_SUFFIX		:= tar.xz
IPROUTE2_URL		:= $(call ptx/mirror, KERNEL, utils/net/iproute2/$(IPROUTE2).$(IPROUTE2_SUFFIX))
IPROUTE2_SOURCE		:= $(SRCDIR)/$(IPROUTE2).$(IPROUTE2_SUFFIX)
IPROUTE2_DIR		:= $(BUILDDIR)/$(IPROUTE2)
IPROUTE2_LICENSE	:= GPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# iproute2's configure is handcrafted and doesn't take standard configure options
IPROUTE2_CONF_OPT := ''

$(STATEDIR)/iproute2.prepare:
	@$(call targetinfo)
	@$(call world/prepare, IPROUTE2)
# overwrite options we don't want, or may be misdetected
	@echo 'TC_CONFIG_ATM:=n'	>> $(IPROUTE2_DIR)/Config
	@echo 'TC_CONFIG_XT:=y'		>> $(IPROUTE2_DIR)/Config
	@echo 'IPT_LIB_DIR:=/usr/lib'	>> $(IPROUTE2_DIR)/Config
	@echo 'TC_CONFIG_ELF:=n'	>> $(IPROUTE2_DIR)/Config
ifndef PTXCONF_GLOBAL_SELINUX
	@echo 'HAVE_SELINUX:=n'		>> $(IPROUTE2_DIR)/Config
endif
	@echo 'HAVE_MNL:=n'		>> $(IPROUTE2_DIR)/Config
ifndef PTXCONF_IPROUTE2_ARPD
	@echo 'HAVE_BERKELEY_DB:=n'	>> $(IPROUTE2_DIR)/Config
endif
	@$(call touch)

IPROUTE2_MAKE_OPT := \
	DESTDIR=$(SYSROOT) \
	LDFLAGS='-rdynamic' \
	WFLAGS="-Wall" \
	KERNEL_INCLUDE="$(KERNEL_HEADERS_INCLUDE_DIR)"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

IPROUTE2_INSTALL_FILES-y =
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_ARPD) +=	/sbin/arpd
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_BRIDGE) +=	/sbin/bridge
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_CTSTAT) +=	/sbin/ctstat
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_GENL) +=	/sbin/genl
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_IP) +=	/sbin/ip
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_IFCFG) +=	/sbin/ifcfg
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_IFSTAT) +=	/sbin/ifstat
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_LNSTAT) +=	/sbin/lnstat
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_NSTAT) +=	/sbin/nstat
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_ROUTEF) +=	/sbin/routef
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_ROUTEL) +=	/sbin/routel
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_RTACCT) +=	/sbin/rtacct
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_RTMON) +=	/sbin/rtmon
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_RTPR) +=	/sbin/rtpr
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_RTSTAT) +=	/sbin/rtstat
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_SS) +=	/sbin/ss
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_TC) +=	/sbin/tc


$(STATEDIR)/iproute2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iproute2)
	@$(call install_fixup, iproute2,PRIORITY,optional)
	@$(call install_fixup, iproute2,SECTION,base)
	@$(call install_fixup, iproute2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, iproute2,DESCRIPTION,missing)

	@for i in $(IPROUTE2_INSTALL_FILES-y); do \
		$(call install_copy, iproute2, 0, 0, 0755, -, $$i) \
	done

ifdef PTXCONF_IPROUTE2_TC
	@$(call install_copy, iproute2, 0, 0, 0644, -, /usr/lib/tc/normal.dist)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /usr/lib/tc/pareto.dist)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /usr/lib/tc/paretonormal.dist)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /usr/lib/tc/experimental.dist)
endif

	@$(call install_alternative, iproute2, 0, 0, 0644, /etc/iproute2/ematch_map)
	@$(call install_alternative, iproute2, 0, 0, 0644, /etc/iproute2/group)
	@$(call install_alternative, iproute2, 0, 0, 0644, /etc/iproute2/nl_protos)
	@$(call install_alternative, iproute2, 0, 0, 0644, /etc/iproute2/rt_dsfield)
	@$(call install_alternative, iproute2, 0, 0, 0644, /etc/iproute2/rt_protos)
	@$(call install_alternative, iproute2, 0, 0, 0644, /etc/iproute2/rt_realms)
	@$(call install_alternative, iproute2, 0, 0, 0644, /etc/iproute2/rt_scopes)
	@$(call install_alternative, iproute2, 0, 0, 0644, /etc/iproute2/rt_tables)

	@$(call install_finish, iproute2)

	@$(call touch)

# vim: syntax=make
