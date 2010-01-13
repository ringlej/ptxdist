# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
# Copyright (C) 2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DRI2PROTO) += dri2proto

#
# Paths and names
#
DRI2PROTO_VERSION	:= 2.1
DRI2PROTO		:= dri2proto-$(DRI2PROTO_VERSION)
DRI2PROTO_SUFFIX	:= tar.bz2
DRI2PROTO_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(DRI2PROTO).$(DRI2PROTO_SUFFIX)
DRI2PROTO_SOURCE	:= $(SRCDIR)/$(DRI2PROTO).$(DRI2PROTO_SUFFIX)
DRI2PROTO_DIR		:= $(BUILDDIR)/$(DRI2PROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DRI2PROTO_SOURCE):
	@$(call targetinfo)
	@$(call get, DRI2PROTO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/dri2proto.extract:
	@$(call targetinfo)
	@$(call clean, $(DRI2PROTO_DIR))
	@$(call extract, DRI2PROTO)
	@$(call patchin, DRI2PROTO)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DRI2PROTO_PATH	:= PATH=$(CROSS_PATH)
DRI2PROTO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
DRI2PROTO_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/dri2proto.prepare:
	@$(call targetinfo)
	@$(call clean, $(DRI2PROTO_DIR)/config.cache)
	cd $(DRI2PROTO_DIR) && \
		$(DRI2PROTO_PATH) $(DRI2PROTO_ENV) \
		./configure $(DRI2PROTO_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/dri2proto.compile:
	@$(call targetinfo)
	cd $(DRI2PROTO_DIR) && $(DRI2PROTO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dri2proto.install:
	@$(call targetinfo)
	@$(call install, DRI2PROTO)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dri2proto.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
