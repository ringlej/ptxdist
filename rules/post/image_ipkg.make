# -*-makefile-*-
#
# Copyright (C) 2003-2009 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_IMAGE_IPKG_IMAGE_FROM_REPOSITORY
$(STATEDIR)/images: $(STATEDIR)/ipkg-push
endif

$(STATEDIR)/ipkg-push: $(STATEDIR)/host-ipkg-utils.install.post
	@$(call targetinfo)
	( \
	PATH=$(PTXCONF_SYSROOT_CROSS)/bin:$(PTXCONF_SYSROOT_CROSS)/usr/bin:$$PATH; \
	export PATH;  \
	$(PTXDIST_TOPDIR)/scripts/ipkg-push \
		--ipkgdir  $(call remove_quotes,$(PKGDIR)) \
		--repodir  $(call remove_quotes,$(PTXCONF_SETUP_IPKG_REPOSITORY)) \
		--revision $(call remove_quotes,$(PTXDIST_VERSION_FULL)) \
		--project  $(call remove_quotes,$(PTXCONF_PROJECT)) \
		--dist     $(call remove_quotes,$(PTXCONF_PROJECT)$(PTXCONF_PROJECT_VERSION)); \
	echo; \
	)

# vim: syntax=make
