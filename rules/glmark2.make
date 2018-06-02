# -*-makefile-*-
#
# Copyright (C) 2017 by Markus Niebel <Markus.Niebel@tqs.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLMARK2) += glmark2

#
# Paths and names
#
# No tags: use a fake descriptive commit-ish to include the date
GLMARK2_VERSION	:= 2017-06-23-g9b1070fe
GLMARK2_MD5	:= 108815396d54fbb97b78e639f59a0df0
GLMARK2		:= glmark2-$(GLMARK2_VERSION)
GLMARK2_SUFFIX	:= tar.xz
GLMARK2_URL	:= https://github.com/glmark2/glmark2.git;tag=$(GLMARK2_VERSION)
GLMARK2_SOURCE	:= $(SRCDIR)/$(GLMARK2).$(GLMARK2_SUFFIX)
GLMARK2_DIR	:= $(BUILDDIR)/$(GLMARK2)
GLMARK2_LICENSE	:= GPL-3.0-only AND SGIv1
GLMARK2_LICENSE_FILES := \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://COPYING.SGI;md5=7125c8894bd29eddfd44ede5ce3ab1e4


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLMARK2_CONF_ENV	:= \
	$(CROSS_ENV)

GLMARK2_FLAVORS-y :=
GLMARK2_FLAVORS-$(PTXCONF_GLMARK2_FLAVOR_X11_GL)	+= x11-gl
GLMARK2_FLAVORS-$(PTXCONF_GLMARK2_FLAVOR_X11_GLES2)	+= x11-glesv2
GLMARK2_FLAVORS-$(PTXCONF_GLMARK2_FLAVOR_DRM_GL)	+= drm-gl
GLMARK2_FLAVORS-$(PTXCONF_GLMARK2_FLAVOR_DRM_GLES2)	+= drm-glesv2
GLMARK2_FLAVORS-$(PTXCONF_GLMARK2_FLAVOR_WAYLAND_GL)	+= wayland-gl
GLMARK2_FLAVORS-$(PTXCONF_GLMARK2_FLAVOR_WAYLAND_GLES2)	+= wayland-glesv2

GLMARK2_FLAVORS := $(strip $(GLMARK2_FLAVORS-y))
GLMARK2_FLAVORS := $(subst $(ptx/def/space),$(ptx/def/comma),$(GLMARK2_FLAVORS))

GLMARK2_CONF_TOOL	:= NO
GLMARK2_CONF_OPT	:= \
	--prefix=/usr \
	--with-flavors=$(GLMARK2_FLAVORS)

$(STATEDIR)/glmark2.prepare:
	@$(call targetinfo)
	@cd $(GLMARK2_DIR) && \
		$(GLMARK2_CONF_ENV) $(SYSTEMPYTHON3) ./waf configure $(GLMARK2_CONF_OPT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/glmark2.compile:
	@$(call targetinfo)
	@cd $(GLMARK2_DIR) && $(SYSTEMPYTHON3) ./waf build -j 1
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glmark2.install:
	@$(call targetinfo)
	@rm -rf "$(GLMARK2_PKGDIR)"
	@mkdir -p "$(GLMARK2_PKGDIR)"
	@cd "$(GLMARK2_DIR)" && $(SYSTEMPYTHON3) ./waf --destdir=$(GLMARK2_PKGDIR) install
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glmark2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glmark2)
	@$(call install_fixup, glmark2, PRIORITY, optional)
	@$(call install_fixup, glmark2, SECTION, base)
	@$(call install_fixup, glmark2, AUTHOR, "Markus Niebel <Markus.Niebel@tqs.de>")
	@$(call install_fixup, glmark2, DESCRIPTION, missing)

	@$(call install_tree, glmark2, 0, 0, -, /usr/share/glmark2)
ifeq ($(PTXCONF_GLMARK2_FLAVOR_X11_GL),y)
	@$(call install_copy, glmark2, 0, 0, 0755, -, /usr/bin/glmark2)
endif
ifeq ($(PTXCONF_GLMARK2_FLAVOR_X11_GLES2),y)
	@$(call install_copy, glmark2, 0, 0, 0755, -, /usr/bin/glmark2-es2)
endif
ifeq ($(PTXCONF_GLMARK2_FLAVOR_DRM_GL),y)
	@$(call install_copy, glmark2, 0, 0, 0755, -, /usr/bin/glmark2-drm)
endif
ifeq ($(PTXCONF_GLMARK2_FLAVOR_DRM_GLES2),y)
	@$(call install_copy, glmark2, 0, 0, 0755, -, /usr/bin/glmark2-es2-drm)
endif
ifeq ($(PTXCONF_GLMARK2_FLAVOR_WAYLAND_GL),y)
	@$(call install_copy, glmark2, 0, 0, 0755, -, /usr/bin/glmark2-wayland)
endif
ifeq ($(PTXCONF_GLMARK2_FLAVOR_WAYLAND_GLES2),y)
	@$(call install_copy, glmark2, 0, 0, 0755, -, /usr/bin/glmark2-es2-wayland)
endif

	@$(call install_finish, glmark2)

	@$(call touch)

# vim: syntax=make
