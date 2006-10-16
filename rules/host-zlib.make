# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


HOST_PACKAGES-$(PTXCONF_HOST_ZLIB) += host-zlib

#
# Paths and names
#
HOST_ZLIB		= $(ZLIB)
HOST_ZLIB_BUILDDIR	= $(HOST_BUILDDIR)/$(HOST_ZLIB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-zlib_get: $(STATEDIR)/host-zlib.get

$(STATEDIR)/host-zlib.get: $(STATEDIR)/zlib.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-zlib_extract: $(STATEDIR)/host-zlib.extract

$(STATEDIR)/host-zlib.extract: $(host_zlib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_ZLIB_BUILDDIR))
	@$(call extract, ZLIB, $(HOST_BUILDDIR))
	@$(call patchin, ZLIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-zlib_prepare: $(STATEDIR)/host-zlib.prepare

#
# autoconf without automake :-(
#

HOST_ZLIB_AUTOCONF	:=  --prefix=$(PTXCONF_HOST_PREFIX)/usr
HOST_ZLIB_MAKEVARS	:=  $(HOSTCC_ENV)

$(STATEDIR)/host-zlib.prepare: $(host_zlib_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_ZLIB_BUILDDIR) && \
		./configure $(HOST_ZLIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-zlib_compile: $(STATEDIR)/host-zlib.compile

$(STATEDIR)/host-zlib.compile: $(host_zlib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_ZLIB_BUILDDIR) && make $(HOST_ZLIB_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-zlib_install: $(STATEDIR)/host-zlib.install

$(STATEDIR)/host-zlib.install: $(host_zlib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_ZLIB, $(HOST_ZLIB_BUILDDIR),h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-zlib_targetinstall: $(STATEDIR)/host-zlib.targetinstall

$(STATEDIR)/host-zlib.targetinstall: $(host_zlib_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-zlib_clean:
	rm -rf $(STATEDIR)/host-zlib.*
	rm -rf $(HOST_ZLIB_BUILDDIR)

# vim: syntax=make
