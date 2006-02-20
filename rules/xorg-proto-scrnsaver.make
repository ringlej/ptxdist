# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_PROTO_SCMSAVER) += xorg-proto-scmsaver

#
# Paths and names
#
XORG_PROTO_SCMSAVER_VERSION := 1.0.2
XORG_PROTO_SCMSAVER	:= scmsaverproto-X11R7.0-$(XORG_PROTO_SCMSAVER_VERSION)
XORG_PROTO_SCMSAVER_SUFFIX	:= tar.bz2
XORG_PROTO_SCMSAVER_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/proto/$(XORG_PROTO_SCMSAVER).$(XORG_PROTO_SCMSAVER_SUFFIX)
XORG_PROTO_SCMSAVER_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_SCMSAVER).$(XORG_PROTO_SCMSAVER_SUFFIX)
XORG_PROTO_SCMSAVER_DIR	:= $(BUILDDIR)/$(XORG_PROTO_SCMSAVER)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-scmsaver_get: $(STATEDIR)/xorg-proto-scmsaver.get

$(STATEDIR)/xorg-proto-scmsaver.get: $(xorg-proto-scmsaver_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_SCMSAVER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_PROTO_SCMSAVER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-scmsaver_extract: $(STATEDIR)/xorg-proto-scmsaver.extract

$(STATEDIR)/xorg-proto-scmsaver.extract: $(xorg-proto-scmsaver_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_SCMSAVER_DIR))
	@$(call extract, $(XORG_PROTO_SCMSAVER_SOURCE))
	@$(call patchin, $(XORG_PROTO_SCMSAVER))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-scmsaver_prepare: $(STATEDIR)/xorg-proto-scmsaver.prepare

XORG_PROTO_SCMSAVER_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_SCMSAVER_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_SCMSAVER_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-scmsaver.prepare: $(xorg-proto-scmsaver_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_SCMSAVER_DIR)/config.cache)
	cd $(XORG_PROTO_SCMSAVER_DIR) && \
		$(XORG_PROTO_SCMSAVER_PATH) $(XORG_PROTO_SCMSAVER_ENV) \
		./configure $(XORG_PROTO_SCMSAVER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-scmsaver_compile: $(STATEDIR)/xorg-proto-scmsaver.compile

$(STATEDIR)/xorg-proto-scmsaver.compile: $(xorg-proto-scmsaver_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_SCMSAVER_DIR) && $(XORG_PROTO_SCMSAVER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-scmsaver_install: $(STATEDIR)/xorg-proto-scmsaver.install

$(STATEDIR)/xorg-proto-scmsaver.install: $(xorg-proto-scmsaver_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_SCMSAVER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-scmsaver_targetinstall: $(STATEDIR)/xorg-proto-scmsaver.targetinstall

$(STATEDIR)/xorg-proto-scmsaver.targetinstall: $(xorg-proto-scmsaver_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-proto-scmsaver)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_PROTO_SCMSAVER_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-scmsaver_clean:
	rm -rf $(STATEDIR)/xorg-proto-scmsaver.*
	rm -rf $(IMAGEDIR)/xorg-proto-scmsaver_*
	rm -rf $(XORG_PROTO_SCMSAVER_DIR)

# vim: syntax=make

