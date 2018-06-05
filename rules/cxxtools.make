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
PACKAGES-$(PTXCONF_CXXTOOLS) += cxxtools

#
# Paths and names
#
CXXTOOLS_VERSION	:= 2.2.1
CXXTOOLS_MD5		:= aab00068ae5237435b37ac86f2ac7576
CXXTOOLS			:= cxxtools-$(CXXTOOLS_VERSION)
CXXTOOLS_SUFFIX		:= tar.gz
CXXTOOLS_URL		:= http://www.tntnet.org/download/$(CXXTOOLS).$(CXXTOOLS_SUFFIX)
CXXTOOLS_SOURCE		:= $(SRCDIR)/$(CXXTOOLS).$(CXXTOOLS_SUFFIX)
CXXTOOLS_DIR		:= $(BUILDDIR)/$(CXXTOOLS)
CXXTOOLS_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# Building in thumb mode fails
ifdef PTXCONF_ARCH_ARM
CXXTOOLS_CXXFLAGS	:= -marm
endif

CXXTOOLS_CONF_ENV	:= $(CROSS_ENV)
CXXTOOLS_CONF_TOOL	:= autoconf
CXXTOOLS_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-unittest \
	--disable-demos \
	--disable-dependency-tracking

ifdef PTXCONF_ARCH_ARM64
CXXTOOLS_CONF_OPT	+= \
	--with-atomictype=pthread
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cxxtools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cxxtools)
	@$(call install_fixup, cxxtools,PRIORITY,optional)
	@$(call install_fixup, cxxtools,SECTION,base)
	@$(call install_fixup, cxxtools,AUTHOR,"Bernhard Seßler <bernhard.sessler@corscience.de>")
	@$(call install_fixup, cxxtools,DESCRIPTION,missing)

	@$(call install_lib, cxxtools, 0, 0, 0644, libcxxtools)
	@$(call install_lib, cxxtools, 0, 0, 0644, libcxxtools-bin)
	@$(call install_lib, cxxtools, 0, 0, 0644, libcxxtools-http)
	@$(call install_lib, cxxtools, 0, 0, 0644, libcxxtools-json)
	@$(call install_lib, cxxtools, 0, 0, 0644, libcxxtools-unit)
	@$(call install_lib, cxxtools, 0, 0, 0644, libcxxtools-xmlrpc)

	@$(call install_finish, cxxtools)

	@$(call touch)

# vim: syntax=make
