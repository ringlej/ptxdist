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
PACKAGES-$(PTXCONF_PYTHON3_HBMQTT) += python3-hbmqtt

#
# Paths and names
#
PYTHON3_HBMQTT_VERSION	:= 0.9
PYTHON3_HBMQTT_MD5	:= 6789d964c0e3573ca70d20a0e2ff191e
PYTHON3_HBMQTT		:= python3-hbmqtt-$(PYTHON3_HBMQTT_VERSION)
PYTHON3_HBMQTT_SUFFIX	:= tar.gz
PYTHON3_HBMQTT_URL	:= https://github.com/beerfactory/hbmqtt/archive/$(PYTHON3_HBMQTT_VERSION).$(PYTHON3_HBMQTT_SUFFIX)
PYTHON3_HBMQTT_SOURCE	:= $(SRCDIR)/$(PYTHON3_HBMQTT).$(PYTHON3_HBMQTT_SUFFIX)
PYTHON3_HBMQTT_DIR	:= $(BUILDDIR)/$(PYTHON3_HBMQTT)
PYTHON3_HBMQTT_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_HBMQTT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-hbmqtt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-hbmqtt)
	@$(call install_fixup, python3-hbmqtt, PRIORITY, optional)
	@$(call install_fixup, python3-hbmqtt, SECTION, base)
	@$(call install_fixup, python3-hbmqtt, AUTHOR, "David Jander <david@protonic.nl>")
	@$(call install_fixup, python3-hbmqtt, DESCRIPTION, missing)

	@$(call install_glob, python3-hbmqtt, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/hbmqtt,, *.py)

	@$(call install_finish, python3-hbmqtt)

	@$(call touch)

# vim: syntax=make
