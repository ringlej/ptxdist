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
GST_PLUGINS_BASE_VERSION	:= 0.10.36
GST_PLUGINS_BASE_MD5		:= 776c73883e567f67b9c4a2847d8d041a
GST_PLUGINS_BASE		:= gst-plugins-base-$(GST_PLUGINS_BASE_VERSION)
GST_PLUGINS_BASE_SUFFIX		:= tar.bz2
GST_PLUGINS_BASE_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-base/$(GST_PLUGINS_BASE).$(GST_PLUGINS_BASE_SUFFIX)
GST_PLUGINS_BASE_SOURCE		:= $(SRCDIR)/$(GST_PLUGINS_BASE).$(GST_PLUGINS_BASE_SUFFIX)
GST_PLUGINS_BASE_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_BASE)
GST_PLUGINS_BASE_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_APP)		+= app
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_ADDER)		+= adder
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_AUDIOCONVERT)	+= audioconvert
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_AUDIORATE)		+= audiorate
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_AUDIORESAMPLE)	+= audioresample
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_AUDIOTESTSRC)	+= audiotestsrc
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_DECODEBIN)		+= decodebin
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_DECODEBIN_2)	+= decodebin2
GST_PLUGINS_BASE_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE_ENCODING)		+= encoding
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_ENCODING)		+= encodebin
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_FFMPEGCOLORSPACE)	+= ffmpegcolorspace
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_GDP)		+= gdp
GST_PLUGINS_BASE_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE_PLAYBACK)		+= playback
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_PLAYBACK)		+= playbin
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_SUBPARSE)		+= subparse
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_TCP)		+= tcp
GST_PLUGINS_BASE_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE_TYPEFIND)		+= typefind
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_TYPEFIND)		+= typefindfunctions
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_VIDEOTESTSRC)	+= videotestsrc
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_VIDEORATE)		+= videorate
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_VIDEOSCALE)		+= videoscale
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_VOLUME)		+= volume
GST_PLUGINS_BASE_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE_X)			+= x
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_X)			+= ximagesink
GST_PLUGINS_BASE_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE_XVIDEO)		+= xvideo
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_XVIDEO)		+= xvimagesink
GST_PLUGINS_BASE_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE_GST_V4L)		+= gst_v4l
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_GST_V4L)		+= video4linux
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_ALSA)		+= alsa
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_CDPARANOIA)		+= cdparanoia
GST_PLUGINS_BASE_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE_GNOME_VFS)		+= gnome_vfs
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_GNOME_VFS)		+= gnomevfs
GST_PLUGINS_BASE_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE_IVORBIS)		+= ivorbis
GST_PLUGINS_BASE_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE_IVORBIS)		+= ivorbisdec
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_GIO)		+= gio
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_LIBVISUAL)		+= libvisual
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_OGG)		+= ogg
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_PANGO)		+= pango
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_THEORA)		+= theora
GST_PLUGINS_BASE_ENABLE-$(PTXCONF_GST_PLUGINS_BASE_VORBIS)		+= vorbis

GST_PLUGINS_BASE_ENABLEC-y	+= $(GST_PLUGINS_BASE_ENABLE-y)
GST_PLUGINS_BASE_ENABLEC-	+= $(GST_PLUGINS_BASE_ENABLE-)
GST_PLUGINS_BASE_ENABLEP-y	+= $(GST_PLUGINS_BASE_ENABLE-y)

#
# autoconf
#
GST_PLUGINS_BASE_CONF_TOOL	= autoconf
GST_PLUGINS_BASE_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER_GENERIC_CONF_OPT) \
	--enable-external \
	--disable-experimental \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-introspection \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE_ORC)-orc \
	--enable-Bsymbolic \
	--disable-iso-codes \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE_ZLIB)-zlib \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE_XSHM)-xshm \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-freetypetest \
	--$(call ptx/wwo,PTXCONF_GST_PLUGINS_BASE_GST_V4L)-gudev

# --with-plugins=foo,bar,baz only works for depencyless plugins and
# when no plugins are given it falls back to its default which is
# to enable all plugins, so --with-plugins is useless for us.

ifneq ($(call remove_quotes,$(GST_PLUGINS_BASE_ENABLEC-y)),)
GST_PLUGINS_BASE_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_BASE_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_BASE_ENABLEC-)),)
GST_PLUGINS_BASE_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_BASE_ENABLEC-)))
endif

ifdef PTXCONF_GST_PLUGINS_BASE_X
GST_PLUGINS_BASE_CONF_OPT += --with-x=$(SYSROOT)/usr
else
GST_PLUGINS_BASE_CONF_OPT += --without-x
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-base.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  gst-plugins-base)
	@$(call install_fixup, gst-plugins-base,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-base,SECTION,base)
	@$(call install_fixup, gst-plugins-base,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gst-plugins-base,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-base, 0, 0, 0755, -, \
		/usr/bin/gst-discoverer-0.10)

	# install all activated libs
	@cd $(GST_PLUGINS_BASE_PKGDIR)/usr/lib/ && \
	for libs in `find -name "*-0.10.so" -printf '%f\n'`; do \
		$(call install_lib, gst-plugins-base, 0, 0, 0644, $${libs%.so}); \
	done

	@$(foreach plugin, $(GST_PLUGINS_BASE_ENABLEP-y), \
		$(call install_copy, gst-plugins-base, 0, 0, 0644, -, \
			/usr/lib/gstreamer-0.10/libgst$(plugin).so);)

	@$(call install_finish, gst-plugins-base)

	@$(call touch)

# vim: syntax=make
