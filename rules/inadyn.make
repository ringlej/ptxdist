# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INADYN) += inadyn

#
# Paths and names
#
INADYN_VERSION	:= 1.96.2
INADYN_MD5	:= fecb4c970811cb0c8b8d2ffcd7792879
INADYN		:= inadyn-$(INADYN_VERSION)
INADYN_SUFFIX	:= tar.bz2
INADYN_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-sr/$(INADYN).$(INADYN_SUFFIX)
INADYN_SOURCE	:= $(SRCDIR)/$(INADYN).$(INADYN_SUFFIX)
INADYN_DIR	:= $(BUILDDIR)/$(INADYN)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

INADYN_MAKE_ENV	:= $(CROSS_ENV)
INADYN_MAKE_OPT	:= TARGET_ARCH=linux

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/inadyn.install:
	@$(call targetinfo)
	install -D -m755 $(INADYN_DIR)/bin/linux/inadyn \
		$(INADYN_PKGDIR)/sbin/inadyn
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/inadyn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, inadyn)
	@$(call install_fixup, inadyn,PRIORITY,optional)
	@$(call install_fixup, inadyn,SECTION,base)
	@$(call install_fixup, inadyn,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, inadyn,DESCRIPTION,missing)

	@$(call install_copy, inadyn, 0, 0, 0755, -, /sbin/inadyn)
	@$(call install_alternative, inadyn, 0, 0, 0600, /etc/inadyn.conf)

	@$(call install_finish, inadyn)

	@$(call touch)

# vim: syntax=make
