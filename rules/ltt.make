# -*-makefile-*-
# $Id: ltt.make,v 1.3 2003/09/19 13:43:36 mkl Exp $
#
# (c) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# (c) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_LTT))
PACKAGES += ltt
endif

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

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltt_get: $(STATEDIR)/ltt.get

ltt_get_deps = $(LTT_SOURCE)

$(STATEDIR)/ltt.get: $(ltt_get_deps)
	@$(call targetinfo, ltt.get)
	@$(call get_patches, $(LTT))
	touch $@

$(LTT_SOURCE):
	@$(call targetinfo, ltt.get)
	@$(call get, $(LTT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltt_extract: $(STATEDIR)/ltt.extract

ltt_extract_deps =  $(STATEDIR)/ltt.get

$(STATEDIR)/ltt.extract: $(ltt_extract_deps)
	@$(call targetinfo, ltt.extract)
	@$(call clean, $(LTT_DIR))
	@$(call extract, $(LTT_SOURCE))
	@$(call patchin, $(LTT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltt_prepare: $(STATEDIR)/ltt.prepare

LTT_PATH	=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(CROSS_PATH)
LTT_ENV		=  $(CROSS_ENV)
LTT_ENV		+= ac_cv_func_setvbuf_reversed=no ltt_cv_have_mbstate_t=yes

LTT_AUTOCONF	= --disable-sanity-checks
LTT_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)

#
# dependencies
#
ltt_prepare_deps =  $(STATEDIR)/ltt.extract 
ltt_prepare_deps += $(STATEDIR)/virtual-xchain.install

$(STATEDIR)/ltt.prepare: $(ltt_prepare_deps)
	@$(call targetinfo, ltt.prepare)

	# configure without $(LTT_ENV) now, add this later;
	# visualizer has to be built for host...
	cd $(LTT_DIR) &&					\
		$(LTT_PATH)					\
		./configure $(LTT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltt_compile: $(STATEDIR)/ltt.compile

ltt_compile_deps = $(STATEDIR)/ltt.prepare

$(STATEDIR)/ltt.compile: $(STATEDIR)/ltt.prepare 
	@$(call targetinfo, ltt.compile)

#	build for target:
	make -C $(LTT_DIR)/LibUserTrace $(LTT_ENV) UserTrace.o
	make -C $(LTT_DIR)/LibUserTrace $(LTT_ENV) LDFLAGS="-static"
	make -C $(LTT_DIR)/Daemon $(LTT_ENV) LDFLAGS="-static"

#	build for host:
	make -C $(LTT_DIR)/LibLTT
	make -C $(LTT_DIR)/Visualizer

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltt_install: $(STATEDIR)/ltt.install

$(STATEDIR)/ltt.install: $(STATEDIR)/ltt.compile
	@$(call targetinfo, ltt.install)
	make -C $(LTT_DIR)/LibLTT install
	make -C $(LTT_DIR)/Visualizer install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltt_targetinstall: $(STATEDIR)/ltt.targetinstall

$(STATEDIR)/ltt.targetinstall: $(STATEDIR)/ltt.install
	@$(call targetinfo, ltt.targetinstall)
	$(CROSSSTRIP) $(LTT_DIR)/Daemon/tracedaemon
	cp $(LTT_DIR)/Daemon/tracedaemon $(ROOTDIR)/usr/sbin
	cp $(LTT_DIR)/createdev.sh $(ROOTDIR)/usr/sbin/tracecreatedev
	cp $(LTT_DIR)/Daemon/Scripts/trace* $(ROOTDIR)/usr/sbin
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltt_clean: 
	rm -rf $(STATEDIR)/ltt.* $(LTT_DIR)

# vim: syntax=make
