# -*-makefile-*-
#
# Copyright (C) 2006-2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBLTDL) += libltdl

#
# Paths and names
#
LIBLTDL_VERSION	:= 1.5.26
LIBLTDL		:= libtool-$(LIBLTDL_VERSION)
LIBLTDL_SUFFIX	:= tar.gz
LIBLTDL_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/libtool/$(LIBLTDL).$(LIBLTDL_SUFFIX)
LIBLTDL_SOURCE	:= $(SRCDIR)/$(LIBLTDL).$(LIBLTDL_SUFFIX)
LIBLTDL_DIR	:= $(BUILDDIR)/$(LIBLTDL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBLTDL_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBLTDL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBLTDL_PATH	:= PATH=$(CROSS_PATH)
LIBLTDL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBLTDL_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libltdl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libltdl)
	@$(call install_fixup,libltdl,PRIORITY,optional)
	@$(call install_fixup,libltdl,SECTION,base)
	@$(call install_fixup,libltdl,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,libltdl,DESCRIPTION,missing)

	@$(call install_copy, libltdl, 0, 0, 0644, -, \
		/usr/lib/libltdl.so.3.1.6)
	@$(call install_link, libltdl, libltdl.so.3.1.6, /usr/lib/libltdl.so.3)
	@$(call install_link, libltdl, libltdl.so.3.1.6, /usr/lib/libltdl.so)

	@$(call install_finish,libltdl)

	@$(call touch)

# vim: syntax=make
