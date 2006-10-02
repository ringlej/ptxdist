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
PACKAGES-$(PTXCONF_XORG_LIB_SM) += xorg-lib-SM

#
# Paths and names
#
XORG_LIB_SM_VERSION	:= 1.0.1
XORG_LIB_SM		:= libSM-X11R7.1-$(XORG_LIB_SM_VERSION)
XORG_LIB_SM_SUFFIX	:= tar.bz2
XORG_LIB_SM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/lib/$(XORG_LIB_SM).$(XORG_LIB_SM_SUFFIX)
XORG_LIB_SM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_SM).$(XORG_LIB_SM_SUFFIX)
XORG_LIB_SM_DIR		:= $(BUILDDIR)/$(XORG_LIB_SM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-SM_get: $(STATEDIR)/xorg-lib-SM.get

$(STATEDIR)/xorg-lib-SM.get: $(xorg-lib-SM_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_SM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_SM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-SM_extract: $(STATEDIR)/xorg-lib-SM.extract

$(STATEDIR)/xorg-lib-SM.extract: $(xorg-lib-SM_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_SM_DIR))
	@$(call extract, XORG_LIB_SM)
	@$(call patchin, XORG_LIB_SM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-SM_prepare: $(STATEDIR)/xorg-lib-SM.prepare

XORG_LIB_SM_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_SM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_SM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

ifdef PTXCONF_XORG_OPTIONS_TRANS_UNIX
XORG_LIB_SM_AUTOCONF	+= --enable-unix-transport
else
XORG_LIB_SM_AUTOCONF	+= --disable-unix-transport
endif

ifdef PTXCONF_XORG_OPTIONS_TRANS_TCP
XORG_LIB_SM_AUTOCONF	+= --enable-tcp-transport
else
XORG_LIB_SM_AUTOCONF	+= --disable-tcp-transport
endif

ifdef PTXCONF_XORG_OPTIONS_TRANS_IPV6
XORG_LIB_SM_AUTOCONF	+= --enable-ipv6
else
XORG_LIB_SM_AUTOCONF	+= --disable-ipv6
endif

$(STATEDIR)/xorg-lib-SM.prepare: $(xorg-lib-SM_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_SM_DIR)/config.cache)
	cd $(XORG_LIB_SM_DIR) && \
		$(XORG_LIB_SM_PATH) $(XORG_LIB_SM_ENV) \
		./configure $(XORG_LIB_SM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-SM_compile: $(STATEDIR)/xorg-lib-SM.compile

$(STATEDIR)/xorg-lib-SM.compile: $(xorg-lib-SM_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_SM_DIR) && $(XORG_LIB_SM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-SM_install: $(STATEDIR)/xorg-lib-SM.install

$(STATEDIR)/xorg-lib-SM.install: $(xorg-lib-SM_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_SM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-SM_targetinstall: $(STATEDIR)/xorg-lib-SM.targetinstall

$(STATEDIR)/xorg-lib-SM.targetinstall: $(xorg-lib-SM_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-SM)
	@$(call install_fixup, xorg-lib-SM,PACKAGE,xorg-lib-sm)
	@$(call install_fixup, xorg-lib-SM,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-SM,VERSION,$(XORG_LIB_SM_VERSION))
	@$(call install_fixup, xorg-lib-SM,SECTION,base)
	@$(call install_fixup, xorg-lib-SM,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-SM,DEPENDS,)
	@$(call install_fixup, xorg-lib-SM,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-SM, 0, 0, 0644, \
		$(XORG_LIB_SM_DIR)/src/.libs/libSM.so.6.0.0, \
		$(XORG_LIBDIR)/libSM.so.6.0.0)

	@$(call install_link, xorg-lib-SM, \
		libSM.so.6.0.0, \
		$(XORG_LIBDIR)/libSM.so.6)

	@$(call install_link, xorg-lib-SM, \
		libSM.so.6.0.0, \
		$(XORG_LIBDIR)/libSM.so)

	@$(call install_finish, xorg-lib-SM)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-SM_clean:
	rm -rf $(STATEDIR)/xorg-lib-SM.*
	rm -rf $(IMAGEDIR)/xorg-lib-SM_*
	rm -rf $(XORG_LIB_SM_DIR)

# vim: syntax=make
