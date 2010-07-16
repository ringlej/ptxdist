# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
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
PACKAGES-$(PTXCONF_FFTW) += fftw

#
# Paths and names
#
FFTW_VERSION	:= 3.2.2
FFTW		:= fftw-$(FFTW_VERSION)
FFTW_SUFFIX	:= tar.gz
FFTW_SOURCE	:= $(SRCDIR)/$(FFTW).$(FFTW_SUFFIX)
FFTW_DIR	:= $(BUILDDIR)/$(FFTW)
FFTW_URL	:= \
	http://www.fftw.org/$(FFTW).$(FFTW_SUFFIX) \
	ftp://ftp.fftw.org/pub/fftw/old/$(FFTW).$(FFTW_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FFTW_SOURCE):
	@$(call targetinfo)
	@$(call get, FFTW)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FFTW_PATH	:= PATH=$(CROSS_PATH)
FFTW_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FFTW_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fftw.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fftw)
	@$(call install_fixup, fftw,PRIORITY,optional)
	@$(call install_fixup, fftw,SECTION,base)
	@$(call install_fixup, fftw,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fftw,DESCRIPTION,missing)

	@$(call install_copy, fftw, 0, 0, 0644, -, /usr/lib/libfftw3.so.3.2.4)
	@$(call install_link, fftw, libfftw3.so.3.2.4, /usr/lib/libfftw3.so.3)
	@$(call install_link, fftw, libfftw3.so.3.2.4, /usr/lib/libfftw3.so)

	@$(call install_finish, fftw)

	@$(call touch)

# vim: syntax=make
