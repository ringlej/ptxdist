# -*-makefile-*-

ifdef PTXCONF_IMAGE_IPKG_IMAGE_FROM_REPOSITORY
$(STATEDIR)/images: $(STATEDIR)/ipkg-push
endif

$(STATEDIR)/ipkg-push: $(STATEDIR)/host-ipkg-utils.install
	@$(call targetinfo)
	( \
	PATH=$(PTXCONF_SYSROOT_CROSS)/bin:$(PTXCONF_SYSROOT_CROSS)/usr/bin:$$PATH; \
	PATH=$(PTXCONF_SYSROOT_HOST)/bin:$(PTXCONF_SYSROOT_HOST)/usr/bin:$$PATH; \
	export PATH;  \
	$(PTXDIST_TOPDIR)/scripts/ipkg-push \
		--ipkgdir  $(call remove_quotes,$(PKGDIR)) \
		--repodir  $(call remove_quotes,$(PTXCONF_SETUP_IPKG_REPOSITORY)) \
		--revision $(call remove_quotes,$(PTXDIST_VERSION_FULL)) \
		--project  $(call remove_quotes,$(PTXCONF_PROJECT)) \
		--dist     $(call remove_quotes,$(PTXCONF_PROJECT)$(PTXCONF_PROJECT_VERSION)); \
	echo; \
	)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
