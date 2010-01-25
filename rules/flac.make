# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLAC) += flac

#
# Paths and names
#
FLAC_VERSION	:= 1.2.1
FLAC		:= flac-$(FLAC_VERSION)
FLAC_SUFFIX	:= tar.gz
FLAC_URL	:= $(PTXCONF_SETUP_SFMIRROR)/flac/$(FLAC).$(FLAC_SUFFIX)
FLAC_SOURCE	:= $(SRCDIR)/$(FLAC).$(FLAC_SUFFIX)
FLAC_DIR	:= $(BUILDDIR)/$(FLAC)
FLAC_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FLAC_SOURCE):
	@$(call targetinfo)
	@$(call get, FLAC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FLAC_CONF_TOOL	:= autoconf
FLAC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-rpath \
	--enable-largefile \
	--disable-debug \
	--disable-thorough-tests \
	--disable-exhaustive-tests \
	--disable-valgrind-testing \
	--disable-doxygen-docs \
	--disable-local-xmms-plugin \
	--disable-xmms-plugin \
	--disable-cpplibs \
	--enable-ogg \
	--disable-oggtest \
	--with-ogg=$(PTXDIST_SYSROOT_TARGET)/usr

ifdef PTXCONF_ARCH_X86
FLAC_CONF_OPT += \
	--enable-asm-optimizations \
	--enable-sse \
	--enable-3dnow \
	--disable-altivec
else
FLAC_CONF_OPT += \
	--disable-asm-optimizations \
	--disable-sse \
	--disable-3dnow \
	--disable-altivec
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flac.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  flac)
	@$(call install_fixup, flac,PACKAGE,flac)
	@$(call install_fixup, flac,PRIORITY,optional)
	@$(call install_fixup, flac,VERSION,$(FLAC_VERSION))
	@$(call install_fixup, flac,SECTION,base)
	@$(call install_fixup, flac,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, flac,DEPENDS,)
	@$(call install_fixup, flac,DESCRIPTION,missing)

	@$(call install_copy, flac, 0, 0, 0644, -, /usr/lib/libFLAC.so.8.2.0)
	@$(call install_link, flac, libFLAC.so.8.2.0, /usr/lib/libFLAC.so.8)
	@$(call install_link, flac, libFLAC.so.8.2.0, /usr/lib/libFLAC.so)

ifdef PTXCONF_FLAC_INSTALL_FLAC
	@$(call install_copy, flac, 0, 0, 0755, -, /usr/bin/flac)
endif
ifdef PTXCONF_FLAC_INSTALL_METAFLAC
	@$(call install_copy, flac, 0, 0, 0755, -, /usr/bin/metaflac)
endif

	@$(call install_finish, flac)

	@$(call touch)

# vim: syntax=make
