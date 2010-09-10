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
OWFS_VERSION	:= 2.7p26
OWFS		:= owfs-$(OWFS_VERSION)
OWFS_SUFFIX	:= tar.gz
OWFS_URL	:= $(PTXCONF_SETUP_SFMIRROR)/owfs/$(OWFS).$(OWFS_SUFFIX)
OWFS_SOURCE	:= $(SRCDIR)/$(OWFS).$(OWFS_SUFFIX)
OWFS_DIR	:= $(BUILDDIR)/$(OWFS)
OWFS_LICENSE	:= GPLv2+, LGPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(OWFS_SOURCE):
	@$(call targetinfo)
	@$(call get, OWFS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OWFS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--disable-fast-install \
	--enable-libtool-lock \
	--disable-debian \
	--disable-debug \
	--enable-owlib \
	--disable-tai8570 \
	--disable-thermocouple \
	--enable-mt \
	--disable-i2c \
	--disable-ha7 \
	--disable-owhttpd \
	--disable-owftpd \
	--disable-owserver \
	--disable-ownet \
	--disable-owtap \
	--disable-owside \
	--disable-owmon \
	--disable-owcapi \
	--disable-swig \
	--disable-owperl \
	--disable-owphp \
	--disable-owpython \
	--disable-owtcl \
	--disable-profiling \
	--disable-cache \
	--disable-zero \
	--disable-usb \
	--disable-parport \
	--with-gnu-ld \
	--with-pic \
	--without-perl5 \
	--without-php \
	--without-phpconfig \
	--without-python \
	--without-pythonconfig \
	--without-tcl

#	--with-libusb-config=PATH

ifdef PTXCONF_OWFS__OWSHELL
OWFS_AUTOCONF += --enable-owshell
else
OWFS_AUTOCONF += --disable-owshell
endif
ifdef PTXCONF_OWFS__OWNETLIB
OWFS_AUTOCONF += --enable-ownetlib
else
OWFS_AUTOCONF += --disable-ownetlib
endif
ifdef PTXCONF_OWFS__OWFS
OWFS_AUTOCONF += --enable-owfs
else
OWFS_AUTOCONF += --disable-owfs
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

	@$(call install_lib, owfs, 0, 0, 0644, libow-2.7)

ifdef PTXCONF_OWFS__OWFS
	@$(call install_copy, owfs, 0, 0, 0755, /usr/bin/owfs)
endif
	@$(call install_finish, owfs)

	@$(call touch)

# vim: syntax=make
