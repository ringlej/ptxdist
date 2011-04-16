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
EVTEST_VERSION	:= 1.25
EVTEST		:= evtest-$(EVTEST_VERSION)
EVTEST_SUFFIX	:= tar.bz2
EVTEST_URL	:= http://cgit.freedesktop.org/~whot/evtest/snapshot/$(EVTEST).$(EVTEST_SUFFIX)
EVTEST_SOURCE	:= $(SRCDIR)/$(EVTEST).$(EVTEST_SUFFIX)
EVTEST_DIR	:= $(BUILDDIR)/$(EVTEST)
EVTEST_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(EVTEST_SOURCE):
	@$(call targetinfo)
	@$(call get, EVTEST)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

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

ifdef PTXCONF_EVTEST_EVTEST
	@$(call install_copy, evtest, 0, 0, 0755, -, /usr/bin/evtest)
endif

ifdef PTXCONF_EVTEST_CAPTURE
	@$(call install_copy, evtest, 0, 0, 0755, -, /usr/bin/evtest-capture)
	@$(call install_copy, evtest, 0, 0, 0755, -, \
		/usr/share/evtest/evtest-create-device.xsl)
endif

	@$(call install_finish, evtest)

	@$(call touch)

# vim: syntax=make
