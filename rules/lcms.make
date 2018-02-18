# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LCMS) += lcms

#
# Paths and names
#
LCMS_VERSION		:= 2.9
LCMS_MD5		:= 8de1b7724f578d2995c8fdfa35c3ad0e
LCMS			:= lcms2-$(LCMS_VERSION)
LCMS_SUFFIX		:= tar.gz
LCMS_URL		:= $(call ptx/mirror, SF, lcms/$(LCMS).$(LCMS_SUFFIX))
LCMS_SOURCE		:= $(SRCDIR)/$(LCMS).$(LCMS_SUFFIX)
LCMS_DIR		:= $(BUILDDIR)/$(LCMS)
LCMS_LICENSE		:= MIT
LCMS_LICENSE_FILES	:= file://COPYING;md5=6c786c3b7a4afbd3c990f1b81261d516

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LCMS_PATH	:= PATH=$(CROSS_PATH)
LCMS_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LCMS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-tiff \
	--without-zlib \
	--without-jpeg

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lcms.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lcms)
	@$(call install_fixup, lcms,PRIORITY,optional)
	@$(call install_fixup, lcms,SECTION,base)
	@$(call install_fixup, lcms,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, lcms,DESCRIPTION,missing)

	@$(call install_lib, lcms, 0, 0, 0644, liblcms2)

ifdef PTXCONF_LCMS_BIN
	@$(call install_copy, lcms, 0, 0, 0755, -, /usr/bin/transicc)
	@$(call install_copy, lcms, 0, 0, 0755, -, /usr/bin/psicc)
	@$(call install_copy, lcms, 0, 0, 0755, -, /usr/bin/linkicc)
endif
	@$(call install_finish, lcms)

	@$(call touch)

# vim: syntax=make
