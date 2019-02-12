# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_VALIDATE1) += gst-validate1

#
# Paths and names
#
GST_VALIDATE1_VERSION	:= 1.14.4
GST_VALIDATE1_MD5	:= 1f4fc5308695adfdc11d13046aa4888c
GST_VALIDATE1		:= gst-validate-$(GST_VALIDATE1_VERSION)
GST_VALIDATE1_SUFFIX	:= tar.xz
GST_VALIDATE1_URL	:= http://gstreamer.freedesktop.org/data/src/gst-validate/$(GST_VALIDATE1).$(GST_VALIDATE1_SUFFIX)
GST_VALIDATE1_SOURCE	:= $(SRCDIR)/$(GST_VALIDATE1).$(GST_VALIDATE1_SUFFIX)
GST_VALIDATE1_DIR	:= $(BUILDDIR)/$(GST_VALIDATE1)
GST_VALIDATE1_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_VALIDATE1_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_prog_enable_sphinx_doc=no \
	ac_cv_path_PYTHON=$(CROSS_PYTHON3)

#
# autoconf
#
GST_VALIDATE1_CONF_TOOL	:= autoconf
GST_VALIDATE1_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--runstatedir=/run \
	--disable-nls \
	--disable-rpath \
	--disable-debug \
	--disable-valgrind \
	--disable-gcov \
	--$(call ptx/endis, PTXCONF_GSTREAMER1_INTROSPECTION)-introspection \
	--disable-docbook \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-gobject-cast-checks \
	--disable-glib-asserts \
	--with-package-origin="PTXdist"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-validate1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-validate1)
	@$(call install_fixup, gst-validate1,PRIORITY,optional)
	@$(call install_fixup, gst-validate1,SECTION,base)
	@$(call install_fixup, gst-validate1,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gst-validate1,DESCRIPTION,missing)

	@$(call install_lib, gst-validate1, 0, 0, 0644, libgstvalidate-1.0)
	@$(call install_lib, gst-validate1, 0, 0, 0644, \
		libgstvalidate-default-overrides-1.0)

	@$(call install_lib, gst-validate1, 0, 0, 0644, \
		gstreamer-1.0/libgstvalidatetracer)

	@$(call install_lib, gst-validate1, 0, 0, 0644, \
		gstreamer-1.0/validate/libgstvalidatefaultinjection)
	@$(call install_lib, gst-validate1, 0, 0, 0644, \
		gstreamer-1.0/validate/libgstvalidategapplication)

	@$(call install_copy, gst-validate1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-1.0)
	@$(call install_copy, gst-validate1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-media-check-1.0)
	@$(call install_copy, gst-validate1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-transcoding-1.0)

	@$(call install_tree, gst-validate1, 0, 0, -, \
		/usr/share/gstreamer-1.0/validate/scenarios)

ifdef PTXCONF_GSTREAMER1_INTROSPECTION
	@$(call install_copy, gst-validate1, 0, 0, 644, -, \
		/usr/lib/girepository-1.0/GstValidate-1.0.typelib)
endif

ifdef PTXCONF_GST_VALIDATE1_VIDEO
	@$(call install_lib, gst-validate1, 0, 0, 0644, \
		libgstvalidatevideo-1.0)

	@$(call install_lib, gst-validate1, 0, 0, 0644, \
		gstreamer-1.0/validate/libgstvalidatessim)

	@$(call install_copy, gst-validate1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-images-check-1.0)
endif

ifdef PTXCONF_GST_VALIDATE1_LAUNCHER
	@$(call install_copy, gst-validate1, 0, 0, 0755, -, \
		/usr/bin/gst-validate-launcher)

	@cd $(GST_VALIDATE1_PKGDIR)/usr/lib/gst-validate-launcher/python && \
		for file in `find launcher/ -name "*.pyc"`; do \
			$(call install_copy, gst-validate1, 0, 0, 0644, -, \
				/usr/lib/gst-validate-launcher/python/$${file}); \
		done
endif

	@$(call install_finish, gst-validate1)

	@$(call touch)

# vim: syntax=make
