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

	@$(call install_alternative, rc-once, 0, 0, 0644, /lib/init/rc-once.sh)

ifdef PTXCONF_INITMETHOD_BBINIT
	@$(call install_alternative, rc-once, 0, 0, 0755, /etc/init.d/rc-once)

ifneq ($(call remove_quotes,$(PTXCONF_RC_ONCE_BBINIT_LINK)),)
	@$(call install_link, rc-once, \
		../init.d/rc-once, \
		/etc/rc.d/$(PTXCONF_RC_ONCE_BBINIT_LINK))
endif
endif
ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_alternative, rc-once, 0, 0, 0755, \
		/lib/systemd/systemd-rc-once)

	@$(call install_alternative, rc-once, 0, 0, 0644, \
		/lib/systemd/system/rc-once.service)
	@$(call install_alternative, rc-once, 0, 0, 0644, \
		/lib/systemd/system/rc-once.target)
	@$(call install_copy, rc-once, 0, 0, 0755, /etc/systemd/system)
endif

	@$(call install_copy, rc-once, 0, 0, 0755, /etc/rc.once.d)
	@$(call install_copy, rc-once, 0, 0, 0755, /etc/rc.once.d/.done)

	@$(call install_finish, rc-once)

	@$(call touch)

# vim: syntax=make

