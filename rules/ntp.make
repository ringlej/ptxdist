# -*-makefile-*-
# $Id: ntp.make,v 1.4 2004/06/23 15:33:28 rsc Exp $
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_NTP
PACKAGES += ntp
endif

#
# Paths and names
#
NTP_VERSION	= 4.2.0
NTP		= ntp-$(NTP_VERSION)
NTP_SUFFIX		= tar.gz
NTP_URL		= http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4//$(NTP).$(NTP_SUFFIX)
NTP_SOURCE		= $(SRCDIR)/$(NTP).$(NTP_SUFFIX)
NTP_DIR		= $(BUILDDIR)/$(NTP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ntp_get: $(STATEDIR)/ntp.get

ntp_get_deps = $(NTP_SOURCE)

$(STATEDIR)/ntp.get: $(ntp_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(NTP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NTP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ntp_extract: $(STATEDIR)/ntp.extract

ntp_extract_deps = $(STATEDIR)/ntp.get

$(STATEDIR)/ntp.extract: $(ntp_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NTP_DIR))
	@$(call extract, $(NTP_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ntp_prepare: $(STATEDIR)/ntp.prepare

#
# dependencies
#
ntp_prepare_deps = \
	$(STATEDIR)/ntp.extract \
	$(STATEDIR)/virtual-xchain.install

NTP_PATH	=  PATH=$(CROSS_PATH)
NTP_ENV 	=  $(CROSS_ENV)
#NTP_ENV	+=

#
# autoconf
#
NTP_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)
	
# NTP: options, we need lots of options ;-)

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
ifdef PTXCONF_NTP_ALL_CLOCKS
NTP_AUTOCONF += --enable-all-clocks
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
ifdef PTXCONF_NTP_PARSE_CLOCKS
NTP_AUTOCONF += --enable-parse-clocks
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
NTP_AUTOCONF += --enable-crypto
NTP_AUTOCONF += --with-openssl-libdir=$(OPENSSL_DIR)
NTP_AUTOCONF += --with-openssl-incdir=$(OPENSSL_DIR)
else
NTP_AUTOCONF += --disable-crypto
endif
ifdef PTXCONF_NTP_SNTP
NTP_AUTOCONF += --enable-sntp
endif
ifdef PTXCONF_NTP_ARLIB
NTP_AUTOCONF += --enable-arlib
endif

#

$(STATEDIR)/ntp.prepare: $(ntp_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NTP_DIR)/config.cache)
	cd $(NTP_DIR) && \
		$(NTP_PATH) $(NTP_ENV) \
		./configure $(NTP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ntp_compile: $(STATEDIR)/ntp.compile

ntp_compile_deps = $(STATEDIR)/ntp.prepare

$(STATEDIR)/ntp.compile: $(ntp_compile_deps)
	@$(call targetinfo, $@)
	
	# ntp-4.2.0 tries to build ntpdc/ntpdc-layout for the target but
	# trys to run it on the build machine - this is wrong... 
	perl -i -p -e "s/^CC =/CC ?=/g" $(NTP_DIR)/ntpdc/Makefile
	cd $(NTP_DIR)/ntpdc && CC=$(HOSTCC) make ntpdc-layout 

	# now build the rest
	cd $(NTP_DIR) && $(NTP_ENV) $(NTP_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ntp_install: $(STATEDIR)/ntp.install

$(STATEDIR)/ntp.install: $(STATEDIR)/ntp.compile
	@$(call targetinfo, $@)
	cd $(NTP_DIR) && $(NTP_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ntp_targetinstall: $(STATEDIR)/ntp.targetinstall

ntp_targetinstall_deps = $(STATEDIR)/ntp.compile

$(STATEDIR)/ntp.targetinstall: $(ntp_targetinstall_deps)
	@$(call targetinfo, $@)
ifdef PTXCONF_NTP_NTPDATE
	cp $(NTP_DIR)/ntpdate/ntpdate $(ROOTDIR)/usr/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/ntpdate
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ntp_clean:
	rm -rf $(STATEDIR)/ntp.*
	rm -rf $(NTP_DIR)

# vim: syntax=make
