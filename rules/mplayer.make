# -*-makefile-*-
#
# Copyright (C) 2005 by Sascha Hauer
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MPLAYER) += mplayer

#
# Paths and names
#
MPLAYER_VERSION	:= 1.0rc4
MPLAYER		:= MPlayer-$(MPLAYER_VERSION)
MPLAYER_SUFFIX	:= tar.bz2
MPLAYER_URL	:= http://www.mplayerhq.hu/MPlayer/releases/$(MPLAYER).$(MPLAYER_SUFFIX)
MPLAYER_SOURCE	:= $(SRCDIR)/$(MPLAYER).$(MPLAYER_SUFFIX)
MPLAYER_DIR	:= $(BUILDDIR)/$(MPLAYER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MPLAYER_SOURCE):
	@$(call targetinfo)
	@$(call get, MPLAYER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MPLAYER_PATH		:= PATH=$(CROSS_PATH)
ifdef PTXCONF_ARCH_X86
MPLAYER_MAKE_ENV	+= CFLAGS='-O2 -fomit-frame-pointer'
endif
#
# autoconf
#
MPLAYER_AUTOCONF := \
	--prefix=/usr \
	--disable-runtime-cpudetection \
	--enable-cross-compile \
	--cc=$(CROSS_CC) \
	--as=$(CROSS_AS) \
	--ar=$(CROSS_AR) \
	--host-cc=$(HOSTCC) \
	--ranlib=$(CROSS_RANLIB) \
	--language=en \
	--target=$(PTXCONF_GNU_TARGET) \
	--extra-cflags='$(CROSS_CPPFLAGS)' \
	--extra-libs='$(CROSS_LDFLAGS)'

ifdef PTXCONF_ICONV
MPLAYER_AUTOCONF += --enable-iconv
else
MPLAYER_AUTOCONF += --disable-iconv
endif

#
# video out
#
MPLAYER_AUTOCONF += \
	--disable-vidix \
	--disable-vidix-pcidb \
	--disable-dhahelper \
	--disable-svgalib_helper \
	--disable-gl \
	--disable-matrixview \
	--disable-dga2 \
	--disable-dga1 \
	--disable-vesa \
	--disable-svga \
	--disable-sdl \
	--disable-kva \
	--disable-aa \
	--disable-caca \
	--disable-ggi \
	--disable-ggiwmh \
	--disable-direct3d \
	--disable-directx \
	--disable-dxr2 \
	--disable-dxr3 \
	--disable-ivtv \
	--disable-v4l2 \
	--disable-dvb \
	--disable-mga \
	--disable-xmga \
	--disable-xvmc \
	--disable-vdpau \
	--disable-vm \
	--disable-xinerama \
	--disable-xshape \
	--disable-xss \
	--disable-mlib \
	--disable-3dfx \
	--disable-tdfxfb \
	--disable-s3fb \
	--disable-wii \
	--disable-directfb \
	--disable-zr \
	--disable-bl \
	--disable-tdfxvid \
	--disable-xvr100 \
	--disable-tga \
	--disable-pnm \
	--disable-md5sum \
	--disable-yuv4mpeg \
	--disable-corevideo \
	--disable-quartz
#
# optional features
#
MPLAYER_AUTOCONF += \
	--disable-mencoder \
	--enable-mplayer \
	--disable-gui \
	--disable-gtk1 \
	--disable-largefiles \
	--disable-termcap \
	--disable-termios \
	--disable-langinfo \
	--disable-lirc \
	--disable-lircc \
	--disable-joystick \
	--disable-apple-remote \
	--disable-apple-ir \
	--disable-vm \
	--disable-xf86keysym \
	--disable-radio \
	--disable-radio-capture \
	--disable-radio-v4l2 \
	--disable-radio-bsdbt848 \
	--disable-tv-bsdbt848 \
	--disable-pvr \
	--disable-rtc \
	--disable-network \
	--disable-winsock2_h \
	--disable-smb \
	--disable-live \
	--disable-nemesi \
	--disable-librtmp \
	--disable-vcd \
	--disable-bluray \
	--disable-dvdnav \
	--disable-dvdread \
	--disable-dvdread-internal \
	--disable-libdvdcss-internal \
	--disable-cdparanoia \
	--disable-cddb \
	--disable-freetype \
	--disable-fontconfig \
	--disable-unrarexec \
	--disable-menu \
	--disable-sortsub \
	--disable-fribidi \
	--disable-enca \
	--disable-maemo \
	--disable-macosx-finder \
	--disable-macosx-bundle \
	--disable-inet6 \
	--disable-gethostbyname2 \
	--disable-ftp \
	--disable-vstream \
	--disable-w32threads \
	--disable-ass-internal \
	--disable-ass \
	--disable-rpath

#	--disable-bitmap-font \

#
# codecs
#
MPLAYER_AUTOCONF += \
	--disable-gif \
	--disable-png \
	--disable-mng \
	--disable-libcdio \
	--disable-liblzo \
	--disable-win32dll \
	--disable-qtx \
	--disable-xanim \
	--disable-real \
	--disable-xvid \
	--disable-xvid-lavc \
	--disable-x264 \
	--disable-x264-lavc \
	--disable-libdirac-lavc \
	--disable-libschroedinger-lavc \
	--disable-libvpx-lavc \
	--disable-libnut \
	--disable-libpostproc_a \
	--disable-libpostproc_so \
	--disable-tremor-internal \
	--disable-tremor-low \
	--disable-tremor \
	--disable-libvorbis \
	--disable-speex \
	--disable-libgsm \
	--disable-theora \
	--disable-faad \
	--disable-faad-internal \
	--disable-faad-fixed \
	--disable-faac \
	--disable-faac-lavc \
	--disable-ladspa \
	--disable-libbs2b \
	--disable-libdv \
	--disable-mpg123 \
	--disable-mad \
	--disable-mp3lame \
	--disable-mp3lame-lavc \
	--disable-toolame \
	--disable-twolame \
	--disable-xmms \
	--disable-libdca \
	--disable-mp3lib \
	--disable-liba52 \
	--disable-musepack \
	--disable-libopencore_amrnb \
	--disable-libopencore_amrwb \
	--disable-libopenjpeg

#	--disable-libavutil_a \
#	--disable-libavcodec_a \
#	--disable-libavformat_a \
#	--disable-libswscale_a \
#	--disable-libavutil_so \
#	--disable-libavcodec_so \
#	--disable-libavformat_so \
#	--disable-libswscale_so \
#	--disable-libavcodec_mpegaudio_hp \

#
# audio
#
MPLAYER_AUTOCONF += \
	--disable-alsa \
	--disable-ossaudio \
	--disable-arts \
	--disable-esd \
	--disable-pulse \
	--disable-jack \
	--disable-openal \
	--disable-nas \
	--disable-sgiaudio \
	--disable-sunaudio \
	--disable-kai \
	--disable-dart \
	--disable-win32waveout \
	--disable-coreaudio \
	--disable-select

#
# Advanced options:
#
MPLAYER_AUTOCONF += \
	--disable-mmx \
	--disable-mmxext \
	--disable-3dnow \
	--disable-3dnowext \
	--disable-sse \
	--disable-sse2 \
	--disable-ssse3 \
	--disable-shm \
	--disable-altivec \
	--disable-armv5te \
	--disable-armv6t2 \
	--disable-armvfp \
	--disable-neon \
	--disable-fastmemcpy \
	--disable-hardcoded-tables \
	--disable-big-endian \
	--disable-debug \
	--disable-profile \
	--disable-sighandler \
	--disable-crash-debug \
	--disable-dynamic-plugins

#Use these options if autodetection fails:
#  --extra-cflags=FLAGS        extra CFLAGS
#  --extra-ldflags=FLAGS       extra LDFLAGS
#  --extra-libs=FLAGS          extra linker flags
#  --extra-libs-mplayer=FLAGS  extra linker flags for MPlayer
#  --extra-libs-mencoder=FLAGS extra linker flags for MEncoder
#  --with-xvmclib=NAME         adapter-specific library name (e.g. XvMCNVIDIA)
#
#  --with-freetype-config=PATH path to freetype-config
#  --with-glib-config=PATH     path to glib*-config
#  --with-gtk-config=PATH      path to gtk*-config
#  --with-sdl-config=PATH      path to sdl*-config
#  --with-dvdnav-config=PATH   path to dvdnav-config
#  --with-dvdread-config=PATH  path to dvdread-config

#
# Configurable Video Inputs
#

ifdef PTXCONF_MPLAYER_VI_V4L1
MPLAYER_AUTOCONF += --enable-tv-v4l1
else
MPLAYER_AUTOCONF += --disable-tv-v4l1
endif

ifdef PTXCONF_MPLAYER_VI_V4L2
MPLAYER_AUTOCONF += --enable-tv-v4l2
else
MPLAYER_AUTOCONF += --disable-tv-v4l2
endif

#
# Configurable Video Outputs
#

ifdef PTXCONF_MPLAYER_VO_XV
MPLAYER_AUTOCONF += --enable-xv
else
MPLAYER_AUTOCONF += --disable-xv
endif

ifdef PTXCONF_MPLAYER_VO_X11
MPLAYER_AUTOCONF += --enable-x11
else
MPLAYER_AUTOCONF += --disable-x11
endif

ifdef PTXCONF_MPLAYER_VO_FBDEV
MPLAYER_AUTOCONF += --enable-fbdev
else
MPLAYER_AUTOCONF += --disable-fbdev
endif

# enable tv and pthreads if any of the tv options are on
ifeq ($(or $(PTXCONF_MPLAYER_VI_V4L1),$(PTXCONF_MPLAYER_VI_V4L2)),)
MPLAYER_AUTOCONF += --disable-tv --disable-pthreads
else
# Don't enable pthread explicitly. The correct library will not be detected
MPLAYER_AUTOCONF += --enable-tv
endif


#
# Configurable Codecs
#
ifdef PTXCONF_MPLAYER_CODEC_JPEG
MPLAYER_AUTOCONF += --enable-jpeg
else
MPLAYER_AUTOCONF += --disable-jpeg
endif

ifdef PTXCONF_MPLAYER_CODEC_MPEG2
MPLAYER_AUTOCONF += --enable-libmpeg2 --enable-libmpeg2-internal
else
MPLAYER_AUTOCONF += --disable-libmpeg2 --disable-libmpeg2-internal
endif

#
# Advanced Options
#
ifdef PTXCONF_MPLAYER_IWMMXT
MPLAYER_AUTOCONF += --enable-iwmmxt
else
MPLAYER_AUTOCONF += --disable-iwmmxt
endif

ifdef PTXCONF_ARCH_ARM_V6
MPLAYER_AUTOCONF += --enable-armv6
else
MPLAYER_AUTOCONF += --disable-armv6
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mplayer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mplayer)
	@$(call install_fixup, mplayer,PRIORITY,optional)
	@$(call install_fixup, mplayer,SECTION,base)
	@$(call install_fixup, mplayer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mplayer,DESCRIPTION,missing)

	@$(call install_copy, mplayer, 0, 0, 0755, -, /usr/bin/mplayer)

	@$(call install_finish, mplayer)

	@$(call touch)

# vim: syntax=make
