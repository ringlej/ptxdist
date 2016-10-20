# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLEX) += flex

#
# Paths and names
#
FLEX_VERSION	:= 2.5.39
FLEX_MD5	:= 477679c37ff8b28248a9b05f1da29a82
FLEX		:= flex-$(FLEX_VERSION)
FLEX_SUFFIX	:= tar.xz
FLEX_URL	:= $(call ptx/mirror, SF, flex/$(FLEX).$(FLEX_SUFFIX))
FLEX_SOURCE	:= $(SRCDIR)/$(FLEX).$(FLEX_SUFFIX)
FLEX_DIR	:= $(BUILDDIR)/$(FLEX)
FLEX_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FLEX_CONF_TOOL	:= autoconf
FLEX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flex.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  flex)
	@$(call install_fixup, flex,PRIORITY,optional)
	@$(call install_fixup, flex,SECTION,base)
	@$(call install_fixup, flex,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, flex,DESCRIPTION,missing)

	@$(call install_lib, flex, 0, 0, 644, libfl)

	@$(call install_finish, flex)

	@$(call touch)

# vim: syntax=make
