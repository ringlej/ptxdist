# -*-makefile-*-
# $Id: template 5041 2006-03-09 08:45:49Z mkl $
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
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
DIRECTFB_VERSION	:= 1.0.0
DIRECTFB		:= DirectFB-$(DIRECTFB_VERSION)
DIRECTFB_SUFFIX		:= tar.gz
DIRECTFB_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(DIRECTFB).$(DIRECTFB_SUFFIX)
DIRECTFB_URL		:= http://www.directfb.org/downloads/Core/$(DIRECTFB).$(DIRECTFB_SUFFIX)
DIRECTFB_SOURCE		:= $(SRCDIR)/$(DIRECTFB).$(DIRECTFB_SUFFIX)
DIRECTFB_DIR		:= $(BUILDDIR)/$(DIRECTFB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

directfb_get: $(STATEDIR)/directfb.get

$(STATEDIR)/directfb.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DIRECTFB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DIRECTFB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

directfb_extract: $(STATEDIR)/directfb.extract

$(STATEDIR)/directfb.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(DIRECTFB_DIR))
	@$(call extract, DIRECTFB)
	@$(call patchin, DIRECTFB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

directfb_prepare: $(STATEDIR)/directfb.prepare

DIRECTFB_PATH	:= PATH=$(CROSS_PATH)
DIRECTFB_ENV 	= \
	$(CROSS_ENV) \
	DIRECTFB_CSOURCE=$(HOST_DIRECTFB_DIR)/tools/directfb-csource

ifdef PTXCONF_DIRECTFB_INPUT_KEYBOARD
DIRECTFB_INPUT += keybaord
endif

ifdef PTXCONF_DIRECTFB_INPUT_LINUXINPUT
DIRECTFB_INPUT += linuxinput
endif

ifdef PTXCONF_DIRECTFB_INPUT_PS2MOUSE
DIRECTFB_INPUT += ps2mouse
endif

ifdef PTXCONF_DIRECTFB_INPUT_TSLIB
DIRECTFB_INPUT += tslib
endif

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
	--disable-gif \
	--disable-video4linux \
	--disable-video4linux2 \
	\
	--with-gfxdrivers=none \
	--with-inputdrivers=$(subst $(space),$(comma),$(DIRECTFB_INPUT)) \
	\
	--enable-fbdev


ifdef PTXCONF_DIRECTFB_WM_UNIQUE
DIRECTFB_AUTOCONF += --enable-unique
else
DIRECTFB_AUTOCONF += --disable-unique
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

$(STATEDIR)/directfb.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(DIRECTFB_DIR)/config.cache)
	cd $(DIRECTFB_DIR) && \
		$(DIRECTFB_PATH) $(DIRECTFB_ENV) \
		./configure $(DIRECTFB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

directfb_compile: $(STATEDIR)/directfb.compile

$(STATEDIR)/directfb.compile:
	@$(call targetinfo, $@)
	cd $(DIRECTFB_DIR) && $(DIRECTFB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

directfb_install: $(STATEDIR)/directfb.install

$(STATEDIR)/directfb.install:
	@$(call targetinfo, $@)
	@$(call install, DIRECTFB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

directfb_targetinstall: $(STATEDIR)/directfb.targetinstall

$(STATEDIR)/directfb.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, directfb)
	@$(call install_fixup,directfb,PACKAGE,directfb)
	@$(call install_fixup,directfb,PRIORITY,optional)
	@$(call install_fixup,directfb,VERSION,$(DIRECTFB_VERSION))
	@$(call install_fixup,directfb,SECTION,base)
	@$(call install_fixup,directfb,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,directfb,DEPENDS,)
	@$(call install_fixup,directfb,DESCRIPTION,missing)

	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/src/.libs/libdirectfb-1.0.so.0.0.0, \
		/usr/lib/libdirectfb-1.0.so.0.0.0)
	@$(call install_link, directfb, libdirectfb-1.0.so.0.0.0, /usr/lib/libdirectfb-1.0.so.0)
	@$(call install_link, directfb, libdirectfb-1.0.so.0.0.0, /usr/lib/libdirectfb.so)

	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/lib/fusion/.libs/libfusion-1.0.so.0.0.0, \
		/usr/lib/libfusion-1.0.so.0.0.0)
	@$(call install_link, directfb, libfusion-1.0.so.0.0.0, /usr/lib/libfusion-1.0.so.0)
	@$(call install_link, directfb, libfusion-1.0.so.0.0.0, /usr/lib/libfusion.so)

	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/lib/direct/.libs/libdirect-1.0.so.0.0.0, \
		/usr/lib/libdirect-1.0.so.0.0.0)
	@$(call install_link, directfb, libdirect-1.0.so.0.0.0, /usr/lib/libdirect-1.0.so.0)
	@$(call install_link, directfb, libdirect-1.0.so.0.0.0, /usr/lib/libdirect.so)


	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/systems/fbdev/.libs/libdirectfb_fbdev.so, \
		/usr/lib/directfb-1.0-0/systems/libdirectfb_fbdev.so)

	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/wm/default/.libs/libdirectfbwm_default.so, \
		/usr/lib/directfb-1.0-0/wm/libdirectfbwm_default.so)

