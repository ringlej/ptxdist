# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
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
PACKAGES-$(PTXCONF_LIBGMP) += libgmp

#
# Paths and names
#
LIBGMP_VERSION	:= 6.1.2
LIBGMP_MD5	:= 8ddbb26dc3bd4e2302984debba1406a5
LIBGMP		:= gmp-$(LIBGMP_VERSION)
LIBGMP_SUFFIX	:= tar.bz2
LIBGMP_URL	:= $(call ptx/mirror, GNU, gmp/$(LIBGMP).$(LIBGMP_SUFFIX))
LIBGMP_SOURCE	:= $(SRCDIR)/$(LIBGMP).$(LIBGMP_SUFFIX)
LIBGMP_DIR	:= $(BUILDDIR)/$(LIBGMP)
LIBGMP_LICENSE	:= GPL-3.0-only AND LGPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBGMP_CONF_TOOL	:= autoconf
LIBGMP_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-assert \
	--enable-alloca \
	--disable-cxx \
	--enable-assembly \
	--enable-fft \
	--disable-old-fft-full \
	--disable-nails \
	--disable-profiling \
	--disable-fat \
	--disable-minithres \
	--disable-fake-cpuid \
	--enable-shared \
	--disable-static \
	--without-readline

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgmp)
	@$(call install_fixup, libgmp,PRIORITY,optional)
	@$(call install_fixup, libgmp,SECTION,base)
	@$(call install_fixup, libgmp,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, libgmp,DESCRIPTION,missing)

	@$(call install_lib, libgmp, 0, 0, 0644, libgmp)

	@$(call install_finish, libgmp)

	@$(call touch)

# vim: syntax=make
