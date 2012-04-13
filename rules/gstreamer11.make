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
GSTREAMER11_VERSION	:= 0.11.3
GSTREAMER11_MD5		:= dc8b876b3f61711adfe742bea8ddebfd
GSTREAMER11		:= gstreamer-$(GSTREAMER11_VERSION)
GSTREAMER11_SUFFIX	:= tar.bz2
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

$(STATEDIR)/gstreamer11.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer11)
	@$(call install_fixup, gstreamer11,PRIORITY,optional)
	@$(call install_fixup, gstreamer11,SECTION,base)
	@$(call install_fixup, gstreamer11,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gstreamer11,DESCRIPTION,missing)

ifdef PTXCONF_GSTREAMER11_INSTALL_TYPEFIND
	@$(call install_copy, gstreamer11, 0, 0, 0755, -, \
		/usr/bin/gst-typefind-0.11)
endif
ifdef PTXCONF_GSTREAMER11_INSTALL_INSPECT
	@$(call install_copy, gstreamer11, 0, 0, 0755, -, \
		/usr/bin/gst-inspect-0.11)
endif
ifdef PTXCONF_GSTREAMER11_INSTALL_LAUNCH
	@$(call install_copy, gstreamer11, 0, 0, 0755, -, \
		/usr/bin/gst-launch-0.11)
endif
	@$(call install_lib, gstreamer11, 0, 0, 0644, libgstbase-0.11)
	@$(call install_lib, gstreamer11, 0, 0, 0644, libgstcontroller-0.11)
	@$(call install_lib, gstreamer11, 0, 0, 0644, libgstnet-0.11)
	@$(call install_lib, gstreamer11, 0, 0, 0644, libgstreamer-0.11)

	@$(call install_lib, gstreamer11, 0, 0, 0644, \
		gstreamer-0.11/libgstcoreelements)

	@$(call install_copy, gstreamer11, 0, 0, 0755, -, \
		/usr/libexec/gstreamer-0.11/gst-plugin-scanner)

ifdef PTXCONF_PRELINK
	@$(call install_alternative, gstreamer11, 0, 0, 0644, \
		/etc/prelink.conf.d/gstreamer11)
endif

	@$(call install_finish, gstreamer11)

	@$(call touch)

# vim: syntax=make
