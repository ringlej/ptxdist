# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <walle@corscience.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SP_OOPS_EXTRACT) += sp-oops-extract

#
# Paths and names
#
SP_OOPS_EXTRACT_VERSION		:= 0.0.7
SP_OOPS_EXTRACT_MD5		:= b4e3ff7716c249e3446758582a1cae12
SP_OOPS_EXTRACT			:= sp-oops-extract-$(SP_OOPS_EXTRACT_VERSION)
SP_OOPS_EXTRACT_SUFFIX		:= tar.gz
SP_OOPS_EXTRACT_ARCHIVE		:= sp-oops-extract_$(SP_OOPS_EXTRACT_VERSION)-1.$(SP_OOPS_EXTRACT_SUFFIX)
SP_OOPS_EXTRACT_URL		:= http://repository.maemo.org/pool/fremantle/free/s/sp-oops-extract/$(SP_OOPS_EXTRACT_ARCHIVE)
SP_OOPS_EXTRACT_SOURCE		:= $(SRCDIR)/$(SP_OOPS_EXTRACT_ARCHIVE)
SP_OOPS_EXTRACT_DIR		:= $(BUILDDIR)/$(SP_OOPS_EXTRACT)
SP_OOPS_EXTRACT_LICENSE		:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SP_OOPS_EXTRACT_CONF_TOOL	:= NO
SP_OOPS_EXTRACT_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sp-oops-extract.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sp-oops-extract)
	@$(call install_fixup, sp-oops-extract,PRIORITY,optional)
	@$(call install_fixup, sp-oops-extract,SECTION,base)
	@$(call install_fixup, sp-oops-extract,AUTHOR,"Bernhard Walle <walle@corscience.de>")
	@$(call install_fixup, sp-oops-extract,DESCRIPTION,missing)

	@$(call install_copy, sp-oops-extract, 0, 0, 0755, -, \
		/usr/bin/sp-oops-extract)

	@$(call install_finish, sp-oops-extract)

	@$(call touch)

# vim: syntax=make
