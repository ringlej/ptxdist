# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
HOST_PACKAGES-$(PTXCONF_HOST_MKELFIMAGE) += host-mkelfImage

#
# Paths and names
#
HOST_MKELFIMAGE_VERSION	:= 2.7
HOST_MKELFIMAGE		:= mkelfImage-$(HOST_MKELFIMAGE_VERSION)
HOST_MKELFIMAGE_SUFFIX	:= tar.gz
HOST_MKELFIMAGE_URL	:= ftp://ftp.lnxi.com/pub/mkelfImage/$(HOST_MKELFIMAGE).$(HOST_MKELFIMAGE_SUFFIX)
HOST_MKELFIMAGE_SOURCE	:= $(SRCDIR)/$(HOST_MKELFIMAGE).$(HOST_MKELFIMAGE_SUFFIX)
HOST_MKELFIMAGE_DIR	:= $(HOST_BUILDDIR)/$(HOST_MKELFIMAGE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-mkelfImage_get: $(STATEDIR)/host-mkelfImage.get

$(STATEDIR)/host-mkelfImage.get: $(host-mkelfImage_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_MKELFIMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_MKELFIMAGE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mkelfImage_extract: $(STATEDIR)/host-mkelfImage.extract

$(STATEDIR)/host-mkelfImage.extract: $(host-mkelfImage_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKELFIMAGE_DIR))
	@$(call extract, HOST_MKELFIMAGE, $(HOST_BUILDDIR))
	@$(call patchin, HOST_MKELFIMAGE, $(HOST_MKELFIMAGE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mkelfImage_prepare: $(STATEDIR)/host-mkelfImage.prepare

HOST_MKELFIMAGE_PATH	:= PATH=$(HOST_PATH)
HOST_MKELFIMAGE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_MKELFIMAGE_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-mkelfImage.prepare: $(host-mkelfImage_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKELFIMAGE_DIR)/config.cache)
	cd $(HOST_MKELFIMAGE_DIR) && \
		$(HOST_MKELFIMAGE_PATH) $(HOST_MKELFIMAGE_ENV) \
		./configure $(HOST_MKELFIMAGE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mkelfImage_compile: $(STATEDIR)/host-mkelfImage.compile


$(STATEDIR)/host-mkelfImage.compile: $(host-mkelfImage_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MKELFIMAGE_DIR) && $(HOST_MKELFIMAGE_ENV) $(HOST_MKELFIMAGE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mkelfImage_install: $(STATEDIR)/host-mkelfImage.install

$(STATEDIR)/host-mkelfImage.install: $(host-mkelfImage_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_MKELFIMAGE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mkelfImage_clean:
	rm -rf $(STATEDIR)/host-mkelfImage.*
	rm -rf $(HOST_MKELFIMAGE_DIR)

# vim: syntax=make
