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
PACKAGES-$(PTXCONF_TRACE_CMD) += trace-cmd

#
# Paths and names
#
TRACE_CMD_VERSION	:= 1.0.5
TRACE_CMD_MD5		:= 251432a677c4498f2428654d9b6ec7fd
TRACE_CMD		:= trace-cmd-$(TRACE_CMD_VERSION)
TRACE_CMD_SUFFIX	:= tar.bz2
TRACE_CMD_URL		:= $(call ptx/mirror, KERNEL, analysis/trace-cmd/$(TRACE_CMD).$(TRACE_CMD_SUFFIX))
TRACE_CMD_SOURCE	:= $(SRCDIR)/$(TRACE_CMD).$(TRACE_CMD_SUFFIX)
TRACE_CMD_DIR		:= $(BUILDDIR)/$(TRACE_CMD)
TRACE_CMD_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TRACE_CMD_SOURCE):
	@$(call targetinfo)
	@$(call get, TRACE_CMD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TRACE_CMD_CONF_TOOL	:= NO

TRACE_CMD_MAKE_ENV	:= \
	$(CROSS_ENV) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	prefix=/usr

TRACE_CMD_INSTALL_ENV	:= \
	$(TRACE_CMD_MAKE_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/trace-cmd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, trace-cmd)
	@$(call install_fixup, trace-cmd,PRIORITY,optional)
	@$(call install_fixup, trace-cmd,SECTION,base)
	@$(call install_fixup, trace-cmd,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, trace-cmd,DESCRIPTION,missing)

	@$(call install_copy, trace-cmd, 0, 0, 0755, -, /usr/bin/trace-cmd)

	@$(call install_copy, trace-cmd, 0, 0, 0644, -, \
		/usr/share/trace-cmd/plugins/plugin_kmem.so)
	@$(call install_copy, trace-cmd, 0, 0, 0644, -, \
		/usr/share/trace-cmd/plugins/plugin_mac80211.so)
	@$(call install_copy, trace-cmd, 0, 0, 0644, -, \
		/usr/share/trace-cmd/plugins/plugin_hrtimer.so)
	@$(call install_copy, trace-cmd, 0, 0, 0644, -, \
		/usr/share/trace-cmd/plugins/plugin_sched_switch.so)
	@$(call install_copy, trace-cmd, 0, 0, 0644, -, \
		/usr/share/trace-cmd/plugins/plugin_jbd2.so)

	@$(call install_finish, trace-cmd)

	@$(call touch)

# vim: syntax=make
