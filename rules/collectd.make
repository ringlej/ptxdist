# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
# Copyright (C) 2016 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_COLLECTD) += collectd

#
# Paths and names
#
COLLECTD_VERSION	:= 5.8.1
COLLECTD		:= collectd-$(COLLECTD_VERSION)
COLLECTD_SUFFIX		:= tar.bz2
COLLECTD_URL		:= https://collectd.org/files/${COLLECTD}.${COLLECTD_SUFFIX}
COLLECTD_MD5		:= bfce96c42cede5243028510bcc57c1e6
COLLECTD_DIR		:= $(BUILDDIR)/$(COLLECTD)
COLLECTD_SOURCE		:= $(SRCDIR)/$(COLLECTD).$(COLLECTD_SUFFIX)
COLLECTD_LICENSE	:= MIT AND GPL-2.0-only
COLLECTD_LICENSE_FILES	:= file://COPYING;md5=1bd21f19f7f0c61a7be8ecacb0e28854

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# 'noyywrap' is set, so no lex library is needed
COLLECTD_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_lex=''

#
# autoconf
#
COLLECTD_CONF_TOOL	:= autoconf
COLLECTD_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-xfs \
	--disable-debug \
	--enable-daemon \
	--disable-getifaddrs \
	--disable-werror \
	--disable-all-plugins \
	--without-libgcrypt \
	--with-nan-emulation \
	--with-fp-layout=nothing \
	--without-libdpdk \
	--without-perl-bindings

# Plugins
COLLECTD_ENABLE-				+= aggregation
COLLECTD_ENABLE-				+= amqp
COLLECTD_ENABLE-				+= apache
COLLECTD_ENABLE-				+= apcups
COLLECTD_ENABLE-				+= apple_sensors
COLLECTD_ENABLE-				+= aquaero
COLLECTD_ENABLE-				+= ascent
COLLECTD_ENABLE-				+= barometer
COLLECTD_ENABLE-				+= battery
COLLECTD_ENABLE-				+= bind
COLLECTD_ENABLE-				+= ceph
COLLECTD_ENABLE-				+= cgroups
COLLECTD_ENABLE-				+= chrony
COLLECTD_ENABLE-				+= conntrack
COLLECTD_ENABLE-				+= contextswitch
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_CPU)		+= cpu
COLLECTD_ENABLE-				+= cpufreq
COLLECTD_ENABLE-				+= cpusleep
COLLECTD_ENABLE-				+= csv
COLLECTD_ENABLE-				+= curl
COLLECTD_ENABLE-				+= curl_json
COLLECTD_ENABLE-				+= curl_xml
COLLECTD_ENABLE-				+= dbi
COLLECTD_ENABLE-				+= df
COLLECTD_ENABLE-				+= disk
COLLECTD_ENABLE-				+= dns
COLLECTD_ENABLE-				+= dpdkevents
COLLECTD_ENABLE-				+= dpdkstat
COLLECTD_ENABLE-				+= drbd
COLLECTD_ENABLE-				+= email
COLLECTD_ENABLE-				+= entropy
COLLECTD_ENABLE-				+= ethstat
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_EXEC)	+= exec
COLLECTD_ENABLE-				+= fhcount
COLLECTD_ENABLE-				+= filecount
COLLECTD_ENABLE-				+= fscache
COLLECTD_ENABLE-				+= gmond
COLLECTD_ENABLE-				+= gps
COLLECTD_ENABLE-				+= grpc
COLLECTD_ENABLE-				+= hddtemp
COLLECTD_ENABLE-				+= hugepages
COLLECTD_ENABLE-				+= intel_pmu
COLLECTD_ENABLE-				+= intel_rdt
COLLECTD_ENABLE-				+= interface
COLLECTD_ENABLE-				+= ipc
COLLECTD_ENABLE-				+= ipmi
COLLECTD_ENABLE-				+= iptables
COLLECTD_ENABLE-				+= ipvs
COLLECTD_ENABLE-				+= irq
COLLECTD_ENABLE-				+= java
COLLECTD_ENABLE-				+= load
COLLECTD_ENABLE-				+= log_logstash
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_LOGFILE)	+= logfile
COLLECTD_ENABLE-				+= lpar
COLLECTD_ENABLE-				+= lua
COLLECTD_ENABLE-				+= lvm
COLLECTD_ENABLE-				+= madwifi
COLLECTD_ENABLE-				+= match_empty_counter
COLLECTD_ENABLE-				+= match_hashed
COLLECTD_ENABLE-				+= match_regex
COLLECTD_ENABLE-				+= match_timediff
COLLECTD_ENABLE-				+= match_value
COLLECTD_ENABLE-				+= mbmon
COLLECTD_ENABLE-				+= mcelog
COLLECTD_ENABLE-				+= md
COLLECTD_ENABLE-				+= memcachec
COLLECTD_ENABLE-				+= memcached
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_MEMORY)	+= memory
COLLECTD_ENABLE-				+= mic
COLLECTD_ENABLE-				+= modbus
COLLECTD_ENABLE-				+= mqtt
COLLECTD_ENABLE-				+= multimeter
COLLECTD_ENABLE-				+= mysql
COLLECTD_ENABLE-				+= netapp
COLLECTD_ENABLE-				+= netlink
COLLECTD_ENABLE-				+= network
COLLECTD_ENABLE-				+= nfs
COLLECTD_ENABLE-				+= nginx
COLLECTD_ENABLE-				+= notify_desktop
COLLECTD_ENABLE-				+= notify_email
COLLECTD_ENABLE-				+= notify_nagios
COLLECTD_ENABLE-				+= ntpd
COLLECTD_ENABLE-				+= numa
COLLECTD_ENABLE-				+= nut
COLLECTD_ENABLE-				+= olsrd
COLLECTD_ENABLE-				+= onewire
COLLECTD_ENABLE-				+= openldap
COLLECTD_ENABLE-				+= openvpn
COLLECTD_ENABLE-				+= oracle
COLLECTD_ENABLE-				+= ovs_events
COLLECTD_ENABLE-				+= ovs_stats
COLLECTD_ENABLE-				+= perl
COLLECTD_ENABLE-				+= pf
COLLECTD_ENABLE-				+= pinba
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_PING)	+= ping
COLLECTD_ENABLE-				+= postgresql
COLLECTD_ENABLE-				+= powerdns
COLLECTD_ENABLE-				+= processes
COLLECTD_ENABLE-				+= protocols
COLLECTD_ENABLE-				+= python
COLLECTD_ENABLE-				+= redis
COLLECTD_ENABLE-				+= routeros
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_RRDCACHED)	+= rrdcached
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_RRDTOOL)	+= rrdtool
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_SENSORS)	+= sensors
COLLECTD_ENABLE-				+= serial
COLLECTD_ENABLE-				+= sigrok
COLLECTD_ENABLE-				+= smart
COLLECTD_ENABLE-				+= snmp
COLLECTD_ENABLE-				+= snmp_agent
COLLECTD_ENABLE-				+= statsd
COLLECTD_ENABLE-				+= swap
COLLECTD_ENABLE-				+= synproxy
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_SYSLOG)	+= syslog
COLLECTD_ENABLE-				+= table
COLLECTD_ENABLE-				+= tail
COLLECTD_ENABLE-				+= tail_csv
COLLECTD_ENABLE-				+= tape
COLLECTD_ENABLE-				+= target_notification
COLLECTD_ENABLE-				+= target_replace
COLLECTD_ENABLE-				+= target_scale
COLLECTD_ENABLE-				+= target_set
COLLECTD_ENABLE-				+= target_v5upgrade
COLLECTD_ENABLE-				+= tcpconns
COLLECTD_ENABLE-				+= teamspeak2
COLLECTD_ENABLE-				+= ted
COLLECTD_ENABLE-				+= thermal
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_THRESHOLD)	+= threshold
COLLECTD_ENABLE-				+= tokyotyrant
COLLECTD_ENABLE-				+= turbostat
COLLECTD_ENABLE-				+= unixsock
COLLECTD_ENABLE-				+= uptime
COLLECTD_ENABLE-				+= users
COLLECTD_ENABLE-				+= uuid
COLLECTD_ENABLE-				+= varnish
COLLECTD_ENABLE-				+= virt
COLLECTD_ENABLE-				+= vmem
COLLECTD_ENABLE-				+= vserver
COLLECTD_ENABLE-				+= wireless
COLLECTD_ENABLE-				+= write_graphite
COLLECTD_ENABLE-				+= write_http
COLLECTD_ENABLE-				+= write_kafka
COLLECTD_ENABLE-				+= write_log
COLLECTD_ENABLE-				+= write_mongodb
COLLECTD_ENABLE-				+= write_prometheus
COLLECTD_ENABLE-				+= write_redis
COLLECTD_ENABLE-				+= write_riemann
COLLECTD_ENABLE-				+= write_sensu
COLLECTD_ENABLE-				+= write_tsdb
COLLECTD_ENABLE-				+= xencpu
COLLECTD_ENABLE-				+= xmms
COLLECTD_ENABLE-				+= zfs_arc
COLLECTD_ENABLE-				+= zone
COLLECTD_ENABLE-				+= zookeeper

