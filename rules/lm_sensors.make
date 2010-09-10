# -*-makefile-*-
#
# Copyright (C) 2009 by Uwe Kleine-König
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LM_SENSORS) += lm_sensors

#
# Paths and names
#
LM_SENSORS_VERSION	:= 3.1.2
LM_SENSORS		:= lm_sensors-$(LM_SENSORS_VERSION)
LM_SENSORS_SUFFIX	:= tar.bz2
LM_SENSORS_URL		:= http://dl.lm-sensors.org/lm-sensors/releases/$(LM_SENSORS).$(LM_SENSORS_SUFFIX)
LM_SENSORS_SOURCE	:= $(SRCDIR)/$(LM_SENSORS).$(LM_SENSORS_SUFFIX)
LM_SENSORS_DIR		:= $(BUILDDIR)/$(LM_SENSORS)
LM_SENSORS_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LM_SENSORS_SOURCE):
	@$(call targetinfo)
	@$(call get, LM_SENSORS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LM_SENSORS_PATH	:= PATH=$(CROSS_PATH)
LM_SENSORS_ENV 	:= $(CROSS_ENV)

LM_SENSORS_MAKEVARS := \
	PREFIX=/usr \
	LIBICONV="" \
	MACHINE=$(PTXCONF_ARCH_STRING) \
	$(CROSS_ENV_CC)

$(STATEDIR)/lm_sensors.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lm_sensors.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lm_sensors)
	@$(call install_fixup, lm_sensors,PRIORITY,optional)
	@$(call install_fixup, lm_sensors,SECTION,base)
	@$(call install_fixup, lm_sensors,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, lm_sensors,DESCRIPTION,missing)

	@$(call install_lib, lm_sensors, 0, 0, 0644, libsensors)

	@$(call install_copy, lm_sensors, 0, 0, 0755, -, /usr/bin/sensors)
	@$(call install_copy, lm_sensors, 0, 0, 0755, -, /usr/bin/sensors-conf-convert)

	@$(call install_copy, lm_sensors, 0, 0, 0644, -, /etc/sensors3.conf)

ifdef PTXCONF_LM_SENSORS_FANCONTROL
	@$(call install_copy, lm_sensors, 0, 0, 0755, -, /usr/sbin/fancontrol)
endif
ifdef PTXCONF_LM_SENSORS_SENSORS_DETECT
	@$(call install_copy, lm_sensors, 0, 0, 0755, -, /usr/sbin/sensors-detect)
endif
ifdef PTXCONF_LM_SENSORS_PWMCONFIG
	@$(call install_copy, lm_sensors, 0, 0, 0755, -, /usr/sbin/pwmconfig)
endif

ifdef PTXCONF_ARCH_X86
ifdef PTXCONF_LM_SENSORS_ISASET
	@$(call install_copy, lm_sensors, 0, 0, 0755, -, /usr/sbin/isaset)
endif
ifdef PTXCONF_LM_SENSORS_ISADUMP
	@$(call install_copy, lm_sensors, 0, 0, 0755, -, /usr/sbin/isadump)
endif
endif
	@$(call install_finish, lm_sensors)

	@$(call touch)

# vim: syntax=make
