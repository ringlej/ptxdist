# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
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
CBMBASIC		:= cbmbasic
CBMBASIC_SUFFIX		:= zip
CBMBASIC_URL		:= http://www.weihenstephan.org/~michaste/pagetable/recompiler/$(CBMBASIC).$(CBMBASIC_SUFFIX)
CBMBASIC_SOURCE		:= $(SRCDIR)/$(CBMBASIC).$(CBMBASIC_SUFFIX)
CBMBASIC_DIR		:= $(BUILDDIR)/$(CBMBASIC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CBMBASIC_SOURCE):
	@$(call targetinfo)
	@$(call get, CBMBASIC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/cbmbasic.extract:
	@$(call targetinfo)
	@$(call clean, $(CBMBASIC_DIR))
	mkdir -p $(CBMBASIC_DIR)
	@$(call extract, CBMBASIC, $(CBMBASIC_DIR))
	@$(call patchin, CBMBASIC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CBMBASIC_PATH	:= PATH=$(CROSS_PATH)
CBMBASIC_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/cbmbasic.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/cbmbasic.compile:
	@$(call targetinfo)
	cd $(CBMBASIC_DIR) && $(CBMBASIC_PATH) $(MAKE) $(PARALLELMFLAGS) CC=$(CROSS_CC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cbmbasic.install:
	@$(call targetinfo)
	# @$(call install, CBMBASIC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cbmbasic.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  cbmbasic)
	@$(call install_fixup, cbmbasic,PACKAGE,cbmbasic)
	@$(call install_fixup, cbmbasic,PRIORITY,optional)
	@$(call install_fixup, cbmbasic,VERSION,$(CBMBASIC_VERSION))
	@$(call install_fixup, cbmbasic,SECTION,base)
	@$(call install_fixup, cbmbasic,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, cbmbasic,DEPENDS,)
	@$(call install_fixup, cbmbasic,DESCRIPTION,missing)

	@$(call install_copy, cbmbasic, 0, 0, 0755, \
		$(CBMBASIC_DIR)/cbmbasic, \
		/usr/bin/cbmbasic)

	@$(call install_finish, cbmbasic)

	@$(call touch)

# vim: syntax=make
