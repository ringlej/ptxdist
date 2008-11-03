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
PACKAGES-$(PTXCONF_XORG_LIB_XDMCP) += xorg-lib-xdmcp

#
# Paths and names
#
XORG_LIB_XDMCP_VERSION	:= 1.0.2
XORG_LIB_XDMCP		:= libXdmcp-$(XORG_LIB_XDMCP_VERSION)
XORG_LIB_XDMCP_SUFFIX	:= tar.bz2
XORG_LIB_XDMCP_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XDMCP).$(XORG_LIB_XDMCP_SUFFIX)
XORG_LIB_XDMCP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XDMCP).$(XORG_LIB_XDMCP_SUFFIX)
XORG_LIB_XDMCP_DIR	:= $(BUILDDIR)/$(XORG_LIB_XDMCP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xdmcp_get: $(STATEDIR)/xorg-lib-xdmcp.get

$(STATEDIR)/xorg-lib-xdmcp.get: $(xorg-lib-xdmcp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XDMCP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XDMCP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xdmcp_extract: $(STATEDIR)/xorg-lib-xdmcp.extract

$(STATEDIR)/xorg-lib-xdmcp.extract: $(xorg-lib-xdmcp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XDMCP_DIR))
	@$(call extract, XORG_LIB_XDMCP)
	@$(call patchin, XORG_LIB_XDMCP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xdmcp_prepare: $(STATEDIR)/xorg-lib-xdmcp.prepare

XORG_LIB_XDMCP_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XDMCP_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XDMCP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/xorg-lib-xdmcp.prepare: $(xorg-lib-xdmcp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XDMCP_DIR)/config.cache)
	cd $(XORG_LIB_XDMCP_DIR) && \
		$(XORG_LIB_XDMCP_PATH) $(XORG_LIB_XDMCP_ENV) \
		./configure $(XORG_LIB_XDMCP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xdmcp_compile: $(STATEDIR)/xorg-lib-xdmcp.compile

$(STATEDIR)/xorg-lib-xdmcp.compile: $(xorg-lib-xdmcp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XDMCP_DIR) && $(XORG_LIB_XDMCP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xdmcp_install: $(STATEDIR)/xorg-lib-xdmcp.install

$(STATEDIR)/xorg-lib-xdmcp.install: $(xorg-lib-xdmcp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XDMCP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xdmcp_targetinstall: $(STATEDIR)/xorg-lib-xdmcp.targetinstall

$(STATEDIR)/xorg-lib-xdmcp.targetinstall: $(xorg-lib-xdmcp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  xorg-lib-xdmcp)
	@$(call install_fixup, xorg-lib-xdmcp,PACKAGE,xorg-lib-xdmcp)
	@$(call install_fixup, xorg-lib-xdmcp,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xdmcp,VERSION,$(XORG_LIB_XDMCP_VERSION))
	@$(call install_fixup, xorg-lib-xdmcp,SECTION,base)
	@$(call install_fixup, xorg-lib-xdmcp,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xdmcp,DEPENDS,)
	@$(call install_fixup, xorg-lib-xdmcp,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xdmcp, 0, 0, 0644, \
		$(XORG_LIB_XDMCP_DIR)/.libs/libXdmcp.so.6.0.0, \
		$(XORG_LIBDIR)/libXdmcp.so.6.0.0)

	@$(call install_link, xorg-lib-xdmcp, \
		libXdmcp.so.6.0.0, \
		$(XORG_LIBDIR)/libXdmcp.so.6)

	@$(call install_link, xorg-lib-xdmcp, \
		libXdmcp.so.6.0.0, \
		$(XORG_LIBDIR)/libXdmcp.so)

	@$(call install_finish, xorg-lib-xdmcp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xdmcp_clean:
	rm -rf $(STATEDIR)/xorg-lib-xdmcp.*
	rm -rf $(PKGDIR)/xorg-lib-xdmcp_*
	rm -rf $(XORG_LIB_XDMCP_DIR)

# vim: syntax=make
