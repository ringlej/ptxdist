# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PROTOBUF) += host-protobuf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_PROTOBUF_CONF_TOOL	:= autoconf
HOST_PROTOBUF_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-64bit-solaris \
	--disable-static \
	--without-zlib

# vim: syntax=make
