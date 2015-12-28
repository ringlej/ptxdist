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
PACKAGES-$(PTXCONF_GST_RTSP_SERVER1) += gst-rtsp-server1

#
# Paths and names
#
GST_RTSP_SERVER1_VERSION	:= 1.6.2
GST_RTSP_SERVER1_MD5		:= a1cafefb5fc14ac5d7e7d8cdbdfa9694
GST_RTSP_SERVER1		:= gst-rtsp-server-$(GST_RTSP_SERVER1_VERSION)
GST_RTSP_SERVER1_SUFFIX		:= tar.xz
GST_RTSP_SERVER1_URL		:= http://gstreamer.freedesktop.org/src/gst-rtsp/$(GST_RTSP_SERVER1).$(GST_RTSP_SERVER1_SUFFIX)
GST_RTSP_SERVER1_SOURCE		:= $(SRCDIR)/$(GST_RTSP_SERVER1).$(GST_RTSP_SERVER1_SUFFIX)
GST_RTSP_SERVER1_DIR		:= $(BUILDDIR)/$(GST_RTSP_SERVER1)
GST_RTSP_SERVER1_LICENSE	:= LGPL-2.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GST_RTSP_SERVER1_CONF_TOOL	:= autoconf
GST_RTSP_SERVER1_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	--disable-tests \
	--disable-introspection \
	--disable-docbook \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-rtsp-server1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-rtsp-server1)
	@$(call install_fixup, gst-rtsp-server1,PRIORITY,optional)
	@$(call install_fixup, gst-rtsp-server1,SECTION,base)
	@$(call install_fixup, gst-rtsp-server1,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gst-rtsp-server1,DESCRIPTION,missing)

	@$(call install_lib, gst-rtsp-server1, 0, 0, 0644, libgstrtspserver-1.0)

	@$(call install_finish, gst-rtsp-server1)

	@$(call touch)

# vim: syntax=make
