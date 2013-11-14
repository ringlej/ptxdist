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
PACKAGES-$(PTXCONF_GST_PLUGINS_BASE1) += gst-plugins-base1

#
# Paths and names
#
GST_PLUGINS_BASE1_VERSION	:= 1.2.1
GST_PLUGINS_BASE1_MD5		:= 2e75fb03ed7e4d24d88601fcac4d57aa
GST_PLUGINS_BASE1		:= gst-plugins-base-$(GST_PLUGINS_BASE1_VERSION)
GST_PLUGINS_BASE1_SUFFIX	:= tar.xz
GST_PLUGINS_BASE1_URL		:= http://gstreamer.freedesktop.org/src/gst-plugins-base/$(GST_PLUGINS_BASE1).$(GST_PLUGINS_BASE1_SUFFIX)
GST_PLUGINS_BASE1_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_BASE1).$(GST_PLUGINS_BASE1_SUFFIX)
GST_PLUGINS_BASE1_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_BASE1)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_ADDER)		+= adder
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_APP)		+= app
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIOCONVERT)	+= audioconvert
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIORATE)		+= audiorate
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIOTESTSRC)	+= audiotestsrc
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_ENCODING)		+= encoding
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_ENCODING)		+= encodebin
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VIDEOCONVERT)	+= videoconvert
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_GIO)		+= gio
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_PLAYBACK)		+= playback
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_AUDIORESAMPLE)	+= audioresample
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_SUBPARSE)		+= subparse
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_TCP)		+= tcp
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_TYPEFIND)		+= typefind
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_TYPEFIND)		+= typefindfunctions
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VIDEOTESTSRC)	+= videotestsrc
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VIDEORATE)		+= videorate
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VIDEOSCALE)	+= videoscale
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VOLUME)		+= volume
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_X)		+= x
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_X)		+= ximagesink
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_XVIDEO)		+= xvideo
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_XVIDEO)		+= xvimagesink
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_ALSA)		+= alsa
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_CDPARANOIA)	+= cdparanoia
GST_PLUGINS_BASE1_ENABLEC-$(PTXCONF_GST_PLUGINS_BASE1_IVORBIS)		+= ivorbis
GST_PLUGINS_BASE1_ENABLEP-$(PTXCONF_GST_PLUGINS_BASE1_IVORBIS)		+= ivorbisdec
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_LIBVISUAL)		+= libvisual
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_OGG)		+= ogg
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_PANGO)		+= pango
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_THEORA)		+= theora
GST_PLUGINS_BASE1_ENABLE-$(PTXCONF_GST_PLUGINS_BASE1_VORBIS)		+= vorbis

GST_PLUGINS_BASE1_ENABLEC-y	+= $(GST_PLUGINS_BASE1_ENABLE-y)
GST_PLUGINS_BASE1_ENABLEC-	+= $(GST_PLUGINS_BASE1_ENABLE-)
GST_PLUGINS_BASE1_ENABLEP-y	+= $(GST_PLUGINS_BASE1_ENABLE-y)

#
# autoconf
#
GST_PLUGINS_BASE1_CONF_TOOL	= autoconf
GST_PLUGINS_BASE1_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER_GENERIC_CONF_OPT) \
	--enable-external \
	--disable-experimental \
	\
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE1_ORC)-orc \
	--enable-Bsymbolic \
	\
	--disable-iso-codes \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE1_ZLIB)-zlib \
	--$(call ptx/endis,PTXCONF_GST_PLUGINS_BASE1_XSHM)-xshm \
	--disable-freetypetest

# --with-plugins=foo,bar,baz only works for depencyless plugins and
# when no plugins are given it falls back to its default which is
# to enable all plugins, so --with-plugins is useless for us.

ifneq ($(call remove_quotes,$(GST_PLUGINS_BASE1_ENABLEC-y)),)
GST_PLUGINS_BASE1_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_BASE1_ENABLEC-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_BASE1_ENABLEC-)),)
GST_PLUGINS_BASE1_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_BASE1_ENABLEC-)))
endif

ifdef PTXCONF_GST_PLUGINS_BASE1_X
GST_PLUGINS_BASE1_CONF_OPT += --with-x=$(SYSROOT)/usr
else
GST_PLUGINS_BASE1_CONF_OPT += --without-x
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-base1.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  gst-plugins-base1)
	@$(call install_fixup, gst-plugins-base1,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-base1,SECTION,base)
	@$(call install_fixup, gst-plugins-base1,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gst-plugins-base1,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-base1, 0, 0, 0755, -, \
		/usr/bin/gst-discoverer-1.0)

	# install all activated libs
	@cd $(GST_PLUGINS_BASE1_PKGDIR)/usr/lib/ && \
	for libs in `find -name "*-1.0.so" -printf '%f\n'`; do \
		$(call install_lib, gst-plugins-base1, 0, 0, 0644, $${libs%.so}); \
	done

	@$(foreach plugin, $(GST_PLUGINS_BASE1_ENABLEP-y), \
		$(call install_copy, gst-plugins-base1, 0, 0, 0644, -, \
			/usr/lib/gstreamer-1.0/libgst$(plugin).so);)

	@$(call install_finish, gst-plugins-base1)

	@$(call touch)

# vim: syntax=make
