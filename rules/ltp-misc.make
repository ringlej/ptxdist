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
PACKAGES-$(PTXCONF_LTP_MISC) += ltp-misc

#
# Paths and names
#
LTP_MISC_VERSION	= $(LTP_BASE_VERSION)
LTP_MISC		= ltp-misc-$(LTP_BASE_VERSION)
LTP_MISC_PKGDIR		= $(PKGDIR)/$(LTP_MISC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-misc_get: $(STATEDIR)/ltp-misc.get

$(STATEDIR)/ltp-misc.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-misc_extract: $(STATEDIR)/ltp-misc.extract

$(STATEDIR)/ltp-misc.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-misc_prepare: $(STATEDIR)/ltp-misc.prepare

$(STATEDIR)/ltp-misc.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-misc_compile: $(STATEDIR)/ltp-misc.compile

$(STATEDIR)/ltp-misc.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_BASE_DIR)/testcases/misc; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-misc_install: $(STATEDIR)/ltp-misc.install

$(STATEDIR)/ltp-misc.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_MISC_PKGDIR)/bin
	@ln -sf $(LTP_MISC_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/misc; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-misc_targetinstall: $(STATEDIR)/ltp-misc.targetinstall

$(STATEDIR)/ltp-misc.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-misc)
	@$(call install_fixup, ltp-misc,PACKAGE,ltp-misc)
	@$(call install_fixup, ltp-misc,PRIORITY,optional)
	@$(call install_fixup, ltp-misc,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-misc,SECTION,base)
	@$(call install_fixup, ltp-misc,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-misc,DEPENDS,)
	@$(call install_fixup, ltp-misc,DESCRIPTION,missing)

	@cd $(LTP_MISC_PKGDIR)/bin; \
	for file in `find -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-misc, 0, 0, $$PER, \
			$(LTP_MISC_PKGDIR)/bin/$$file, \
			$(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-misc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-misc_clean:
	rm -rf $(STATEDIR)/ltp-misc.*
	rm -rf $(PKGDIR)/ltp-misc_*
	rm -rf $(LTP_MISC_DIR)

# vim: syntax=make
