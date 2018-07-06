# -*-makefile-*-
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_USR_ROOTFS) += usr-rootfs

USR_ROOTFS_VERSION	:= 1.0
USR_ROOTFS_LICENSE	:= ignore

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/usr-rootfs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, usr-rootfs)
	@$(call install_fixup,usr-rootfs,PRIORITY,optional)
	@$(call install_fixup,usr-rootfs,SECTION,base)
	@$(call install_fixup,usr-rootfs,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,usr-rootfs,DESCRIPTION,missing)

	@$(call install_copy, usr-rootfs, 0, 0, 0755, /usr)
	@$(call install_copy, usr-rootfs, 0, 0, 0755, /usr/bin)
	@$(call install_copy, usr-rootfs, 0, 0, 0755, /usr/sbin)
	@$(call install_copy, usr-rootfs, 0, 0, 0755, /usr/lib)

	@$(call install_link, usr-rootfs, usr/bin, /bin)
	@$(call install_link, usr-rootfs, usr/sbin, /sbin)
	@$(call install_link, usr-rootfs, usr/lib, /lib)

	@$(call install_finish,usr-rootfs)

	@$(call touch)

# vim: syntax=make
