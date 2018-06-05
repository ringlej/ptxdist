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
V4L_UTILS_VERSION	:= 1.14.0
V4L_UTILS_MD5		:= ef7a0eaadf85a06ec0df272ddca6f5f7
V4L_UTILS		:= v4l-utils-$(V4L_UTILS_VERSION)
V4L_UTILS_SUFFIX	:= tar.bz2
V4L_UTILS_URL		:= http://linuxtv.org/downloads/v4l-utils/$(V4L_UTILS).$(V4L_UTILS_SUFFIX)
V4L_UTILS_SOURCE	:= $(SRCDIR)/$(V4L_UTILS).$(V4L_UTILS_SUFFIX)
V4L_UTILS_DIR		:= $(BUILDDIR)/$(V4L_UTILS)
V4L_UTILS_LICENSE	:= GPL-2.0-or-later (tools); LGPL-2.1-or-later (libs)
V4L_UTILS_LICENSE_FILES	:= \
	file://COPYING;md5=48da9957849056017dc568bbc43d8975 \
	file://COPYING.libdvbv5;md5=28fb0f8e5cecc8a7a1a88008019dc3d0 \
	file://COPYING.libv4l;md5=d749e86a105281d7a44c2328acebc4b0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

V4L_UTILS_CONF_TOOL	:= autoconf
V4L_UTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-man \
	--disable-doxygen-rtf \
	--disable-doxygen-xml \
	--disable-doxygen-chm \
	--disable-doxygen-chi \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--disable-nls \
	--disable-rpath \
	--disable-libdvbv5 \
	--enable-dyn-libv4l \
	--enable-v4l-utils \
	--enable-v4l2-compliance-libv4l \
	--enable-v4l2-ctl-libv4l \
	--enable-v4l2-ctl-stream-to \
	--disable-qv4l2 \
	--disable-gconv \
	--$(call ptx/wwo, PTXCONF_V4L_UTILS_LIBV4LCONVERT)-jpeg

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
ifdef PTXCONF_V4L_UTILS_CECCOMPLIANCE
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/cec-compliance)
endif
ifdef PTXCONF_V4L_UTILS_CECCTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/cec-ctl)
endif
ifdef PTXCONF_V4L_UTILS_CECFOLLOWER
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/cec-follower)
endif
ifdef PTXCONF_V4L_UTILS_CX18CTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/cx18-ctl)
endif
ifdef PTXCONF_V4L_UTILS_DECODETM6000
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/decode_tm6000)
endif
ifdef PTXCONF_V4L_UTILS_IRCTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/ir-ctl)
endif
ifdef PTXCONF_V4L_UTILS_IRKEYTABLE
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/ir-keytable)
endif
ifdef PTXCONF_V4L_UTILS_IVTVCTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/ivtv-ctl)
endif
ifdef PTXCONF_V4L_UTILS_MEDIACTL
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/media-ctl)
endif
ifdef PTXCONF_V4L_UTILS_RDSCTL
	@$(call install_lib, v4l-utils, 0, 0, 0644, libv4l2rds)
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/rds-ctl)
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
ifdef PTXCONF_V4L_UTILS_V4L2SYSFSPATH
	@$(call install_copy, v4l-utils, 0, 0, 0755, -, /usr/bin/v4l2-sysfs-path)
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
