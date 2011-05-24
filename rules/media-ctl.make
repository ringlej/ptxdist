# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Grzeschik <mgr@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEDIA_CTL) += media-ctl

#
# Paths and names
#
MEDIA_CTL_VERSION	:= 2011.05.24-ga183835
MEDIA_CTL_MD5		:= e80ad58e923e77a10b881100ce944f3e
MEDIA_CTL		:= media-ctl-$(MEDIA_CTL_VERSION)
MEDIA_CTL_SUFFIX	:= tar.gz
MEDIA_CTL_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(MEDIA_CTL).$(MEDIA_CTL_SUFFIX)
MEDIA_CTL_SOURCE	:= $(SRCDIR)/$(MEDIA_CTL).$(MEDIA_CTL_SUFFIX)
MEDIA_CTL_DIR		:= $(BUILDDIR)/$(MEDIA_CTL)
MEDIA_CTL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MEDIA_CTL_CONF_TOOL	:= autoconf
MEDIA_CTL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR)\
	--with-kernel-headers="$(KERNEL_HEADERS_DIR)"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/media-ctl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, media-ctl)
	@$(call install_fixup, media-ctl,PRIORITY,optional)
	@$(call install_fixup, media-ctl,SECTION,base)
	@$(call install_fixup, media-ctl,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, media-ctl,DESCRIPTION,missing)

	@$(call install_lib, media-ctl, 0, 0, 0644, libmediactl)
	@$(call install_lib, media-ctl, 0, 0, 0644, libv4l2subdev)
	@$(call install_copy, media-ctl, 0, 0, 0755, -, /usr/bin/media-ctl)

	@$(call install_finish, media-ctl)

	@$(call touch)


# vim: syntax=make
