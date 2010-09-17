# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
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
PACKAGES-$(PTXCONF_LIBPV) += libpv

#
# Paths and names
#
LIBPV_VERSION	:= 1.4.1
LIBPV		:= libpv-$(LIBPV_VERSION)
LIBPV_SUFFIX	:= tar.bz2
LIBPV_URL	:= http://www.pengutronix.de/software/libpv/download/$(LIBPV).$(LIBPV_SUFFIX)
LIBPV_SOURCE	:= $(SRCDIR)/$(LIBPV).$(LIBPV_SUFFIX)
LIBPV_DIR	:= $(BUILDDIR)/$(LIBPV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBPV_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBPV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBPV_CONF_TOOL	:= autoconf

# force disable xsltproc to avoid building docs
LIBPV_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_prog_XSLTPROC=false

LIBPV_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--disable-debug

ifdef PTXCONF_LIBPV_EVENT
LIBPV_CONF_OPT += --enable-event
else
LIBPV_CONF_OPT += --disable-event
endif

ifdef PTXCONF_LIBPV_PYTHON
LIBPV_CONF_OPT += --enable-python
else
LIBPV_CONF_OPT += --disable-python
endif

ifdef PTXCONF_LIBPV_XML_EXPAT
LIBPV_CONF_OPT += --with-expat
else
LIBPV_CONF_OPT += --without-expat
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpv)
	@$(call install_fixup, libpv,PRIORITY,optional)
	@$(call install_fixup, libpv,SECTION,base)
	@$(call install_fixup, libpv,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libpv,DESCRIPTION,missing)

ifdef PTXCONF_LIBPV_PVTOOL
	@$(call install_copy, libpv, 0, 0, 0755, -, \
		/usr/bin/pvtool)
endif
ifdef PTXCONF_LIBPV_EVENT
	@$(call install_copy, libpv, 0, 0, 0755, -, \
		/usr/bin/pv_eventd)
endif

	@$(call install_copy, libpv, 0, 0, 0644, - , \
		/usr/lib/libpv.so.12.0.0)
	@$(call install_link, libpv, libpv.so.12.0.0, /usr/lib/libpv.so.12)
	@$(call install_link, libpv, libpv.so.12.0.0, /usr/lib/libpv.so)

ifdef PTXCONF_LIBPV_PYTHON
	@$(call install_copy, libpv, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/libpv.so)
endif

	@$(call install_finish, libpv)

	@$(call touch)

# vim: syntax=make
