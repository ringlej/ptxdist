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
PACKAGES-$(PTXCONF_XORG_PROTO_XCMISC) += xorg-proto-xcmisc

#
# Paths and names
#
XORG_PROTO_XCMISC_VERSION	:= 1.1.2
XORG_PROTO_XCMISC		:= xcmiscproto-X11R7.0-$(XORG_PROTO_XCMISC_VERSION)
XORG_PROTO_XCMISC_SUFFIX	:= tar.bz2
XORG_PROTO_XCMISC_URL		:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/proto/$(XORG_PROTO_XCMISC).$(XORG_PROTO_XCMISC_SUFFIX)
XORG_PROTO_XCMISC_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XCMISC).$(XORG_PROTO_XCMISC_SUFFIX)
XORG_PROTO_XCMISC_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XCMISC)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xcmisc_get: $(STATEDIR)/xorg-proto-xcmisc.get

$(STATEDIR)/xorg-proto-xcmisc.get: $(xorg-proto-xcmisc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XCMISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_PROTO_XCMISC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xcmisc_extract: $(STATEDIR)/xorg-proto-xcmisc.extract

$(STATEDIR)/xorg-proto-xcmisc.extract: $(xorg-proto-xcmisc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XCMISC_DIR))
	@$(call extract, $(XORG_PROTO_XCMISC_SOURCE))
	@$(call patchin, $(XORG_PROTO_XCMISC))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xcmisc_prepare: $(STATEDIR)/xorg-proto-xcmisc.prepare

XORG_PROTO_XCMISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XCMISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XCMISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xcmisc.prepare: $(xorg-proto-xcmisc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XCMISC_DIR)/config.cache)
	cd $(XORG_PROTO_XCMISC_DIR) && \
		$(XORG_PROTO_XCMISC_PATH) $(XORG_PROTO_XCMISC_ENV) \
		./configure $(XORG_PROTO_XCMISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xcmisc_compile: $(STATEDIR)/xorg-proto-xcmisc.compile

$(STATEDIR)/xorg-proto-xcmisc.compile: $(xorg-proto-xcmisc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XCMISC_DIR) && $(XORG_PROTO_XCMISC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xcmisc_install: $(STATEDIR)/xorg-proto-xcmisc.install

$(STATEDIR)/xorg-proto-xcmisc.install: $(xorg-proto-xcmisc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XCMISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xcmisc_targetinstall: $(STATEDIR)/xorg-proto-xcmisc.targetinstall

$(STATEDIR)/xorg-proto-xcmisc.targetinstall: $(xorg-proto-xcmisc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-proto-xcmisc)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_PROTO_XCMISC_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Erwin Rol <erwin\@erwinrol.com>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xcmisc_clean:
	rm -rf $(STATEDIR)/xorg-proto-xcmisc.*
	rm -rf $(IMAGEDIR)/xorg-proto-xcmisc_*
	rm -rf $(XORG_PROTO_XCMISC_DIR)

# vim: syntax=make

