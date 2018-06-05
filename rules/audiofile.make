# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AUDIOFILE) += audiofile

#
# Paths and names
#
AUDIOFILE_VERSION	:= 0.3.6
AUDIOFILE_MD5		:= 2731d79bec0acef3d30d2fc86b0b72fd
AUDIOFILE		:= audiofile-$(AUDIOFILE_VERSION)
AUDIOFILE_SUFFIX	:= tar.gz
AUDIOFILE_URL		:= http://audiofile.68k.org/$(AUDIOFILE).$(AUDIOFILE_SUFFIX)
AUDIOFILE_SOURCE	:= $(SRCDIR)/$(AUDIOFILE).$(AUDIOFILE_SUFFIX)
AUDIOFILE_DIR		:= $(BUILDDIR)/$(AUDIOFILE)
AUDIOFILE_LICENSE	:= GPL-2.0-only AND LGPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
AUDIOFILE_CONF_TOOL := autoconf
AUDIOFILE_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-werror \
	--disable-coverage \
	--disable-valgrind \
	--disable-docs \
	--disable-examples \
	--disable-flac

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/audiofile.targetinstall:
	@$(call targetinfo)

	@$(call install_init, audiofile)
	@$(call install_fixup, audiofile,PRIORITY,optional)
	@$(call install_fixup, audiofile,SECTION,base)
	@$(call install_fixup, audiofile,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, audiofile,DESCRIPTION,missing)

	@$(call install_lib, audiofile, 0, 0, 0644, libaudiofile)

ifdef PTXCONF_AUDIOFILE_TOOLS
	@$(call install_copy, audiofile, 0, 0, 0755, -, /usr/bin/sfconvert)
	@$(call install_copy, audiofile, 0, 0, 0755, -, /usr/bin/sfinfo)
endif

	@$(call install_finish, audiofile)

	@$(call touch)

# vim: syntax=make
