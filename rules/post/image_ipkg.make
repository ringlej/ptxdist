# -*-makefile-*-
#
# Copyright (C) 2003-2009 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_IPKG_IMAGE_FROM_REPOSITORY) += $(STATEDIR)/ipkg-push

$(STATEDIR)/ipkg-push: $(STATEDIR)/host-ipkg-utils.install.post
	@$(call targetinfo)
	$(PTXDIST_TOPDIR)/scripts/ipkg-push \
		--ipkgdir  $(call remove_quotes,$(PKGDIR)) \
		--repodir  $(call remove_quotes,$(PTXCONF_SETUP_IPKG_REPOSITORY)) \
		--revision $(call remove_quotes,$(PTXDIST_VERSION_FULL)) \
		--project  $(call remove_quotes,$(PTXCONF_PROJECT)) \
		--dist     $(call remove_quotes,$(PTXCONF_PROJECT)$(PTXCONF_PROJECT_VERSION))

# vim: syntax=make
