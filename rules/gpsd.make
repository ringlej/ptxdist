# -*-makefile-*-
#
# Copyright (C) 2008 by J.Kilb
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GPSD) += gpsd

#
# Paths and names
#
GPSD_VERSION	:= 2.39
GPSD_MD5	:= 3db437196a6840c252fca99b6c19d4d0
GPSD		:= gpsd-$(GPSD_VERSION)
GPSD_SUFFIX	:= tar.gz
GPSD_URL	:= http://download.berlios.de/gpsd/$(GPSD).$(GPSD_SUFFIX)
GPSD_SOURCE	:= $(SRCDIR)/$(GPSD).$(GPSD_SUFFIX)
GPSD_DIR	:= $(BUILDDIR)/$(GPSD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GPSD_PATH	:= PATH=$(CROSS_PATH)
GPSD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GPSD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-x \
	--$(call ptx/endis, PTXCONF_GPSD_PYTHON)-python \
	--$(call ptx/endis, PTXCONF_GPSD_PROFILING)-profiling \
	--$(call ptx/endis, PTXCONF_GPSD_NTPSHM)-ntpshm \
	--$(call ptx/endis, PTXCONF_GPSD_PPS)-pps \
	--$(call ptx/endis, PTXCONF_GPSD_PPS_ON_CTS)-pps-on-cts \
	--$(call ptx/endis, PTXCONF_GPSD_DBUS)-dbus \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_NMEA)-nmea \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_SIRF)-sirf \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_TSIP)-tsip \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_FV18)-fv18 \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_TRIPMATE)-tripmate \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_EARTHMATE)-earthmate \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_ITRAX)-itrax \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_ASHTECH)-ashtech \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_NAVCOM)-navcom \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_GARMIN)-garmin \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_GARMINTXT)-garmintxt \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_TNT)-tnt \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_UBX)-ubx \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_EVERMORE)-evermore \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_GPSCLOCK)-gpsclock \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_RTCM104V2)-rtcm104v2 \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_RTCM104V3)-rtcm104v3 \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_NTRIP)-ntrip \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_SUPERSTAR2)-superstar2 \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_OCEANSERVER)-oceanserver \
	--$(call ptx/endis, PTXCONF_GPSD_DRIVER_MKT3301)-mkt3301

ifneq ($(call remove_quotes,$(PTXCONF_GPSD_USER)),)
GPSD_AUTOCONF += --enable-gpsd-user=$(PTXCONF_GPSD_USER)
endif
ifneq ($(call remove_quotes,$(PTXCONF_GPSD_FIXED_PORT_SPEED)),)
GPSD_AUTOCONF += --enable-fixed-port-speed=$(PTXCONF_GPSD_FIXED_PORT_SPEED)
endif

ifneq ($(call remove_quotes,$(PTXCONF_GPSD_MAX_CLIENTS)),)
GPSD_AUTOCONF += --enable-max-clients=$(PTXCONF_GPSD_MAX_CLIENTS)
endif
ifneq ($(call remove_quotes,$(PTXCONF_GPSD_MAX_DEVICES)),)
GPSD_AUTOCONF += --enable-max-devices=$(PTXCONF_GPSD_MAX_DEVICES)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gpsd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gpsd)
	@$(call install_fixup, gpsd,PRIORITY,optional)
	@$(call install_fixup, gpsd,SECTION,base)
	@$(call install_fixup, gpsd,AUTHOR,"Jürgen Kilb <j.kilb@phytec.de>")
	@$(call install_fixup, gpsd,DESCRIPTION,missing)

	@$(call install_lib, gpsd, 0, 0, 0644, libgps)

ifdef PTXCONF_GPSD_GPSD
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/sbin/gpsd)
endif
ifdef PTXCONF_GPSD_GPSCTL
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpsctl)
endif
ifdef PTXCONF_GPSD_GPSPIPE
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpspipe)
endif
ifdef PTXCONF_GPSD_GPSFLASH
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpsflash)
endif
ifdef PTXCONF_GPSD_GPXLOGGER
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpxlogger)
endif
ifdef PTXCONF_GPSD_CGPS
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/cgps)
endif
ifdef PTXCONF_GPSD_GPSMON
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpsmon)
endif
ifdef PTXCONF_GPSD_GPSDECODE
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpsdecode)
endif

ifdef PTXCONF_GPSD_GPSCAT
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpscat)
endif
ifdef PTXCONF_GPSD_GPSFAKE
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpsfake)
endif
ifdef PTXCONF_GPSD_GPSPROF
	@$(call install_copy, gpsd, 0, 0, 0755, -, /usr/bin/gpsprof)
endif

ifdef PTXCONF_GPSD_PYTHON
	@cd $(GPSD_PKGDIR) && \
		find ./usr/lib/python$(PYTHON_MAJORMINOR) \
		-name "*.so" -o -name "*.pyc" | \
		while read file; do \
		$(call install_copy, gpsd, 0, 0, 644, -, $${file##.}); \
	done
endif

	@$(call install_finish, gpsd)

	@$(call touch)

# vim: syntax=make
