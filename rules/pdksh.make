# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_PDKSH
PACKAGES += pdksh
endif

#
# Paths and names 
#
PDKSK_VERSION		= 5.2.14
PDKSH			= pdksh-$(PDKSK_VERSION)
PDKSH_URL		= ftp://ftp.cs.mun.ca/pub/pdksh/$(PDKSH).tar.gz 
PDKSH_SOURCE		= $(SRCDIR)/$(PDKSH).tar.gz
PDKSH_DIR		= $(BUILDDIR)/$(PDKSH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pdksh_get: $(STATEDIR)/pdksh.get

$(STATEDIR)/pdksh.get: $(PDKSH_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(PDKSH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PDKSH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pdksh_extract: $(STATEDIR)/pdksh.extract

$(STATEDIR)/pdksh.extract: $(STATEDIR)/pdksh.get
	@$(call targetinfo, $@)
	@$(call clean, $(PDKSH_DIR))
	@$(call extract, $(PDKSH_SOURCE))
	@$(call patchin, $(PDKSH))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pdksh_prepare: $(STATEDIR)/pdksh.prepare

PDKSH_AUTOCONF =  $(CROSS_AUTOCONF)
PDKSH_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-sanity-checks \
	--prefix=/usr

PDKSH_PATH	=  PATH=$(CROSS_PATH)
PDKSH_ENV = \
	$(CROSS_ENV) \
	ac_cv_sizeof_long=4 \
	ac_cv_sizeof_int=4 \
	ac_cv_func_mmap=yes \
	ksh_cv_func_memmove=yes \
	ksh_cv_func_times_ok=yes \
	ksh_cv_pgrp_check=posix \
	ksh_cv_dup2_clexec_ok=yes \
	ksh_cv_dev_fd=yes \
	ksh_cv_need_pgrp_sync=no \
	ksh_cv_opendir_ok=yes

ifdef PTXCONF_PDKSH_SHLIKE
PDKSH_AUTOCONF	+= --enable-shell=sh
else
PDKSH_AUTOCONF	+= --enable-shell=ksh
endif

ifdef PTXCONF_PDKSH_POSIX
PDKSH_AUTOCONF	+= --enable-posixly_correct
else
PDKSH_AUTOCONF	+= --disable-posixly_correct
endif

ifdef PTXCONF_PDKSH_VI
PDKSH_AUTOCONF	+= --enable-vi
else
PDKSH_AUTOCONF	+= --disable-vi
endif

ifdef PTXCONF_PDKSH_EMACS
PDKSH_AUTOCONF	+= --enable-emacs
else
PDKSH_AUTOCONF	+= --disable-emacs
endif

ifdef PTXCONF_PDKSH_CMDHISTORY
PDKSH_AUTOCONF	+= --enable-history=simple
else
PDKSH_AUTOCONF	+= --disable-history
endif

ifdef PTXCONF_PDKSH_JOBS
PDKSH_AUTOCONF	+= --enable-jobs
else
PDKSH_AUTOCONF	+= --disable-jobs
endif

ifdef PTXCONF_PDKSH_BRACE_EXPAND
PDKSH_AUTOCONF	+= --enable-brace-expand
else
PDKSH_AUTOCONF	+= --disable-brace-expand
endif

#
# dependencies
#
pdksh_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	 $(STATEDIR)/pdksh.extract 

$(STATEDIR)/pdksh.prepare: $(pdksh_prepare_deps)
	@$(call targetinfo, $@)
	mkdir -p $(BUILDDIR)/$(PDKSH)
	cd $(PDKSH_DIR) && \
		$(PDKSH_PATH) $(PDKSH_ENV) \
		$(PDKSH_DIR)/configure $(PDKSH_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pdksh_compile_deps = $(STATEDIR)/pdksh.prepare

pdksh_compile: $(STATEDIR)/pdksh.compile

$(STATEDIR)/pdksh.compile: $(STATEDIR)/pdksh.prepare 
	@$(call targetinfo, $@)
	cd $(PDKSH_DIR) && $(PDKSH_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pdksh_install: $(STATEDIR)/pdksh.install

$(STATEDIR)/pdksh.install: $(STATEDIR)/pdksh.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pdksh_targetinstall: $(STATEDIR)/pdksh.targetinstall

$(STATEDIR)/pdksh.targetinstall: $(STATEDIR)/pdksh.install
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,pdksh)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PDKSH_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(PDKSH_DIR)/ksh, /bin/ksh)
	
	@$(call install_finish)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pdksh_clean: 
	rm -rf $(STATEDIR)/pdksh.* 
	rm -rf $(IMAGEDIR)/pdksh_* 
	rm -rf $(PDKSH_DIR)

# vim: syntax=make
