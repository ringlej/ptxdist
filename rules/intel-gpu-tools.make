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
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-selective-werror \
	--disable-strict-compilation \
	--enable-intel \
	--disable-nouveau \
	--disable-vc4 \
	--disable-shader-debugger \
	--disable-debug \
	--disable-werror \
	--disable-git-hash \
	--disable-tests \
	--without-libunwind

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

INTEL_GPU_TOOLS_APPS := \
	igt_stats \
	intel_aubdump \
	intel_audio_dump \
	intel_backlight \
	intel_bios_dumper \
	intel_bios_reader \
	intel_display_crc \
	intel_display_poller \
	intel_dump_decode \
	intel_error_decode \
	intel_firmware_decode \
	intel_forcewaked \
	intel_gpu_abrt \
	intel_gpu_frequency \
	intel_gpu_time \
	intel_gpu_top \
	intel_gtt \
	intel_infoframes \
	intel_l3_parity \
	intel_lid \
	intel_opregion_decode \
	intel_panel_fitter \
	intel_perf_counters \
	intel_reg \
	intel_reg_checker \
	intel_stepping \
	intel_watermark

$(STATEDIR)/intel-gpu-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, intel-gpu-tools)
	@$(call install_fixup, intel-gpu-tools,PRIORITY,optional)
	@$(call install_fixup, intel-gpu-tools,SECTION,base)
	@$(call install_fixup, intel-gpu-tools,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, intel-gpu-tools,DESCRIPTION,missing)

	@$(foreach app, $(INTEL_GPU_TOOLS_APPS), \
		$(call install_copy, intel-gpu-tools, 0, 0, 0755, -, /usr/bin/$(app));)

	@$(call install_finish, intel-gpu-tools)

	@$(call touch)

# vim: syntax=make
