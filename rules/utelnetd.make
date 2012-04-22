# -*-makefile-*-
#
# Copyright (C) 2002, 2003, 2008 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UTELNETD) += utelnetd

#
# Paths and names
#
UTELNETD_VERSION	:= 0.1.11
UTELNETD_MD5		:= a6d1c84163d01e79b45242d6f6435d6a
UTELNETD		:= utelnetd-$(UTELNETD_VERSION)
UTELNETD_URL		:= http://www.pengutronix.de/software/utelnetd/download/$(UTELNETD).tar.gz
UTELNETD_SOURCE		:= $(SRCDIR)/$(UTELNETD).tar.gz
UTELNETD_DIR		:= $(BUILDDIR)/$(UTELNETD)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

UTELNETD_COMPILE_ENV := \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	$(CROSS_ENV_FLAGS)

UTELNETD_INSTALL_OPT := \
	INSTDIR=/sbin \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/utelnetd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, utelnetd)
	@$(call install_fixup, utelnetd,PRIORITY,optional)
	@$(call install_fixup, utelnetd,SECTION,base)
	@$(call install_fixup, utelnetd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, utelnetd,DESCRIPTION,missing)

	@$(call install_copy, utelnetd, 0, 0, 0755, -, /sbin/utelnetd)

	#
	# busybox init
	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_UTELNETD_STARTSCRIPT
	@$(call install_alternative, utelnetd, 0, 0, 0755, /etc/init.d/telnetd, n)

ifneq ($(call remove_quotes,$(PTXCONF_UTELNETD_BBINIT_LINK)),)
	@$(call install_link, utelnetd, \
		../init.d/telnetd, \
		/etc/rc.d/$(PTXCONF_UTELNETD_BBINIT_LINK))
endif
endif
endif
ifdef PTXCONF_UTELNETD_SYSTEMD_UNIT
	@$(call install_alternative, utelnetd, 0, 0, 0644, \
		/lib/systemd/system/utelnetd.service)
	@$(call install_link, utelnetd, ../utelnetd.service, \
		/lib/systemd/system/multi-user.target.wants/utelnetd.service)
endif

	@$(call install_finish, utelnetd)

	@$(call touch)

# vim: syntax=make
