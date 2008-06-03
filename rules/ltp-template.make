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
PACKAGES-$(PTXCONF_LTP_TEMPLATE) += ltp-template

#
# Paths and names
#
LTP_TEMPLATE_VERSION	= $(LTP_BASE_VERSION)
LTP_TEMPLATE		= ltp-template-$(LTP_BASE_VERSION)
LTP_TEMPLATE_PKGDIR	= $(PKGDIR)/$(LTP_TEMPLATE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-template_get: $(STATEDIR)/ltp-template.get

$(STATEDIR)/ltp-template.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-template_extract: $(STATEDIR)/ltp-template.extract

$(STATEDIR)/ltp-template.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-template_prepare: $(STATEDIR)/ltp-template.prepare

$(STATEDIR)/ltp-template.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-template_compile: $(STATEDIR)/ltp-template.compile

$(STATEDIR)/ltp-template.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_BASE_DIR)/testcases/template; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-template_install: $(STATEDIR)/ltp-template.install

$(STATEDIR)/ltp-template.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_TEMPLATE_PKGDIR)/bin
	@ln -sf $(LTP_TEMPLATE_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/template; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-template_targetinstall: $(STATEDIR)/ltp-template.targetinstall

$(STATEDIR)/ltp-template.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-template)
	@$(call install_fixup, ltp-template,PACKAGE,ltp-template)
	@$(call install_fixup, ltp-template,PRIORITY,optional)
	@$(call install_fixup, ltp-template,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-template,SECTION,base)
	@$(call install_fixup, ltp-template,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-template,DEPENDS,)
	@$(call install_fixup, ltp-template,DESCRIPTION,missing)

	@for file in `find $(LTP_TEMPLATE_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-template, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-template)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-template_clean:
	rm -rf $(STATEDIR)/ltp-template.*
	rm -rf $(PKGDIR)/ltp-template_*
	rm -rf $(LTP_TEMPLATE_DIR)

# vim: syntax=make
