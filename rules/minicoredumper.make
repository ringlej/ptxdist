# -*-makefile-*-
#
# Copyright (C) 2018 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MINICOREDUMPER) += minicoredumper

#
# Paths and names
#
MINICOREDUMPER_VERSION	:= 2.0.1
MINICOREDUMPER_MD5	:= 813b864e0c6a833d14bab244723de6a4
MINICOREDUMPER		:= minicoredumper-$(MINICOREDUMPER_VERSION)
MINICOREDUMPER_SUFFIX	:= tar.xz
MINICOREDUMPER_URL	:= https://linutronix.de/minicoredumper/files/$(MINICOREDUMPER).$(MINICOREDUMPER_SUFFIX)
MINICOREDUMPER_SOURCE	:= $(SRCDIR)/$(MINICOREDUMPER).$(MINICOREDUMPER_SUFFIX)
MINICOREDUMPER_DIR	:= $(BUILDDIR)/$(MINICOREDUMPER)
MINICOREDUMPER_LICENSE	:= BSD AND LGPL-2.1
MINICOREDUMPER_LICENSE_FILES := file://COPYING;md5=71827c617ec7b45a0dd23658347cc1e9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MINICOREDUMPER_CONF_TOOL := autoconf
MINICOREDUMPER_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-silent-rules \
	--without-coreinject \
	--with-minicoredumper \
	--without-minicoredumper_regd \
	--without-minicoredumper_trigger \
	--without-libminicoredumper \
	--without-minicoredumper_demo \
	--without-werror \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/minicoredumper.targetinstall:
	@$(call targetinfo)

	@$(call install_init, minicoredumper)
	@$(call install_fixup, minicoredumper, PRIORITY, optional)
	@$(call install_fixup, minicoredumper, SECTION, base)
	@$(call install_fixup, minicoredumper, AUTHOR, "Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, minicoredumper, DESCRIPTION, missing)

	@$(call install_copy, minicoredumper, 0, 0, 0755, -, /usr/sbin/minicoredumper)

	@$(call install_alternative_tree, minicoredumper, 0, 0, /etc/minicoredumper)

	@$(call install_copy, minicoredumper, 0, 0, 0755, /var/crash/minicoredumper)

	@$(call install_finish, minicoredumper)

	@$(call touch)

# vim: syntax=make
