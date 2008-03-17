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
PACKAGES-$(PTXCONF_LTP) += ltp

#
# Paths and names
#
LTP_VERSION	= 20080229
LTP		= ltp-full-$(LTP_VERSION)
LTP_SUFFIX	= tgz
LTP_URL		= $(PTXCONF_SETUP_SFMIRROR)/ltp/$(LTP).$(LTP_SUFFIX)
LTP_SOURCE	= $(SRCDIR)/$(LTP).$(LTP_SUFFIX)
LTP_DIR		= $(BUILDDIR)/$(LTP)
LTP_BIN_DIR	= /usr/bin/ltp

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltp_get: $(STATEDIR)/ltp.get

$(STATEDIR)/ltp.get: $(ltp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LTP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LTP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltp_extract: $(STATEDIR)/ltp.extract

$(STATEDIR)/ltp.extract: $(ltp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LTP_DIR))
	@$(call extract, LTP)
	@$(call patchin, LTP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltp_prepare: $(STATEDIR)/ltp.prepare

LTP_PATH	=  PATH=$(CROSS_PATH)
LTP_ENV 	=  $(CROSS_ENV) LDFLAGS="-L$(LTP_DIR)/lib"

$(STATEDIR)/ltp.prepare: $(ltp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltp_compile: $(STATEDIR)/ltp.compile

$(STATEDIR)/ltp.compile: $(ltp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LTP_DIR); $(LTP_ENV) make $(PARALLELMFLAGS) libltp.a

#	CROSS_COMPILER=$(PTXDIST_WORKSPACE)/.toolchain/$(PTXCONF_COMPILER_PREFIX) \
#	make CROSS_CFLAGS="" LDFLAGS="-static -L$(LTP_DIR)/lib" \
#		LOADLIBS="-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc" \
#		$(PARALLELMFLAGS) all install

#	CROSS_COMPILER=$(PTXDIST_WORKSPACE)/.toolchain/$(PTXCONF_COMPILER_PREFIX) \
#	make CROSS_CFLAGS="" LDFLAGS="-static -L$(LTP_DIR)/lib" \
#		LOADLIBS="-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc" \
#		$(PARALLELMFLAGS) install

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltp_install: $(STATEDIR)/ltp.install

$(STATEDIR)/ltp.install: $(ltp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltp_targetinstall: $(STATEDIR)/ltp.targetinstall

$(STATEDIR)/ltp.targetinstall: $(ltp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, ltp)
	@$(call install_fixup, ltp,PACKAGE,ltp)
	@$(call install_fixup, ltp,PRIORITY,optional)
	@$(call install_fixup, ltp,VERSION,$(LTP_VERSION))
	@$(call install_fixup, ltp,SECTION,base)
	@$(call install_fixup, ltp,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ltp,DEPENDS,)
	@$(call install_fixup, ltp,DESCRIPTION,missing)

	@$(call install_finish, ltp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltp_clean:
	rm -rf $(STATEDIR)/ltp.*
	rm -rf $(IMAGEDIR)/ltp_*
	rm -rf $(LTP_DIR)

# vim: syntax=make
