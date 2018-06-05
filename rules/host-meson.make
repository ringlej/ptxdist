# -*-makefile-*-
#
# Copyright (C) 2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MESON) += host-meson

#
# Paths and names
#
HOST_MESON_VERSION	:= 0.44.1
HOST_MESON_MD5		:= 623ebb89422911ce4fbac6707e2cffc5
HOST_MESON		:= meson-$(HOST_MESON_VERSION)
HOST_MESON_SUFFIX	:= tar.gz
HOST_MESON_URL		:= https://github.com/mesonbuild/meson/archive/$(HOST_MESON_VERSION).$(HOST_MESON_SUFFIX)
HOST_MESON_SOURCE	:= $(SRCDIR)/$(HOST_MESON).$(HOST_MESON_SUFFIX)
HOST_MESON_DIR		:= $(HOST_BUILDDIR)/$(HOST_MESON)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MESON_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-meson.compile:
	@$(call targetinfo)
	cd $(HOST_MESON_DIR) && \
		$(SYSTEMPYTHON3) setup.py build
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# Special dirs to avoid collisions with host-python3
HOST_MESON_INSTALL_OPT	:= \
	install \
	--prefix=/ \
	--install-lib=/share/meson \
	--install-scripts=/share/meson \
	--root=$(HOST_MESON_PKGDIR)

$(STATEDIR)/host-meson.install:
	@$(call targetinfo)
	@rm -rf $(HOST_MESON_PKGDIR)
	@cd $(HOST_MESON_DIR) && \
		$(SYSTEMPYTHON3) setup.py $(HOST_MESON_INSTALL_OPT)
	@mkdir -vp $(HOST_MESON_PKGDIR)/bin
	@ln -svf ../share/meson/meson $(HOST_MESON_PKGDIR)/bin/meson
	@$(call touch)

$(STATEDIR)/host-meson.install.post: $(PTXDIST_MESON_CROSS_FILE)

# vim: syntax=make
