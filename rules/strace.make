# -*-makefile-*-
# $Id: strace.make,v 1.4 2003/09/18 00:37:40 mkl Exp $
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
ifdef PTXCONF_STRACE
PACKAGES += strace
endif

#
# Paths and names 
#
STRACE			= strace-4.4.98
STRACE_URL		= http://umn.dl.sourceforge.net/sourceforge/strace/$(STRACE).tar.bz2
STRACE_SOURCE		= $(SRCDIR)/$(STRACE).tar.bz2
STRACE_DIR		= $(BUILDDIR)/$(STRACE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

strace_get: $(STATEDIR)/strace.get

$(STATEDIR)/strace.get: $(STRACE_SOURCE)
	@$(call targetinfo, strace.get)
	@$(call get_patches, $(STRACE))
	touch $@

$(STRACE_SOURCE):
	@$(call targetinfo, $(STRACE_SOURCE))
	@$(call get, $(STRACE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

strace_extract: $(STATEDIR)/strace.extract

strace_extract_deps = \
	$(STATEDIR)/strace.get

$(STATEDIR)/strace.extract: $(strace_extract_deps)
	@$(call targetinfo, strace.extract)
	@$(call clean, $(STRACE_DIR))
	@$(call extract, $(STRACE_SOURCE))
	@$(call patchin, $(STRACE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

strace_prepare: $(STATEDIR)/strace.prepare

strace_prepare_deps = \
	$(STATEDIR)/strace.extract \
	$(STATEDIR)/virtual-xchain.install

STRACE_PATH	=  PATH=$(CROSS_PATH)
STRACE_ENV	=  $(CROSS_ENV)

STRACE_AUTOCONF	=  --build=$(GNU_HOST)
STRACE_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
STRACE_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)
STRACE_AUTOCONF	+= --disable-sanity-checks
STRACE_AUTOCONF	+= --prefix=/

$(STATEDIR)/strace.prepare: $(strace_prepare_deps)
	@$(call targetinfo, strace.prepare)
	cd $(STRACE_DIR) && \
		$(STRACE_PATH) $(STRACE_ENV) \
		./configure $(STRACE_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

strace_compile: $(STATEDIR)/strace.compile

$(STATEDIR)/strace.compile: $(STATEDIR)/strace.prepare 
	@$(call targetinfo, strace.compile)
	$(STRACE_PATH) $(STRACE_ENV) make -C $(STRACE_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

strace_install: $(STATEDIR)/strace.install

$(STATEDIR)/strace.install: $(STATEDIR)/strace.compile
	@$(call targetinfo, strace.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

strace_targetinstall: $(STATEDIR)/strace.targetinstall

$(STATEDIR)/strace.targetinstall: $(STATEDIR)/strace.compile
	@$(call targetinfo, strace.targetinstall)
	install -d $(ROOTDIR)/bin
	install $(STRACE_DIR)/strace $(ROOTDIR)/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/bin/strace
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

strace_clean: 
	rm -rf $(STATEDIR)/strace.* $(STRACE_DIR)

# vim: syntax=make
