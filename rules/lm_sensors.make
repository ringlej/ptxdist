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
LM_SENSORS_VERSION	:= 3.5.0
LM_SENSORS_TAG		:= V3-5-0
LM_SENSORS_MD5		:= 37981f5d3a0f649381529cb41c0f1ff3
LM_SENSORS		:= lm_sensors-$(LM_SENSORS_VERSION)
LM_SENSORS_SUFFIX	:= tar.gz
LM_SENSORS_URL		:= \
	https://github.com/lm-sensors/lm-sensors/archive/$(LM_SENSORS_TAG).$(LM_SENSORS_SUFFIX)
LM_SENSORS_SOURCE	:= $(SRCDIR)/$(LM_SENSORS).$(LM_SENSORS_SUFFIX)
LM_SENSORS_DIR		:= $(BUILDDIR)/$(LM_SENSORS)
LM_SENSORS_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LM_SENSORS_CONF_TOOL	:= NO
LM_SENSORS_MAKE_OPT	:= \
	PREFIX=/usr \
	LIBICONV="" \
	MACHINE=$(PTXCONF_ARCH_STRING) \
	$(CROSS_ENV_CC)

LM_SENSORS_INSTALL_OPT	:= \
	$(LM_SENSORS_MAKE_OPT) \
	install

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

	@$(call install_alternative, lm_sensors, 0, 0, 0644, /etc/sensors3.conf)

ifdef PTXCONF_LM_SENSORS_FANCONTROL
	@$(call install_copy, lm_sensors, 0, 0, 0755, -, /usr/sbin/fancontrol)
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
