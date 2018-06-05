# -*-makefile-*-
#
# Copyright (C) 2010 by Remy Bohmer <linux@bohmer.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LATENCYTOP) += latencytop

#
# Paths and names
#
LATENCYTOP_VERSION	:= 0.5
LATENCYTOP_MD5		:= 73bb3371c6ee0b0e68e25289027e865c
LATENCYTOP		:= latencytop-$(LATENCYTOP_VERSION)
LATENCYTOP_SUFFIX	:= tar.gz
LATENCYTOP_URL		:= https://www.latencytop.org/download/$(LATENCYTOP).$(LATENCYTOP_SUFFIX);no-check-certificate
LATENCYTOP_SOURCE	:= $(SRCDIR)/$(LATENCYTOP).$(LATENCYTOP_SUFFIX)
LATENCYTOP_DIR		:= $(BUILDDIR)/$(LATENCYTOP)
LATENCYTOP_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LATENCYTOP_CONF_TOOL	:= NO
LATENCYTOP_COMPILE_ENV	:= $(CROSS_ENV_FLAGS)
LATENCYTOP_MAKE_OPT	:= \
	$(CROSS_ENV_CC) \
	HAS_GTK_GUI=
LATENCYTOP_INSTALL_OPT	:= \
	$(LATENCYTOP_MAKE_OPT) \
	DESTDIR=$(LATENCYTOP_PKGDIR) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/latencytop.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  latencytop)
	@$(call install_fixup, latencytop,PRIORITY,optional)
	@$(call install_fixup, latencytop,SECTION,base)
	@$(call install_fixup, latencytop,AUTHOR,"Remy Bohmer <linux@bohmer.net>")
	@$(call install_fixup, latencytop,DESCRIPTION,missing)

	@$(call install_copy, latencytop, 0, 0, 0644, -, \
				/usr/share/latencytop/latencytop.trans)
	@$(call install_copy, latencytop, 0, 0, 0755, -, /usr/sbin/latencytop)

	@$(call install_finish, latencytop)
	@$(call touch)

# vim: syntax=make
