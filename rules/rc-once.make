# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RC_ONCE) += rc-once

#
# Paths and names
#
RC_ONCE_VERSION	:= 1.0.0
RC_ONCE		:= rc-once-$(RC_ONCE_VERSION)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/rc-once.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/rc-once.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/rc-once.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rc-once.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rc-once.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  rc-once)
	@$(call install_fixup, rc-once, PRIORITY, optional)
	@$(call install_fixup, rc-once, SECTION, base)
	@$(call install_fixup, rc-once, AUTHOR, "Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, rc-once, DESCRIPTION, missing)

	@$(call install_alternative, rc-once, 0, 0, 0755, /etc/init.d/rc-once)

ifneq ($(call remove_quotes,$(PTXCONF_RC_ONCE_BBINIT_LINK)),)
	@$(call install_link, rc-once, \
		../init.d/rc-once, \
		/etc/rc.d/$(PTXCONF_RC_ONCE_BBINIT_LINK))
endif

	@$(call install_copy, rc-once, 0, 0, 0755, /etc/rc.once.d)
	@$(call install_copy, rc-once, 0, 0, 0755, /etc/rc.once.d/.done)

	@$(call install_finish, rc-once)

	@$(call touch)

# vim: syntax=make

