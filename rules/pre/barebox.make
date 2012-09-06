# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2008, 2009, 2012 by Marc Kleine-Budde
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

barebox/opts = \
	$(PARALLELMFLAGS) \
	V=$(PTXDIST_VERBOSE) \
	HOSTCC=$(HOSTCC) \
	ARCH=$(PTXCONF_BAREBOX_ARCH_STRING) \
	CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE)

barebox-opts = \
	$(call barebox/opts,$(strip $(1)))

barebox/url = \
	http://www.barebox.org/download/$($(1)).$($(1)_SUFFIX)

barebox-url = \
	$(call barebox/url,$(strip $(1)))

# vim: syntax=make
