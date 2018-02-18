# -*-makefile-*-
#
# Copyright (C) 2017 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPTEE_CLIENT) += optee-client

#
# Paths and names
#
OPTEE_CLIENT_VERSION	:= 2.4.0
OPTEE_CLIENT_MD5	:= 5c27298b0e28aa9b28d18e44c79cc66d
OPTEE_CLIENT		:= optee-client-$(OPTEE_CLIENT_VERSION)
OPTEE_CLIENT_SUFFIX	:= tar.gz
OPTEE_CLIENT_URL	:= https://github.com/OP-TEE/optee_client/archive/$(OPTEE_CLIENT_VERSION).$(OPTEE_CLIENT_SUFFIX)
OPTEE_CLIENT_SOURCE	:= $(SRCDIR)/$(OPTEE_CLIENT).$(OPTEE_CLIENT_SUFFIX)
OPTEE_CLIENT_DIR	:= $(BUILDDIR)/$(OPTEE_CLIENT)
OPTEE_CLIENT_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPTEE_CLIENT_CONF_TOOL := NO
OPTEE_CLIENT_MAKE_ENV := \
	$(CROSS_ENV) \
	LIBDIR=/usr/lib \
	BINDIR=/usr/bin \
	INCLUDEDIR=/usr/include

ifdef PTXDIST_ICECC
OPTEE_CLIENT_CFLAGS := -C
endif
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/optee-client.targetinstall:
	@$(call targetinfo)

	@$(call install_init, optee-client)
	@$(call install_fixup, optee-client,PRIORITY,optional)
	@$(call install_fixup, optee-client,SECTION,base)
	@$(call install_fixup, optee-client,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, optee-client,DESCRIPTION,missing)

	@$(call install_lib, optee-client, 0, 0, 0644, libteec)
	@$(call install_copy, optee-client, 0, 0, 0755, -, /usr/bin/tee-supplicant)

	@$(call install_finish, optee-client)

	@$(call touch)

# vim: syntax=make
