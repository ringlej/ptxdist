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
IPROUTE2_VERSION	:= 2.6.34
IPROUTE2		:= iproute2-$(IPROUTE2_VERSION)
IPROUTE2_SUFFIX		:= tar.bz2
IPROUTE2_URL		:= http://devresources.linuxfoundation.org/dev/iproute2/download/$(IPROUTE2).$(IPROUTE2_SUFFIX)
IPROUTE2_SOURCE		:= $(SRCDIR)/$(IPROUTE2).$(IPROUTE2_SUFFIX)
IPROUTE2_DIR		:= $(BUILDDIR)/$(IPROUTE2)
IPROUTE2_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(IPROUTE2_SOURCE):
	@$(call targetinfo)
	@$(call get, IPROUTE2)

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

$(STATEDIR)/iproute2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iproute2)
	@$(call install_fixup, iproute2,PRIORITY,optional)
	@$(call install_fixup, iproute2,SECTION,base)
	@$(call install_fixup, iproute2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, iproute2,DESCRIPTION,missing)

ifdef PTXCONF_IPROUTE2_IP
	@$(call install_copy, iproute2, 0, 0, 0755, -, /sbin/ip)
endif
ifdef PTXCONF_IPROUTE2_RTMON
	@$(call install_copy, iproute2, 0, 0, 0755, -, /sbin/rtmon)
endif
ifdef PTXCONF_IPROUTE2_TC
	@$(call install_copy, iproute2, 0, 0, 0755, -, /sbin/tc)
	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/lib/tc/normal.dist)

	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/lib/tc/pareto.dist)

	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/lib/tc/paretonormal.dist)
endif
ifdef PTXCONF_IPROUTE2_ARPD
	@$(call install_copy, iproute2, 0, 0, 0755, -, /sbin/arpd)
endif
ifdef PTXCONF_IPROUTE2_LNSTAT
	@$(call install_copy, iproute2, 0, 0, 0755, -, /sbin/lnstat)
endif
ifdef PTXCONF_IPROUTE2_NSTAT
	@$(call install_copy, iproute2, 0, 0, 0755, -, /sbin/nstat)
endif
ifdef PTXCONF_IPROUTE2_RTACCT
	@$(call install_copy, iproute2, 0, 0, 0755, -, /sbin/rtacct)
endif
ifdef PTXCONF_IPROUTE2_SS
	@$(call install_copy, iproute2, 0, 0, 0755, -, /sbin/ss)
endif

	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/etc/iproute2/ematch_map)

	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/etc/iproute2/rt_dsfield)

	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/etc/iproute2/rt_protos)

	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/etc/iproute2/rt_realms)

	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/etc/iproute2/rt_scopes)

	@$(call install_copy, iproute2, 0, 0, 0644, -, \
		/etc/iproute2/rt_tables)

	@$(call install_finish, iproute2)

	@$(call touch)

# vim: syntax=make
