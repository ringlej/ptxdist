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
PACKAGES-$(PTXCONF_XORG_LIB_XDMCP) += xorg-lib-Xdmcp

#
# Paths and names
#
XORG_LIB_XDMCP_VERSION	:= 1.0.1
XORG_LIB_XDMCP		:= libXdmcp-X11R7.1-$(XORG_LIB_XDMCP_VERSION)
XORG_LIB_XDMCP_SUFFIX	:= tar.bz2
XORG_LIB_XDMCP_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/lib/$(XORG_LIB_XDMCP).$(XORG_LIB_XDMCP_SUFFIX)
XORG_LIB_XDMCP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XDMCP).$(XORG_LIB_XDMCP_SUFFIX)
XORG_LIB_XDMCP_DIR	:= $(BUILDDIR)/$(XORG_LIB_XDMCP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xdmcp_get: $(STATEDIR)/xorg-lib-Xdmcp.get

$(STATEDIR)/xorg-lib-Xdmcp.get: $(xorg-lib-Xdmcp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XDMCP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XDMCP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xdmcp_extract: $(STATEDIR)/xorg-lib-Xdmcp.extract

$(STATEDIR)/xorg-lib-Xdmcp.extract: $(xorg-lib-Xdmcp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XDMCP_DIR))
	@$(call extract, XORG_LIB_XDMCP)
	@$(call patchin, XORG_LIB_XDMCP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xdmcp_prepare: $(STATEDIR)/xorg-lib-Xdmcp.prepare

XORG_LIB_XDMCP_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XDMCP_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XDMCP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/xorg-lib-Xdmcp.prepare: $(xorg-lib-Xdmcp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XDMCP_DIR)/config.cache)
	cd $(XORG_LIB_XDMCP_DIR) && \
		$(XORG_LIB_XDMCP_PATH) $(XORG_LIB_XDMCP_ENV) \
		./configure $(XORG_LIB_XDMCP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xdmcp_compile: $(STATEDIR)/xorg-lib-Xdmcp.compile

$(STATEDIR)/xorg-lib-Xdmcp.compile: $(xorg-lib-Xdmcp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XDMCP_DIR) && $(XORG_LIB_XDMCP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xdmcp_install: $(STATEDIR)/xorg-lib-Xdmcp.install

$(STATEDIR)/xorg-lib-Xdmcp.install: $(xorg-lib-Xdmcp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XDMCP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xdmcp_targetinstall: $(STATEDIR)/xorg-lib-Xdmcp.targetinstall

$(STATEDIR)/xorg-lib-Xdmcp.targetinstall: $(xorg-lib-Xdmcp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xdmcp)
	@$(call install_fixup, xorg-lib-Xdmcp,PACKAGE,xorg-lib-xdmcp)
	@$(call install_fixup, xorg-lib-Xdmcp,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xdmcp,VERSION,$(XORG_LIB_XDMCP_VERSION))
	@$(call install_fixup, xorg-lib-Xdmcp,SECTION,base)
	@$(call install_fixup, xorg-lib-Xdmcp,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xdmcp,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xdmcp,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xdmcp, 0, 0, 0644, \
		$(XORG_LIB_XDMCP_DIR)/.libs/libXdmcp.so.6.0.0, \
		$(XORG_LIBDIR)/libXdmcp.so.6.0.0)

	@$(call install_link, xorg-lib-Xdmcp, \
		libXdmcp.so.6.0.0, \
		$(XORG_LIBDIR)/libXdmcp.so.6)

	@$(call install_link, xorg-lib-Xdmcp, \
		libXdmcp.so.6.0.0, \
		$(XORG_LIBDIR)/libXdmcp.so)

	@$(call install_finish, xorg-lib-Xdmcp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xdmcp_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xdmcp.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xdmcp_*
	rm -rf $(XORG_LIB_XDMCP_DIR)

# vim: syntax=make
