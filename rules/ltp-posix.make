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
PACKAGES-$(PTXCONF_LTP_POSIX) += ltp-posix

#
# Paths and names
#
LTP_POSIX_VERSION	= $(LTP_VERSION)
LTP_POSIX		= ltp-posix-$(LTP_VERSION)
LTP_POSIX_PKGDIR	= $(PKGDIR)/$(LTP_POSIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-posix_get: $(STATEDIR)/ltp-posix.get

$(STATEDIR)/ltp-posix.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-posix_extract: $(STATEDIR)/ltp-posix.extract

$(STATEDIR)/ltp-posix.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-posix_prepare: $(STATEDIR)/ltp-posix.prepare

$(STATEDIR)/ltp-posix.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-posix_compile: $(STATEDIR)/ltp-posix.compile

$(STATEDIR)/ltp-posix.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_DIR)/testcases/open_posix_testsuite; $(LTP_ENV) make $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-posix_install: $(STATEDIR)/ltp-posix.install

$(STATEDIR)/ltp-posix.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_POSIX_PKGDIR)/bin
	@ln -sf $(LTP_POSIX_PKGDIR)/bin $(LTP_DIR)/testcases/bin
	@cd $(LTP_DIR)/testcases/open_posix_testsuite; $(LTP_ENV) make $(PARALLELMFLAGS) install
	@rm $(LTP_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-posix_targetinstall: $(STATEDIR)/ltp-posix.targetinstall

$(STATEDIR)/ltp-posix.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-posix)
	@$(call install_fixup, ltp-posix,PACKAGE,ltp-posix)
	@$(call install_fixup, ltp-posix,PRIORITY,optional)
	@$(call install_fixup, ltp-posix,VERSION,$(LTP_VERSION))
	@$(call install_fixup, ltp-posix,SECTION,base)
	@$(call install_fixup, ltp-posix,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-posix,DEPENDS,)
	@$(call install_fixup, ltp-posix,DESCRIPTION,missing)

	@for file in `find $(LTP_POSIX_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-posix, 0, 0, $$PER, $$file, $(LTP_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-posix)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-posix_clean:
	rm -rf $(STATEDIR)/ltp-posix.*
	rm -rf $(IMAGEDIR)/ltp-posix_*
	rm -rf $(LTP_POSIX_DIR)

# vim: syntax=make
