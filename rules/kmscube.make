# -*-makefile-*-
#
# Copyright (C) 2017 by Markus Niebel <Markus.Niebel@tq-group.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KMSCUBE) += kmscube

#
# Paths and names
#
# No tags: use a fake descriptive commit-ish to include the date
KMSCUBE_VERSION	:= 2017-03-13-g803bac5
KMSCUBE		:= kmscube-$(KMSCUBE_VERSION)
KMSCUBE_MD5	:= 781a59ab2d1d245e99a49df7c3dc1876
KMSCUBE_URL	:= git://anongit.freedesktop.org/mesa/kmscube;tag=$(KMSCUBE_VERSION)
KMSCUBE_SUFFIX	:= tar.gz
KMSCUBE_SOURCE	:= $(SRCDIR)/$(KMSCUBE).$(KMSCUBE_SUFFIX)
KMSCUBE_DIR	:= $(BUILDDIR)/$(KMSCUBE)

KMSCUBE_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
KMSCUBE_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kmscube.targetinstall:
	@$(call targetinfo)

	@$(call install_init, kmscube)
	@$(call install_fixup, kmscube, PRIORITY, optional)
	@$(call install_fixup, kmscube, SECTION, base)
	@$(call install_fixup, kmscube, AUTHOR, "Markus Niebel <Markus.Niebel@tq-group.com>")
	@$(call install_fixup, kmscube, DESCRIPTION, missing)

	@$(call install_copy, kmscube, 0, 0, 0755, -, /usr/bin/kmscube)

	@$(call install_finish, kmscube)

	@$(call touch)

# vim: syntax=make
