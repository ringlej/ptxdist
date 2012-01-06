# -*-makefile-*-
#
# Copyright (C) 2005 by Bjoern Buerger <b.buerger@pengutronix.de>
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETCAT) += netcat

#
# Paths and names
#
NETCAT_VERSION	:= 0.7.1
NETCAT_MD5	:= 088def25efe04dcdd1f8369d8926ab34
NETCAT		:= netcat-$(NETCAT_VERSION)
NETCAT_SUFFIX	:= tar.gz
NETCAT_URL	:= $(call ptx/mirror, SF, netcat/$(NETCAT).$(NETCAT_SUFFIX))
NETCAT_SOURCE	:= $(SRCDIR)/$(NETCAT).$(NETCAT_SUFFIX)
NETCAT_DIR	:= $(BUILDDIR)/$(NETCAT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NETCAT_SOURCE):
	@$(call targetinfo)
	@$(call get, NETCAT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NETCAT_PATH	:= PATH=$(CROSS_PATH)
NETCAT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
NETCAT_AUTOCONF := $(CROSS_AUTOCONF_ROOT)

ifdef PTXCONF_NETCAT_OLD_HEXDUMP
NETCAT_AUTOCONF += --enable-oldhexdump
else
NETCAT_AUTOCONF += --disable-oldhexdump
endif

ifdef PTXCONF_NETCAT_OLD_TELNET
NETCAT_AUTOCONF += --enable-oldtelnet
else
NETCAT_AUTOCONF += --disable-oldtelnet
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/netcat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, netcat)
	@$(call install_fixup, netcat,PRIORITY,optional)
	@$(call install_fixup, netcat,SECTION,base)
	@$(call install_fixup, netcat,AUTHOR,"Bjoern Buerger <b.buerger@pengutronix.de>")
	@$(call install_fixup, netcat,DESCRIPTION,missing)

	@$(call install_copy, netcat, 0, 0, 0755, -, /bin/netcat)
	@$(call install_link, netcat, netcat, /bin/nc)

	@$(call install_finish, netcat)

	@$(call touch)

# vim: syntax=make
