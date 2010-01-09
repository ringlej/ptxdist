# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPKG) += opkg

#
# Paths and names
#
OPKG_VERSION	:= r180
OPKG		:= opkg-$(OPKG_VERSION)
OPKG_SUFFIX	:= tar.gz
#                  http://code.google.com/p/opkg/
OPKG_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(OPKG).$(OPKG_SUFFIX)
OPKG_SOURCE	:= $(SRCDIR)/$(OPKG).$(OPKG_SUFFIX)
OPKG_DIR	:= $(BUILDDIR)/$(OPKG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(OPKG_SOURCE):
	@$(call targetinfo)
	@$(call get, OPKG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPKG_PATH	:= PATH=$(CROSS_PATH)
OPKG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
OPKG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gpg

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/opkg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, opkg)
	@$(call install_fixup, opkg,PACKAGE,opkg)
	@$(call install_fixup, opkg,PRIORITY,optional)
	@$(call install_fixup, opkg,VERSION,$(OPKG_VERSION))
	@$(call install_fixup, opkg,SECTION,base)
	@$(call install_fixup, opkg,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, opkg,DEPENDS,)
	@$(call install_fixup, opkg,DESCRIPTION,missing)

#	# makes only sense when we --enable-gpg
#	# @$(call install_copy, opkg, 0, 0, 0755, -, /usr/bin/opkg-key)
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/bin/update-alternatives)
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/bin/opkg-cl)
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/share/opkg/intercept/ldconfig)
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/share/opkg/intercept/depmod)
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/share/opkg/intercept/update-modules)
	@$(call install_copy, opkg, 0, 0, 0644, -, /usr/lib/libopkg.so.0.0.0)
	@$(call install_link, opkg, libopkg.so.0.0.0, /usr/lib/libopkg.so.0)
	@$(call install_link, opkg, libopkg.so.0.0.0, /usr/lib/libopkg.so)

#	# opkg tries to write to the OPKG_STATE_DIR_PREFIX, which is /usr/lib/opkg
	@$(call install_link, opkg, ../../tmp, /usr/lib/opkg)

	@$(call install_finish, opkg)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

opkg_clean:
	rm -rf $(STATEDIR)/opkg.*
	rm -rf $(PKGDIR)/opkg_*
	rm -rf $(OPKG_DIR)

# vim: syntax=make
