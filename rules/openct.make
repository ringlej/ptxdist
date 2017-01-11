# -*-makefile-*-
#
# Copyright (C) 2010 by Juergen Beisert <jbe@pengutronix.de>
#               2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENCT) += openct

#
# Paths and names
#
OPENCT_VERSION		:= 0.6.20
OPENCT_MD5		:= a1da3358ab798f1cb9232f1dbababc21
OPENCT			:= openct-$(OPENCT_VERSION)
OPENCT_SUFFIX		:= tar.gz
OPENCT_URL		:= $(call ptx/mirror, SF, opensc/openct/$(OPENCT).$(OPENCT_SUFFIX))
OPENCT_SOURCE		:= $(SRCDIR)/$(OPENCT).$(OPENCT_SUFFIX)
OPENCT_DIR		:= $(BUILDDIR)/$(OPENCT)
OPENCT_BUILD_OOT	:= YES
OPENCT_LICENSE		:= LGPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENCT_CONF_TOOL := autoconf
OPENCT_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--localstatedir=/ \
	--$(call ptx/endis, PTXCONF_OPENCT_PCSC)-pcsc \
	--$(call ptx/endis, PTXCONF_OPENCT_USB)-usb \
	--disable-debug \
	--disable-sunray \
	--disable-sunrayclient \
	--enable-shared \
	--disable-static \
	--with-bundle=/usr/lib/pcsc


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openct.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  openct)
	@$(call install_fixup, openct,PRIORITY,optional)
	@$(call install_fixup, openct,SECTION,base)
	@$(call install_fixup, openct,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, openct,DESCRIPTION, "SmartCard environment")

	@$(call install_lib, openct, 0, 0, 0644, libopenct)
	@$(call install_copy, openct, 0, 0, 0755, -, /usr/sbin/ifdhandler)
	@$(call install_copy, openct, 0, 0, 0755, -, /usr/sbin/openct-control)

ifdef PTXCONF_OPENCT_PCSC
	@$(call install_lib, openct, 0, 0, 0644, openct-ifd)
endif
ifdef PTXCONF_OPENCT_API
	@$(call install_lib, openct, 0, 0, 0644, libopenctapi)
endif
ifdef PTXCONF_OPENCT_TOOLS
	@$(call install_copy, openct, 0, 0, 0755, -, /usr/bin/openct-tool)
	@$(call install_copy, openct, 0, 0, 0755, -, /usr/sbin/ifdproxy)
endif
	@$(call install_alternative, openct, 0, 0, 0644, /etc/openct.conf)

ifdef PTXCONF_OPENCT_SYSTEMD_UNIT
	@$(call install_alternative, openct, 0, 0, 0644, /usr/lib/systemd/system/openct.service)
	@$(call install_link, openct, ../openct.service, \
		/usr/lib/systemd/system/multi-user.target.wants/openct.service)
	@$(call install_alternative, openct, 0, 0, 0644, /usr/lib/tmpfiles.d/openct.conf)
endif

	@$(call install_finish, openct)
	@$(call touch)

# vim: syntax=make
