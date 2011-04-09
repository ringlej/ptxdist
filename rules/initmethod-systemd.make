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

	@$(call install_finish,initmethod-systemd)

	@$(call touch)

# vim: syntax=make
