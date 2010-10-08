# -*-makefile-*-
#
# Copyright (C) 2010 by Alexander Stein <alexander.stein@systec-electronic.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BOA) += boa

#
# Paths and names
#
BOA_VERSION	:= 0.94.14rc21
BOA_MD5		:= e24b570bd767a124fcfb40a34d148ba9
BOA_SUFFIX	:= tar.gz
BOA		:= boa-$(BOA_VERSION)
BOA_TARBALL	:= boa_$(BOA_VERSION).orig.$(BOA_SUFFIX)
BOA_URL		:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/b/boa/$(BOA_TARBALL)
BOA_SOURCE	:= $(SRCDIR)/$(BOA_TARBALL)
BOA_DIR		:= $(BUILDDIR)/$(BOA)
BOA_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BOA_SOURCE):
	@$(call targetinfo)
	@$(call get, BOA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BOA_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/boa.install:
	@$(call targetinfo)
	install -D -m 755 $(BOA_DIR)/src/boa $(BOA_PKGDIR)/usr/sbin/boa
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/boa.targetinstall:
	@$(call targetinfo)

	@$(call install_init, boa)
	@$(call install_fixup, boa,PRIORITY,optional)
	@$(call install_fixup, boa,SECTION,base)
	@$(call install_fixup, boa,AUTHOR,"Alexander Stein <alexander.stein@systec-electronic.com>")
	@$(call install_fixup, boa,DESCRIPTION,missing)

	@$(call install_copy, boa, 0, 0, 0755, -, /usr/sbin/boa)

	@$(call install_alternative, boa, 0, 0, 0755, /etc/init.d/boa)

ifdef PTXCONF_BOA_INSTALL_CONFIG
	@$(call install_alternative, boa, 0, 0, 0644, /etc/boa/boa.conf)
endif
	@$(call install_finish, boa)

	@$(call touch)

# vim: syntax=make
