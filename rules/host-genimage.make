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
HOST_PACKAGES-$(PTXCONF_HOST_GENIMAGE) += host-genimage

#
# Paths and names
#
HOST_GENIMAGE_VERSION	:= 4
HOST_GENIMAGE_MD5	:= accbbee9c4782e2607e3cc27c0ba7cb1
HOST_GENIMAGE		:= genimage-$(HOST_GENIMAGE_VERSION)
HOST_GENIMAGE_SUFFIX	:= tar.xz
HOST_GENIMAGE_URL	:= http://www.pengutronix.de/software/genimage/download/$(HOST_GENIMAGE).$(HOST_GENIMAGE_SUFFIX)
HOST_GENIMAGE_SOURCE	:= $(SRCDIR)/$(HOST_GENIMAGE).$(HOST_GENIMAGE_SUFFIX)
HOST_GENIMAGE_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENIMAGE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GENIMAGE_CONF_TOOL	:= autoconf
HOST_GENIMAGE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-largefile

# vim: syntax=make
