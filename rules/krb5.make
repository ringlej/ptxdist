# -*-makefile-*-
#
# Copyright (C) 2017 by Jan Luebbe <jlu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KRB5) += krb5

#
# Paths and names
#
KRB5_VERSION	:= 1.15.2
KRB5_MD5	:= b160f72161c730897dc7689f876b6e2a
KRB5		:= krb5-$(KRB5_VERSION)
KRB5_SUFFIX	:= tar.gz
KRB5_URL	:= https://web.mit.edu/kerberos/dist/krb5/1.15/$(KRB5).$(KRB5_SUFFIX)
KRB5_SOURCE	:= $(SRCDIR)/$(KRB5).$(KRB5_SUFFIX)
KRB5_DIR	:= $(BUILDDIR)/$(KRB5)
KRB5_LICENSE	:= MIT

KRB5_SUBDIR	:= src

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# keyutils is only useful for the client case

KRB5_PATH	:= PATH=$(CROSS_PATH)
KRB5_CONF_ENV	:= \
	$(CROSS_ENV) \
	krb5_cv_attr_constructor_destructor=yes,yes \
	ac_cv_func_regcomp=yes \
	ac_cv_printf_positional=yes \
	ac_cv_file__etc_environment=yes \
	ac_cv_file__etc_TIMEZONE=no \
	ac_cv_header_keyutils_h=$(call ptx/yesno, PTXCONF_KRB5_CLIENT_TOOLS)

#
# autoconf
#
KRB5_CONF_TOOL	:= autoconf
KRB5_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-dns-for-realm \
	--enable-delayed-initialization \
	--enable-thread-support \
	--disable-rpath \
	--disable-athena \
	--disable-audit-plugin \
	--enable-kdc-lookaside-cache \
	--disable-asan \
	--enable-pkinit \
	--without-size-optimizations \
	--with-system-et \
	--with-system-ss \
	--without-system-db \
	--without-netlib \
	--without-hesiod \
	--without-ldap \
	--without-tcl \
	--without-vague-errors \
	--with-crypto-impl=openssl \
	--with-prng-alg=fortuna \
	--with-pkinit-crypto-impl=openssl \
	--with-tls-impl=openssl \
	--with-libedit \
	--without-readline \
	--without-system-verto

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/krb5.targetinstall:
	@$(call targetinfo)

	@$(call install_init, krb5)
	@$(call install_fixup, krb5,PRIORITY,optional)
	@$(call install_fixup, krb5,SECTION,base)
	@$(call install_fixup, krb5,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, krb5,DESCRIPTION,missing)

	@$(call install_lib, krb5, 0, 0, 0644, libgssapi_krb5)
	@$(call install_lib, krb5, 0, 0, 0644, libgssrpc)
	@$(call install_lib, krb5, 0, 0, 0644, libk5crypto)
	@$(call install_lib, krb5, 0, 0, 0644, libkdb5)
	@$(call install_lib, krb5, 0, 0, 0644, libkrb5)
	@$(call install_lib, krb5, 0, 0, 0644, libkrb5support)

ifdef PTXCONF_KRB5_ADMIN_LIBS
	@$(call install_lib, krb5, 0, 0, 0644, libkadm5clnt_mit)
	@$(call install_lib, krb5, 0, 0, 0644, libkadm5srv_mit)
endif

ifdef PTXCONF_KRB5_CLIENT_TOOLS
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/kdestroy)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/klist)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/kpasswd)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/kswitch)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/ksu)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/ktutil)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/kvno)
endif

ifdef PTXCONF_KRB5_ADMIN_TOOLS
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/kadmin)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/kinit)
endif

ifdef PTXCONF_KRB5_EXAMPLES
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/gss-client)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/bin/sclient)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/sbin/gss-server)
	@$(call install_copy, krb5, 0, 0, 0755, -, /usr/sbin/sserver)
endif

	@$(call install_finish, krb5)

	@$(call touch)

# vim: syntax=make
