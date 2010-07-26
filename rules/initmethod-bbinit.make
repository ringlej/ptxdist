# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INITMETHOD_BBINIT) += initmethod-bbinit

#
# Paths and names
#
INITMETHOD_BBINIT_VERSION	:= 1.0.0
INITMETHOD_BBINIT		:= initmethod-bbinit-$(INITMETHOD_BBINIT_VERSION)
INITMETHOD_BBINIT_DIR		:= $(BUILDDIR)/$(INITMETHOD_BBINIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(INITMETHOD_BBINIT_SOURCE):
	@$(call targetinfo)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/initmethod-bbinit.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/initmethod-bbinit.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/initmethod-bbinit.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initmethod-bbinit.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initmethod-bbinit.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  initmethod-bbinit)
	@$(call install_fixup, initmethod-bbinit, PRIORITY, optional)
	@$(call install_fixup, initmethod-bbinit, SECTION, base)
	@$(call install_fixup, initmethod-bbinit, AUTHOR, "Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, initmethod-bbinit, DESCRIPTION, missing)

#	# first of all: generate the required directories & rcS
	@$(call install_copy, initmethod-bbinit, 0, 0, 0755, /etc/init.d)
	@$(call install_copy, initmethod-bbinit, 0, 0, 0755, /etc/rc.d)
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0755, /etc/init.d/rcS, n)
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0644, /etc/inittab, n)
	@$(call install_replace, initmethod-bbinit, /etc/inittab, \
		@CONSOLE@, $(PTXCONF_CONSOLE_NAME))
	@$(call install_replace, initmethod-bbinit, /etc/inittab, \
		@SPEED@, $(PTXCONF_CONSOLE_SPEED))
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0755, /lib/init/initmethod-bbinit-functions.sh)

#	#
#	# start scripts
#	#
ifdef PTXCONF_INITMETHOD_BBINIT_ETC_INITD_BANNER
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0755, /etc/init.d/banner, n)

	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@PROJECT@, $(PTXCONF_PROJECT))
	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@PRJVERSION@, $(PTXCONF_PROJECT_VERSION))

	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@PTXDIST@, ptxdist)
	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@VERSION@, $(PTXDIST_VERSION_YEAR))
	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@PATCHLEVEL@, $(PTXDIST_VERSION_MONTH))
	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@SUBLEVEL@, $(PTXDIST_VERSION_BUGFIX))
	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@EXTRAVERSION@, $(PTXDIST_VERSION_SCM))
	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@DATE@, $(shell date -Iseconds))

	@$(call install_replace, initmethod-bbinit, /etc/init.d/banner, \
		@VENDOR@, $(PTXCONF_PROJECT_VENDOR))
endif

ifdef PTXCONF_INITMETHOD_BBINIT_ETC_INITD_MODULES
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0755, /etc/init.d/modules, n)
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0644, /etc/modules, n)
endif

ifdef PTXCONF_INITMETHOD_BBINIT_ETC_INITD_LOGROTATE
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0755, /etc/init.d/logrotate, n)
endif

ifdef PTXCONF_INITMETHOD_BBINIT_ETC_INITD_NETWORKING
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0755, /etc/init.d/networking, n)
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0644, /etc/network/interfaces, n)
	@$(call install_copy, initmethod-bbinit, 0, 0, 0755, /etc/network/if-down.d)
	@$(call install_copy, initmethod-bbinit, 0, 0, 0755, /etc/network/if-up.d)
	@$(call install_copy, initmethod-bbinit, 0, 0, 0755, /etc/network/if-post-down.d)
	@$(call install_copy, initmethod-bbinit, 0, 0, 0755, /etc/network/if-pre-up.d)
endif

ifdef PTXCONF_INITMETHOD_BBINIT_ETC_INITD_RT_SET_BANDWIDTH
	@$(call install_alternative, initmethod-bbinit, 0, 0, 0755, /etc/init.d/rt-set-bandwidth, n)
endif

#	#
#	# collect start links
#	#

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_APACHE2)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/apache2, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_APACHE2))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_AT)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/atd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_AT))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_CHRONY)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/chrony, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_CHRONY))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_CONNMAN)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/connman, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_CONNMAN))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_CVS)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/cvs, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_CVS))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_DBUS)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/dbus, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_DBUS))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_DNSMASQ)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/dnsmasq, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_DNSMASQ))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_DROPBEAR)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/dropbear, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_DROPBEAR))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_INETD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/inetd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_INETD))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_SYSLOGD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/syslogd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_SYSLOGD))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_CROND)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/crond, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_CROND))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_HWCLOCK)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/hwclock, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_HWCLOCK))
endif

ifneq ($(call remove_quotes, $(PTXCONF_INITMETHOD_BBINIT_LINK_LIGHTTPD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/lighttpd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_LIGHTTPD))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_MYSQL)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/mysql, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_MYSQL))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_NFSD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/nfsd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_NFSD))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_NTP)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/ntp-server, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_NTP))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_NTPC)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/ntp-client, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_NTPC))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_NTPCLIENT)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/ntpclient, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_NTPCLIENT))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_OPENSSH)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/openssh, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_OPENSSH))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_PORTMAP)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/portmapd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_PORTMAP))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_PPPD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/pppd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_PPPD))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_PROFTPD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/proftpd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_PROFTPD))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_PUREFTPD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/pureftpd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_PUREFTPD))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_RSYNCD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/rsyncd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_RSYNCD))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_SAMBA)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/samba, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_SAMBA))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_SYSLOG_NG)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/syslog-ng, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_SYSLOG_NG))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_TELNETD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/telnetd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_TELNETD))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_THTTPD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/thttpd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_THTTPD))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_UDEV)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/udev, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_UDEV))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_BANNER)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/banner, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_BANNER))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_LOGROTATE)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/logrotate, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_LOGROTATE))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_MODULES)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/modules, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_MODULES))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_NETWORKING)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/networking, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_NETWORKING))
endif

ifdef PTXCONF_ARCH_X86
ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_ACPID)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/acpid, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_ACPID))
endif
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_RT_SET_BANDWIDTH)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/rt-set-bandwidth, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_RT_SET_BANDWIDTH))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_LVM2)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/lvm2, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_LVM2))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_DIBBLER_SERVER)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/dibbler-server, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_DIBBLER_SERVER))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_DIBBLER_CLIENT)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/dibbler-client, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_DIBBLER_CLIENT))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_DIBBLER_RELAY)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/dibbler-relay, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_DIBBLER_RELAY))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_FAKE_OVERLAYFS)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/fake-overlayfs, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_FAKE_OVERLAYFS))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_RC_ONCE)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/rc-once, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_RC_ONCE))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_LINK_SPLASHUTILS)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/splashutils, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_LINK_SPLASHUTILS))
endif

ifneq ($(call remove_quotes,$(PTXCONF_INITMETHOD_BBINIT_SMARTD)),)
	@$(call install_link, initmethod-bbinit, \
		../init.d/smartd, \
		/etc/rc.d/$(PTXCONF_INITMETHOD_BBINIT_SMARTD))
endif

	@$(call install_finish, initmethod-bbinit)

	@$(call touch)

# vim: syntax=make

