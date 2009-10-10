# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Uwe Kleine-König
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
LM_SENSORS_VERSION	:= 3.1.1
LM_SENSORS		:= lm_sensors-$(LM_SENSORS_VERSION)
LM_SENSORS_SUFFIX	:= tar.bz2
LM_SENSORS_URL		:= http://dl.lm-sensors.org/lm-sensors/releases/$(LM_SENSORS).$(LM_SENSORS_SUFFIX)
LM_SENSORS_SOURCE	:= $(SRCDIR)/$(LM_SENSORS).$(LM_SENSORS_SUFFIX)
LM_SENSORS_DIR		:= $(BUILDDIR)/$(LM_SENSORS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LM_SENSORS_SOURCE):
	@$(call targetinfo)
	@$(call get, LM_SENSORS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/lm_sensors.extract:
	@$(call targetinfo)
	@$(call clean, $(LM_SENSORS_DIR))
	@$(call extract, LM_SENSORS)
	@$(call patchin, LM_SENSORS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LM_SENSORS_PATH	:= PATH=$(CROSS_PATH)
LM_SENSORS_ENV 	:= $(CROSS_ENV)

LM_SENSORS_MAKEVARS := \
	PREFIX=/usr \
	LIBICONV="" \
	$(CROSS_ENV_CC)

$(STATEDIR)/lm_sensors.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/lm_sensors.compile:
	@$(call targetinfo)
	cd $(LM_SENSORS_DIR) && $(LM_SENSORS_PATH) $(MAKE) $(PARALLELMFLAGS) $(LM_SENSORS_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lm_sensors.install:
	@$(call targetinfo)
	@$(call install, LM_SENSORS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lm_sensors.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  lm_sensors)
	@$(call install_fixup, lm_sensors,PACKAGE,lm-sensors)
	@$(call install_fixup, lm_sensors,PRIORITY,optional)
	@$(call install_fixup, lm_sensors,VERSION,$(LM_SENSORS_VERSION))
	@$(call install_fixup, lm_sensors,SECTION,base)
	@$(call install_fixup, lm_sensors,AUTHOR,"Uwe Kleine-König <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, lm_sensors,DEPENDS,)
	@$(call install_fixup, lm_sensors,DESCRIPTION,missing)

	@$(call install_copy, lm_sensors, 0, 0, 0755, $(LM_SENSORS_DIR)/prog/sensors/sensors, /usr/bin/sensors)
	@$(call install_copy, lm_sensors, 0, 0, 0644, $(LM_SENSORS_DIR)/etc/sensors.conf.default, /etc/sensors3.conf)
	@$(call install_copy, lm_sensors, 0, 0, 0755, $(LM_SENSORS_DIR)/lib/libsensors.so.4.2.0, /usr/lib/libsensors.so.4.2.0)
	@$(call install_link, lm_sensors, libsensors.so.4.2.0, /usr/lib/libsensors.so.4)
	@$(call install_link, lm_sensors, libsensors.so.4.2.0, /usr/lib/libsensors.so)

	@$(call install_finish, lm_sensors)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lm_sensors_clean:
	rm -rf $(STATEDIR)/lm_sensors.*
	rm -rf $(PKGDIR)/lm_sensors_*
	rm -rf $(LM_SENSORS_DIR)

# vim: syntax=make
