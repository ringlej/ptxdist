# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
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
PACKAGES-$(PTXCONF_GST_PLUGINS_BAD1) += gst-plugins-bad1

#
# Paths and names
#
GST_PLUGINS_BAD1_VERSION	:= 1.0.8
GST_PLUGINS_BAD1_MD5		:= a2fdf125ee2ae46047dcbcfc305949ee
GST_PLUGINS_BAD1		:= gst-plugins-bad-$(GST_PLUGINS_BAD1_VERSION)
GST_PLUGINS_BAD1_SUFFIX		:= tar.xz
GST_PLUGINS_BAD1_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-bad/$(GST_PLUGINS_BAD1).$(GST_PLUGINS_BAD1_SUFFIX)
GST_PLUGINS_BAD1_SOURCE		:= $(SRCDIR)/$(GST_PLUGINS_BAD1).$(GST_PLUGINS_BAD1_SUFFIX)
GST_PLUGINS_BAD1_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_BAD1)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ADPCMDEC)		+= adpcmdec
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ADPCMENC)		+= adpcmenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AIFF)		+= aiff
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ASFMUX)		+= asfmux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AUDIOVISUALIZERS)	+= audiovisualizers
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AUTOCONVERT)		+= autoconvert
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_BAYER)		+= bayer
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_CAMERABIN2)		+= camerabin2
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_CDXAPARSE)		+= cdxaparse
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_COLOREFFECTS)	+= coloreffects
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DATAURISRC)		+= dataurisrc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DCCP)		+= dccp
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_DEBUGUTILS)		+= debugutils
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_DEBUGUTILS)		+= debugutilsbad
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DTMF)		+= dtmf
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DVBSUBOVERLAY)	+= dvbsuboverlay
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DVDSPU)		+= dvdspu
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FACEOVERLAY)		+= faceoverlay
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FESTIVAL)		+= festival
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FIELDANALYSIS)	+= fieldanalysis
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FREEVERB)		+= freeverb
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FREI0R)		+= frei0r
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GAUDIEFFECTS)	+= gaudieffects
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GEOMETRICTRANSFORM)	+= geometrictransform
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GDP)			+= gdp
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_HDVPARSE)		+= hdvparse
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_HLS)		+= hls
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_HLS)		+= fragmented
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ID3TAG)		+= id3tag
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_INTER)		+= inter
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_INTERLACE)		+= interlace
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_IVFPARSE)		+= ivfparse
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_JP2KDECIMATOR)	+= jp2kdecimator
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_JPEGFORMAT)		+= jpegformat
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_LIBRFB)		+= librfb
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_LIBRFB)		+= rfbsrc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_LIVEADDER)		+= liveadder
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_MPEGDEMUX)		+= mpegdemux
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_MPEGDEMUX)		+= mpegpsdemux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPEGTSDEMUX)		+= mpegtsdemux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPEGTSMUX)		+= mpegtsmux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPEGPSMUX)		+= mpegpsmux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MVE)			+= mve
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MXF)			+= mxf
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_NSF)			+= nsf
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_NUVDEMUX)		+= nuvdemux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_PATCHDETECT)		+= patchdetect
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_PCAPPARSE)		+= pcapparse
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_PNM)			+= pnm
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RAWPARSE)		+= rawparse
# real plugin cannot be built on arch != x86
ifdef PTXCONF_ARCH_X86
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_REAL)		+= real
endif
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_REMOVESILENCE)	+= removesilence
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RTPMUX)		+= rtpmux
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RTPVP8)		+= rtpvp8
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_SCALETEMPO)		+= scaletempo
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_SCALETEMPO)		+= scaletempoplugin
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SDI)			+= sdi
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_SDP)		+= sdp
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_SDP)		+= sdpelem
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SEGMENTCLIP)		+= segmentclip
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SIREN)		+= siren
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SMOOTH)		+= smooth
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SPEED)		+= speed
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SUBENC)		+= subenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_STEREO)		+= stereo
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_TTA)			+= tta
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOFILTERS)	+= videofilters
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOMEASURE)	+= videomeasure
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOPARSERS)	+= videoparsers
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOPARSERS)	+= videoparsersbad
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VIDEOSIGNAL)		+= videosignal
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VMNC)		+= vmnc
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_Y4M)		+= y4m
GST_PLUGINS_BAD1_ENABLED-$(PTXCONF_GST_PLUGINS_BAD1_Y4M)		+= y4mdec
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_AVC)			+= avc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SHM)			+= shm
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_VCD)		+= vcd
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_VCD)		+= vcdsrc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENSLES)		+= opensles
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_uvch264)		+= uvch264
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ASSRENDER)		+= assrender
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VOAMRWBENC)		+= voamrwbenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VOAACENC)		+= voaacenc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_APEXSINK)		+= apexsink
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_BZ2)			+= bz2
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_CDAUDIO)		+= cdaudio
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_CELT)		+= celt
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_CHROMAPRINT)		+= chromaprint
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_COG)			+= cog
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_CURL)		+= curl
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DC1394)		+= dc1394
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DECKLINK)		+= decklink
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_DIRECTFB)		+= directfb
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_DIRECTFB)		+= dfbvideosink
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_WAYLAND)		+= wayland
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_WAYLAND)		+= waylandsink
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DIRAC)		+= dirac
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DTS)			+= dts
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RESINDVD)		+= resindvd
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FAAC)		+= faac
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FAAD)		+= faad
GST_PLUGINS_BAD1_ENABLEC-$(PTXCONF_GST_PLUGINS_BAD1_FBDEV)		+= fbdev
GST_PLUGINS_BAD1_ENABLEP-$(PTXCONF_GST_PLUGINS_BAD1_FBDEV)		+= fbdevsink
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_FLITE)		+= flite
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GSM)			+= gsm
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_JASPER)		+= jasper
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_KATE)		+= kate
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_LADSPA)		+= ladspa
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_LV2)			+= lv2
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_LIBMMS)		+= libmms
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_LINSYS)		+= linsys
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MODPLUG)		+= modplug
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MIMIC)		+= mimic
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPEG2ENC)		+= mpeg2enc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPG123)		+= mpg123
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MPLEX)		+= mplex
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MUSEPACK)		+= musepack
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MUSICBRAINZ)		+= musicbrainz
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_MYTHTV)		+= mythtv
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_NAS)			+= nas
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_NEON)		+= neon
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OFA)			+= ofa
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENAL)		+= openal
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPENCV)		+= opencv
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_OPUS)		+= opus
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_PVR)			+= pvr
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RSVG)		+= rsvg
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_EGLGLES)		+= eglgles
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_TIMIDITY)		+= timidity
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_TELETEXTDEC)		+= teletextdec
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_WILDMIDI)		+= wildmidi
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SDL)			+= sdl
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SNDFILE)		+= sndfile
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SOUNDTOUCH)		+= soundtouch
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SPC)			+= spc
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GME)			+= gme
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SWFDEC)		+= swfdec
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_XVID)		+= xvid
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_DVB)			+= dvb
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_WININET)		+= wininet
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ACM)			+= acm
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_VDPAU)		+= vdpau
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SCHRO)		+= schro
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_ZBAR)		+= zbar
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_RTMP)		+= rtmp
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SPANDSP)		+= spandsp
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_GSETTINGS)		+= gsettings
GST_PLUGINS_BAD1_ENABLE-$(PTXCONF_GST_PLUGINS_BAD1_SNDIO)		+= sndio

