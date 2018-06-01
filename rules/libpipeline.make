# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPIPELINE) += libpipeline

#
# Paths and names
#
LIBPIPELINE_VERSION	:= 1.2.2
LIBPIPELINE_MD5		:= 4367a3f598d171fd43dfa8620ed16d55
LIBPIPELINE		:= libpipeline-$(LIBPIPELINE_VERSION)
LIBPIPELINE_SUFFIX	:= tar.gz
LIBPIPELINE_URL		:= http://download.savannah.gnu.org/releases/libpipeline/$(LIBPIPELINE).$(LIBPIPELINE_SUFFIX)
LIBPIPELINE_SOURCE	:= $(SRCDIR)/$(LIBPIPELINE).$(LIBPIPELINE_SUFFIX)
LIBPIPELINE_DIR		:= $(BUILDDIR)/$(LIBPIPELINE)
LIBPIPELINE_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBPIPELINE_CONF_ENV	:= $(CROSS_ENV)
LIBPIPELINE_CONF_TOOL	:= autoconf
# we know the socket pair mode works on our systems
# (but 'configure' cannot check it due to cross compiling)
LIBPIPELINE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--enable-threads=posix \
	--disable-rpath \
	--$(call ptx/endis,PTXCONF_LIBPIPELINE_SOCKETPAIR)-socketpair-pipe \
	pipeline_cv_socketpair_pipe=yes \
	pipeline_cv_socketpair_mode=yes

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpipeline.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpipeline)
	@$(call install_fixup, libpipeline,PRIORITY,optional)
	@$(call install_fixup, libpipeline,SECTION,base)
	@$(call install_fixup, libpipeline,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, libpipeline,DESCRIPTION,"pipeline manipulation library")

	@$(call install_lib, libpipeline, 0, 0, 0644, libpipeline)

	@$(call install_finish, libpipeline)

	@$(call touch)

# vim: syntax=make
