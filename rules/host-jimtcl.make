# -*-makefile-*-
#
# Copyright (C) 2018 by Ladislav Michl <ladis@linux-mips.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_JIMTCL) += host-jimtcl

#
# Paths and names
#
HOST_JIMTCL	:= $(JIMTCL)
HOST_JIMTCL_DIR	:= $(HOST_BUILDDIR)/$(HOST_JIMTCL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# Package is not using autoconf but autosetup which is enough compatible...
#
HOST_JIMTCL_CONF_TOOL	:= autoconf
# autosetup/cc.tcl tries to discover ccache on its own, so use 'CCACHE=none'
# to prevent that and leave PTXCONF_SETUP_CCACHE in charge.
HOST_JIMTCL_CONF_ENV	:= \
	$(HOST_ENV) \
	CCACHE=none
HOST_JIMTCL_CONF_OPT	:= \
	--prefix=/usr \
	--disable-lineedit \
	--disable-docs

# vim: syntax=make
