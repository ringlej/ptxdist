# -*-makefile-*-
# $Id: template-make 8509 2008-06-12 12:45:40Z mkl $
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
	@$(call install_fixup, libid3tag,PACKAGE,libid3tag)
	@$(call install_fixup, libid3tag,PRIORITY,optional)
	@$(call install_fixup, libid3tag,VERSION,$(LIBID3TAG_VERSION))
	@$(call install_fixup, libid3tag,SECTION,base)
	@$(call install_fixup, libid3tag,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libid3tag,DEPENDS,)
	@$(call install_fixup, libid3tag,DESCRIPTION,missing)

	@$(call install_copy, libid3tag, 0, 0, 0644, -, \
		/usr/lib/libid3tag.so.0.3.0)
	@$(call install_link, libid3tag, libid3tag.so.0.3.0, /usr/lib/libid3tag.so.0)
	@$(call install_link, libid3tag, libid3tag.so.0.3.0, /usr/lib/libid3tag.so)

	@$(call install_finish, libid3tag)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libid3tag_clean:
	rm -rf $(STATEDIR)/libid3tag.*
	rm -rf $(PKGDIR)/libid3tag_*
	rm -rf $(LIBID3TAG_DIR)

# vim: syntax=make
