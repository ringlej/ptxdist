# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_PLUGINS_GL) += gst-plugins-gl

#
# Paths and names
#
GST_PLUGINS_GL_VERSION	:= 0.10.1
GST_PLUGINS_GL		:= gst-plugins-gl-$(GST_PLUGINS_GL_VERSION)
GST_PLUGINS_GL_SUFFIX	:= tar.bz2
GST_PLUGINS_GL_URL	:= http://gstreamer.freedesktop.org/src/gst-plugins-gl/$(GST_PLUGINS_GL).$(GST_PLUGINS_GL_SUFFIX)
GST_PLUGINS_GL_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_GL).$(GST_PLUGINS_GL_SUFFIX)
GST_PLUGINS_GL_DIR	:= $(BUILDDIR)/$(GST_PLUGINS_GL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GST_PLUGINS_GL_SOURCE):
	@$(call targetinfo)
	@$(call get, GST_PLUGINS_GL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GST_PLUGINS_GL_CONF_TOOL := autoconf
GST_PLUGINS_GL_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-rpath \
	--disable-nls \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-gtk-doc \
	--enable-largefile

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-gl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-gl)
	@$(call install_fixup, gst-plugins-gl,PACKAGE,gst-plugins-gl)
	@$(call install_fixup, gst-plugins-gl,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-gl,VERSION,$(GST_PLUGINS_GL_VERSION))
	@$(call install_fixup, gst-plugins-gl,SECTION,base)
	@$(call install_fixup, gst-plugins-gl,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, gst-plugins-gl,DEPENDS,)
	@$(call install_fixup, gst-plugins-gl,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-gl, 0, 0, 0644, -, /usr/lib/gstreamer-0.10/libgstopengl.so)

	@$(call install_copy, gst-plugins-gl, 0, 0, 0644, -, /usr/lib/libgstgl-0.10.so.0.0.0)
	@$(call install_link, gst-plugins-gl, libgstgl-0.10.so.0.0.0, /usr/lib/libgstgl-0.10.so.0)
	@$(call install_link, gst-plugins-gl, libgstgl-0.10.so.0.0.0, /usr/lib/libgstgl-0.10.so)

	@$(call install_finish, gst-plugins-gl)

	@$(call touch)

# vim: syntax=make
