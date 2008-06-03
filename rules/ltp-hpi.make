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
PACKAGES-$(PTXCONF_LTP_HPI) += ltp-hpi

#
# Paths and names
#
LTP_HPI_VERSION	= $(LTP_BASE_VERSION)
LTP_HPI		= ltp-hpi-$(LTP_BASE_VERSION)
LTP_HPI_PKGDIR	= $(PKGDIR)/$(LTP_HPI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-hpi_get: $(STATEDIR)/ltp-hpi.get

$(STATEDIR)/ltp-hpi.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-hpi_extract: $(STATEDIR)/ltp-hpi.extract

$(STATEDIR)/ltp-hpi.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-hpi_prepare: $(STATEDIR)/ltp-hpi.prepare

$(STATEDIR)/ltp-hpi.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-hpi_compile: $(STATEDIR)/ltp-hpi.compile

$(STATEDIR)/ltp-hpi.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_BASE_DIR)/testcases/open_hpi_testsuite; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-hpi_install: $(STATEDIR)/ltp-hpi.install

$(STATEDIR)/ltp-hpi.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_HPI_PKGDIR)/bin
	@ln -sf $(LTP_HPI_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/open_hpi_testsuite; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-hpi_targetinstall: $(STATEDIR)/ltp-hpi.targetinstall

$(STATEDIR)/ltp-hpi.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-hpi)
	@$(call install_fixup, ltp-hpi,PACKAGE,ltp-hpi)
	@$(call install_fixup, ltp-hpi,PRIORITY,optional)
	@$(call install_fixup, ltp-hpi,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-hpi,SECTION,base)
	@$(call install_fixup, ltp-hpi,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-hpi,DEPENDS,)
	@$(call install_fixup, ltp-hpi,DESCRIPTION,missing)

	@for file in `find $(LTP_HPI_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-hpi, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-hpi)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-hpi_clean:
	rm -rf $(STATEDIR)/ltp-hpi.*
	rm -rf $(PKGDIR)/ltp-hpi_*
	rm -rf $(LTP_HPI_DIR)

# vim: syntax=make
