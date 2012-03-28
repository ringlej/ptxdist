# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GSTREAMER) += gstreamer

#
# Paths and names
#
GSTREAMER_VERSION	:= 0.10.36
GSTREAMER_MD5		:= a0cf7d6877f694a1a2ad2b4d1ecb890b
GSTREAMER		:= gstreamer-$(GSTREAMER_VERSION)
GSTREAMER_SUFFIX	:= tar.bz2
GSTREAMER_URL		:= http://gstreamer.freedesktop.org/src/gstreamer/$(GSTREAMER).$(GSTREAMER_SUFFIX)
GSTREAMER_SOURCE	:= $(SRCDIR)/$(GSTREAMER).$(GSTREAMER_SUFFIX)
GSTREAMER_DIR		:= $(BUILDDIR)/$(GSTREAMER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GSTREAMER_GENERIC_CONF_OPT = \
	--disable-nls \
	--disable-rpath \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	--disable-gtk-doc \
	--disable-silent-rules \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--disable-gobject-cast-checks

GSTREAMER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER_GENERIC_CONF_OPT) \
	--$(call ptx/endis,PTXCONF_GSTREAMER_DEBUG)-gst-debug \
	--$(call ptx/endis,PTXCONF_GSTREAMER_LOADSAVE)-loadsave \
	--$(call ptx/endis,PTXCONF_GSTREAMER_CMDLINEPARSER)-parse \
	--$(call ptx/endis,PTXCONF_GSTREAMER_OPTIONPARSING)-option-parsing \
	--disable-trace \
	--disable-alloc-trace \
	--enable-registry \
	--$(call ptx/endis,PTXCONF_GSTREAMER_NETDIST)-net \
	--enable-plugin \
	--disable-tests \
	--disable-failing-tests \
	--disable-poisoning \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-introspection \
	--disable-docbook \
	--disable-check \
	--enable-Bsymbolic

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer)
	@$(call install_fixup, gstreamer,PRIORITY,optional)
	@$(call install_fixup, gstreamer,SECTION,base)
	@$(call install_fixup, gstreamer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gstreamer,DESCRIPTION,missing)

ifdef PTXCONF_GSTREAMER_INSTALL_TYPEFIND
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-typefind)
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-typefind-0.10)
endif
ifdef PTXCONF_GSTREAMER_INSTALL_INSPECT
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-inspect)
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-inspect-0.10)
endif
ifdef PTXCONF_GSTREAMER_INSTALL_XMLINSPECT
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-xmlinspect)
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-xmlinspect-0.10)
endif
ifdef PTXCONF_GSTREAMER_INSTALL_XMLLAUNCH
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-xmllaunch)
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-xmllaunch-0.10)
endif
ifdef PTXCONF_GSTREAMER_INSTALL_LAUNCH
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-launch)
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-launch-0.10)
endif

	@$(call install_lib, gstreamer, 0, 0, 0644, libgstbase-0.10)
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstcontroller-0.10)
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstdataprotocol-0.10)
ifdef PTXCONF_GSTREAMER_NETDIST
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstnet-0.10)
endif
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstreamer-0.10)

	@$(call install_lib, gstreamer, 0, 0, 0644, \
		gstreamer-0.10/libgstcoreelements)
	@$(call install_lib, gstreamer, 0, 0, 0644, \
		gstreamer-0.10/libgstcoreindexers)

	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/libexec/gstreamer-0.10/gst-plugin-scanner)

ifdef PTXCONF_PRELINK
	@$(call install_alternative, gstreamer, 0, 0, 0644, \
		/etc/prelink.conf.d/gstreamer)
endif

	@$(call install_finish, gstreamer)

	@$(call touch)

# vim: syntax=make
