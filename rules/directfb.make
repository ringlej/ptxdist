# -*-makefile-*-
#
# Copyright (C) 2006, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIRECTFB) += directfb

#
# Paths and names
#
DIRECTFB_VERSION	:= 1.3.0
DIRECTFB		:= DirectFB-$(DIRECTFB_VERSION)
DIRECTFB_SUFFIX		:= tar.gz
DIRECTFB_SOURCE		:= $(SRCDIR)/$(DIRECTFB).$(DIRECTFB_SUFFIX)
DIRECTFB_DIR		:= $(BUILDDIR)/$(DIRECTFB)

DIRECTFB_URL		:= \
	http://www.directfb.org/downloads/Core/DirectFB-1.3/$(DIRECTFB).$(DIRECTFB_SUFFIX) \
	http://www.directfb.org/downloads/Old/$(DIRECTFB).$(DIRECTFB_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DIRECTFB_SOURCE):
	@$(call targetinfo)
	@$(call get, DIRECTFB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DIRECTFB_PATH	:= PATH=$(CROSS_PATH)
DIRECTFB_ENV 	= \
	$(CROSS_ENV) \
	DIRECTFB_CSOURCE=$(HOST_DIRECTFB_DIR)/tools/directfb-csource

DIRECTFB_INPUT-$(PTXCONF_DIRECTFB_INPUT_KEYBOARD)	+= keyboard
DIRECTFB_INPUT-$(PTXCONF_DIRECTFB_INPUT_LINUXINPUT)	+= linuxinput
DIRECTFB_INPUT-$(PTXCONF_DIRECTFB_INPUT_PS2MOUSE)	+= ps2mouse
DIRECTFB_INPUT-$(PTXCONF_DIRECTFB_INPUT_TSLIB)		+= tslib

#
# autoconf
#
DIRECTFB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-osx \
	--disable-network \
	--disable-multi \
	--disable-voodoo \
	--disable-sdl \
	--disable-vnc \
	--disable-sysfs \
	--disable-zlib \
	--disable-video4linux \
	--disable-video4linux2 \
	--with-gfxdrivers=none \
	--with-inputdrivers=$(subst $(space),$(comma),$(DIRECTFB_INPUT-y)) \
	--enable-fbdev \
	--disable-x11


ifdef PTXCONF_DIRECTFB_DEBUG
DIRECTFB_AUTOCONF += --enable-debug
DIRECTFB_MODULE_DIRECTORY := /usr/lib/directfb-1.3-0
else
DIRECTFB_AUTOCONF += --disable-debug-support
DIRECTFB_MODULE_DIRECTORY := /usr/lib/directfb-1.3-0-pure
endif

ifdef PTXCONF_DIRECTFB_TRACE
DIRECTFB_AUTOCONF += --enable-trace
else
DIRECTFB_AUTOCONF += --disable-trace
endif

ifdef PTXCONF_DIRECTFB_WM_UNIQUE
DIRECTFB_AUTOCONF += --enable-unique
else
DIRECTFB_AUTOCONF += --disable-unique
endif

ifdef PTXCONF_DIRECTFB_IMAGE_GIF
DIRECTFB_AUTOCONF += --enable-gif
else
DIRECTFB_AUTOCONF += --disable-gif
endif

ifdef PTXCONF_DIRECTFB_IMAGE_PNG
DIRECTFB_AUTOCONF += --enable-png
else
DIRECTFB_AUTOCONF += --disable-png
endif

ifdef PTXCONF_DIRECTFB_IMAGE_JPEG
DIRECTFB_AUTOCONF += --enable-jpeg
else
DIRECTFB_AUTOCONF += --disable-jpeg
endif

ifdef PTXCONF_DIRECTFB_FONT_FREETYPE
DIRECTFB_AUTOCONF += --enable-freetype
else
DIRECTFB_AUTOCONF += --disable-freetype
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/directfb.install:
	@$(call targetinfo)
	@$(call install, DIRECTFB)

	$(INSTALL) -m 755 -D $(DIRECTFB_DIR)/directfb-config $(PTXCONF_SYSROOT_CROSS)/bin/directfb-config

	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

# /usr/bin/dfblayer
# /usr/bin/dfbfx
# /usr/bin/dfbg
# /usr/bin/dfbinspector
# /usr/bin/dfbinput
# /usr/bin/mkdgiff
# /usr/bin/dfbscreen
# /usr/bin/dfbpenmount
# /usr/bin/directfb-config
# /usr/bin/mkdfiff
# /usr/bin/directfb-csource
# /usr/bin/dfbmaster
# /usr/bin/dfbdump
# /usr/share/directfb-1.3.5/cursor.dat
# /usr/lib/directfb-1.3-0-pure/interfaces/IDirectFBFont/libidirectfbfont_dgiff.so
# /usr/lib/directfb-1.3-0-pure/interfaces/IDirectFBFont/libidirectfbfont_default.so
# /usr/lib/directfb-1.3-0-pure/interfaces/IDirectFBImageProvider/libidirectfbimageprovider_dfiff.so
# /usr/lib/directfb-1.3-0-pure/interfaces/IDirectFBVideoProvider/libidirectfbvideoprovider_gif.so
# /usr/lib/directfb-1.3-0-pure/systems/libdirectfb_devmem.so

$(STATEDIR)/directfb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, directfb)
	@$(call install_fixup,directfb,PACKAGE,directfb)
	@$(call install_fixup,directfb,PRIORITY,optional)
	@$(call install_fixup,directfb,VERSION,$(DIRECTFB_VERSION))
	@$(call install_fixup,directfb,SECTION,base)
	@$(call install_fixup,directfb,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,directfb,DEPENDS,)
	@$(call install_fixup,directfb,DESCRIPTION,missing)

	@$(call install_copy, directfb, 0, 0, 0755, -, /usr/bin/dfbinfo)

	@$(call install_copy, directfb, 0, 0, 0644, -, /usr/lib/libdirectfb-1.3.so.0.0.0)
	@$(call install_link, directfb, libdirectfb-1.3.so.0.0.0, /usr/lib/libdirectfb-1.3.so.0)
	@$(call install_link, directfb, libdirectfb-1.3.so.0.0.0, /usr/lib/libdirectfb.so)

	@$(call install_copy, directfb, 0, 0, 0644, -, /usr/lib/libfusion-1.3.so.0.0.0)
	@$(call install_link, directfb, libfusion-1.3.so.0.0.0, /usr/lib/libfusion-1.3.so.0)
	@$(call install_link, directfb, libfusion-1.3.so.0.0.0, /usr/lib/libfusion.so)

	@$(call install_copy, directfb, 0, 0, 0644, -, /usr/lib/libdirect-1.3.so.0.0.0)
	@$(call install_link, directfb, libdirect-1.3.so.0.0.0, /usr/lib/libdirect-1.3.so.0)
	@$(call install_link, directfb, libdirect-1.3.so.0.0.0, /usr/lib/libdirect.so)

	@$(call install_copy, directfb, 0, 0, 0644, -, $(DIRECTFB_MODULE_DIRECTORY)/systems/libdirectfb_fbdev.so)
	@$(call install_copy, directfb, 0, 0, 0644, -, $(DIRECTFB_MODULE_DIRECTORY)/wm/libdirectfbwm_default.so)

