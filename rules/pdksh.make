# -*-makefile-*-
# $Id: pdksh.make,v 1.7 2003/07/16 04:23:28 mkl Exp $
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
ifeq (y, $(PTXCONF_PDKSH))
PACKAGES += pdksh
endif

#
# Paths and names 
#
PDKSH			= pdksh-5.2.14
PDKSH_URL		= ftp://ftp.cs.mun.ca/pub/pdksh/$(PDKSH).tar.gz 
PDKSH_SOURCE		= $(SRCDIR)/$(PDKSH).tar.gz
PDKSH_DIR		= $(BUILDDIR)/$(PDKSH)
PDKSH_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pdksh_get: $(STATEDIR)/pdksh.get

$(STATEDIR)/pdksh.get: $(PDKSH_SOURCE)
	@$(call targetinfo, pdksh.get)
	touch $@

$(PDKSH_SOURCE):
	@$(call targetinfo, $(PDKSH_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(PDKSH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pdksh_extract: $(STATEDIR)/pdksh.extract

$(STATEDIR)/pdksh.extract: $(STATEDIR)/pdksh.get
	@$(call targetinfo, pdksh.extract)
	@$(call clean, $(PDKSH_DIR))
	$(PDKSH_EXTRACT) $(PDKSH_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pdksh_prepare: $(STATEDIR)/pdksh.prepare

PDKSH_AUTOCONF	=  --build=$(GNU_HOST)
PDKSH_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
PDKSH_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)
PDKSH_AUTOCONF	+= --disable-sanity-checks
PDKSH_AUTOCONF	+= --prefix=/usr

PDKSH_PATH	=  PATH=$(CROSS_PATH)
PDKSH_ENV	=  ac_cv_sizeof_long=4 ac_cv_sizeof_int=4 ac_cv_func_mmap=yes
PDKSH_ENV	+= ksh_cv_func_memmove=yes
PDKSH_ENV	+= ksh_cv_func_times_ok=yes ksh_cv_pgrp_check=posix
PDKSH_ENV	+= ksh_cv_dup2_clexec_ok=yes
PDKSH_ENV	+= ksh_cv_dev_fd=yes ksh_cv_need_pgrp_sync=no ksh_cv_opendir_ok=yes

PDKSH_ENV	+= $(CROSS_ENV)

ifeq (y, $(PTXCONF_PDKSH_SHLIKE))
PDKSH_AUTOCONF	+= --enable-shell=sh
else
PDKSH_AUTOCONF	+= --enable-shell=ksh
endif
ifeq (y, $(PTXCONF_PDKSH_POSIX))
PDKSH_AUTOCONF	+= --enable-posixly_correct
else
PDKSH_AUTOCONF	+= --disable-posixly_correct
endif
ifeq (y, $(PTXCONF_PDKSH_VI))
PDKSH_AUTOCONF	+= --enable-vi
else
PDKSH_AUTOCONF	+= --disable-vi
endif
ifeq (y, $(PTXCONF_PDKSH_EMACS))
PDKSH_AUTOCONF	+= --enable-emacs
else
PDKSH_AUTOCONF	+= --disable-emacs
endif
ifeq (y, $(PTXCONF_PDKSH_CMDHISTORY))
PDKSH_AUTOCONF	+= --enable-history=simple
else
PDKSH_AUTOCONF	+= --disable-history
endif
ifeq (y, $(PTXCONF_PDKSH_JOBS))
PDKSH_AUTOCONF	+= --enable-jobs
else
PDKSH_AUTOCONF	+= --disable-jobs
endif
ifeq (y, $(PTXCONF_PDKSH_BRACE_EXPAND))
PDKSH_AUTOCONF	+= --enable-brace-expand
else
PDKSH_AUTOCONF	+= --disable-brace-expand
endif

#
# dependencies
#
pdksh_prepare_deps =  $(STATEDIR)/pdksh.extract 
pdksh_prepare_deps += $(STATEDIR)/virtual-xchain.install

$(STATEDIR)/pdksh.prepare: $(pdksh_prepare_deps)
	@$(call targetinfo, pdksh.prepare)
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
	@$(call targetinfo, pdksh.compile)
	$(PDKSH_PATH) make -C $(PDKSH_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pdksh_install: $(STATEDIR)/pdksh.install

$(STATEDIR)/pdksh.install: $(STATEDIR)/pdksh.compile
	@$(call targetinfo, pdksh.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pdksh_targetinstall: $(STATEDIR)/pdksh.targetinstall

$(STATEDIR)/pdksh.targetinstall: $(STATEDIR)/pdksh.install
	@$(call targetinfo, pdksh.targetinstall)
	install $(PDKSH_DIR)/ksh $(ROOTDIR)/bin
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/bin/ksh
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pdksh_clean: 
	rm -rf $(STATEDIR)/pdksh.* $(PDKSH_DIR)

# vim: syntax=make
