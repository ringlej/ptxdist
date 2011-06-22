# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CBMBASIC) += cbmbasic

#
# Paths and names
#
CBMBASIC_VERSION	:= 1.0
CBMBASIC_MD5		:= ecd8cd832470ea85368c11d609274c31
CBMBASIC		:= cbmbasic
CBMBASIC_SUFFIX		:= zip
CBMBASIC_URL		:= http://www.weihenstephan.org/~michaste/pagetable/recompiler/$(CBMBASIC).$(CBMBASIC_SUFFIX)
CBMBASIC_SOURCE		:= $(SRCDIR)/$(CBMBASIC).$(CBMBASIC_SUFFIX)
CBMBASIC_DIR		:= $(BUILDDIR)/$(CBMBASIC)-$(CBMBASIC_VERSION)
CBMBASIC_STRIP_LEVEL	:= 0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CBMBASIC_CONF_TOOL	:= NO
CBMBASIC_MAKE_OPT	:= $(CROSS_ENV_PROGS)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cbmbasic.install:
	@$(call targetinfo)
	install -D -m755 $(CBMBASIC_DIR)/cbmbasic \
		$(CBMBASIC_PKGDIR)/usr/bin/cbmbasic
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cbmbasic.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  cbmbasic)
	@$(call install_fixup, cbmbasic,PRIORITY,optional)
	@$(call install_fixup, cbmbasic,SECTION,base)
	@$(call install_fixup, cbmbasic,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, cbmbasic,DESCRIPTION,missing)

	@$(call install_copy, cbmbasic, 0, 0, 0755, -, /usr/bin/cbmbasic)

	@$(call install_finish, cbmbasic)

	@$(call touch)

# vim: syntax=make
