# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EVTEST) += evtest

#
# Paths and names
#
EVTEST_VERSION	:= 1.33
EVTEST_MD5	:= 19c74f94ffde781bab9ecd60e4e2f986
EVTEST		:= evtest-$(EVTEST_VERSION)
EVTEST_SUFFIX	:= tar.xz
EVTEST_URL	:= http://anongit.freedesktop.org/git/evtest.git;tag=evtest-$(EVTEST_VERSION)
EVTEST_SOURCE	:= $(SRCDIR)/$(EVTEST).$(EVTEST_SUFFIX)
EVTEST_DIR	:= $(BUILDDIR)/$(EVTEST)
EVTEST_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EVTEST_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_XSLTPROC= \
	ac_cv_path_XMLTO= \
	ac_cv_path_ASCIIDOC=

#
# autoconf
#
EVTEST_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/evtest.targetinstall:
	@$(call targetinfo)

	@$(call install_init, evtest)
	@$(call install_fixup, evtest,PRIORITY,optional)
	@$(call install_fixup, evtest,SECTION,base)
	@$(call install_fixup, evtest,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, evtest,DESCRIPTION,missing)

	@$(call install_copy, evtest, 0, 0, 0755, -, /usr/bin/evtest)

	@$(call install_finish, evtest)

	@$(call touch)

# vim: syntax=make
