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
PACKAGES-$(PTXCONF_GST_PLUGINS_FSL_VPU) += gst-plugins-fsl_vpu

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
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GST_PLUGINS_FSL_VPU_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-plugins-fsl_vpu.targetinstall:

	@$(call targetinfo)

	@$(call install_init, gst-plugins-fsl_vpu)
	@$(call install_fixup, gst-plugins-fsl_vpu,PRIORITY,optional)
	@$(call install_fixup, gst-plugins-fsl_vpu,SECTION,base)
	@$(call install_fixup, gst-plugins-fsl_vpu,AUTHOR,"Sascha Hauer <s.hauer@pengutronix.de>")
	@$(call install_fixup, gst-plugins-fsl_vpu,DESCRIPTION,missing)

	@$(call install_copy, gst-plugins-fsl_vpu, 0, 0, 0644, \
		$(GST_PLUGINS_FSL_VPU_PKGDIR)/usr/lib/libgst-plugins-fsl-vpu.so, \
		/usr/lib/gstreamer-0.10/libmfw_gst_vpu.so)

	@$(call install_finish, gst-plugins-fsl_vpu)

	@$(call touch)

# vim: syntax=make
