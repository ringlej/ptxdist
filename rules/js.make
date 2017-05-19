# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2016 by Ladislav Michl <ladis@linux-mips.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ARCH_PPC
PACKAGES-$(PTXCONF_JS) += js
endif

#
# Paths and names
#
JS_VERSION	:= 45.0.2
JS_MD5		:= 2ca34f998d8b5ea79d8616dd26b5fbab
JS		:= mozjs-$(JS_VERSION)
JS_SUFFIX	:= tar.bz2
JS_URL		:= https://people.mozilla.org/~sfink/$(JS).$(JS_SUFFIX)
JS_SOURCE	:= $(SRCDIR)/$(JS).$(JS_SUFFIX)
JS_DIR		:= $(BUILDDIR)/$(JS)
JS_SUBDIR	:= js/src
JS_LICENSE	:= MPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#

JS_CONF_ENV	:= \
	$(CROSS_ENV) \
	PYTHON=python

# $(JS_SUBDIR)/configure.in:
#   In Mozilla, we use the names $target, $host and $build incorrectly, but are
#   too far gone to back out now. See Bug 475488:
#     - When we say $target, we mean $host, that is, the system on which
#       Mozilla will be run.
#     - When we say $host, we mean $build, that is, the system on which Mozilla
#       is built.
#     - $target (in its correct usage) is for compilers who generate code for a
#       different platform than $host, so it would not be used by Mozilla.
JS_CONF_TOOL	:= autoconf
JS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_SYSROOT_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--host=$(GNU_HOST) \
	--build=$(GNU_HOST) \
	--enable-posix-nspr-emulation \
	--with-system-zlib \
	--enable-system-ffi \
	--disable-tests \
	--disable-jig \
	--disable-debug \
	--enable-optimize \
	--without-x \
	--with-pthreads \
	--without-intl-api

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

JS_VERSION_MAJOR	:= $(word 1,$(subst ., ,$(JS_VERSION)))

$(STATEDIR)/js.targetinstall:
	@$(call targetinfo)

	@$(call install_init, js)
	@$(call install_fixup, js,PRIORITY,optional)
	@$(call install_fixup, js,SECTION,base)
	@$(call install_fixup, js,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, js,DESCRIPTION,missing)

	@$(call install_lib, js, 0, 0, 0644, libmozjs-$(JS_VERSION_MAJOR))

	@$(call install_finish, js)

	@$(call touch)

# vim: syntax=make
