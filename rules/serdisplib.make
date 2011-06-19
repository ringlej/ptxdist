# -*-makefile-*-
#
# Copyright (C) 2011 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SERDISPLIB) += serdisplib

#
# Paths and names
#
SERDISPLIB_VERSION	:= 1.97.9
SERDISPLIB_MD5		:= 130552ec60d01e974712a60274f34de7
SERDISPLIB		:= serdisplib-$(SERDISPLIB_VERSION)
SERDISPLIB_SUFFIX	:= tar.gz
SERDISPLIB_URL		:= $(PTXCONF_SETUP_SFMIRROR)/project/serdisplib/serdisplib/$(SERDISPLIB_VERSION)/$(SERDISPLIB).$(SERDISPLIB_SUFFIX)
SERDISPLIB_SOURCE	:= $(SRCDIR)/$(SERDISPLIB).$(SERDISPLIB_SUFFIX)
SERDISPLIB_DIR		:= $(BUILDDIR)/$(SERDISPLIB)
SERDISPLIB_LICENSE	:= GPL


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SERDISPLIB_CONF_TOOL	:= autoconf
SERDISPLIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-libusb

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/serdisplib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, serdisplib)
	@$(call install_fixup, serdisplib,PRIORITY,optional)
	@$(call install_fixup, serdisplib,SECTION,base)
	@$(call install_fixup, serdisplib,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, serdisplib,DESCRIPTION,missing)

	@$(call install_lib, serdisplib, 0, 0, 0644, libserdisp)

ifdef PTXCONF_SERDISPLIB_TESTSERDISP
	@$(call install_copy, serdisplib, 0, 0, 0755, -, /usr/bin/testserdisp)
endif

	@$(call install_finish, serdisplib)

	@$(call touch)

# vim: syntax=make
