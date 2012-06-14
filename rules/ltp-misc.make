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
PACKAGES-$(PTXCONF_LTP_MISC) += ltp-misc

#
# Paths and names
#
LTP_MISC_VERSION	:= $(LTP_BASE_VERSION)
LTP_MISC		:= ltp-misc-$(LTP_BASE_VERSION)
LTP_MISC_PKGDIR		= $(PKGDIR)/$(LTP_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-misc.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-misc.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-misc.compile:
	@$(call targetinfo)
	@cd $(LTP_BASE_DIR)/testcases/misc; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-misc.install:
	@$(call targetinfo)
	@mkdir -p $(LTP_MISC_PKGDIR)/bin
	@ln -sf $(LTP_MISC_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/misc; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-misc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-misc)
	@$(call install_fixup, ltp-misc,PRIORITY,optional)
	@$(call install_fixup, ltp-misc,SECTION,base)
	@$(call install_fixup, ltp-misc,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ltp-misc,DESCRIPTION,missing)

	@cd $(LTP_MISC_PKGDIR)/bin; \
	for file in `find -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-misc, 0, 0, $$PER, \
			$(LTP_MISC_PKGDIR)/bin/$$file, \
			$(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-misc)

	@$(call touch)

# vim: syntax=make
