# -*-makefile-*-
#
# Copyright (C) 2014 by Jon Ringle <jringle@gridpoint.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AUTOSSH) += autossh

#
# Paths and names
#
AUTOSSH_VERSION	:= 1.4c
AUTOSSH_MD5	:= 26520eea934f296be0783dabe7fcfd28
AUTOSSH		:= autossh-$(AUTOSSH_VERSION)
AUTOSSH_SUFFIX	:= tgz
AUTOSSH_URL	:= http://www.harding.motd.ca/autossh/$(AUTOSSH).$(AUTOSSH_SUFFIX)
AUTOSSH_SOURCE	:= $(SRCDIR)/$(AUTOSSH).$(AUTOSSH_SUFFIX)
AUTOSSH_DIR	:= $(BUILDDIR)/$(AUTOSSH)
AUTOSSH_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use ac_cv_path_ssh= because --with-ssh= is broken
AUTOSSH_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_path_ssh=/usr/bin/ssh

AUTOSSH_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/autossh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, autossh)
	@$(call install_fixup, autossh,PRIORITY,optional)
	@$(call install_fixup, autossh,SECTION,base)
	@$(call install_fixup, autossh,AUTHOR,"Jon Ringle <jringle@gridpoint.com>")
	@$(call install_fixup, autossh,DESCRIPTION,missing)

	@$(call install_copy, autossh, 0, 0, 0755, -, /usr/bin/autossh)

	@$(call install_finish, autossh)

	@$(call touch)

# vim: syntax=make
