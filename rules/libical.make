# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBICAL) += libical

#
# Paths and names
#
LIBICAL_VERSION	:= 0.46
LIBICAL_MD5	:= 9c08f88945bfd5d0791d102e4aa4125c
LIBICAL		:= libical-$(LIBICAL_VERSION)
LIBICAL_SUFFIX	:= tar.gz
LIBICAL_URL	:= $(PTXCONF_SETUP_SFMIRROR)/project/freeassociation/libical/libical-0.46/$(LIBICAL).$(LIBICAL_SUFFIX)
LIBICAL_SOURCE	:= $(SRCDIR)/$(LIBICAL).$(LIBICAL_SUFFIX)
LIBICAL_DIR	:= $(BUILDDIR)/$(LIBICAL)
LIBICAL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBICAL_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBICAL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBICAL_PATH := PATH=$(CROSS_PATH)
LIBICAL_CONF_ENV := $(CROSS_ENV)

#
# autoconf
#
LIBICAL_CONF_TOOL := autoconf
LIBICAL_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-icalerrors-are-fatal \
	--disable-java \
	--disable-python \
	--without-builtintz \
	--without-bdb4 \
	--without-backtrace \
	--without-devel

ifdef PTXCONF_LIBICAL_CXX
LIBICAL_CONF_OPT	+= --enable-cxx
else
LIBICAL_CONF_OPT	+= --disable-cxx
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libical.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libical)
	@$(call install_fixup, libical,PRIORITY,optional)
	@$(call install_fixup, libical,SECTION,base)
	@$(call install_fixup, libical,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libical,DESCRIPTION,missing)

	@$(call install_lib, libical, 0, 0, 0644, libical)
	@$(call install_lib, libical, 0, 0, 0644, libicalss)
	@$(call install_lib, libical, 0, 0, 0644, libicalvcal)

ifdef PTXCONF_LIBICAL_CXX
	@$(call install_lib, libical, 0, 0, 0644, libical_cxx)
	@$(call install_lib, libical, 0, 0, 0644, libicalss_cxx)
endif
	@$(call install_finish, libical)

	@$(call touch)

# vim: syntax=make
