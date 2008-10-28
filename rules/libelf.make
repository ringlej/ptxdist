# -*-makefile-*-
# $Id: template-make 8785 2008-08-26 07:48:06Z wsa $
#
# Copyright (C) 2006, 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
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
LIBELF_VERSION	:= 0.8.10
LIBELF		:= libelf-$(LIBELF_VERSION)
LIBELF_SUFFIX	:= tar.gz
LIBELF_URL	:= http://www.mr511.de/software/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_SOURCE	:= $(SRCDIR)/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_DIR	:= $(BUILDDIR)/$(LIBELF)

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
LIBELF_MAKEVARS	:= instroot=$(SYSROOT)

#
# autoconf
#
LIBELF_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libelf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libelf)
	@$(call install_fixup, libelf,PACKAGE,libelf)
	@$(call install_fixup, libelf,PRIORITY,optional)
	@$(call install_fixup, libelf,VERSION,$(LIBELF_VERSION))
	@$(call install_fixup, libelf,SECTION,base)
	@$(call install_fixup, libelf,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libelf,DEPENDS,)
	@$(call install_fixup, libelf,DESCRIPTION,missing)

	@$(call install_copy, libelf, 0, 0, 0644, \
		$(LIBELF_DIR)/lib/libelf.so.0.8.10, /usr/lib/libelf.so.0.8.10)
	@$(call install_link, libelf, libelf.so.0.8.10, /usr/lib/libelf.so.0)
	@$(call install_link, libelf, libelf.so.0.8.10, /usr/lib/libelf.so)

	@$(call install_finish, libelf)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libelf_clean:
	rm -rf $(STATEDIR)/libelf.*
	rm -rf $(PKGDIR)/libelf_*
	rm -rf $(LIBELF_DIR)

# vim: syntax=make
