# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBVA_UTILS) += libva-utils

#
# Paths and names
#
LIBVA_UTILS_VERSION	:= 2.1.0
LIBVA_UTILS_MD5		:= 6649be70390606651cb636320bfd43c6
LIBVA_UTILS		:= libva-utils-$(LIBVA_UTILS_VERSION)
LIBVA_UTILS_SUFFIX	:= tar.bz2
LIBVA_UTILS_URL		:= https://github.com/intel/libva-utils/releases/download/$(LIBVA_UTILS_VERSION)/$(LIBVA_UTILS).$(LIBVA_UTILS_SUFFIX)
LIBVA_UTILS_SOURCE	:= $(SRCDIR)/$(LIBVA_UTILS).$(LIBVA_UTILS_SUFFIX)
LIBVA_UTILS_DIR		:= $(BUILDDIR)/$(LIBVA_UTILS)
LIBVA_UTILS_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBVA_UTILS_CONF_TOOL	:= autoconf
LIBVA_UTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-drm \
	--$(call ptx/endis, PTXCONF_LIBVA_UTILS_X11)-x11 \
	--$(call ptx/endis, PTXCONF_LIBVA_UTILS_WAYLAND)-wayland \
	--disable-tests \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libva-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libva-utils)
	@$(call install_fixup, libva-utils,PRIORITY,optional)
	@$(call install_fixup, libva-utils,SECTION,base)
	@$(call install_fixup, libva-utils,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libva-utils,DESCRIPTION,missing)

	@$(call install_tree, libva-utils, 0, 0, -, /usr/bin)

	@$(call install_finish, libva-utils)

	@$(call touch)

# vim: syntax=make
