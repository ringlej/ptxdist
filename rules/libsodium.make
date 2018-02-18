# -*-makefile-*-
#
# Copyright (C) 2016 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSODIUM) += libsodium

#
# Paths and names
#
LIBSODIUM_VERSION	:= 1.0.16
LIBSODIUM_MD5		:= 37b18839e57e7a62834231395c8e962b
LIBSODIUM		:= libsodium-$(LIBSODIUM_VERSION)
LIBSODIUM_SUFFIX	:= tar.gz
LIBSODIUM_URL		:= https://github.com/jedisct1/libsodium/releases/download/$(LIBSODIUM_VERSION)/$(LIBSODIUM).$(LIBSODIUM_SUFFIX)
LIBSODIUM_SOURCE	:= $(SRCDIR)/$(LIBSODIUM).$(LIBSODIUM_SUFFIX)
LIBSODIUM_DIR		:= $(BUILDDIR)/$(LIBSODIUM)
LIBSODIUM_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSODIUM_CONF_TOOL	:= autoconf
LIBSODIUM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-ssp \
	--$(call ptx/endis, PTXCONF_ARCH_X86)-asm \
	--enable-pie \
	--disable-blocking-random \
	--disable-minimal \
	--disable-debug \
	--disable-opt \
	--disable-valgrind \
	--disable-valgrind-memcheck \
	--disable-valgrind-helgrind \
	--disable-valgrind-drd \
	--disable-valgrind-sgcheck \
	--enable-soname-versions \
	--disable-static \
	--with-pthreads \
	--without-safecode \
	--without-ctgrind

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsodium.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsodium)
	@$(call install_fixup, libsodium, PRIORITY, optional)
	@$(call install_fixup, libsodium, SECTION, base)
	@$(call install_fixup, libsodium, AUTHOR, "Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, libsodium, DESCRIPTION, "The sodium crypto library")

	@$(call install_lib, libsodium, 0, 0, 0644, libsodium)

	@$(call install_finish, libsodium)

	@$(call touch)

# vim: syntax=make
