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
CRDA_VERSION	:= 3.13
CRDA_MD5	:= 66b1b0417c1ad19f0009a5c0c0c1aebc
CRDA		:= crda-$(CRDA_VERSION)
CRDA_SUFFIX	:= tar.xz
CRDA_URL	:= $(call ptx/mirror, KERNEL, ../software/network/crda/$(CRDA).$(CRDA_SUFFIX))
CRDA_SOURCE	:= $(SRCDIR)/$(CRDA).$(CRDA_SUFFIX)
CRDA_DIR	:= $(BUILDDIR)/$(CRDA)
CRDA_LICENSE	:= ISC, copyleft-next-0.3.0
CRDA_LICENSE_FILES := \
	file://LICENSE;md5=ef8b69b43141352d821fd66b64ff0ee7 \
	file://copyleft-next-0.3.0;md5=8743a2c359037d4d329a31e79eabeffe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/crda.prepare:
	@$(call targetinfo)
ifdef PTXCONF_ARCH_X86_64
	@cp $(CRDA_DIR)/keys-ssl.c.64 $(CRDA_DIR)/keys-ssl.c
else
	@cp $(CRDA_DIR)/keys-ssl.c.32 $(CRDA_DIR)/keys-ssl.c
endif
	@$(call touch)

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
	@$(call install_lib, crda, 0, 0, 0644, libreg)

	# regulatory.bin was downloaded from:
	# git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-regdb.git
	@$(call install_alternative, crda, 0, 0, 0644, \
		/usr/lib/crda/regulatory.bin)

	@$(call install_finish, crda)

	@$(call touch)

# vim: syntax=make
