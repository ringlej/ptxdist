# -*-makefile-*-
# $Id: template-make 8509 2008-06-12 12:45:40Z mkl $
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOGG) += libogg

#
# Paths and names
#
LIBOGG_VERSION	:= 1.1.3
LIBOGG		:= libogg-$(LIBOGG_VERSION)
LIBOGG_SUFFIX	:= tar.gz
LIBOGG_URL	:= http://downloads.xiph.org/releases/ogg/$(LIBOGG).$(LIBOGG_SUFFIX)
LIBOGG_SOURCE	:= $(SRCDIR)/$(LIBOGG).$(LIBOGG_SUFFIX)
LIBOGG_DIR	:= $(BUILDDIR)/$(LIBOGG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBOGG_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBOGG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libogg.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBOGG_DIR))
	@$(call extract, LIBOGG)
	@$(call patchin, LIBOGG)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBOGG_PATH	:= PATH=$(CROSS_PATH)
LIBOGG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBOGG_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libogg.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBOGG_DIR)/config.cache)
	cd $(LIBOGG_DIR) && \
		$(LIBOGG_PATH) $(LIBOGG_ENV) \
		./configure $(LIBOGG_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libogg.compile:
	@$(call targetinfo)
	cd $(LIBOGG_DIR) && $(LIBOGG_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libogg.install:
	@$(call targetinfo)
	@$(call install, LIBOGG)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libogg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libogg)
	@$(call install_fixup, libogg,PACKAGE,libogg)
	@$(call install_fixup, libogg,PRIORITY,optional)
	@$(call install_fixup, libogg,VERSION,$(LIBOGG_VERSION))
	@$(call install_fixup, libogg,SECTION,base)
	@$(call install_fixup, libogg,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libogg,DEPENDS,)
	@$(call install_fixup, libogg,DESCRIPTION,missing)

	@$(call install_copy, libogg, 0, 0, 0644, \
		$(LIBOGG_DIR)/src/.libs/libogg.so.0.5.3, \
		/usr/lib/libogg.so.0.5.3)
	@$(call install_link, libogg, libogg.so.0.5.3, libogg.so.0)
	@$(call install_link, libogg, libogg.so.0.5.3, libogg.so)

	@$(call install_finish, libogg)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libogg_clean:
	rm -rf $(STATEDIR)/libogg.*
	rm -rf $(PKGDIR)/libogg_*
	rm -rf $(LIBOGG_DIR)

# vim: syntax=make
