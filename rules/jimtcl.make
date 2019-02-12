# -*-makefile-*-
#
# Copyright (C) 2018 by Ladislav Michl <ladis@linux-mips.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JIMTCL) += jimtcl

#
# Paths and names
#
JIMTCL_VERSION	:= 0.78
JIMTCL_MD5	:= bde9021d78a77fe28e1bbc423142ab23
JIMTCL		:= jimtcl-$(JIMTCL_VERSION)
JIMTCL_SUFFIX	:= tar.xz
JIMTCL_URL	:= http://repo.or.cz/jimtcl.git;tag=$(JIMTCL_VERSION)
JIMTCL_SOURCE	:= $(SRCDIR)/$(JIMTCL).$(JIMTCL_SUFFIX)
JIMTCL_DIR	:= $(BUILDDIR)/$(JIMTCL)
JIMTCL_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# Package is not using autoconf but autosetup which is enough compatible...
#
JIMTCL_CONF_TOOL	:= autoconf
# autosetup/cc.tcl tries to discover ccache on its own, so use 'CCACHE=none'
# to prevent that and leave PTXCONF_SETUP_CCACHE in charge.
JIMTCL_CONF_ENV		:= \
	$(CROSS_ENV) \
	CCACHE=none \
	autosetup_tclsh=$(PTXCONF_SYSROOT_HOST)/usr/bin/jimsh
JIMTCL_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(call ptx/ifdef, PTXCONF_JIMTCL_UTF8,--utf8,) \
	$(call ptx/ifdef, PTXCONF_JIMTCL_LINEEDIT,,--disable-lineedit) \
	$(call ptx/ifdef, PTXCONF_JIMTCL_REFERENCES,,--disable-references) \
	$(call ptx/ifdef, PTXCONF_JIMTCL_MATH,--math,) \
	$(call ptx/ifdef, PTXCONF_JIMTCL_SSL,--ssl,) \
	$(call ptx/ifdef, PTXCONF_GLOBAL_IPV6,--ipv6,) \
	--shared \
	$(call ptx/ifdef, PTXCONF_JIMTCL_POSIX_REGEX,--disable-jim-regexp,) \
	--disable-docs \
	$(call ptx/ifdef, PTXCONF_JIMTCL_RANDOM_HASH,--random-hash,)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jimtcl.install:
	@$(call targetinfo)
	@$(call world/install, JIMTCL)
	@ln -sf libjim.so.$(JIMTCL_VERSION) $(JIMTCL_PKGDIR)/usr/lib/libjim.so
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jimtcl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, jimtcl)
	@$(call install_fixup, jimtcl, PRIORITY, optional)
	@$(call install_fixup, jimtcl, SECTION, base)
	@$(call install_fixup, jimtcl, AUTHOR, "Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, jimtcl, DESCRIPTION, \
		"A small footprint implementation of the Tcl programming language")

ifdef PTXCONF_JIMTCL_SHELL
	@$(call install_copy, jimtcl, 0, 0, 0755, -, /usr/bin/jimsh)
ifdef PTXCONF_JIMTCL_SYMLINK
	@$(call install_link, jimtcl, jimsh, /usr/bin/tclsh)
endif
endif
	@$(call install_lib, jimtcl, 0, 0, 0644, libjim)

	@$(call install_finish, jimtcl)

	@$(call touch)

# vim: syntax=make
