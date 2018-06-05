# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_RUBY) += host-system-ruby
HOST_SYSTEM_RUBY_LICENSE := ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-system-ruby.prepare:
	@$(call targetinfo)
	@echo "Checking for Ruby ..."
	@ruby --version >/dev/null 2>&1 || \
		ptxd_bailout "'ruby' not found! Please install.";
	@echo
	@$(call touch)

# vim: syntax=make
