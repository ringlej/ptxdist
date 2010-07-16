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
PACKAGES-$(PTXCONF_LTP_BALLISTA) += ltp-ballista

#
# Paths and names
#
LTP_BALLISTA_VERSION	:= $(LTP_BASE_VERSION)
LTP_BALLISTA		:= ltp-ballista-$(LTP_BASE_VERSION)
LTP_BALLISTA_PKGDIR	= $(PKGDIR)/$(LTP_BALLISTA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-ballista.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-ballista.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-ballista.compile:
	@$(call targetinfo)
	@cd $(LTP_BASE_DIR)/testcases/ballista; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-ballista.install:
	@$(call targetinfo)
	@mkdir -p $(LTP_BALLISTA_PKGDIR)/bin
	@ln -sf $(LTP_BALLISTA_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/ballista; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-ballista.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-ballista)
	@$(call install_fixup, ltp-ballista,PRIORITY,optional)
	@$(call install_fixup, ltp-ballista,SECTION,base)
	@$(call install_fixup, ltp-ballista,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-ballista,DESCRIPTION,missing)

	@for file in `find $(LTP_BALLISTA_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-ballista, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-ballista)

	@$(call touch)

# vim: syntax=make
