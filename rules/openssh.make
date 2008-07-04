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

openssh_get: $(STATEDIR)/openssh.get

$(STATEDIR)/openssh.get: $(openssh_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OPENSSH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, OPENSSH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openssh_extract: $(STATEDIR)/openssh.extract

$(STATEDIR)/openssh.extract: $(openssh_extract_deps_default)
	@$(call targetinfo, openssh.extract)
	@$(call clean, $(OPENSSH_DIR))
	@$(call extract, OPENSSH)
	@$(call patchin, OPENSSH)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openssh_prepare: $(STATEDIR)/openssh.prepare

OPENSSH_PATH	= PATH=$(CROSS_PATH)

# openssh is a little F*CKED up, is won't compile without LD=gcc in environment
# perhaps someone should fix this....
OPENSSH_ENV	= $(CROSS_ENV) \
	LD=$(COMPILER_PREFIX)gcc

#
# autoconf
#
OPENSSH_AUTOCONF = \
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

$(STATEDIR)/openssh.prepare: $(openssh_prepare_deps_default)
	@$(call targetinfo, openssh.prepare)
	cd $(OPENSSH_DIR) && \
		$(OPENSSH_PATH) $(OPENSSH_ENV) \
		./configure $(OPENSSH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openssh_compile: $(STATEDIR)/openssh.compile

$(STATEDIR)/openssh.compile: $(openssh_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(OPENSSH_DIR) && $(OPENSSH_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openssh_install: $(STATEDIR)/openssh.install

$(STATEDIR)/openssh.install: $(openssh_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openssh_targetinstall: $(STATEDIR)/openssh.targetinstall

$(STATEDIR)/openssh.targetinstall: $(openssh_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, openssh)
	@$(call install_fixup, openssh,PACKAGE,openssh)
	@$(call install_fixup, openssh,PRIORITY,optional)
	@$(call install_fixup, openssh,VERSION,$(OPENSSH_VERSION))
	@$(call install_fixup, openssh,SECTION,base)
	@$(call install_fixup, openssh,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
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

ifdef PTXCONF_ROOTFS_ETC_INITD_OPENSSH_DEFAULT
# install the generic one
	@$(call install_copy, openssh, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/openssh, \
		/etc/init.d/openssh, n)
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_OPENSSH_USER
# install users one
	@$(call install_copy, openssh, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/openssh, \
		/etc/init.d/openssh, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_OPENSSH_LINK),"")
	@$(call install_link, openssh, ../init.d/openssh, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_OPENSSH_LINK))
endif

	@$(call install_finish, openssh)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openssh_clean:
	rm -rf $(STATEDIR)/openssh.*
	rm -rf $(PKGDIR)/openssh_*
	rm -rf $(OPENSSH_DIR)

# vim: syntax=make
