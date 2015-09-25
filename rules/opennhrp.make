# -*-makefile-*-
#
# Copyright (C) 2014 Dr. Neuhaus Telekommunikation GmbH, Hamburg Germany, Oliver Graute <oliver.graute@neuhaus.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENNHRP) += opennhrp

#
# Paths and names
#
OPENNHRP_VERSION	:= 0.14.1
OPENNHRP_MD5		:= eb42ddb13e07ceb415b9ebb8eaca28ee
OPENNHRP		:= opennhrp-$(OPENNHRP_VERSION)
OPENNHRP_SUFFIX		:= tar.bz2
OPENNHRP_URL		:= $(call ptx/mirror, SF, opennhrp/$(OPENNHRP).$(OPENNHRP_SUFFIX))
OPENNHRP_SOURCE		:= $(SRCDIR)/$(OPENNHRP).$(OPENNHRP_SUFFIX)
OPENNHRP_DIR		:= $(BUILDDIR)/$(OPENNHRP)
OPENNHRP_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENNHRP_CONF_TOOL	:=  NO
OPENNHRP_MAKE_OPT	:= \
	$(CROSS_ENV_CC) \
	PREFIX=/usr

OPENNHRP_INSTALL_OPT := \
	$(OPENNHRP_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/opennhrp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, opennhrp)
	@$(call install_fixup, opennhrp,PRIORITY,optional)
	@$(call install_fixup, opennhrp,SECTION,base)
	@$(call install_fixup, opennhrp,AUTHOR,"<oliver.graute@neuhaus.de>")
	@$(call install_fixup, opennhrp,DESCRIPTION,missing)

	@$(call install_copy, opennhrp, 0, 0, 0755, -, /usr/sbin/opennhrp)
	@$(call install_copy, opennhrp, 0, 0, 0755, -, /usr/sbin/opennhrpctl)
	@$(call install_alternative, opennhrp, 0, 0, 0644, /etc/opennhrp/opennhrp.conf)
	@$(call install_alternative, opennhrp, 0, 0, 0755, /etc/opennhrp/racoon-ph1dead.sh)
	@$(call install_alternative, opennhrp, 0, 0, 0755, /etc/opennhrp/racoon-ph1down.sh)

	@$(call install_finish, opennhrp)

	@$(call touch)

# vim: syntax=make