ifdef PTXCONF_DIRECTFB_WM_UNIQUE
	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/wm/unique/.libs/libdirectfbwm_unique.so, \
		/usr/lib/directfb-1.0-0/wm/libdirectfbwm_unique.so)

	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/wm/unique/.libs/libuniquewm-1.0.so.0.0.0, \
		/usr/lib/libuniquewm-1.0.so.0.0.0)
	@$(call install_link, directfb, libuniquewm-1.0.so.0.0.0, /usr/lib/libuniquewm-1.0.so.0)
	@$(call install_link, directfb, libuniquewm-1.0.so.0.0.0, /usr/lib/libuniquewm.so)
endif

ifdef PTXCONF_DIRECTFB_IMAGE_PNG
	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/interfaces/IDirectFBImageProvider/.libs/libidirectfbimageprovider_png.so, \
		/usr/lib/directfb-1.0-0/interfaces/IDirectFBImageProvider/libidirectfbimageprovider_png.so)
endif

ifdef PTXCONF_DIRECTFB_IMAGE_JPEG
	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/interfaces/IDirectFBImageProvider/.libs/libidirectfbimageprovider_jpeg.so, \
		/usr/lib/directfb-1.0-0/interfaces/IDirectFBImageProvider/libidirectfbimageprovider_jpeg.so)
endif


ifdef PTXCONF_DIRECTFB_INPUT_LINUXINPUT
	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/inputdrivers/linux_input/.libs/libdirectfb_linux_input.so, \
		/usr/lib/directfb-1.0-0/inputdrivers/libdirectfb_linux_input.so)
endif

ifdef PTXCONF_DIRECTFB_INPUT_PS2MOUSE
	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/inputdrivers/ps2mouse/.libs/libdirectfb_ps2mouse.so, \
		/usr/lib/directfb-1.0-0/inputdrivers/libdirectfb_ps2mouse.so)
endif

ifdef PTXCONF_DIRECTFB_INPUT_TSLIB
	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/inputdrivers/tslib/.libs/libdirectfb_tslib.so, \
		/usr/lib/directfb-1.0-0/inputdrivers/libdirectfb_tslib.so)
endif


ifdef PTXCONF_DIRECTFB_FONT_FREETYPE
	@$(call install_copy, directfb, 0, 0, 0644, \
		$(DIRECTFB_DIR)/interfaces/IDirectFBFont/.libs/libidirectfbfont_ft2.so, \
		/usr/lib/directfb-1.0-0/interfaces/IDirectFBFont/libidirectfbfont_ft2.so)
endif



	@$(call install_finish,directfb)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

directfb_clean:
	rm -rf $(STATEDIR)/directfb.*
	rm -rf $(IMAGEDIR)/directfb_*
	rm -rf $(DIRECTFB_DIR)

# vim: syntax=make
