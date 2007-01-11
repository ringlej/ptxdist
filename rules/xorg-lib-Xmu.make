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
PACKAGES-$(PTXCONF_XORG_LIB_XMU) += xorg-lib-Xmu

#
# Paths and names
#
XORG_LIB_XMU_VERSION	:= 1.0.1
XORG_LIB_XMU		:= libXmu-X11R7.1-$(XORG_LIB_XMU_VERSION)
XORG_LIB_XMU_SUFFIX	:= tar.bz2
XORG_LIB_XMU_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/lib/$(XORG_LIB_XMU).$(XORG_LIB_XMU_SUFFIX)
XORG_LIB_XMU_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XMU).$(XORG_LIB_XMU_SUFFIX)
XORG_LIB_XMU_DIR	:= $(BUILDDIR)/$(XORG_LIB_XMU)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xmu_get: $(STATEDIR)/xorg-lib-Xmu.get

$(STATEDIR)/xorg-lib-Xmu.get: $(xorg-lib-Xmu_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XMU_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XMU)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xmu_extract: $(STATEDIR)/xorg-lib-Xmu.extract

$(STATEDIR)/xorg-lib-Xmu.extract: $(xorg-lib-Xmu_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XMU_DIR))
	@$(call extract, XORG_LIB_XMU)
	@$(call patchin, XORG_LIB_XMU)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xmu_prepare: $(STATEDIR)/xorg-lib-Xmu.prepare

XORG_LIB_XMU_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XMU_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XMU_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

ifdef PTXCONF_XORG_OPTIONS_TRANS_IPV6
XORG_LIB_XMU_AUTOCONF	+= --enable-ipv6
else
XORG_LIB_XMU_AUTOCONF	+= --disable-ipv6
endif

ifdef PTXCONF_XORG_OPTIONS_TRANS_UNIX
XORG_LIB_XMU_AUTOCONF	+= --enable-unix-transport
else
XORG_LIB_XMU_AUTOCONF	+= --disable-unix-transport
endif

ifdef PTXCONF_XORG_OPTIONS_TRANS_TCP
XORG_LIB_XMU_AUTOCONF	+= --enable-tcp-transport
else
XORG_LIB_XMU_AUTOCONF	+= --disable-tcp-transport
endif

$(STATEDIR)/xorg-lib-Xmu.prepare: $(xorg-lib-Xmu_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XMU_DIR)/config.cache)
	cd $(XORG_LIB_XMU_DIR) && \
		$(XORG_LIB_XMU_PATH) $(XORG_LIB_XMU_ENV) \
		./configure $(XORG_LIB_XMU_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xmu_compile: $(STATEDIR)/xorg-lib-Xmu.compile

$(STATEDIR)/xorg-lib-Xmu.compile: $(xorg-lib-Xmu_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XMU_DIR) && $(XORG_LIB_XMU_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xmu_install: $(STATEDIR)/xorg-lib-Xmu.install

$(STATEDIR)/xorg-lib-Xmu.install: $(xorg-lib-Xmu_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XMU)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xmu_targetinstall: $(STATEDIR)/xorg-lib-Xmu.targetinstall

$(STATEDIR)/xorg-lib-Xmu.targetinstall: $(xorg-lib-Xmu_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xmu)
	@$(call install_fixup, xorg-lib-Xmu,PACKAGE,xorg-lib-xmu)
	@$(call install_fixup, xorg-lib-Xmu,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xmu,VERSION,$(XORG_LIB_XMU_VERSION))
	@$(call install_fixup, xorg-lib-Xmu,SECTION,base)
	@$(call install_fixup, xorg-lib-Xmu,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xmu,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xmu,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xmu, 0, 0, 0644, \
		$(XORG_LIB_XMU_DIR)/src/.libs/libXmu.so.6.2.0, \
		$(XORG_LIBDIR)/libXmu.so.6.2.0)

	@$(call install_link, xorg-lib-Xmu, \
		libXmu.so.6.2.0, \
		$(XORG_LIBDIR)/libXmu.so.6)

	@$(call install_link, xorg-lib-Xmu, \
		libXmu.so.6.2.0, \
		$(XORG_LIBDIR)/libXmu.so)

	@$(call install_copy, xorg-lib-Xmu, 0, 0, 0644, \
		$(XORG_LIB_XMU_DIR)/src/.libs/libXmuu.so.1.0.0, \
		$(XORG_LIBDIR)/libXmuu.so.1.0.0)

	@$(call install_link, xorg-lib-Xmu, \
		libXmuu.so.1.0.0, \
		$(XORG_LIBDIR)/libXmuu.so.1)

	@$(call install_link, xorg-lib-Xmu, \
		libXmuu.so.1.0.0, \
		$(XORG_LIBDIR)/libXmuu.so)

	@$(call install_finish, xorg-lib-Xmu)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xmu_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xmu.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xmu_*
	rm -rf $(XORG_LIB_XMU_DIR)

# vim: syntax=make
