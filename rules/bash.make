# -*-makefile-*-
# $Id: bash.make,v 1.3 2003/06/16 12:05:16 bsp Exp $
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
ifeq (y, $(PTXCONF_BASH))
PACKAGES += bash
endif

#
# Paths and names 
#
BASH			= bash-2.05b
BASH_URL		= ftp://ftp.gnu.org/pub/gnu/bash/$(BASH).tar.gz 
BASH_SOURCE		= $(SRCDIR)/$(BASH).tar.gz
BASH_DIR		= $(BUILDDIR)/$(BASH)
BASH_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bash_get: $(STATEDIR)/bash.get

$(STATEDIR)/bash.get: $(BASH_SOURCE)
	touch $@

$(BASH_SOURCE):
	@$(call targetinfo, bash.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(BASH_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bash_extract: $(STATEDIR)/bash.extract

$(STATEDIR)/bash.extract: $(STATEDIR)/bash.get
	@$(call targetinfo, bash.extract)
	$(BASH_EXTRACT) $(BASH_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bash_prepare: $(STATEDIR)/bash.prepare

BASH_AUTOCONF	=  --build=$(GNU_HOST)
BASH_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
BASH_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)
BASH_AUTOCONF	+= --disable-sanity-checks
BASH_AUTOCONF	+= --prefix=$(PTXCONF_PREFIX)
BASH_ENVIRONMENT=  PATH=$(PTXCONF_PREFIX)/$(AUTOCONF213)/bin:$(PTXCONF_PREFIX)/bin:$$PATH
BASH_ENVIRONMENT+= ac_cv_func_setvbuf_reversed=no bash_cv_have_mbstate_t=yes
BASH_MAKEVARS	=  AR=$(PTXCONF_GNU_TARGET)-ar
BASH_MAKEVARS	+= RANLIB=$(PTXCONF_GNU_TARGET)-ranlib
BASH_MAKEVARS	+= CC=$(PTXCONF_GNU_TARGET)-gcc

# FIXME: "disable" does not compile with bash-2.05b (at least not on ARM)
BASH_AUTOCONF	+= --enable-dparen-arithmetic

ifeq (y, $(PTXCONF_BASH_SHLIKE))
# FIXME: "enable" does not compile with bash-2.05b (at least not on ARM)
#BASH_AUTOCONF	+= --enable-minimal-config
BASH_AUTOCONF	+= --disable-minimal-config
else
BASH_AUTOCONF	+= --disable-minimal-config
endif
ifeq (y, $(PTXCONF_BASH_ALIASES))
BASH_AUTOCONF	+= --enable-alias
else
# FIXME: "disable" does not compile with bash-2.05b (at least not on ARM)
#BASH_AUTOCONF	+= --disable-alias
BASH_AUTOCONF	+= --enable-alias
endif
ifeq (y, $(PTXCONF_BASH_ARITHMETIC_FOR))
BASH_AUTOCONF	+= --enable-arith-for-command
else
# FIXME: "disable" does not compile with bash-2.05b (at least not on ARM)
#BASH_AUTOCONF	+= --disable-arith-for-command
BASH_AUTOCONF	+= --enable-arith-for-command
endif
ifeq (y, $(PTXCONF_BASH_ARRAY))
BASH_AUTOCONF	+= --enable-array-variables
else
BASH_AUTOCONF	+= --disable-array-variables
endif
ifeq (y, $(PTXCONF_BASH_HISTORY))
BASH_AUTOCONF	+= --enable-bang-history
else
BASH_AUTOCONF	+= --disable-bang-history
endif
ifeq (y, $(PTXCONF_BASH_BRACE))
BASH_AUTOCONF	+= --enable-brace-expansion
else
BASH_AUTOCONF	+= --disable-brace-expansion
endif
ifeq (y, $(PTXCONF_BASH_CONDITIONAL))
BASH_AUTOCONF	+= --enable-cond-command
else
# FIXME: "disable" does not compile with bash-2.05b (at least not on ARM)
# BASH_AUTOCONF	+= --disable-cond-command
BASH_AUTOCONF	+= --enable-cond-command
endif
ifeq (y, $(PTXCONF_BASH_DIRSTACK))
BASH_AUTOCONF	+= --enable-directory-stack
else
BASH_AUTOCONF	+= --disable-directory-stack
endif
ifeq (y, $(PTXCONF_BASH_EXTPATTERN))
BASH_AUTOCONF	+= --enable-extended-glob
else
# FIXME: "disable" does not compile with bash-2.05b (at least not on ARM)
#BASH_AUTOCONF	+= --disable-extended-glob
BASH_AUTOCONF	+= --enable-extended-glob
endif
ifeq (y, $(PTXCONF_BASH_HELP))
BASH_AUTOCONF	+= --enable-help-builtin
else
BASH_AUTOCONF	+= --disable-help-builtin
endif
ifeq (y, $(PTXCONF_BASH_CMDHISTORY))
BASH_AUTOCONF	+= --enable-history
else
BASH_AUTOCONF	+= --disable-history
endif
ifeq (y, $(PTXCONF_BASH_JOBS))
BASH_AUTOCONF	+= --enable-job-control
else
BASH_AUTOCONF	+= --disable-job-control
endif
ifeq (y, $(PTXCONF_BASH_LARGEFILES))
BASH_AUTOCONF	+= --enable-largefile
else
BASH_AUTOCONF	+= --disable-largefile
endif
ifeq (y, $(PTXCONF_BASH_PROCSUBST))
BASH_AUTOCONF	+= --enable-process-substitution
else
BASH_AUTOCONF	+= --disable-process-substitution
endif
ifeq (y, $(PTXCONF_BASH_COMPLETION))
BASH_AUTOCONF	+= --enable-progcomp
else
BASH_AUTOCONF	+= --disable-progcomp
endif
ifeq (y, $(PTXCONF_BASH_ESC))
BASH_AUTOCONF	+= --enable-prompt-string-decoding
else
BASH_AUTOCONF	+= --disable-prompt-string-decoding
endif

# these options are currently untested...

ifeq (y, $(PTXCONF_BASH_EDIT))
BASH_AUTOCONF	+= --enable-readline
else
BASH_AUTOCONF	+= --disable-readline
endif
ifeq (y, $(PTXCONF_BASH_RESTRICTED))
BASH_AUTOCONF	+= --enable-restricted
else
BASH_AUTOCONF	+= --disable-restricted
endif
ifeq (y, $(PTXCONF_BASH_SELECT))
BASH_AUTOCONF	+= --enable-select
else
BASH_AUTOCONF	+= --disable-select
endif
ifeq (y, $(PTXCONF_BASH_GPROF))
BASH_AUTOCONF	+= --enable-profiling
else
BASH_AUTOCONF	+= --disable-profiling
endif
ifeq (y, $(PTXCONF_BASH_STATIC))
BASH_AUTOCONF	+= --enable-static-link
else
BASH_AUTOCONF	+= --disable-static-link
endif

#
# dependencies
#
bash_prepare_deps =  $(STATEDIR)/bash.extract 
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
bash_prepare_deps += $(STATEDIR)/xchain-gccstage2.install
endif


$(STATEDIR)/bash.prepare: $(bash_prepare_deps)
	@$(call targetinfo, bash.prepare)
	mkdir -p $(BUILDDIR)/$(BASH)
	cd $(BUILDDIR)/$(BASH) &&					\
		$(BASH_ENVIRONMENT)					\
		$(BASH_DIR)/configure $(BASH_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bash_compile: $(STATEDIR)/bash.compile

$(STATEDIR)/bash.compile: $(STATEDIR)/bash.prepare 
	@$(call targetinfo, bash.compile)
	make -C $(BASH_DIR) $(MAKEPARMS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bash_install: $(STATEDIR)/bash.install

$(STATEDIR)/bash.install: $(STATEDIR)/bash.compile
	@$(call targetinfo, bash.install)
	make -C $(BASH_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bash_targetinstall: $(STATEDIR)/bash.targetinstall

$(STATEDIR)/bash.targetinstall: $(STATEDIR)/bash.install
	@$(call targetinfo, bash.targetinstall)
	# don't forget to $(CROSSSTRIP) -S your source!
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bash_clean: 
	rm -rf $(STATEDIR)/bash.* $(BASH_DIR)

# vim: syntax=make
