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
PACKAGES-$(PTXCONF_P7ZIP) += p7zip

#
# Paths and names
#
P7ZIP_VERSION	:= 9.20.1
P7ZIP_MD5	:= bd6caaea567dc0d995c990c5cc883c89
P7ZIP		:= p7zip_$(P7ZIP_VERSION)
P7ZIP_SUFFIX	:= tar.bz2
P7ZIP_URL	:= $(call ptx/mirror, SF, p7zip/$(P7ZIP)_src_all.$(P7ZIP_SUFFIX))
P7ZIP_SOURCE	:= $(SRCDIR)/$(P7ZIP)_src_all.$(P7ZIP_SUFFIX)
P7ZIP_DIR	:= $(BUILDDIR)/$(P7ZIP)
P7ZIP_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


P7ZIP_CONF_TOOL		:= NO
P7ZIP_MAKE_ENV		:= $(CROSS_ENV)
P7ZIP_MAKE_OPT		:= \
	CXX='$(CROSS_CXX) \$$(ALLFLAGS)' \
	CC='$(CROSS_CC) \$$(ALLFLAGS)'

P7ZIP_INSTALL_OPT	:= \
	DEST_HOME=/usr \
	DEST_DIR=$(P7ZIP_PKGDIR) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/p7zip.targetinstall:
	@$(call targetinfo)

	@$(call install_init, p7zip)
	@$(call install_fixup, p7zip,PRIORITY,optional)
	@$(call install_fixup, p7zip,SECTION,base)
	@$(call install_fixup, p7zip,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, p7zip,DESCRIPTION,missing)

	@$(call install_copy, p7zip, 0, 0, 0755, -, /usr/bin/7za)

	@$(call install_finish, p7zip)

	@$(call touch)

# vim: syntax=make
