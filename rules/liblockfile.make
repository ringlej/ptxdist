# -*-makefile-*-
#
# Copyright (C) 2006 by Bjoern Buerger
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBLOCKFILE) += liblockfile

#
# Paths and names
#
LIBLOCKFILE_VERSION	:= 1.08
LIBLOCKFILE_MD5		:= c24e2dfb4a2aab0263fe5ac1564d305e
LIBLOCKFILE_SUFFIX	:= tar.gz
LIBLOCKFILE		:= liblockfile-$(LIBLOCKFILE_VERSION)
LIBLOCKFILE_TARBALL	:= liblockfile_$(LIBLOCKFILE_VERSION).orig.$(LIBLOCKFILE_SUFFIX)
LIBLOCKFILE_URL		:= $(call ptx/mirror, DEB, pool/main/libl/liblockfile/$(LIBLOCKFILE_TARBALL))
LIBLOCKFILE_SOURCE	:= $(SRCDIR)/$(LIBLOCKFILE_TARBALL)
LIBLOCKFILE_DIR		:= $(BUILDDIR)/liblockfile-$(LIBLOCKFILE_VERSION)
LIBLOCKFILE_LICENSE	:= GPLv2+, LGPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBLOCKFILE_PATH	:= PATH=$(CROSS_PATH)
LIBLOCKFILE_ENV 	:= $(CROSS_ENV)
LIBLOCKFILE_MAKEVARS	:= ROOT=$(PKGDIR)/$(LIBLOCKFILE) $(CROSS_ENV_AR)

#
# autoconf
#
LIBLOCKFILE_AUTOCONF	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liblockfile.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liblockfile)
	@$(call install_fixup, liblockfile,PRIORITY,optional)
	@$(call install_fixup, liblockfile,SECTION,base)
	@$(call install_fixup, liblockfile,AUTHOR,"Bjoern Buerger <b.buerger@pengutronix.de>")
	@$(call install_fixup, liblockfile,DESCRIPTION,missing)

	@$(call install_copy, liblockfile, 0, 0, 0755, -, /usr/bin/dotlockfile)

	@$(call install_finish, liblockfile)

	@$(call touch)

# vim: syntax=make
