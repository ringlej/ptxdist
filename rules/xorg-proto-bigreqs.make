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
PACKAGES-$(PTXCONF_XORG_PROTO_BIGREQS) += xorg-proto-bigreqs

#
# Paths and names
#
XORG_PROTO_BIGREQS_VERSION	:= 1.0.2
XORG_PROTO_BIGREQS		:= bigreqsproto-X11R7.0-$(XORG_PROTO_BIGREQS_VERSION)
XORG_PROTO_BIGREQS_SUFFIX	:= tar.bz2
XORG_PROTO_BIGREQS_URL		:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/proto/$(XORG_PROTO_BIGREQS).$(XORG_PROTO_BIGREQS_SUFFIX)
XORG_PROTO_BIGREQS_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_BIGREQS).$(XORG_PROTO_BIGREQS_SUFFIX)
XORG_PROTO_BIGREQS_DIR		:= $(BUILDDIR)/$(XORG_PROTO_BIGREQS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-bigreqs_get: $(STATEDIR)/xorg-proto-bigreqs.get

$(STATEDIR)/xorg-proto-bigreqs.get: $(xorg-proto-bigreqs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_BIGREQS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_PROTO_BIGREQS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-bigreqs_extract: $(STATEDIR)/xorg-proto-bigreqs.extract

$(STATEDIR)/xorg-proto-bigreqs.extract: $(xorg-proto-bigreqs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_BIGREQS_DIR))
	@$(call extract, $(XORG_PROTO_BIGREQS_SOURCE))
	@$(call patchin, $(XORG_PROTO_BIGREQS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-bigreqs_prepare: $(STATEDIR)/xorg-proto-bigreqs.prepare

XORG_PROTO_BIGREQS_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_BIGREQS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_BIGREQS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-bigreqs.prepare: $(xorg-proto-bigreqs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_BIGREQS_DIR)/config.cache)
	cd $(XORG_PROTO_BIGREQS_DIR) && \
		$(XORG_PROTO_BIGREQS_PATH) $(XORG_PROTO_BIGREQS_ENV) \
		./configure $(XORG_PROTO_BIGREQS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-bigreqs_compile: $(STATEDIR)/xorg-proto-bigreqs.compile

$(STATEDIR)/xorg-proto-bigreqs.compile: $(xorg-proto-bigreqs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_BIGREQS_DIR) && $(XORG_PROTO_BIGREQS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-bigreqs_install: $(STATEDIR)/xorg-proto-bigreqs.install

$(STATEDIR)/xorg-proto-bigreqs.install: $(xorg-proto-bigreqs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_BIGREQS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-bigreqs_targetinstall: $(STATEDIR)/xorg-proto-bigreqs.targetinstall

$(STATEDIR)/xorg-proto-bigreqs.targetinstall: $(xorg-proto-bigreqs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-proto-bigreqs)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_PROTO_BIGREQS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Erwin Rol <erwin\@erwinrol.com>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-bigreqs_clean:
	rm -rf $(STATEDIR)/xorg-proto-bigreqs.*
	rm -rf $(IMAGEDIR)/xorg-proto-bigreqs_*
	rm -rf $(XORG_PROTO_BIGREQS_DIR)

# vim: syntax=make

