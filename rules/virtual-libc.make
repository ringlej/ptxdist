# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
VIRTUAL += virtual-libc

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

virtual-libc_install: $(STATEDIR)/virtual-libc.install

ifdef PTXCONF_LIBC
ifdef PTXCONF_GLIBC
virtual-libc_install_deps = $(STATEDIR)/glibc.install
endif 
ifdef PTXCONF_UCLIBC
virtual-libc_install_deps = $(STATEDIR)/uclibc.install
endif 
endif

$(STATEDIR)/virtual-libc.install: $(virtual-libc_install_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

virtual-libc_targetinstall: $(STATEDIR)/virtual-libc.targetinstall

ifdef PTXCONF_LIBC
ifdef PTXCONF_GLIBC
virtual-libc_targetinstall_deps = $(STATEDIR)/glibc.targetinstall
endif 
ifdef PTXCONF_UCLIBC
virtual-libc_targetinstall_deps = $(STATEDIR)/uclibc.targetinstall
endif 
endif

$(STATEDIR)/virtual-libc.targetinstall: $(virtual-libc_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@
