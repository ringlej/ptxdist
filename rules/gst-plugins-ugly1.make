# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_UGLY1) += gst-plugins-ugly1

#
# Paths and names
#
GST_PLUGINS_UGLY1_VERSION	:= 1.14.0
GST_PLUGINS_UGLY1_MD5		:= bcb1f8d9339176aee2b5da2a9cb2df88
GST_PLUGINS_UGLY1		:= gst-plugins-ugly-$(GST_PLUGINS_UGLY1_VERSION)
GST_PLUGINS_UGLY1_SUFFIX	:= tar.xz
GST_PLUGINS_UGLY1_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-ugly/$(GST_PLUGINS_UGLY1).$(GST_PLUGINS_UGLY1_SUFFIX)
GST_PLUGINS_UGLY1_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_UGLY1).$(GST_PLUGINS_UGLY1_SUFFIX)
GST_PLUGINS_UGLY1_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_UGLY1)
GST_PLUGINS_UGLY1_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_UGLY1_ENABLEC-$(PTXCONF_GST_PLUGINS_UGLY1_ASFDEMUX)		+= asfdemux
GST_PLUGINS_UGLY1_ENABLEP-$(PTXCONF_GST_PLUGINS_UGLY1_ASFDEMUX)		+= asf
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_DVDLPCMDEC)	+= dvdlpcmdec
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_DVDSUB)		+= dvdsub
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_XINGMUX)		+= xingmux
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_REALMEDIA)		+= realmedia
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_A52DEC)		+= a52dec
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_AMRNB)		+= amrnb
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_AMRWBDEC)		+= amrwb
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_CDIO)		+= cdio
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_DVDREADSRC)	+= dvdread
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_MPEG2DEC)		+= mpeg2dec
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_SID)		+= sidplay
GST_PLUGINS_UGLY1_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY1_X264)		+= x264

GST_PLUGINS_UGLY1_ENABLEC-y	+= $(GST_PLUGINS_UGLY1_ENABLE-y)
GST_PLUGINS_UGLY1_ENABLEC-	+= $(GST_PLUGINS_UGLY1_ENABLE-)
GST_PLUGINS_UGLY1_ENABLEP-y	+= $(GST_PLUGINS_UGLY1_ENABLE-y)

#
# autoconf
#
GST_PLUGINS_UGLY1_CONF_TOOL	:= autoconf
GST_PLUGINS_UGLY1_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER1_GENERIC_CONF_OPT) \
	--enable-external \
	--enable-experimental \
	--enable-orc

#
# the --with-plugins sadly only applies to depencyless plugings
# and when no plugins are sellected it builds them all. So
# --with-plugins is useless, so we generate a --enable-*
# and --disable-* below
#
ifneq ($(call remove_quotes,$(GST_PLUGINS_UGLY1_ENABLEC-y)),)
GST_PLUGINS_UGLY1_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_UGLY1_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_UGLY1_ENABLEC-)),)
GST_PLUGINS_UGLY1_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_UGLY1_ENABLEC-)))
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-ugly1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-ugly1)
	@$(call install_fixup, gst-plugins-ugly1,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-ugly1,SECTION,base)
	@$(call install_fixup, gst-plugins-ugly1,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, gst-plugins-ugly1,DESCRIPTION,missing)

	# install all activated plugins
	@for plugin in $(GST_PLUGINS_UGLY1_ENABLEP-y); do \
		$(call install_copy, gst-plugins-ugly1, 0, 0, 0644, -, \
			/usr/lib/gstreamer-1.0/libgst$${plugin}.so); \
	done

	@$(call install_finish, gst-plugins-ugly1)

	@$(call touch)

# vim: syntax=make
