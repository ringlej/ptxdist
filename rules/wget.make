# -*-makefile-*-
#
# Copyright (C) 2005-2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WGET) += wget

#
# Paths and names
#
WGET_VERSION	:= 1.19.1
WGET_MD5	:= 87cea36b7161fd43e3fd51a4e8b89689
WGET		:= wget-$(WGET_VERSION)
WGET_SUFFIX	:= tar.gz
WGET_URL	:= $(call ptx/mirror, GNU, wget/$(WGET).$(WGET_SUFFIX))
WGET_SOURCE	:= $(SRCDIR)/$(WGET).$(WGET_SUFFIX)
WGET_DIR	:= $(BUILDDIR)/$(WGET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WGET_ENV := \
	$(CROSS_ENV) \
	ac_cv_prog_MAKEINFO=: \
	ac_cv_path_PERL=: \
	ac_cv_path_POD2MAN=:

#
# autoconf
#
WGET_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-opie \
	--enable-digest \
	--disable-ntlm \
	--enable-debug \
	--disable-valgrind-tests \
	--enable-assert \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--disable-nls \
	--disable-rpath \
	$(GLOBAL_IPV6_OPTION) \
	--disable-iri \
	--disable-pcre \
	--disable-xattr \
	--without-libpsl \
	--without-ssl \
	--without-zlib \
	--with-metalink \
	--without-cares \
	--without-openssl \
	--with-included-libunistring \
	--without-included-regex \
	--with-libidn=/usr \
	--without-libuuid


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wget.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wget)
	@$(call install_fixup, wget,PRIORITY,optional)
	@$(call install_fixup, wget,SECTION,base)
	@$(call install_fixup, wget,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, wget,DESCRIPTION,missing)

	@$(call install_copy, wget, 0, 0, 0755, -, /usr/bin/wget)

	@$(call install_finish, wget)

	@$(call touch)

# vim: syntax=make
