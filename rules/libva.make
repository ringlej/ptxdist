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
PACKAGES-$(PTXCONF_LIBVA) += libva

#
# Paths and names
#
LIBVA_VERSION	:= 2.1.0
LIBVA_MD5	:= 9d6e4f1d36c407566343e9dde5a972b8
LIBVA		:= libva-$(LIBVA_VERSION)
LIBVA_SUFFIX	:= tar.bz2
LIBVA_URL	:= https://github.com/intel/libva/releases/download/$(LIBVA_VERSION)/$(LIBVA).$(LIBVA_SUFFIX)
LIBVA_SOURCE	:= $(SRCDIR)/$(LIBVA).$(LIBVA_SUFFIX)
LIBVA_DIR	:= $(BUILDDIR)/$(LIBVA)
LIBVA_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBVA_ENABLE-y				:= drm
LIBVA_ENABLE-$(PTXCONF_LIBVA_X11)	+= x11
LIBVA_ENABLE-$(PTXCONF_LIBVA_GLX)	+= glx
LIBVA_ENABLE-$(PTXCONF_LIBVA_WAYLAND)	+= wayland

#
# autoconf
#
LIBVA_CONF_TOOL	:= autoconf
LIBVA_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	$(addprefix --enable-,$(LIBVA_ENABLE-y)) \
	$(addprefix --disable-,$(LIBVA_ENABLE-)) \
	--enable-va-messaging \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libva.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libva)
	@$(call install_fixup, libva,PRIORITY,optional)
	@$(call install_fixup, libva,SECTION,base)
	@$(call install_fixup, libva,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libva,DESCRIPTION,missing)

	@$(call install_lib, libva, 0, 0, 0644, libva)

	@$(foreach api, $(LIBVA_ENABLE-y), \
		$(call install_lib, libva, 0, 0, 0644, libva-$(api));)

	@$(call install_finish, libva)

	@$(call touch)

# vim: syntax=make