COLLECTD_CONF_OPT += \
	$(addprefix --enable-,$(COLLECTD_ENABLE-y)) \
	$(addprefix --disable-,$(COLLECTD_ENABLE-))

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/collectd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, collectd)
	@$(call install_fixup, collectd, PRIORITY, optional)
	@$(call install_fixup, collectd, SECTION, base)
	@$(call install_fixup, collectd, AUTHOR, "Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, collectd, DESCRIPTION, missing)

#	# base files + directories
	@$(call install_lib, collectd, 0, 0, 0644, libcollectdclient)
	@$(call install_copy, collectd, 0, 0, 0755, -, /usr/sbin/collectd)
	@$(call install_alternative, collectd, 0, 0, 0644, /etc/collectd.conf)
	@$(call install_copy, collectd, 0, 0, 0644, -, /usr/share/collectd/types.db)
	@$(call install_copy, collectd, 0, 0, 0755, /usr/lib/collectd)


ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_alternative, collectd, 0, 0, 0644, /usr/lib/systemd/system/collectd.service)
	@$(call install_link, collectd, \
		../collectd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/collectd.service \
	)
endif
	# Plugins
	@for plugin in $(COLLECTD_ENABLE-y); do \
		$(call install_copy, collectd, 0, 0, 0644, -, \
			/usr/lib/collectd/$${plugin}.so); \
		$(call install_alternative, collectd, 0, 0, 0644, \
			/etc/collectd.d/$${plugin}.conf); \
	done

	@$(call install_finish, collectd)

	@$(call touch)

# vim: syntax=make
