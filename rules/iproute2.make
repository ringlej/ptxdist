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
IPROUTE2_VERSION	:= 2.6.39
IPROUTE2_MD5		:= 8a3b6bc77c2ecf752284aa4a6fc630a6
IPROUTE2		:= iproute2-$(IPROUTE2_VERSION)
IPROUTE2_SUFFIX		:= tar.gz
IPROUTE2_URL		:= \
	http://devresources.linuxfoundation.org/dev/iproute2/download/$(IPROUTE2).$(IPROUTE2_SUFFIX) \
	http://www.linuxgrill.com/anonymous/iproute2/NEW-OSDL/$(IPROUTE2).$(IPROUTE2_SUFFIX)
IPROUTE2_SOURCE		:= $(SRCDIR)/$(IPROUTE2).$(IPROUTE2_SUFFIX)
IPROUTE2_DIR		:= $(BUILDDIR)/$(IPROUTE2)
IPROUTE2_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IPROUTE2_PATH	:= PATH=$(CROSS_PATH)
IPROUTE2_ENV 	:= $(CROSS_ENV)
IPROUTE2_MAKEVARS := \
	CC=$(PTXCONF_GNU_TARGET)-gcc \
	CROSS_CPPFLAGS='$(CROSS_CPPFLAGS) -g' \
	LDFLAGS='$(CROSS_LDFLAGS) -g -rdynamic' \
	DBM_INCLUDE=$(SYSROOT)/usr/include

$(STATEDIR)/iproute2.prepare:
	@$(call targetinfo)
	@touch $(IPROUTE2_DIR)/Config
ifdef PTXCONF_IPROUTE2_ARPD
	@echo BUILD_ARPD=y >> $(IPROUTE2_DIR)/Config
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

IPROUTE2_INSTALL_FILES-y =
IPROUTE2_INSTALL_FILES-$(PTXCONF_IPROUTE2_ARPD) +=	/sbin/arpd
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
	@$(call install_copy, iproute2, 0, 0, 0644, -, /usr/lib/tc/pareto.dist)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /usr/lib/tc/paretonormal.dist)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /usr/lib/tc/experimental.dist)
endif

	@$(call install_copy, iproute2, 0, 0, 0644, -, /etc/iproute2/ematch_map)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /etc/iproute2/rt_dsfield)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /etc/iproute2/rt_protos)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /etc/iproute2/rt_realms)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /etc/iproute2/rt_scopes)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /etc/iproute2/rt_tables)
	@$(call install_copy, iproute2, 0, 0, 0644, -, /etc/iproute2/group)

	@$(call install_finish, iproute2)

	@$(call touch)

# vim: syntax=make
