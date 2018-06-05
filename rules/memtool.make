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
MEMTOOL_VERSION	:= 2018.03.0
MEMTOOL_MD5	:= b3b16018cda270fa1d375ea09b67d6ae
MEMTOOL		:= memtool-$(MEMTOOL_VERSION)
MEMTOOL_SUFFIX	:= tar.xz
MEMTOOL_URL	:= http://www.pengutronix.de/software/memtool/downloads/$(MEMTOOL).$(MEMTOOL_SUFFIX)
MEMTOOL_SOURCE	:= $(SRCDIR)/$(MEMTOOL).$(MEMTOOL_SUFFIX)
MEMTOOL_DIR	:= $(BUILDDIR)/$(MEMTOOL)
MEMTOOL_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MEMTOOL_CONF_TOOL := autoconf
MEMTOOL_CONF_OPT := \
       $(CROSS_AUTOCONF_USR) \
       $(GLOBAL_LARGE_FILE_OPTION) \
       --enable-mdio \

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
	@$(call install_copy, memtool, 0, 0, 0755, -, /usr/bin/memtool)

	@$(call install_finish, memtool)

	@$(call touch)

# vim: syntax=make
