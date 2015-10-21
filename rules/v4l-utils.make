# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_V4L_UTILS) += v4l-utils

#
# Paths and names
#
V4L_UTILS_VERSION	:= 1.6.2
V4L_UTILS_MD5		:= 9cb3c178f937954e65bf30920af433ef
V4L_UTILS		:= v4l-utils-$(V4L_UTILS_VERSION)
V4L_UTILS_SUFFIX	:= tar.bz2
V4L_UTILS_URL		:= http://linuxtv.org/downloads/v4l-utils/$(V4L_UTILS).$(V4L_UTILS_SUFFIX)
V4L_UTILS_SOURCE	:= $(SRCDIR)/$(V4L_UTILS).$(V4L_UTILS_SUFFIX)
V4L_UTILS_DIR		:= $(BUILDDIR)/$(V4L_UTILS)
V4L_UTILS_LICENSE	:= GPL-2.0+ (tools); LGPL-2.1+ (libs)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

V4L_UTILS_CONF_TOOL	:= autoconf
V4L_UTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doxygen-doc \
	--disable-rpath \
	--disable-libdvbv5 \
	--enable-libv4l \
	--enable-v4l-utils \
	--disable-qv4l2 \
	--$(call ptx/wwo, PTXCONF_V4L_UTILS_LIBV4LCONVERT)-jpeg \
	--$(call ptx/wwo, PTXCONF_V4L_UTILS_MEDIACTL)-libudev

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/v4l-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, v4l-utils)
	@$(call install_fixup, v4l-utils,PRIORITY,optional)
	@$(call install_fixup, v4l-utils,SECTION,base)
	@$(call install_fixup, v4l-utils,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, v4l-utils,DESCRIPTION,missing)

ifdef PTXCONF_V4L_UTILS_LIBV4L1
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l1)
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l/v4l1compat)
endif
ifdef PTXCONF_V4L_UTILS_LIBV4L2
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l2)
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l/v4l2convert)
endif
ifdef PTXCONF_V4L_UTILS_LIBV4LCONVERT
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4lconvert)
endif

ifdef PTXCONF_V4L_UTILS_MEDIACTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/media-ctl)
endif

ifdef PTXCONF_V4L_UTILS_V4L2COMPLIANCE
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/v4l2-compliance)
endif

ifdef PTXCONF_V4L_UTILS_V4L2DBG
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/sbin/v4l2-dbg)
endif

ifdef PTXCONF_V4L_UTILS_V4L2CTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/v4l2-ctl)
endif

	@$(call install_finish, v4l-utils)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/v4l-utils.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, V4L_UTILS)

# vim: syntax=make
