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
HOST_PACKAGES-$(PTXCONF_HOST_LIBEPOXY) += host-libepoxy

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBEPOXY_CONF_ENV	:= \
	$(HOST_ENV) \
	ac_cv_prog_PYTHON=$(SYSTEMPYTHON3)

#
# autoconf
#
HOST_LIBEPOXY_CONF_TOOL	:= autoconf
HOST_LIBEPOXY_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-selective-werror \
	--disable-strict-compilation \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-x11 \
	--disable-glx \
	--disable-egl

# vim: syntax=make
