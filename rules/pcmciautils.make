# -*-makefile-*-
#
# Copyright (C) 2005 by Steven Scholz <steven.scholz@imc-berlin.de>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PCMCIAUTILS) += pcmciautils

#
# Paths and names
#
PCMCIAUTILS_VERSION	:= 017
PCMCIAUTILS		:= pcmciautils-$(PCMCIAUTILS_VERSION)
PCMCIAUTILS_SUFFIX	:= tar.gz
PCMCIAUTILS_URL		:= http://www.kernel.org/pub/linux/utils/kernel/pcmcia/$(PCMCIAUTILS).$(PCMCIAUTILS_SUFFIX)
PCMCIAUTILS_SOURCE	:= $(SRCDIR)/$(PCMCIAUTILS).$(PCMCIAUTILS_SUFFIX)
PCMCIAUTILS_DIR		:= $(BUILDDIR)/$(PCMCIAUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PCMCIAUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, PCMCIAUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PCMCIAUTILS_PATH	:= PATH=$(CROSS_PATH)
PCMCIAUTILS_ENV		:= $(CROSS_ENV)

PCMCIAUTILS_COMPILE_ENV := \
	$(CROSS_ENV_CFLAGS) \
	$(CROSS_ENV_CPPFLAGS) \
	$(CROSS_ENV_LDFLAGS)

PCMCIAUTILS_MAKEVARS := \
	CROSS=$(COMPILER_PREFIX) \
	V=1 \
	STRIP=echo \
	$(call ptx/ifdef, PTXCONF_PCMCIAUTILS_STARTUP, STARTUP=true, STARTUP=false)

PCMCIAUTILS_MAKE_PAR := NO

$(STATEDIR)/pcmciautils.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pcmciautils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pcmciautils)
	@$(call install_fixup, pcmciautils,PACKAGE,pcmciautils)
	@$(call install_fixup, pcmciautils,PRIORITY,optional)
	@$(call install_fixup, pcmciautils,VERSION,$(PCMCIAUTILS_VERSION))
	@$(call install_fixup, pcmciautils,SECTION,base)
	@$(call install_fixup, pcmciautils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pcmciautils,DEPENDS,)
	@$(call install_fixup, pcmciautils,DESCRIPTION,missing)

#	# install-tools
	@$(call install_copy, pcmciautils, 0, 0, 0755, -, \
		/sbin/pccardctl);
	@$(call install_link, pcmciautils, pccardctl, /sbin/lspcmcia)

	@$(call install_copy, pcmciautils, 0, 0, 0755, -, \
		/lib/udev/pcmcia-check-broken-cis);

ifdef PTXCONF_PCMCIAUTILS_STARTUP
#	# install-socket-tools
	@$(call install_copy, pcmciautils, 0, 0, 0755, -, \
		/lib/udev/pcmcia-socket-startup);
endif
	@$(call install_finish, pcmciautils)
	@$(call touch)

# vim: syntax=make
