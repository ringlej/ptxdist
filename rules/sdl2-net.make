# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Grzeschik <mgr@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL2_NET) += sdl2-net

#
# Paths and names
#
SDL2_NET_VERSION	:= 2.0.1
SDL2_NET_MD5		:= 5c1d9d1cfa63301b141cb5c0de2ea7c4
SDL2_NET		:= SDL2_net-$(SDL2_NET_VERSION)
SDL2_NET_SUFFIX	:= tar.gz
SDL2_NET_URL		:= https://www.libsdl.org/projects/SDL_net/release/$(SDL2_NET).$(SDL2_NET_SUFFIX)
SDL2_NET_SOURCE	:= $(SRCDIR)/$(SDL2_NET).$(SDL2_NET_SUFFIX)
SDL2_NET_DIR		:= $(BUILDDIR)/$(SDL2_NET)
SDL2_NET_LICENSE	:= zlib

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL2_NET_CONF_TOOL	:= autoconf

ifdef PTXCONF_SDL2_PULSEAUDIO
SDL2_NET_LDFLAGS	:= \
	-Wl,-rpath-link,$(SYSROOT)/usr/lib/pulseaudio
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl2-net.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl2-net)
	@$(call install_fixup, sdl2-net,PRIORITY,optional)
	@$(call install_fixup, sdl2-net,SECTION,base)
	@$(call install_fixup, sdl2-net,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, sdl2-net,DESCRIPTION,missing)

	@$(call install_lib, sdl2-net, 0, 0, 0644, libSDL2_net-2.0)

	@$(call install_finish, sdl2-net)

	@$(call touch)

# vim: syntax=make
