# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RSYSLOG) += rsyslog

#
# Paths and names
#
RSYSLOG_VERSION	:= 5.8.1
RSYSLOG_MD5		:= 909d4d867450aeedd6b388c199d79222
RSYSLOG		:= rsyslog-$(RSYSLOG_VERSION)
RSYSLOG_SUFFIX	:= tar.gz
RSYSLOG_URL		:= http://www.rsyslog.com/files/download/rsyslog/$(RSYSLOG).$(RSYSLOG_SUFFIX)
RSYSLOG_SOURCE	:= $(SRCDIR)/$(RSYSLOG).$(RSYSLOG_SUFFIX)
RSYSLOG_DIR		:= $(BUILDDIR)/$(RSYSLOG)
RSYSLOG_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
RSYSLOG_CONF_TOOL	:= autoconf
RSYSLOG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXCONF_RSYSLOG_REGEXP)-regexp \
	--$(call ptx/endis, PTXCONF_RSYSLOG_ZLIB)-zlib \
	--disable-gssapi-krb5 \
	--enable-pthreads \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMKLOG)-klog \
	--disable-unix \
	--$(call ptx/endis, PTXCONF_RSYSLOG_INET)-inet \
	--enable-fsstnd \
	--enable-unlimited-select \
	--disable-debug \
	--disable-rtinst \
	--disable-valgrind \
	--disable-memcheck \
	--disable-diagtools \
	--disable-mysql \
	--disable-pgsql \
	--disable-oracle \
	--disable-libdbi \
	--disable-snmp \
	--disable-gnutls \
	--enable-rsyslogrt \
	--enable-rsyslogd \
	--disable-mysql-tests \
	--disable-mail \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMDIAG)-imdiag \
	--disable-relp \
	--disable-rfc3195 \
	--disable-testbench \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMFILE)-imfile \
	--disable-imsolaris \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMPTCP)-imptcp \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMPSTATS)-impstats \
	--$(call ptx/endis, PTXCONF_RSYSLOG_OMPROG)-omprog \
	--$(call ptx/endis, PTXCONF_RSYSLOG_OMUDPSPOOF)-omudpspoof \
	--$(call ptx/endis, PTXCONF_RSYSLOG_OMSTDOUT)-omstdout \
	--$(call ptx/endis, PTXCONF_RSYSLOG_PMLASTMSG)-pmlastmsg \
	--disable-pmcisconames \
	--disable-pmaixforwardedfrom \
	--disable-pmsnare \
	--disable-pmrfc3164sd \
	--disable-omruleset \
	--disable-omdbalerting \
	--disable-gui \
	--$(call ptx/endis, PTXCONF_RSYSLOG_OMUXSOCK)-omuxsock \
	--disable-cust1 \
	--disable-smcustbindcdr \
	--disable-imtemplate \
	--disable-omtemplate \
	--disable-mmsnmptrapd \
	--disable-omhdfs \

ifdef PTXCONF_RSYSLOG_SYSTEMD_UNIT
RSYSLOG_CONF_OPT += --with-systemdsystemunitdir=/lib/systemd/system
else
RSYSLOG_CONF_OPT += --without-systemdsystemunitdir
endif

RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMDIAG)	+= imdiag
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMFILE)	+= imfile
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMKLOG)	+= imklog
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMMARK)	+= immark
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMPSTATS)	+= impstats
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMPTCP)	+= imptcp
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMTCP)	+= imtcp
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMUDP)	+= imudp
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMUXSOCK)	+= imuxsock
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_INET)		+= lmnet
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_INET)		+= lmnetstrms
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_INET)		+= lmnsd_ptcp
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_REGEXP)	+= lmregexp
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_INET)		+= lmstrmsrv
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_INET)		+= lmtcpclt
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_INET)		+= lmtcpsrv
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_ZLIB)		+= lmzlibw
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_OMPROG)	+= omprog
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_OMSTDOUT)	+= omstdout
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_OMUDPSPOOF)	+= omudpspoof
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_OMUXSOCK)	+= omuxsock
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_PMLASTMSG)	+= pmlastmsg

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rsyslog.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rsyslog)
	@$(call install_fixup, rsyslog,PRIORITY,optional)
	@$(call install_fixup, rsyslog,SECTION,base)
	@$(call install_fixup, rsyslog,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, rsyslog,DESCRIPTION,missing)

	@$(call install_copy, rsyslog, 0, 0, 0755, -, /usr/sbin/rsyslogd)

	@$(call install_alternative, rsyslog, 0, 0, 0644, /etc/rsyslog.conf)

ifdef PTXCONF_RSYSLOG_SYSTEMD_UNIT
	@$(call install_copy, rsyslog, 0, 0, 0644, -, \
		/lib/systemd/system/rsyslog.service)
	@$(call install_link, rsyslog, ../rsyslog.service, \
		/lib/systemd/system/multi-user.target.wants/rsyslog.service)
endif

	@for plugin in $(RSYSLOG_PLUGINS-y); do \
		$(call install_copy, rsyslog, 0, 0, 0644, -, \
			/usr/lib/rsyslog/$$plugin.so); \
	done

	@$(call install_finish, rsyslog)

	@$(call touch)

# vim: syntax=make
