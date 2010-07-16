# -*-makefile-*-
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BZIP2) += bzip2

#
# Paths and names
#
BZIP2_VERSION	:= 1.0.5
BZIP2		:= bzip2-$(BZIP2_VERSION)
BZIP2_SUFFIX	:= tar.gz
BZIP2_URL	:= http://www.bzip.org/1.0.5/$(BZIP2).$(BZIP2_SUFFIX)
BZIP2_SOURCE	:= $(SRCDIR)/$(BZIP2).$(BZIP2_SUFFIX)
BZIP2_DIR	:= $(BUILDDIR)/$(BZIP2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BZIP2_SOURCE):
	@$(call targetinfo)
	@$(call get, BZIP2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BZIP2_MAKE_OPT		:= $(CROSS_ENV)
BZIP2_INSTALL_OPT	:= PREFIX=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bzip2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bzip2)
	@$(call install_fixup, bzip2,PRIORITY,optional)
	@$(call install_fixup, bzip2,SECTION,base)
	@$(call install_fixup, bzip2,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, bzip2,DESCRIPTION,missing)

ifdef PTXCONF_BZIP2_LIBBZ2
	@$(call install_copy, bzip2, 0, 0, 0644, -, /usr/lib/libbz2.so.1.0.4)
	@$(call install_link, bzip2, libbz2.so.1.0.4, /usr/lib/libbz2.so.1.0)
endif

ifdef PTXCONF_BZIP2_BZIP2
	@$(call install_copy, bzip2, 0, 0, 0755, -, /usr/bin/bzip2)
endif

ifdef PTXCONF_BZIP2_BZIP2RECOVER
	@$(call install_copy, bzip2, 0, 0, 0755, -, /usr/bin/bzip2recover)
endif

	@$(call install_finish, bzip2)

	@$(call touch)

# vim: syntax=make
