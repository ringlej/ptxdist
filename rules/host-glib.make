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
HOST_PACKAGES-$(PTXCONF_HOST_GLIB) += host-glib

#
# Paths and names
#
HOST_GLIB_DIR	= $(HOST_BUILDDIR)/$(GLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GLIB_PATH	:= PATH=$(HOST_PATH)
HOST_GLIB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GLIB_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--enable-silent-rules \
	--disable-debug \
	--disable-gc-friendly \
	--enable-mem-pools \
	--disable-rebuilds \
	--disable-installed-tests \
	--disable-always-build-tests \
	--disable-static \
	--enable-shared \
	--disable-included-printf \
	--disable-selinux \
	--disable-fam \
	--disable-xattr \
	--disable-libelf \
	--disable-gtk-doc \
	--disable-man \
	--disable-dtrace \
	--disable-systemtap \
	--disable-coverage

$(STATEDIR)/host-glib.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_GLIB)
	@sed -i "s:'/share':'$(PTXCONF_SYSROOT_HOST)/share':" "$(PTXCONF_SYSROOT_HOST)/bin/gdbus-codegen"
	@$(call touch)

# vim: syntax=make
