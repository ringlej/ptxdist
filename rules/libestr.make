# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBESTR) += libestr

#
# Paths and names
#
LIBESTR_VERSION	:= 0.1.10
LIBESTR_MD5	:= f4c9165a23587e77f7efe65d676d5e8e
LIBESTR		:= libestr-$(LIBESTR_VERSION)
LIBESTR_SUFFIX	:= tar.gz
LIBESTR_URL	:= http://libestr.adiscon.com/files/download/$(LIBESTR).$(LIBESTR_SUFFIX)
LIBESTR_SOURCE	:= $(SRCDIR)/$(LIBESTR).$(LIBESTR_SUFFIX)
LIBESTR_DIR	:= $(BUILDDIR)/$(LIBESTR)
LIBESTR_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBESTR_CONF_TOOL	:= autoconf
LIBESTR_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-testbench \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libestr.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libestr)
	@$(call install_fixup, libestr,PRIORITY,optional)
	@$(call install_fixup, libestr,SECTION,base)
	@$(call install_fixup, libestr,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libestr,DESCRIPTION,missing)

	@$(call install_lib, libestr, 0, 0, 0644, libestr)

	@$(call install_finish, libestr)

	@$(call touch)

# vim: syntax=make
