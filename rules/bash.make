# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BASH) += bash

#
# Paths and names 
#
BASH_VERSION		= 3.1
BASH			= bash-$(BASH_VERSION)
BASH_URL		= $(PTXCONF_SETUP_GNUMIRROR)/bash/$(BASH).tar.gz 
BASH_SOURCE		= $(SRCDIR)/$(BASH).tar.gz
BASH_DIR		= $(BUILDDIR)/$(BASH)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bash_get: $(STATEDIR)/bash.get

$(STATEDIR)/bash.get: $(bash_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BASH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, BASH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bash_extract: $(STATEDIR)/bash.extract

$(STATEDIR)/bash.extract: $(bash_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean $(BASH_DIR))
	@$(call extract, BASH)
	@$(call patchin, BASH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bash_prepare: $(STATEDIR)/bash.prepare

BASH_AUTOCONF	= $(CROSS_AUTOCONF_ROOT) \
	--disable-sanity-checks
BASH_PATH	=  PATH=$(CROSS_PATH)
BASH_ENV	=  $(CROSS_ENV) \
	ac_cv_func_setvbuf_reversed=no \
	bash_cv_have_mbstate_t=yes

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

# on Linux, we always want the glibc malloc
BASH_AUTOCONF	+= --with-bash-malloc=no

$(STATEDIR)/bash.prepare: $(bash_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(BASH_DIR) && \
		$(BASH_PATH) $(BASH_ENV) \
		./configure $(BASH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bash_compile: $(STATEDIR)/bash.compile

$(STATEDIR)/bash.compile: $(bash_compile_deps_default) 
	@$(call targetinfo, $@)
	cd $(BASH_DIR) && $(BASH_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bash_install: $(STATEDIR)/bash.install

$(STATEDIR)/bash.install: $(bash_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bash_targetinstall: $(STATEDIR)/bash.targetinstall

$(STATEDIR)/bash.targetinstall: $(bash_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, bash)
	@$(call install_fixup, bash,PACKAGE,bash)
	@$(call install_fixup, bash,PRIORITY,optional)
	@$(call install_fixup, bash,VERSION,$(BASH_VERSION))
	@$(call install_fixup, bash,SECTION,base)
	@$(call install_fixup, bash,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, bash,DEPENDS,)
	@$(call install_fixup, bash,DESCRIPTION,missing)

	@$(call install_copy, bash, 0, 0, 0755, $(BASH_DIR)/bash, /bin/bash)
	@$(call install_link, bash, bash, /bin/sh)

	@$(call install_finish, bash)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bash_clean: 
	rm -rf $(STATEDIR)/bash.* 
	rm -rf $(IMAGEDIR)/bash_* 
	rm -fr $(STATEDIR)/bash-patches.get 
	rm -fr $(BASH_DIR)

# vim: syntax=make
