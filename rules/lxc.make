# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Grzeschik <mgr@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LXC) += lxc

#
# Paths and names
#
LXC_VERSION	:= 3.0.1
LXC_MD5		:= 8eb396dde561e5832ba2d505513a1935
LXC		:= lxc-$(LXC_VERSION)
LXC_SUFFIX	:= tar.gz
LXC_URL		:= https://linuxcontainers.org/downloads/lxc/$(LXC).$(LXC_SUFFIX)
LXC_SOURCE	:= $(SRCDIR)/$(LXC).$(LXC_SUFFIX)
LXC_DIR		:= $(BUILDDIR)/$(LXC)
LXC_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#LXC_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LXC_CONF_TOOL	:= autoconf
LXC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-silent-rules \
	--enable-dependency-tracking \
	--enable-shared \
	--disable-static \
	--disable-fast-install \
	--disable-libtool-lock \
	--disable-werror \
	--disable-rpath \
	--disable-doc \
	--disable-api-docs \
	--disable-apparmor \
	--disable-gnutls \
	--$(call ptx/endis, PTXCONF_GLOBAL_SELINUX)-selinux \
	--enable-seccomp \
	--enable-capabilities \
	--disable-examples \
	--disable-mutex-debugging \
	--disable-bash \
	--enable-tools \
	--enable-commands \
	--$(call ptx/endis, PTXCONF_LXC_TEST_TOOLS)-tests \
	--enable-configpath-log \
	--disable-pam \
	--with-init-script=systemd \
	--with-systemdsystemunitdir=/usr/lib/systemd/system/ \
	--with-distro=unknown \
	--with-usernic-conf \
	--with-usernic-db \
	--with-log-path=/var/log \
	--with-pamdir=none

LXC_APPLICATIONS := \
	copy \
	cgroup \
	create \
	snapshot \
	freeze \
	config \
	monitor \
	unfreeze \
	device \
	destroy \
	ls \
	console \
	wait \
	execute \
	update-config \
	stop \
	checkconfig \
	checkpoint \
	usernsexec \
	attach \
	start \
	top \
	info \
	autostart \
	unshare

ifdef PTXCONF_LXC_TEST_TOOLS
LXC_TEST_TOOLS := \
	containertests \
	may-control \
	console \
	locktests \
	no-new-privs \
	snapshot \
	concurrent \
	shutdowntest \
	cgpath \
	get_item \
	criu-check-feature \
	apparmor \
	share-ns \
	saveconfig \
	clonetest \
	createtest \
	createconfig \
	shortlived \
	rootfs \
	getkeys \
	console-log \
	attach \
	reboot \
	automount \
	api-reboot \
	destroytest \
	startone \
	raw-clone \
	parse-config-file \
	config-jump-table \
	autostart \
	state-server \
	list \
	device-add-remove \
	cloneconfig \
	utils \
	lxcpath
endif

LXC_LIBEXEC_APPS := \
	containers \
	net \
	apparmor-load \
	user-nic \
	monitord \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lxc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lxc)
	@$(call install_fixup, lxc, PRIORITY, optional)
	@$(call install_fixup, lxc, SECTION, base)
	@$(call install_fixup, lxc, AUTHOR, "Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, lxc, DESCRIPTION, missing)

	@$(call install_lib, lxc, 0, 0, 0644, liblxc)

	@$(call install_copy, lxc, 0, 0, 0644, /var/lib/lxc)
	@$(call install_copy, lxc, 0, 0, 0644, /usr/lib/lxc/rootfs)

	@$(call install_tree, lxc, 0, 0, -, /usr/share/lxc/config)

ifdef PTXCONF_GLOBAL_SELINUX
	@$(call install_tree, lxc, 0, 0, -, /usr/share/lxc/selinux)
endif

	@$(call install_alternative, lxc, 0, 0, 0644, /etc/lxc/default.conf)
	@$(call install_alternative, lxc, 0, 0, 0644, /etc/default/lxc-net)

	@$(call install_copy, lxc, 0, 0, 0644, -, /etc/default/lxc)

	@$(foreach app, $(LXC_APPLICATIONS), \
		$(call install_copy, lxc, 0, 0, 0755, -, \
			/usr/bin/lxc-$(app))$(ptx/nl))

	@$(foreach app, $(LXC_LIBEXEC_APPS), \
		$(call install_copy, lxc, 0, 0, 0755, -, \
			/usr/libexec/lxc/lxc-$(app))$(ptx/nl))

ifdef PTXCONF_LXC_TEST_TOOLS
	@$(foreach app, $(LXC_TEST_TOOLS), \
		$(call install_copy, lxc, 0, 0, 0755, \
			$(LXC_PKGDIR)/usr/bin/lxc-test-$(app), \
			/usr/bin/lxc-tests/$(app))$(ptx/nl))
endif

ifdef PTXCONF_LXC_SYSTEMD_UNIT
	@$(call install_copy, lxc, 0, 0, 0644, -, \
		/usr/lib/systemd/system/lxc.service)
	@$(call install_copy, lxc, 0, 0, 0644, -, \
		/usr/lib/systemd/system/lxc@.service)
	@$(call install_copy, lxc, 0, 0, 0644, -, \
		/usr/lib/systemd/system/lxc-net.service)

	@$(call install_link, lxc, ../lxc.service, \
		/usr/lib/systemd/system/multi-user.target.wants/lxc.service)
	@$(call install_link, lxc, ../lxc@.service, \
		/usr/lib/systemd/system/multi-user.target.wants/lxc@.service)
	@$(call install_link, lxc, ../lxc-net.service, \
		/usr/lib/systemd/system/multi-user.target.wants/lxc-net.service)
endif

	@$(call install_finish, lxc)

	@$(call touch)

# vim: syntax=make
