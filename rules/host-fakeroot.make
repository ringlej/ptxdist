# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FAKEROOT) += host-fakeroot

#
# Paths and names
#
HOST_FAKEROOT_VERSION	= 1.5.1
HOST_FAKEROOT		= fakeroot-$(HOST_FAKEROOT_VERSION)
HOST_FAKEROOT_SUFFIX	= tar.gz
HOST_FAKEROOT_URL	= http://www.pengutronix.de/software/ptxdist/temporary-src/fakeroot_$(HOST_FAKEROOT_VERSION).$(HOST_FAKEROOT_SUFFIX)
HOST_FAKEROOT_SOURCE	= $(SRCDIR)/fakeroot_$(HOST_FAKEROOT_VERSION).$(HOST_FAKEROOT_SUFFIX)
HOST_FAKEROOT_DIR	= $(HOST_BUILDDIR)/$(HOST_FAKEROOT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-fakeroot_get: $(STATEDIR)/host-fakeroot.get

$(STATEDIR)/host-fakeroot.get: $(host-fakeroot_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_FAKEROOT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_FAKEROOT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-fakeroot_extract: $(STATEDIR)/host-fakeroot.extract

$(STATEDIR)/host-fakeroot.extract: $(host-fakeroot_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_FAKEROOT_DIR))
	@$(call extract, HOST_FAKEROOT, $(HOST_BUILDDIR))
	@$(call patchin, HOST_FAKEROOT,$(HOST_FAKEROOT_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-fakeroot_prepare: $(STATEDIR)/host-fakeroot.prepare

HOST_FAKEROOT_PATH	:= PATH=$(HOST_PATH)
HOST_FAKEROOT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_FAKEROOT_AUTOCONF:= \
	$(HOST_AUTOCONF) \
	--without-po4a

$(STATEDIR)/host-fakeroot.prepare: $(host-fakeroot_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_FAKEROOT_DIR)/config.cache)
	cd $(HOST_FAKEROOT_DIR) && \
		$(HOST_FAKEROOT_PATH) $(HOST_FAKEROOT_ENV) \
		./configure $(HOST_FAKEROOT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-fakeroot_compile: $(STATEDIR)/host-fakeroot.compile

$(STATEDIR)/host-fakeroot.compile: $(host-fakeroot_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_FAKEROOT_DIR) && $(HOST_FAKEROOT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-fakeroot_install: $(STATEDIR)/host-fakeroot.install

$(STATEDIR)/host-fakeroot.install: $(host-fakeroot_install_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_FAKEROOT_DIR) &&					\
		$(HOST_FAKEROOT_ENV) $(HOST_FAKEROOT_PATH) 		\
		make install $(HOST_FAKEROOT_MAKEVARS)			
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-fakeroot_targetinstall: $(STATEDIR)/host-fakeroot.targetinstall

$(STATEDIR)/host-fakeroot.targetinstall: $(host-fakeroot_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-fakeroot_clean:
	rm -rf $(STATEDIR)/host-fakeroot.*
	rm -rf $(HOST_FAKEROOT_DIR)

# vim: syntax=make
