# -*-makefile-*-
#
# Copyright (C) 2003-2009 by the ptxdist project <ptxdist@pengutronix.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
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


SEL_ROOTFS-$(PTXCONF_IMAGE_IPKG_INDEX) += $(PKGDIR)/Packages

PHONY += $(PKGDIR)/Packages
$(PKGDIR)/Packages: $(STATEDIR)/host-ipkg-utils.install.post
	@echo -n "generating ipkg index '$(notdir $@)'..."
	@$(HOST_ENV) \
		ipkg-make-index -p "$(@)" "$(PKGDIR)" >/dev/null 2>&1
	@echo "done"

# vim: syntax=make
