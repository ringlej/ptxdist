# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3) += host-python3

#
# Paths and names
#
HOST_PYTHON3_DIR	= $(HOST_BUILDDIR)/$(PYTHON3)

HOSTPYTHON3		= $(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON3_MAJORMINOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# Note: the LDFLAGS are used by setup.py for manual searches
HOST_PYTHON3_ENV	:= \
	$(HOST_ENV) \
	ac_sys_system=Linux \
	ac_sys_release=2 \
	MACHDEP=linux2 \
	LDFLAGS="-L $(PTXDIST_SYSROOT_HOST)/lib"

#
# autoconf
#
HOST_PYTHON3_CONF_TOOL	:= autoconf
HOST_PYTHON3_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-shared \
	--disable-profiling \
	--disable-optimizations \
	--disable-loadable-sqlite-extensions \
	--without-pydebug \
	--without-assertions \
	--without-lto \
	--with-system-expat \
	--without-system-libmpdec \
	--with-dbmliborder= \
	--without-doc-strings \
	--with-pymalloc \
	--with-c-locale-coercion \
	--with-c-locale-warning \
	--without-valgrind \
	--without-dtrace \
	--with-computed-gotos \
	--without-ensurepip

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python3.install:
	@$(call targetinfo)
	@$(call install, HOST_PYTHON3,,h)
#
# remove "python" so that it doesn't interfere with the build
# machine's python
#
# the target build proces will only use python with the
# python-$(PYTHON3_MAJORMINOR)
#
	@rm -v \
		"$(HOST_PYTHON3_PKGDIR)/bin/python3" \
		"$(HOST_PYTHON3_PKGDIR)/bin/python3-config"
	@$(call touch)

$(STATEDIR)/host-python3.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_PYTHON3)
	@sed -i 's;prefix_build="";prefix_build="$(PTXDIST_SYSROOT_HOST)";' \
		$(PTXDIST_SYSROOT_HOST)/bin/python3*-config
	@$(call touch)

# vim: syntax=make
