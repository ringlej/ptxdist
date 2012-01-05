# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBKMOD) += libkmod

#
# Paths and names
#
LIBKMOD_VERSION	:= 3
LIBKMOD_MD5	:= bc0e69f75c2ac22c091f05e166e86c5d
LIBKMOD		:= kmod-$(LIBKMOD_VERSION)
LIBKMOD_SUFFIX	:= tar.xz
LIBKMOD_URL	:= http://packages.profusion.mobi/kmod/$(LIBKMOD).$(LIBKMOD_SUFFIX)
LIBKMOD_SOURCE	:= $(SRCDIR)/$(LIBKMOD).$(LIBKMOD_SUFFIX)
LIBKMOD_DIR	:= $(BUILDDIR)/$(LIBKMOD)
# note: library: LGPLv2, tools: GPLv2
LIBKMOD_LICENSE	:= GPLv2/LGPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBKMOD_CONF_TOOL	:= autoconf
LIBKMOD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--enable-shared \
	--$(call ptx/endis, PTXCONF_LIBKMOD_TOOLS)-tools \
	--$(call ptx/endis, PTXCONF_LIBKMOD_LOGGING)-logging \
	--$(call ptx/endis, PTXCONF_LIBKMOD_DEBUG)-debug \
	--without-xz \
	--$(call ptx/wwo, PTXCONF_LIBKMOD_ZLIB)-zlib

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libkmod.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libkmod)
	@$(call install_fixup, libkmod,PRIORITY,optional)
	@$(call install_fixup, libkmod,SECTION,base)
	@$(call install_fixup, libkmod,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, libkmod,DESCRIPTION,"Linux kernel module handling")

	@$(call install_lib, libkmod, 0, 0, 0644, libkmod)

ifdef PTXCONF_LIBKMOD_TOOLS
	@$(call install_copy, libkmod, 0, 0, 0755, -, /usr/bin/kmod)
endif
	@$(call install_finish, libkmod)

	@$(call touch)

# vim: syntax=make
