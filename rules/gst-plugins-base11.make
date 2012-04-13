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
PACKAGES-$(PTXCONF_GST_PLUGINS_BASE11) += gst-plugins-base11

#
# Paths and names
#
GST_PLUGINS_BASE11_VERSION	:= 0.11.3
GST_PLUGINS_BASE11_MD5		:= d403bdb5eac3bff7808c972877ea8e35
GST_PLUGINS_BASE11		:= gst-plugins-base-$(GST_PLUGINS_BASE11_VERSION)
GST_PLUGINS_BASE11_SUFFIX	:= tar.bz2
GST_PLUGINS_BASE11_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-base/$(GST_PLUGINS_BASE11).$(GST_PLUGINS_BASE11_SUFFIX)
GST_PLUGINS_BASE11_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_BASE11).$(GST_PLUGINS_BASE11_SUFFIX)
GST_PLUGINS_BASE11_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_BASE11)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_APP)		+= app
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_ADDER)		+= adder
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_AUDIOCONVERT)	+= audioconvert
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_AUDIORATE)	+= audiorate
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_AUDIORESAMPLE)	+= audioresample
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_AUDIOTESTSRC)	+= audiotestsrc
GST_PLUGINS_BASE11_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE11_ENCODING)	+= encoding
GST_PLUGINS_BASE11_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE11_ENCODING)	+= encodebin
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_VIDEOCONVERT)	+= videoconvert
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_GDP)		+= gdp
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_GIO)		+= gio
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_PLAYBACK)	+= playback
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_SUBPARSE)	+= subparse
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_TCP)		+= tcp
GST_PLUGINS_BASE11_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE11_TYPEFIND)	+= typefind
GST_PLUGINS_BASE11_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE11_TYPEFIND)	+= typefindfunctions
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_VIDEOTESTSRC)	+= videotestsrc
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_VIDEORATE)	+= videorate
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_VIDEOSCALE)	+= videoscale
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_VOLUME)		+= volume
GST_PLUGINS_BASE11_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE11_X)		+= x
GST_PLUGINS_BASE11_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE11_X)		+= ximagesink
GST_PLUGINS_BASE11_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE11_XVIDEO)		+= xvideo
GST_PLUGINS_BASE11_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE11_XVIDEO)		+= xvimagesink
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_ALSA)		+= alsa
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_CDPARANOIA)	+= cdparanoia
GST_PLUGINS_BASE11_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE11_IVORBIS)	+= ivorbis
GST_PLUGINS_BASE11_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE11_IVORBIS)	+= ivorbisdec
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_LIBVISUAL)	+= libvisual
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_OGG)		+= ogg
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_PANGO)		+= pango
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_THEORA)		+= theora
GST_PLUGINS_BASE11_ENABLE-$(PTXCONF_GST_PLUGINS_BASE11_VORBIS)		+= vorbis

GST_PLUGINS_BASE11_ENABLEC-y	+= $(GST_PLUGINS_BASE11_ENABLE-y)
GST_PLUGINS_BASE11_ENABLEC-	+= $(GST_PLUGINS_BASE11_ENABLE-)
GST_PLUGINS_BASE11_ENABLEP-y	+= $(GST_PLUGINS_BASE11_ENABLE-y)

#
# autoconf
#
GST_PLUGINS_BASE11_CONF_TOOL	= autoconf
GST_PLUGINS_BASE11_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER_GENERIC_CONF_OPT) \
	--enable-external \
	--disable-experimental \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-introspection \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE11_ORC)-orc \
	--enable-Bsymbolic \
	--disable-iso-codes \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE11_ZLIB)-zlib \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE11_XSHM)-xshm \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-freetypetest

# --with-plugins=foo,bar,baz only works for depencyless plugins and
# when no plugins are given it falls back to its default which is
# to enable all plugins, so --with-plugins is useless for us.

ifneq ($(call remove_quotes,$(GST_PLUGINS_BASE11_ENABLEC-y)),)
GST_PLUGINS_BASE11_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_BASE11_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_BASE11_ENABLEC-)),)
GST_PLUGINS_BASE11_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_BASE11_ENABLEC-)))
endif

ifdef PTXCONF_GST_PLUGINS_BASE11_X
GST_PLUGINS_BASE11_CONF_OPT += --with-x=$(SYSROOT)/usr
else
GST_PLUGINS_BASE11_CONF_OPT += --without-x
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-base11.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  gst-plugins-base11)
	@$(call install_fixup, gst-plugins-base11,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-base11,SECTION,base)
	@$(call install_fixup, gst-plugins-base11,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gst-plugins-base11,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-base11, 0, 0, 0755, -, \
		/usr/bin/gst-discoverer-0.11)

	# install all activated libs
	@cd $(GST_PLUGINS_BASE11_PKGDIR)/usr/lib/ && \
	for libs in `find -name "*-0.11.so" -printf '%f\n'`; do \
		$(call install_lib, gst-plugins-base11, 0, 0, 0644, $${libs%.so}); \
	done

	@$(foreach plugin, $(GST_PLUGINS_BASE11_ENABLEP-y), \
		$(call install_copy, gst-plugins-base11, 0, 0, 0644, -, \
			/usr/lib/gstreamer-0.11/libgst$(plugin).so);)

	@$(call install_finish, gst-plugins-base11)

	@$(call touch)

# vim: syntax=make
