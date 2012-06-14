# -*-makefile-*-
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
BASH_MD5	:= 338dcf975a93640bb3eaa843ca42e3f8
BASH		:= bash-$(BASH_VERSION)
BASH_SUFFIX	:= tar.gz
BASH_URL	:= $(call ptx/mirror, GNU, bash/$(BASH).$(BASH_SUFFIX))
BASH_SOURCE	:= $(SRCDIR)/$(BASH).$(BASH_SUFFIX)
BASH_DIR	:= $(BUILDDIR)/$(BASH)
BASH_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BASH_PATH	:= PATH=$(CROSS_PATH)
BASH_ENV	:= $(CROSS_ENV)


BASH_AUTOCONF	:= \
	$(CROSS_AUTOCONF_ROOT) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--without-bash-malloc \
	--disable-net-redirections \
	--$(call ptx/endis, PTXCONF_BASH_SHLIKE)-minimal-config \
	--$(call ptx/endis, PTXCONF_BASH_ALIAS)-alias \
	--$(call ptx/endis, PTXCONF_BASH_ARITHMETIC_FOR)-arith-for-command \
	--$(call ptx/endis, PTXCONF_BASH_ARRAY)-array-variables \
	--$(call ptx/endis, PTXCONF_BASH_HISTORY)-bang-history \
	--$(call ptx/endis, PTXCONF_BASH_BRACE)-brace-expansion \
	--$(call ptx/endis, PTXCONF_BASH_CONDITIONAL)-cond-command \
	--$(call ptx/endis, PTXCONF_BASH_DIRSTACK)-directory-stack \
	--$(call ptx/endis, PTXCONF_BASH_EXTPATTERN)-extended-glob \
	--$(call ptx/endis, PTXCONF_BASH_HELP)-help-builtin \
	--$(call ptx/endis, PTXCONF_BASH_CMDHISTORY)-history \
	--$(call ptx/endis, PTXCONF_BASH_JOBS)-job-control \
	--$(call ptx/endis, PTXCONF_BASH_PROCSUBST)-process-substitution \
	--$(call ptx/endis, PTXCONF_BASH_COMPLETION)-progcomp \
	--$(call ptx/endis, PTXCONF_BASH_ESC)-prompt-string-decoding \
	--$(call ptx/endis, PTXCONF_BASH_EDIT)-readline \
	--$(call ptx/endis, PTXCONF_BASH_RESTRICTED)-restricted \
	--$(call ptx/endis, PTXCONF_BASH_SELECT)-select \
	--$(call ptx/endis, PTXCONF_BASH_GPROF)-profiling \
	--$(call ptx/endis, PTXCONF_BASH_STATIC)-static-link \
	--$(call ptx/endis, PTXCONF_BASH_CURSES)-curses

ifdef PTXCONF_BASH_JOBS
BASH_ENV	+= bash_cv_job_control_missing=present
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bash)
	@$(call install_fixup, bash,PRIORITY,optional)
	@$(call install_fixup, bash,SECTION,base)
	@$(call install_fixup, bash,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bash,DESCRIPTION,missing)

	@$(call install_copy, bash, 0, 0, 0755, -, /bin/bash)
ifdef PTXCONF_BUSYBOX_FEATURE_SH_IS_NONE
	@$(call install_link, bash, bash, /bin/sh)
endif

	@$(call install_finish, bash)

	@$(call touch)

# vim: syntax=make
