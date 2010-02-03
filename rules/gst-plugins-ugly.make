# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_UGLY) += gst-plugins-ugly

#
# Paths and names
#
GST_PLUGINS_UGLY_VERSION := 0.10.13
GST_PLUGINS_UGLY	 := gst-plugins-ugly-$(GST_PLUGINS_UGLY_VERSION)
GST_PLUGINS_UGLY_SUFFIX	 := tar.bz2
GST_PLUGINS_UGLY_URL	 := http://gstreamer.freedesktop.org/src/gst-plugins-ugly/$(GST_PLUGINS_UGLY).$(GST_PLUGINS_UGLY_SUFFIX)
GST_PLUGINS_UGLY_SOURCE	 := $(SRCDIR)/$(GST_PLUGINS_UGLY).$(GST_PLUGINS_UGLY_SUFFIX)
GST_PLUGINS_UGLY_DIR	 := $(BUILDDIR)/$(GST_PLUGINS_UGLY)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GST_PLUGINS_UGLY_SOURCE):
	@$(call targetinfo)
	@$(call get, GST_PLUGINS_UGLY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_ASFDEMUX)		+= asfdemux
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_DVDLPCMDEC)		+= dvdlpcmdec
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_DVDSUB)		+= dvdsub
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_IEC958)		+= iec958
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_MPEGAUDIOPARSE)	+= mpegaudioparse
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_MPEGSTREAM)		+= mpegstream
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_REALMEDIA)		+= realmedia
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_SYNAESTHESIA)	+= synaesthesia
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_A52DEC)		+= a52dec
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_AMRNB)		+= amrnb
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_AMRWBDEC)		+= amrwb
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_CDIO)		+= cdio
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_DVDREADSRC)		+= dvdread
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_LAME)		+= lame
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_MAD)			+= mad
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_MPEG2DEC)		+= mpeg2dec
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_SID)			+= sidplay
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_TWOLAME)		+= twolame
GST_PLUGINS_UGLY_ENABLE-$(PTXCONF_GST_PLUGINS_UGLY_X264)		+= x264

#
# autoconf
#
GST_PLUGINS_UGLY_CONF_TOOL	:= autoconf
GST_PLUGINS_UGLY_CONF_OPT	:= \
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
	--disable-gtk-doc \
	--with-package-origin="PTXDist" \
	--enable-shave
#
# the --with-plugins sadly only applies to depencyless plugings
# and when no plugins are sellected it builds them all. So
# --with-plugins is useless, so we generate a --enable-*
# and --disable-* below
#
ifneq ($(call remove_quotes,$(GST_PLUGINS_UGLY_ENABLE-y)),)
GST_PLUGINS_UGLY_CONF_OPT +=  --enable-$(subst $(space),$(space)--enable-,$(strip $(GST_PLUGINS_UGLY_ENABLE-y)))
endif

ifneq ($(call remove_quotes,$(GST_PLUGINS_UGLY_ENABLE-)),)
GST_PLUGINS_UGLY_CONF_OPT +=  --disable-$(subst $(space),$(space)--disable-,$(strip $(GST_PLUGINS_UGLY_ENABLE-)))
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-ugly.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-ugly)
	@$(call install_fixup, gst-plugins-ugly,PACKAGE,gst-plugins-ugly)
	@$(call install_fixup, gst-plugins-ugly,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-ugly,VERSION,$(GST_PLUGINS_UGLY_VERSION))
	@$(call install_fixup, gst-plugins-ugly,SECTION,base)
	@$(call install_fixup, gst-plugins-ugly,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, gst-plugins-ugly,DEPENDS,)
	@$(call install_fixup, gst-plugins-ugly,DESCRIPTION,missing)

	# install all activated plugins
	@if [ -d  $(GST_PLUGINS_UGLY_PKGDIR)/usr/lib/gstreamer-0.10/ ]; then \
		cd $(GST_PLUGINS_UGLY_PKGDIR) && for plugin in `find ./usr/lib/gstreamer-0.10/ -name "*.so"`; do \
			$(call install_copy, gst-plugins-ugly, 0, 0, 0644, -, /$$plugin); \
		done \
	fi

	@$(call install_finish, gst-plugins-ugly)

	@$(call touch)

# vim: syntax=make
