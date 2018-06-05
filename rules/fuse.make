# -*-makefile-*-
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FUSE) += fuse

#
# Paths and names
#
FUSE_VERSION	:= 2.9.5
FUSE_MD5	:= c901b77a1c4584c7ac6c2b67c0713f2b
FUSE		:= fuse-$(FUSE_VERSION)
FUSE_SUFFIX	:= tar.gz
FUSE_URL	:= https://github.com/libfuse/libfuse/releases/download/fuse_$(subst .,_,$(FUSE_VERSION))/$(FUSE).$(FUSE_SUFFIX)
FUSE_SOURCE	:= $(SRCDIR)/$(FUSE).$(FUSE_SUFFIX)
FUSE_DIR	:= $(BUILDDIR)/$(FUSE)
FUSE_LICENSE	:= GPL-2.0-only AND LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FUSE_CONF_TOOL	:= autoconf
FUSE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-example \
	--disable-mtab \
	--disable-rpath \
	--without-libiconv-prefix \
	--$(call ptx/endis, PTXCONF_FUSE__LIB)-lib \
	--$(call ptx/endis, PTXCONF_FUSE__UTIL)-util

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fuse.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fuse)
	@$(call install_fixup, fuse,PRIORITY,optional)
	@$(call install_fixup, fuse,SECTION,base)
	@$(call install_fixup, fuse,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fuse,DESCRIPTION,missing)

ifdef PTXCONF_FUSE__LIB
	@$(call install_lib, fuse, 0, 0, 0644, libfuse)
	@$(call install_lib, fuse, 0, 0, 0644, libulockmgr)
endif
ifdef PTXCONF_FUSE__UTIL
	@$(call install_copy, fuse, 0, 0, 0755, -, /usr/bin/fusermount)
	@$(call install_copy, fuse, 0, 0, 0755, -, /usr/bin/ulockmgr_server)
endif
	@$(call install_finish, fuse)

	@$(call touch)

# vim: syntax=make
