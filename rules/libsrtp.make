# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSRTP) += libsrtp

#
# Paths and names
#
LIBSRTP_VERSION	:= 2.2.0
LIBSRTP_MD5	:= f77a27457d219f2991ea7aa2f0c11ec9
LIBSRTP		:= libsrtp-$(LIBSRTP_VERSION)
LIBSRTP_SUFFIX	:= tar.gz
LIBSRTP_URL	:= https://github.com/cisco/libsrtp/archive/v$(LIBSRTP_VERSION).$(LIBSRTP_SUFFIX)
LIBSRTP_SOURCE	:= $(SRCDIR)/$(LIBSRTP).$(LIBSRTP_SUFFIX)
LIBSRTP_DIR	:= $(BUILDDIR)/$(LIBSRTP)
LIBSRTP_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSRTP_CONF_TOOL	:= autoconf
LIBSRTP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug-logging \
	--enable-openssl \
	--disable-openssl-kdf \
	--enable-log-stdout

LIBSRTP_MAKE_OPT	:= shared_library

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsrtp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsrtp)
	@$(call install_fixup, libsrtp,PRIORITY,optional)
	@$(call install_fixup, libsrtp,SECTION,base)
	@$(call install_fixup, libsrtp,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libsrtp,DESCRIPTION,missing)

	@$(call install_lib, libsrtp, 0, 0, 644, libsrtp2)

	@$(call install_finish, libsrtp)

	@$(call touch)

# vim: syntax=make
