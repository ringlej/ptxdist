# -*-makefile-*-
#
# Copyright (C) 2007-2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009 by Marc Kleine-Budde
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBICONV) += host-libiconv

#
# Paths and names
#
HOST_LIBICONV_VERSION	:= 1.13.1
HOST_LIBICONV		:= libiconv-$(HOST_LIBICONV_VERSION)
HOST_LIBICONV_SUFFIX	:= tar.gz
HOST_LIBICONV_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/libiconv/$(HOST_LIBICONV).$(HOST_LIBICONV_SUFFIX)
HOST_LIBICONV_SOURCE	:= $(SRCDIR)/$(HOST_LIBICONV).$(HOST_LIBICONV_SUFFIX)
HOST_LIBICONV_DIR	:= $(HOST_BUILDDIR)/$(HOST_LIBICONV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_LIBICONV_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_LIBICONV)


# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libiconv.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_LIBICONV_DIR))
	@$(call extract, HOST_LIBICONV, $(HOST_BUILDDIR))
	@$(call patchin, HOST_LIBICONV, $(HOST_LIBICONV_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBICONV_PATH	:= PATH=$(HOST_PATH)
HOST_LIBICONV_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBICONV_AUTOCONF	:= \
	$(HOST_AUTOCONF)

$(STATEDIR)/host-libiconv.prepare:
	@$(call targetinfo)
	@$(call clean, $(HOST_LIBICONV_DIR)/config.cache)
	cd $(HOST_LIBICONV_DIR) && \
		$(HOST_LIBICONV_PATH) $(HOST_LIBICONV_ENV) \
		./configure $(HOST_LIBICONV_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libiconv.compile:
	@$(call targetinfo)
	cd $(HOST_LIBICONV_DIR) && $(HOST_LIBICONV_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-libiconv.install:
	@$(call targetinfo)
	@$(call install, HOST_LIBICONV,,h)
	@$(call touch)

# vim: syntax=make
