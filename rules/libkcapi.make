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
PACKAGES-$(PTXCONF_LIBKCAPI) += libkcapi

#
# Paths and names
#
LIBKCAPI_VERSION	:= 1.1.3
LIBKCAPI_MD5		:= 480b78de9fe7f3f64ca7622396499e5f
LIBKCAPI		:= libkcapi-$(LIBKCAPI_VERSION)
LIBKCAPI_SUFFIX		:= tar.xz
LIBKCAPI_URL		:= http://www.chronox.de/libkcapi//$(LIBKCAPI).$(LIBKCAPI_SUFFIX)
LIBKCAPI_SOURCE		:= $(SRCDIR)/$(LIBKCAPI).$(LIBKCAPI_SUFFIX)
LIBKCAPI_DIR		:= $(BUILDDIR)/$(LIBKCAPI)
LIBKCAPI_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBKCAPI_CONF_ENV	:= \
			$(CROSS_ENV) \
			ac_cv_path_XMLTO=

#
# autoconf
#
LIBKCAPI_CONF_TOOL	:= autoconf
LIBKCAPI_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-kcapi-hasher \
	--enable-kcapi-rngapp \
	--enable-kcapi-speed \
	--$(call ptx/endis, PTXCONF_LIBKCAPI_TEST)-kcapi-test \
	--enable-kcapi-encapp \
	--enable-kcapi-dgstapp \
	--disable-lib-asym \
	--disable-lib-kpp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libkcapi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libkcapi)
	@$(call install_fixup, libkcapi,PRIORITY,optional)
	@$(call install_fixup, libkcapi,SECTION,base)
	@$(call install_fixup, libkcapi,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, libkcapi,DESCRIPTION,missing)

	@$(call install_lib, libkcapi, 0, 0, 0644, libkcapi);

	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-rng);
	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-speed);
	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-enc);
	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-dgst);

	@$(call install_copy, libkcapi, 0, 0, 0755, $(LIBKCAPI_PKGDIR)/usr/bin/fipscheck, /usr/bin/kcapi-hasher);
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/fipscheck);
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/fipshmac);
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha1hmac);
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha224hmac);
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha256hmac);
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha384hmac);
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha512hmac);

#ifdef PTXCONF_LIBKCAPI_MD5SUM
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/md5sum);
#endif

#ifdef PTXCONF_LIBKCAPI_SHA1SUM
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha1sum);
#endif

#ifdef PTXCONF_LIBKCAPI_SHA256SUM
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha256sum);
#endif

#ifdef PTXCONF_LIBKCAPI_SHA384SUM
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha384sum);
#endif

#ifdef PTXCONF_LIBKCAPI_SHA512SUM
	@$(call install_link, libkcapi, /usr/bin/kcapi-hasher, /usr/bin/sha512sum);
#endif

#ifdef PTXCONF_LIBKCAPI_TEST
	@$(call install_tree, libkcapi, 0, 0, -, /usr/libexec/libkcapi);
#endif

	@$(call install_finish, libkcapi)

	@$(call touch)

# vim: syntax=make
