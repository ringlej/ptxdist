# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_USTR) += ustr

#
# Paths and names
#
USTR_VERSION	:= 1.0.4
USTR_MD5	:= 93147d9f0c9765d4cd0f04f7e44bdfce
USTR		:= ustr-$(USTR_VERSION)
USTR_SUFFIX	:= tar.bz2
USTR_URL	:= http://www.and.org/ustr/$(USTR_VERSION)/$(USTR).$(USTR_SUFFIX)
USTR_SOURCE	:= $(SRCDIR)/$(USTR).$(USTR_SUFFIX)
USTR_DIR	:= $(BUILDDIR)/$(USTR)
USTR_LICENSE	:= LGPL-2.0-or-later AND MIT AND BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

USTR_CONF_TOOL := NO
USTR_MAKE_OPT := \
	$(CROSS_ENV_PROGS) \
	VSNP=0 \
	SZ64=$(call ptx/ifdef, PTXCONF_ARCH_LP64,1,0) \
	all-shared
USTR_INSTALL_OPT := \
	$(USTR_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ustr.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ustr)
	@$(call install_fixup, ustr,PRIORITY,optional)
	@$(call install_fixup, ustr,SECTION,base)
	@$(call install_fixup, ustr,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, ustr,DESCRIPTION,missing)

	@$(call install_lib, ustr, 0, 0, 0644, libustr-1.0)

	@$(call install_finish, ustr)

	@$(call touch)

# vim: syntax=make
