# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEVDEV) += libevdev

#
# Paths and names
#
LIBEVDEV_VERSION	:= 1.5.7
LIBEVDEV_MD5		:= 4f1cfaee8d75ea3fbbfeb99a98730952
LIBEVDEV		:= libevdev-$(LIBEVDEV_VERSION)
LIBEVDEV_SUFFIX		:= tar.xz
LIBEVDEV_URL		:= http://www.freedesktop.org/software/libevdev/$(LIBEVDEV).$(LIBEVDEV_SUFFIX)
LIBEVDEV_SOURCE		:= $(SRCDIR)/$(LIBEVDEV).$(LIBEVDEV_SUFFIX)
LIBEVDEV_DIR		:= $(BUILDDIR)/$(LIBEVDEV)
LIBEVDEV_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEVDEV_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_path_VALGRIND= \
	ac_cv_path_DOXYGEN=

#
# autoconf
#
LIBEVDEV_CONF_TOOL	:= autoconf
LIBEVDEV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gcov

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libevdev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libevdev)
	@$(call install_fixup, libevdev,PRIORITY,optional)
	@$(call install_fixup, libevdev,SECTION,base)
	@$(call install_fixup, libevdev,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libevdev,DESCRIPTION,missing)

	@$(call install_lib, libevdev, 0, 0, 0644, libevdev)

	@$(call install_finish, libevdev)

	@$(call touch)

# vim: syntax=make
