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
HOST_PACKAGES-$(PTXCONF_HOST_CXXTOOLS) += host-cxxtools

#
# Paths and names
#
HOST_CXXTOOLS_DIR		:= $(HOST_BUILDDIR)/$(CXXTOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CXXTOOLS_CONF_TOOL	:= autoconf
HOST_CXXTOOLS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-dependency-tracking \
	--disable-unittest \
	--disable-demos

# vim: syntax=make
