# -*-makefile-*-
#
# Copyright (C) 2010 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_UTIL_LINUX_NG) += host-util-linux-ng

#
# Paths and names
#
HOST_UTIL_LINUX_NG_DIR	= $(HOST_BUILDDIR)/$(UTIL_LINUX_NG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-util-linux-ng.get: $(STATEDIR)/util-linux-ng.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#

HOST_UTIL_LINUX_NG_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-nls \
	--disable-use-tty-group \
	--disable-makeinstall-chown \
	--disable-fallocate \
	--enable-libuuid \
	--enable-libblkid

HOST_UTIL_LINUX_NG_MAKE_OPT	:= -C shlibs
HOST_UTIL_LINUX_NG_INSTALL_OPT	:= $(HOST_UTIL_LINUX_NG_MAKE_OPT) install

# vim: syntax=make
