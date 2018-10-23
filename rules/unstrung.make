# -*-makefile-*-
#
# Copyright (C) 2016 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UNSTRUNG) += unstrung

#
# Paths and names
#
UNSTRUNG_VERSION	:= 1.11.0
UNSTRUNG_MD5		:= b18fa7644f19688e75eb37475816d73a
UNSTRUNG		:= unstrung-$(UNSTRUNG_VERSION)
UNSTRUNG_SUFFIX		:= tar.gz
UNSTRUNG_URL		:= http://unstrung.sandelman.ca/downloads/$(UNSTRUNG).$(UNSTRUNG_SUFFIX)
UNSTRUNG_SOURCE		:= $(SRCDIR)/$(UNSTRUNG).$(UNSTRUNG_SUFFIX)
UNSTRUNG_DIR		:= $(BUILDDIR)/$(UNSTRUNG)
UNSTRUNG_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UNSTRUNG_CONF_TOOL	:= NO
UNSTRUNG_COMPILE_ENV	:= \
	$(CROSS_ENV) \
	ARCH=$(PTXCONF_ARCH_STRING) \
	EMBEDDED=$(call ptx/ifdef,PTXCONF_UNSTRUNG_TESTING,,1)

UNSTRUNG_MAKE_OPT = \
	BUILDNUMBER="$(shell date --utc --date @$(SOURCE_DATE_EPOCH) '+%Y%m%d_%s')"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/unstrung.targetinstall:
	@$(call targetinfo)

	@$(call install_init, unstrung)
	@$(call install_fixup, unstrung,PRIORITY,optional)
	@$(call install_fixup, unstrung,SECTION,base)
	@$(call install_fixup, unstrung,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, unstrung,DESCRIPTION,missing)

	@$(call install_copy, unstrung, 0, 0, 0755, -, /sbin/sunshine)

ifdef PTXCONF_UNSTRUNG_TESTING
	@$(call install_copy, unstrung, 0, 0, 0755, -, /sbin/peck)
	@$(call install_copy, unstrung, 0, 0, 0755, -, /sbin/senddao)
	@$(call install_copy, unstrung, 0, 0, 0755, -, /sbin/senddio)
endif

	@$(call install_finish, unstrung)

	@$(call touch)

# vim: syntax=make
