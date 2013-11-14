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
PACKAGES-$(PTXCONF_GSTREAMER1) += gstreamer1

#
# Paths and names
#
GSTREAMER1_VERSION	:= 1.2.1
GSTREAMER1_MD5		:= 55d50f48a496799dbb0b195c9c6c6153
GSTREAMER1		:= gstreamer-$(GSTREAMER1_VERSION)
GSTREAMER1_SUFFIX	:= tar.xz
GSTREAMER1_URL		:= http://gstreamer.freedesktop.org/src/gstreamer/$(GSTREAMER1).$(GSTREAMER1_SUFFIX)
GSTREAMER1_SOURCE	:= $(SRCDIR)/$(GSTREAMER1).$(GSTREAMER1_SUFFIX)
GSTREAMER1_DIR		:= $(BUILDDIR)/$(GSTREAMER1)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GSTREAMER1_GENERIC_CONF_OPT = \
	--disable-nls \
	--disable-rpath \
	--disable-fatal-warnings \
	\
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	--disable-static-plugins \
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

GSTREAMER1_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER1_GENERIC_CONF_OPT) \
	--$(call ptx/endis,PTXCONF_GSTREAMER1_DEBUG)-gst-debug \
	--$(call ptx/endis,PTXCONF_GSTREAMER1_CMDLINEPARSER)-parse \
	--$(call ptx/endis,PTXCONF_GSTREAMER1_OPTIONPARSING)-option-parsing \
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

$(STATEDIR)/gstreamer1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer1)
	@$(call install_fixup, gstreamer1,PRIORITY,optional)
	@$(call install_fixup, gstreamer1,SECTION,base)
	@$(call install_fixup, gstreamer1,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gstreamer1,DESCRIPTION,missing)

ifdef PTXCONF_GSTREAMER1_INSTALL_TYPEFIND
	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/bin/gst-typefind-1.0)
endif
ifdef PTXCONF_GSTREAMER1_INSTALL_INSPECT
	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/bin/gst-inspect-1.0)
endif
ifdef PTXCONF_GSTREAMER1_INSTALL_LAUNCH
	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/bin/gst-launch-1.0)
endif
	@$(call install_lib, gstreamer1, 0, 0, 0644, libgstbase-1.0)
	@$(call install_lib, gstreamer1, 0, 0, 0644, libgstcontroller-1.0)
	@$(call install_lib, gstreamer1, 0, 0, 0644, libgstnet-1.0)
	@$(call install_lib, gstreamer1, 0, 0, 0644, libgstreamer-1.0)

	@$(call install_lib, gstreamer1, 0, 0, 0644, \
		gstreamer-1.0/libgstcoreelements)

	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/libexec/gstreamer-1.0/gst-plugin-scanner)

ifdef PTXCONF_PRELINK
	@$(call install_alternative, gstreamer1, 0, 0, 0644, \
		/etc/prelink.conf.d/gstreamer1)
endif

	@$(call install_finish, gstreamer1)

	@$(call touch)

# vim: syntax=make
