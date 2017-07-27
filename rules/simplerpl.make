# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SIMPLERPL) += simplerpl

#
# Paths and names
#
SIMPLERPL_VERSION	:= 1.0
SIMPLERPL_MD5		:= 8544a9f7414e98cd2d17ff15332c8eee
SIMPLERPL		:= simplerpl-$(SIMPLERPL_VERSION)
SIMPLERPL_SUFFIX	:= tar.gz
SIMPLERPL_URL		:= http://cakelab.org/~eintopf/RPL/$(SIMPLERPL).$(SIMPLERPL_SUFFIX)
SIMPLERPL_SOURCE	:= $(SRCDIR)/$(SIMPLERPL).$(SIMPLERPL_SUFFIX)
SIMPLERPL_DIR		:= $(BUILDDIR)/$(SIMPLERPL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SIMPLERPL_CONF_TOOL	:= python
SIMPLERPL_MAKE_OPT	= build -e "/usr/bin/python$(PYTHON_MAJORMINOR)"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/simplerpl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, simplerpl)
	@$(call install_fixup, simplerpl,PRIORITY,optional)
	@$(call install_fixup, simplerpl,SECTION,base)
	@$(call install_fixup, simplerpl,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, simplerpl,DESCRIPTION,missing)

	@for file in $(shell cd $(SIMPLERPL_PKGDIR) && find . -name "*.pyc"); \
		do \
		$(call install_copy, simplerpl, 0, 0, 0644, -, /$$file); \
	done

	@$(call install_copy, simplerpl, 0, 0, 0755, -, /usr/bin/cliRPL.py)
	@$(call install_copy, simplerpl, 0, 0, 0755, -, /usr/bin/simpleRPL.py)

	@$(call install_finish, simplerpl)

	@$(call touch)

# vim: syntax=make
