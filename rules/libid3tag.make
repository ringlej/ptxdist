# -*-makefile-*-
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBID3TAG) += libid3tag

#
# Paths and names
#
LIBID3TAG_VERSION	:= 0.15.1b
LIBID3TAG_MD5		:= e5808ad997ba32c498803822078748c3
LIBID3TAG		:= libid3tag-$(LIBID3TAG_VERSION)
LIBID3TAG_SUFFIX	:= tar.gz
LIBID3TAG_URL		:= ftp://ftp.mars.org/pub/mpeg/$(LIBID3TAG).$(LIBID3TAG_SUFFIX)
LIBID3TAG_SOURCE	:= $(SRCDIR)/$(LIBID3TAG).$(LIBID3TAG_SUFFIX)
LIBID3TAG_DIR		:= $(BUILDDIR)/$(LIBID3TAG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBID3TAG_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBID3TAG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBID3TAG_PATH	:= PATH=$(CROSS_PATH)
LIBID3TAG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBID3TAG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debugging \
	--disable-profiling

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libid3tag.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libid3tag)
	@$(call install_fixup, libid3tag,PRIORITY,optional)
	@$(call install_fixup, libid3tag,SECTION,base)
	@$(call install_fixup, libid3tag,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libid3tag,DESCRIPTION,missing)

	@$(call install_lib, libid3tag, 0, 0, 0644, libid3tag)

	@$(call install_finish, libid3tag)

	@$(call touch)

# vim: syntax=make
