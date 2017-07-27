# -*-makefile-*-
#
# Copyright (C) 2016 by Lucas Stach <l.stach@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WAFFLE) += waffle

#
# Paths and names
#
WAFFLE_VERSION	:= 1.5.2
WAFFLE_MD5	:= c669c91bf2f7e13a5d781c3dbb30fd8c
WAFFLE		:= waffle-$(WAFFLE_VERSION)
WAFFLE_SUFFIX	:= tar.xz
WAFFLE_URL	:= http://www.waffle-gl.org/files/release/$(WAFFLE)/$(WAFFLE).$(WAFFLE_SUFFIX)
WAFFLE_SOURCE	:= $(SRCDIR)/$(WAFFLE).$(WAFFLE_SUFFIX)
WAFFLE_DIR	:= $(BUILDDIR)/$(WAFFLE)
WAFFLE_LICENSE	:= BSD-2-Clause
WAFFLE_LICENSE_FILES := \
	file://LICENSE.txt;md5=4c5154407c2490750dd461c50ad94797

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WAFFLE_CONF_TOOL	:= cmake
WAFFLE_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-Dwaffle_has_glx=$(call ptx/ifdef,PTXCONF_WAFFLE_GLX,1,0) \
	-Dwaffle_has_wayland=$(call ptx/ifdef,PTXCONF_WAFFLE_WAYLAND,1,0) \
	-Dwaffle_has_x11_egl=$(call ptx/ifdef,PTXCONF_WAFFLE_X11_EGL,1,0) \
	-Dwaffle_has_gbm=$(call ptx/ifdef,PTXCONF_WAFFLE_GBM,1,0)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/waffle.targetinstall:
	@$(call targetinfo)

	@$(call install_init, waffle)
	@$(call install_fixup, waffle,PRIORITY,optional)
	@$(call install_fixup, waffle,SECTION,base)
	@$(call install_fixup, waffle,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, waffle,DESCRIPTION,missing)

	@$(call install_lib, waffle, 0, 0, 0644, libwaffle-1)

	@$(call install_finish, waffle)

	@$(call touch)

# vim: syntax=make
