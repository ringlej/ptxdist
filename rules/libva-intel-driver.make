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
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_LIBVA_INTEL_DRIVER) += libva-intel-driver

#
# Paths and names
#
LIBVA_INTEL_DRIVER_VERSION	:= 2.1.0
LIBVA_INTEL_DRIVER_MD5		:= ab4c33ab31183787dece9b99a86f7b8c
LIBVA_INTEL_DRIVER		:= intel-vaapi-driver-$(LIBVA_INTEL_DRIVER_VERSION)
LIBVA_INTEL_DRIVER_SUFFIX	:= tar.bz2
LIBVA_INTEL_DRIVER_URL		:= https://github.com/intel/intel-vaapi-driver/releases/download/$(LIBVA_INTEL_DRIVER_VERSION)/$(LIBVA_INTEL_DRIVER).$(LIBVA_INTEL_DRIVER_SUFFIX)
LIBVA_INTEL_DRIVER_SOURCE	:= $(SRCDIR)/$(LIBVA_INTEL_DRIVER).$(LIBVA_INTEL_DRIVER_SUFFIX)
LIBVA_INTEL_DRIVER_DIR		:= $(BUILDDIR)/$(LIBVA_INTEL_DRIVER)
LIBVA_INTEL_DRIVER_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBVA_INTEL_DRIVER_CONF_TOOL	:= autoconf
LIBVA_INTEL_DRIVER_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-drm \
	--$(call ptx/endis, PTXCONF_LIBVA_INTEL_DRIVER_X11)-x11 \
	--$(call ptx/endis, PTXCONF_LIBVA_INTEL_DRIVER_WAYLAND)-wayland \
	--disable-hybrid-codec \
	--disable-tests \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libva-intel-driver.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libva-intel-driver)
	@$(call install_fixup, libva-intel-driver,PRIORITY,optional)
	@$(call install_fixup, libva-intel-driver,SECTION,base)
	@$(call install_fixup, libva-intel-driver,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libva-intel-driver,DESCRIPTION,missing)

	@$(call install_lib, libva-intel-driver, 0, 0, 0644, dri/i965_drv_video)

	@$(call install_finish, libva-intel-driver)

	@$(call touch)

# vim: syntax=make
