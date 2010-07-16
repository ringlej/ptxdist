# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
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
PACKAGES-$(PTXCONF_LOGROTATE) += logrotate

#
# Paths and names
#
LOGROTATE_VERSION	:= 3.7.1
LOGROTATE		:= logrotate-$(LOGROTATE_VERSION)
LOGROTATE_SUFFIX	:= tar.gz
LOGROTATE_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(LOGROTATE).$(LOGROTATE_SUFFIX)
LOGROTATE_SOURCE	:= $(SRCDIR)/$(LOGROTATE).$(LOGROTATE_SUFFIX)
LOGROTATE_DIR		:= $(BUILDDIR)/$(LOGROTATE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LOGROTATE_SOURCE):
	@$(call targetinfo)
	@$(call get, LOGROTATE)


# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

LOGROTATE_PATH		:= PATH=$(CROSS_PATH)
LOGROTATE_MAKE_ENV	:= $(CROSS_ENV) RPM_OPT_FLAGS='$(strip $(CROSS_CPPFLAGS))'
LOGROTATE_MAKE_OPT	:= OS_NAME=Linux LFS=-D_FILE_OFFSET_BITS=64

LOGROTATE_INSTALL_OPT	:= PREFIX=$(LOGROTATE_PKGDIR) install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/logrotate.targetinstall:
	@$(call targetinfo)

	@$(call install_init, logrotate)
	@$(call install_fixup,logrotate,PRIORITY,optional)
	@$(call install_fixup,logrotate,SECTION,base)
	@$(call install_fixup,logrotate,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,logrotate,DESCRIPTION,missing)

	@$(call install_copy, logrotate, 0, 0, 0755, -, /usr/sbin/logrotate)

	@$(call install_finish,logrotate)

	@$(call touch)

# vim: syntax=make
