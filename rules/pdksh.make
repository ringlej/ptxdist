# -*-makefile-*-
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PDKSH) += pdksh

#
# Paths and names
#
PDKSH_VERSION		:= 5.2.14
PDKSH			:= pdksh-$(PDKSH_VERSION)
PDKSH_SUFFIX		:= tar.gz
PDKSH_URL		:= ftp://ftp.cs.mun.ca/pub/pdksh/$(PDKSH).$(PDKSH_SUFFIX)
PDKSH_SOURCE		:= $(SRCDIR)/$(PDKSH).tar.gz
PDKSH_DIR		:= $(BUILDDIR)/$(PDKSH)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PDKSH_SOURCE):
	@$(call targetinfo)
	@$(call get, PDKSH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PDKSH_AUTOCONF := $(CROSS_AUTOCONF_USR)
PDKSH_AUTOCONF = \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-sanity-checks \

PDKSH_PATH	:= PATH=$(CROSS_PATH)
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

$(STATEDIR)/pdksh.prepare:
	@$(call targetinfo)
	mkdir -p $(BUILDDIR)/$(PDKSH)
	cd $(PDKSH_DIR) && \
		$(PDKSH_PATH) $(PDKSH_ENV) \
		$(PDKSH_DIR)/configure $(PDKSH_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pdksh.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pdksh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pdksh)
	@$(call install_fixup, pdksh,PACKAGE,pdksh)
	@$(call install_fixup, pdksh,PRIORITY,optional)
	@$(call install_fixup, pdksh,VERSION,$(PDKSH_VERSION))
	@$(call install_fixup, pdksh,SECTION,base)
	@$(call install_fixup, pdksh,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pdksh,DEPENDS,)
	@$(call install_fixup, pdksh,DESCRIPTION,missing)

	@$(call install_copy, pdksh, 0, 0, 0755, $(PDKSH_DIR)/ksh, /bin/ksh)

	@$(call install_finish, pdksh)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pdksh_clean:
	rm -rf $(STATEDIR)/pdksh.*
	rm -rf $(PKGDIR)/pdksh_*
	rm -rf $(PDKSH_DIR)

# vim: syntax=make
