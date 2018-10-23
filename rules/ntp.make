# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NTP) += ntp

#
# Paths and names
#
NTP_VERSION	:= 4.2.8p12
NTP_MD5		:= 1522d66574bae14abb2622746dad2bdc
NTP		:= ntp-$(NTP_VERSION)
NTP_SUFFIX	:= tar.gz
NTP_URL		:= http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/$(NTP).$(NTP_SUFFIX)
NTP_SOURCE	:= $(SRCDIR)/$(NTP).$(NTP_SUFFIX)
NTP_DIR		:= $(BUILDDIR)/$(NTP)
NTP_LICENSE	:= ntp
NTP_LICENSE_FILES	:= file://COPYRIGHT;md5=e877a1d567a6a58996d2b66e3e387003

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NTP_CONF_ENV	:= \
	$(CROSS_ENV) \
	libopts_cv_test_dev_zero=yes \
	ntp_cv_vsnprintf_percent_m=yes

#
# autoconf
#

# Note: Only if '--disable-all-clocks' is given, the additional clock driver
# switches makes sense (else most of the clock drivers are enabled by default)
NTP_CONF_TOOL	:= autoconf
NTP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-hardenfile=linux \
	--bindir=/usr/sbin \
	--disable-nls \
	--enable-local-libopts \
	--disable-libopts-install \
	--disable-local-libevent \
	--without-lineeditlibs \
	--$(call ptx/endis, PTXCONF_NTP_DEBUGGING)-debugging \
	--enable-thread-support \
	--with-threads=posix \
	--with-yielding-select=yes \
	--disable-c99-snprintf \
	--disable-clockctl \
	--enable-linuxcaps \
	--disable-solarisprivs \
	--disable-trustedbsd-mac \
	--without-arlib \
	--without-net-snmp-config \
	--disable-libseccomp \
	--disable-debug-timing \
	--enable-dst-minutes=60 \
	--disable-ignore-dns-errors \
	--$(call ptx/endis, PTXCONF_NTP_BANCOMM)-BANCOMM \
	--$(call ptx/endis, PTXCONF_NTP_GPSVME)-GPSVME \
	--$(call ptx/endis, PTXCONF_NTP_ALL_CLOCK_DRIVERS)-all-clocks \
	--$(call ptx/endis, PTXCONF_NTP_ACTS)-ACTS \
	--$(call ptx/endis, PTXCONF_NTP_ARBITER)-ARBITER \
	--$(call ptx/endis, PTXCONF_NTP_ARCRON_MSF)-ARCRON-MSF \
	--$(call ptx/endis, PTXCONF_NTP_AS2201)-AS2201 \
	--$(call ptx/endis, PTXCONF_NTP_ATOM)-ATOM \
	--$(call ptx/endis, PTXCONF_NTP_CHRONOLOG)-CHRONOLOG \
	--$(call ptx/endis, PTXCONF_NTP_CHU)-CHU \
	--$(call ptx/endis, PTXCONF_NTP_AUDIO_CHU)-AUDIO-CHU \
	--$(call ptx/endis, PTXCONF_NTP_DATUM)-DATUM \
	--$(call ptx/endis, PTXCONF_NTP_DUMBCLOCK)-DUMBCLOCK \
	--$(call ptx/endis, PTXCONF_NTP_FG)-FG \
	--$(call ptx/endis, PTXCONF_NTP_HEATH)-HEATH \
	--$(call ptx/endis, PTXCONF_NTP_HOPFSERIAL)-HOPFSERIAL \
	--$(call ptx/endis, PTXCONF_NTP_HOPFPCI)-HOPFPCI \
	--$(call ptx/endis, PTXCONF_NTP_HPGPS)-HPGPS \
	--$(call ptx/endis, PTXCONF_NTP_IRIG)-IRIG \
	--$(call ptx/endis, PTXCONF_NTP_JJY)-JJY \
	--$(call ptx/endis, PTXCONF_NTP_JUPITER)-JUPITER \
	--$(call ptx/endis, PTXCONF_NTP_LEITCH)-LEITCH \
	--$(call ptx/endis, PTXCONF_NTP_LOCAL_CLOCK)-LOCAL-CLOCK \
	--$(call ptx/endis, PTXCONF_NTP_MX4200)-MX4200 \
	--$(call ptx/endis, PTXCONF_NTP_NEOCLOCK4X)-NEOCLOCK4X \
	--$(call ptx/endis, PTXCONF_NTP_NMEA)-NMEA \
	--$(call ptx/endis, PTXCONF_NTP_GPSD)-GPSD \
	--$(call ptx/endis, PTXCONF_NTP_ONCORE)-ONCORE \
	--$(call ptx/endis, PTXCONF_NTP_PALISADE)-PALISADE \
	--$(call ptx/endis, PTXCONF_NTP_PCF)-PCF \
	--$(call ptx/endis, PTXCONF_NTP_PST)-PST \
	--$(call ptx/endis, PTXCONF_NTP_RIPENCC)-RIPENCC \
	--$(call ptx/endis, PTXCONF_NTP_SHM)-SHM \
	--$(call ptx/endis, PTXCONF_NTP_SPECTRACOM)-SPECTRACOM \
	--$(call ptx/endis, PTXCONF_NTP_TPRO)-TPRO \
	--$(call ptx/endis, PTXCONF_NTP_TRUETIME)-TRUETIME \
	--$(call ptx/endis, PTXCONF_NTP_TT560)-TT560 \
	--$(call ptx/endis, PTXCONF_NTP_ULINK)-ULINK \
	--$(call ptx/endis, PTXCONF_NTP_TSYNCPCI)-TSYNCPCI \
	--$(call ptx/endis, PTXCONF_NTP_WWV)-WWV \
	--$(call ptx/endis, PTXCONF_NTP_ZYFER)-ZYFER \
	--$(call ptx/endis, PTXCONF_NTP_ALL_CLOCK_DRIVERS)-parse-clocks \
	--$(call ptx/endis, PTXCONF_NTP_COMPUTIME)-COMPUTIME \
	--$(call ptx/endis, PTXCONF_NTP_DCF7000)-DCF7000 \
	--$(call ptx/endis, PTXCONF_NTP_HOPF6021)-HOPF6021 \
	--$(call ptx/endis, PTXCONF_NTP_MEINBERG)-MEINBERG \
	--$(call ptx/endis, PTXCONF_NTP_RAWDCF)-RAWDCF \
	--$(call ptx/endis, PTXCONF_NTP_RCC8000)-RCC8000 \
	--$(call ptx/endis, PTXCONF_NTP_SCHMID)-SCHMID \
	--$(call ptx/endis, PTXCONF_NTP_TRIMTAIP)-TRIMTAIP \
	--$(call ptx/endis, PTXCONF_NTP_TRIMTSIP)-TRIMTSIP \
	--$(call ptx/endis, PTXCONF_NTP_WHARTON)-WHARTON \
	--$(call ptx/endis, PTXCONF_NTP_VARITEXT)-VARITEXT \
	--$(call ptx/endis, PTXCONF_NTP_SEL240X)-SEL240X \
	--$(call ptx/wwo, PTXCONF_NTP_CRYPTO)-crypto \
	--without-rpath \
	--$(call ptx/endis, PTXCONF_NTP_CRYPTO)-openssl-random \
	--$(call ptx/endis, PTXCONF_NTP_CRYPTO)-autokey \
	--disable-kmem \
	--enable-accurate-adjtime \
	--disable-simulator \
	--without-sntp \
	--without-ntpsnmpd \
	--$(call ptx/endis, PTXCONF_NTP_SLEW_ALWAYS)-slew-always \
	--$(call ptx/endis, PTXCONF_NTP_STEP_SLEW)-step-slew \
	--$(call ptx/endis, PTXCONF_NTP_NTPDATE_STEP)-ntpdate-step \
	--$(call ptx/endis, PTXCONF_NTP_HOURLY_TODR_SYNC)-hourly-todr-sync \
	--disable-kernel-fll-bug \
	--enable-bug1243-fix \
	--enable-bug3020-fix \
	--$(call ptx/endis, PTXCONF_NTP_IRIG_SAWTOOTH)-irig-sawtooth \
	--$(call ptx/endis, PTXCONF_NTP_NIST)-nist \
	--disable-ntp-signd \
	$(GLOBAL_IPV6_OPTION) \
	--without-kame \
	--enable-getifaddrs \
	--disable-saveconfig \
	--disable-leap-smear \
	--disable-dynamic-interleave \
	--without-gtest \
	--disable-problem-tests

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ntp.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  ntp)
	@$(call install_fixup, ntp,PRIORITY,optional)
	@$(call install_fixup, ntp,SECTION,base)
	@$(call install_fixup, ntp,AUTHOR,"Robert Schwebel")
	@$(call install_fixup, ntp,DESCRIPTION,missing)

