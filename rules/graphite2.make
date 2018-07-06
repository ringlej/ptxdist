# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GRAPHITE2) += graphite2

#
# Paths and names
#
GRAPHITE2_VERSION	:= 1.3.11
GRAPHITE2_MD5		:= 9b6166dee759e2175fe7983f65bd8be2
GRAPHITE2		:= graphite2-$(GRAPHITE2_VERSION)
GRAPHITE2_SUFFIX	:= tgz
GRAPHITE2_URL		:= https://github.com/silnrsi/graphite/releases/download/$(GRAPHITE2_VERSION)/$(GRAPHITE2).$(GRAPHITE2_SUFFIX)
GRAPHITE2_SOURCE	:= $(SRCDIR)/$(GRAPHITE2).$(GRAPHITE2_SUFFIX)
GRAPHITE2_DIR		:= $(BUILDDIR)/$(GRAPHITE2)
GRAPHITE2_LICENSE	:= LGPL-2.1-or-later OR GPL-2.0-or-later OR MPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GRAPHITE2_CONF_TOOL	:= cmake


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/graphite2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, graphite2)
	@$(call install_fixup, graphite2,PRIORITY,optional)
	@$(call install_fixup, graphite2,SECTION,base)
	@$(call install_fixup, graphite2,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, graphite2,DESCRIPTION,missing)

	@$(call install_lib, graphite2, 0, 0, 0644, libgraphite2)

	@$(call install_finish, graphite2)

	@$(call touch)

# vim: syntax=make
