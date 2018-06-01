# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSHOUT) += libshout

#
# Paths and names
#
LIBSHOUT_VERSION	:= 2.3.1
LIBSHOUT_MD5		:= 11765b2592e7ea623ccd93d3f8df172c
LIBSHOUT		:= libshout-$(LIBSHOUT_VERSION)
LIBSHOUT_SUFFIX		:= tar.gz
LIBSHOUT_URL		:= http://downloads.xiph.org/releases/libshout/$(LIBSHOUT).$(LIBSHOUT_SUFFIX)
LIBSHOUT_SOURCE		:= $(SRCDIR)/$(LIBSHOUT).$(LIBSHOUT_SUFFIX)
LIBSHOUT_DIR		:= $(BUILDDIR)/$(LIBSHOUT)
LIBSHOUT_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSHOUT_CONF_TOOL	:= autoconf
LIBSHOUT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-thread \
	--$(call ptx/endis, PTXCONF_LIBSHOUT_THEORA)-theora \
	--$(call ptx/endis, PTXCONF_LIBSHOUT_SPEEX)-speex

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libshout.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libshout)
	@$(call install_fixup, libshout,PRIORITY,optional)
	@$(call install_fixup, libshout,VERSION,$(LIBSHOUT_VERSION))
	@$(call install_fixup, libshout,SECTION,base)
	@$(call install_fixup, libshout,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libshout,DEPENDS,)
	@$(call install_fixup, libshout,DESCRIPTION,missing)

	@$(call install_lib, libshout, 0, 0, 0755, libshout)

	@$(call install_finish, libshout)

	@$(call touch)

# vim: syntax=make
