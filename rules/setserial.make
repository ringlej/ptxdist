# -*-makefile-*-
#
# Copyright (C) 2005 by BSP
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SETSERIAL) += setserial

#
# Paths and names
#
SETSERIAL_VERSION	:= 2.17
SETSERIAL_MD5		:= c4867d72c41564318e0107745eb7a0f2
SETSERIAL		:= setserial-$(SETSERIAL_VERSION)
SETSERIAL_SUFFIX	:= tar.gz
SETSERIAL_URL		:= $(call ptx/mirror, SF, setserial/$(SETSERIAL).$(SETSERIAL_SUFFIX))
SETSERIAL_SOURCE	:= $(SRCDIR)/$(SETSERIAL).$(SETSERIAL_SUFFIX)
SETSERIAL_DIR		:= $(BUILDDIR)/$(SETSERIAL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SETSERIAL_CONF_TOOL	:= autoconf
SETSERIAL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR)

SETSERIAL_MAKE_OPT	:= setserial

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/setserial.targetinstall:
	@$(call targetinfo)

	@$(call install_init, setserial)
	@$(call install_fixup, setserial,PRIORITY,optional)
	@$(call install_fixup, setserial,SECTION,base)
	@$(call install_fixup, setserial,AUTHOR,"Benedikt Spranger <b.spranger@linutronix.de>")
	@$(call install_fixup, setserial,DESCRIPTION,missing)

	@$(call install_copy, setserial, 0, 0, 0755, -, /bin/setserial)

	@$(call install_finish, setserial)

	@$(call touch)

# vim: syntax=make
