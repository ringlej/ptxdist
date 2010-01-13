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
GST_PLUGINS_GOOD_VERSION	:= 0.10.14
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

GST_PLUGINS_GOOD_PATH	:= PATH=$(CROSS_PATH)
GST_PLUGINS_GOOD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
# --without-libiconv-prefix -> we use libc iconv
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
	--disable-schemas-install \
	--disable-gtk-doc \
	--disable-gconftool \
	--without-libiconv-prefix

#
# FIXME: what about these? They are built but I don't know which option
# they belong to.
#
#/usr/lib/gstreamer-0.10/libgstnavigationtest.so
#/usr/lib/gstreamer-0.10/libgstmulaw.so
#/usr/lib/gstreamer-0.10/libgstgamma.so

ifdef PTXCONF_GST_PLUGINS_GOOD__VIDEOFILTER
GST_PLUGINS_GOOD_AUTOCONF += --enable-videofilter
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstvideoflip.so \
                             /usr/lib/gstreamer-0.10/libgstgamma.so \
                             /usr/lib/gstreamer-0.10/libgstvideobalance.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-videofilter
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__ALPHA
GST_PLUGINS_GOOD_AUTOCONF += --enable-alpha
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstalphacolor.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-alpha
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__APETAG
GST_PLUGINS_GOOD_AUTOCONF += --enable-apetag
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-apetag
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__AUDIOFX
GST_PLUGINS_GOOD_AUTOCONF += --enable-audiofx
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstaudiofx.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-audiofx
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__AUPARSE
GST_PLUGINS_GOOD_AUTOCONF += --enable-auparse
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstauparse.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-auparse
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__AUTODETECT
GST_PLUGINS_GOOD_AUTOCONF += --enable-autodetect
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-autodetect
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__AVI
GST_PLUGINS_GOOD_AUTOCONF += --enable-avi
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstavi.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-avi
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__CUTTER
GST_PLUGINS_GOOD_AUTOCONF += --enable-cutter
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstcutter.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-cutter
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__DEBUG
GST_PLUGINS_GOOD_AUTOCONF += --enable-debug
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstdebug.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-debug
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__EFFECTV
GST_PLUGINS_GOOD_AUTOCONF += --enable-effectv
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgsteffectv.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-effectv
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__EQUALIZER
GST_PLUGINS_GOOD_AUTOCONF += --enable-equalizer
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstequalizer.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-equalizer
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__ID3DEMUX
GST_PLUGINS_GOOD_AUTOCONF += --enable-id3demux
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-id3demux
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__ICYDEMUX
GST_PLUGINS_GOOD_AUTOCONF += --enable-icydemux
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgsticydemux.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-icydemux
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__INTERLEAVE
GST_PLUGINS_GOOD_AUTOCONF += --enable-interleave
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstinterleave.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-interleave
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__FLX
GST_PLUGINS_GOOD_AUTOCONF += --enable-flx
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstflxdec.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-flx
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__GOOM
GST_PLUGINS_GOOD_AUTOCONF += --enable-goom
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstgoom.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-goom
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__GOOM2K1
GST_PLUGINS_GOOD_AUTOCONF += --enable-goom2k1
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstgoom2k1.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-goom2k1
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__LAW
GST_PLUGINS_GOOD_AUTOCONF += --enable-law
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-law
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__LEVEL
GST_PLUGINS_GOOD_AUTOCONF += --enable-level
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstlevel.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-level
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__MATROSKA
GST_PLUGINS_GOOD_AUTOCONF += --enable-matroska
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstmatroska.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-matroska
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__MONOSCOPE
GST_PLUGINS_GOOD_AUTOCONF += --enable-monoscope
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstmonoscope.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-monoscope
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__MULTIFILE
GST_PLUGINS_GOOD_AUTOCONF += --enable-multifile
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstmultifile.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-multifile
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__MULTIPART
GST_PLUGINS_GOOD_AUTOCONF += --enable-multipart
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstmultipart.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-multipart
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__QTDEMUX
GST_PLUGINS_GOOD_AUTOCONF += --enable-qtdemux
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstqtdemux.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-qtdemux
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__REPLAYGAIN
GST_PLUGINS_GOOD_AUTOCONF += --enable-replaygain
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstreplaygain.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-replaygain
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__RTP
GST_PLUGINS_GOOD_AUTOCONF += --enable-rtp
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstrtp.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-rtp
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__RTSP
GST_PLUGINS_GOOD_AUTOCONF += --enable-rtsp
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstrtsp.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-rtsp
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__SMPTE
GST_PLUGINS_GOOD_AUTOCONF += --enable-smpte
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstsmpte.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-smpte
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__SPECTRUM
GST_PLUGINS_GOOD_AUTOCONF += --enable-spectrum
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstspectrum.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-spectrum
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__UDP
GST_PLUGINS_GOOD_AUTOCONF += --enable-udp
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstudp.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-udp
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__VIDEOBOX
GST_PLUGINS_GOOD_AUTOCONF += --enable-videobox
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstvideobox.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-videobox
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__VIDEOCROP
GST_PLUGINS_GOOD_AUTOCONF += --enable-videocrop
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstvideocrop.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-videocrop
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__VIDEOMIXER
GST_PLUGINS_GOOD_AUTOCONF += --enable-videomixer
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstvideomixer.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-videomixer
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__WAVENC
GST_PLUGINS_GOOD_AUTOCONF += --enable-wavenc
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-wavenc
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__WAVPARSE
GST_PLUGINS_GOOD_AUTOCONF += --enable-wavparse
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstwavparse.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-wavparse
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__DIRECTDRAW
GST_PLUGINS_GOOD_AUTOCONF += --enable-directdraw
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-directdraw
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__DIRECTSOUND
GST_PLUGINS_GOOD_AUTOCONF += --enable-directsound
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-directsound
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__OSS
GST_PLUGINS_GOOD_AUTOCONF += --enable-oss
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-oss
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__SUNAUDIO
GST_PLUGINS_GOOD_AUTOCONF += --enable-sunaudio
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-sunaudio
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__OSX_AUDIO
GST_PLUGINS_GOOD_AUTOCONF += --enable-osx_audio
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-osx_audio
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__OSX_VIDEO
GST_PLUGINS_GOOD_AUTOCONF += --enable-osx_video
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-osx_video
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__V4L2
GST_PLUGINS_GOOD_AUTOCONF += --enable-gst_v4l2
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstvideo4linux2.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-gst_v4l2
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__X
GST_PLUGINS_GOOD_AUTOCONF += --enable-x
#  --x-includes=DIR    X include files are in DIR
#  --x-libraries=DIR   X library files are in DIR
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-x
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__XSHM
GST_PLUGINS_GOOD_AUTOCONF += --enable-xshm
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-xshm
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__XVIDEO
GST_PLUGINS_GOOD_AUTOCONF += --enable-xvideo
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-xvideo
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__AALIB
GST_PLUGINS_GOOD_AUTOCONF += --enable-aalib
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-aalib
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__AALIBTEST
GST_PLUGINS_GOOD_AUTOCONF += --enable-aalibtest
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-aalibtest
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__ANNODEX
GST_PLUGINS_GOOD_AUTOCONF += --enable-annodex
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-annodex
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__CAIRO
GST_PLUGINS_GOOD_AUTOCONF += --enable-cairo
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-cairo
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__CDIO
GST_PLUGINS_GOOD_AUTOCONF += --enable-cdio
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-cdio
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__ESD
GST_PLUGINS_GOOD_AUTOCONF += --enable-esd
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-esd
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__ESDTEST
GST_PLUGINS_GOOD_AUTOCONF += --enable-esdtest
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-esdtest
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__FLAC
GST_PLUGINS_GOOD_AUTOCONF += --enable-flac
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-flac
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__GCONF
GST_PLUGINS_GOOD_AUTOCONF += --enable-gconf
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-gconf
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__GDK_PIXBUF
GST_PLUGINS_GOOD_AUTOCONF += --enable-gdk_pixbuf
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-gdk_pixbuf
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__HAL
GST_PLUGINS_GOOD_AUTOCONF += --enable-hal
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-hal
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__JPEG
GST_PLUGINS_GOOD_AUTOCONF += --enable-jpeg
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstjpeg.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-jpeg
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__LIBCACA
GST_PLUGINS_GOOD_AUTOCONF += --enable-libcaca
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-libcaca
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__LIBDV
GST_PLUGINS_GOOD_AUTOCONF += --enable-libdv
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-libdv
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__LIBPNG
GST_PLUGINS_GOOD_AUTOCONF += --enable-libpng
GST_PLUGINS_GOOD_INSTALL  += /usr/lib/gstreamer-0.10/libgstpng.so
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-libpng
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__PULSE
GST_PLUGINS_GOOD_AUTOCONF += --enable-pulse
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-pulse
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__DV1394
GST_PLUGINS_GOOD_AUTOCONF += --enable-dv1394
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-dv1394
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__SHOUT2
GST_PLUGINS_GOOD_AUTOCONF += --enable-shout2
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-shout2
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__SHOUT2TEST
GST_PLUGINS_GOOD_AUTOCONF += --enable-shout2test
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-shout2test
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__SOUP
GST_PLUGINS_GOOD_AUTOCONF += --enable-soup
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-soup
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__SPEEX
GST_PLUGINS_GOOD_AUTOCONF += --enable-speex
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-speex
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__TAGLIB
GST_PLUGINS_GOOD_AUTOCONF += --enable-taglib
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-taglib
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__WAVPACK
GST_PLUGINS_GOOD_AUTOCONF += --enable-wavpack
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-wavpack
endif
ifdef PTXCONF_GST_PLUGINS_GOOD__ZLIB
GST_PLUGINS_GOOD_AUTOCONF += --enable-zlib
else
GST_PLUGINS_GOOD_AUTOCONF += --disable-zlib
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
	@for i in $(GST_PLUGINS_GOOD_INSTALL); do \
		$(call install_copy, gst-plugins-good, 0, 0, 644, \
			$(PKGDIR)/$(GST_PLUGINS_GOOD)$$i, $$i) \
	done

	@$(call install_finish, gst-plugins-good)

	@$(call touch)

# vim: syntax=make
