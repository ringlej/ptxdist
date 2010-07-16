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
PACKAGES-$(PTXCONF_LTP_TEMPLATE) += ltp-template

#
# Paths and names
#
LTP_TEMPLATE_VERSION	:= $(LTP_BASE_VERSION)
LTP_TEMPLATE		:= ltp-template-$(LTP_BASE_VERSION)
LTP_TEMPLATE_PKGDIR	= $(PKGDIR)/$(LTP_TEMPLATE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-template.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-template.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-template.compile:
	@$(call targetinfo)
	@cd $(LTP_BASE_DIR)/testcases/template; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-template.install:
	@$(call targetinfo)
	@mkdir -p $(LTP_TEMPLATE_PKGDIR)/bin
	@ln -sf $(LTP_TEMPLATE_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/template; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-template.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-template)
	@$(call install_fixup, ltp-template,PRIORITY,optional)
	@$(call install_fixup, ltp-template,SECTION,base)
	@$(call install_fixup, ltp-template,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-template,DESCRIPTION,missing)

	@for file in `find $(LTP_TEMPLATE_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-template, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-template)

	@$(call touch)

# vim: syntax=make
