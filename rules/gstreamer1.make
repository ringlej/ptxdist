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
GSTREAMER1_VERSION	:= 1.14.1
GSTREAMER1_MD5		:= c46967bd2b7b6b73fa4f47de61610243
GSTREAMER1		:= gstreamer-$(GSTREAMER1_VERSION)
GSTREAMER1_SUFFIX	:= tar.xz
GSTREAMER1_URL		:= http://gstreamer.freedesktop.org/src/gstreamer/$(GSTREAMER1).$(GSTREAMER1_SUFFIX)
GSTREAMER1_SOURCE	:= $(SRCDIR)/$(GSTREAMER1).$(GSTREAMER1_SUFFIX)
GSTREAMER1_DIR		:= $(BUILDDIR)/$(GSTREAMER1)
GSTREAMER1_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GSTREAMER1_BASIC_CONF_OPT = \
	\
	--disable-fatal-warnings \
	--disable-extra-check \
	\
	--disable-debug \
	\
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-gobject-cast-checks \
	--disable-glib-asserts

GSTREAMER1_GENERIC_CONF_OPT = \
	$(GSTREAMER1_BASIC_CONF_OPT) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	\
	--disable-nls \
	--disable-rpath \
	\
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-examples \
	\
	--enable-Bsymbolic \
	\
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--with-package-origin="PTXdist"

GSTREAMER1_CONF_TOOL	:= autoconf
GSTREAMER1_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GSTREAMER1_GENERIC_CONF_OPT) \
	--$(call ptx/endis,PTXCONF_GSTREAMER1_DEBUG)-gst-debug \
	--$(call ptx/endis,PTXCONF_GSTREAMER1_DEBUG)-gst-tracer-hooks \
	--enable-parse \
	--enable-option-parsing \
	--enable-registry \
	--enable-plugin \
	\
	--disable-tests \
	--disable-failing-tests \
	--disable-benchmarks \
	--$(call ptx/endis,PTXCONF_GSTREAMER1_INSTALL_TOOLS)-tools \
	--disable-poisoning \
	--$(call ptx/endis, PTXCONF_GSTREAMER1_INTROSPECTION)-introspection \
	\
	--disable-check \
	--with-ptp-helper-setuid-user=nobody \
	--with-ptp-helper-setuid-group=nogroup \
	--with-ptp-helper-permissions=setuid-root \
	--with-unwind \
	--without-dw

ifdef PTXCONF_GSTREAMER1_INTROSPECTION
GSTREAMER1_LDFLAGS := -Wl,-rpath-link,$(GSTREAMER1_DIR)/libs/gst/base/.libs
endif

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

ifdef PTXCONF_GSTREAMER1_INSTALL_TOOLS
	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/bin/gst-inspect-1.0)
	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/bin/gst-launch-1.0)
	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/bin/gst-typefind-1.0)
	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/bin/gst-stats-1.0)
endif

	@$(call install_lib, gstreamer1, 0, 0, 0644, libgstbase-1.0)
	@$(call install_lib, gstreamer1, 0, 0, 0644, libgstcontroller-1.0)
	@$(call install_lib, gstreamer1, 0, 0, 0644, libgstnet-1.0)
	@$(call install_lib, gstreamer1, 0, 0, 0644, libgstreamer-1.0)

	@$(call install_lib, gstreamer1, 0, 0, 0644, \
		gstreamer-1.0/libgstcoreelements)
ifdef PTXCONF_GSTREAMER1_DEBUG
	@$(call install_lib, gstreamer1, 0, 0, 0644, \
		gstreamer-1.0/libgstcoretracers)
endif

	@$(call install_copy, gstreamer1, 0, 0, 0755, -, \
		/usr/libexec/gstreamer-1.0/gst-plugin-scanner)
	@$(call install_copy, gstreamer1, 0, 0, 4755, -, \
		/usr/libexec/gstreamer-1.0/gst-ptp-helper)

ifdef PTXCONF_GSTREAMER1_INTROSPECTION
	@$(call install_tree, gstreamer1, 0, 0, -, \
		/usr/lib/girepository-1.0)
endif

ifdef PTXCONF_PRELINK
	@$(call install_alternative, gstreamer1, 0, 0, 0644, \
		/etc/prelink.conf.d/gstreamer1)
endif

	@$(call install_finish, gstreamer1)

	@$(call touch)

# vim: syntax=make
