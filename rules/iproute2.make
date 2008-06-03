# -*-makefile-*-
# $Id: template 5616 2006-06-02 13:50:47Z rsc $
#
# Copyright (C) 2006 by Erwin Rol
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
IPROUTE2_VERSION	:= 2.6.23
IPROUTE2		:= iproute2-$(IPROUTE2_VERSION)
IPROUTE2_SUFFIX		:= tar.bz2
IPROUTE2_URL		:= http://developer.osdl.org/dev/iproute2/download/$(IPROUTE2).$(IPROUTE2_SUFFIX)
IPROUTE2_SOURCE		:= $(SRCDIR)/$(IPROUTE2).$(IPROUTE2_SUFFIX)
IPROUTE2_DIR		:= $(BUILDDIR)/$(IPROUTE2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

iproute2_get: $(STATEDIR)/iproute2.get

$(STATEDIR)/iproute2.get: $(iproute2_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(IPROUTE2_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, IPROUTE2)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

iproute2_extract: $(STATEDIR)/iproute2.extract

$(STATEDIR)/iproute2.extract: $(iproute2_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IPROUTE2_DIR))
	@$(call extract, IPROUTE2)
	@$(call patchin, IPROUTE2)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

iproute2_prepare: $(STATEDIR)/iproute2.prepare

IPROUTE2_PATH	:=  PATH=$(CROSS_PATH)
IPROUTE2_ENV 	:=  $(CROSS_ENV)
IPROUTE2_MAKEVARS = $(call remove_quotes, $(CROSS_ENV_CC) CFLAGS='$(CROSS_CPPFLAGS) -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -I../include -DRESOLVE_HOSTNAMES' LDFLAGS='$(CROSS_LDFLAGS) -L../lib -lnetlink -lutil' DBM_INCLUDE=$(SYSROOT)/usr/include)

#
# autoconf
#
IPROUTE2_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/iproute2.prepare: $(iproute2_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IPROUTE2_DIR)/config.cache)
	touch $(IPROUTE2_DIR)/Config
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

iproute2_compile: $(STATEDIR)/iproute2.compile

$(STATEDIR)/iproute2.compile: $(iproute2_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(IPROUTE2_DIR) && $(IPROUTE2_PATH) make $(IPROUTE2_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

iproute2_install: $(STATEDIR)/iproute2.install

$(STATEDIR)/iproute2.install: $(iproute2_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

iproute2_targetinstall: $(STATEDIR)/iproute2.targetinstall

$(STATEDIR)/iproute2.targetinstall: $(iproute2_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, iproute2)
	@$(call install_fixup,iproute2,PACKAGE,iproute2)
	@$(call install_fixup,iproute2,PRIORITY,optional)
	@$(call install_fixup,iproute2,VERSION,$(IPROUTE2_VERSION))
	@$(call install_fixup,iproute2,SECTION,base)
	@$(call install_fixup,iproute2,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,iproute2,DEPENDS,)
	@$(call install_fixup,iproute2,DESCRIPTION,missing)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/ip/ip, \
		/sbin/ip )
	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/ip/rtmon, \
		/sbin/rtmon)
	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/tc/tc, \
		/sbin/tc)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/misc/arpd, \
		/usr/sbin/arpd )
	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/misc/lnstat, \
		/usr/sbin/lnstat )
	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/misc/nstat, \
		/usr/sbin/nstat )
	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/misc/rtacct, \
		/usr/sbin/rtacct )
	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/misc/ss, \
		/usr/sbin/ss )

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/netem/normal.dist, \
		/usr/lib/tc/normal.dist,n)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/netem/pareto.dist, \
		/usr/lib/tc/pareto.dist,n)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/netem/paretonormal.dist, \
		/usr/lib/tc/paretonormal.dist,n)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/etc/iproute2/ematch_map, \
		/etc/iproute2/ematch_map,n)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/etc/iproute2/rt_dsfield, \
		/etc/iproute2/rt_dsfield,n)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/etc/iproute2/rt_protos, \
		/etc/iproute2/rt_protos,n)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/etc/iproute2/rt_realms, \
		/etc/iproute2/rt_realms,n)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/etc/iproute2/rt_scopes, \
		/etc/iproute2/rt_scopes,n)

	@$(call install_copy, iproute2, 0, 0, 0755, \
		$(IPROUTE2_DIR)/etc/iproute2/rt_tables, \
		/etc/iproute2/rt_tables,n)

	@$(call install_finish,iproute2)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

iproute2_clean:
	rm -rf $(STATEDIR)/iproute2.*
	rm -rf $(PKGDIR)/iproute2_*
	rm -rf $(IPROUTE2_DIR)

# vim: syntax=make
