# -*-makefile-*-
#
# Copyright (C) 2008 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
# FIXME: LTP realtime tests do not compile for != x68/powerpc
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_LTP_REALTIME) += ltp-realtime
PACKAGES-$(PTXCONF_ARCH_PPC)-$(PTXCONF_LTP_REALTIME) += ltp-realtime

#
# Paths and names
#
LTP_REALTIME_VERSION	:= $(LTP_BASE_VERSION)
LTP_REALTIME		:= ltp-realtime-$(LTP_BASE_VERSION)
LTP_REALTIME_PKGDIR	= $(PKGDIR)/$(LTP_REALTIME)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-realtime.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-realtime.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-realtime.compile:
	@$(call targetinfo)
	@cd $(LTP_BASE_DIR)/testcases/realtime; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-realtime.install:
	@$(call targetinfo)
	@mkdir -p $(LTP_REALTIME_PKGDIR)/bin
	@ln -sf $(LTP_REALTIME_PKGDIR)/bin $(LTP_BASE_DIR)/testcases/bin
	@cd $(LTP_BASE_DIR)/testcases/realtime; $(LTP_ENV) $(MAKE) $(PARALLELMFLAGS) install
	@rm $(LTP_BASE_DIR)/testcases/bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp-realtime.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp-realtime)
	@$(call install_fixup, ltp-realtime,PACKAGE,ltp-realtime)
	@$(call install_fixup, ltp-realtime,PRIORITY,optional)
	@$(call install_fixup, ltp-realtime,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp-realtime,SECTION,base)
	@$(call install_fixup, ltp-realtime,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, ltp-realtime,DEPENDS,)
	@$(call install_fixup, ltp-realtime,DESCRIPTION,missing)

	@for file in `find $(LTP_REALTIME_PKGDIR)/bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp-realtime, 0, 0, $$PER, $$file, $(LTP_BASE_BIN_DIR)/$$file); \
	done


	@$(call install_finish, ltp-realtime)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp-realtime_clean:
	rm -rf $(STATEDIR)/ltp-realtime.*
	rm -rf $(PKGDIR)/ltp-realtime_*
	rm -rf $(LTP_REALTIME_DIR)

# vim: syntax=make
