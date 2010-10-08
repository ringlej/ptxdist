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
GST_PLUGINS_GL_MD5	:= 3880eb17f3cff03b8e1b8af215116813
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
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-rpath \
	--disable-nls \
	--disable-debug \
	--disable-profiling \
	--disable-valgrind \
	--disable-gcov \
	--disable-gtk-doc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-gl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-plugins-gl)
	@$(call install_fixup, gst-plugins-gl,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-gl,SECTION,base)
	@$(call install_fixup, gst-plugins-gl,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, gst-plugins-gl,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-gl, 0, 0, 0644, -, /usr/lib/gstreamer-0.10/libgstopengl.so)
	@$(call install_lib, gst-plugins-gl, 0, 0, 0644, libgstgl-0.10)

	@$(call install_finish, gst-plugins-gl)

	@$(call touch)

# vim: syntax=make
