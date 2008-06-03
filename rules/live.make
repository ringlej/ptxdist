# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIVE_LIB) += live

#
# Paths and names
#
LIVE_LIB_VERSION	:= 2006.10.27
LIVE_LIB		:= live.$(LIVE_LIB_VERSION)
LIVE_LIB_SUFFIX		:= tar.gz
LIVE_LIB_URL		:= http://www.live555.com/liveMedia/public/$(LIVE_LIB).$(LIVE_LIB_SUFFIX)
LIVE_LIB_SOURCE		:= $(SRCDIR)/$(LIVE_LIB).$(LIVE_LIB_SUFFIX)
LIVE_LIB_DIR		:= $(BUILDDIR)/live


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

live_get: $(STATEDIR)/live.get

$(STATEDIR)/live.get: $(live_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIVE_LIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIVE_LIB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

live_extract: $(STATEDIR)/live.extract

$(STATEDIR)/live.extract: $(live_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIVE_LIB_DIR))
	@$(call extract, LIVE_LIB)
	@$(call patchin, LIVE_LIB, $(LIVE_LIB_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

live_prepare: $(STATEDIR)/live.prepare

LIVE_LIB_PATH	:=  PATH=$(CROSS_PATH)
LIVE_LIB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
LIVE_LIB_AUTOCONF := $(CROSS_AUTOCONF_USR)
#LIVE_LIB_AUTOCONF += --disable-static
#LIVE_LIB_AUTOCONF += --enable-shared

$(STATEDIR)/live.prepare: $(live_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIVE_LIB_DIR)/config.cache)
	cd $(LIVE_LIB_DIR) && \
		$(LIVE_LIB_PATH) $(LIVE_LIB_ENV) \
		./configure $(LIVE_LIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

live_compile: $(STATEDIR)/live.compile

$(STATEDIR)/live.compile: $(live_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIVE_LIB_DIR) && $(LIVE_LIB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

live_install: $(STATEDIR)/live.install

$(STATEDIR)/live.install: $(live_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIVE_LIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

live_targetinstall: $(STATEDIR)/live.targetinstall

$(STATEDIR)/live.targetinstall: $(live_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, live)
	@$(call install_fixup, live,PACKAGE,live)
	@$(call install_fixup, live,PRIORITY,optional)
	@$(call install_fixup, live,VERSION,$(LIVE_LIB_VERSION))
	@$(call install_fixup, live,SECTION,base)
	@$(call install_fixup, live,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, live,DEPENDS,)
	@$(call install_fixup, live,DESCRIPTION,missing)

	@$(call install_copy, live, 0, 0, 0644, \
		$(LIVE_LIB_DIR)/BasicUsageEnvironment/.libs/libBasicUsageEnvironment.so.6.5.17, \
		/usr/lib/libBasicUsageEnvironment.so.6.5.17, n)
	@$(call install_link, live, \
		libBasicUsageEnvironment.so.6.5.17, \
		/usr/lib/libBasicUsageEnvironment.so.6)
	@$(call install_link, live, \
		libBasicUsageEnvironment.so.6.5.17, \
		/usr/lib/libBasicUsageEnvironment.so)

	@$(call install_copy, live, 0, 0, 0644, \
		$(LIVE_LIB_DIR)/groupsock/.libs/libgroupsock.so.6.5.17, \
		/usr/lib/libgroupsock.so.6.5.17, n)
	@$(call install_link, live, \
		libgroupsock.so.6.5.17, \
		/usr/lib/libgroupsock.so.6)
	@$(call install_link, live, \
		libgroupsock.so.6.5.17, \
		/usr/lib/libgroupsock.so)

	@$(call install_copy, live, 0, 0, 0644, \
		$(LIVE_LIB_DIR)/liveMedia/.libs/libliveMedia.so.6.5.17, \
		/usr/lib/libliveMedia.so.6.5.17, n)
	@$(call install_link, live, \
		libliveMedia.so.6.5.17, \
		/usr/lib/libliveMedia.so.6)
	@$(call install_link, live, \
		libliveMedia.so.6.5.17, \
		/usr/lib/libliveMedia.so)

	@$(call install_copy, live, 0, 0, 0644, \
		$(LIVE_LIB_DIR)/UsageEnvironment/.libs/libUsageEnvironment.so.6.5.17, \
		/usr/lib/libUsageEnvironment.so.6.5.17, n)
	@$(call install_link, live, \
		libUsageEnvironment.so.6.5.17, \
		/usr/lib/libUsageEnvironment.so.6)
	@$(call install_link, live, \
		libUsageEnvironment.so.6.5.17, \
		/usr/lib/libUsageEnvironment.so)

	@$(call install_finish, live)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

live_clean:
	rm -rf $(STATEDIR)/live.*
	rm -rf $(PKGDIR)/live_*
	rm -rf $(LIVE_DIR)

# vim: syntax=make
