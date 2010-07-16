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
PACKAGES-$(PTXCONF_GSTREAMER) += gstreamer

#
# Paths and names
#
GSTREAMER_VERSION	:= 0.10.29
GSTREAMER		:= gstreamer-$(GSTREAMER_VERSION)
GSTREAMER_SUFFIX	:= tar.bz2
GSTREAMER_URL		:= http://gstreamer.freedesktop.org/src/gstreamer/$(GSTREAMER).$(GSTREAMER_SUFFIX)
GSTREAMER_SOURCE	:= $(SRCDIR)/$(GSTREAMER).$(GSTREAMER_SUFFIX)
GSTREAMER_DIR		:= $(BUILDDIR)/$(GSTREAMER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GSTREAMER_SOURCE):
	@$(call targetinfo)
	@$(call get, GSTREAMER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GSTREAMER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-rpath \
	--disable-trace \
	--disable-alloc-trace \
	--enable-registry \
	--enable-plugin \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	--disable-tests \
	--disable-failing-tests	\
	--disable-poisoning \
	--disable-introspection \
	--disable-docbook \
	--disable-gtk-doc \
	--disable-gobject-cast-checks \
	--disable-check \
	--without-libiconv-prefix \
	--without-libintl-prefix

ifdef PTXCONF_GSTREAMER__DEBUG
GSTREAMER_AUTOCONF += --enable-gst-debug
else
GSTREAMER_AUTOCONF += --disable-gst-debug
endif
ifdef PTXCONF_GSTREAMER__LOADSAVE
GSTREAMER_AUTOCONF += --enable-loadsave
else
GSTREAMER_AUTOCONF += --disable-loadsave
endif
ifdef PTXCONF_GSTREAMER__CMDLINEPARSER
GSTREAMER_AUTOCONF += --enable-parse
else
GSTREAMER_AUTOCONF += --disable-parse
endif
ifdef PTXCONF_GSTREAMER__OPTIONPARSING
GSTREAMER_AUTOCONF += --enable-option-parsing
else
GSTREAMER_AUTOCONF += --disable-option-parsing
endif
ifdef PTXCONF_GSTREAMER__NETDIST
GSTREAMER_AUTOCONF += --enable-net
else
GSTREAMER_AUTOCONF += --disable-net
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

GSTREAMER_LIB_VERSION := 0.25.0

$(STATEDIR)/gstreamer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer)
	@$(call install_fixup, gstreamer,PRIORITY,optional)
	@$(call install_fixup, gstreamer,SECTION,base)
	@$(call install_fixup, gstreamer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gstreamer,DESCRIPTION,missing)

ifdef PTXCONF_GSTREAMER__INSTALL_TYPEFIND
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-typefind)
endif
ifdef PTXCONF_GSTREAMER__INSTALL_INSPECT
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-inspect)
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-inspect-0.10)
endif
ifdef PTXCONF_GSTREAMER__INSTALL_XMLINSPECT
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-xmlinspect)
endif
ifdef PTXCONF_GSTREAMER__INSTALL_XMLLAUNCH
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-xmllaunch)
endif
ifdef PTXCONF_GSTREAMER__INSTALL_LAUNCH
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-launch)
	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/bin/gst-launch-0.10)
endif
ifdef PTXCONF_GSTREAMER__NETDIST
	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/libgstnet-0.10.so.$(GSTREAMER_LIB_VERSION))
	@$(call install_link, gstreamer, \
		libgstnet-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstnet-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstnet-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstnet-0.10.so)
endif
	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/libgstcontroller-0.10.so.$(GSTREAMER_LIB_VERSION))
	@$(call install_link, gstreamer, \
		libgstcontroller-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstcontroller-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstcontroller-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstcontroller-0.10.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/libgstreamer-0.10.so.$(GSTREAMER_LIB_VERSION))
	@$(call install_link, gstreamer, \
		libgstreamer-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstreamer-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstreamer-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstreamer-0.10.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/gstreamer-0.10/libgstcoreelements.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/gstreamer-0.10/libgstcoreindexers.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/libgstdataprotocol-0.10.so.$(GSTREAMER_LIB_VERSION))
	@$(call install_link, gstreamer, \
		libgstdataprotocol-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstdataprotocol-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstdataprotocol-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstdataprotocol-0.10.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/libgstbase-0.10.so.$(GSTREAMER_LIB_VERSION))
	@$(call install_link, gstreamer, \
		libgstbase-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstbase-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstbase-0.10.so.$(GSTREAMER_LIB_VERSION), \
		/usr/lib/libgstbase-0.10.so)

ifdef PTXCONF_PRELINK
	@$(call install_alternative, gstreamer, 0, 0, 0644, \
		/etc/prelink.conf.d/gstreamer)
endif

	@$(call install_finish, gstreamer)

	@$(call touch)

# vim: syntax=make
