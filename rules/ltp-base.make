# -*-makefile-*-
# $Id$
#
# Copyright (C) 2005 by Robert Schwebel
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
LTP_BASE_VERSION	= 20080331
LTP_BASE		= ltp-full-$(LTP_BASE_VERSION)
LTP_BASE_SUFFIX		= tgz
LTP_BASE_URL		= $(PTXCONF_SETUP_SFMIRROR)/ltp_base/$(LTP_BASE).$(LTP_BASE_SUFFIX)
LTP_BASE_SOURCE		= $(SRCDIR)/$(LTP_BASE).$(LTP_BASE_SUFFIX)
LTP_BASE_DIR		= $(BUILDDIR)/$(LTP_BASE)
LTP_BASE_BIN_DIR	= /usr/bin/ltp

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp_base_get: $(STATEDIR)/ltp_base.get

$(STATEDIR)/ltp_base.get: $(ltp_base_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LTP_BASE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LTP_BASE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp_base_extract: $(STATEDIR)/ltp_base.extract

$(STATEDIR)/ltp_base.extract: $(ltp_base_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LTP_BASE_DIR))
	@$(call extract, LTP_BASE)
	@$(call patchin, LTP_BASE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp_base_prepare: $(STATEDIR)/ltp_base.prepare

LTP_BASE_PATH	=  PATH=$(CROSS_PATH)
LTP_BASE_ENV 	=  $(CROSS_ENV) LDFLAGS="-L$(LTP_BASE_DIR)/lib"

$(STATEDIR)/ltp_base.prepare: $(ltp_base_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp_base_compile: $(STATEDIR)/ltp_base.compile

$(STATEDIR)/ltp_base.compile: $(ltp_base_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LTP_BASE_DIR); $(LTP_BASE_ENV) $(MAKE) $(PARALLELMFLAGS) libltp.a

#	CROSS_COMPILER=$(PTXDIST_WORKSPACE)/.toolchain/$(PTXCONF_COMPILER_PREFIX) \
#	make CROSS_CFLAGS="" LDFLAGS="-static -L$(LTP_BASE_DIR)/lib" \
#		LOADLIBS="-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc" \
#		$(PARALLELMFLAGS) all install

#	CROSS_COMPILER=$(PTXDIST_WORKSPACE)/.toolchain/$(PTXCONF_COMPILER_PREFIX) \
#	make CROSS_CFLAGS="" LDFLAGS="-static -L$(LTP_BASE_DIR)/lib" \
#		LOADLIBS="-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc" \
#		$(PARALLELMFLAGS) install

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp_base_install: $(STATEDIR)/ltp_base.install

$(STATEDIR)/ltp_base.install: $(ltp_base_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp_base_targetinstall: $(STATEDIR)/ltp_base.targetinstall

$(STATEDIR)/ltp_base.targetinstall: $(ltp_base_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  ltp_base)
	@$(call install_fixup, ltp_base,PACKAGE,ltp_base)
	@$(call install_fixup, ltp_base,PRIORITY,optional)
	@$(call install_fixup, ltp_base,VERSION,$(LTP_BASE_VERSION))
	@$(call install_fixup, ltp_base,SECTION,base)
	@$(call install_fixup, ltp_base,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp_base,DEPENDS,)
	@$(call install_fixup, ltp_base,DESCRIPTION,missing)

	@$(call install_finish, ltp_base)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp_base_clean:
	rm -rf $(STATEDIR)/ltp_base.*
	rm -rf $(PKGDIR)/ltp_base_*
	rm -rf $(LTP_BASE_DIR)

# vim: syntax=make
