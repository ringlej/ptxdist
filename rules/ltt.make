# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LTT) += ltt

#
# Paths and names 
#
LTT_VERSION		= 0.9.5
LTT			= TraceToolkit-$(LTT_VERSION)
LTT_SUFFIX		= tgz
# FIXME: beat upstream for "a" syntax...
LTT_URL			= http://www.opersys.com/ftp/pub/LTT/$(LTT)a.$(LTT_SUFFIX)
LTT_SOURCE		= $(SRCDIR)/$(LTT)a.$(LTT_SUFFIX)
LTT_DIR			= $(BUILDDIR)/$(LTT)
LTT_BUILDDIR		= $(BUILDDIR)/$(LTT)-build

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltt_get: $(STATEDIR)/ltt.get

ltt_get_deps = $(LTT_SOURCE)

$(STATEDIR)/ltt.get: $(ltt_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LTT))
	@$(call touch, $@)

$(LTT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LTT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltt_extract: $(STATEDIR)/ltt.extract

ltt_extract_deps =  $(STATEDIR)/ltt.get

$(STATEDIR)/ltt.extract: $(ltt_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LTT_DIR))
	@$(call extract, $(LTT_SOURCE))
	@$(call patchin, $(LTT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltt_prepare: $(STATEDIR)/ltt.prepare

LTT_PATH	=  PATH=$(CROSS_PATH)
LTT_ENV		=  $(CROSS_ENV)
LTT_ENV		+= ac_cv_func_setvbuf_reversed=no ltt_cv_have_mbstate_t=yes

LTT_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
LTT_AUTOCONF	+= --with-gtk=no

#
# dependencies
#
ltt_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/ltt.extract 

$(STATEDIR)/ltt.prepare: $(ltt_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LTT_BUILDDIR))
	mkdir -p $(LTT_BUILDDIR)
	cd $(LTT_BUILDDIR) && \
		$(LTT_PATH) $(LTT_ENV) \
		$(LTT_DIR)/configure $(LTT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltt_compile: $(STATEDIR)/ltt.compile

ltt_compile_deps = $(STATEDIR)/ltt.prepare

$(STATEDIR)/ltt.compile: $(STATEDIR)/ltt.prepare 
	@$(call targetinfo, $@)

	$(LTT_PATH) make -C $(LTT_BUILDDIR)/LibUserTrace UserTrace.o
	$(LTT_PATH) make -C $(LTT_BUILDDIR)/LibUserTrace LDFLAGS="-static"
	$(LTT_PATH) make -C $(LTT_BUILDDIR)/Daemon LDFLAGS="-static"

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltt_install: $(STATEDIR)/ltt.install

ltt_install_deps = \
	$(STATEDIR)/ltt.compile \
	$(STATEDIR)/xchain-ltt.compile

$(STATEDIR)/ltt.install: $(ltt_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltt_targetinstall: $(STATEDIR)/ltt.targetinstall

$(STATEDIR)/ltt.targetinstall: $(STATEDIR)/ltt.install
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,ltt)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LTT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, \
		$(LTT_BUILDDIR)/Daemon/tracedaemon, \
		/usr/sbin/tracedaemon)
	@$(call install_copy, 0, 0, 0755, \
		$(LTT_DIR)/createdev.sh, \
		/usr/sbin/tracecreatedev, n)

	@$(call install_copy, 0, 0, 0755, $(LTT_DIR)/Daemon/Scripts/trace, /usr/sbin/trace, n)
	@$(call install_copy, 0, 0, 0755, $(LTT_DIR)/Daemon/Scripts/tracecore, /usr/sbin/tracecore, n)
	@$(call install_copy, 0, 0, 0755, $(LTT_DIR)/Daemon/Scripts/tracecpuid, /usr/sbin/tracecpuid, n)
	@$(call install_copy, 0, 0, 0755, $(LTT_DIR)/Daemon/Scripts/traceu, /usr/sbin/traceu, n)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltt_clean: 
	rm -rf $(STATEDIR)/ltt.* 
	rm -rf $(IMAGEDIR)/ltt_* 
	rm -rf $(LTT_DIR)

# vim: syntax=make
