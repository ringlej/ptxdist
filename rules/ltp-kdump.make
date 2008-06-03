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
PACKAGES-$(PTXCONF_LTP_KDUMP) += ltp-kdump

#
# Paths and names
#
LTP_KDUMP_VERSION	= $(LTP_BASE_VERSION)
LTP_KDUMP		= ltp-kdump-$(LTP_BASE_VERSION)
LTP_KDUMP_PKGDIR	= $(PKGDIR)/$(LTP_KDUMP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-kdump_get: $(STATEDIR)/ltp-kdump.get

$(STATEDIR)/ltp-kdump.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-kdump_extract: $(STATEDIR)/ltp-kdump.extract

$(STATEDIR)/ltp-kdump.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-kdump_prepare: $(STATEDIR)/ltp-kdump.prepare

$(STATEDIR)/ltp-kdump.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-kdump_compile: $(STATEDIR)/ltp-kdump.compile

$(STATEDIR)/ltp-kdump.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_BASE_DIR)/testcases/kdump; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-kdump_install: $(STATEDIR)/ltp-kdump.install

$(STATEDIR)/ltp-kdump.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_KDUMP_PKGDIR)/bin
	@ln -sf $(LTP_KDUMP_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/kdump; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-kdump_targetinstall: $(STATEDIR)/ltp-kdump.targetinstall

$(STATEDIR)/ltp-kdump.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-kdump)
	@$(call install_fixup, ltp-kdump,PACKAGE,ltp-kdump)
	@$(call install_fixup, ltp-kdump,PRIORITY,optional)
	@$(call install_fixup, ltp-kdump,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-kdump,SECTION,base)
	@$(call install_fixup, ltp-kdump,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-kdump,DEPENDS,)
	@$(call install_fixup, ltp-kdump,DESCRIPTION,missing)

	@for file in `find $(LTP_KDUMP_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-kdump, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-kdump)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-kdump_clean:
	rm -rf $(STATEDIR)/ltp-kdump.*
	rm -rf $(PKGDIR)/ltp-kdump_*
	rm -rf $(LTP_KDUMP_DIR)

# vim: syntax=make
