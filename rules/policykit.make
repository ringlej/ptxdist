# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POLICYKIT) += policykit

#
# Paths and names
#
POLICYKIT_VERSION	:= 0.9
POLICYKIT_MD5		:= 802fd13ae41f73d79359e5ecb0a98716
POLICYKIT		:= PolicyKit-$(POLICYKIT_VERSION)
POLICYKIT_SUFFIX	:= tar.gz
POLICYKIT_URL		:= http://hal.freedesktop.org/releases/$(POLICYKIT).$(POLICYKIT_SUFFIX)
POLICYKIT_SOURCE	:= $(SRCDIR)/$(POLICYKIT).$(POLICYKIT_SUFFIX)
POLICYKIT_DIR		:= $(BUILDDIR)/$(POLICYKIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(POLICYKIT_SOURCE):
	@$(call targetinfo)
	@$(call get, POLICYKIT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POLICYKIT_PATH	:= PATH=$(CROSS_PATH)
POLICYKIT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
POLICYKIT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--disable-ansi \
	--disable-verbose-mode \
	--disable-tests \
	--disable-gcov \
	--disable-man-pages \
	--disable-gtk-doc \
	--disable-selinux \
	--with-gnu-ld \
	--with-authfw=none \
	--with-authdb=dummy \
	--with-os-type=redhat

# TODO:
# - add switches for --with-authfw=none/pam/shadow
# - add --with-authdb=default
# - --with-os-type=<os> doesn't know debian

#  --with-tags[=TAGS]      include additional configurations [automatic]
#  --with-html-dir=PATH    path to installed docs
#  --with-expat=<dir>      Use expat from here
#  --with-polkit-user=<user>  user for PolicyKit
#  --with-polkit-group=<grp>  group for PolicyKit
#  --with-pam-prefix=<prefix> specify where pam files go
#  --with-pam-module-dir=dirname  directory to install PAM security module
#  --with-pam-include=<file>  pam file to include

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/policykit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, policykit)
	@$(call install_fixup, policykit,PRIORITY,optional)
	@$(call install_fixup, policykit,SECTION,base)
	@$(call install_fixup, policykit,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, policykit,DESCRIPTION,missing)

	# libs
	@$(call install_lib, policykit, 0, 0, 0644, libpolkit-dbus)
	@$(call install_lib, policykit, 0, 0, 0644, libpolkit-grant)
	@$(call install_lib, policykit, 0, 0, 0644, libpolkit)

	# configs
	for i in \
		/etc/dbus-1/system.d/org.freedesktop.PolicyKit.conf \
		/etc/PolicyKit/PolicyKit.conf \
		/usr/share/dbus-1/interfaces/org.freedesktop.PolicyKit.AuthenticationAgent.xml \
		/usr/share/dbus-1/system-services/org.freedesktop.PolicyKit.service \
		/usr/share/PolicyKit/config.dtd \
		/usr/share/PolicyKit/policy/org.freedesktop.policykit.policy \
		/etc/profile.d/polkit-bash-completion.sh \
	; \
	do $(call install_copy, policykit, 0, 0, 0644, -, $$i); done

	# binaries
	for i in \
		/usr/bin/polkit-action \
		/usr/bin/polkit-auth \
		/usr/bin/polkit-config-file-validate \
		/usr/bin/polkit-policy-file-validate \
		/usr/libexec/polkitd \
	; \
	do $(call install_copy, policykit, 0, 0, 0755, -, $$i); done

	# binaries with suid
	@$(call install_copy, policykit, 0, 0, 4755, -, /usr/libexec/polkit-resolve-exe-helper)

	@$(call install_finish, policykit)

	@$(call touch)

# vim: syntax=make
