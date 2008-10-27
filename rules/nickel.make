# -*-makefile-*-
# $Id: template-make 8785 2008-08-26 07:48:06Z wsa $
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
PACKAGES-$(PTXCONF_NICKEL) += nickel

#
# Paths and names
#
NICKEL_VERSION	:= 1.1.0
NICKEL		:= nickel-$(NICKEL_VERSION)
NICKEL_SUFFIX	:= tar.gz
NICKEL_URL	:= http://downloads.sourceforge.net/chaoslizard/$(NICKEL).$(NICKEL_SUFFIX)
NICKEL_SOURCE	:= $(SRCDIR)/$(NICKEL).$(NICKEL_SUFFIX)
NICKEL_DIR	:= $(BUILDDIR)/$(NICKEL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(NICKEL_SOURCE):
	@$(call targetinfo)
	@$(call get, NICKEL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/nickel.extract:
	@$(call targetinfo)
	@$(call clean, $(NICKEL_DIR))
	@$(call extract, NICKEL)
	@$(call patchin, NICKEL)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NICKEL_PATH	:= PATH=$(CROSS_PATH)
NICKEL_ENV 	:= $(CROSS_ENV)

##
## autoconf
##
#NICKEL_AUTOCONF := $(CROSS_AUTOCONF_USR)
#
$(STATEDIR)/nickel.prepare:
#	@$(call targetinfo)
#	@$(call clean, $(NICKEL_DIR)/config.cache)
#	cd $(NICKEL_DIR) && \
#		$(NICKEL_PATH) $(NICKEL_ENV) \
#		./configure $(NICKEL_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/nickel.compile:
	@$(call targetinfo)
	cd $(NICKEL_DIR)/src && $(NICKEL_PATH) $(MAKE) \
		CC=$(CROSS_CC) LD=$(CROSS_LD) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nickel.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nickel.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nickel)
	@$(call install_fixup, nickel,PACKAGE,nickel)
	@$(call install_fixup, nickel,PRIORITY,optional)
	@$(call install_fixup, nickel,VERSION,$(NICKEL_VERSION))
	@$(call install_fixup, nickel,SECTION,base)
	@$(call install_fixup, nickel,AUTHOR,"Robert Schwebel <your@email.please>")
	@$(call install_fixup, nickel,DEPENDS,)
	@$(call install_fixup, nickel,DESCRIPTION,missing)

	@$(call install_copy, nickel, 0, 0, 0644, \
		$(NICKEL_DIR)/src/libnickel.so.1.1.0, \
		/usr/lib/libnickel.so.1.1.0)
	@$(call install_link, nickel,  \
		libnickel.so.1.1.0, \
		/usr/lib/libnickel.so.1)
	@$(call install_link, nickel,  \
		libnickel.so.1.1.0, \
		/usr/lib/libnickel.so)

	@$(call install_finish, nickel)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

nickel_clean:
	rm -rf $(STATEDIR)/nickel.*
	rm -rf $(PKGDIR)/nickel_*
	rm -rf $(NICKEL_DIR)

# vim: syntax=make
