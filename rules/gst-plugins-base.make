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
PACKAGES-$(PTXCONF_GST_PLUGINS_BASE) += gst-plugins-base

#
# Paths and names
#
GST_PLUGINS_BASE_VERSION	:= 0.10.22
GST_PLUGINS_BASE		:= gst-plugins-base-$(GST_PLUGINS_BASE_VERSION)
GST_PLUGINS_BASE_SUFFIX		:= tar.bz2
GST_PLUGINS_BASE_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-base/$(GST_PLUGINS_BASE).$(GST_PLUGINS_BASE_SUFFIX)
GST_PLUGINS_BASE_SOURCE		:= $(SRCDIR)/$(GST_PLUGINS_BASE).$(GST_PLUGINS_BASE_SUFFIX)
GST_PLUGINS_BASE_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_BASE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GST_PLUGINS_BASE_SOURCE):
	@$(call targetinfo)
	@$(call get, GST_PLUGINS_BASE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_BASE_PATH	:= PATH=$(CROSS_PATH)
GST_PLUGINS_BASE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GST_PLUGINS_BASE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-rpath \
	--disable-nls \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	--disable-largefile \
	--disable-gtk-doc \
	--enable-external \
	--disable-experimental \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-freetypetest \
	--without-libiconv-prefix \
	--without-libintl-prefix

# --with-plugins=foo,bar,baz

ifdef PTXCONF_GST_PLUGINS_BASE_ADDER
GST_PLUGINS_BASE_AUTOCONF += --enable-adder
else
GST_PLUGINS_BASE_AUTOCONF += --disable-adder
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIOCONVERT
GST_PLUGINS_BASE_AUTOCONF += --enable-audioconvert
else
GST_PLUGINS_BASE_AUTOCONF += --disable-audioconvert
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIOCONVERT
GST_PLUGINS_BASE_AUTOCONF += --enable-audioconvert
else
GST_PLUGINS_BASE_AUTOCONF += --disable-audioconvert
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIORATE
GST_PLUGINS_BASE_AUTOCONF += --enable-audiorate
else
GST_PLUGINS_BASE_AUTOCONF += --disable-audiorate
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIORESAMPLE
GST_PLUGINS_BASE_AUTOCONF += --enable-audioresample
else
GST_PLUGINS_BASE_AUTOCONF += --disable-audioresample
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIOTESTSRC
GST_PLUGINS_BASE_AUTOCONF += --enable-audiotestsrc
else
GST_PLUGINS_BASE_AUTOCONF += --disable-audiotestsrc
endif
ifdef PTXCONF_GST_PLUGINS_BASE_FFMPEGCOLORSPACE
GST_PLUGINS_BASE_AUTOCONF += --enable-ffmpegcolorspace
else
GST_PLUGINS_BASE_AUTOCONF += --disable-ffmpegcolorspace
endif
ifdef PTXCONF_GST_PLUGINS_BASE_GDP
GST_PLUGINS_BASE_AUTOCONF += --enable-gdp
else
GST_PLUGINS_BASE_AUTOCONF += --disable-gdp
endif
ifneq ($(PTXCONF_GST_PLUGINS_BASE_PLAYBIN)$(PTXCONF_GST_PLUGINS_BASE_DECODEBIN)$(PTXCONF_GST_PLUGINS_BASE_DECODEBIN2),)
GST_PLUGINS_BASE_AUTOCONF += --enable-playback
else
GST_PLUGINS_BASE_AUTOCONF += --disable-playback
endif
ifdef PTXCONF_GST_PLUGINS_BASE_SUBPARSE
GST_PLUGINS_BASE_AUTOCONF += --enable-subparse
else
GST_PLUGINS_BASE_AUTOCONF += --disable-subparse
endif
ifdef PTXCONF_GST_PLUGINS_BASE_TCP
GST_PLUGINS_BASE_AUTOCONF += --enable-tcp
else
GST_PLUGINS_BASE_AUTOCONF += --disable-tcp
endif
ifdef PTXCONF_GST_PLUGINS_BASE_TYPEFIND
GST_PLUGINS_BASE_AUTOCONF += --enable-typefind
else
GST_PLUGINS_BASE_AUTOCONF += --disable-typefind
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VIDEOTESTSRC
GST_PLUGINS_BASE_AUTOCONF += --enable-videotestsrc
else
GST_PLUGINS_BASE_AUTOCONF += --disable-videotestsrc
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VIDEORATE
GST_PLUGINS_BASE_AUTOCONF += --enable-videorate
else
GST_PLUGINS_BASE_AUTOCONF += --disable-videorate
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VIDEOSCALE
GST_PLUGINS_BASE_AUTOCONF += --enable-videoscale
else
GST_PLUGINS_BASE_AUTOCONF += --disable-videoscale
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VOLUME
GST_PLUGINS_BASE_AUTOCONF += --enable-volume
else
GST_PLUGINS_BASE_AUTOCONF += --disable-volume
endif
ifdef PTXCONF_GST_PLUGINS_BASE_X
GST_PLUGINS_BASE_AUTOCONF += --enable-x
GST_PLUGINS_BASE_AUTOCONF += --with-x=$(SYSROOT)/usr
else
GST_PLUGINS_BASE_AUTOCONF += --disable-x
GST_PLUGINS_BASE_AUTOCONF += --without-x
endif
ifdef PTXCONF_GST_PLUGINS_BASE_XVIDEO
GST_PLUGINS_BASE_AUTOCONF += --enable-xvideo
else
GST_PLUGINS_BASE_AUTOCONF += --disable-xvideo
endif
ifdef PTXCONF_GST_PLUGINS_BASE_XSHM
GST_PLUGINS_BASE_AUTOCONF += --enable-xshm
else
GST_PLUGINS_BASE_AUTOCONF += --disable-xshm
endif
ifdef PTXCONF_GST_PLUGINS_BASE_GST_V4L
GST_PLUGINS_BASE_AUTOCONF += --enable-gst_v4l
else
GST_PLUGINS_BASE_AUTOCONF += --disable-gst_v4l
endif
ifdef PTXCONF_GST_PLUGINS_BASE_ALSA
GST_PLUGINS_BASE_AUTOCONF += --enable-alsa
else
GST_PLUGINS_BASE_AUTOCONF += --disable-alsa
endif
ifdef PTXCONF_GST_PLUGINS_BASE_CDPARANOIA
GST_PLUGINS_BASE_AUTOCONF += --enable-cdparanoia
else
GST_PLUGINS_BASE_AUTOCONF += --disable-cdparanoia
endif
ifdef PTXCONF_GST_PLUGINS_BASE_GNOME_VFS
GST_PLUGINS_BASE_AUTOCONF += --enable-gnome_vfs
else
GST_PLUGINS_BASE_AUTOCONF += --disable-gnome_vfs
endif
ifdef PTXCONF_GST_PLUGINS_BASE_GIO
GST_PLUGINS_BASE_AUTOCONF += --enable-gio
else
GST_PLUGINS_BASE_AUTOCONF += --disable-gio
endif
ifdef PTXCONF_GST_PLUGINS_BASE_LIBVISUAL
GST_PLUGINS_BASE_AUTOCONF += --enable-libvisual
else
GST_PLUGINS_BASE_AUTOCONF += --disable-libvisual
endif
ifdef PTXCONF_GST_PLUGINS_BASE_OGG
GST_PLUGINS_BASE_AUTOCONF += --enable-ogg
else
GST_PLUGINS_BASE_AUTOCONF += --disable-ogg
endif
ifdef PTXCONF_GST_PLUGINS_BASE_PANGO
GST_PLUGINS_BASE_AUTOCONF += --enable-pango
else
GST_PLUGINS_BASE_AUTOCONF += --disable-pango
endif
ifdef PTXCONF_GST_PLUGINS_BASE_THEORA
GST_PLUGINS_BASE_AUTOCONF += --enable-theora
else
GST_PLUGINS_BASE_AUTOCONF += --disable-theora
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VORBIS
GST_PLUGINS_BASE_AUTOCONF += --enable-vorbis
else
GST_PLUGINS_BASE_AUTOCONF += --disable-vorbis
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-base.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  gst-plugins-base)
	@$(call install_fixup, gst-plugins-base,PACKAGE,gst-plugins-base)
	@$(call install_fixup, gst-plugins-base,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-base,VERSION,$(GST_PLUGINS_BASE_VERSION))
	@$(call install_fixup, gst-plugins-base,SECTION,base)
	@$(call install_fixup, gst-plugins-base,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gst-plugins-base,DEPENDS,)
	@$(call install_fixup, gst-plugins-base,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-base, 0, 0, 0755, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/bin/gst-visualise-0.10, \
		/usr/bin/gst-visualise)

	@for i in \
		libgsttag-0.10.so.0  \
		libgstinterfaces-0.10.so.0 \
		libgstcdda-0.10.so.0 \
		libgstpbutils-0.10.so.0 \
		libgstnetbuffer-0.10.so.0 \
		libgstfft-0.10.so.0 \
		libgstriff-0.10.so.0 \
		libgstaudio-0.10.so.0 \
		libgstrtp-0.10.so.0 \
		libgstsdp-0.10.so.0 \
		libgstrtsp-0.10.so.0 \
		libgstvideo-0.10.so.0 \
	; do \
	$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/$$i.16.0, \
		/usr/lib/$$i.16.0); \
	$(call install_link, gst-plugins-base,  \
		$$i.16.0, \
		/usr/lib/$$i); \
	done

