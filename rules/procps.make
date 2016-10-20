# -*-makefile-*-
#
# Copyright (C) 2003 by Ixia Corporation, by Milan Bobde
#		2007 by Pengutronix e.K.
#		2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#		2015 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PROCPS) += procps

#
# Paths and names
#
PROCPS_VERSION	:= 3.3.12
PROCPS_MD5	:= 957e42e8b193490b2111252e4a2b443c
PROCPS		:= procps-ng-$(PROCPS_VERSION)
PROCPS_SUFFIX	:= tar.xz
PROCPS_URL	:= $(call ptx/mirror, SF, procps-ng/Production/$(PROCPS).$(PROCPS_SUFFIX))
PROCPS_SOURCE	:= $(SRCDIR)/$(PROCPS).$(PROCPS_SUFFIX)
PROCPS_DIR	:= $(BUILDDIR)/$(PROCPS)
PROCPS_LICENSE	:= GPL-2.0 (tools), LGPL-2.0 (libs)
PROCPS_LICENSE_FILES := \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://COPYING.LIB;md5=4cf66a4984120007c9881cc871cf49db

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PROCPS_CONF_ENV	:= \
	$(CROSS_ENV) \
	$(call ptx/ncurses, PTXCONF_PROCPS_USES_NCURSES)

#
# autoconf
#
PROCPS_CONF_TOOL	:= autoconf
PROCPS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-nls \
	--disable-rpath \
	--disable-kill \
	--$(call ptx/endis, PROCPS_TOP_MODERN)-modern-top \
	--prefix=/ \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--$(call ptx/wwo, PTXCONF_PROCPS_USES_NCURSES)-ncurses \
	--$(call ptx/wwo, PTXCONF_PROCPS_WITH_SYSTEMD)-systemd


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/procps.targetinstall:
	@$(call targetinfo)

	@$(call install_init, procps)
	@$(call install_fixup, procps,PRIORITY,optional)
	@$(call install_fixup, procps,SECTION,base)
	@$(call install_fixup, procps,AUTHOR,"Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, procps,DESCRIPTION,missing)

	@$(call install_lib, procps, 0, 0, 0644, libprocps)

ifdef PTXCONF_PROCPS_FREE
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/free, \
		/usr/bin/free)
endif
ifdef PTXCONF_PROCPS_PGREP
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/pgrep, \
		/usr/bin/pgrep)
endif
ifdef PTXCONF_PROCPS_PIDOF
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/pidof, \
		/usr/bin/pidof)
endif
ifdef PTXCONF_PROCPS_PKILL
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/pkill, \
		/usr/bin/pkill)
endif
ifdef PTXCONF_PROCPS_PMAP
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/pmap, \
		/usr/bin/pmap)
endif
ifdef PTXCONF_PROCPS_PS
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/ps, \
		/bin/ps)
endif
ifdef PTXCONF_PROCPS_PWDX
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/pwdx, \
		/usr/bin/pwdx)
endif
ifdef PTXCONF_PROCPS_SLABTOP
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/slabtop, \
		/usr/bin/slabtop)
endif
ifdef PTXCONF_PROCPS_SYSCTL
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/sbin/sysctl, \
		/sbin/sysctl)
	@$(call install_alternative, procps, 0, 0, 0644, /etc/sysctl.conf, n)
endif
ifdef PTXCONF_PROCPS_TOP
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/top, \
		/usr/bin/top)
endif
ifdef PTXCONF_PROCPS_UPTIME
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/uptime, \
		/usr/bin/uptime)
endif
ifdef PTXCONF_PROCPS_VMSTAT
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/vmstat, \
		/usr/bin/vmstat)
endif
ifdef PTXCONF_PROCPS_W
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/w, \
		/usr/bin/w)
endif
ifdef PTXCONF_PROCPS_WATCH
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_PKGDIR)/bin/watch, \
		/usr/bin/watch)
endif

	@$(call install_finish, procps)

	@$(call touch)

# vim: syntax=make
