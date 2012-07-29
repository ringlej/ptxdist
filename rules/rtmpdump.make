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
PACKAGES-$(PTXCONF_RTMPDUMP) += rtmpdump

#
# Paths and names
#
RTMPDUMP_VERSION	:= 2.3
RTMPDUMP_MD5		:= eb961f31cd55f0acf5aad1a7b900ef59
RTMPDUMP		:= rtmpdump-$(RTMPDUMP_VERSION)
RTMPDUMP_SUFFIX		:= tgz
RTMPDUMP_URL		:= http://rtmpdump.mplayerhq.hu/download/$(RTMPDUMP).$(RTMPDUMP_SUFFIX)
RTMPDUMP_SOURCE		:= $(SRCDIR)/$(RTMPDUMP).$(RTMPDUMP_SUFFIX)
RTMPDUMP_DIR		:= $(BUILDDIR)/$(RTMPDUMP)
RTMPDUMP_LICENSE	:= LGPLv2.1+,GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RTMPDUMP_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

RTMPDUMP_MAKE_ENV	:= \
	$(CROSS_ENV) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	XDEF="$(CROSS_CPPFLAGS)" \
	XCFLAGS="$(CROSS_CFLAGS)" \
	XLDFLAGS="$(CROSS_LDFLAGS)"

RTMPDUMP_MAKE_OPT	:= \
	prefix=/usr

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

RTMPDUMP_INSTALL_OPT	:= \
	$(RTMPDUMP_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rtmpdump.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rtmpdump)
	@$(call install_fixup, rtmpdump,PRIORITY,optional)
	@$(call install_fixup, rtmpdump,SECTION,base)
	@$(call install_fixup, rtmpdump,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, rtmpdump,DESCRIPTION,missing)

	@$(call install_lib, rtmpdump, 0, 0, 0644, librtmp)
	@$(call install_copy, rtmpdump, 0, 0, 0755, -, /usr/bin/rtmpdump)

	@$(call install_finish, rtmpdump)

	@$(call touch)

# vim: syntax=make
