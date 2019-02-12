# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_P11_KIT) += host-p11-kit

#
# Paths and names
#
HOST_P11_KIT_VERSION	:= 0.23.13
HOST_P11_KIT_MD5	:= 9fb1daab59c6b9d90261f6bddf00d0f1
HOST_P11_KIT		:= p11-kit-$(HOST_P11_KIT_VERSION)
HOST_P11_KIT_SUFFIX	:= tar.gz
HOST_P11_KIT_URL	:= https://github.com/p11-glue/p11-kit/releases/download/0.23.13//$(HOST_P11_KIT).$(HOST_P11_KIT_SUFFIX)
HOST_P11_KIT_SOURCE	:= $(SRCDIR)/$(HOST_P11_KIT).$(HOST_P11_KIT_SUFFIX)
HOST_P11_KIT_DIR	:= $(HOST_BUILDDIR)/$(HOST_P11_KIT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#HOST_P11_KIT_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_P11_KIT_CONF_TOOL	:= autoconf
HOST_P11_KIT_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-nls \
	--disable-trust-module \
	--disable-doc \
	--disable-doc-html \
	--disable-doc-pdf \
	--enable-debug=no \
	--with-hash-impl=internal \
	--without-systemd

# vim: syntax=make
