# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_X11) += host-xorg-lib-x11

#
# Paths and names
#
HOST_XORG_LIB_X11	= $(XORG_LIB_X11)
HOST_XORG_LIB_X11_DIR	= $(HOST_BUILDDIR)/$(HOST_XORG_LIB_X11)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-xorg-lib-x11_get: $(STATEDIR)/host-xorg-lib-x11.get

$(STATEDIR)/host-xorg-lib-x11.get: $(STATEDIR)/xorg-lib-x11.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-xorg-lib-x11_extract: $(STATEDIR)/host-xorg-lib-x11.extract

$(STATEDIR)/host-xorg-lib-x11.extract: $(host-xorg-lib-x11_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_X11_DIR))
	@$(call extract, XORG_LIB_X11, $(HOST_BUILDDIR))
	@$(call patchin, XORG_LIB_X11, $(HOST_XORG_LIB_X11_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-xorg-lib-x11_prepare: $(STATEDIR)/host-xorg-lib-x11.prepare

HOST_XORG_LIB_X11_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_LIB_X11_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_LIB_X11_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--disable-man-pages \
	--disable-specs

$(STATEDIR)/host-xorg-lib-x11.prepare: $(host-xorg-lib-x11_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_XORG_LIB_X11_DIR)/config.cache)
	cd $(HOST_XORG_LIB_X11_DIR) && \
		$(HOST_XORG_LIB_X11_PATH) $(HOST_XORG_LIB_X11_ENV) \
		./configure $(HOST_XORG_LIB_X11_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-xorg-lib-x11_compile: $(STATEDIR)/host-xorg-lib-x11.compile

$(STATEDIR)/host-xorg-lib-x11.compile: $(host-xorg-lib-x11_compile_deps_default)
	@$(call targetinfo, $@)
	# FIXME: CC_FOR_BUILD is a hack because of our broken patch; the
	# real solution is to modify the patch to use CC_FOR_BUILD only
	# when $cross_compiling is set. See nfsutils for example (rsc)
	cd $(HOST_XORG_LIB_X11_DIR) && $(HOST_XORG_LIB_X11_PATH) $(MAKE) $(PARALLELMFLAGS) CC_FOR_BUILD=$(HOSTCC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-xorg-lib-x11_install: $(STATEDIR)/host-xorg-lib-x11.install

$(STATEDIR)/host-xorg-lib-x11.install: $(host-xorg-lib-x11_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_XORG_LIB_X11,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-lib-x11_clean:
	rm -rf $(STATEDIR)/host-xorg-lib-x11.*
	rm -rf $(HOST_XORG_LIB_X11_DIR)

# vim: syntax=make
