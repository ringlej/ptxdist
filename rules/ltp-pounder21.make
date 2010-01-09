# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTP_POUNDER21) += ltp-pounder21

#
# Paths and names
#
LTP_POUNDER21_VERSION	:= $(LTP_BASE_VERSION)
LTP_POUNDER21		:= ltp-pounder21-$(LTP_BASE_VERSION)
LTP_POUNDER21_PKGDIR	= $(PKGDIR)/$(LTP_POUNDER21)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-pounder21.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-pounder21.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-pounder21.compile:
	@$(call targetinfo)
	@cd $(LTP_BASE_DIR)/testcases/pounder21; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-pounder21.install:
	@$(call targetinfo)
	@mkdir -p $(LTP_POUNDER21_PKGDIR)/bin
	@ln -sf $(LTP_POUNDER21_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/pounder21; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-pounder21.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-pounder21)
	@$(call install_fixup, ltp-pounder21,PACKAGE,ltp-pounder21)
	@$(call install_fixup, ltp-pounder21,PRIORITY,optional)
	@$(call install_fixup, ltp-pounder21,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-pounder21,SECTION,base)
	@$(call install_fixup, ltp-pounder21,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-pounder21,DEPENDS,)
	@$(call install_fixup, ltp-pounder21,DESCRIPTION,missing)

	@for file in `find $(LTP_POUNDER21_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-pounder21, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-pounder21)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-pounder21_clean:
	rm -rf $(STATEDIR)/ltp-pounder21.*
	rm -rf $(PKGDIR)/ltp-pounder21_*
	rm -rf $(LTP_POUNDER21_DIR)

# vim: syntax=make
