# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_PKG_CONFIG_WRAPPER) += cross-pkg-config-wrapper
CROSS_PKG_CONFIG_WRAPPER_LICENSE := ignore

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

CROSS_PKG_CONFIG_WRAPPER_SCRIPT = \
	$(shell ptxd_get_alternative scripts pkg-config-wrapper && echo $$ptxd_reply)

$(STATEDIR)/cross-pkg-config-wrapper.install:
	@$(call targetinfo)
	@ln -sv $(CROSS_PKG_CONFIG_WRAPPER_SCRIPT) \
		$(PTXCONF_SYSROOT_CROSS)/bin/$(COMPILER_PREFIX)pkg-config
	@ln -sv $(CROSS_PKG_CONFIG_WRAPPER_SCRIPT) \
		$(PTXCONF_SYSROOT_CROSS)/bin/pkg-config
	@$(call touch)

# vim: syntax=make
