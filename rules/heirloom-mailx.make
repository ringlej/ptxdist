# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HEIRLOOM_MAILX) += heirloom-mailx

#
# Paths and names
#
HEIRLOOM_MAILX_VERSION	:= 12.4
HEIRLOOM_MAILX_MD5	:= 0c93759e34200eb56a0e7c464680a54a
HEIRLOOM_MAILX		:= mailx-$(HEIRLOOM_MAILX_VERSION)
HEIRLOOM_MAILX_SUFFIX	:= tar.bz2
HEIRLOOM_MAILX_URL	:= $(call ptx/mirror, SF, heirloom/$(HEIRLOOM_MAILX).$(HEIRLOOM_MAILX_SUFFIX))
HEIRLOOM_MAILX_SOURCE	:= $(SRCDIR)/$(HEIRLOOM_MAILX).$(HEIRLOOM_MAILX_SUFFIX)
HEIRLOOM_MAILX_DIR	:= $(BUILDDIR)/$(HEIRLOOM_MAILX)
HEIRLOOM_MAILX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HEIRLOOM_MAILX_CONF_ENV	:= $(CROSS_ENV)
HEIRLOOM_MAILX_PATH	:= PATH=$(CROSS_PATH)

HEIRLOOM_MAILX_DISABLE := \
	USE_SSL \
	USE_NSS \
	USE_OPENSSL \
	USE_GSSAPI \
	GSSAPI_OLD_STYLE

$(STATEDIR)/heirloom-mailx.prepare:
	@$(call targetinfo)
	@$(call clean, $(HEIRLOOM_MAILX_DIR)/config.cache)
	@cd $(HEIRLOOM_MAILX_DIR) && \
		$(HEIRLOOM_MAILX_PATH) $(HEIRLOOM_MAILX_CONF_ENV) \
		sh makeconfig
#	# disable ssl options
	@$(foreach def,$(HEIRLOOM_MAILX_DISABLE), \
		sed -i 's;^\(#define $(def)\)$$;/*\1*/;' $(HEIRLOOM_MAILX_DIR)/config.h;)
#	# don't link to ssl libs
	@:> $(HEIRLOOM_MAILX_DIR)/LIBS
	@$(call touch)

HEIRLOOM_MAILX_MAKE_ENV		:= $(CROSS_ENV)
HEIRLOOM_MAILX_INSTALL_OPT	:= PREFIX=/usr UCBINSTALL=install install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/heirloom-mailx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, heirloom-mailx)
	@$(call install_fixup, heirloom-mailx,PRIORITY,optional)
	@$(call install_fixup, heirloom-mailx,SECTION,base)
	@$(call install_fixup, heirloom-mailx,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, heirloom-mailx,DESCRIPTION,missing)

	@$(call install_copy, heirloom-mailx, 0, 0, 0755, -, /usr/bin/mailx)
	@$(call install_alternative, heirloom-mailx, 0, 0, 0644, /etc/nail.rc)

	@$(call install_finish, heirloom-mailx)

	@$(call touch)

# vim: syntax=make
