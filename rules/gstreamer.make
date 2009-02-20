# -*-makefile-*-
# $Id: template-make 8509 2008-06-12 12:45:40Z mkl $
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
GSTREAMER_VERSION	:= 0.10.22
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
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer.extract:
	@$(call targetinfo)
	@$(call clean, $(GSTREAMER_DIR))
	@$(call extract, GSTREAMER)
	@$(call patchin, GSTREAMER)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GSTREAMER_PATH	:= PATH=$(CROSS_PATH)
GSTREAMER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GSTREAMER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
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
	--disable-binary-registry \
	--disable-large-file \
	--disable-docbook \
	--disable-gtk-doc \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--without-check

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


$(STATEDIR)/gstreamer.prepare:
	@$(call targetinfo)
	@$(call clean, $(GSTREAMER_DIR)/config.cache)
	cd $(GSTREAMER_DIR) && \
		$(GSTREAMER_PATH) $(GSTREAMER_ENV) \
		./configure $(GSTREAMER_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer.compile:
	@$(call targetinfo)
	cd $(GSTREAMER_DIR) && $(GSTREAMER_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer.install:
	@$(call targetinfo)
	@$(call install, GSTREAMER)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gstreamer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gstreamer)
	@$(call install_fixup, gstreamer,PACKAGE,gstreamer)
	@$(call install_fixup, gstreamer,PRIORITY,optional)
	@$(call install_fixup, gstreamer,VERSION,$(GSTREAMER_VERSION))
	@$(call install_fixup, gstreamer,SECTION,base)
	@$(call install_fixup, gstreamer,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gstreamer,DEPENDS,)
	@$(call install_fixup, gstreamer,DESCRIPTION,missing)

ifdef PTXCONF_GSTREAMER__INSTALL_TYPEFIND
	@$(call install_copy, gstreamer, 0, 0, 0755, \
		$(GSTREAMER_DIR)/tools/gst-typefind, \
		/usr/bin/gst-typefind)
endif
ifdef PTXCONF_GSTREAMER__INSTALL_INSPECT
	@$(call install_copy, gstreamer, 0, 0, 0755, \
		$(GSTREAMER_DIR)/tools/gst-inspect, \
		/usr/bin/gst-inspect)
	@$(call install_copy, gstreamer, 0, 0, 0755, \
		$(GSTREAMER_DIR)/tools/gst-inspect-0.10, \
		/usr/bin/gst-inspect-0.10)
endif
ifdef PTXCONF_GSTREAMER__INSTALL_XMLINSPECT
	@$(call install_copy, gstreamer, 0, 0, 0755, \
		$(GSTREAMER_DIR)/tools/gst-xmlinspect, \
		/usr/bin/gst-xmlinspect)
endif
ifdef PTXCONF_GSTREAMER__INSTALL_XMLLAUNCH
	@$(call install_copy, gstreamer, 0, 0, 0755, \
		$(GSTREAMER_DIR)/tools/gst-xmllaunch, \
		/usr/bin/gst-xmllaunch)
endif
ifdef PTXCONF_GSTREAMER__INSTALL_LAUNCH
	@$(call install_copy, gstreamer, 0, 0, 0755, \
		$(GSTREAMER_DIR)/tools/gst-launch, \
		/usr/bin/gst-launch)
	@$(call install_copy, gstreamer, 0, 0, 0755, \
		$(GSTREAMER_DIR)/tools/gst-launch-0.10, \
		/usr/bin/gst-launch-0.10)
endif
ifdef PTXCONF_GSTREAMER__NETDIST
	@$(call install_copy, gstreamer, 0, 0, 0644, \
		$(GSTREAMER_DIR)/libs/gst/net/.libs/libgstnet-0.10.so.0.19.0, \
		/usr/lib/libgstnet-0.10.so.0.17.0)
	@$(call install_link, gstreamer, \
		libgstnet-0.10.so.0.17.0, \
		/usr/lib/libgstnet-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstnet-0.10.so.0.17.0, \
		/usr/lib/libgstnet-0.10.so)
endif
	@$(call install_copy, gstreamer, 0, 0, 0644, \
		$(GSTREAMER_DIR)/libs/gst/controller/.libs/libgstcontroller-0.10.so.0.19.0, \
		/usr/lib/libgstcontroller-0.10.so.0.17.0)
	@$(call install_link, gstreamer, \
		libgstcontroller-0.10.so.0.17.0, \
		/usr/lib/libgstcontroller-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstcontroller-0.10.so.0.17.0, \
		/usr/lib/libgstcontroller-0.10.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, \
		$(GSTREAMER_DIR)/gst/.libs/libgstreamer-0.10.so.0.19.0, \
		/usr/lib/libgstreamer-0.10.so.0.17.0)
	@$(call install_link, gstreamer, \
		libgstreamer-0.10.so.0.17.0, \
		/usr/lib/libgstreamer-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstreamer-0.10.so.0.17.0, \
		/usr/lib/libgstreamer-0.10.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, \
		$(GSTREAMER_DIR)/plugins/elements/.libs/libgstcoreelements.so, \
		/usr/lib/gstreamer-0.10/libgstcoreelements.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, \
		$(GSTREAMER_DIR)/plugins/indexers/.libs/libgstcoreindexers.so, \
		/usr/lib/gstreamer-0.10/libgstcoreindexers.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, \
		$(GSTREAMER_DIR)/libs/gst/dataprotocol/.libs/libgstdataprotocol-0.10.so.0.19.0, \
		/usr/lib/libgstdataprotocol-0.10.so.0.19.0)
	@$(call install_link, gstreamer, \
		libgstdataprotocol-0.10.so.0.19.0, \
		/usr/lib/libgstdataprotocol-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstdataprotocol-0.10.so.0.19.0, \
		/usr/lib/libgstdataprotocol-0.10.so)

	@$(call install_copy, gstreamer, 0, 0, 0644, \
		$(GSTREAMER_DIR)/libs/gst/base/.libs/libgstbase-0.10.so.0.19.0, \
		/usr/lib/libgstbase-0.10.so.0.19.0)
	@$(call install_link, gstreamer, \
		libgstbase-0.10.so.0.19.0, \
		/usr/lib/libgstbase-0.10.so.0)
	@$(call install_link, gstreamer, \
		libgstbase-0.10.so.0.19.0, \
		/usr/lib/libgstbase-0.10.so.0)

	@$(call install_finish, gstreamer)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gstreamer_clean:
	rm -rf $(STATEDIR)/gstreamer.*
	rm -rf $(PKGDIR)/gstreamer_*
	rm -rf $(GSTREAMER_DIR)

# vim: syntax=make
