# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_GOOD) += gst-plugins-good

#
# Paths and names
#
GST_PLUGINS_GOOD_VERSION	:= 0.10.23
GST_PLUGINS_GOOD		:= gst-plugins-good-$(GST_PLUGINS_GOOD_VERSION)
GST_PLUGINS_GOOD_SUFFIX		:= tar.bz2
GST_PLUGINS_GOOD_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-good/$(GST_PLUGINS_GOOD).$(GST_PLUGINS_GOOD_SUFFIX)
GST_PLUGINS_GOOD_SOURCE		:= $(SRCDIR)/$(GST_PLUGINS_GOOD).$(GST_PLUGINS_GOOD_SUFFIX)
GST_PLUGINS_GOOD_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_GOOD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GST_PLUGINS_GOOD_SOURCE):
	@$(call targetinfo)
	@$(call get, GST_PLUGINS_GOOD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_VIDEOFILTER)	+= videofilter
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ALPHA)	+= alpha
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_APETAG)	+= apetag
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AUDIOFX)	+= audiofx
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AUPARSE)	+= auparse
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AUTODETECT)	+= autodetect
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AVI)		+= avi
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_CUTTER)	+= cutter
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_DEBUGUTILS)	+= debugutils
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_DEINTERLACE)	+= deinterlace
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_EFFECTV)	+= effectv
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_EQUALIZER)	+= equalizer
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_FLV)		+= flv
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ID3DEMUX)	+= id3demux
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ICYDEMUX)	+= icydemux
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_INTERLEAVE)	+= interleave
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_FLX)		+= flx
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_GOOM)	+= goom
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_GOOM2K1)	+= goom2k1
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_IMAGEFREEZE)	+= imagefreeze
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_LAW)		+= law
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_LEVEL)	+= level
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_MATROSKA)	+= matroska
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_MONOSCOPE)	+= monoscope
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_MULTIFILE)	+= multifile
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_MULTIPART)	+= multipart
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_QTDEMUX)	+= qtdemux
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_REPLAYGAIN)	+= replaygain
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_RTP)		+= rtp
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_RTPMANAGER)	+= rtpmanager
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_RTSP)	+= rtsp
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SHAPEWIPE)	+= shapewipe
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SMPTE)	+= smpte
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SPECTRUM)	+= spectrum
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_UDP)		+= udp
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_VIDEOBOX)	+= videobox
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_VIDEOCROP)	+= videocrop
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_VIDEOMIXER)	+= videomixer
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_WAVENC)	+= wavenc
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_WAVPARSE)	+= wavparse
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_Y4M)		+= y4m
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_DIRECTSOUND)	+= directsound
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_OSS)		+= oss
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_OSS4)	+= oss4
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SUNAUDIO)	+= sunaudio
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_OSX_AUDIO)	+= osx_audio
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_OSX_VIDEO)	+= osx_video
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_GST_V4L2)	+= gst_v4l2
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_X)		+= x
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_XSHM)	+= xshm
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_XVIDEO)	+= xvideo
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_AALIB)	+= aalib
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ANNODEX)	+= annodex
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_CAIRO)	+= cairo
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ESD)		+= esd
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_FLAC)	+= flac
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_GCONF)	+= gconf
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_GDK_PIXBUF)	+= gdk_pixbuf
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_HAL)		+= hal
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_JPEG)	+= jpeg
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_LIBCACA)	+= libcaca
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_LIBDV)	+= libdv
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_LIBPNG)	+= libpng
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_PULSE)	+= pulse
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_DV1394)	+= dv1394
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SHOUT2)	+= shout2
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SOUP)	+= soup
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_SPEEX)	+= speex
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_TAGLIB)	+= taglib
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_WAVPACK)	+= wavpack
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_ZLIB)	+= zlib
GST_PLUGINS_GOOD_ENABLE-$(PTXCONF_GST_PLUGINS_GOOD_BZ2)		+= bz2

#
# autoconf
#
# --without-libiconv-prefix -> we use libc iconv
#
GST_PLUGINS_GOOD_CONF_TOOL	:= autoconf
GST_PLUGINS_GOOD_CONF_OPT	:= \
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
	--disable-schemas-install \
	--disable-gtk-doc \
	--disable-gconftool \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--disable-esdtest \
	--disable-aalibtest \
	--disable-shout2test

#
# the --with-plugins sadly only applies to depencyless plugings
# and when no plugins are sellected it builds them all. So
# --with-plugins is useless, so we generate a --enable-*
# and --disable-* below
#
ifneq ($(call remove_quotes,$(GST_PLUGINS_GOOD_ENABLE-y)),)
GST_PLUGINS_GOOD_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_GOOD_ENABLE-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_GOOD_ENABLE-)),)
GST_PLUGINS_GOOD_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_GOOD_ENABLE-)))
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-good.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-good)
	@$(call install_fixup, gst-plugins-good,PACKAGE,gst-plugins-good)
	@$(call install_fixup, gst-plugins-good,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-good,VERSION,$(GST_PLUGINS_GOOD_VERSION))
	@$(call install_fixup, gst-plugins-good,SECTION,base)
	@$(call install_fixup, gst-plugins-good,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gst-plugins-good,DEPENDS,)
	@$(call install_fixup, gst-plugins-good,DESCRIPTION,missing)

	# install all activated plugins
	@if [ -d  $(GST_PLUGINS_GOOD_PKGDIR)/usr/lib/gstreamer-0.10/ ]; then \
		cd $(GST_PLUGINS_GOOD_PKGDIR) && for plugin in `find ./usr/lib/gstreamer-0.10/ -name "*.so"`; do \
			$(call install_copy, gst-plugins-good, 0, 0, 0644, -, /$$plugin); \
		done \
	fi

	@$(call install_finish, gst-plugins-good)

	@$(call touch)

# vim: syntax=make
