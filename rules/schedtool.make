# -*-makefile-*-
#
# Copyright (C) 2012 by Martin Wagner <martin.wagner@neuberger.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SCHEDTOOL) += schedtool

#
# Paths and names
#
SCHEDTOOL_VERSION	:= 1.3.0
SCHEDTOOL_MD5		:= 0d968f05d3ad7675f1f33ef1f6d0a3fb
SCHEDTOOL		:= schedtool-$(SCHEDTOOL_VERSION)
SCHEDTOOL_SUFFIX	:= tar.bz2
SCHEDTOOL_URL		:= http://freequaos.host.sk/schedtool/$(SCHEDTOOL).$(SCHEDTOOL_SUFFIX)
SCHEDTOOL_SOURCE	:= $(SRCDIR)/$(SCHEDTOOL).$(SCHEDTOOL_SUFFIX)
SCHEDTOOL_DIR		:= $(BUILDDIR)/$(SCHEDTOOL)
SCHEDTOOL_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SCHEDTOOL_CONF_TOOL	:= NO
SCHEDTOOL_MAKE_ENV	:= $(CROSS_ENV) CPPFLAGS="$(CROSS_CFLAGS) $(CROSS_CPPFLAGS)"
SCHEDTOOL_MAKE_OPT	:= CC=$(CROSS_CC)
SCHEDTOOL_INSTALL_OPT	:= DESTPREFIX=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/schedtool.targetinstall:
	@$(call targetinfo)

	@$(call install_init, schedtool)
	@$(call install_fixup, schedtool,PRIORITY,optional)
	@$(call install_fixup, schedtool,SECTION,base)
	@$(call install_fixup, schedtool,AUTHOR,"Martin Wagner <martin.wagner@neuberger.net>")
	@$(call install_fixup, schedtool,DESCRIPTION,missing)

	@$(call install_copy, schedtool, 0, 0, 0755, -, /usr/bin/schedtool)

	@$(call install_finish, schedtool)

	@$(call touch)

# vim: syntax=make
