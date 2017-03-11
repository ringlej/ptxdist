# -*-makefile-*-
#
# Copyright (C) 2006, 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2016 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
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
LIBELF_VERSION	:= 0.168
LIBELF_MD5	:= 52adfa40758d0d39e5d5c57689bf38d6
LIBELF		:= elfutils-$(LIBELF_VERSION)
LIBELF_SUFFIX	:= tar.bz2
LIBELF_URL	:= https://fedorahosted.org/releases/e/l/elfutils/$(LIBELF_VERSION)/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_SOURCE	:= $(SRCDIR)/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_DIR	:= $(BUILDDIR)/$(LIBELF)
LIBELF_LICENSE	:= (LGPL-3.0+ OR GPL-2.0+) AND GPL-3.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBELF_CONF_TOOL := autoconf
LIBELF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-zlib \
	--without-bzlib \
	--without-lzma

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libelf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libelf)
	@$(call install_fixup, libelf,PRIORITY,optional)
	@$(call install_fixup, libelf,SECTION,base)
	@$(call install_fixup, libelf,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, libelf,DESCRIPTION,missing)

	@$(call install_lib, libelf, 0, 0, 0644, libelf-$(LIBELF_VERSION))

ifdef PTXCONF_LIBELF_LIBDW
	@$(call install_lib, libelf, 0, 0, 0644, libdw-$(LIBELF_VERSION))
	@$(foreach arch, i386 sh x86_64 ia64 alpha arm aarch64 sparc ppc ppc64 \
		s390 tilegx, \
		$(call install_lib, libelf, 0, 0, 0644, \
		elfutils/libebl_$(arch)-$(LIBELF_VERSION));)
endif

ifdef PTXCONF_LIBELF_LIBASM
	@$(call install_lib, libelf, 0, 0, 0644, libasm-$(LIBELF_VERSION))
endif

ifdef PTXCONF_LIBELF_ELFSUTILS
	@$(foreach bin, addr2line ar elfcmp elfcompress elflint findtextrel \
		make-debug-archive nm objdump ranlib readelf size stack strings \
		strip unstrip, \
		$(call install_copy, libelf, 0, 0, 0755, -, \
		/usr/bin/eu-$(bin));)
endif

	@$(call install_finish, libelf)

	@$(call touch)

# vim: syntax=make
