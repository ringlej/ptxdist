# -*-makefile-*-
#
# Copyright (C) 2017 by Denis Osterland <Denis.Osterland@diehl.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_GIFLIB) += giflib

GIFLIB_VERSION       := 5.1.4
GIFLIB_MD5           := 2c171ced93c0e83bb09e6ccad8e3ba2b
GIFLIB               := giflib-$(GIFLIB_VERSION)
GIFLIB_SUFFIX        := tar.bz2
GIFLIB_URL           := $(call ptx/mirror, SF, giflib/$(GIFLIB).$(GIFLIB_SUFFIX))
GIFLIB_SOURCE        := $(SRCDIR)/$(GIFLIB).$(GIFLIB_SUFFIX)
GIFLIB_DIR           := $(BUILDDIR)/$(GIFLIB)
GIFLIB_LICENSE       := MIT
GIFLIB_LICENSE_FILES := file://COPYING;md5=ae11c61b04b2917be39b11f78d71519a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GIFLIB_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/giflib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, giflib)
	@$(call install_fixup, giflib,PRIORITY,optional)
	@$(call install_fixup, giflib,SECTION,base)
	@$(call install_fixup, giflib,AUTHOR,"Denis Osterland <Denis.Osterland@diehl.com>")
	@$(call install_fixup, giflib,DESCRIPTION,missing)

	@$(call install_lib, giflib, 0, 0, 0644, libgif)

ifdef GIFLIB_TOOLS
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/giftext)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gif2rgb)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gifinfo)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gifecho)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gifbuild)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/giftool)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/giffix)
	@$(call install_copy, giflib, 0, 0, 0755, -, /usr/bin/gifclrmp)
endif

	@$(call install_finish, giflib)

	@$(call touch)

# vim: syntax=make
