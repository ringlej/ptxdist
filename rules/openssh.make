# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENSSH) += openssh

#
# Paths and names
#
OPENSSH_VERSION		= 4.3p2
OPENSSH			= openssh-$(OPENSSH_VERSION)
OPENSSH_URL 		= ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/$(OPENSSH).tar.gz
OPENSSH_SOURCE		= $(SRCDIR)/$(OPENSSH).tar.gz
OPENSSH_DIR 		= $(BUILDDIR)/$(OPENSSH)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(OPENSSH_SOURCE):
	@$(call targetinfo)
	@$(call get, OPENSSH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENSSH_PATH	:= PATH=$(CROSS_PATH)

# openssh won't compile without LD=gcc in environment
OPENSSH_ENV	:= \
	$(CROSS_ENV) \
	LD=$(COMPILER_PREFIX)gcc

#
# autoconf
#
OPENSSH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--libexecdir=/usr/sbin \
	--sysconfdir=/etc/ssh \
	--with-privsep-path=/var/run/sshd \
	--with-rand-helper=no \
	--without-pam \
	--with-ipv4-default \
	--disable-etc-default-login \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------


$(STATEDIR)/openssh.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openssh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openssh)
	@$(call install_fixup, openssh,PACKAGE,openssh)
	@$(call install_fixup, openssh,PRIORITY,optional)
	@$(call install_fixup, openssh,VERSION,$(OPENSSH_VERSION))
	@$(call install_fixup, openssh,SECTION,base)
	@$(call install_fixup, openssh,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, openssh,DEPENDS,)
	@$(call install_fixup, openssh,DESCRIPTION,missing)

ifdef PTXCONF_OPENSSH_SSH
	@$(call install_alternative, openssh, 0, 0, 0644, /etc/ssh/ssh_config)
	@$(call install_copy, openssh, 0, 0, 0755, $(OPENSSH_DIR)/ssh, /usr/bin/ssh)
endif

ifdef PTXCONF_OPENSSH_SSHD
	@$(call install_copy, openssh, 0, 0, 0644, $(OPENSSH_DIR)/moduli.out, \
		/etc/ssh/moduli, n)
	@$(call install_alternative, openssh, 0, 0, 0644, /etc/ssh/sshd_config)
	@$(call install_copy, openssh, 0, 0, 0755, $(OPENSSH_DIR)/sshd, \
		/usr/sbin/sshd)
endif

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_OPENSSH_SSHD_STARTSCRIPT
	@$(call install_alternative, openssh, 0, 0, 0755, /etc/init.d/openssh, n)
endif
endif

ifdef PTXCONF_OPENSSH_SCP
	@$(call install_copy, openssh, 0, 0, 0755, $(OPENSSH_DIR)/scp, \
		/usr/bin/scp)
endif

ifdef PTXCONF_OPENSSH_SFTP_SERVER
	@$(call install_copy, openssh, 0, 0, 0755, $(OPENSSH_DIR)/sftp-server, \
		/usr/sbin/sftp-server)
endif

ifdef PTXCONF_OPENSSH_KEYGEN
	@$(call install_copy, openssh, 0, 0, 0755, $(OPENSSH_DIR)/ssh-keygen, \
		/usr/bin/ssh-keygen)
endif

	@$(call install_finish, openssh)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssh_clean:
	rm -rf $(STATEDIR)/openssh.*
	rm -rf $(PKGDIR)/openssh_*
	rm -rf $(OPENSSH_DIR)

# vim: syntax=make
