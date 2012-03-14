# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMIKMOD) += libmikmod

#
# Paths and names
#
LIBMIKMOD_VERSION	:= 3.1.12
LIBMIKMOD_MD5		:= 9f3c740298260d5f88981fc0d51f6f16
LIBMIKMOD		:= libmikmod-$(LIBMIKMOD_VERSION)
LIBMIKMOD_SUFFIX	:= tar.gz
LIBMIKMOD_URL		:= http://downloads.sourceforge.net/mikmod/$(LIBMIKMOD).$(LIBMIKMOD_SUFFIX)
LIBMIKMOD_SOURCE	:= $(SRCDIR)/$(LIBMIKMOD).$(LIBMIKMOD_SUFFIX)
LIBMIKMOD_DIR		:= $(BUILDDIR)/$(LIBMIKMOD)
LIBMIKMOD_LICENSE	:= LGPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBMIKMOD_CONF_TOOL	:= autoconf
LIBMIKMOD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-af \
	--enable-alsa \
	--disable-esd \
	--disable-oss \
	--disable-sam9407 \
	--disable-ultra \
	--disable-esdtest \
	--enable-threads

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmikmod.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmikmod)
	@$(call install_fixup, libmikmod, PRIORITY, optional)
	@$(call install_fixup, libmikmod, SECTION, base)
	@$(call install_fixup, libmikmod, AUTHOR, "Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libmikmod, DESCRIPTION, missing)

	@$(call install_lib, libmikmod, 0, 0, 0644, libmikmod)

	@$(call install_finish, libmikmod)

	@$(call touch)

# vim: syntax=make
