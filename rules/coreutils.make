# -*-makefile-*-
# $Id: coreutils.make,v 1.1 2003/08/06 21:23:03 robert Exp $
#
# (c) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_COREUTILS))
PACKAGES += coreutils
endif

#
# Paths and names 
#
COREUTILS		= coreutils-5.0
COREUTILS_URL		= http://ftp.gnu.org/pub/gnu/coreutils/$(COREUTILS).tar.bz2 
COREUTILS_SOURCE	= $(SRCDIR)/$(COREUTILS).tar.bz2
COREUTILS_DIR		= $(BUILDDIR)/$(COREUTILS)
COREUTILS_EXTRACT 	= bzcat 

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

coreutils_get: $(STATEDIR)/coreutils.get

$(STATEDIR)/coreutils.get: $(COREUTILS_SOURCE)
	@$(call targetinfo, coreutils.get)
	touch $@

$(COREUTILS_SOURCE):
	@$(call targetinfo, $(COREUTILS_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(COREUTILS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

coreutils_extract: $(STATEDIR)/coreutils.extract

$(STATEDIR)/coreutils.extract: $(STATEDIR)/coreutils.get
	@$(call targetinfo, coreutils.extract)
	@$(call clean, $(COREUTILS_DIR))
	$(COREUTILS_EXTRACT) $(COREUTILS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

coreutils_prepare: $(STATEDIR)/coreutils.prepare

COREUTILS_AUTOCONF	=  --build=$(GNU_HOST)
COREUTILS_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
COREUTILS_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)

COREUTILS_PATH		=  PATH=$(CROSS_PATH)
COREUTILS_ENV		+= $(CROSS_ENV)

#ifeq (y, $(PTXCONF_COREUTILS_SHLIKE))
#COREUTILS_AUTOCONF	+= --enable-shell=sh
#else
#COREUTILS_AUTOCONF	+= --enable-shell=ksh
#endif

#
# dependencies
#
coreutils_prepare_deps =  $(STATEDIR)/coreutils.extract 
coreutils_prepare_deps += $(STATEDIR)/virtual-xchain.install

$(STATEDIR)/coreutils.prepare: $(coreutils_prepare_deps)
	@$(call targetinfo, coreutils.prepare)
	mkdir -p $(BUILDDIR)/$(COREUTILS)
	cd $(COREUTILS_DIR) && \
		$(COREUTILS_PATH) $(COREUTILS_ENV) \
		$(COREUTILS_DIR)/configure $(COREUTILS_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

coreutils_compile_deps = $(STATEDIR)/coreutils.prepare

coreutils_compile: $(STATEDIR)/coreutils.compile

$(STATEDIR)/coreutils.compile: $(STATEDIR)/coreutils.prepare 
	@$(call targetinfo, coreutils.compile)
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/lib libfetish.a
#ifeq (y, $(PTXCONF_COREUTILS_SEQ))
	$(COREUTILS_PATH) make -C $(COREUTILS_DIR)/src seq
#endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

coreutils_install: $(STATEDIR)/coreutils.install

$(STATEDIR)/coreutils.install: $(STATEDIR)/coreutils.compile
	@$(call targetinfo, coreutils.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

coreutils_targetinstall: $(STATEDIR)/coreutils.targetinstall

$(STATEDIR)/coreutils.targetinstall: $(STATEDIR)/coreutils.install
	@$(call targetinfo, coreutils.targetinstall)
	install -d $(ROOTDIR)/bin
	install $(COREUTILS_DIR)/src/seq $(ROOTDIR)/bin
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/bin/seq
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

coreutils_clean: 
	rm -rf $(STATEDIR)/coreutils.* $(COREUTILS_DIR)

# vim: syntax=make
