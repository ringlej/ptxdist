# -*-makefile-*-
#
# Copyright (C) 2010 by Tim Sander <tim.sander@hbm.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNIH) += libnih

#
# Paths and names
#
LIBNIH_VERSION	:= 1.0.2
LIBNIH		:= libnih-$(LIBNIH_VERSION)
LIBNIH_SUFFIX	:= tar.gz
LIBNIH_URL	:= http://launchpad.net/libnih/1.0/$(LIBNIH_VERSION)/+download/$(LIBNIH).$(LIBNIH_SUFFIX)
LIBNIH_DIR	:= $(BUILDDIR)/$(LIBNIH)
LIBNIH_SOURCE	:= $(SRCDIR)/$(LIBNIH).$(LIBNIH_SUFFIX)
LIBNIH_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------
$(LIBNIH_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBNIH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNIH_PATH	:= PATH=$(CROSS_PATH)
LIBNIH_ENV 	:= $(CROSS_ENV) NIH_DBUS_TOOL=${PTXDIST_SYSROOT_HOST}/bin/nih-dbus-tool

#
# autoconf
#
LIBNIH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnih.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  libnih)
	@$(call install_fixup, libnih, PACKAGE, libnih)
	@$(call install_fixup, libnih, PRIORITY, optional)
	@$(call install_fixup, libnih, VERSION, $(LIBNIH_VERSION))
	@$(call install_fixup, libnih, SECTION, base)
	@$(call install_fixup, libnih, AUTHOR, "Tim Sandet <tim.sander@hbm.com>")
	@$(call install_fixup, libnih, DEPENDS,)
	@$(call install_fixup, libnih, DESCRIPTION, missing)

	$(call install_copy, libnih, 0, 0, 0644, -, /usr/lib/libnih-dbus.so.1.0.0); 
	$(call install_link, libnih, libnih-dbus.so.1.0.0, /usr/lib/libnih-dbus.so.1); 
	$(call install_link, libnih, libnih-dbus.so.1.0.0, /usr/lib/libnih-dbus.so); 

	$(call install_copy, libnih, 0, 0, 0644, -, /usr/lib/libnih.so.1.0.0); 
	$(call install_link, libnih, libnih.so.1.0.0, /usr/lib/libnih.so.1); 
	$(call install_link, libnih, libnih.so.1.0.0, /usr/lib/libnih.so); 
	@$(call install_finish, libnih)

	@$(call touch)

# vim: syntax=make
