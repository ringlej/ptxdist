# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GOBJECT_INTROSPECTION) += host-gobject-introspection

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GOBJECT_INTROSPECTION_CONF_TOOL	:= autoconf
HOST_GOBJECT_INTROSPECTION_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-doctool \
	--without-cairo \
	--with-python=$(SYSTEMPYTHON3)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gobject-introspection.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_GOBJECT_INTROSPECTION)
	@echo '#!/bin/sh'				>  $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner
	@echo 'export GI_SCANNER_DISABLE_CACHE=1'	>> $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner
	@echo 'export pkg_ldflags="$$(find -H $${pkg_dir} -name .libs -printf "-Wl,-rpath,%p ")$${pkg_ldflags}"' \
							>> $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner
	@echo 'export CC=$(CROSS_CC)'			>> $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner
	@echo 'export GI_CROSS_LAUNCHER="$(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross"' \
							>> $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner
	@echo 'PATH="$(PTXDIST_SYSROOT_CROSS)/bin/qemu:$$PATH"' \
							>> $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner
	@echo 'exec "$(PTXDIST_SYSROOT_HOST)/bin/g-ir-scanner" \
		"$${@}"'				>> $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner

	@echo '#!/bin/sh'				>  $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-compiler
	@echo '$(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross \
		$(SYSROOT)/usr/bin/g-ir-compiler --includedir \
		$(SYSROOT)/usr/share/gir-1.0 "$${@}"'	>> $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-compiler
	@chmod +x $(PTXDIST_SYSROOT_CROSS)/bin/g-ir-compiler

	@sed -i 's;"/share";"$(PTXDIST_SYSROOT_HOST)/share";' \
		"$(PTXDIST_SYSROOT_HOST)/bin/g-ir-scanner" \
		"$(PTXDIST_SYSROOT_HOST)/bin/g-ir-annotation-tool"

	@sed -i 's;'/lib';'$(PTXDIST_SYSROOT_HOST)/lib';' \
		"$(PTXDIST_SYSROOT_HOST)/bin/g-ir-scanner" \
		"$(PTXDIST_SYSROOT_HOST)/bin/g-ir-annotation-tool"

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gobject-introspection.clean:
	@$(call targetinfo)
	@$(call clean_pkg, HOST_GOBJECT_INTROSPECTION)
	@rm \
		$(PTXDIST_SYSROOT_CROSS)/bin/g-ir-scanner \
		$(PTXDIST_SYSROOT_CROSS)/bin/g-ir-compiler

# vim: syntax=make
