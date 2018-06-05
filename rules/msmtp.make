# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MSMTP) += msmtp

#
# Paths and names
#
MSMTP_VERSION	:= 1.4.30
MSMTP_MD5	:= 4d32724a2b03f07aa6d4ea9d49367ad3
MSMTP		:= msmtp-$(MSMTP_VERSION)
MSMTP_SUFFIX	:= tar.bz2
MSMTP_URL	:= $(call ptx/mirror, SF, msmtp/$(MSMTP).$(MSMTP_SUFFIX))
MSMTP_SOURCE	:= $(SRCDIR)/$(MSMTP).$(MSMTP_SUFFIX)
MSMTP_DIR	:= $(BUILDDIR)/$(MSMTP)
MSMTP_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MSMTP_CONF_TOOL	:= autoconf
MSMTP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-rpath \
	--with-ssl=$(PTXCONF_MSMTP_SSL) \
	--without-libgsasl \
	--without-libidn \
	--without-gnome-keyring

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/msmtp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, msmtp)
	@$(call install_fixup, msmtp,PRIORITY,optional)
	@$(call install_fixup, msmtp,SECTION,base)
	@$(call install_fixup, msmtp,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, msmtp,DESCRIPTION,missing)

	@$(call install_copy, msmtp, 0, 0, 0755, -, /usr/bin/msmtp)

	@$(call install_finish, msmtp)

	@$(call touch)

# vim: syntax=make
