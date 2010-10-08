# -*-makefile-*-
#
# Copyright (C) 2011 by Stephan Linz <linz@li-pro.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XL_TOOLS) += host-xl-tools

#
# Paths and names
#
HOST_XL_TOOLS_VERSION	:= 1.0.1
HOST_XL_TOOLS_MD5	:= eee7b6ed778a0b8d309234795d61e9db
HOST_XL_TOOLS		:= xl-tools-$(HOST_XL_TOOLS_VERSION)
HOST_XL_TOOLS_SUFFIX	:= tar.bz2
HOST_XL_TOOLS_URL	:= http://www.li-pro.de/_media/xilinx_mb/xl-tools/$(HOST_XL_TOOLS).$(HOST_XL_TOOLS_SUFFIX)
HOST_XL_TOOLS_SOURCE	:= $(SRCDIR)/$(HOST_XL_TOOLS).$(HOST_XL_TOOLS_SUFFIX)
HOST_XL_TOOLS_DIR	:= $(HOST_BUILDDIR)/$(HOST_XL_TOOLS)

#
# autoconf
#
HOST_XL_TOOLS_CONF_TOOL := autoconf

# vim: syntax=make
