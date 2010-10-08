# -*-makefile-*-
#
# Copyright (C) 2003 by Ixia Corporation (www.ixiacom.com)
#               2006 by Randall Loomis
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GENEXT2FS) += host-genext2fs

#
# Paths and names
#
HOST_GENEXT2FS_VERSION	:= 1.4.1
HOST_GENEXT2FS_MD5	:= b7b6361bcce2cedff1ae437fadafe53b
HOST_GENEXT2FS		:= genext2fs-$(HOST_GENEXT2FS_VERSION)
HOST_GENEXT2FS_SUFFIX	:= tar.gz
HOST_GENEXT2FS_URL	:= $(PTXCONF_SETUP_SFMIRROR)/genext2fs/$(HOST_GENEXT2FS).$(HOST_GENEXT2FS_SUFFIX)
HOST_GENEXT2FS_SOURCE	:= $(SRCDIR)/$(HOST_GENEXT2FS).$(HOST_GENEXT2FS_SUFFIX)
HOST_GENEXT2FS_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENEXT2FS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_GENEXT2FS_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_GENEXT2FS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GENEXT2FS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GENEXT2FS_AUTOCONF := $(HOST_AUTOCONF)

# vim: syntax=make
