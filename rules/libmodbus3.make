# -*-makefile-*-
#
# Copyright (C) 2005 by Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMODBUS3) += libmodbus3

#
# Paths and names
#
LIBMODBUS3_VERSION	:= 3.0.1
LIBMODBUS3_MD5		:= 7ad8afbd02a7a2afd70c5bb7271a593b
LIBMODBUS3		:= libmodbus-$(LIBMODBUS3_VERSION)
LIBMODBUS3_SUFFIX	:= tar.gz
LIBMODBUS3_URL		:= http://github.com/downloads/stephane/libmodbus/$(LIBMODBUS3).$(LIBMODBUS3_SUFFIX)
LIBMODBUS3_SOURCE	:= $(SRCDIR)/$(LIBMODBUS3).$(LIBMODBUS3_SUFFIX)
LIBMODBUS3_DIR		:= $(BUILDDIR)/$(LIBMODBUS3)
LIBMODBUS3_LICENSE	:= LGPLv3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMODBUS3_CONF_TOOL := autoconf
LIBMODBUS3_CONF_OPT += \
	$(CROSS_AUTOCONF_USR) \
	--enable-silent-rules \
	--without-documentation

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmodbus3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmodbus3)
	@$(call install_fixup, libmodbus3,PRIORITY,optional)
	@$(call install_fixup, libmodbus3,SECTION,base)
	@$(call install_fixup, libmodbus3,AUTHOR,"Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>")
	@$(call install_fixup, libmodbus3,DESCRIPTION,missing)

	@$(call install_lib, libmodbus3, 0, 0, 0644, libmodbus)

	@$(call install_finish, libmodbus3)

	@$(call touch)

# vim: syntax=make
