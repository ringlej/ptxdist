# -*-makefile-*-
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PORTMAP) += portmap

#
# Paths and names
#
PORTMAP_VERSION := 6.0
PORTMAP		:= portmap_$(PORTMAP_VERSION)
PORTMAP_SUFFIX	:= tgz
PORTMAP_URL	:= http://neil.brown.name/portmap/portmap-$(PORTMAP_VERSION).$(PORTMAP_SUFFIX)
PORTMAP_SOURCE	:= $(SRCDIR)/portmap-$(PORTMAP_VERSION).$(PORTMAP_SUFFIX)
PORTMAP_DIR	:= $(BUILDDIR)/$(PORTMAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PORTMAP_SOURCE):
	@$(call targetinfo)
	@$(call get, PORTMAP)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

PORTMAP_ENV		:= $(CROSS_ENV)
PORTMAP_PATH		:= PATH=$(CROSS_PATH)
PORTMAP_MAKE_OPT	:= CC=$(CROSS_CC) NO_TCP_WRAPPER=yes

PORTMAP_INSTALL_OPT	:= BASEDIR=$(PORTMAP_PKGDIR) install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/portmap.targetinstall:
	@$(call targetinfo)

	@$(call install_init, portmap)
	@$(call install_fixup, portmap,PRIORITY,optional)
	@$(call install_fixup, portmap,SECTION,base)
	@$(call install_fixup, portmap,AUTHOR,"Juergen Beisert <jbeisert@netscape.net>")
	@$(call install_fixup, portmap,DESCRIPTION,missing)

	@$(call install_copy, portmap, 0, 0, 0755, -, /sbin/portmap)

	#
	# busybox init
	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_PORTMAP_STARTSCRIPT
	@$(call install_alternative, portmap, 0, 0, 0755, /etc/init.d/portmapd, n)
endif
endif

ifdef PTXCONF_PORTMAP_INETD_SERVER
	@$(call install_alternative, portmap, 0, 0, 0644, /etc/inetd.conf.d/portmap, n)
endif

	@$(call install_finish, portmap)
	@$(call touch)

# vim: syntax=make
