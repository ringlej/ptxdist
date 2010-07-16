# -*-makefile-*-
#
# Copyright (C) 2006, 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBELF) += libelf

#
# Paths and names
#
LIBELF_VERSION	:= 0.8.13
LIBELF		:= libelf-$(LIBELF_VERSION)
LIBELF_SUFFIX	:= tar.gz
LIBELF_URL	:= http://www.mr511.de/software/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_SOURCE	:= $(SRCDIR)/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_DIR	:= $(BUILDDIR)/$(LIBELF)
LIBELF_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBELF_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBELF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBELF_PATH	:= PATH=$(CROSS_PATH)
LIBELF_ENV 	:= \
	$(CROSS_ENV) \
	mr_cv_target_elf=yes \
	ac_cv_func_mmap_fixed_mapped=yes \
	libelf_cv_working_memmove=yes \
	mr_cv_coffee_machine='author is a tee drinker'

LIBELF_MAKEVARS	:= instroot=$(PKGDIR)/$(LIBELF)

#
# autoconf
#
LIBELF_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-elf64

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libelf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libelf)
	@$(call install_fixup, libelf,PRIORITY,optional)
	@$(call install_fixup, libelf,SECTION,base)
	@$(call install_fixup, libelf,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libelf,DESCRIPTION,missing)

	@$(call install_copy, libelf, 0, 0, 0644, -, \
		/usr/lib/libelf.so.0.8.13)
	@$(call install_link, libelf, libelf.so.0.8.13, /usr/lib/libelf.so.0)
	@$(call install_link, libelf, libelf.so.0.8.13, /usr/lib/libelf.so)

	@$(call install_finish, libelf)

	@$(call touch)

# vim: syntax=make
