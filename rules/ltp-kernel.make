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
PACKAGES-$(PTXCONF_LTP_KERNEL) += ltp-kernel

#
# Paths and names
#
LTP_KERNEL_VERSION	= $(LTP_VERSION)
LTP_KERNEL		= ltp-kernel-$(LTP_VERSION)
LTP_KERNEL_PKGDIR	= $(PKGDIR)/$(LTP_KERNEL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp-kernel_get: $(STATEDIR)/ltp-kernel.get

$(STATEDIR)/ltp-kernel.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp-kernel_extract: $(STATEDIR)/ltp-kernel.extract

$(STATEDIR)/ltp-kernel.extract:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp-kernel_prepare: $(STATEDIR)/ltp-kernel.prepare

$(STATEDIR)/ltp-kernel.prepare:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp-kernel_compile: $(STATEDIR)/ltp-kernel.compile

$(STATEDIR)/ltp-kernel.compile:
	@$(call targetinfo, $@)
	@cd $(LTP_DIR)/testcases/kernel; $(LTP_ENV) make $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp-kernel_install: $(STATEDIR)/ltp-kernel.install

$(STATEDIR)/ltp-kernel.install:
	@$(call targetinfo, $@)
	@mkdir -p $(LTP_KERNEL_PKGDIR)/bin
	@ln -sf $(LTP_KERNEL_PKGDIR)/bin $(LTP_DIR)/testcases/bin
	@cd $(LTP_DIR)/testcases/kernel; $(LTP_ENV) make $(PARALLELMFLAGS) install
	@rm $(LTP_DIR)/testcases/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp-kernel_targetinstall: $(STATEDIR)/ltp-kernel.targetinstall

$(STATEDIR)/ltp-kernel.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, ltp-kernel)
	@$(call install_fixup, ltp-kernel,PACKAGE,ltp-kernel)
	@$(call install_fixup, ltp-kernel,PRIORITY,optional)
	@$(call install_fixup, ltp-kernel,VERSION,$(LTP_VERSION))
	@$(call install_fixup, ltp-kernel,SECTION,base)
	@$(call install_fixup, ltp-kernel,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp-kernel,DEPENDS,)
	@$(call install_fixup, ltp-kernel,DESCRIPTION,missing)

	@for file in `find $(LTP_KERNEL_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-kernel, 0, 0, $$PER, $$file, $(LTP_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-kernel)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-kernel_clean:
	rm -rf $(STATEDIR)/ltp-kernel.*
	rm -rf $(IMAGEDIR)/ltp-kernel_*
	rm -rf $(LTP_KERNEL_DIR)

# vim: syntax=make
