# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#               2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#               2003-2009 by Pengutronix e.K., Hildesheim, Germany
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPROFILE) += oprofile

#
# Paths and names
#
OPROFILE_VERSION	:= 0.9.9
OPROFILE_MD5		:= 00aec1287da2dfffda17a9b1c0a01868
OPROFILE		:= oprofile-$(OPROFILE_VERSION)
OPROFILE_SUFFIX		:= tar.gz
OPROFILE_URL		:= $(call ptx/mirror, SF, oprofile/$(OPROFILE).$(OPROFILE_SUFFIX))
OPROFILE_SOURCE		:= $(SRCDIR)/$(OPROFILE).$(OPROFILE_SUFFIX)
OPROFILE_DIR		:= $(BUILDDIR)/$(OPROFILE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPROFILE_CONF_TOOL	:= autoconf
OPROFILE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-gui \
	--with-kernel=$(KERNEL_HEADERS_DIR) \
	--without-java \
	--without-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/oprofile.targetinstall:
	@$(call targetinfo)

	@$(call install_init, oprofile)
	@$(call install_fixup, oprofile,PRIORITY,optional)
	@$(call install_fixup, oprofile,SECTION,base)
	@$(call install_fixup, oprofile,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, oprofile,DESCRIPTION,missing)

	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/opcontrol)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/ophelp)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/opreport)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/oprofiled)

	@$(call install_tree, oprofile, 0, 0, -, /usr/share/oprofile)

	@$(call install_finish, oprofile)

	@$(call touch)

# vim: syntax=make
