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
LIBKMOD_VERSION	:= 7
LIBKMOD_MD5	:= 7bd916ae1c8a38e7697fdd8118bc98eb
LIBKMOD		:= kmod-$(LIBKMOD_VERSION)
LIBKMOD_SUFFIX	:= tar.xz
LIBKMOD_URL	:= $(call ptx/mirror, KERNEL, utils/kernel/kmod/$(LIBKMOD).$(LIBKMOD_SUFFIX))
LIBKMOD_SOURCE	:= $(SRCDIR)/$(LIBKMOD).$(LIBKMOD_SUFFIX)
LIBKMOD_DIR	:= $(BUILDDIR)/$(LIBKMOD)
# note: library: LGPLv2, tools: GPLv2
LIBKMOD_LICENSE	:= GPLv2/LGPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBKMOD_CONF_TOOL	:= autoconf
LIBKMOD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_ROOT) \
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
	@$(call install_copy, libkmod, 0, 0, 0755, -, /bin/kmod)
ifdef PTXCONF_LIBKMOD_INSMOD
	@$(call install_link, libkmod, ../bin/kmod, /sbin/insmod)
endif
ifdef PTXCONF_LIBKMOD_RMMOD
	@$(call install_link, libkmod, ../bin/kmod, /sbin/rmmod)
endif
ifdef PTXCONF_LIBKMOD_LSMOD
	@$(call install_link, libkmod, kmod, /bin/lsmod)
endif
ifdef PTXCONF_LIBKMOD_MODINFO
	@$(call install_link, libkmod, ../bin/kmod, /sbin/modinfo)
endif
ifdef PTXCONF_LIBKMOD_MODPROBE
	@$(call install_link, libkmod, ../bin/kmod, /sbin/modprobe)
endif
ifdef PTXCONF_LIBKMOD_DEPMOD
	@$(call install_link, libkmod, ../bin/kmod, /sbin/depmod)
endif
endif
	@$(call install_finish, libkmod)

	@$(call touch)

# vim: syntax=make
