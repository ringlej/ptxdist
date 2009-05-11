# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
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
PORTMAP_VERSION := 5beta
PORTMAP		:= portmap_$(PORTMAP_VERSION)
PORTMAP_SUFFIX	:= tar.gz
PORTMAP_URL	:= ftp://ftp.porcupine.org/pub/security/$(PORTMAP).tar.gz
PORTMAP_SOURCE	:= $(SRCDIR)/$(PORTMAP).tar.gz
PORTMAP_DIR	:= $(BUILDDIR)/$(PORTMAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PORTMAP_SOURCE):
	@$(call targetinfo)
	@$(call get, PORTMAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/portmap.extract:
	@$(call targetinfo)
	@$(call clean, $(PORTMAP_DIR))
	@$(call extract, PORTMAP)
	@$(call patchin, PORTMAP)
#
# Attention: TCP-Wrapper will be ignored and not used!
#
#ifndef PTXCONF_TCPWRAPPER
#	sed -i -e 's/$$(WRAP_DIR)\/libwrap.a//' $(PORTMAP_DIR)/Makefile
#endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/portmap.prepare: $(portmap_prepare_deps_default)
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

PORTMAP_ENV		= $(CROSS_ENV)
PORTMAP_PATH		= PATH=$(CROSS_PATH)

ifdef PTXCONF_TCPWRAPPER
PORTMAP_MAKEVARS	= WRAP_DIR=$(SYSROOT)/lib
endif

$(STATEDIR)/portmap.compile:
	@$(call targetinfo)
	cd $(PORTMAP_DIR) && 						\
		$(PORTMAP_ENV) $(PORTMAP_PATH) make $(PORTMAP_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/portmap.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/portmap.targetinstall:
	@$(call targetinfo)

	@$(call install_init, portmap)
	@$(call install_fixup, portmap,PACKAGE,portmap)
	@$(call install_fixup, portmap,PRIORITY,optional)
	@$(call install_fixup, portmap,VERSION,$(PORTMAP_VERSION))
	@$(call install_fixup, portmap,SECTION,base)
	@$(call install_fixup, portmap,AUTHOR,"Juergen Beisert <jbeisert@netscape.net>")
	@$(call install_fixup, portmap,DEPENDS,)
	@$(call install_fixup, portmap,DESCRIPTION,missing)

	@$(call install_copy, portmap, 0, 0, 0755, \
		$(PORTMAP_DIR)/portmap, \
		/sbin/portmap)

#	#
#	# busybox init
#	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_PORTMAP_STARTSCRIPT
	@$(call install_alternative, portmap, 0, 0, 0755, /etc/init.d/portmapd, n)
endif
endif

#	#
#	# /etc/inetd.conf sniplet
#	#
ifdef PTXCONF_PORTMAP_INETD_SERVER
	@$(call install_alternative, portmap, 0, 0, 0644, /etc/inetd.conf.d/portmap, n)
endif

	@$(call install_finish, portmap)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

portmap_clean:
	rm -rf $(STATEDIR)/portmap.*
	rm -rf $(PKGDIR)/portmap_*
	rm -rf $(PORTMAP_DIR)

# vim: syntax=make