GST_PLUGINS_BAD1_ENABLEC-y	+= $(GST_PLUGINS_BAD1_ENABLE-y)
GST_PLUGINS_BAD1_ENABLEC-	+= $(GST_PLUGINS_BAD1_ENABLE-)
GST_PLUGINS_BAD1_ENABLEP-y	+= $(GST_PLUGINS_BAD1_ENABLE-y)

#
# autoconf
#
GST_PLUGINS_BAD1_CONF_TOOL	:= autoconf

GST_PLUGINS_BAD1_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER_GENERIC_CONF_OPT) \
	--enable-external \
	--enable-experimental \
	\
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BAD1_ORC)-orc \
	\
	--disable-directsound \
	--disable-direct3d \
	--disable-directdraw \
	--disable-direct3d9 \
	--disable-directshow \
	--disable-android_media \
	--disable-apple_media \
	--disable-osx_video \
	--disable-quicktime \
	--disable-sdltest \
	--disable-schemas-compile

ifneq ($(call remove_quotes,$(GST_PLUGINS_BAD1_ENABLEC-y)),)
GST_PLUGINS_BAD1_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_BAD1_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_BAD1_ENABLEC-)),)
GST_PLUGINS_BAD1_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_BAD1_ENABLEC-)))
endif

#  --enable-gobject-cast-checks=[no/auto/yes] Enable GObject cast checks


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-bad1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-bad1)
	@$(call install_fixup, gst-plugins-bad1,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-bad1,SECTION,base)
	@$(call install_fixup, gst-plugins-bad1,AUTHOR,"Sascha Hauer")
	@$(call install_fixup, gst-plugins-bad1,DESCRIPTION,missing)

	# install all activated libs
	@cd $(GST_PLUGINS_BAD1_PKGDIR)/usr/lib/ && \
	for libs in `find -name "*-1.0.so" -printf '%f\n'`; do \
		$(call install_lib, gst-plugins-bad1, 0, 0, 0644, $${libs%.so}); \
	done

	# install all activated plugins
	@for plugin in $(GST_PLUGINS_BAD1_ENABLEP-y); do \
		$(call install_copy, gst-plugins-bad1, 0, 0, 0644, -, \
			/usr/lib/gstreamer-1.0/libgst$${plugin}.so); \
	done

	@$(call install_finish, gst-plugins-bad1)

	@$(call touch)

# vim: syntax=make
