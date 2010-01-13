# -*-makefile-*-
#
# Copyright (C) 2008 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_ARM_IMX)-$(PTXCONF_GST_PLUGINS_FSL_VPU) += gst-plugins-fsl_vpu

#
# Paths and names
#
GST_PLUGINS_FSL_VPU_VERSION	:= 0.1.0
GST_PLUGINS_FSL_VPU		:= gst-plugins-fsl-vpu-$(GST_PLUGINS_FSL_VPU_VERSION)
GST_PLUGINS_FSL_VPU_SUFFIX	:= tar.bz2
GST_PLUGINS_FSL_VPU_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(GST_PLUGINS_FSL_VPU).$(GST_PLUGINS_FSL_VPU_SUFFIX)
GST_PLUGINS_FSL_VPU_SOURCE	:= $(SRCDIR)/$(GST_PLUGINS_FSL_VPU).$(GST_PLUGINS_FSL_VPU_SUFFIX)
GST_PLUGINS_FSL_VPU_DIR		:= $(BUILDDIR)/$(GST_PLUGINS_FSL_VPU)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GST_PLUGINS_FSL_VPU_SOURCE):
	@$(call targetinfo)
	@$(call get, GST_PLUGINS_FSL_VPU)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-fsl_vpu.extract:
	@$(call targetinfo)
	@$(call clean, $(GST_PLUGINS_FSL_VPU_DIR))
	@$(call extract, GST_PLUGINS_FSL_VPU)
	@$(call patchin, GST_PLUGINS_FSL_VPU)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GST_PLUGINS_FSL_VPU_PATH	:= PATH=$(CROSS_PATH)
GST_PLUGINS_FSL_VPU_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
GST_PLUGINS_FSL_VPU_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/gst-plugins-fsl_vpu.prepare:
	@$(call targetinfo)
	@$(call clean, $(GST_PLUGINS_FSL_VPU_DIR)/config.cache)
	cd $(GST_PLUGINS_FSL_VPU_DIR) && \
		$(GST_PLUGINS_FSL_VPU_PATH) $(GST_PLUGINS_FSL_VPU_ENV) \
		./configure $(GST_PLUGINS_FSL_VPU_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-fsl_vpu.compile:
	@$(call targetinfo)
	cd $(GST_PLUGINS_FSL_VPU_DIR) && $(GST_PLUGINS_FSL_VPU_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-fsl_vpu.install:
	@$(call targetinfo)
	@$(call install, GST_PLUGINS_FSL_VPU)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-fsl_vpu.targetinstall:

	@$(call targetinfo)
	@$(call install_init,  gst-plugins-fsl_vpu)
	@$(call install_fixup, gst-plugins-fsl_vpu,PACKAGE,gst-plugins-fsl-vpu)
	@$(call install_fixup, gst-plugins-fsl_vpu,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-fsl_vpu,VERSION,$(GST_PLUGINS_FSL_VPU_VERSION))
	@$(call install_fixup, gst-plugins-fsl_vpu,SECTION,base)
	@$(call install_fixup, gst-plugins-fsl_vpu,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup, gst-plugins-fsl_vpu,DEPENDS,)
	@$(call install_fixup, gst-plugins-fsl_vpu,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-fsl_vpu, 0, 0, 0644, \
		$(GST_PLUGINS_FSL_VPU_DIR)/src/.libs/libgst-plugins-fsl-vpu.so, \
		/usr/lib/gstreamer-0.10/libmfw_gst_vpu.so)

	@$(call install_finish, gst-plugins-fsl_vpu)

	@$(call touch)

# vim: syntax=make
