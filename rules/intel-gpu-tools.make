# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_INTEL_GPU_TOOLS) += intel-gpu-tools

#
# Paths and names
#
INTEL_GPU_TOOLS_VERSION	:= 1.22
INTEL_GPU_TOOLS_MD5	:= 965c591b23a132084113c2a0604f537a
INTEL_GPU_TOOLS		:= intel-gpu-tools-$(INTEL_GPU_TOOLS_VERSION)
INTEL_GPU_TOOLS_SUFFIX	:= tar.xz
INTEL_GPU_TOOLS_URL	:= $(call ptx/mirror, XORG, individual/app/$(INTEL_GPU_TOOLS).$(INTEL_GPU_TOOLS_SUFFIX))
INTEL_GPU_TOOLS_SOURCE	:= $(SRCDIR)/$(INTEL_GPU_TOOLS).$(INTEL_GPU_TOOLS_SUFFIX)
INTEL_GPU_TOOLS_DIR	:= $(BUILDDIR)/$(INTEL_GPU_TOOLS)
INTEL_GPU_TOOLS_LICENSE	:= MIT AND ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
INTEL_GPU_TOOLS_CONF_TOOL	:= autoconf
INTEL_GPU_TOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-selective-werror \
	--disable-strict-compilation \
	--disable-chamelium \
	--disable-audio \
	--enable-intel \
	--disable-amdgpu \
	--disable-nouveau \
	--disable-vc4 \
	--disable-shader-debugger \
	--disable-debug \
	--disable-werror \
	--disable-git-hash \
	--disable-tests

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------


$(STATEDIR)/intel-gpu-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, intel-gpu-tools)
	@$(call install_fixup, intel-gpu-tools,PRIORITY,optional)
	@$(call install_fixup, intel-gpu-tools,SECTION,base)
	@$(call install_fixup, intel-gpu-tools,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, intel-gpu-tools,DESCRIPTION,missing)

	@$(call install_tree, intel-gpu-tools, 0, 0, -, /usr/bin)

	@$(call install_finish, intel-gpu-tools)

	@$(call touch)

# vim: syntax=make
