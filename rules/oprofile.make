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
OPROFILE_VERSION	:= 1.2.0
OPROFILE_MD5		:= 4fcd3920984dcb607314b2e225086c3a
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
	$(call ptx/ifdef, PTXCONF_KERNEL_HEADER,--with-kernel=$(KERNEL_HEADERS_DIR)) \
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

	@$(call install_lib, oprofile, 0, 0, 0644, oprofile/libopagent)

	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/ocount)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/op-check-perfevents)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/opannotate)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/oparchive)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/operf)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/opgprof)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/ophelp)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/opimport)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/opjitconv)
	@$(call install_copy, oprofile, 0, 0, 0755, -, /usr/bin/opreport)

	@$(call install_tree, oprofile, 0, 0, -, /usr/share/oprofile)

	@$(call install_finish, oprofile)

	@$(call touch)

# vim: syntax=make
