# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBZMQ) += libzmq

#
# Paths and names
#
LIBZMQ_VERSION		:= 4.0.4
LIBZMQ_MD5		:= f3c3defbb5ef6cc000ca65e529fdab3b
LIBZMQ			:= zeromq-$(LIBZMQ_VERSION)
LIBZMQ_SUFFIX		:= tar.gz
LIBZMQ_URL		:= http://download.zeromq.org/$(LIBZMQ).$(LIBZMQ_SUFFIX)
LIBZMQ_SOURCE		:= $(SRCDIR)/$(LIBZMQ).$(LIBZMQ_SUFFIX)
LIBZMQ_DIR		:= $(BUILDDIR)/$(LIBZMQ)
LIBZMQ_LICENSE		:= LGPL-3.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBZMQ_CONF_ENV		:= \
	$(CROSS_ENV) \
	ac_cv_lib_sodium_sodium_init=no

#
# autoconf
#
LIBZMQ_CONF_TOOL	:= autoconf
LIBZMQ_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--disable-debug \
	--with-gnu-ld \
	--without-gcov \
	--without-documentation \
	--with-poller=epoll \
	--without-pgm

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libzmq.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libzmq)
	@$(call install_fixup, libzmq,PRIORITY,optional)
	@$(call install_fixup, libzmq,SECTION,base)
	@$(call install_fixup, libzmq,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, libzmq,DESCRIPTION,missing)

	@$(call install_lib, libzmq, 0, 0, 0644, libzmq)
	@$(call install_copy, libzmq, 0, 0, 0755, -, /usr/bin/curve_keygen)

	@$(call install_finish, libzmq)

	@$(call touch)

# vim: syntax=make
