# -*-makefile-*-
# $Id: template-make 7759 2008-02-12 21:05:07Z mkl $
#
# Copyright (C) 2008 by 
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
LTP_COMMANDS_VERSION	= $(LTP_BASE_VERSION)
LTP_COMMANDS		= ltp-commands-$(LTP_BASE_VERSION)
LTP_COMMANDS_PKGDIR	= $(PKGDIR)/$(LTP_COMMANDS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-commands_get: $(STATEDIR)/ltp-commands.get

$(STATEDIR)/ltp-commands.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-commands_extract: $(STATEDIR)/ltp-commands.extract

$(STATEDIR)/ltp-commands.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-commands_prepare: $(STATEDIR)/ltp-commands.prepare

$(STATEDIR)/ltp-commands.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-commands_compile: $(STATEDIR)/ltp-commands.compile

$(STATEDIR)/ltp-commands.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_BASE_DIR)/testcases/commands; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-commands_install: $(STATEDIR)/ltp-commands.install

$(STATEDIR)/ltp-commands.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_COMMANDS_PKGDIR)/bin
	@ln -sf $(LTP_COMMANDS_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/commands; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-commands_targetinstall: $(STATEDIR)/ltp-commands.targetinstall

$(STATEDIR)/ltp-commands.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-commands)
	@$(call install_fixup, ltp-commands,PACKAGE,ltp-commands)
	@$(call install_fixup, ltp-commands,PRIORITY,optional)
	@$(call install_fixup, ltp-commands,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-commands,SECTION,base)
	@$(call install_fixup, ltp-commands,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
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

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-commands_clean:
	rm -rf $(STATEDIR)/ltp-commands.*
	rm -rf $(PKGDIR)/ltp-commands_*
	rm -rf $(LTP_COMMANDS_DIR)

# vim: syntax=make
