# -*-makefile-*-
#
# Copyright (C) 2004 by Benedikt Spranger
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
PACKAGES-$(PTXCONF_JED) += jed

#
# Paths and names
#
JED_VERSION	:= 0.99-19
JED		:= jed-$(JED_VERSION)
JED_SUFFIX	:= tar.bz2
JED_URL		:= ftp://space.mit.edu/pub/davis/jed/v0.99/old/$(JED).$(JED_SUFFIX) \
		   ftp://space.mit.edu/pub/davis/jed/v0.99/$(JED).$(JED_SUFFIX)
JED_SOURCE	:= $(SRCDIR)/$(JED).$(JED_SUFFIX)
JED_DIR		:= $(BUILDDIR)/$(JED)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(JED_SOURCE):
	@$(call targetinfo)
	@$(call get, JED)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JED_PATH	:= PATH=$(CROSS_PATH)
JED_ENV 	:= \
	$(CROSS_ENV) \
	JED_ROOT=/usr/share/jed

#
# autoconf
#
JED_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-slang=$(SYSROOT)/usr \
	--without-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jed.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  jed)
	@$(call install_fixup, jed,PRIORITY,optional)
	@$(call install_fixup, jed,SECTION,base)
	@$(call install_fixup, jed,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, jed,DESCRIPTION,missing)

	@$(call install_copy, jed, 0, 0, 0755, -, \
		/usr/bin/jed)

	@$(call install_finish, jed)

	@$(call touch)

# vim: syntax=make
