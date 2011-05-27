# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INITMETHOD_SYSTEMD) += initmethod-systemd

INITMETHOD_SYSTEMD_VERSION	:= 1.0.0

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initmethod-systemd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, initmethod-systemd)
	@$(call install_fixup,initmethod-systemd,PRIORITY,optional)
	@$(call install_fixup,initmethod-systemd,SECTION,base)
	@$(call install_fixup,initmethod-systemd,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,initmethod-systemd,DESCRIPTION,missing)

	@$(call install_alternative, initmethod-systemd, 0, 0, 0755, /lib/init/initmethod-bbinit-functions.sh)

ifdef PTXCONF_INITMETHOD_SYSTEMD_IFUPDOWN
	@$(call install_alternative, initmethod-systemd, 0, 0, 0755, \
		/lib/systemd/ifupdown-prepare)
	@$(call install_alternative, initmethod-systemd, 0, 0, 0644, \
		/lib/systemd/system/ifupdown-prepare.service)
	@$(call install_link, initmethod-systemd, ../ifupdown-prepare.service, \
		/lib/systemd/system/ifupdown.service.wants/ifupdown-prepare.service)

	@$(call install_alternative, initmethod-systemd, 0, 0, 0644, \
		/lib/systemd/system/ifupdown.service)
	@$(call install_link, initmethod-systemd, ../ifupdown.service, \
		/lib/systemd/system/network.target.wants/ifupdown.service)

	@$(call install_link, initmethod-systemd, ../network.target, \
		/lib/systemd/system/multi-user.target.wants/network.target)

	@$(call install_alternative, initmethod-systemd, 0, 0, 0644, /etc/network/interfaces)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-down.d)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-up.d)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-post-down.d)
	@$(call install_copy, initmethod-systemd, 0, 0, 0755, /etc/network/if-pre-up.d)
endif

	@$(call install_finish,initmethod-systemd)

	@$(call touch)

# vim: syntax=make
