# -*-makefile-*-
#
# Copyright (C) 2017 by Alexander Dahl <post@lespocky.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DROPWATCH) += dropwatch

#
# Paths and names
#
# No tags: use a fake descriptive commit-ish to include the date
DROPWATCH_VERSION	:= 2015-07-06-g7c33d8a
DROPWATCH_MD5		:= c4164e9f96bb5c0b801047685ed09ea5
DROPWATCH		:= dropwatch-$(DROPWATCH_VERSION)
DROPWATCH_SUFFIX	:= tar.gz
DROPWATCH_URL		:= git://git.infradead.org/users/nhorman/dropwatch.git;tag=$(DROPWATCH_VERSION)
DROPWATCH_SOURCE	:= $(SRCDIR)/$(DROPWATCH).$(DROPWATCH_SUFFIX)
DROPWATCH_DIR		:= $(BUILDDIR)/$(DROPWATCH)
DROPWATCH_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DROPWATCH_CONF_TOOL	:= NO
DROPWATCH_MAKE_ENV	:= $(CROSS_ENV)
DROPWATCH_MAKE_OPT	:= build

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dropwatch.install:
	@$(call targetinfo)
	install -D -m 0755 $(DROPWATCH_DIR)/src/dropwatch \
			$(DROPWATCH_PKGDIR)/usr/bin/dropwatch
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dropwatch.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dropwatch)
	@$(call install_fixup, dropwatch,PRIORITY,optional)
	@$(call install_fixup, dropwatch,SECTION,base)
	@$(call install_fixup, dropwatch,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, dropwatch,DESCRIPTION,missing)

	@$(call install_copy, dropwatch, 0, 0, 0755, -, /usr/bin/dropwatch)

	@$(call install_finish, dropwatch)

	@$(call touch)

# vim: ft=make noet
