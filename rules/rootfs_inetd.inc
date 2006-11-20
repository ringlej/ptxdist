# -*-makefile-*-
# $Id:$
#
# Copyright (C) 2006 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
# Note: This file will be included by rootfs.make
#
# TODO: If you want to add a new service to inetd, add it here. Do not forget to
# give the user a chance to use its own inetd string!
#
# Purpose: Populate inetd configuration into etc/
#
# "populate_inetd_conf" is a subtarget. See rootfs.make for use
#
$(STATEDIR)/rootfs.sub_populate_inetd_conf:

ifdef PTXCONF_ROOTFS_INETD
# /etc/inetd.conf
ifdef PTXCONF_ROOTFS_GENERIC_INETD
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/inetd.conf, \
		/etc/inetd.conf, n )
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/services, \
		/etc/services, n )
endif
ifdef PTXCONF_ROOTFS_USERS_INETD
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/inetd.conf, \
		/etc/inetd.conf, n )
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/services, \
		/etc/services, n )
endif

#
# Replace all markers if service is enabled
# or delete markers if service is disabled
################################
# add rshd if enabled
#
ifdef PTXCONF_INETUTILS_RSHD
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@RSHD@, shell stream tcp nowait root /usr/sbin/rshd )
	@$(call install_replace, rootfs, /etc/services, \
		@RSHD@, \
		"shell 514/tcp cmd" )
else
	@$(call install_replace, rootfs, /etc/inetd.conf, @RSHD@, )
	@$(call install_replace, rootfs, /etc/services, @RSHD@, )
endif
################################
# add NTP if enabled
#
ifdef PTXCONF_INETUTILS_NTP
# FIXME: What's needed to start ntp with inetd?
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@NTP@, "" )
	@$(call install_replace, rootfs, /etc/services, \
		@NTP@, \
		"ntp 123/tcp\nntp 123/udp" )
else
	@$(call install_replace, rootfs, /etc/inetd.conf, @NTP@, )
	@$(call install_replace, rootfs, /etc/services, @NTP@, )
endif
################################
# add cvs if enabled
#
ifdef PTXCONF_CVS_INETD_SERVER
ifneq ($(PTXCONF_CVS_INETD_STRING),"")
# add user defined string to start the cvs server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@CVSD@, $(PTXCONF_CVS_INETD_STRING) )
else
# add default string to start the cvs server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@CVSD@, \
		"cvspserver stream tcp nowait root /usr/bin/cvs cvsd -f @ROOT@ pserver" )
endif
ifneq ($(PTXCONF_CVS_SERVER_REPOSITORY),"")
# add info about repository's root
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@ROOT@, \
		"--allow-root=$(PTXCONF_CVS_SERVER_REPOSITORY)" )
else
# use cvs' default if not otherwise specified
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@ROOT@, )
endif
# add cvs service
	@$(call install_replace, rootfs, \
		/etc/services, \
		@CVSD@, \
		"cvspserver 2401/tcp\ncvspserver 2401/udp")
else
# remove all cvs entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @CVSD@, )
	@$(call install_replace, rootfs, /etc/services, @CVSD@, )
endif
################################
# add rsync if enabled
#
ifdef PTXCONF_RSYNC_INETD_SERVER
ifneq ($(PTXCONF_RSYNC_INETD_STRING),"")
# add user defined string to start rsync server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@RSYNCD@, $(PTXCONF_RSYNC_INETD_STRING) )
else
# add default string to start the rsync server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@RSYNCD@, \
		"rsync stream tcp nowait root /usr/bin/rsync rsyncd --daemon @CONFIG@" )
endif
ifneq ($(PTXCONF_RSYNC_CONFIG_FILE),"")
# add path and name of config file
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@CONFIG@, "--config=$(PTXCONF_RSYNC_CONFIG_FILE)" )
else
# use rpath' default if not otherwise specified
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@CONFIG@, )
endif
# add rsync service
	@$(call install_replace, rootfs, \
		/etc/services, \
		@RSYNCD@, \
		"rsync 873/tcp\nrsync 873/udp" )
else
# remove all cvs entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @RSYNCD@, )
	@$(call install_replace, rootfs, /etc/services, @RSYNCD@, )
endif
################################
# add famd if enabled
#
ifdef PTXCONF_FAM_INETD_SERVER
ifneq ($(PTXCONF_FAM_INETD_STRING),"")
# add user defined string to start famd server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@FAMD@, $(PTXCONF_FAM_INETD_STRING) )
else
# add default string to start the rsync server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@FAMD@, \
		"sgi_fam/1-2 stream  rpc/tcp wait root /usr/sbin/famd famd -c /etc/fam.conf" )
endif
else
# remove all famd entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @FAMD@, )
endif

################################
# add telnetd if enabled
#
ifdef PTXCONF_BB_CONFIG_FEATURE_TELNETD_INETD
# for busybox only!
# add default string to start the telnetd from busybox into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@TELNETD@, \
		"telnet stream  tcp wait root /usr/sbin/telnetd" )

	@$(call install_replace, rootfs, \
		/etc/services, \
		@TELNETD@, \
		"telnet 23/tcp\ntelnet 23/udp" )
else
# remove all telnetd entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @TELNETD@, )
	@$(call install_replace, rootfs, /etc/services, @TELNETD@, )
endif

################################
# add portmap if enabled
#
ifdef PTXCONF_PORTMAP_INETD_SERVER
ifneq ($(PTXCONF_PORTMAP_INETD_STRING),"")
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@PORTMAPD@, $(PTXCONF_PORTMAP_INETD_STRING) )
else
# add default string to start the portmap into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@PORTMAPD@, \
		"sunrpc stream tcp nowait root /sbin/portmap portmap" )
endif
	@$(call install_replace, rootfs, \
		/etc/services, \
		@PORTMAPD@, \
		"sunrpc 111/tcp\nsunrpc 111/udp" )
else
# remove all portmapd entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @PORTMAPD@, )
	@$(call install_replace, rootfs, /etc/services, @PORTMAPD@, )

endif

################################
# add dnsmasq if enabled
#
ifdef PTXCONF_DNSMASQ_INETD_SERVER
ifneq ($(PTXCONF_DNSMASQ_INETD_STRING),"")
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@DNSD@, \
		$(PTXCONF_DNSMASQ_INETD_STRING) )
else
# add default string to start the dnsmasq into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@DNSD@, \
		"domain stream tcp nowait root /sbin/dnsmasq domain" )
endif
# add dns service
	@$(call install_replace, rootfs, \
		/etc/services, \
		@DNSD@, \
		"domain 53/tcp\ndomain 53/udp" )
else
# remove all dnsmasq entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @DNSD@, )
	@$(call install_replace, rootfs, /etc/services, @DNSD@, )
endif
#
###########################################################################################
endif

# utelnet, thttpd, pureftpd, nfs-utils???,

# does the user wants his own file?
