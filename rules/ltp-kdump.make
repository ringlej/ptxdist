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
PACKAGES-$(PTXCONF_LTP_KDUMP) += ltp-kdump

#
# Paths and names
#
LTP_KDUMP_VERSION	:= $(LTP_BASE_VERSION)
LTP_KDUMP		:= ltp-kdump-$(LTP_BASE_VERSION)
LTP_KDUMP_PKGDIR	= $(PKGDIR)/$(LTP_KDUMP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kdump.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kdump.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kdump.compile:
	@$(call targetinfo)
	@cd $(LTP_BASE_DIR)/testcases/kdump; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kdump.install:
	@$(call targetinfo)
	@mkdir -p $(LTP_KDUMP_PKGDIR)/bin
	@ln -sf $(LTP_KDUMP_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/kdump; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-kdump.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-kdump)
	@$(call install_fixup, ltp-kdump,PRIORITY,optional)
	@$(call install_fixup, ltp-kdump,SECTION,base)
	@$(call install_fixup, ltp-kdump,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-kdump,DESCRIPTION,missing)

	@for file in `find $(LTP_KDUMP_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-kdump, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-kdump)

	@$(call touch)

# vim: syntax=make
