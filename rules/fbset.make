# -*-makefile-*-
#
# Copyright (C) 2011 by Sascha Hauer <s.hauer@pengutronix.de>
# Copyright (C) 2011 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FBSET) += fbset

#
# Paths and names
#
FBSET_VERSION	:= 2.1
FBSET_MD5	:= e547cfcbb8c1a4f2a6b8ba4acb8b7164
FBSET		:= fbset-$(FBSET_VERSION)
FBSET_SUFFIX	:= tar.gz
FBSET_URL	:= http://users.telenet.be/geertu/Linux/fbdev/$(FBSET).$(FBSET_SUFFIX)
FBSET_SOURCE	:= $(SRCDIR)/$(FBSET).$(FBSET_SUFFIX)
FBSET_DIR	:= $(BUILDDIR)/$(FBSET)
FBSET_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

FBSET_MAKE_ENV	:= $(CROSS_ENV)
FBSET_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbset.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbset)
	@$(call install_fixup, fbset,PRIORITY,optional)
	@$(call install_fixup, fbset,SECTION,base)
	@$(call install_fixup, fbset,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup, fbset,DESCRIPTION,missing)

	@$(call install_copy, fbset, 0, 0, 0755, -, /usr/sbin/fbset)

	@$(call install_finish, fbset)

	@$(call touch)

# vim: syntax=make
