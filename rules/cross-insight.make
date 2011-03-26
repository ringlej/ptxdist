# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_INSIGHT) += cross-insight

#
# Paths and names
#
CROSS_INSIGHT_VERSION	:= 6.8-1
CROSS_INSIGHT		:= insight-$(CROSS_INSIGHT_VERSION)
CROSS_INSIGHT_SUFFIX	:= tar.bz2
CROSS_INSIGHT_URL	:= ftp://sourceware.org/pub/insight/releases/$(CROSS_INSIGHT).$(CROSS_INSIGHT_SUFFIX)
CROSS_INSIGHT_SOURCE	:= $(SRCDIR)/$(CROSS_INSIGHT).$(CROSS_INSIGHT_SUFFIX)
CROSS_INSIGHT_DIR	:= $(CROSS_BUILDDIR)/$(CROSS_INSIGHT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CROSS_INSIGHT_SOURCE):
	@$(call targetinfo)
	@$(call get, CROSS_INSIGHT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CROSS_INSIGHT_CONF_TOOL := autoconf
CROSS_INSIGHT_CONF_OPT	:= \
	$(HOST_CROSS_AUTOCONF) \
	--disable-werror

# vim: syntax=make
