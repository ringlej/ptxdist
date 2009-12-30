# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2009 by Pengutronix e.K., Hildesheim, Germany
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
BASH_VERSION	:= 3.2.48
BASH		:= bash-$(BASH_VERSION)
BASH_SUFFIX	:= tar.gz
BASH_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/bash/$(BASH).$(BASH_SUFFIX)
BASH_SOURCE	:= $(SRCDIR)/$(BASH).$(BASH_SUFFIX)
BASH_DIR	:= $(BUILDDIR)/$(BASH)
BASH_MAKE_PAR	:= NO


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BASH_SOURCE):
	@$(call targetinfo)
	@$(call get, BASH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BASH_PATH	:= PATH=$(CROSS_PATH)
BASH_ENV	:= $(CROSS_ENV)


BASH_AUTOCONF	:= \
	$(CROSS_AUTOCONF_ROOT) \
	--without-bash-malloc \
	--disable-net-redirections

ifdef PTXCONF_BASH_SHLIKE
BASH_AUTOCONF	+= --enable-minimal-config
else
BASH_AUTOCONF	+= --disable-minimal-config
endif

ifdef PTXCONF_BASH_ALIASES
BASH_AUTOCONF	+= --enable-alias
else
BASH_AUTOCONF	+= --disable-alias
endif

ifdef PTXCONF_BASH_ARITHMETIC_FOR
BASH_AUTOCONF	+= --enable-arith-for-command
else
BASH_AUTOCONF	+= --disable-arith-for-command
endif

ifdef PTXCONF_BASH_ARRAY
BASH_AUTOCONF	+= --enable-array-variables
else
BASH_AUTOCONF	+= --disable-array-variables
endif

ifdef PTXCONF_BASH_HISTORY
BASH_AUTOCONF	+= --enable-bang-history
else
BASH_AUTOCONF	+= --disable-bang-history
endif

ifdef PTXCONF_BASH_BRACE
BASH_AUTOCONF	+= --enable-brace-expansion
else
BASH_AUTOCONF	+= --disable-brace-expansion
endif

ifdef PTXCONF_BASH_CONDITIONAL
BASH_AUTOCONF	+= --enable-cond-command
else
BASH_AUTOCONF	+= --disable-cond-command
endif

ifdef PTXCONF_BASH_DIRSTACK
BASH_AUTOCONF	+= --enable-directory-stack
else
BASH_AUTOCONF	+= --disable-directory-stack
endif

ifdef PTXCONF_BASH_EXTPATTERN
BASH_AUTOCONF	+= --enable-extended-glob
else
BASH_AUTOCONF	+= --disable-extended-glob
endif

ifdef PTXCONF_BASH_HELP
BASH_AUTOCONF	+= --enable-help-builtin
else
BASH_AUTOCONF	+= --disable-help-builtin
endif

ifdef PTXCONF_BASH_CMDHISTORY
BASH_AUTOCONF	+= --enable-history
else
BASH_AUTOCONF	+= --disable-history
endif

ifdef PTXCONF_BASH_JOBS
BASH_ENV	+= bash_cv_job_control_missing=present
BASH_AUTOCONF	+= --enable-job-control
else
BASH_AUTOCONF	+= --disable-job-control
endif

ifdef PTXCONF_BASH_LARGEFILES
BASH_AUTOCONF	+= --enable-largefile
else
BASH_AUTOCONF	+= --disable-largefile
endif

ifdef PTXCONF_BASH_PROCSUBST
BASH_AUTOCONF	+= --enable-process-substitution
else
BASH_AUTOCONF	+= --disable-process-substitution
endif

ifdef PTXCONF_BASH_COMPLETION
BASH_AUTOCONF	+= --enable-progcomp
else
BASH_AUTOCONF	+= --disable-progcomp
endif

ifdef PTXCONF_BASH_ESC
BASH_AUTOCONF	+= --enable-prompt-string-decoding
else
BASH_AUTOCONF	+= --disable-prompt-string-decoding
endif

ifdef PTXCONF_BASH_EDIT
BASH_AUTOCONF	+= --enable-readline
else
BASH_AUTOCONF	+= --disable-readline
endif

ifdef PTXCONF_BASH_RESTRICTED
BASH_AUTOCONF	+= --enable-restricted
else
BASH_AUTOCONF	+= --disable-restricted
endif

ifdef PTXCONF_BASH_SELECT
BASH_AUTOCONF	+= --enable-select
else
BASH_AUTOCONF	+= --disable-select
endif

ifdef PTXCONF_BASH_GPROF
BASH_AUTOCONF	+= --enable-profiling
else
BASH_AUTOCONF	+= --disable-profiling
endif

ifdef PTXCONF_BASH_STATIC
BASH_AUTOCONF	+= --enable-static-link
else
BASH_AUTOCONF	+= --disable-static-link
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bash)
	@$(call install_fixup, bash,PACKAGE,bash)
	@$(call install_fixup, bash,PRIORITY,optional)
	@$(call install_fixup, bash,VERSION,$(BASH_VERSION))
	@$(call install_fixup, bash,SECTION,base)
	@$(call install_fixup, bash,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, bash,DEPENDS,)
	@$(call install_fixup, bash,DESCRIPTION,missing)

	@$(call install_copy, bash, 0, 0, 0755, -, /bin/bash)
	@$(call install_link, bash, bash, /bin/sh)

	@$(call install_finish, bash)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bash_clean:
	rm -rf $(STATEDIR)/bash.*
	rm -rf $(PKGDIR)/bash_*
	rm -fr $(BASH_DIR)

# vim: syntax=make
