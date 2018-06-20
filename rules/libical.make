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
LIBICAL_VERSION	:= 3.0.3
LIBICAL_MD5	:= ead7d0d349f872a909cd4f30988de7fc
LIBICAL		:= libical-$(LIBICAL_VERSION)
LIBICAL_SUFFIX	:= tar.gz
LIBICAL_URL	:= https://github.com/libical/libical/releases/download/v$(LIBICAL_VERSION)/$(LIBICAL).$(LIBICAL_SUFFIX)
LIBICAL_SOURCE	:= $(SRCDIR)/$(LIBICAL).$(LIBICAL_SUFFIX)
LIBICAL_DIR	:= $(BUILDDIR)/$(LIBICAL)
LIBICAL_LICENSE	:= LGPL-2.1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
#
# cmake
#
LIBICAL_CONF_TOOL := cmake
LIBICAL_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DICU_INCLUDE_DIR=NO \
	-DICU_LIBRARY=NO \
	-DSHARED_ONLY=ON \
	-DGOBJECT_INTROSPECTION=OFF \
	-DICAL_BUILD_DOCS=OFF \
	-DICAL_GLIB_VAPI=OFF \
	-DICAL_GLIB=OFF \
	-DWITH_CXX_BINDINGS=$(call ptx/onoff,PTXCONF_LIBICAL_CXX)

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
