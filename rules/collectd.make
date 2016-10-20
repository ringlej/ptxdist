# -*-makefile-*-
#
# Copyright (C) 2014 by Markus Pargmann <mpa@pengutronix.de>
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
COLLECTD_VERSION	:= 5.4.1
COLLECTD		:= collectd-$(COLLECTD_VERSION)
COLLECTD_SUFFIX		:= tar.bz2
COLLECTD_URL		:= http://collectd.org/files/${COLLECTD}.${COLLECTD_SUFFIX}
COLLECTD_MD5		:= 6f56c71c96573a7f4f7fb3bfab185974
COLLECTD_DIR		:= $(BUILDDIR)/$(COLLECTD)
COLLECTD_SOURCE		:= $(SRCDIR)/$(COLLECTD).$(COLLECTD_SUFFIX)
COLLECTD_LICENSE	:= GPL2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

COLLECTD_ENABLE-$(PTXCONF_COLLECTD_LOGFILE)	+= logfile
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_SYSLOG)	+= syslog
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_RRDTOOL)	+= rrdtool
COLLECTD_ENABLE-$(PTXCONF_COLLECTD_CPU)		+= cpu

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
	--disable-standards \
	--disable-glibtest \
	--disable-debug \
	--enable-daemon \
	--disable-getifaddrs \
	--disable-all-plugins \
	--with-included-ltdl \
	--with-nan-emulation \
	--with-fp-layout=nothing \
	\
	--disable-aggregation \
	--disable-amqp \
	--disable-apache \
	--disable-apcups \
	--disable-apple_sensors \
	--disable-aquaero \
	--disable-ascent \
	--disable-battery \
	--disable-bind \
	--disable-conntrack \
	--disable-contextswitch \
	--disable-cpufreq \
	--disable-csv \
	--disable-curl \
	--disable-curl_json \
	--disable-curl_xml \
	--disable-cgroups \
	--disable-dbi \
	--disable-df \
	--disable-disk \
	--disable-dns \
	--disable-email \
	--disable-entropy \
	--disable-ethstat \
	--disable-exec \
	--disable-filecount \
	--disable-fscache \
	--disable-gmond \
	--disable-hddtemp \
	--disable-interface \
	--disable-ipmi \
	--disable-iptables \
	--disable-ipvs \
	--disable-irq \
	--disable-java \
	--disable-libvirt \
	--disable-load \
	--disable-lpar \
	--disable-lvm \
	--disable-madwifi \
	--disable-match_empty_counter \
	--disable-match_hashed \
	--disable-match_regex \
	--disable-match_timediff \
	--disable-match_value \
	--disable-mbmon \
	--disable-md \
	--disable-memcachec \
	--disable-memcached \
	--disable-memory \
	--disable-mic \
	--disable-modbus \
	--disable-multimeter \
	--disable-mysql \
	--disable-netapp \
	--disable-netlink \
	--disable-network \
	--disable-nfs \
	--disable-nginx \
	--disable-notify_desktop \
	--disable-notify_email \
	--disable-ntpd \
	--disable-numa \
	--disable-nut \
	--disable-olsrd \
	--disable-onewire \
	--disable-openvpn \
	--disable-oracle \
	--disable-perl \
	--disable-pf \
	--disable-pinba \
	--disable-ping \
	--disable-postgresql \
	--disable-powerdns \
	--disable-processes \
	--disable-protocols \
	--disable-python \
	--disable-redis \
	--disable-routeros \
	--disable-rrdcached \
	--disable-sensors \
	--disable-serial \
	--disable-sigrok \
	--disable-snmp \
	--disable-statsd \
	--disable-swap \
	--disable-table \
	--disable-tail \
	--disable-tail_csv \
	--disable-tape \
	--disable-target_notification \
	--disable-target_replace \
	--disable-target_scale \
	--disable-target_set \
	--disable-target_v5upgrade \
	--disable-tcpconns \
	--disable-teamspeak2 \
	--disable-ted \
	--disable-thermal \
	--disable-threshold \
	--disable-tokyotyrant \
	--disable-unixsock \
	--disable-uptime \
	--disable-users \
	--disable-uuid \
	--disable-varnish \
	--disable-vmem \
	--disable-vserver \
	--disable-wireless \
	--disable-write_graphite \
	--disable-write_http \
	--disable-write_mongodb \
	--disable-write_redis \
	--disable-write_riemann \
	--disable-xmms \
	--disable-zfs_arc \
	--without-perl-bindings

ifneq ($(call remove_quotes,$(COLLECTD_ENABLE-y)),)
COLLECTD_CONF_OPT += --enable-$(subst $(space),$(space)--enable-,$(strip $(COLLECTD_ENABLE-y)))
endif

ifneq ($(call remove_quotes,$(COLLECTD_ENABLE-)),)
COLLECTD_CONF_OPT += --disable-$(subst $(space),$(space)--disable-,$(strip $(COLLECTD_ENABLE-)))
endif

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
	@$(call install_copy, collectd, 0, 0, 0644, /etc/collectd)
	@$(call install_copy, collectd, 0, 0, 0644, -, /usr/share/collectd/types.db)
	@$(call install_copy, collectd, 0, 0, 0755, /usr/lib/collectd)


ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_alternative, collectd, 0, 0, 0644, /lib/systemd/system/collectd.service)
	@$(call install_link, collectd, \
		../collectd.service, \
		/lib/systemd/system/multi-user.target.wants/collectd.service \
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
