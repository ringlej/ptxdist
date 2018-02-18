# -*-makefile-*-
#
# Copyright (C) 2017 by David Jander <david@protonic.nl>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_TRANSITIONS) += python3-transitions

#
# Paths and names
#
PYTHON3_TRANSITIONS_VERSION	:= 0.5.3
PYTHON3_TRANSITIONS_MD5		:= 256d7714bfbbdbc4efe23dc2e58afc45
PYTHON3_TRANSITIONS		:= python3-transitions-$(PYTHON3_TRANSITIONS_VERSION)
PYTHON3_TRANSITIONS_SUFFIX	:= tar.gz
PYTHON3_TRANSITIONS_URL		:= https://github.com/pytransitions/transitions/archive/$(PYTHON3_TRANSITIONS_VERSION).$(PYTHON3_TRANSITIONS_SUFFIX)
PYTHON3_TRANSITIONS_SOURCE	:= $(SRCDIR)/$(PYTHON3_TRANSITIONS).$(PYTHON3_TRANSITIONS_SUFFIX)
PYTHON3_TRANSITIONS_DIR		:= $(BUILDDIR)/$(PYTHON3_TRANSITIONS)
PYTHON3_TRANSITIONS_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_TRANSITIONS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-transitions.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-transitions)
	@$(call install_fixup, python3-transitions, PRIORITY, optional)
	@$(call install_fixup, python3-transitions, SECTION, base)
	@$(call install_fixup, python3-transitions, AUTHOR, "David Jander <david@protonic.nl>")
	@$(call install_fixup, python3-transitions, DESCRIPTION, missing)

	@$(call install_glob, python3-transitions, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/transitions,, *.py)

	@$(call install_finish, python3-transitions)

	@$(call touch)

# vim: syntax=make
