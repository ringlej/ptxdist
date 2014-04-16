# -*-makefile-*-
#
# Copyright (C) 2014 by Bernhard Seßler <bernhard.sessler@corscience.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_TNTNET) += host-tntnet

#
# Paths and names
#
HOST_TNTNET_DIR		= $(HOST_BUILDDIR)/$(TNTNET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_TNTNET_CONF_TOOL	:= autoconf
HOST_TNTNET_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-dependency-tracking \
	--disable-unittest \
	--with-demos=no \
	--with-epoll=no \
	--with-sdk=yes \
	--with-sendfile=no \
	--with-server=no \
	--with-ssl=no \
	--with-stressjob=no

# vim: syntax=make