#	#
#	# ntpdate
#	#
ifdef PTXCONF_NTP_NTPDATE
	@$(call install_copy, ntp, 0, 0, 0755, -, \
		/usr/sbin/ntpdate)
endif

#	#
#	# ntp server
#	#
ifdef PTXCONF_NTP_NTPD
	@$(call install_copy, ntp, 0, 0, 0755, -, \
		/usr/sbin/ntpd)
	@$(call install_alternative, ntp, 0, 0, 0644, /etc/ntp-server.conf)
endif

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_NTP_NTPD_STARTSCRIPT
	@$(call install_alternative, ntp, 0, 0, 0755, /etc/init.d/ntp-server)

ifneq ($(call remove_quotes,$(PTXCONF_NTP_NTPD_BBINIT_LINK)),)
	@$(call install_link, ntp, \
		../init.d/ntp-server, \
		/etc/rc.d/$(PTXCONF_NTP_NTPD_BBINIT_LINK))
endif
endif
endif
ifdef PTXCONF_NTP_NTPD_SYSTEMD_UNIT
	@$(call install_alternative, ntp, 0, 0, 0644, \
		/usr/lib/systemd/system/ntpd.service)
	@$(call install_link, ntp, ../ntpd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/ntpd.service)
endif

#	#
#	# ntpdc
#	#
ifdef PTXCONF_NTP_NTPDC
	@$(call install_copy, ntp, 0, 0, 0755, -, \
		/usr/sbin/ntpdc)
	@$(call install_alternative, ntp, 0, 0, 0644, /etc/ntp-client.conf)
endif

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_NTP_NTPC_STARTSCRIPT
	@$(call install_alternative, ntp, 0, 0, 0755, /etc/init.d/ntp-client)

ifneq ($(call remove_quotes,$(PTXCONF_NTP_NTPC_BBINIT_LINK)),)
	@$(call install_link, ntp, \
		../init.d/ntp-client, \
		/etc/rc.d/$(PTXCONF_NTP_NTPC_BBINIT_LINK))
endif
endif
endif

#	#
#	# ntpq
#	#
ifdef PTXCONF_NTP_NTPQ
	@$(call install_copy, ntp, 0, 0, 0755, -, \
		/usr/sbin/ntpq)
endif

#	#
#	# ntptime
#	#
ifdef PTXCONF_NTP_NTPTIME
	@$(call install_copy, ntp, 0, 0, 0755, -, \
		/usr/sbin/ntptime)
endif

#	#
#	# other dirs
#	#
	@$(call install_copy, ntp, 0, 0, 0755, /var/log/ntpstats)
	@$(call install_copy, ntp, 0, 0, 0755, /var/lib/ntp)

	@$(call install_finish, ntp)

	@$(call touch)

# vim: syntax=make
