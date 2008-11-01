# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FUSE) += fuse

#
# Paths and names
#
FUSE_VERSION	:= 2.7.4
FUSE		:= fuse-$(FUSE_VERSION)
FUSE_SUFFIX	:= tar.gz
FUSE_URL	:= $(PTXCONF_SETUP_SFMIRROR)/fuse/$(FUSE).$(FUSE_SUFFIX)
FUSE_SOURCE	:= $(SRCDIR)/$(FUSE).$(FUSE_SUFFIX)
FUSE_DIR	:= $(BUILDDIR)/$(FUSE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fuse_get: $(STATEDIR)/fuse.get

$(STATEDIR)/fuse.get: $(fuse_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FUSE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FUSE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fuse_extract: $(STATEDIR)/fuse.extract

$(STATEDIR)/fuse.extract: $(fuse_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FUSE_DIR))
	@$(call extract, FUSE)
	@$(call patchin, FUSE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fuse_prepare: $(STATEDIR)/fuse.prepare

FUSE_PATH	:= PATH=$(CROSS_PATH)
FUSE_ENV	:= $(CROSS_ENV)

#
# autoconf
#
FUSE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-example \
	--disable-mtab \
	--disable-rpath

ifdef PTXCONF_FUSE__KERNEL_MODULE
FUSE_AUTOCONF += --enable-kernel-module
else
FUSE_AUTOCONF += --disable-kernel-module
endif
ifdef PTXCONF_FUSE__LIB
FUSE_AUTOCONF += --enable-lib
else
FUSE_AUTOCONF += --disable-lib
endif
ifdef PTXCONF_FUSE__UTIL
FUSE_AUTOCONF += --enable-util
else
FUSE_AUTOCONF += --disable-util
endif

$(STATEDIR)/fuse.prepare: $(fuse_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FUSE_DIR)/config.cache)
	cd $(FUSE_DIR) && \
		$(FUSE_PATH) $(FUSE_ENV) \
		./configure $(FUSE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fuse_compile: $(STATEDIR)/fuse.compile

$(STATEDIR)/fuse.compile: $(fuse_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FUSE_DIR) && $(FUSE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fuse_install: $(STATEDIR)/fuse.install

$(STATEDIR)/fuse.install: $(fuse_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FUSE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fuse_targetinstall: $(STATEDIR)/fuse.targetinstall

$(STATEDIR)/fuse.targetinstall: $(fuse_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, fuse)
	@$(call install_fixup, fuse,PACKAGE,fuse)
	@$(call install_fixup, fuse,PRIORITY,optional)
	@$(call install_fixup, fuse,VERSION,$(FUSE_VERSION))
	@$(call install_fixup, fuse,SECTION,base)
	@$(call install_fixup, fuse,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, fuse,DEPENDS,)
	@$(call install_fixup, fuse,DESCRIPTION,missing)

ifdef PTXCONF_FUSE__LIB
	@$(call install_copy, fuse, 0, 0, 0644, \
		$(FUSE_DIR)/lib/.libs/libfuse.so.2.7.4, \
		/usr/lib/libfuse.so.2.7.4)
	@$(call install_link, fuse, libfuse.so.2.7.4, /usr/lib/libfuse.so)
	@$(call install_link, fuse, libfuse.so.2.7.4, /usr/lib/libfuse.so.2)

	@$(call install_copy, fuse, 0, 0, 0644, \
		$(FUSE_DIR)/lib/.libs/libulockmgr.so.1.0.1, \
		/usr/lib/libulockmgr.so.1.0.1)
	@$(call install_link, fuse, libulockmgr.so.1.0.1, /usr/lib/libulockmgr.so)
	@$(call install_link, fuse, libulockmgr.so.1.0.1, /usr/lib/libulockmgr.so.1)
endif
ifdef PTXCONF_FUSE__UTIL
	@$(call install_copy, fuse, 0, 0, 0755, $(FUSE_DIR)/util/fusermount, /usr/bin/fusermount)
	@$(call install_copy, fuse, 0, 0, 0755, $(FUSE_DIR)/util/ulockmgr_server, /usr/bin/ulockmgr_server)
endif
	@$(call install_finish, fuse)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fuse_clean:
	rm -rf $(STATEDIR)/fuse.*
	rm -rf $(PKGDIR)/fuse_*
	rm -rf $(FUSE_DIR)

# vim: syntax=make
