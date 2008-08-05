# -*-makefile-*-
# $Id: template-make 8509 2008-06-12 12:45:40Z mkl $
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
GST_PLUGINS_GOOD_VERSION	:= 0.10.9
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
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-good.extract:
	@$(call targetinfo)
	@$(call clean, $(GST_PLUGINS_GOOD_DIR))
	@$(call extract, GST_PLUGINS_GOOD)
	@$(call patchin, GST_PLUGINS_GOOD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_GOOD_PATH	:= PATH=$(CROSS_PATH)
GST_PLUGINS_GOOD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GST_PLUGINS_GOOD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-rpath \
	--disable-nls \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	--enable-external \
	--enable-experimental \
	--enable-schemas-install \
	--disable-gtk-doc \
	--disable-gconf-tool \

ifdef GST_PLUGINS_GOOD__VIDEOFILTER
GST_PLUGINS_GOOD_AUTOCONF += --enable-videofilter
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-videofilter
endif
ifdef GST_PLUGINS_GOOD__ALPHA
GST_PLUGINS_GOOD_AUTOCONF += --enable-alpha
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-alpha
endif
ifdef GST_PLUGINS_GOOD__APETAG
GST_PLUGINS_GOOD_AUTOCONF += --enable-apetag
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-apetag
endif
ifdef GST_PLUGINS_GOOD__AUDIOFX
GST_PLUGINS_GOOD_AUTOCONF += --enable-audiofx
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-audiofx
endif
ifdef GST_PLUGINS_GOOD__AUPARSE
GST_PLUGINS_GOOD_AUTOCONF += --enable-auparse
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-auparse
endif
ifdef GST_PLUGINS_GOOD__AUTODETECT
GST_PLUGINS_GOOD_AUTOCONF += --enable-autodetect
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-autodetect
endif
ifdef GST_PLUGINS_GOOD__AVI
GST_PLUGINS_GOOD_AUTOCONF += --enable-avi
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-avi
endif
ifdef GST_PLUGINS_GOOD__CUTTER
GST_PLUGINS_GOOD_AUTOCONF += --enable-cutter
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-cutter
endif
ifdef GST_PLUGINS_GOOD__DEBUG
GST_PLUGINS_GOOD_AUTOCONF += --enable-debug
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-debug
endif
ifdef GST_PLUGINS_GOOD__EFFECTV
GST_PLUGINS_GOOD_AUTOCONF += --enable-effectv
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-effectv
endif
ifdef GST_PLUGINS_GOOD__EQUALIZER
GST_PLUGINS_GOOD_AUTOCONF += --enable-equalizer
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-equalizer
endif
ifdef GST_PLUGINS_GOOD__ID3DEMUX
GST_PLUGINS_GOOD_AUTOCONF += --enable-id3demux
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-id3demux
endif
ifdef GST_PLUGINS_GOOD__ICYDEMUX
GST_PLUGINS_GOOD_AUTOCONF += --enable-icydemux
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-icydemux
endif
ifdef GST_PLUGINS_GOOD__INTERLEAVE
GST_PLUGINS_GOOD_AUTOCONF += --enable-interleave
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-interleave
endif
ifdef GST_PLUGINS_GOOD__FLX
GST_PLUGINS_GOOD_AUTOCONF += --enable-flx
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-flx
endif
ifdef GST_PLUGINS_GOOD__GOOM
GST_PLUGINS_GOOD_AUTOCONF += --enable-goom
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-goom
endif
ifdef GST_PLUGINS_GOOD__GOOM2K1
GST_PLUGINS_GOOD_AUTOCONF += --enable-goom2k1
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-goom2k1
endif
ifdef GST_PLUGINS_GOOD__LAW
GST_PLUGINS_GOOD_AUTOCONF += --enable-law
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-law
endif
ifdef GST_PLUGINS_GOOD__LEVEL
GST_PLUGINS_GOOD_AUTOCONF += --enable-level
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-level
endif
ifdef GST_PLUGINS_GOOD__MATROSKA
GST_PLUGINS_GOOD_AUTOCONF += --enable-matroska
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-matroska
endif
ifdef GST_PLUGINS_GOOD__MONOSCOPE
GST_PLUGINS_GOOD_AUTOCONF += --enable-monoscope
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-monoscope
endif
ifdef GST_PLUGINS_GOOD__MULTIFILE
GST_PLUGINS_GOOD_AUTOCONF += --enable-multifile
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-multifile
endif
ifdef GST_PLUGINS_GOOD__MULTIPART
GST_PLUGINS_GOOD_AUTOCONF += --enable-multipart
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-multipart
endif
ifdef GST_PLUGINS_GOOD__QTDEMUX
GST_PLUGINS_GOOD_AUTOCONF += --enable-qtdemux
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-qtdemux
endif
ifdef GST_PLUGINS_GOOD__REPLAYGAIN
GST_PLUGINS_GOOD_AUTOCONF += --enable-replaygain
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-replaygain
endif
ifdef GST_PLUGINS_GOOD__RTP
GST_PLUGINS_GOOD_AUTOCONF += --enable-rtp
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-rtp
endif
ifdef GST_PLUGINS_GOOD__RTSP
GST_PLUGINS_GOOD_AUTOCONF += --enable-rtsp
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-rtsp
endif
ifdef GST_PLUGINS_GOOD__SMPTE
GST_PLUGINS_GOOD_AUTOCONF += --enable-smpte
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-smpte
endif
ifdef GST_PLUGINS_GOOD__SPECTRUM
GST_PLUGINS_GOOD_AUTOCONF += --enable-spectrum
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-spectrum
endif
ifdef GST_PLUGINS_GOOD__UDP
GST_PLUGINS_GOOD_AUTOCONF += --enable-udp
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-udp
endif
ifdef GST_PLUGINS_GOOD__VIDEOBOX
GST_PLUGINS_GOOD_AUTOCONF += --enable-videobox
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-videobox
endif
ifdef GST_PLUGINS_GOOD__VIDEOCROP
GST_PLUGINS_GOOD_AUTOCONF += --enable-videocrop
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-videocrop
endif
ifdef GST_PLUGINS_GOOD__VIDEOMIXER
GST_PLUGINS_GOOD_AUTOCONF += --enable-videomixer
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-videomixer
endif
ifdef GST_PLUGINS_GOOD__WAVENC
GST_PLUGINS_GOOD_AUTOCONF += --enable-wavenc
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-wavenc
endif
ifdef GST_PLUGINS_GOOD__WAVPARSE
GST_PLUGINS_GOOD_AUTOCONF += --enable-wavparse
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-wavparse
endif
ifdef GST_PLUGINS_GOOD__DIRECTDRAW
GST_PLUGINS_GOOD_AUTOCONF += --enable-directdraw
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-directdraw
endif
ifdef GST_PLUGINS_GOOD__DIRECTSOUND
GST_PLUGINS_GOOD_AUTOCONF += --enable-directsound
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-directsound
endif
ifdef GST_PLUGINS_GOOD__OSS
GST_PLUGINS_GOOD_AUTOCONF += --enable-oss
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-oss
endif
ifdef GST_PLUGINS_GOOD__SUNAUDIO
GST_PLUGINS_GOOD_AUTOCONF += --enable-sunaudio
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-sunaudio
endif
ifdef GST_PLUGINS_GOOD__OSX_AUDIO
GST_PLUGINS_GOOD_AUTOCONF += --enable-osx_audio
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-osx_audio
endif
ifdef GST_PLUGINS_GOOD__OSX_VIDEO
GST_PLUGINS_GOOD_AUTOCONF += --enable-osx_video
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-osx_video
endif
ifdef GST_PLUGINS_GOOD__V4L2
GST_PLUGINS_GOOD_AUTOCONF += --enable-v4l2
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-v4l2
endif
ifdef GST_PLUGINS_GOOD__X
GST_PLUGINS_GOOD_AUTOCONF += --enable-x
#  --x-includes=DIR    X include files are in DIR
#  --x-libraries=DIR   X library files are in DIR
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-x
endif
ifdef GST_PLUGINS_GOOD__XSHM
GST_PLUGINS_GOOD_AUTOCONF += --enable-xshm
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-xshm
endif
ifdef GST_PLUGINS_GOOD__XVIDEO
GST_PLUGINS_GOOD_AUTOCONF += --enable-xvideo
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-xvideo
endif
ifdef GST_PLUGINS_GOOD__AALIB
GST_PLUGINS_GOOD_AUTOCONF += --enable-aalib
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-aalib
endif
ifdef GST_PLUGINS_GOOD__AALIBTEST
GST_PLUGINS_GOOD_AUTOCONF += --enable-aalibtest
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-aalibtest
endif
ifdef GST_PLUGINS_GOOD__ANNODEX
GST_PLUGINS_GOOD_AUTOCONF += --enable-annodex
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-annodex
endif
ifdef GST_PLUGINS_GOOD__CAIRO
GST_PLUGINS_GOOD_AUTOCONF += --enable-cairo
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-cairo
endif
ifdef GST_PLUGINS_GOOD__CDIO
GST_PLUGINS_GOOD_AUTOCONF += --enable-cdio
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-cdio
endif
ifdef GST_PLUGINS_GOOD__ESD
GST_PLUGINS_GOOD_AUTOCONF += --enable-esd
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-esd
endif
ifdef GST_PLUGINS_GOOD__ESDTEST
GST_PLUGINS_GOOD_AUTOCONF += --enable-esdtest
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-esdtest
endif
ifdef GST_PLUGINS_GOOD__FLAC
GST_PLUGINS_GOOD_AUTOCONF += --enable-flac
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-flac
endif
ifdef GST_PLUGINS_GOOD__GCONF
GST_PLUGINS_GOOD_AUTOCONF += --enable-gconf
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-gconf
endif
ifdef GST_PLUGINS_GOOD__GDK_PIXBUF
GST_PLUGINS_GOOD_AUTOCONF += --enable-gdk_pixbuf
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-gdk_pixbuf
endif
ifdef GST_PLUGINS_GOOD__HAL
GST_PLUGINS_GOOD_AUTOCONF += --enable-hal
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-hal
endif
ifdef GST_PLUGINS_GOOD__JPEG
GST_PLUGINS_GOOD_AUTOCONF += --enable-jpeg
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-jpeg
endif
ifdef GST_PLUGINS_GOOD__LIBCACA
GST_PLUGINS_GOOD_AUTOCONF += --enable-libcaca
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-libcaca
endif
ifdef GST_PLUGINS_GOOD__LIBDV
GST_PLUGINS_GOOD_AUTOCONF += --enable-libdv
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-libdv
endif
ifdef GST_PLUGINS_GOOD__LIBPNG
GST_PLUGINS_GOOD_AUTOCONF += --enable-libpng
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-libpng
endif
ifdef GST_PLUGINS_GOOD__PULSE
GST_PLUGINS_GOOD_AUTOCONF += --enable-pulse
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-pulse
endif
ifdef GST_PLUGINS_GOOD__DV1394
GST_PLUGINS_GOOD_AUTOCONF += --enable-dv1394
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-dv1394
endif
ifdef GST_PLUGINS_GOOD__SHOUT2
GST_PLUGINS_GOOD_AUTOCONF += --enable-shout2
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-shout2
endif
ifdef GST_PLUGINS_GOOD__SHOUT2TEST
GST_PLUGINS_GOOD_AUTOCONF += --enable-shout2test
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-shout2test
endif
ifdef GST_PLUGINS_GOOD__SOUP
GST_PLUGINS_GOOD_AUTOCONF += --enable-soup
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-soup
endif
ifdef GST_PLUGINS_GOOD__SPEEX
GST_PLUGINS_GOOD_AUTOCONF += --enable-speex
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-speex
endif
ifdef GST_PLUGINS_GOOD__TAGLIB
GST_PLUGINS_GOOD_AUTOCONF += --enable-taglib
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-taglib
endif
ifdef GST_PLUGINS_GOOD__WAVPACK
GST_PLUGINS_GOOD_AUTOCONF += --enable-wavpack
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-wavpack
endif
ifdef GST_PLUGINS_GOOD__ZLIB
GST_PLUGINS_GOOD_AUTOCONF += --enable-zlib
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-zlib
endif

$(STATEDIR)/gst-plugins-good.prepare:
	@$(call targetinfo)
	@$(call clean, $(GST_PLUGINS_GOOD_DIR)/config.cache)
	cd $(GST_PLUGINS_GOOD_DIR) && \
		$(GST_PLUGINS_GOOD_PATH) $(GST_PLUGINS_GOOD_ENV) \
		./configure $(GST_PLUGINS_GOOD_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-good.compile:
	@$(call targetinfo)
	cd $(GST_PLUGINS_GOOD_DIR) && $(GST_PLUGINS_GOOD_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-good.install:
	@$(call targetinfo)
	@$(call install, GST_PLUGINS_GOOD)
	@$(call touch)

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
	@$(call install_fixup, gst-plugins-good,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gst-plugins-good,DEPENDS,)
	@$(call install_fixup, gst-plugins-good,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-good, 0, 0, 0755, $(GST_PLUGINS_GOOD_DIR)/foobar, /dev/null)

	@$(call install_finish, gst-plugins-good)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gst-plugins-good_clean:
	rm -rf $(STATEDIR)/gst-plugins-good.*
	rm -rf $(PKGDIR)/gst-plugins-good_*
	rm -rf $(GST_PLUGINS_GOOD_DIR)

# vim: syntax=make