ifdef PTXCONF_DIRECTFB_WM_UNIQUE
	@$(call install_copy, directfb, 0, 0, 0644, -, $(DIRECTFB_MODULE_DIRECTORY)/wm/libdirectfbwm_unique.so)
	@$(call install_copy, directfb, 0, 0, 0644, -,/usr/lib/libuniquewm-1.3.so.0.0.0)
	@$(call install_link, directfb, libuniquewm-1.3.so.0.0.0, /usr/lib/libuniquewm-1.3.so.0)
	@$(call install_link, directfb, libuniquewm-1.3.so.0.0.0, /usr/lib/libuniquewm.so)
endif

ifdef PTXCONF_DIRECTFB_IMAGE_GIF
	@$(call install_copy, directfb, 0, 0, 0644, -, \
		$(DIRECTFB_MODULE_DIRECTORY)/interfaces/IDirectFBImageProvider/libidirectfbimageprovider_gif.so)
endif

ifdef PTXCONF_DIRECTFB_IMAGE_PNG
	@$(call install_copy, directfb, 0, 0, 0644, -, \
		$(DIRECTFB_MODULE_DIRECTORY)/interfaces/IDirectFBImageProvider/libidirectfbimageprovider_png.so)
endif

ifdef PTXCONF_DIRECTFB_IMAGE_JPEG
	@$(call install_copy, directfb, 0, 0, 0644, -, \
		$(DIRECTFB_MODULE_DIRECTORY)/interfaces/IDirectFBImageProvider/libidirectfbimageprovider_jpeg.so)
endif

ifdef PTXCONF_DIRECTFB_INPUT_LINUXINPUT
	@$(call install_copy, directfb, 0, 0, 0644, -, \
		$(DIRECTFB_MODULE_DIRECTORY)/inputdrivers/libdirectfb_linux_input.so)
endif

ifdef PTXCONF_DIRECTFB_INPUT_KEYBOARD
	@$(call install_copy, directfb, 0, 0, 0644, -, \
		$(DIRECTFB_MODULE_DIRECTORY)/inputdrivers/libdirectfb_keyboard.so)
endif

ifdef PTXCONF_DIRECTFB_INPUT_PS2MOUSE
	@$(call install_copy, directfb, 0, 0, 0644, -, \
		$(DIRECTFB_MODULE_DIRECTORY)/inputdrivers/libdirectfb_ps2mouse.so)
endif

ifdef PTXCONF_DIRECTFB_INPUT_TSLIB
	@$(call install_copy, directfb, 0, 0, 0644, -, \
		$(DIRECTFB_MODULE_DIRECTORY)/inputdrivers/libdirectfb_tslib.so)
endif

ifdef PTXCONF_DIRECTFB_FONT_FREETYPE
	@$(call install_copy, directfb, 0, 0, 0644, -, \
		$(DIRECTFB_MODULE_DIRECTORY)/interfaces/IDirectFBFont/libidirectfbfont_ft2.so)
endif

	@$(call install_finish,directfb)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

directfb_clean:
	rm -rf $(STATEDIR)/directfb.*
	rm -rf $(PKGDIR)/directfb_*
	rm -rf $(DIRECTFB_DIR)

# vim: syntax=make
