# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TIMEOUT) += timeout

#
# Paths and names
#
TIMEOUT_VERSION	:= 1.18
TIMEOUT_MD5	:= 81d747a0add4c2a9e5071eda5c412658
TIMEOUT		:= tct-$(TIMEOUT_VERSION)
TIMEOUT_SUFFIX	:= tar.gz
TIMEOUT_URL	:= http://www.porcupine.org/forensics/$(TIMEOUT).$(TIMEOUT_SUFFIX)
TIMEOUT_SOURCE	:= $(SRCDIR)/$(TIMEOUT).$(TIMEOUT_SUFFIX)
TIMEOUT_DIR	:= $(BUILDDIR)/$(TIMEOUT)
TIMEOUT_SUBDIR	:= src/misc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TIMEOUT_CONF_TOOL	:= NO
TIMEOUT_MAKE_OPT	:= \
	$(CROSS_ENV_PROGS) \
	../../bin/timeout

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/timeout.install:
	@$(call targetinfo)
	@install -v -D -m755 $(TIMEOUT_DIR)/bin/timeout \
		$(TIMEOUT_PKGDIR)/usr/bin/timeout
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/timeout.targetinstall:
	@$(call targetinfo)

	@$(call install_init, timeout)
	@$(call install_fixup, timeout,PRIORITY,optional)
	@$(call install_fixup, timeout,SECTION,base)
	@$(call install_fixup, timeout,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, timeout,DESCRIPTION,missing)

	@$(call install_copy, timeout, 0, 0, 0755, -, /usr/bin/timeout)

	@$(call install_finish, timeout)

	@$(call touch)

# vim: syntax=make
