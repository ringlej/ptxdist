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
RSYSLOG_VERSION	:= 8.26.0
RSYSLOG_MD5	:= abe20d1621d1e73326c08b964a556ed7
RSYSLOG		:= rsyslog-$(RSYSLOG_VERSION)
RSYSLOG_SUFFIX	:= tar.gz
RSYSLOG_URL	:= http://www.rsyslog.com/files/download/rsyslog/$(RSYSLOG).$(RSYSLOG_SUFFIX)
RSYSLOG_SOURCE	:= $(SRCDIR)/$(RSYSLOG).$(RSYSLOG_SUFFIX)
RSYSLOG_DIR	:= $(BUILDDIR)/$(RSYSLOG)
RSYSLOG_LICENSE	:= GPL-3.0-or-later AND LGPL-3.0-or-later AND Apache-2.0
RSYSLOG_LICENSE_FILES := \
	file://COPYING;md5=51d9635e646fb75e1b74c074f788e973 \
	file://COPYING.LESSER;md5=cb7903f1e5c39ae838209e130dca270a \
	file://COPYING.ASL20;md5=052f8a09206615ab07326ff8ce2d9d32

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
	--disable-gssapi-krb5 \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMKLOG)-klog \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMKMSG)-kmsg \
	--$(call ptx/endis, PTXCONF_RSYSLOG_SYSTEMD)-imjournal \
	--$(call ptx/endis, PTXCONF_RSYSLOG_INET)-inet \
	--disable-jemalloc \
	--disable-unlimited-select \
	--disable-debug \
	--disable-debug-symbols \
	--disable-rtinst \
	--disable-debugless \
	--disable-valgrind \
	--disable-memcheck \
	--disable-diagtools \
	--disable-usertools \
	--disable-mysql \
	--disable-pgsql \
	--disable-libdbi \
	--disable-snmp \
	--disable-uuid \
	--disable-elasticsearch \
	--disable-elasticsearch-tests \
	--disable-gnutls \
	--disable-libgcrypt \
	--enable-rsyslogrt \
	--enable-rsyslogd \
	--disable-extended-tests \
	--disable-mysql-tests \
	--disable-pgsql-tests \
	--disable-mail \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMDIAG)-imdiag \
	--disable-mmnormalize \
	--$(call ptx/endis, PTXCONF_RSYSLOG_MMJSONPARSE)-mmjsonparse \
	--disable-mmgrok \
	--disable-mmaudit \
	--disable-mmanon \
	--disable-mmrm1stspace \
	--disable-mmutf8fix \
	--disable-mmcount \
	--disable-mmsequence \
	--disable-mmdblookup \
	--disable-mmfields \
	--disable-mmpstrucdata \
	--disable-mmrfc5424addhmac \
	--disable-relp \
	--disable-guardtime \
	--disable-gt-ksi \
	--disable-liblogging-stdlog \
	--disable-rfc3195 \
	--disable-testbench \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMFILE)-imfile \
	--disable-imsolaris \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMPTCP)-imptcp \
	--$(call ptx/endis, PTXCONF_RSYSLOG_IMPSTATS)-impstats \
	--$(call ptx/endis, PTXCONF_RSYSLOG_OMPROG)-omprog \
	--$(call ptx/endis, PTXCONF_RSYSLOG_OMUDPSPOOF)-omudpspoof \
	--$(call ptx/endis, PTXCONF_RSYSLOG_OMSTDOUT)-omstdout \
	--$(call ptx/endis, PTXCONF_RSYSLOG_SYSTEMD)-omjournal \
	--$(call ptx/endis, PTXCONF_RSYSLOG_PMLASTMSG)-pmlastmsg \
	--disable-pmcisconames \
	--$(call ptx/endis, PTXCONF_RSYSLOG_PMCISCOIOS)-pmciscoios \
	--disable-pmnull \
	--disable-pmaixforwardedfrom \
	--disable-pmsnare \
	--disable-pmpanngfw \
	--disable-omruleset \
	--$(call ptx/endis, PTXCONF_RSYSLOG_OMUXSOCK)-omuxsock \
	--disable-mmsnmptrapd \
	--disable-omhdfs \
	--disable-omkafka \
	--disable-kafka-tests \
	--disable-ommongodb \
	--disable-imzmq3 \
	--disable-imczmq \
	--disable-omzmq3 \
	--disable-omczmq \
	--disable-omrabbitmq \
	--disable-omhiredis \
	--disable-omhttpfs \
	--disable-omamqp1 \
	--disable-omtcl \
	--disable-generate-man-pages \
	--disable-distcheck-workaround

ifdef PTXCONF_RSYSLOG_SYSTEMD_UNIT
RSYSLOG_CONF_OPT += --with-systemdsystemunitdir=/usr/lib/systemd/system
else
RSYSLOG_CONF_OPT += --without-systemdsystemunitdir
endif

RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMDIAG)	+= imdiag
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMFILE)	+= imfile
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMKLOG)	+= imklog
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_IMKMSG)	+= imkmsg
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_SYSTEMD)	+= imjournal
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
RSYSLOG_PLUGINS-y				+= lmzlibw
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_MMJSONPARSE)	+= mmjsonparse
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_OMPROG)	+= omprog
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_OMSTDOUT)	+= omstdout
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_SYSTEMD)	+= omjournal
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_OMUDPSPOOF)	+= omudpspoof
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_OMUXSOCK)	+= omuxsock
RSYSLOG_PLUGINS-$(PTXCONF_RSYSLOG_PMCISCOIOS)	+= pmciscoios
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
	@$(call install_alternative, rsyslog, 0, 0, 0644, \
		/usr/lib/systemd/system/rsyslog.service)
	@$(call install_link, rsyslog, ../rsyslog.service, \
		/usr/lib/systemd/system/multi-user.target.wants/rsyslog.service)
	@$(call install_link, rsyslog, rsyslog.service, \
		/usr/lib/systemd/system/syslog.service)
endif

	@for plugin in $(RSYSLOG_PLUGINS-y); do \
		$(call install_copy, rsyslog, 0, 0, 0644, -, \
			/usr/lib/rsyslog/$$plugin.so); \
	done

	@$(call install_finish, rsyslog)

	@$(call touch)

# vim: syntax=make
