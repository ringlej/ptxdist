# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBAO) += libao

#
# Paths and names
#
LIBAO_VERSION	:= 1.1.0
LIBAO_MD5	:= 2b2508c29bc97e4dc218fa162cf883c8
LIBAO		:= libao-$(LIBAO_VERSION)
LIBAO_SUFFIX	:= tar.gz
LIBAO_URL	:= http://downloads.xiph.org/releases/ao/$(LIBAO).$(LIBAO_SUFFIX)
LIBAO_SOURCE	:= $(SRCDIR)/$(LIBAO).$(LIBAO_SUFFIX)
LIBAO_DIR	:= $(BUILDDIR)/$(LIBAO)
LIBAO_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBAO_CONF_TOOL := autoconf
LIBAO_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-wmm \
	--disable-esd \
	--enable-alsa \
	--enable-alsa-mmap \
	--disable-broken-oss \
	--disable-arts \
	--disable-nas \
	--disable-pulse \
	--without-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libao.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libao)
	@$(call install_fixup, libao,PRIORITY,optional)
	@$(call install_fixup, libao,SECTION,base)
	@$(call install_fixup, libao,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libao,DESCRIPTION,missing)

	@$(call install_lib, libao, 0, 0, 0644, libao)
	@$(call install_lib, libao, 0, 0, 0644, ao/plugins-4/libalsa)

	@$(call install_finish, libao)

	@$(call touch)

# vim: syntax=make
