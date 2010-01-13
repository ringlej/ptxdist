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
PACKAGES-$(PTXCONF_LTP_HPI) += ltp-hpi

#
# Paths and names
#
LTP_HPI_VERSION	:= $(LTP_BASE_VERSION)
LTP_HPI		:= ltp-hpi-$(LTP_BASE_VERSION)
LTP_HPI_PKGDIR	= $(PKGDIR)/$(LTP_HPI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-hpi.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-hpi.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-hpi.compile:
	@$(call targetinfo)
	@cd $(LTP_BASE_DIR)/testcases/open_hpi_testsuite; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-hpi.install:
	@$(call targetinfo)
	@mkdir -p $(LTP_HPI_PKGDIR)/bin
	@ln -sf $(LTP_HPI_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/open_hpi_testsuite; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-hpi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-hpi)
	@$(call install_fixup, ltp-hpi,PACKAGE,ltp-hpi)
	@$(call install_fixup, ltp-hpi,PRIORITY,optional)
	@$(call install_fixup, ltp-hpi,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-hpi,SECTION,base)
	@$(call install_fixup, ltp-hpi,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-hpi,DEPENDS,)
	@$(call install_fixup, ltp-hpi,DESCRIPTION,missing)

	@for file in `find $(LTP_HPI_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-hpi, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-hpi)

	@$(call touch)

# vim: syntax=make
