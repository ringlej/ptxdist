# -*-makefile-*-
#
# Copyright (C) 2016 by Lucas Stach <l.stach@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NSPR) += nspr

#
# Paths and names
#
NSPR_VERSION	:= 4.20
NSPR_MD5	:= 1c198c7e73f6b0e2bb9153a644ba246b
NSPR		:= nspr-$(NSPR_VERSION)
NSPR_SUFFIX	:= tar.gz
NSPR_URL	:= https://ftp.mozilla.org/pub/nspr/releases/v$(NSPR_VERSION)/src/$(NSPR).$(NSPR_SUFFIX)
NSPR_SOURCE	:= $(SRCDIR)/$(NSPR).$(NSPR_SUFFIX)
NSPR_DIR	:= $(BUILDDIR)/$(NSPR)
NSPR_SUBDIR	:= nspr
NSPR_LICENSE	:= MPL-2.0
NSPR_LICENSE_FILES	:= \
	file://$(NSPR_SUBDIR)/LICENSE;md5=815ca599c9df247a0c7f619bab123dad
# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
NSPR_CONF_TOOL	:= autoconf
NSPR_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-optimize=-O2 \
	--disable-debug \
	--disable-debug-symbols \
	--$(call ptx/endis, PTXCONF_ARCH_LP64)-64bit \
	--disable-mdupdate \
	--disable-cplus \
	--disable-strip \
	$(GLOBAL_IPV6_OPTION) \
	--disable-wrap-malloc \
	--without-mozilla \
	--with-thumb=toolchain-default \
	--with-thumb-interwork=toolchain-default \
	--with-arch=toolchain-default \
	--with-fpu=toolchain-default \
	--with-float-abi=toolchain-default \
	--with-soft-float=toolchain-default

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

NSPR_HOST_COMPILE_OPT := \
	CC=gcc \
	CFLAGS="-DXP_UNIX" \
	CROSS_COMPILE=1 \
	LDFLAGS="" \
	-C config \
	export

NSPR_MAKE_OPT := \
	SH_NOW="$(SOURCE_DATE_EPOCH)000000" \
	SH_DATE="`date --utc --date @$(SOURCE_DATE_EPOCH) "+%Y-%m-%d %T"`"

$(STATEDIR)/nspr.compile:
	@$(call targetinfo)
	@$(call compile, NSPR, $(NSPR_HOST_COMPILE_OPT))
	@$(call world/compile, NSPR)
	@$(call touch)

NSPR_INSTALL_OPT := \
	DESTDIR=$(NSPR_PKGDIR) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nspr.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nspr)
	@$(call install_fixup, nspr,PRIORITY,optional)
	@$(call install_fixup, nspr,SECTION,base)
	@$(call install_fixup, nspr,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, nspr,DESCRIPTION,missing)

	@$(call install_lib, nspr, 0, 0, 0644, libnspr4)
	@$(call install_lib, nspr, 0, 0, 0644, libplc4)
	@$(call install_lib, nspr, 0, 0, 0644, libplds4)

	@$(call install_finish, nspr)

	@$(call touch)

# vim: syntax=make
