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
PACKAGES-$(PTXCONF_GSTREAMER11) += gstreamer11

#
# Paths and names
#
GSTREAMER11_VERSION	:= 1.0.6
GSTREAMER11_MD5		:= d0797e51a420fca0beb973b9dcda586f
GSTREAMER11		:= gstreamer-$(GSTREAMER11_VERSION)
GSTREAMER11_SUFFIX	:= tar.xz
GSTREAMER11_URL		:= http://gstreamer.freedesktop.org/src/gstreamer/$(GSTREAMER11).$(GSTREAMER11_SUFFIX)
GSTREAMER11_SOURCE	:= $(SRCDIR)/$(GSTREAMER11).$(GSTREAMER11_SUFFIX)
GSTREAMER11_DIR		:= $(BUILDDIR)/$(GSTREAMER11)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GSTREAMER11_GENERIC_CONF_OPT = \
	--disable-nls \
	--disable-rpath \
	--disable-fatal-warnings \
	\
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	\
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-introspection \
	\
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-gobject-cast-checks \
	--disable-glib-asserts \
	\
	--without-libiconv-prefix \
	--without-libintl-prefix \

GSTREAMER11_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER11_GENERIC_CONF_OPT) \
	--$(call ptx/endis,PTXCONF_GSTREAMER11_DEBUG)-gst-debug \
	--$(call ptx/endis,PTXCONF_GSTREAMER11_CMDLINEPARSER)-parse \
	--$(call ptx/endis,PTXCONF_GSTREAMER11_OPTIONPARSING)-option-parsing \
	--disable-trace \
	--disable-alloc-trace \
	--enable-registry \
	--enable-plugin \
	\
	--disable-tests \
	--disable-failing-tests \
	--disable-benchmarks \
	--enable-tools \
	--disable-poisoning \
	\
	--disable-docbook \
	\
	--disable-check \
	--enable-Bsymbolic

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer11.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer11)
	@$(call install_fixup, gstreamer11,PRIORITY,optional)
	@$(call install_fixup, gstreamer11,SECTION,base)
	@$(call install_fixup, gstreamer11,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gstreamer11,DESCRIPTION,missing)

ifdef PTXCONF_GSTREAMER11_INSTALL_TYPEFIND
	@$(call install_copy, gstreamer11, 0, 0, 0755, -, \
		/usr/bin/gst-typefind-1.0)
endif
ifdef PTXCONF_GSTREAMER11_INSTALL_INSPECT
	@$(call install_copy, gstreamer11, 0, 0, 0755, -, \
		/usr/bin/gst-inspect-1.0)
endif
ifdef PTXCONF_GSTREAMER11_INSTALL_LAUNCH
	@$(call install_copy, gstreamer11, 0, 0, 0755, -, \
		/usr/bin/gst-launch-1.0)
endif
	@$(call install_lib, gstreamer11, 0, 0, 0644, libgstbase-1.0)
	@$(call install_lib, gstreamer11, 0, 0, 0644, libgstcontroller-1.0)
	@$(call install_lib, gstreamer11, 0, 0, 0644, libgstnet-1.0)
	@$(call install_lib, gstreamer11, 0, 0, 0644, libgstreamer-1.0)

	@$(call install_lib, gstreamer11, 0, 0, 0644, \
		gstreamer-1.0/libgstcoreelements)

	@$(call install_copy, gstreamer11, 0, 0, 0755, -, \
		/usr/libexec/gstreamer-1.0/gst-plugin-scanner)

ifdef PTXCONF_PRELINK
	@$(call install_alternative, gstreamer11, 0, 0, 0644, \
		/etc/prelink.conf.d/gstreamer11)
endif

	@$(call install_finish, gstreamer11)

	@$(call touch)

# vim: syntax=make
