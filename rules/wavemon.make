# -*-makefile-*-
#
# Copyright (C) 2013 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WAVEMON) += wavemon

#
# Paths and names
#
WAVEMON_VERSION	:= 0.7.5
WAVEMON_MD5	:= 77d4a0f099ca98cf98a915adc70694ba
WAVEMON		:= wavemon-$(WAVEMON_VERSION)
WAVEMON_SUFFIX	:= tar.bz2
WAVEMON_URL	:= http://eden-feed.erg.abdn.ac.uk/wavemon/stable-releases/$(WAVEMON).$(WAVEMON_SUFFIX)
WAVEMON_SOURCE	:= $(SRCDIR)/$(WAVEMON).$(WAVEMON_SUFFIX)
WAVEMON_DIR	:= $(BUILDDIR)/$(WAVEMON)
WAVEMON_LICENSE	:= GPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WAVEMON_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_lib_cap_cap_get_flag=no

#
# autoconf
#
WAVEMON_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wavemon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wavemon)
	@$(call install_fixup, wavemon,PRIORITY,optional)
	@$(call install_fixup, wavemon,SECTION,base)
	@$(call install_fixup, wavemon,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, wavemon,DESCRIPTION,missing)

	@$(call install_copy, wavemon, 0, 0, 0755, -, /usr/bin/wavemon)

	@$(call install_finish, wavemon)

	@$(call touch)

# vim: syntax=make
