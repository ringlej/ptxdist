# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ICU) += icu

#
# Paths and names
#
ICU_VERSION	:= 52.1
ICU_MD5		:= 9e96ed4c1d99c0d14ac03c140f9f346c
ICU		:= icu4c-$(subst .,_,$(ICU_VERSION))-src
ICU_SUFFIX	:= tgz
ICU_URL		:= http://download.icu-project.org/files/icu4c/$(ICU_VERSION)/$(ICU).$(ICU_SUFFIX)
ICU_SOURCE	:= $(SRCDIR)/$(ICU).$(ICU_SUFFIX)
ICU_DIR		:= $(BUILDDIR)/$(ICU)
ICU_SUBDIR	:= source
ICU_LICENSE	:= MIT AND Unicode-TOU AND public_domain
ICU_LICENSE_FILES := \
	file://license.html;md5=3a0605ebb7852070592fbd57e8967f3f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#ICU_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
ICU_CONF_TOOL	:= autoconf
ICU_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--enable-release \
	--enable-shared \
	--disable-static \
	--enable-draft \
	--enable-renaming \
	--disable-tracing \
	--enable-dyload \
	--disable-rpath \
	--disable-weak-threads \
	--disable-extras \
	--enable-icuio \
	--enable-layout \
	--enable-tools \
	--disable-tests \
	--disable-samples \
	--with-cross-build=$(HOST_ICU_DIR)/$(ICU_SUBDIR) \
	--with-data-packaging=archive

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/icu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, icu)
	@$(call install_fixup, icu,PRIORITY,optional)
	@$(call install_fixup, icu,SECTION,base)
	@$(call install_fixup, icu,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, icu,DESCRIPTION,missing)

	@$(call install_lib, icu, 0, 0, 0644, libicudata)
	@$(call install_lib, icu, 0, 0, 0644, libicui18n)
	@$(call install_lib, icu, 0, 0, 0644, libicuio)
	@$(call install_lib, icu, 0, 0, 0644, libicule)
	@$(call install_lib, icu, 0, 0, 0644, libiculx)
	@$(call install_lib, icu, 0, 0, 0644, libicutu)
	@$(call install_lib, icu, 0, 0, 0644, libicuuc)

	@$(call install_copy, icu, 0, 0, 0644, -, \
		/usr/share/icu/$(ICU_VERSION)/icudt$(basename $(ICU_VERSION))$(call ptx/ifdef,PTXCONF_ENDIAN_LITTLE,l,b).dat)

	@$(call install_finish, icu)

	@$(call touch)

# vim: syntax=make
