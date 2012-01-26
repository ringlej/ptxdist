# -*-makefile-*-
#
# Copyright (C) 2012 by Jan Luebbe <jlu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CRDA) += crda

#
# Paths and names
#
CRDA_VERSION	:= 1.1.2
CRDA_MD5	:= 5226f65aebacf94baaf820f8b4e06df4
CRDA		:= crda-$(CRDA_VERSION)
CRDA_SUFFIX	:= tar.bz2
CRDA_URL	:= http://linuxwireless.org/download/crda/$(CRDA).$(CRDA_SUFFIX)
CRDA_SOURCE	:= $(SRCDIR)/$(CRDA).$(CRDA_SUFFIX)
CRDA_DIR	:= $(BUILDDIR)/$(CRDA)
CRDA_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CRDA_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

CRDA_MAKE_ENV	:= \
	$(CROSS_ENV) \
	USE_OPENSSL=1

CRDA_MAKE_OPT	:= all_noverify

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/crda.targetinstall:
	@$(call targetinfo)

	@$(call install_init, crda)
	@$(call install_fixup, crda,PRIORITY,optional)
	@$(call install_fixup, crda,SECTION,base)
	@$(call install_fixup, crda,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, crda,DESCRIPTION,missing)

	@$(call install_copy, crda, 0, 0, 0755, -, /sbin/crda)
	@$(call install_copy, crda, 0, 0, 0755, -, /sbin/regdbdump)
	@$(call install_copy, crda, 0, 0, 0644, -, \
		/lib/udev/rules.d/85-regulatory.rules)

	# regulatory.bin was downloaded from:
	# git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-regdb.git
	@$(call install_alternative, crda, 0, 0, 0644, \
		/usr/lib/crda/regulatory.bin)

	@$(call install_finish, crda)

	@$(call touch)

# vim: syntax=make
