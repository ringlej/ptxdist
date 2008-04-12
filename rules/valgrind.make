# -*-makefile-*-
# $Id: valgrind.make $
#
# Copyright (C) 2005 by Shahar Livne <shahar@livnex.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_ARCH_X86
PACKAGES-$(PTXCONF_VALGRIND) += valgrind
endif

#
# Paths and names
#
VALGRIND_VERSION	= 3.1.1
VALGRIND		= valgrind-$(VALGRIND_VERSION)
VALGRIND_SUFFIX		= tar.bz2
VALGRIND_URL		= http://site.n.ml.org/download/20060517103526/valgrind/$(VALGRIND).$(VALGRIND_SUFFIX)
VALGRIND_SOURCE		= $(SRCDIR)/$(VALGRIND).$(VALGRIND_SUFFIX)
VALGRIND_DIR		= $(BUILDDIR)/$(VALGRIND)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

valgrind_get: $(STATEDIR)/valgrind.get

$(STATEDIR)/valgrind.get: $(valgrind_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(VALGRIND_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, VALGRIND)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

valgrind_extract: $(STATEDIR)/valgrind.extract

$(STATEDIR)/valgrind.extract: $(valgrind_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(VALGRIND_DIR))
	@$(call extract, VALGRIND)
	@$(call patchin, VALGRIND)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

valgrind_prepare: $(STATEDIR)/valgrind.prepare


VALGRIND_PATH	=  PATH=$(CROSS_PATH)
VALGRIND_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
VALGRIND_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--enable-tls

$(STATEDIR)/valgrind.prepare: $(valgrind_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(VALGRIND_DIR)/config.cache)
	cd $(VALGRIND_DIR) && \
		$(VALGRIND_PATH) $(VALGRIND_ENV) \
		./configure $(VALGRIND_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

valgrind_compile: $(STATEDIR)/valgrind.compile

$(STATEDIR)/valgrind.compile: $(valgrind_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(VALGRIND_DIR) && $(VALGRIND_ENV) $(VALGRIND_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

valgrind_install: $(STATEDIR)/valgrind.install

$(STATEDIR)/valgrind.install: $(valgrind_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, VALGRIND)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

valgrind_targetinstall: $(STATEDIR)/valgrind.targetinstall

$(STATEDIR)/valgrind.targetinstall: $(valgrind_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, valgrind)
	@$(call install_fixup, valgrind,PACKAGE,valgrind)
	@$(call install_fixup, valgrind,PRIORITY,optional)
	@$(call install_fixup, valgrind,VERSION,$(VALGRIND_VERSION))
	@$(call install_fixup, valgrind,SECTION,base)
	@$(call install_fixup, valgrind,AUTHOR,"Shahar Livne <shahar\@livnex.com>")
	@$(call install_fixup, valgrind,DEPENDS,)
	@$(call install_fixup, valgrind,DESCRIPTION,missing)

	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/coregrind/valgrind, /usr/bin/valgrind)

	@$(call install_copy, valgrind, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/default.supp, /usr/lib/valgrind/default.supp)
	@$(call install_copy, valgrind, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/glibc-2.3.supp, /usr/lib/valgrind/glibc-2.3.supp)
	@$(call install_copy, valgrind, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/glibc-2.2.supp, /usr/lib/valgrind/glibc-2.2.supp)
	@$(call install_copy, valgrind, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/glibc-2.4.supp, /usr/lib/valgrind/glibc-2.4.supp)
	@$(call install_copy, valgrind, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/xfree-4.supp, /usr/lib/valgrind/xfree-4.supp)
	@$(call install_copy, valgrind, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/xfree-3.supp, /usr/lib/valgrind/xfree-3.supp)

	@$(call install_copy, valgrind, 0, 0, 0644, $(VALGRIND_DIR)/.in_place/hp2ps, /usr/lib/valgrind/hp2ps)

	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/cachegrind, /usr/lib/valgrind/x86-linux/cachegrind)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/helgrind, /usr/lib/valgrind/x86-linux/helgrind)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/lackey, /usr/lib/valgrind/x86-linux/lackey)

	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/coregrind/libcoregrind_x86_linux.a, /usr/lib/valgrind/x86-linux/libcoregrind.a)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/VEX/libvex_x86_linux.a, /usr/lib/valgrind/x86-linux/libvex.a)

	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/massif, /usr/lib/valgrind/x86-linux/massif)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/memcheck, /usr/lib/valgrind/x86-linux/memcheck)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/none, /usr/lib/valgrind/x86-linux/none)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/vgpreload_core.so, /usr/lib/valgrind/x86-linux/vgpreload_core.so)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/vgpreload_helgrind.so, /usr/lib/valgrind/x86-linux/vgpreload_helgrind.so)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/vgpreload_massif.so, /usr/lib/valgrind/x86-linux/vgpreload_massif.so)
	@$(call install_copy, valgrind, 0, 0, 0755, $(VALGRIND_DIR)/.in_place/x86-linux/vgpreload_memcheck.so, /usr/lib/valgrind/x86-linux/vgpreload_memcheck.so)

	@$(call install_finish, valgrind)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

valgrind_clean:
	rm -rf $(STATEDIR)/valgrind.*
	rm -rf $(IMAGEDIR)/valgrind_*
	rm -rf $(VALGRIND_DIR)

# vim: syntax=make
