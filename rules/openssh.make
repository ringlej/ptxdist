# -*-makefile-*-
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
OPENSSH_VERSION	:= 5.8p2
OPENSSH_MD5	:= 0541579adf9d55abb15ef927048d372e
OPENSSH		:= openssh-$(OPENSSH_VERSION)
OPENSSH_SUFFIX	:= tar.gz
OPENSSH_URL	:= http://openssh.linux-mirror.org/portable/$(OPENSSH).$(OPENSSH_SUFFIX)
OPENSSH_SOURCE	:= $(SRCDIR)/$(OPENSSH).$(OPENSSH_SUFFIX)
OPENSSH_DIR	:= $(BUILDDIR)/$(OPENSSH)
OPENSSH_LICENSE	:= BSD

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
OPENSSH_ENV 	:= \
	$(CROSS_ENV) \
	LD=$(COMPILER_PREFIX)gcc

#
# autoconf
#
OPENSSH_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-zlib=$(SYSROOT) \
	--libexecdir=/usr/sbin \
	--sysconfdir=/etc/ssh \
	--with-privsep-path=/var/run/sshd \
	--with-rand-helper=no \
	--without-pam \
	--disable-etc-default-login \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--disable-pututline \
	--disable-pututxline

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openssh.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  openssh)
	@$(call install_fixup, openssh,PRIORITY,optional)
	@$(call install_fixup, openssh,SECTION,base)
	@$(call install_fixup, openssh,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, openssh,DESCRIPTION,missing)

ifdef PTXCONF_OPENSSH_SSH
	@$(call install_alternative, openssh, 0, 0, 0644, /etc/ssh/ssh_config)
	@$(call install_copy, openssh, 0, 0, 0755, -, \
		/usr/bin/ssh)
endif

ifdef PTXCONF_OPENSSH_SSHD
	@$(call install_alternative, openssh, 0, 0, 0644, /etc/ssh/sshd_config)
	@$(call install_copy, openssh, 0, 0, 0644, -, \
		/etc/ssh/moduli)
	@$(call install_copy, openssh, 0, 0, 0755, -, \
		/usr/sbin/sshd)
	@$(call install_alternative, openssh, 0, 0, 0755, /etc/rc.once.d/openssh)
endif

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_OPENSSH_SSHD_STARTSCRIPT
	@$(call install_alternative, openssh, 0, 0, 0755, /etc/init.d/openssh)

ifneq ($(call remove_quotes,$(PTXCONF_OPENSSH_BBINIT_LINK)),)
	@$(call install_link, openssh, \
		../init.d/openssh, \
		/etc/rc.d/$(PTXCONF_OPENSSH_BBINIT_LINK))
endif
endif
endif
ifdef PTXCONF_INITMETHOD_SYSTEMD
ifdef PTXCONF_OPENSSH_SSHD_SYSTEMD_UNIT
	@$(call install_alternative, openssh, 0, 0, 0644, \
		/lib/systemd/system/sshd.socket)
	@$(call install_alternative, openssh, 0, 0, 0644, \
		/lib/systemd/system/sshd@.service)
	@$(call install_link, openssh, ../sshd.socket, \
		/lib/systemd/system/sockets.target.wants/sshd.socket)
	@$(call install_alternative, openssh, 0, 0, 0644, \
		/usr/lib/tmpfiles.d/ssh.conf)
endif
endif

ifdef PTXCONF_INITMETHOD_UPSTART
	@$(call install_alternative, openssh, 0, 0, 0644, /etc/init/ssh.conf)
endif

ifdef PTXCONF_OPENSSH_SCP
	@$(call install_copy, openssh, 0, 0, 0755, -, \
		/usr/bin/scp)
endif

ifdef PTXCONF_OPENSSH_SFTP
	@$(call install_copy, openssh, 0, 0, 0755, -, \
		/usr/bin/sftp)
endif

ifdef PTXCONF_OPENSSH_SFTP_SERVER
	@$(call install_copy, openssh, 0, 0, 0755, -, \
		/usr/sbin/sftp-server)
endif

ifdef PTXCONF_OPENSSH_KEYGEN
	@$(call install_copy, openssh, 0, 0, 0755, -, \
		/usr/bin/ssh-keygen)
endif

	@$(call install_finish, openssh)

	@$(call touch)

# vim: syntax=make
