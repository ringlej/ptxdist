# -*-makefile-*-
# $Id: template 5989 2006-08-09 15:21:14Z mkl $
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
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

xawtv_get: $(STATEDIR)/xawtv.get

$(STATEDIR)/xawtv.get: $(xawtv_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XAWTV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XAWTV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xawtv_extract: $(STATEDIR)/xawtv.extract

$(STATEDIR)/xawtv.extract: $(xawtv_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XAWTV_DIR))
	@$(call extract, XAWTV)
	@$(call patchin, XAWTV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xawtv_prepare: $(STATEDIR)/xawtv.prepare

XAWTV_PATH	:= PATH=$(CROSS_PATH)
XAWTV_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XAWTV_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--includedir=$(SYSROOT)/usr/include

$(STATEDIR)/xawtv.prepare: $(xawtv_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XAWTV_DIR)/config.cache)
	cd $(XAWTV_DIR) && \
		$(XAWTV_PATH) $(XAWTV_ENV) \
		./configure $(XAWTV_AUTOCONF) --disable-mmx
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xawtv_compile: $(STATEDIR)/xawtv.compile

$(STATEDIR)/xawtv.compile: $(xawtv_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XAWTV_DIR) \
	&& $(XAWTV_PATH) make \
		CPPFLAGS="$(CROSS_CPPFLAGS)" \
		verbose=yes \
		LDFLAGS_CUST="-L$(SYSROOT)/usr/lib -L$(SYSROOT)/lib -Wl,-rpath-link -Wl,$(SYSROOT)/usr/lib" \
		SYSROOT=$(SYSROOT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xawtv_install: $(STATEDIR)/xawtv.install

$(STATEDIR)/xawtv.install: $(xawtv_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XAWTV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xawtv_targetinstall: $(STATEDIR)/xawtv.targetinstall

$(STATEDIR)/xawtv.targetinstall: $(xawtv_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xawtv)
	@$(call install_fixup,xawtv,PACKAGE,xawtv)
	@$(call install_fixup,xawtv,PRIORITY,optional)
	@$(call install_fixup,xawtv,VERSION,$(XAWTV_VERSION))
	@$(call install_fixup,xawtv,SECTION,base)
	@$(call install_fixup,xawtv,AUTHOR,"Luotao Fu <lfu\@pengutronix.de>")
	@$(call install_fixup,xawtv,DEPENDS,)
	@$(call install_fixup,xawtv,DESCRIPTION,missing)

	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/dump-mixers, /usr/bin/dump-mixers)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/record, /usr/bin/record)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/showriff, /usr/bin/showriff)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/showqt, /usr/bin/showqt)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/streamer, /usr/bin/streamer)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/webcam, /usr/bin/webcam)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/radio, /usr/bin/radio)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/fbtv, /usr/bin/fbtv)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/v4l-info, /usr/bin/v4l-info)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/console/v4l-conf, /usr/bin/v4l-conf)

	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/x11/v4lctl, /usr/bin/v4lctl)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/x11/propwatch, /usr/bin/propwatch)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/x11/xawtv-remote, /usr/bin/xawtv-remote)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/x11/rootv, /usr/bin/rootv)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/x11/xawtv, /usr/bin/xawtv)
	@$(call install_copy, xawtv, 0, 0, 0755, $(XAWTV_DIR)/x11/pia, /usr/bin/pia)

	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/flt-gamma.so, /usr/lib/xawtv/flt-gamma.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/flt-invert.so, /usr/lib/xawtv/flt-invert.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/flt-disor.so, /usr/lib/xawtv/flt-disor.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/conv-mjpeg.so, /usr/lib/xawtv/conv-mjpeg.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/read-avi.so, /usr/lib/xawtv/read-avi.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/write-avi.so, /usr/lib/xawtv/write-avi.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/drv0-v4l2.so, /usr/lib/xawtv/drv0-v4l2.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/drv0-v4l2-old.so, /usr/lib/xawtv/drv0-v4l2-old.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/drv1-v4l.so, /usr/lib/xawtv/drv1-v4l.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/plugins/snd-oss.so, /usr/lib/xawtv/snd-oss.so)

	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/contrib-plugins/flt-smooth.so, /usr/lib/xawtv/flt-smooth.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/contrib-plugins/bilinear.so, /usr/lib/xawtv/bilinear.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/contrib-plugins/cubic.so, /usr/lib/xawtv/cubic.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/contrib-plugins/linear-blend.so, /usr/lib/xawtv/linear-blend.so)
	@$(call install_copy, xawtv, 0, 0, 0644, $(XAWTV_DIR)/libng/contrib-plugins/linedoubler.so, /usr/lib/xawtv/linedoubler.so)

	@$(call install_finish,xawtv)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xawtv_clean:
	rm -rf $(STATEDIR)/xawtv.*
	rm -rf $(IMAGEDIR)/xawtv_*
	rm -rf $(XAWTV_DIR)

# vim: syntax=make
