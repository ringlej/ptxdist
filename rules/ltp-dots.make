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
PACKAGES-$(PTXCONF_LTP_DOTS) += ltp-dots

#
# Paths and names
#
LTP_DOTS_VERSION	= $(LTP_BASE_VERSION)
LTP_DOTS		= ltp-dots-$(LTP_BASE_VERSION)
LTP_DOTS_PKGDIR		= $(PKGDIR)/$(LTP_DOTS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-dots_get: $(STATEDIR)/ltp-dots.get

$(STATEDIR)/ltp-dots.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-dots_extract: $(STATEDIR)/ltp-dots.extract

$(STATEDIR)/ltp-dots.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-dots_prepare: $(STATEDIR)/ltp-dots.prepare

$(STATEDIR)/ltp-dots.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-dots_compile: $(STATEDIR)/ltp-dots.compile

$(STATEDIR)/ltp-dots.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_BASE_DIR)/testcases/DOTS; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-dots_install: $(STATEDIR)/ltp-dots.install

$(STATEDIR)/ltp-dots.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_DOTS_PKGDIR)/bin
	@ln -sf $(LTP_DOTS_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/DOTS; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-dots_targetinstall: $(STATEDIR)/ltp-dots.targetinstall

$(STATEDIR)/ltp-dots.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-dots)
	@$(call install_fixup, ltp-dots,PACKAGE,ltp-dots)
	@$(call install_fixup, ltp-dots,PRIORITY,optional)
	@$(call install_fixup, ltp-dots,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-dots,SECTION,base)
	@$(call install_fixup, ltp-dots,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-dots,DEPENDS,)
	@$(call install_fixup, ltp-dots,DESCRIPTION,missing)

	@for file in `find $(LTP_DOTS_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-dots, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-dots)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-dots_clean:
	rm -rf $(STATEDIR)/ltp-dots.*
	rm -rf $(PKGDIR)/ltp-dots_*
	rm -rf $(LTP_DOTS_DIR)

# vim: syntax=make
