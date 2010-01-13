# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTP_BASE) += ltp_base

#
# Paths and names
#
LTP_BASE_VERSION	:= 20090131
LTP_BASE		:= ltp-full-$(LTP_BASE_VERSION)
LTP_BASE_SUFFIX		:= tgz
LTP_BASE_URL		:= $(PTXCONF_SETUP_SFMIRROR)/ltp/$(LTP_BASE).$(LTP_BASE_SUFFIX)
LTP_BASE_SOURCE		:= $(SRCDIR)/$(LTP_BASE).$(LTP_BASE_SUFFIX)
LTP_BASE_DIR		:= $(BUILDDIR)/$(LTP_BASE)
LTP_BASE_BIN_DIR	:= /usr/bin/ltp

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LTP_BASE_SOURCE):
	@$(call targetinfo)
	@$(call get, LTP_BASE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LTP_BASE_PATH	:= PATH=$(CROSS_PATH)
LTP_BASE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LTP_BASE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ltp_base.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ltp_base)
	@$(call install_fixup, ltp_base,PACKAGE,ltp_base)
	@$(call install_fixup, ltp_base,PRIORITY,optional)
	@$(call install_fixup, ltp_base,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp_base,SECTION,base)
	@$(call install_fixup, ltp_base,AUTHOR,"Juergen Beisert@pengutronix.de")
	@$(call install_fixup, ltp_base,DEPENDS,)
	@$(call install_fixup, ltp_base,DESCRIPTION,missing)

# just a test
	@$(call install_copy, ltp_base, 0, 0, 0755, /home)
	@$(call install_copy, ltp_base, 0, 0, 0755, /home/testcases)
	@$(call install_copy, ltp_base, 0, 0, 0755, /home/testcases/bin)

# some tools are mandatory

# a useful tool to control processes that run amok (not really yet)
	$(call install_copy, ltp_base, 0, 0, 0755, \
		$(LTP_BASE_DIR)/pan/pan, \
		/usr/sbin/pan)

	@cd $(LTP_BASE_DIR)/testcases; \
	for file in `find bin -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp_base, 0, 0, $$PER, \
			$$file, \
			/home/testcases/$$file) \
	done

	@$(call install_copy, ltp_base, 0, 0, 0755, /home/testcases/bin/dumpdir)
	@cd $(LTP_BASE_DIR)/testcases; \
	for file in `find bin/dumpdir -type f`; do \
		PER=`stat -c "%a" $$file` \
		$(call install_copy, ltp_base, 0, 0, $$PER, \
			$$file, \
			/home/testcases/$$file) \
	done

	@$(call install_finish, ltp_base)

	@$(call touch)

# vim: syntax=make
