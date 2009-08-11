# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_PROJECT_USE_PRODUCTION

$(STATEDIR)/kernel.extract:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/kernel.prepare:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/kernel.compile:
	@$(call targetinfo)
	@$(call touch)

kernel_clean:
	@rm -rf $(STATEDIR)/kernel.* $(STATEDIR)/kernel-modules.*
	@rm -rf $(PKGDIR)/kernel_* $(PKGDIR)/kernel-modules_*

endif

# vim: syntax=make
