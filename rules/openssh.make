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
OPENSSH_VERSION	:= 7.3p1
OPENSSH_MD5	:= dfadd9f035d38ce5d58a3bf130b86d08
OPENSSH		:= openssh-$(OPENSSH_VERSION)
OPENSSH_SUFFIX	:= tar.gz
OPENSSH_URL	:= \
	http://openbsd.cs.fau.de/pub/OpenBSD/OpenSSH/portable/$(OPENSSH).$(OPENSSH_SUFFIX) \
	http://ftp.halifax.rwth-aachen.de/openbsd/OpenSSH/portable/$(OPENSSH).$(OPENSSH_SUFFIX)
OPENSSH_SOURCE	:= $(SRCDIR)/$(OPENSSH).$(OPENSSH_SUFFIX)
OPENSSH_DIR	:= $(BUILDDIR)/$(OPENSSH)
OPENSSH_LICENSE	:= BSD, 2-term BSD, 3-term BSD, MIT, THE BEER-WARE LICENSE
OPENSSH_LICENSE_FILES := file://LICENCE;md5=e326045657e842541d3f35aada442507

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENSSH_CONF_ENV	:= \
	$(CROSS_ENV) \
	LD=$(COMPILER_PREFIX)gcc

#
# autoconf
#
OPENSSH_CONF_TOOL	:= autoconf
OPENSSH_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--libexecdir=/usr/sbin \
	--sysconfdir=/etc/ssh \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-strip \
	--disable-etc-default-login \
	--disable-lastlog \
	--disable-utmp \
	--disable-utmpx \
	--disable-wtmp \
	--disable-wtmpx \
	--enable-libutil \
	--disable-pututline \
	--disable-pututxline \
	--with-openssl \
	--with-stackprotect \
	--with-hardening \
	--without-rpath \
	--with-zlib=$(SYSROOT) \
	--without-skey \
	--without-ldns \
	--without-libedit \
	--without-audit \
	--with-pie \
	--without-ssl-engine \
	--without-pam \
	--$(call ptx/wwo, PTXCONF_GLOBAL_SELINUX)-selinux \
	--with-privsep-path=/var/run/sshd

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
