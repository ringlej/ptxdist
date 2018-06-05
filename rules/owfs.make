# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OWFS) += owfs

#
# Paths and names
#
OWFS_VERSION	:= 3.1p0
OWFS_MD5	:= 3d8919af078ae8c9171e5713a1789195
OWFS		:= owfs-$(OWFS_VERSION)
OWFS_SUFFIX	:= tar.gz
OWFS_URL	:= $(call ptx/mirror, SF, owfs/$(OWFS).$(OWFS_SUFFIX))
OWFS_SOURCE	:= $(SRCDIR)/$(OWFS).$(OWFS_SUFFIX)
OWFS_DIR	:= $(BUILDDIR)/$(OWFS)
OWFS_LICENSE	:= GPL-2.0-or-later AND LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OWFS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debian \
	--disable-debug \
	--disable-mutexdebug \
	--enable-owlib \
	--enable-i2c \
	--disable-w1 \
	--disable-owhttpd \
	--disable-owftpd \
	--disable-owserver \
	--disable-owexternal \
	--disable-ownet \
	--disable-owtap \
	--disable-owmalloc \
	--disable-owmon \
	--disable-swig \
	--disable-owperl \
	--disable-owphp \
	--disable-owpython \
	--disable-owtcl \
	--disable-profiling \
	--disable-zero \
	--disable-usb \
	--disable-avahi \
	--disable-parport \
	--without-perl5 \
	--without-php \
	--without-phpconfig \
	--without-python \
	--without-pythonconfig \
	--without-tcl

ifdef PTXCONF_OWFS_OWSHELL
OWFS_AUTOCONF += --enable-owshell
else
OWFS_AUTOCONF += --disable-owshell
endif
ifdef PTXCONF_OWFS_OWNETLIB
OWFS_AUTOCONF += --enable-ownetlib
else
OWFS_AUTOCONF += --disable-ownetlib
endif
ifdef PTXCONF_OWFS_OWFS
OWFS_AUTOCONF += --enable-owfs
else
OWFS_AUTOCONF += --disable-owfs
endif
ifdef PTXCONF_OWFS_OWCAPI
OWFS_AUTOCONF += --enable-owcapi
else
OWFS_AUTOCONF += --disable-owcapi
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/owfs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, owfs)
	@$(call install_fixup, owfs,PRIORITY,optional)
	@$(call install_fixup, owfs,SECTION,base)
	@$(call install_fixup, owfs,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, owfs,DESCRIPTION,missing)

	@$(call install_lib, owfs, 0, 0, 0644, libow-3.1)
ifdef PTXCONF_OWFS_OWCAPI
	@$(call install_lib, owfs, 0, 0, 0644, libowcapi-3.1)
endif

ifdef PTXCONF_OWFS_OWFS
	@$(call install_copy, owfs, 0, 0, 0755, -, /usr/bin/owfs)
endif
	@$(call install_finish, owfs)

	@$(call touch)

# vim: syntax=make
