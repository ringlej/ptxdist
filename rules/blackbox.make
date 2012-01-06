# -*-makefile-*-
#
# Copyright (C) 2003 by Marco Cavallini <m.cavallini@koansoftware.com>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BLACKBOX) += blackbox

#
# Paths and names
#
BLACKBOX_VERSION	:= 0.70.1
BLACKBOX_MD5		:=
BLACKBOX		:= blackbox-$(BLACKBOX_VERSION)
BLACKBOX_SUFFIX		:= tar.gz
BLACKBOX_URL		:= $(call ptx/mirror, SF, blackboxwm/$(BLACKBOX).$(BLACKBOX_SUFFIX))
BLACKBOX_SOURCE		:= $(SRCDIR)/$(BLACKBOX).$(BLACKBOX_SUFFIX)
BLACKBOX_DIR		:= $(BUILDDIR)/$(BLACKBOX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BLACKBOX_SOURCE):
	@$(call targetinfo)
	@$(call get, BLACKBOX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BLACKBOX_PATH	:= PATH=$(CROSS_PATH)
BLACKBOX_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BLACKBOX_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
BLACKBOX_AUTOCONF	+= --x-includes=$(SYSROOT)/usr/include
BLACKBOX_AUTOCONF	+= --x-libraries=$(SYSROOT)/usr/lib

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/blackbox.compile:
	@$(call targetinfo)
	cd $(BLACKBOX_DIR) && \
		$(BLACKBOX_PATH) $(BLACKBOX_ENV) \
		make $(BLACKBOX_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/blackbox.targetinstall:
	@$(call targetinfo)

	@$(call install_init, blackbox)
	@$(call install_fixup, blackbox,PRIORITY,optional)
	@$(call install_fixup, blackbox,SECTION,base)
	@$(call install_fixup, blackbox,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, blackbox,DESCRIPTION,missing)

	@$(call install_copy, blackbox, 0, 0, 0755, $(BLACKBOX_DIR)/src/blackbox, /usr/X11R6/bin/blackbox)
	@$(call install_copy, blackbox, 0, 0, 0755, $(BLACKBOX_DIR)/util/bsetroot, /usr/X11R6/bin/bsetroot)

	@$(call install_finish, blackbox)

	@$(call touch)

# vim: syntax=make
