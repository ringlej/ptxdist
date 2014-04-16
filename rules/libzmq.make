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
LIBZMQ_VERSION		:= 4.0.3
LIBZMQ_MD5		:= 8348341a0ea577ff311630da0d624d45
LIBZMQ			:= zeromq-$(LIBZMQ_VERSION)
LIBZMQ_SUFFIX		:= tar.gz
LIBZMQ_URL		:= http://download.zeromq.org/$(LIBZMQ).$(LIBZMQ_SUFFIX)
LIBZMQ_SOURCE		:= $(SRCDIR)/$(LIBZMQ).$(LIBZMQ_SUFFIX)
LIBZMQ_DIR		:= $(BUILDDIR)/$(LIBZMQ)
LIBZMQ_LICENSE		:= LGPLv3+

#
# autoconf
#
LIBZMQ_CONF_TOOL	:= autoconf
LIBZMQ_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--with-gnu-ld \
	--without-documentation

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