ifdef PTXCONF_GST_PLUGINS_BASE_ADDER
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstadder.so, \
		/usr/lib/gstreamer-0.10/libgstadder.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIOCONVERT
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstaudioconvert.so, \
		/usr/lib/gstreamer-0.10/libgstaudioconvert.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIORATE
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstaudiorate.so, \
		/usr/lib/gstreamer-0.10/libgstaudiorate.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIORESAMPLE
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstaudioresample.so, \
		/usr/lib/gstreamer-0.10/libgstaudioresample.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_AUDIOTESTSRC
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstaudiotestsrc.so, \
		/usr/lib/gstreamer-0.10/libgstaudiotestsrc.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_DECODEBIN
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstdecodebin.so, \
		/usr/lib/gstreamer-0.10/libgstdecodebin.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_DECODEBIN_2
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstdecodebin2.so, \
		/usr/lib/gstreamer-0.10/libgstdecodebin2.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_FFMPEGCOLORSPACE
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstffmpegcolorspace.so, \
		/usr/lib/gstreamer-0.10/libgstffmpegcolorspace.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_GDP
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstgdp.so, \
		/usr/lib/gstreamer-0.10/libgstgdp.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_PLAYBIN
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstplaybin.so, \
		/usr/lib/gstreamer-0.10/libgstplaybin.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_SUBPARSE
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstsubparse.so, \
		/usr/lib/gstreamer-0.10/libgstsubparse.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_TCP
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgsttcp.so, \
		/usr/lib/gstreamer-0.10/libgsttcp.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_TYPEFIND
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgsttypefindfunctions.so, \
		/usr/lib/gstreamer-0.10/libgsttypefindfunctions.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VIDEOTESTSRC
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstvideotestsrc.so, \
		/usr/lib/gstreamer-0.10/libgstvideotestsrc.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VIDEORATE
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstvideorate.so, \
		/usr/lib/gstreamer-0.10/libgstvideorate.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VIDEOSCALE
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstvideoscale.so, \
		/usr/lib/gstreamer-0.10/libgstvideoscale.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VOLUME
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstvolume.so, \
		/usr/lib/gstreamer-0.10/libgstvolume.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_X
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstximagesink.so, \
		/usr/lib/gstreamer-0.10/libgstximagesink.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_XVIDEO
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstxvimagesink.so, \
		/usr/lib/gstreamer-0.10/libgstxvimagesink.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_GST_V4L
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstvideo4linux.so, \
		/usr/lib/gstreamer-0.10/libgstvideo4linux.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_ALSA
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstalsa.so, \
		/usr/lib/gstreamer-0.10/libgstalsa.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_CDPARANOIA
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstcdparanoia.so, \
		/usr/lib/gstreamer-0.10/libgstcdparanoia.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_GNOME_VFS
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstgnomevfs.so, \
		/usr/lib/gstreamer-0.10/libgstgnomevfs.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_GIO
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgio.so, \
		/usr/lib/gstreamer-0.10/libgio.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_LIBVISUAL
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstlibvisual.so, \
		/usr/lib/gstreamer-0.10/libgstlibvisual.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_OGG
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstogg.so, \
		/usr/lib/gstreamer-0.10/libgstogg.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_PANGO
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstpango.so, \
		/usr/lib/gstreamer-0.10/libgstpango.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_THEORA
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgsttheora.so, \
		/usr/lib/gstreamer-0.10/libgsttheora.so)
endif
ifdef PTXCONF_GST_PLUGINS_BASE_VORBIS
	@$(call install_copy, gst-plugins-base, 0, 0, 0644, \
		$(PKGDIR)/$(GST_PLUGINS_BASE)/usr/lib/gstreamer-0.10/libgstvorbis.so, \
		/usr/lib/gstreamer-0.10/libgstvorbis.so)
endif
	@$(call install_finish, gst-plugins-base)

	@$(call touch)

# vim: syntax=make
