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
PACKAGES-$(PTXCONF_LTP_COMMANDS) += ltp-commands

#
# Paths and names
#
LTP_COMMANDS_VERSION	:= $(LTP_BASE_VERSION)
LTP_COMMANDS		:= ltp-commands-$(LTP_BASE_VERSION)
LTP_COMMANDS_PKGDIR	= $(PKGDIR)/$(LTP_COMMANDS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-commands.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-commands.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-commands.compile:
	@$(call targetinfo)
	@cd $(LTP_BASE_DIR)/testcases/commands; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-commands.install:
	@$(call targetinfo)
	@mkdir -p $(LTP_COMMANDS_PKGDIR)/bin
	@ln -sf $(LTP_COMMANDS_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/commands; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-commands.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-commands)
	@$(call install_fixup, ltp-commands,PACKAGE,ltp-commands)
	@$(call install_fixup, ltp-commands,PRIORITY,optional)
	@$(call install_fixup, ltp-commands,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-commands,SECTION,base)
	@$(call install_fixup, ltp-commands,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-commands,DEPENDS,)
	@$(call install_fixup, ltp-commands,DESCRIPTION,missing)

	@cd $(LTP_COMMANDS_PKGDIR)/bin; \
	for file in `find -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-commands, 0, 0, $$PER, \
			$(LTP_COMMANDS_PKGDIR)/bin/$$file, \
			$(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-commands)

	@$(call touch)

# vim: syntax=make
