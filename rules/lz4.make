# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LZ4) += lz4

#
# Paths and names
#
LZ4_VERSION	:= 1.8.0
LZ4_MD5		:= 6247bf0e955899969d1600ff34baed6b
LZ4		:= lz4-$(LZ4_VERSION)
LZ4_SUFFIX	:= tar.gz
LZ4_URL		:= https://github.com/Cyan4973/lz4/archive/v$(LZ4_VERSION).$(LZ4_SUFFIX)
LZ4_SOURCE	:= $(SRCDIR)/$(LZ4).$(LZ4_SUFFIX)
LZ4_DIR		:= $(BUILDDIR)/$(LZ4)
LZ4_LICENSE	:= BSD-2-Clause AND GPL-2.0-or-later
LZ4_LICENSE_FILES := \
	file://LICENSE;md5=d57c0d21cb917fb4e0af2454aa48b956 \
	file://lib/LICENSE;md5=ebc2ea4814a64de7708f1571904b32cc \
	file://programs/COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LZ4_CONF_TOOL	:= NO
LZ4_MAKE_ENV	:= $(CROSS_ENV) PREFIX=/usr
LZ4_MAKE_OPT	:= \
	BUILD_STATIC=no \
	$(call ptx/ifdef,PTXCONF_LZ4_TOOLS,lib lz4,-C lib)
LZ4_INSTALL_OPT	:= \
	BUILD_STATIC=no \
	$(call ptx/ifdef,PTXCONF_LZ4_TOOLS,,-C lib) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lz4.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lz4)
	@$(call install_fixup, lz4,PRIORITY,optional)
	@$(call install_fixup, lz4,SECTION,base)
	@$(call install_fixup, lz4,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, lz4,DESCRIPTION,missing)

	@$(call install_lib, lz4, 0, 0, 0644, liblz4)
ifdef PTXCONF_LZ4_TOOLS
	@$(call install_copy, lz4, 0, 0, 0755, -, /usr/bin/lz4)
	@$(call install_link, lz4, lz4, /usr/bin/lz4c)
	@$(call install_link, lz4, lz4, /usr/bin/lz4cat)
	@$(call install_link, lz4, lz4, /usr/bin/unlz4)
endif

	@$(call install_finish, lz4)

	@$(call touch)

# vim: syntax=make
