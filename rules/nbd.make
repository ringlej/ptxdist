# -*-makefile-*-
#
# Copyright (C) 2015 by Markus Pargmann <mpa@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NBD) += nbd

#
# Paths and names
#
NBD_VERSION	:= 3.12.1
NBD_MD5		:= 055eb1c5a95cc6976256dcc84ae63abb
NBD		:= nbd-$(NBD_VERSION)
NBD_SUFFIX	:= tar.xz
NBD_URL		:= http://downloads.sourceforge.net/project/nbd/nbd/$(NBD_VERSION)/$(NBD).$(NBD_SUFFIX)
NBD_SOURCE	:= $(SRCDIR)/$(NBD).$(NBD_SUFFIX)
NBD_DIR		:= $(BUILDDIR)/$(NBD)
NBD_LICENSE	:= GPLv2

#
# autoconf
#
NBD_CONF_TOOL	:= autoconf
NBD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_GLOBAL_LARGE_FILE)-lfs \
	--disable-syslog \
	--disable-debug \
	--disable-sdp \
	--disable-gznbd \
	--disable-glibtest

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nbd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nbd)
	@$(call install_fixup, nbd,PRIORITY,optional)
	@$(call install_fixup, nbd,SECTION,base)
	@$(call install_fixup, nbd,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, nbd,DESCRIPTION,missing)

	@$(call install_copy, nbd, 0, 0, 0755, $(NBD_DIR)/nbd-client, /bin/nbd-client)
	@$(call install_copy, nbd, 0, 0, 0755, $(NBD_DIR)/nbd-server, /bin/nbd-server)

	@$(call install_finish, nbd)

	@$(call touch)

# vim: syntax=make
