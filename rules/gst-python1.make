# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PYTHON1) += gst-python1

#
# Paths and names
#
GST_PYTHON1_VERSION	:= 1.14.2
GST_PYTHON1_MD5		:= 5b0af1bd490d79a7d435b2be47568f8e
GST_PYTHON1		:= gst-python-$(GST_PYTHON1_VERSION)
GST_PYTHON1_SUFFIX	:= tar.xz
GST_PYTHON1_URL		:= http://gstreamer.freedesktop.org/src/gst-python/$(GST_PYTHON1).$(GST_PYTHON1_SUFFIX)
GST_PYTHON1_SOURCE	:= $(SRCDIR)/$(GST_PYTHON1).$(GST_PYTHON1_SUFFIX)
GST_PYTHON1_DIR		:= $(BUILDDIR)/$(GST_PYTHON1)
GST_PYTHON1_BUILD_OOT	:= YES
GST_PYTHON1_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PYTHON1_CONF_ENV	:= \
	$(CROSS_ENV) \
	PYTHON=$(CROSS_PYTHON3)

#
# autoconf
#
GST_PYTHON1_CONF_TOOL	:= autoconf
GST_PYTHON1_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-valgrind \
	--with-libpython-dir=/usr/lib

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-python1.install:
	@$(call targetinfo)
	@$(call world/install, GST_PYTHON1)
	@$(call world/env, GST_PYTHON1) ptxd_make_world_install_python_cleanup
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-python1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-python1)
	@$(call install_fixup, gst-python1,PRIORITY,optional)
	@$(call install_fixup, gst-python1,SECTION,base)
	@$(call install_fixup, gst-python1,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gst-python1,DESCRIPTION,missing)

	@for file in `find $(GST_PYTHON1_PKGDIR)/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/gi  \
			! -type d ! -name "*.py" ! -name "*.la" -printf "%P\n"`; do \
		$(call install_copy, gst-python1, 0, 0, 0644, -, \
			/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/gi/$$file); \
	done
	@$(call install_lib, gst-python1, 0, 0, 0644, gstreamer-1.0/libgstpython*)

	@$(call install_finish, gst-python1)

	@$(call touch)

# vim: syntax=make
