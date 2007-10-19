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
PACKAGES-$(PTXCONF_XORG_LIB_XINERAMA) += xorg-lib-Xinerama

#
# Paths and names
#
XORG_LIB_XINERAMA_VERSION	:= 1.0.2
XORG_LIB_XINERAMA		:= libXinerama-$(XORG_LIB_XINERAMA_VERSION)
XORG_LIB_XINERAMA_SUFFIX	:= tar.bz2
XORG_LIB_XINERAMA_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib//$(XORG_LIB_XINERAMA).$(XORG_LIB_XINERAMA_SUFFIX)
XORG_LIB_XINERAMA_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XINERAMA).$(XORG_LIB_XINERAMA_SUFFIX)
XORG_LIB_XINERAMA_DIR		:= $(BUILDDIR)/$(XORG_LIB_XINERAMA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xinerama_get: $(STATEDIR)/xorg-lib-Xinerama.get

$(STATEDIR)/xorg-lib-Xinerama.get: $(xorg-lib-Xinerama_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XINERAMA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XINERAMA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xinerama_extract: $(STATEDIR)/xorg-lib-Xinerama.extract

$(STATEDIR)/xorg-lib-Xinerama.extract: $(xorg-lib-Xinerama_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XINERAMA_DIR))
	@$(call extract, XORG_LIB_XINERAMA)
	@$(call patchin, XORG_LIB_XINERAMA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xinerama_prepare: $(STATEDIR)/xorg-lib-Xinerama.prepare

XORG_LIB_XINERAMA_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XINERAMA_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XINERAMA_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-Xinerama.prepare: $(xorg-lib-Xinerama_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XINERAMA_DIR)/config.cache)
	cd $(XORG_LIB_XINERAMA_DIR) && \
		$(XORG_LIB_XINERAMA_PATH) $(XORG_LIB_XINERAMA_ENV) \
		./configure $(XORG_LIB_XINERAMA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xinerama_compile: $(STATEDIR)/xorg-lib-Xinerama.compile

$(STATEDIR)/xorg-lib-Xinerama.compile: $(xorg-lib-Xinerama_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XINERAMA_DIR) && $(XORG_LIB_XINERAMA_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xinerama_install: $(STATEDIR)/xorg-lib-Xinerama.install

$(STATEDIR)/xorg-lib-Xinerama.install: $(xorg-lib-Xinerama_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XINERAMA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xinerama_targetinstall: $(STATEDIR)/xorg-lib-Xinerama.targetinstall

$(STATEDIR)/xorg-lib-Xinerama.targetinstall: $(xorg-lib-Xinerama_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xinerama)
	@$(call install_fixup, xorg-lib-Xinerama,PACKAGE,xorg-lib-xinerama)
	@$(call install_fixup, xorg-lib-Xinerama,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xinerama,VERSION,$(XORG_LIB_XINERAMA_VERSION))
	@$(call install_fixup, xorg-lib-Xinerama,SECTION,base)
	@$(call install_fixup, xorg-lib-Xinerama,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xinerama,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xinerama,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xinerama, 0, 0, 0644, \
		$(XORG_LIB_XINERAMA_DIR)/src/.libs/libXinerama.so.1.0.0, \
		$(XORG_LIBDIR)/libXinerama.so.1.0.0)

	@$(call install_link, xorg-lib-Xinerama, \
		libXinerama.so.1.0.0, \
		$(XORG_LIBDIR)/libXinerama.so.1)

	@$(call install_link, xorg-lib-Xinerama, \
		libXinerama.so.1.0.0, \
		$(XORG_LIBDIR)/libXinerama.so)

	@$(call install_finish, xorg-lib-Xinerama)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xinerama_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xinerama.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xinerama_*
	rm -rf $(XORG_LIB_XINERAMA_DIR)

# vim: syntax=make
