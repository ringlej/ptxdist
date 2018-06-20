# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPUS) += opus

#
# Paths and names
#
OPUS_VERSION	:= 1.2.1
OPUS_MD5	:= 54bc867f13066407bc7b95be1fede090
OPUS		:= opus-$(OPUS_VERSION)
OPUS_SUFFIX	:= tar.gz
OPUS_URL	:= http://downloads.xiph.org/releases/opus/$(OPUS).$(OPUS_SUFFIX)
OPUS_SOURCE	:= $(SRCDIR)/$(OPUS).$(OPUS_SUFFIX)
OPUS_DIR	:= $(BUILDDIR)/$(OPUS)
OPUS_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OPUS_CONF_TOOL	:= autoconf
OPUS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--$(call ptx/disen, PTXCONF_HAS_HARDFLOAT)-fixed-point \
	--disable-fixed-point-debug \
	--enable-float-api \
	--disable-custom-modes \
	--enable-float-approx \
	--enable-asm \
	--enable-rtcd \
	--enable-intrinsics \
	--disable-assertions \
	--disable-fuzzing \
	--disable-check-asm \
	--disable-ambisonics \
	--disable-doc \
	--disable-extra-programs \
	--disable-update-draft


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/opus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, opus)
	@$(call install_fixup, opus,PRIORITY,optional)
	@$(call install_fixup, opus,SECTION,base)
	@$(call install_fixup, opus,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, opus,DESCRIPTION,missing)

	@$(call install_lib, opus, 0, 0, 0644, libopus)

	@$(call install_finish, opus)

	@$(call touch)

# vim: syntax=make
