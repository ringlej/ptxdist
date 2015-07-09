# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Grzeschik <mgr@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NODEJS) += host-nodejs

#
# Paths and names
#
HOST_NODEJS			= $(NODEJS)
HOST_NODEJS_DIR			= $(HOST_BUILDDIR)/$(HOST_NODEJS)

HOST_NODEJS_NPMBOX_VERSION	:= 2.6.1
HOST_NODEJS_NPMBOX_MD5		:= 2779b99e3427cd49bbf28a236d871028
HOST_NODEJS_NPMBOX		:= npmbox-$(HOST_NODEJS_NPMBOX_VERSION)
HOST_NODEJS_NPMBOX_SUFFIX	:= tar.bz2
HOST_NODEJS_NPMBOX_SOURCE	:= $(SRCDIR)/$(HOST_NODEJS_NPMBOX).$(HOST_NODEJS_NPMBOX_SUFFIX)
$(HOST_NODEJS_NPMBOX_SOURCE)	:= HOST_NODEJS_NPMBOX
HOST_NODEJS_NPMBOX_DIR		:= $(HOST_NODEJS_DIR)
HOST_NODEJS_NPMBOX_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(HOST_NODEJS_NPMBOX).$(HOST_NODEJS_NPMBOX_SUFFIX)

HOST_NODEJS_SOURCES		:= $(HOST_NODEJS_SOURCE) $(HOST_NODEJS_NPMBOX_SOURCE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NODEJS_CONF_TOOL := autoconf
HOST_NODEJS_CONF_OPT := \
	$(HOST_AUTOCONF) \
	--prefix=/ \
	--without-snapshot \
	--shared-openssl \
	--shared-zlib \
	--dest-os=linux

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-nodejs.install:
	@$(call targetinfo)
	@$(call install, HOST_NODEJS)
	@sed "1s^.*^#\!/usr/bin/env node^g" \
		-i $(HOST_NODEJS_PKGDIR)/lib/node_modules/npm/bin/npm-cli.js
	@tar xpf $(HOST_NODEJS_NPMBOX_SOURCE) -C $(HOST_NODEJS_PKGDIR)
	@$(call touch)

# vim: syntax=make
