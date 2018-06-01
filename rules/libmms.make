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
PACKAGES-$(PTXCONF_LIBMMS) += libmms

#
# Paths and names
#
LIBMMS_VERSION	:= 0.6.4
LIBMMS_MD5	:= d6b665b335a6360e000976e770da7691
LIBMMS		:= libmms-$(LIBMMS_VERSION)
LIBMMS_SUFFIX	:= tar.gz
LIBMMS_URL	:= $(call ptx/mirror, SF, libmms/libmms-$(LIBMMS_VERSION).$(LIBMMS_SUFFIX))
LIBMMS_SOURCE	:= $(SRCDIR)/$(LIBMMS).$(LIBMMS_SUFFIX)
LIBMMS_DIR	:= $(BUILDDIR)/$(LIBMMS)
LIBMMS_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBMMS_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmms.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmms)
	@$(call install_fixup, libmms,PRIORITY,optional)
	@$(call install_fixup, libmms,SECTION,base)
	@$(call install_fixup, libmms,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libmms,DESCRIPTION,missing)

	$(call install_lib, libmms, 0, 0, 0644, libmms)

	@$(call install_finish, libmms)

	@$(call touch)

# vim: syntax=make
