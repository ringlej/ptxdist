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
GSTREAMER_VERSION	:= 0.10.35
GSTREAMER_MD5		:= 4a0a00edad7a2c83de5211ca679dfaf9
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
	$(GLOBAL_LARGE_FILE_OPTION) \
	$(GSTREAMER_GENERIC_CONF_OPT) \
	--disable-trace \
	--disable-alloc-trace \
	--enable-registry \
	--enable-plugin \
	--disable-tests \
	--disable-failing-tests	\
	--disable-poisoning \
	--disable-introspection \
	--disable-docbook \
	--disable-check \
	--enable-Bsymbolic

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
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstnet-0.10)
endif
	@$(call install_lib, gstreamer, 0, 0, 0644, libgstcontroller-0.10)

	@$(call install_lib, gstreamer, 0, 0, 0644, libgstreamer-0.10)

	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/gstreamer-0.10/libgstcoreelements.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, -, \
		/usr/lib/gstreamer-0.10/libgstcoreindexers.so)

	@$(call install_lib, gstreamer, 0, 0, 0644, libgstdataprotocol-0.10)

	@$(call install_lib, gstreamer, 0, 0, 0644, libgstbase-0.10)

	@$(call install_copy, gstreamer, 0, 0, 0755, -, \
		/usr/libexec/gstreamer-0.10/gst-plugin-scanner)

ifdef PTXCONF_PRELINK
	@$(call install_alternative, gstreamer, 0, 0, 0644, \
		/etc/prelink.conf.d/gstreamer)
endif

	@$(call install_finish, gstreamer)

	@$(call touch)

# vim: syntax=make
