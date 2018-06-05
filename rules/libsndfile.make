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
PACKAGES-$(PTXCONF_LIBSNDFILE) += libsndfile

#
# Paths and names
#
LIBSNDFILE_VERSION	:= 1.0.25
LIBSNDFILE_MD5		:= e2b7bb637e01022c7d20f95f9c3990a2
LIBSNDFILE		:= libsndfile-$(LIBSNDFILE_VERSION)
LIBSNDFILE_SUFFIX	:= tar.gz
LIBSNDFILE_URL		:= http://www.mega-nerd.com/libsndfile/files/$(LIBSNDFILE).$(LIBSNDFILE_SUFFIX)
LIBSNDFILE_SOURCE	:= $(SRCDIR)/$(LIBSNDFILE).$(LIBSNDFILE_SUFFIX)
LIBSNDFILE_DIR		:= $(BUILDDIR)/$(LIBSNDFILE)
LIBSNDFILE_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSNDFILE_CONF_TOOL := autoconf
LIBSNDFILE_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-octave \
	--disable-alsa \
	--$(call ptx/endis,PTXCONF_LIBSNDFILE_EXT_LIBS)-external-libs

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIBSNDFILE_PROGS := \
	sndfile-cmp \
	sndfile-concat \
	sndfile-convert \
	sndfile-deinterleave \
	sndfile-info \
	sndfile-interleave \
	sndfile-metadata-get \
	sndfile-metadata-set \
	sndfile-play \
	sndfile-regtest \
	sndfile-salvage

$(STATEDIR)/libsndfile.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsndfile)
	@$(call install_fixup, libsndfile,PRIORITY,optional)
	@$(call install_fixup, libsndfile,SECTION,base)
	@$(call install_fixup, libsndfile,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libsndfile,DESCRIPTION,missing)

	@$(call install_lib, libsndfile, 0, 0, 0644, libsndfile)

ifdef PTXCONF_LIBSNDFILE_TOOLS
	@$(foreach prog, $(LIBSNDFILE_PROGS), \
		$(call install_copy, libsndfile, 0, 0, 0755, -, /usr/bin/$(prog));)
endif

	@$(call install_finish, libsndfile)

	@$(call touch)

# vim: syntax=make
