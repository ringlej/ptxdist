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
HOST_PACKAGES-$(PTXCONF_HOST_MKELFIMAGE) += host-mkelfimage

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

host-mkelfimage_get: $(STATEDIR)/host-mkelfimage.get

$(STATEDIR)/host-mkelfimage.get: $(host-mkelfimage_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_MKELFIMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_MKELFIMAGE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mkelfimage_extract: $(STATEDIR)/host-mkelfimage.extract

$(STATEDIR)/host-mkelfimage.extract: $(host-mkelfimage_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKELFIMAGE_DIR))
	@$(call extract, HOST_MKELFIMAGE, $(HOST_BUILDDIR))
	@$(call patchin, HOST_MKELFIMAGE, $(HOST_MKELFIMAGE_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mkelfimage_prepare: $(STATEDIR)/host-mkelfimage.prepare

HOST_MKELFIMAGE_PATH	:= PATH=$(HOST_PATH)
HOST_MKELFIMAGE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_MKELFIMAGE_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-mkelfimage.prepare: $(host-mkelfimage_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKELFIMAGE_DIR)/config.cache)
	cd $(HOST_MKELFIMAGE_DIR) && \
		$(HOST_MKELFIMAGE_PATH) $(HOST_MKELFIMAGE_ENV) \
		./configure $(HOST_MKELFIMAGE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mkelfimage_compile: $(STATEDIR)/host-mkelfimage.compile


$(STATEDIR)/host-mkelfimage.compile: $(host-mkelfimage_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MKELFIMAGE_DIR) && $(HOST_MKELFIMAGE_PATH) make \
		MY_CPPFLAGS="$(HOST_CPPFLAGS)" LDFLAGS="$(HOST_LDFLAGS)"
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mkelfimage_install: $(STATEDIR)/host-mkelfimage.install

$(STATEDIR)/host-mkelfimage.install: $(host-mkelfimage_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_MKELFIMAGE,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mkelfimage_clean:
	rm -rf $(STATEDIR)/host-mkelfimage.*
	rm -rf $(HOST_MKELFIMAGE_DIR)

# vim: syntax=make
