# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
# Copyright (C) 2005 by Oscar Peredo
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSVINIT) += sysvinit

#
# Paths and names
#
SYSVINIT_VERSION	:= 2.86
SYSVINIT		:= sysvinit-$(SYSVINIT_VERSION)
SYSVINIT_SUFFIX		:= tar.gz
SYSVINIT_URL		:= ftp://ftp.cistron.nl/pub/people/miquels/sysvinit/$(SYSVINIT).$(SYSVINIT_SUFFIX)
SYSVINIT_SOURCE		:= $(SRCDIR)/$(SYSVINIT).$(SYSVINIT_SUFFIX)
SYSVINIT_DIR		:= $(BUILDDIR)/$(SYSVINIT)

BSDINIT_URL		= http://www.exis.cl/ptxdist/bsdinit-1.0.tar.gz
BSDINIT_SOURCE		= $(SRCDIR)/bsdinit-1.0.tar.gz
BSDINIT_DIR		= $(BUILDDIR)/bsdinit-1.0


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SYSVINIT_SOURCE):
	@$(call targetinfo)
	@$(call get, SYSVINIT)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

SYSVINIT_PATH		:= PATH=$(CROSS_PATH)
SYSVINIT_MAKE_OPT	:= $(CROSS_ENV)
SYSVINIT_SUBDIR		:= src

SYSVINIT_INSTALL_OPT	:= ROOT=$(SYSVINIT_PKGDIR) install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sysvinit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sysvinit)
	@$(call install_fixup, sysvinit,PACKAGE,sysvinit)
	@$(call install_fixup, sysvinit,PRIORITY,optional)
	@$(call install_fixup, sysvinit,VERSION,$(SYSVINIT_VERSION))
	@$(call install_fixup, sysvinit,SECTION,base)
	@$(call install_fixup, sysvinit,AUTHOR,"Oscar Peredo <oscar@exis.cl>")
	@$(call install_fixup, sysvinit,DEPENDS,)
	@$(call install_fixup, sysvinit,DESCRIPTION,missing)

ifdef PTXCONF_SYSVINIT_INIT
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /sbin/init)
	@$(call install_link, sysvinit, init, /sbin/telinit)
endif
ifdef PTXCONF_SYSVINIT_HALT
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /sbin/halt)
	@$(call install_link, sysvinit, halt, /sbin/poweroff)
	@$(call install_link, sysvinit, halt, /sbin/reboot)
endif
ifdef PTXCONF_SYSVINIT_SHUTDOWN
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /sbin/shutdown)
endif
ifdef PTXCONF_SYSVINIT_RUNLEVEL
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /sbin/runlevel)
endif
ifdef PTXCONF_SYSVINIT_KILLALL5
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /sbin/killall5)
endif
ifdef PTXCONF_SYSVINIT_SULOGIN
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /sbin/sulogin)
endif
ifdef PTXCONF_SYSVINIT_BOOTLOGD
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /sbin/bootlogd)
endif
ifdef PTXCONF_SYSVINIT_WALL
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /usr/bin/wall)
endif
ifdef PTXCONF_SYSVINIT_LAST
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /usr/bin/last)
endif
ifdef PTXCONF_SYSVINIT_MESG
	@$(call install_copy, sysvinit, 0, 0, 0755, -, /usr/bin/mesg)
endif
ifdef PTXCONF_SYSVINIT_BSDINIT
	@$(call clean, $(BSDINIT_DIR))
	@$(call get, BSDINIT)
	@$(call extract, BSDINIT)
	@$(call install_copy, sysvinit, 0, 0, 0644, $(BSDINIT_DIR)/inittab, /etc/inittab, n)
	@$(call install_copy, sysvinit, 0, 0, 0755, /etc/rc.d)
	@$(call install_copy, sysvinit, 0, 0, 0754, $(BSDINIT_DIR)/rc.0, /etc/rc.d/rc.0, n)
	@$(call install_copy, sysvinit, 0, 0, 0754, $(BSDINIT_DIR)/rc.1, /etc/rc.d/rc.1, n)
	@$(call install_copy, sysvinit, 0, 0, 0754, $(BSDINIT_DIR)/rc.2, /etc/rc.d/rc.2, n)
	@$(call install_copy, sysvinit, 0, 0, 0754, $(BSDINIT_DIR)/rc.5, /etc/rc.d/rc.5, n)
	@$(call install_copy, sysvinit, 0, 0, 0754, $(BSDINIT_DIR)/rc.sysinit, /etc/rc.d/rc.sysinit, n) 
	@$(call install_link, sysvinit, rc.2, /etc/rc.d/rc.3)
	@$(call install_link, sysvinit, rc.2, /etc/rc.d/rc.4)
	@$(call install_link, sysvinit, rc.0, /etc/rc.d/rc.6)
endif

	@$(call install_finish, sysvinit)

	@$(call touch)

# vim: syntax=make
