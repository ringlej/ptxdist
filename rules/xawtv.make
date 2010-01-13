# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XAWTV) += xawtv

#
# Paths and names
#
XAWTV_VERSION	:= 3.95
XAWTV		:= xawtv-$(XAWTV_VERSION)
XAWTV_SUFFIX	:= tar.gz
XAWTV_URL	:= http://dl.bytesex.org/releases/xawtv//$(XAWTV).$(XAWTV_SUFFIX)
XAWTV_SOURCE	:= $(SRCDIR)/$(XAWTV).$(XAWTV_SUFFIX)
XAWTV_DIR	:= $(BUILDDIR)/$(XAWTV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XAWTV_SOURCE):
	@$(call targetinfo)
	@$(call get, XAWTV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XAWTV_PATH	:= PATH=$(CROSS_PATH)
XAWTV_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XAWTV_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--includedir=$(SYSROOT)/usr/include \
	--disable-mmx

XAWTV_MAKE_OPT = \
	CPPFLAGS="$(CROSS_CPPFLAGS)" \
	LDFLAGS_CUST="$(CROSS_LDFLAGS)" \
	SYSROOT=$(SYSROOT) \
	verbose=yes

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xawtv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xawtv)
	@$(call install_fixup,xawtv,PACKAGE,xawtv)
	@$(call install_fixup,xawtv,PRIORITY,optional)
	@$(call install_fixup,xawtv,VERSION,$(XAWTV_VERSION))
	@$(call install_fixup,xawtv,SECTION,base)
	@$(call install_fixup,xawtv,AUTHOR,"Luotao Fu <lfu@pengutronix.de>")
	@$(call install_fixup,xawtv,DEPENDS,)
	@$(call install_fixup,xawtv,DESCRIPTION,missing)

	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/dump-mixers)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/record)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/showriff)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/showqt)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/streamer)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/webcam)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/radio)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/fbtv)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/v4l-info)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/v4l-conf)

	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/v4lctl)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/propwatch)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/xawtv-remote)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/rootv)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/xawtv)
	@$(call install_copy, xawtv, 0, 0, 0755, -, /usr/bin/pia)

	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/flt-gamma.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/flt-invert.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/flt-disor.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/conv-mjpeg.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/read-avi.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/write-avi.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/drv0-v4l2.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/drv0-v4l2-old.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/drv1-v4l.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/snd-oss.so)

	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/flt-smooth.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/bilinear.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/cubic.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/linear-blend.so)
	@$(call install_copy, xawtv, 0, 0, 0644, -, /usr/lib/xawtv/linedoubler.so)

	@$(call install_finish,xawtv)

	@$(call touch)

# vim: syntax=make
