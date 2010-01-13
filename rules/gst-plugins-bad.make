# -*-makefile-*-
#
# Copyright (C) 2008 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_BAD) += gst-plugins-bad

#
# Paths and names
#
GST_PLUGINS_BAD_VERSION	:= 0.10.10
GST_PLUGINS_BAD		:= gst-plugins-bad-$(GST_PLUGINS_BAD_VERSION)
GST_PLUGINS_BAD_SUFFIX	:= tar.bz2
GST_PLUGINS_BAD_URL	:= http://gstreamer.freedesktop.org/src/gst-plugins-bad/$(GST_PLUGINS_BAD).$(GST_PLUGINS_BAD_SUFFIX)
GST_PLUGINS_BAD_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_BAD).$(GST_PLUGINS_BAD_SUFFIX)
GST_PLUGINS_BAD_DIR	:= $(BUILDDIR)/$(GST_PLUGINS_BAD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GST_PLUGINS_BAD_SOURCE):
	@$(call targetinfo)
	@$(call get, GST_PLUGINS_BAD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_BAD_PATH	:= PATH=$(CROSS_PATH)
GST_PLUGINS_BAD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GST_PLUGINS_BAD_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-examples \
	--disable-quicktime \
	--disable-vcd \
	--disable-alsa \
	--disable-amrwb \
	--disable-bz2 \
	--disable-cdaudio \
	--disable-dc1394 \
	--disable-directfb \
	--disable-dirac \
	--disable-dts \
	--disable-divx \
	--disable-dvdnav \
	--disable-metadata \
	--disable-faac \
	--disable-faad \
	--disable-gsm \
	--disable-ivorbis \
	--disable-jack \
	--disable-ladspa \
	--disable-libmms \
	--disable-mpeg2enc \
	--disable-mplex \
	--disable-musepack \
	--disable-musicbrainz \
	--disable-mythtv \
	--disable-nas \
	--disable-neon \
	--disable-ofa \
	--disable-timidity \
	--disable-wildmidi \
	--disable-sdl \
	--disable-sdltest \
	--disable-sndfile \
	--disable-soundtouch \
	--disable-spc \
	--disable-swfdec \
	--disable-theoradec \
	--disable-x264 \
	--disable-xvid \
	--disable-dvb \
	--disable-oss4 \
	--disable-wininet

ifdef PTXCONF_GST_PLUGINS_BAD__FBDEVSINK
GST_PLUGINS_BAD_AUTOCONF += --enable-fbdev
GST_PLUGINS_BAD_INSTALL  += /usr/lib/gstreamer-0.10/libgstfbdevsink.so
else
GST_PLUGINS_BADD_AUTOCONF += --disable-fbdev
endif

ifdef PTXCONF_GST_PLUGINS_BAD__BAYER
GST_PLUGINS_BAD_AUTOCONF += --enable-bayer
GST_PLUGINS_BAD_INSTALL  += /usr/lib/gstreamer-0.10/libgstbayer.so
else
GST_PLUGINS_BADD_AUTOCONF += --disable-bayer
endif

ifdef PTXCONF_GST_PLUGINS_BAD__MPEG4VIDEOPARSE
GST_PLUGINS_BAD_AUTOCONF += --enable-mpeg4videoparse
GST_PLUGINS_BAD_INSTALL  += /usr/lib/gstreamer-0.10/libgstmpeg4videoparse.so
else
GST_PLUGINS_BADD_AUTOCONF += --disable-mpeg4videoparse
endif

ifdef PTXCONF_GST_PLUGINS_BAD__H264PARSE
GST_PLUGINS_BAD_AUTOCONF += --enable-h264parse
GST_PLUGINS_BAD_INSTALL  += /usr/lib/gstreamer-0.10/libgsth264parse.so
else
GST_PLUGINS_BADD_AUTOCONF += --disable-h264parse
endif

ifdef PTXCONF_GST_PLUGINS_BAD__MPEGDEMUX
GST_PLUGINS_BAD_AUTOCONF += --enable-mpegdemux
GST_PLUGINS_BAD_INSTALL  += /usr/lib/gstreamer-0.10/libgstmpegdemux.so
else
GST_PLUGINS_BADD_AUTOCONF += --disable-mpegdemux
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-bad.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-bad)
	@$(call install_fixup, gst-plugins-bad,PACKAGE,gst-plugins-bad)
	@$(call install_fixup, gst-plugins-bad,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-bad,VERSION,$(GST_PLUGINS_BAD_VERSION))
	@$(call install_fixup, gst-plugins-bad,SECTION,base)
	@$(call install_fixup, gst-plugins-bad,AUTHOR,"Sascha Hauer")
	@$(call install_fixup, gst-plugins-bad,DEPENDS,)
	@$(call install_fixup, gst-plugins-bad,DESCRIPTION,missing)

	# install all activated plugins
	@for i in $(GST_PLUGINS_BAD_INSTALL); do \
		$(call install_copy, gst-plugins-bad, 0, 0, 644, \
			$(PKGDIR)/$(GST_PLUGINS_BAD)$$i, $$i) \
	done

	@$(call install_finish, gst-plugins-bad)

	@$(call touch)

# vim: syntax=make
