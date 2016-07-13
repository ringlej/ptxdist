# -*-makefile-*-
#
# Copyright (C) 2015 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMTOOL) += memtool

#
# Paths and names
#
MEMTOOL_VERSION	:= 2015.12.2
MEMTOOL_MD5	:= 851ebeb521fe68c27b5d75221fab5333
MEMTOOL		:= memtool-$(MEMTOOL_VERSION)
MEMTOOL_SUFFIX	:= tar.xz
MEMTOOL_URL	:= http://www.pengutronix.de/software/memtool/downloads/$(MEMTOOL).$(MEMTOOL_SUFFIX)
MEMTOOL_SOURCE	:= $(SRCDIR)/$(MEMTOOL).$(MEMTOOL_SUFFIX)
MEMTOOL_DIR	:= $(BUILDDIR)/$(MEMTOOL)
MEMTOOL_LICENSE	:= GPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MEMTOOL_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memtool.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memtool)
	@$(call install_fixup, memtool,PRIORITY,optional)
	@$(call install_fixup, memtool,SECTION,base)
	@$(call install_fixup, memtool,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, memtool,DESCRIPTION,missing)
	@$(call install_copy, memtool, 0, 0, 0755, -, /usr/sbin/memtool)

	@$(call install_finish, memtool)

	@$(call touch)

# vim: syntax=make
