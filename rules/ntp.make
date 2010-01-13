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
NTP_VERSION	:= 4.2.6
NTP		:= ntp-$(NTP_VERSION)
NTP_SUFFIX	:= tar.gz
NTP_URL		:= http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/$(NTP).$(NTP_SUFFIX)
NTP_SOURCE	:= $(SRCDIR)/$(NTP).$(NTP_SUFFIX)
NTP_DIR		:= $(BUILDDIR)/$(NTP)
NTP_LICENSE	:= ntp

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NTP_SOURCE):
	@$(call targetinfo)
	@$(call get, NTP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NTP_PATH	:= PATH=$(CROSS_PATH)
NTP_ENV 	:= \
	$(CROSS_ENV) \
	libopts_cv_test_dev_zero=yes

#
# autoconf
#
NTP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--with-binsubdir=sbin \
	--without-lineeditlibs \
	--without-net-snmp-config

ifdef PTXCONF_NTP_ALL_CLOCK_DRIVERS
NTP_AUTOCONF += --enable-all-clocks
else
NTP_AUTOCONF += --disable-all-clocks
endif

#
# NTP: options, we need lots of options ;-)
# Note: Only if '--disable-all-clocks' is given, the additional clock driver
# switches makes sense (else most of the clock drivers are enabled
# by default)
#
ifdef PTXCONF_NTP_CLOCKCTL
NTP_AUTOCONF += --enable-clockctl
endif
ifdef PTXCONF_NTP_DEBUGGING
NTP_AUTOCONF += --enable-debugging
endif
ifdef PTXCONF_NTP_DST_MINUTES
NTP_AUTOCONF += --enable-dst-minutes=$(PTXCONF_NTP_DST_MINUTES)
endif
ifdef PTXCONF_NTP_BANCOMM
NTP_AUTOCONF += --enable-BANCOMM
endif
ifdef PTXCONF_NTP_GPSVME
NTP_AUTOCONF += --enable-GPSVME
endif
ifdef PTXCONF_NTP_ACTS
NTP_AUTOCONF += --enable-ACTS
endif
ifdef PTXCONF_NTP_ARBITER
NTP_AUTOCONF += --enable-ARBITER
endif
ifdef PTXCONF_NTP_ARCRON_MSF
NTP_AUTOCONF += --enable-ARCRON_MSF
endif
ifdef PTXCONF_NTP_AS2201
NTP_AUTOCONF += --enable-AS2201
endif
ifdef PTXCONF_NTP_ATOM
NTP_AUTOCONF += --enable-ATOM
endif
ifdef PTXCONF_NTP_CHRONOLOG
NTP_AUTOCONF += --enable-CHRONOLOG
endif
ifdef PTXCONF_NTP_CHU
NTP_AUTOCONF += --enable-CHU
endif
ifdef PTXCONF_NTP_AUDIO_CHU
NTP_AUTOCONF += --enable-AUDIO-CHU
endif
ifdef PTXCONF_NTP_DATUM
NTP_AUTOCONF += --enable-DATUM
endif
ifdef PTXCONF_NTP_DUMBCLOCK
NTP_AUTOCONF += --enable-DUMBCLOCK
endif
ifdef PTXCONF_NTP_FG
NTP_AUTOCONF += --enable-FG
endif
ifdef PTXCONF_NTP_HEATH
NTP_AUTOCONF += --enable-HEATH
endif
ifdef PTXCONF_NTP_HOPFSERIAL
NTP_AUTOCONF += --enable-HOPFSERIAL
endif
ifdef PTXCONF_NTP_HOPFPCI
NTP_AUTOCONF += --enable-HOPFPCI
endif
ifdef PTXCONF_NTP_HPGPS
NTP_AUTOCONF += --enable-HPGPS
endif
ifdef PTXCONF_NTP_IRIG
NTP_AUTOCONF += --enable-IRIG
endif
ifdef PTXCONF_NTP_JJY
NTP_AUTOCONF += --enable-JJY
endif
ifdef PTXCONF_NTP_JUPITER
NTP_AUTOCONF += --enable-JUPITER
endif
ifdef PTXCONF_NTP_LEITCH
NTP_AUTOCONF += --enable-LEITCH
endif
ifdef PTXCONF_NTP_LOCAL_CLOCK
NTP_AUTOCONF += --enable-LOCAL-CLOCK
endif
ifdef PTXCONF_NTP_MSFEES
NTP_AUTOCONF += --enable-MSFEES
endif
ifdef PTXCONF_NTP_MX4200
NTP_AUTOCONF += --enable-MX4200
endif
ifdef PTXCONF_NTP_NEOCLOCK4X
NTP_AUTOCONF += --enable-NEOCLOCK4X
endif
ifdef PTXCONF_NTP_NMEA
NTP_AUTOCONF += --enable-NMEA
endif
ifdef PTXCONF_NTP_ONCORE
NTP_AUTOCONF += --enable-ONCORE
endif
ifdef PTXCONF_NTP_PALISADE
NTP_AUTOCONF += --enable-PALISADE
endif
ifdef PTXCONF_NTP_PCF
NTP_AUTOCONF += --enable-PCF
endif
ifdef PTXCONF_NTP_PST
NTP_AUTOCONF += --enable-PST
endif
ifdef PTXCONF_NTP_PTBACTS
NTP_AUTOCONF += --enable-PTBACTS
endif
ifdef PTXCONF_NTP_RIPENCC
NTP_AUTOCONF += --enable-RIPENCC
endif
ifdef PTXCONF_NTP_SHM
NTP_AUTOCONF += --enable-SHM
endif
ifdef PTXCONF_NTP_SPECTRACOM
NTP_AUTOCONF += --enable-SPECTRACOM
endif
ifdef PTXCONF_NTP_TPRO
NTP_AUTOCONF += --enable-TPRO
endif
ifdef PTXCONF_NTP_TRAK
NTP_AUTOCONF += --enable-TRAK
endif
ifdef PTXCONF_NTP_TRUETIME
NTP_AUTOCONF += --enable-TRUETIME
endif
ifdef PTXCONF_NTP_TT560
NTP_AUTOCONF += --enable-TT560
endif
ifdef PTXCONF_NTP_ULINK
NTP_AUTOCONF += --enable-ULINK
endif
ifdef PTXCONF_NTP_USNO
NTP_AUTOCONF += --enable-USNO
endif
ifdef PTXCONF_NTP_WWV
NTP_AUTOCONF += --enable-WWV
endif
ifdef PTXCONF_NTP_ZYFER
NTP_AUTOCONF += --enable-ZYFER
endif
ifdef PTXCONF_NTP_COMPUTIME
NTP_AUTOCONF += --enable-COMPUTIME
endif
ifdef PTXCONF_NTP_DCF7000
NTP_AUTOCONF += --enable-DCF7000
endif
ifdef PTXCONF_NTP_HOPF6021
NTP_AUTOCONF += --enable-HOPF6021
endif
ifdef PTXCONF_NTP_MEINBERG
NTP_AUTOCONF += --enable-MEINBERG
endif
ifdef PTXCONF_NTP_RAWDCF
NTP_AUTOCONF += --enable-RAWDCF
endif
ifdef PTXCONF_NTP_RCC8000
NTP_AUTOCONF += --enable-RCC8000
endif
ifdef PTXCONF_NTP_SCHMID
NTP_AUTOCONF += --enable-SCHMID
endif
ifdef PTXCONF_NTP_TRIMTAIP
NTP_AUTOCONF += --enable-TRIMTAIP
endif
ifdef PTXCONF_NTP_TRIMTSIP
NTP_AUTOCONF += --enable-TRIMTSIP
endif
ifdef PTXCONF_NTP_WHARTON
NTP_AUTOCONF += --enable-WHARTON
endif
ifdef PTXCONF_NTP_VARITEXT
NTP_AUTOCONF += --enable-VARITEXT
endif
ifdef PTXCONF_NTP_KMEM
NTP_AUTOCONF += --enable-kmem
endif
ifdef PTXCONF_NTP_ACCURATE_ADJTIME
NTP_AUTOCONF += --enable-accurate-adjtime
endif
ifdef PTXCONF_NTP_TICK_FORCE
NTP_AUTOCONF += --enable-tick=$(PTXCONF_NTP_TICK)
endif
ifdef PTXCONF_NTP_TICKADJ_FORCE
NTP_AUTOCONF += --enable-tickadj=$(PTXCONF_NTP_TICKADJ)
endif
ifdef PTXCONF_NTP_SIMULATOR
NTP_AUTOCONF += --enable-simulator
endif
ifdef PTXCONF_NTP_UDP_WILDCARD
NTP_AUTOCONF += --enable-udp-wildcard
endif
ifdef PTXCONF_NTP_SLEW_ALWAYS
NTP_AUTOCONF += --enable-slew-always
endif
ifdef PTXCONF_NTP_STEP_SLEW
NTP_AUTOCONF += --enable-step-slew
endif
ifdef PTXCONF_NTP_NTPDATE_STEP
NTP_AUTOCONF += --enable-ntpdate-step
endif
ifdef PTXCONF_NTP_HOURLY_TODR_SYNC
NTP_AUTOCONF += --enable-hourly-todr-sync
endif
ifdef PTXCONF_NTP_KERNEL_FLL_BUG
NTP_AUTOCONF += --enable-kernel-fll-bug
endif
ifdef PTXCONF_NTP_IRIG_SAWTOOTH
NTP_AUTOCONF += --enable-irig-sawtooth
endif
ifdef PTXCONF_NTP_NIST
NTP_AUTOCONF += --enable-nist
endif
ifdef PTXCONF_NTP_CRYPTO
NTP_AUTOCONF += \
	--enable-crypto \
	--with-openssl-libdir=$(PTXDIST_SYSROOT_TARGET)/usr/lib \
	--with-openssl-incdir=$(PTXDIST_SYSROOT_TARGET)/usr/include
else
NTP_AUTOCONF += --disable-crypto \
	--without-openssl-libdir \
	--without-openssl-incdir
endif
ifdef PTXCONF_NTP_SNTP
NTP_AUTOCONF += --enable-sntp
endif
ifdef PTXCONF_NTP_ARLIB
NTP_AUTOCONF += --enable-arlib
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ntp.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  ntp)
	@$(call install_fixup, ntp,PACKAGE,ntp)
	@$(call install_fixup, ntp,PRIORITY,optional)
	@$(call install_fixup, ntp,VERSION,$(NTP_VERSION))
	@$(call install_fixup, ntp,SECTION,base)
	@$(call install_fixup, ntp,AUTHOR,"Robert Schwebel")
	@$(call install_fixup, ntp,DEPENDS,)
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
endif
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
endif
endif

#	#
#	# ntpq
#	#
ifdef PTXCONF_NTP_NTPQ
	@$(call install_copy, ntp, 0, 0, 0755, -, \
		/usr/bin/ntpq)
endif

#	#
#	# other dirs
#	#
	@$(call install_copy, ntp, 0, 0, 0755, /var/log/ntpstats)
	@$(call install_copy, ntp, 0, 0, 0755, /var/lib/ntp)

	@$(call install_finish, ntp)

	@$(call touch)

# vim: syntax=make
