# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2007 by Robert Schwebel
#               2009, 2016 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SLANG) += slang

#
# Paths and names
#
SLANG_VERSION	:= 2.3.0
SLANG_MD5	:= 3bcc790460d52db1316c20395b7ac2f1
SLANG		:= slang-$(SLANG_VERSION)
SLANG_SUFFIX	:= tar.bz2
SLANG_URL	:= \
    http://www.jedsoft.org/releases/slang/$(SLANG).$(SLANG_SUFFIX) \
    http://www.jedsoft.org/releases/slang/old/$(SLANG).$(SLANG_SUFFIX)
SLANG_SOURCE	:= $(SRCDIR)/$(SLANG).$(SLANG_SUFFIX)
SLANG_DIR	:= $(BUILDDIR)/$(SLANG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SLANG_CONF_TOOL	:= autoconf
SLANG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--without-x \
	--without-pcre \
	--without-onig \
	--without-png \
	--without-z \
	--without-iconv

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/slang.targetinstall:
	@$(call targetinfo)

	@$(call install_init, slang)
	@$(call install_fixup, slang,PRIORITY,optional)
	@$(call install_fixup, slang,SECTION,base)
	@$(call install_fixup, slang,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, slang,DESCRIPTION,missing)

	@$(call install_lib, slang, 0, 0, 0644, libslang)

	@$(call install_finish, slang)

	@$(call touch)

# vim: syntax=make
