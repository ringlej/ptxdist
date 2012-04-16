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
PACKAGES-$(PTXCONF_GST_PLUGINS_UGLY11) += gst-plugins-ugly11

#
# Paths and names
#
GST_PLUGINS_UGLY11_VERSION	:= 0.11.2
GST_PLUGINS_UGLY11_MD5		:= 7dbefcf72eb3a5c6b8405bc6021e8a37
GST_PLUGINS_UGLY11		:= gst-plugins-ugly-$(GST_PLUGINS_UGLY11_VERSION)
GST_PLUGINS_UGLY11_SUFFIX	:= tar.bz2
GST_PLUGINS_UGLY11_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-ugly/$(GST_PLUGINS_UGLY11).$(GST_PLUGINS_UGLY11_SUFFIX)
GST_PLUGINS_UGLY11_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_UGLY11).$(GST_PLUGINS_UGLY11_SUFFIX)
GST_PLUGINS_UGLY11_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_UGLY11)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GST_PLUGINS_UGLY11_SOURCE):
	@$(call targetinfo)
	@$(call get, GST_PLUGINS_UGLY11)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_UGLY11_ENABLEC-$(PTXCONF_GST_PLUGINS_UGLY11_ASFDEMUX)	+= asfdemux
GST_PLUGINS_UGLY11_ENABLEP-$(PTXCONF_GST_PLUGINS_UGLY11_ASFDEMUX)	+= asf
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_DVDLPCMDEC)	+= dvdlpcmdec
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_DVDSUB)		+= dvdsub
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_XINGMUX)		+= xingmux
GST_PLUGINS_UGLY11_ENABLEC-$(PTXCONF_GST_PLUGINS_UGLY11_REALMEDIA)	+= realmedia
GST_PLUGINS_UGLY11_ENABLEP-$(PTXCONF_GST_PLUGINS_UGLY11_REALMEDIA)	+= rmdemux
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_SYNAESTHESIA)	+= synaesthesia
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_A52DEC)		+= a52dec
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_AMRNB)		+= amrnb
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_AMRWBDEC)	+= amrwb
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_CDIO)		+= cdio
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_DVDREADSRC)	+= dvdread
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_LAME)		+= lame
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_MAD)		+= mad
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_MPEG2DEC)	+= mpeg2dec
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_SID)		+= sidplay
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_TWOLAME)		+= twolame
GST_PLUGINS_UGLY11_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY11_X264)		+= x264

GST_PLUGINS_UGLY11_ENABLEC-y	+= $(GST_PLUGINS_UGLY11_ENABLE-y)
GST_PLUGINS_UGLY11_ENABLEC-	+= $(GST_PLUGINS_UGLY11_ENABLE-)
GST_PLUGINS_UGLY11_ENABLEP-y	+= $(GST_PLUGINS_UGLY11_ENABLE-y)

#
# autoconf
#
GST_PLUGINS_UGLY11_CONF_TOOL	:= autoconf
GST_PLUGINS_UGLY11_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-option-checking \
	--enable-silent-rules \
        --disable-nls \
        --disable-rpath \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	--enable-external \
	--enable-experimental \
	--disable-gtk-doc \
	--with-package-origin="PTXDist"

#  --enable-gobject-cast-checks=[no/auto/yes] Enable GObject cast checks

#
# the --with-plugins sadly only applies to depencyless plugings
# and when no plugins are sellected it builds them all. So
# --with-plugins is useless, so we generate a --enable-*
# and --disable-* below
#
ifneq ($(call remove_quotes,$(GST_PLUGINS_UGLY11_ENABLEC-y)),)
GST_PLUGINS_UGLY11_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_UGLY11_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_UGLY11_ENABLEC-)),)
GST_PLUGINS_UGLY11_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_UGLY11_ENABLEC-)))
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-ugly11.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-ugly11)
	@$(call install_fixup, gst-plugins-ugly11,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-ugly11,SECTION,base)
	@$(call install_fixup, gst-plugins-ugly11,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, gst-plugins-ugly11,DESCRIPTION,missing)

	# install all activated plugins
	@for plugin in $(GST_PLUGINS_UGLY11_ENABLEP-y); do \
		$(call install_copy, gst-plugins-ugly11, 0, 0, 0644, -, \
			/usr/lib/gstreamer-0.11/libgst$${plugin}.so); \
	done

	@$(call install_finish, gst-plugins-ugly11)

	@$(call touch)

# vim: syntax=make
