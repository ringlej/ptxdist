# -*-makefile-*-
# $Id: pdksh.make,v 1.4 2003/07/08 08:38:25 robert Exp $
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
	touch $@

$(PDKSH_SOURCE):
	wget -P $(SRCDIR) $(PASSIVEFTP) $(PDKSH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pdksh_extract: $(STATEDIR)/pdksh.extract

$(STATEDIR)/pdksh.extract: $(STATEDIR)/pdksh.get
	@$(call targetinfo, pdksh.extract)
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
PDKSH_AUTOCONF	+= --prefix=$(ROOTDIR)
PDKSH_ENVIRONMENT=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(PTXCONF_PREFIX)/bin:$$PATH
PDKSH_ENVIRONMENT+= ac_cv_func_setvbuf_reversed=no pdksh_cv_have_mbstate_t=yes
PDKSH_MAKEVARS	=  AR=$(PTXCONF_GNU_TARGET)-ar
PDKSH_MAKEVARS	+= RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
PDKSH_MAKEVARS	+= CC=$(PTXCONF_GNU_TARGET)-gcc
PDKSH_MAKEVARS	+= "CFLAGS=-Os -fomit-frame-pointer -fstrict-aliasing"

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
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
pdksh_prepare_deps += $(STATEDIR)/xchain-gccstage2.install
endif


$(STATEDIR)/pdksh.prepare: $(pdksh_prepare_deps)
	@$(call targetinfo, pdksh.prepare)
	mkdir -p $(BUILDDIR)/$(PDKSH)
	cd $(BUILDDIR)/$(PDKSH) &&					\
		$(PDKSH_ENVIRONMENT)					\
		$(PDKSH_DIR)/configure $(PDKSH_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pdksh_compile_deps = $(STATEDIR)/pdksh.prepare
ifeq (y, $(PTXCONF_GLIBC))
pdksh_compile_deps += $(STATEDIR)/glibc.install
endif
ifeq (y, $(PTXCONF_UCLIBC))
pdksh_compile_deps += $(STATEDIR)/uclibc.install
endif

pdksh_compile: $(STATEDIR)/pdksh.compile

$(STATEDIR)/pdksh.compile: $(STATEDIR)/pdksh.prepare 
	@$(call targetinfo, pdksh.compile)
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(PDKSH_DIR) $(PDKSH_MAKEVARS) $(MAKEPARMS)
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
	$(CROSSSTRIP) -S $(PDKSH_DIR)/ksh
	cp $(PDKSH_DIR)/ksh $(ROOTDIR)/bin
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pdksh_clean: 
	rm -rf $(STATEDIR)/pdksh.* $(PDKSH_DIR)

# vim: syntax=make
