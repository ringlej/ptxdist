# -*-makefile-*-
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: is this a hosttool? 

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBIDL068) += libidl068

#
# Paths and names
#
LIBIDL068_VERSION	:= 0.6.8
LIBIDL068		:= libIDL-$(LIBIDL068_VERSION)
LIBIDL068_SUFFIX	:= tar.gz
LIBIDL068_URL		:= http://ftp.mozilla.org/pub/mozilla/libraries/source/$(LIBIDL068).$(LIBIDL068_SUFFIX)
LIBIDL068_SOURCE	:= $(SRCDIR)/$(LIBIDL068).$(LIBIDL068_SUFFIX)
LIBIDL068_DIR		:= $(BUILDDIR)/$(LIBIDL068)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBIDL068_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBIDL068)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBIDL068_PATH	:= PATH=$(CROSS_PATH)
LIBIDL068_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBIDL068_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

# FIXME
ifdef PTXCONF_LIBIDL068_FOO
LIBIDL068_AUTOCONF	+= --enable-foo
endif

$(STATEDIR)/libidl068.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBIDL068_BUILDDIR))
	cd $(LIBIDL068_DIR) && \
		$(LIBIDL068_PATH) $(LIBIDL068_ENV) \
		./configure $(LIBIDL068_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libidl068.compile:
	@$(call targetinfo)

	$(LIBIDL068_PATH) $(LIBIDL068_ENV) make -C $(LIBIDL068_DIR)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libidl068.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libidl068_clean:
	rm -rf $(STATEDIR)/libidl068.*
	rm -rf $(LIBIDL068_DIR)

# vim: syntax=make
