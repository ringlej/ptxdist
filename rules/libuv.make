# -*-makefile-*-
#
# Copyright (C) 2018 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUV) += libuv

#
# Paths and names
#
LIBUV_VERSION	:= 1.23.2
LIBUV_MD5	:= cda910306306f997e569c8a0adee44ce
LIBUV		:= libuv-v$(LIBUV_VERSION)
LIBUV_SUFFIX	:= tar.gz
LIBUV_URL	:= https://dist.libuv.org/dist/v$(LIBUV_VERSION)/$(LIBUV).$(LIBUV_SUFFIX)
LIBUV_SOURCE	:= $(SRCDIR)/$(LIBUV).$(LIBUV_SUFFIX)
LIBUV_DIR	:= $(BUILDDIR)/$(LIBUV)
LIBUV_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBUV_CONF_TOOL	:= autoconf
LIBUV_CONF_OPT	:= \
        $(CROSS_AUTOCONF_USR) \
        $(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libuv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libuv)
	@$(call install_fixup, libuv,PRIORITY,optional)
	@$(call install_fixup, libuv,SECTION,base)
	@$(call install_fixup, libuv,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libuv,DESCRIPTION,missing)

	@$(call install_lib, libuv, 0, 0, 0644, libuv)

	@$(call install_finish, libuv)

	@$(call touch)

# vim: syntax=make
