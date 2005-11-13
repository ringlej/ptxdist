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
XCHAIN-$(PTXCONF_LTT) += xchain-ltt

XCHAIN_LTT_BUILDDIR	= $(BUILDDIR)/xchain-$(LTT)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-ltt_get: $(STATEDIR)/xchain-ltt.get

xchain-ltt_get_deps = \
	$(STATEDIR)/ltt.get

$(STATEDIR)/xchain-ltt.get: $(xchain-ltt_get_geps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-ltt_extract: $(STATEDIR)/xchain-ltt.extract

xchain-ltt_extract_deps = $(STATEDIR)/ltt.extract

$(STATEDIR)/xchain-ltt.extract: $(xchain-ltt_extract_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-ltt_prepare: $(STATEDIR)/xchain-ltt.prepare

#
# dependencies
#
xchain-ltt_prepare_deps = \
	$(STATEDIR)/xchain-ltt.extract 

XCHAIN_LTT_ENV		=  $(HOSTCC_ENV)

#
# autoconf
#
XCHAIN_LTT_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX) #--with-gtk=no

$(STATEDIR)/xchain-ltt.prepare: $(xchain-ltt_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_LTT_BUILDDIR))
	mkdir -p $(XCHAIN_LTT_BUILDDIR)
#
# the Daemon/Scripts subdir is needed by 'make install'
# the Visualizer/Scripts subdir is needed by 'make install'
# so link to from the original sources dir
#
	mkdir -p $(XCHAIN_LTT_BUILDDIR)/Daemon
	ln -s $(LTT_DIR)/Daemon/Scripts $(XCHAIN_LTT_BUILDDIR)/Daemon
	mkdir -p $(XCHAIN_LTT_BUILDDIR)/Visualizer
	ln -s $(LTT_DIR)/Daemon/Scripts $(XCHAIN_LTT_BUILDDIR)/Visualizer

	cd $(XCHAIN_LTT_BUILDDIR) && \
		$(XCHAIN_LTT_ENV) \
		$(LTT_DIR)/configure $(XCHAIN_LTT_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-ltt_compile: $(STATEDIR)/xchain-ltt.compile

xchain-ltt_compile_deps = \
	$(STATEDIR)/xchain-ltt.prepare

$(STATEDIR)/xchain-ltt.compile: $(STATEDIR)/xchain-ltt.prepare 
	@$(call targetinfo, $@)
	make -C $(XCHAIN_LTT_BUILDDIR)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-ltt_install: $(STATEDIR)/xchain-ltt.install

$(STATEDIR)/xchain-ltt.install: $(STATEDIR)/xchain-ltt.compile
	@$(call targetinfo, $@)
	make -C $(XCHAIN_LTT_BUILDDIR)/LibLTT install
	make -C $(XCHAIN_LTT_BUILDDIR)/Visualizer install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-ltt_targetinstall: $(STATEDIR)/xchain-ltt.targetinstall

$(STATEDIR)/xchain-ltt.targetinstall:
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-ltt_clean: 
	rm -rf $(STATEDIR)/xchain-ltt.* $(XCHAIN_LTT_BUILDDIR)

# vim: syntax=make
