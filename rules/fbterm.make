# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <walle@corscience.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBTERM) += fbterm

#
# Paths and names
#
FBTERM_VERSION	:= 1.7.0
FBTERM_MD5	:= c36bae75a450df0519b4527cccaf7572
FBTERM		:= fbterm-$(FBTERM_VERSION)
FBTERM_SUFFIX	:= tar.gz
FBTERM_URL	:= http://fbterm.googlecode.com/files/$(FBTERM).$(FBTERM_SUFFIX)
FBTERM_SOURCE	:= $(SRCDIR)/$(FBTERM).$(FBTERM_SUFFIX)
FBTERM_DIR	:= $(BUILDDIR)/$(FBTERM)
FBTERM_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FBTERM_CONF_TOOL	:= autoconf
FBTERM_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_FBTERM_GPM)-gpm \
	--disable-vesa

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbterm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbterm)
	@$(call install_fixup, fbterm,PRIORITY,optional)
	@$(call install_fixup, fbterm,SECTION,base)
	@$(call install_fixup, fbterm,AUTHOR,"Bernhard Walle <walle@corscience.de>")
	@$(call install_fixup, fbterm,DESCRIPTION,missing)

	@$(call install_copy, fbterm, 0, 0, 0755, \
		-, /usr/bin/fbterm)

	@$(call install_finish, fbterm)

	@$(call touch)

# vim: syntax=make
