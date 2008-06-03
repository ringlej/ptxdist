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
PACKAGES-$(PTXCONF_LTP_BALLISTA) += ltp-ballista

#
# Paths and names
#
LTP_BALLISTA_VERSION	= $(LTP_BASE_VERSION)
LTP_BALLISTA		= ltp-ballista-$(LTP_BASE_VERSION)
LTP_BALLISTA_PKGDIR	= $(PKGDIR)/$(LTP_BALLISTA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-ballista_get: $(STATEDIR)/ltp-ballista.get

$(STATEDIR)/ltp-ballista.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-ballista_extract: $(STATEDIR)/ltp-ballista.extract

$(STATEDIR)/ltp-ballista.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-ballista_prepare: $(STATEDIR)/ltp-ballista.prepare

$(STATEDIR)/ltp-ballista.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-ballista_compile: $(STATEDIR)/ltp-ballista.compile

$(STATEDIR)/ltp-ballista.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_BASE_DIR)/testcases/ballista; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-ballista_install: $(STATEDIR)/ltp-ballista.install

$(STATEDIR)/ltp-ballista.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_BALLISTA_PKGDIR)/bin
	@ln -sf $(LTP_BALLISTA_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/ballista; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-ballista_targetinstall: $(STATEDIR)/ltp-ballista.targetinstall

$(STATEDIR)/ltp-ballista.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-ballista)
	@$(call install_fixup, ltp-ballista,PACKAGE,ltp-ballista)
	@$(call install_fixup, ltp-ballista,PRIORITY,optional)
	@$(call install_fixup, ltp-ballista,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-ballista,SECTION,base)
	@$(call install_fixup, ltp-ballista,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-ballista,DEPENDS,)
	@$(call install_fixup, ltp-ballista,DESCRIPTION,missing)

	@for file in `find $(LTP_BALLISTA_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-ballista, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-ballista)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-ballista_clean:
	rm -rf $(STATEDIR)/ltp-ballista.*
	rm -rf $(PKGDIR)/ltp-ballista_*
	rm -rf $(LTP_BALLISTA_DIR)

# vim: syntax=make
