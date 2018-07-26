# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Grzeschik
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL2_TEST) += sdl2-test

#
# Paths and names
#
SDL2_TEST_VERSION	= $(SDL2_VERSION)
SDL2_TEST_MD5		= $(SDL2_MD5)
SDL2_TEST		= SDL2_test-$(SDL2_VERSION)
SDL2_TEST_SUFFIX	= $(SDL2_SUFFIX)
SDL2_TEST_URL		= $(SDL2_URL)
SDL2_TEST_SOURCE	= $(SDL2_SOURCE)
SDL2_TEST_DIR		= $(BUILDDIR)/$(SDL2_TEST)
SDL2_TEST_SUBDIR	:= test
SDL2_TESTS_LICENSE	:= zlib

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL2_TEST_ENV		:= \
	$(CROSS_ENV) \
	SDL_LIBS="-lSDL2 -lunwind -lunwind-generic"

#
# autoconf
#
SDL2_TEST_CONF_TOOL	:= autoconf
SDL2_TEST_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis,PTXCONF_SDL2_OPENGL)-opengl

ifdef PTXCONF_SDL2_PULSEAUDIO
SDL2_TEST_LDFLAGS	:= \
	-Wl,-rpath-link,$(SYSROOT)/usr/lib/pulseaudio
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

SDL2_TEST_TOOLS := \
	checkkeys \
	controllermap \
	loopwave \
	loopwavequeue \
	testatomic \
	testaudiocapture \
	testaudiohotplug \
	testaudioinfo \
	testautomation \
	testbounds \
	testcustomcursor \
	testdisplayinfo \
	testdraw2 \
	testdrawchessboard \
	testdropfile \
	testerror \
	testfile \
	testfilesystem \
	testgamecontroller \
	testgesture \
	testhaptic \
	testhittesting \
	testhotplug \
	testiconv \
	testime \
	testintersections \
	testjoystick \
	testkeys \
	testloadso \
	testlock \
	testmessage \
	testmultiaudio \
	testnative \
	testoverlay2 \
	testplatform \
	testpower \
	testqsort \
	testrelative \
	testrendercopyex \
	testrendertarget \
	testresample \
	testrumble \
	testscale \
	testsem \
	testshape \
	testsprite2 \
	testspriteminimal \
	teststreaming \
	testthread \
	testtimer \
	testver \
	testviewport \
	testvulkan \
	testwm2 \
	testyuv \
	torturethread

ifdef PTXCONF_SDL2_OPENGL
SDL2_TEST_TOOLS += \
	testgl2 \
	testshader
endif

ifdef PTXCONF_SDL2_OPENGLES1
SDL2_TEST_TOOLS += testgles
endif

ifdef PTXCONF_SDL2_OPENGLES2
SDL2_TEST_TOOLS += testgles2
endif

SDL2_TEST_DATA := \
	axis.bmp \
	button.bmp \
	controllermap.bmp \
	icon.bmp \
	sample.bmp \
	testyuv.bmp \
	sample.wav \
	picture.xbm \
	moose.dat \
	utf8.txt

$(STATEDIR)/sdl2-test.install:
	@$(call targetinfo)
	@$(foreach file, $(SDL2_TEST_TOOLS), \
	     install -vD -m 0755 $(SDL2_TEST_DIR)/$(SDL2_TEST_SUBDIR)/$(file) \
	       $(SDL2_TEST_PKGDIR)/usr/bin/sdl2tests/$(file)$(ptx/nl))
	@$(foreach file, $(SDL2_TEST_DATA), \
	     install -vD -m 0644 $(SDL2_TEST_DIR)/$(SDL2_TEST_SUBDIR)/$(file) \
	       $(SDL2_TEST_PKGDIR)/usr/bin/sdl2tests/$(file)$(ptx/nl))
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl2-test.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl2-test)
	@$(call install_fixup, sdl2-test,PRIORITY,optional)
	@$(call install_fixup, sdl2-test,SECTION,base)
	@$(call install_fixup, sdl2-test,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, sdl2-test,DESCRIPTION,missing)

	@$(foreach file, $(SDL2_TEST_TOOLS), \
		$(call install_copy, sdl2-test, 0, 0, 755, -, \
				/usr/bin/sdl2tests/$(file))$(ptx/nl))

	@$(foreach file, $(SDL2_TEST_DATA), \
		$(call install_copy, sdl2-test, 0, 0, 644, -, \
				/usr/bin/sdl2tests/$(file))$(ptx/nl))

	@$(call install_finish, sdl2-test)

	@$(call touch)

# vim: syntax=make
