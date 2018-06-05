# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_COMGT) += comgt

#
# Paths and names
#
COMGT_VERSION	:= 0.32
COMGT_MD5	:= db2452680c3d953631299e331daf49ef
COMGT		:= comgt.$(COMGT_VERSION)
COMGT_SUFFIX	:= tgz
COMGT_URL	:= $(call ptx/mirror, SF, comgt/$(COMGT).$(COMGT_SUFFIX))
COMGT_SOURCE	:= $(SRCDIR)/$(COMGT).$(COMGT_SUFFIX)
COMGT_DIR	:= $(BUILDDIR)/$(COMGT)
COMGT_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

COMGT_CONF_TOOL	:= NO
COMGT_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/comgt.install:
	@$(call targetinfo)
	@install -D -m0755 $(COMGT_DIR)/comgt $(COMGT_PKGDIR)/usr/sbin/comgt
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/comgt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, comgt)
	@$(call install_fixup, comgt,PRIORITY,optional)
	@$(call install_fixup, comgt,SECTION,base)
	@$(call install_fixup, comgt,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, comgt,DESCRIPTION,missing)

	@$(call install_copy, comgt, 0, 0, 0755, -, /usr/sbin/comgt)

	@$(call install_finish, comgt)

	@$(call touch)

# vim: syntax=make
